local status, formatter = pcall(require, 'formatter')
if not status then
  vim.notify('没有找到 formatter')
  return
end

formatter.setup({
  filetype = {
    lua = {
      function()
        return {
          exe = 'stylua',
          args = {
            -- "--config-path "
            --   .. os.getenv("XDG_CONFIG_HOME")
            --   .. "/stylua/stylua.toml",
            '-',
          },
          stdin = true,
        }
      end,
    },
    go = {
      require('formatter.filetypes.go').gofmt,
      function()
        return {
          exe = 'gofmt',
          stdin = true,
        }
      end,
    },
    --    ['*'] = {
    --      -- "formatter.filetypes.any" defines default configurations for any
    --      -- filetype
    --      require('formatter.filetypes.any').remove_trailing_whitespace,
    --    },
  },
})

-- format on save
vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.lua,*.go FormatWrite
    augroup END
]],
  true
)
