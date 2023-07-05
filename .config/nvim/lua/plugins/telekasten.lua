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
local PARA_root = "~/Documents/Cloud-Drive/PARA/"

local function generate_vault_dirs()
  local root = PARA_root
  local dirs = subdirs(root)
  local vaults = {}
  for i, item in ipairs(dirs) do
    local home = vim.fn.expand(root .. item.space .. "/" .. item.subdir)
    local name = item.space .. "_" .. item.subdir
    vaults[name] = { home = home }
  end
  print(vim.inspect(vaults))
  return vaults
end

-- local vaults = generate_vault_dirs()

return {
  -- NOTE: for peek had to run:
  -- cd ~/.local/share/nvim/lazy/peek.nvim && deno task build:debug
  -- https://github.com/toppair/peek.nvim/issues/11#issuecomment-1491297809
  { "toppair/peek.nvim", opts = { app = "browser" }, build = "deno task --quiet build:fast" },
  { "renerocksai/calendar-vim" },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      home = PARA_root,
      -- vaults = vaults,
      vaults = generate_vault_dirs(),
    },
    keys = {
      { "<leader>G", generate_vault_dirs, desc = "test" },
      { "<leader>t", "<Cmd>Telekasten panel<CR>", desc = "Telekasten" },
      { "<leader>tp", "<Cmd>Telekasten panel<CR>" },
      { "<leader>tf", "<cmd>Telekasten find_notes<CR>" },
      { "<leader>tg", "<cmd>Telekasten search_notes<CR>" },
      { "<leader>td", "<cmd>Telekasten goto_today<CR>" },
      { "<leader>tz", "<cmd>Telekasten follow_link<CR>" },
      { "<leader>tn", "<cmd>Telekasten new_note<CR>" },
      { "<leader>tc", "<cmd>Telekasten show_calendar<CR>" },
      { "<leader>tb", "<cmd>Telekasten show_backlinks<CR>" },
      { "<leader>tI", "<cmd>Telekasten insert_img_link<CR>" },
      { "<leader>tt", "<cmd>Telekasten toggle_todo<CR>" },
      { "<leader>ts", "<cmd>Telekasten switch_vault<CR>" },
      { "[[", "<cmd>Telekasten insert_link<CR>", mode = "i" },
      { "##", "<cmd>Telekasten show_tags<CR>", mode = "i" },
    },
  },
}
