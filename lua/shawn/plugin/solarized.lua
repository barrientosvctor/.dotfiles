local status, solarized = pcall(require, 'neosolarized')
if not status then return end

solarized.setup()

local cb = require('colorbuddy.init')
local Color = cb.Color
local colors = cb.colors
local Group = cb.Group
local styles = cb.styles

Color.new('black', '#000000')
Color.new('white', '#ffffff')
Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
Group.new('Visual', colors.none, colors.base03, styles.reverse)
Group.new('StatusLine', colors.black, colors.white, styles.reverse)
