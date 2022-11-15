-- 自动安装Packer.nvim
-- 插件安装目录 ~/.local/share/nvim/site/pack/packer/
---@diagnostic disable: undefined-global
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify('正在安装Packer.nvim,请稍后...')
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://ghproxy.com/https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
  end
  vim.notify('Packer.nvim 安装完成')
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('没有安装 packer.nvim')
  return
end

packer.startup({
  function(use)
    -- Packer 可以升级自己
    use('wbthomason/packer.nvim')

    --------------------- colorschemes --------------------
    -- tokyonight
    use('folke/tokyonight.nvim')
    -------------------------------------------------------

    -------------------------- plugins -------------------------------------------
    -- nvim-tree (左侧导航栏)
    use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })

    -- bufferline (标签导航)
    use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' } })

    -- lualine (底部状态栏)
    use({ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } })
    use('arkav/lualine-lsp-progress')

    -- telescope
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })

    -- dashboard-nvim
    use('glepnir/dashboard-nvim')
    -- project
    use('ahmedkhalf/project.nvim')
    -- treesitter
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('p00f/nvim-ts-rainbow')
    -- indent-blankline
    use('lukas-reineke/indent-blankline.nvim')

    --------------------- LSP --------------------
    use('williamboman/nvim-lsp-installer')
    -- Lspconfig
    use({ 'neovim/nvim-lspconfig' })
    -- Lua 增强
    use('folke/neodev.nvim')

    -- 补全引擎
    use('hrsh7th/nvim-cmp')
    -- Snippet 引擎
    use('hrsh7th/vim-vsnip')
    -- 补全源
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
    use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
    use('hrsh7th/cmp-path') -- { name = 'path' }
    use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
    use('hrsh7th/cmp-nvim-lsp-signature-help') -- { name = 'nvim_lsp_signature_help' }

    -- UI增强
    use('onsails/lspkind-nvim')
    use('tami5/lspsaga.nvim')

    -- 添加格式化，针对的是非golang语言的
    use('mhartington/formatter.nvim')
    --------------------- LSP --------------------

    -- git
    use({ 'lewis6991/gitsigns.nvim' })

    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    -- 锁定插件版本在snapshots目录
    --    snapshot_path = require('packer.util').join_paths(vim.fn.stdpath('config'), 'snapshots'),
    --    -- 这里锁定插件版本在V1,不会继续更新插件
    --    snapshot = 'v1',

    -- 最大并发数
    max_jobs = 5,
    -- 自定义
    git = {
      default_url_format = 'https://ghproxy.com/https://github.com/%s',
    },
    display = {
      -- 使用浮动窗口显示
      open_fn = function()
        return require('packer.util').float({ border = single })
      end,
    },
    log = { level = 'debug' }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
  },
})
-- 每次保存 plugins.lua 自动安装插件
-- move to autocmds.lua
--pcall(
--  vim.cmd,
--  [[
--augroup packer_user_config
--autocmd!
--autocmd BufWritePost plugins.lua source <afile> | PackerSync
--augroup end
--]]
--)
