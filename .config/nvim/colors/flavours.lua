-- Start flavours
local colors = {
  base00 = "#f2e5bc",
  base01 = "#ebdbb2",
  base02 = "#c9b99a",
  base03 = "#a89984",
  base04 = "#665c54",
  base05 = "#654735",
  base06 = "#3c3836",
  base07 = "#282828",
  base08 = "#c14a4a",
  base09 = "#c35e0a",
  base0A = "#b47109",
  base0B = "#6c782e",
  base0C = "#4c7a5d",
  base0D = "#45707a",
  base0E = "#945e80",
  base0F = "#e78a4e",
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
