local function dirs_iter(root)
  local path = vim.fn.expand(root)
  local uv_fs = vim.uv.fs_scandir(path)
  return function()
    if uv_fs ~= nil then
      local entry, type = vim.uv.fs_scandir_next(uv_fs)
      while entry ~= nil and type ~= "directory" do
        entry, type = vim.uv.fs_scandir_next(uv_fs)
      end
      return entry
    end
  end
end

local function subdirs(root)
  do
    local result = {}
    for dir in dirs_iter(root) do
      for subdir in dirs_iter(root .. dir) do
        table.insert(result, { space = dir, subdir = subdir })
      end
    end
    return result
  end
end

local PARK_root = os.getenv("PARK")

local function make_template_path(root, template)
  if template ~= nil then
    return vim.fn.expand(root .. "Templates/" .. template .. ".md")
  else
    return vim.fn.expand(root .. "Templates/")
  end
end

local default_template_new_note = make_template_path(PARK_root, "new_note")
local default_template_new_daily = make_template_path(PARK_root, "daily_note")
local default_template_new_weekly = make_template_path(PARK_root, "weekly_note")
local default_templates_dir = make_template_path(PARK_root, nil)

local global_config = {
  new_note_filename = "uuid-title",
  new_note_location = "prefer_home",
  uuid_type = "%Y%m%d%H%M",
  uuid_sep = "-",
  -- filename_space_subst = "_",
  filename_space_subst = "/",
  template_new_note = default_template_new_note,
  template_new_daily = default_template_new_daily,
  template_new_weekly = default_template_new_weekly,
  templates = default_templates_dir,
  insert_after_inserting = false,
}

-- returns boolean
local function check_file_exists(path)
  local Path = require("plenary.path")
  return Path:new(path):exists()
end

local function get_vault_template_dir(root, note_name, default_value)
  -- use default dirs unless vault-specific file exists
  local template_path = make_template_path(root, note_name)
  if check_file_exists(template_path) then
    return template_path
  else
    return default_value
  end
end

local function add_template_dirs_to_config(config, root)
  config.template_new_note = get_vault_template_dir(root, "new_note", default_template_new_note)
  config.template_new_daily = get_vault_template_dir(root, "daily_note", default_template_new_daily)
  config.template_new_weekly = get_vault_template_dir(root, "weekly_note", default_template_new_weekly)
  config.templates = get_vault_template_dir(root, nil, default_templates_dir)
end

local function vault_name_from_dir(dir)
  local subdir, leaf = dir:match(".+/(.+)/(.+)$")
  local name = "[" .. subdir .. "] " .. leaf
  return name
end

local function generate_vault_dirs()
  local root = PARK_root
  local dirs = subdirs(root)
  local vaults = {}
  for i, item in ipairs(dirs) do
    local config = {}
    for key, value in pairs(global_config) do
      config[key] = value
    end
    local vault_root = root .. item.space .. "/" .. item.subdir
    config.home = vim.fn.expand(vault_root)
    config.dailies = vim.fn.expand(vault_root .. "/daily")
    config.weeklies = vim.fn.expand(vault_root .. "/weekly")
    local name = vault_name_from_dir(vault_root)
    add_template_dirs_to_config(config, vault_root .. "/")
    -- print(vim.inspect(config))
    vaults[name] = config
  end
  return vaults
end

local function append_global_config(opts)
  local config = {}
  for key, value in pairs(global_config) do
    config[key] = value
  end
  for key, value in pairs(opts) do
    config[key] = value
  end
  return config
end

local inbox = "Inbox/Inbox"
local default_opts = append_global_config({
  home = vim.fn.expand(PARK_root .. inbox),
  dailies = vim.fn.expand(PARK_root .. inbox .. "/daily"),
  weeklies = vim.fn.expand(PARK_root .. inbox .. "/weekly"),
  vaults = generate_vault_dirs(),
})

-- :lua require("plugins.kasten.functions").require_kasten("/path/to/Project/Neovim")
local function require_kasten(default_vault_dir)
  local default_vault = vault_name_from_dir(default_vault_dir)
  local opts = default_opts
  if default_vault ~= nil then
    opts.default_vault = default_vault
  end
  require("telekasten").setup(opts)
end

return { default_opts = default_opts, require_kasten = require_kasten }
