-- 基础配置
require('basic')

-- 按键绑定
require('keybindings')

-- 插件
require('plugins')

-- 主题设置
require('colorscheme')

-- 插件配置
require('plugin-config.nvim-tree')
require('plugin-config.bufferline')
require('plugin-config.lualine')
require('plugin-config.telescope')
require('plugin-config.dashboard')
require('plugin-config.project')
require('plugin-config.nvim-treesitter')
require('plugin-config.indent-blankline')
require('plugin-config.gitsigns')

-- 内置LSP
require('lsp.setup')
require('lsp.cmp')
require('lsp.ui')

-- 格式化
require('lsp.formatter')
