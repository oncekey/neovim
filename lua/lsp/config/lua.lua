-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
---@diagnostic disable: undefined-global
local runtime_path = vim.split(package.path, ';', {})
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('neodev').setup({
  --  library = {
  --    --enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
  --    -- these settings will be used for your Neovim config directory
  --    runtime = true, -- runtime path
  --    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
  --    plugins = true, -- installed opt or start plugins in packpath
  --    -- you can also specify the list of plugins to make available as a workspace library
  --    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  --  },
  --  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  --  -- With lspconfig, Neodev will automatically setup your lua-language-server
  --  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  --  -- in your lsp start options
  --  lspconfig = true,-- add any options here, or leave empty to use the default settings
})

local opts = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.documentFormatting = false
    client.server_capabilities.documentRangeFormatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
  end,
}

--查看目录等信息
--print(vim.inspect(server))

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
