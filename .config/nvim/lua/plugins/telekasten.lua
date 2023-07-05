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

-- TODO: make the Cloud-Drive directory an ENV Var
local PARK_root = "~/Documents/Cloud-Drive/PARK/"
local global_config = {
  new_note_filename = "uuid-title",
  new_note_location = "prefer_home",
  uuid_type = "%Y%m%d%H%M",
  uuid_sep = "-",
  filename_space_subst = "_",
  template_new_note = vim.fn.expand(PARK_root .. "Templates/new_note.md"),
  template_new_daily = vim.fn.expand(PARK_root .. "Templates/daily_note.md"),
  template_new_weekly = vim.fn.expand(PARK_root .. "Templates/weekly_note.md"),
  templates = vim.fn.expand(PARK_root .. "Templates/"),
}

local function generate_vault_dirs()
  local root = PARK_root
  local dirs = subdirs(root)
  local vaults = {}
  for i, item in ipairs(dirs) do
    local config = {}
    for key, value in pairs(global_config) do
      config[key] = value
    end
    config.home = vim.fn.expand(root .. item.space .. "/" .. item.subdir)
    config.dailies = vim.fn.expand(root .. item.space .. "/" .. item.subdir .. "/daily")
    config.weeklies = vim.fn.expand(root .. item.space .. "/" .. item.subdir .. "/weekly")
    local name = item.space .. "_" .. item.subdir
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
  -- NOTE: for peek had to run:
  -- cd ~/.local/share/nvim/lazy/peek.nvim && deno task build:debug
  -- https://github.com/toppair/peek.nvim/issues/11#issuecomment-1491297809
  {
    "toppair/peek.nvim",
    opts = { app = "browser", filetype = { "markdown", "telekasten" } },
    build = "deno task --quiet build:fast",
  },
  { "renerocksai/calendar-vim" },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = append_global_config({
      home = vim.fn.expand(PARK_root .. "Inbox"),
      dailies = vim.fn.expand(PARK_root .. "Inbox/daily"),
      weeklies = vim.fn.expand(PARK_root .. "Inbox/weekly"),
      vaults = generate_vault_dirs(),
    }),
    keys = {
      -- { "<leader>t", "<Cmd>Telekasten panel<CR>", desc = "Telekasten" },
      { "<leader>t", desc = "Telekasten" },
      { "<leader>tp", "<Cmd>Telekasten panel<CR>" },
      { "<leader>tf", "<cmd>Telekasten find_notes<CR>" },
      { "<leader>tg", "<cmd>Telekasten search_notes<CR>" },
      { "<leader>td", "<cmd>Telekasten goto_today<CR>" },
      { "<leader>tw", "<cmd>Telekasten goto_thisweek<CR>" },
      { "<leader>tz", "<cmd>Telekasten follow_link<CR>" },
      { "<leader>tn", "<cmd>Telekasten new_note<CR>" },
      { "<leader>ty", "<cmd>Telekasten yank_notelink<CR>" },
      { "<leader>tc", "<cmd>Telekasten show_calendar<CR>" },
      { "<leader>tb", "<cmd>Telekasten show_backlinks<CR>" },
      { "<leader>tB", "<cmd>Telekasten find_friends<CR>" },
      { "<leader>tr", "<cmd>Telekasten rename_note<CR>" },
      { "<leader>t#", "<cmd>Telekasten show_tags<CR>" },
      { "<leader>tI", "<cmd>Telekasten insert_img_link<CR>" },
      { "<leader>tl", "<cmd>Telekasten insert_link<CR>" },
      {
        "<leader>tt",
        function()
          require("telekasten").toggle_todo({ v = true })
        end,
        mode = { "n", "v" },
        desc = "Toggle todo",
      },
      { "<leader>ts", "<cmd>Telekasten switch_vault<CR>" },
      {
        "<leader>tc",
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
