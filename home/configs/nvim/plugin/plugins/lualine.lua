local custom_theme = require'lualine.themes.codedark'
custom_theme.normal.c.bg = nil
custom_theme.replace.c.bg = nil
custom_theme.insert.c.bg = nil
require('lualine').setup {
    options = {
        theme = custom_theme,
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
