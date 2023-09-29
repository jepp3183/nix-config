require('toggleterm').setup{
  open_mapping = [[<c-t>]],
  size =  function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  direction = 'float'
}
