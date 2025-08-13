-- Start flavours
local colors = {
  base00 = "#18262f",
  base01 = "#222e38",
  base02 = "#586875",
  base03 = "#667581",
  base04 = "#85939e",
  base05 = "#a6afb8",
  base06 = "#e8e9ed",
  base07 = "#f5f7fa",
  base08 = "#ef5253",
  base09 = "#e66b2b",
  base0A = "#e4b51c",
  base0B = "#7cc844",
  base0C = "#52cbb0",
  base0D = "#33b5e1",
  base0E = "#a363d5",
  base0F = "#d73c9a",
}
-- End flavours
vim.cmd("highlight clear")
vim.cmd("syntax reset")
local flavour = "flavour-" .. require("util").cmd("flavours current")
-- print(flavour)
vim.g.colors_name = "flavours"
RRethy = require("base16-colorscheme")
RRethy.colorschemes[flavour] = colors
RRethy.setup(colors, { telescope_borders = true })

-- custom highlight groups: for Bufferline groups
-- Source:
-- https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline/config.lua#L247

local buf_colors = require("bufferline.colors")
local hex = buf_colors.get_color
local normal_bg = hex({ name = "Normal", attribute = "bg" })
local is_bright_background = buf_colors.color_is_bright(normal_bg)
local background_shading = is_bright_background and -12 or -25
local darker_bg = buf_colors.shade_color(colors.base00, background_shading) -- "Normal" hl bg

local hi = RRethy.highlight
hi.BufferLineT = { guifg = colors.base0B, guibg = darker_bg }

hi.BufferLineTSelected = { guifg = colors.base0B, guibg = normal_bg }
