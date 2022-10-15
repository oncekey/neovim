vim.opt.cursorline = true
vim.opt.termguicolors = true

-- when yank, shwo yank line as a color
vim.api.nvim_create_autocmd('TextYankPost',{
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 300
    }
  end
})

vim.cmd('colorscheme everforest')
