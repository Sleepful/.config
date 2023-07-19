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

-- TODO: make the root directory an ENV Var
local PARK_root = "~/Sync/PARK/"

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
    local name = item.space .. "_" .. item.subdir
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

return {
  -- NOTE: for peek.nvim to work/build I had to run:
  -- cd ~/.local/share/nvim/lazy/peek.nvim && deno task build:debug
  -- https://github.com/toppair/peek.nvim/issues/11#issuecomment-1491297809
  {
    "toppair/peek.nvim",
    opts = { app = "browser", filetype = { "markdown", "telekasten" } },
    build = "deno task --quiet build:fast",
  },
  { "renerocksai/calendar-vim" },
  {
    -- "sleepful/telekasten.nvim",
    "renerocksai/telekasten.nvim",
    dev = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = append_global_config({
      home = vim.fn.expand(PARK_root .. "Inbox"),
      dailies = vim.fn.expand(PARK_root .. "Inbox/daily"),
      weeklies = vim.fn.expand(PARK_root .. "Inbox/weekly"),
      vaults = generate_vault_dirs(),
    }),
    keys = {
      -- { "<leader>t", "<Cmd>Telekasten panel<CR>", desc = "Telekasten" },
      { "<leader>k", desc = "Telekasten" },
      { "<leader>kp", "<Cmd>Telekasten panel<CR>" },
      { "<leader>kf", "<cmd>Telekasten find_notes<CR>" },
      { "<leader>kg", "<cmd>Telekasten search_notes<CR>" },
      { "<leader>kd", "<cmd>Telekasten goto_today<CR>" },
      { "<leader>kw", "<cmd>Telekasten goto_thisweek<CR>" },
      { "<leader>kz", "<cmd>Telekasten follow_link<CR>" },
      { "<leader>kn", "<cmd>Telekasten new_note<CR>" },
      { "<leader>ky", "<cmd>Telekasten yank_notelink<CR>" },
      { "<leader>kc", "<cmd>Telekasten show_calendar<CR>" },
      { "<leader>kb", "<cmd>Telekasten show_backlinks<CR>" },
      { "<leader>kB", "<cmd>Telekasten find_friends<CR>" },
      { "<leader>kr", "<cmd>Telekasten rename_note<CR>" },
      { "<leader>k#", "<cmd>Telekasten show_tags<CR>" },
      { "<leader>kI", "<cmd>Telekasten insert_img_link<CR>" },
      { "<leader>kl", "<cmd>Telekasten insert_link<CR>" },
      {
        "<leader>kt",
        function()
          require("telekasten").toggle_todo({ v = true })
        end,
        mode = { "n", "v" },
        desc = "Toggle todo",
      },
      { "<leader>kv", "<cmd>Telekasten switch_vault<CR>" },
      {
        "<leader>kc",
        function()
          local dirs = vim.split(require("telekasten").Cfg.home, "/")
          local last = dirs[#dirs]
          local prev_last = dirs[#dirs - 1]
          print(prev_last .. "/" .. last)
        end,
        desc = "Current vault",
      },
    },
  },
}
