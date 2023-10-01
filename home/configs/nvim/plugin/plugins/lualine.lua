-- local custom_theme = require'lualine.themes.base16'
-- custom_theme.normal.c.bg = nil
-- custom_theme.replace.c.bg = nil
-- custom_theme.insert.c.bg = nil
require('lualine').setup {
    options = {
        theme = 'base16',
    },
    tabline = {
      lualine_a = {'buffers'},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    }
}
