util = require('lspconfig/util')

return {
  on_setup = function(server)
    server.setup({
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod' },
      root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
      on_attach = function(client, bufnr)
        -- 禁用格式化功能，交给专门插件插件处理
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- 绑定快捷键
        require('keybindings').mapLSP(buf_set_keymap)
      end,
    })
  end,
}
