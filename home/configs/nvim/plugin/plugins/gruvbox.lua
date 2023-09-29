require('gruvbox').setup({
    bold = true,
    italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
    },
    underline = true,
    transparent_mode = true,
    overrides = {
    }
})
vim.cmd('colorscheme gruvbox')
