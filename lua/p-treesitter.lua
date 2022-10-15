require('nvim-treesitter.configs').setup{
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    'tsx',
    'lua',
    'python',
    'json',
    'graphql',
    'go',
    'yaml'
  },
  autotag = {
    enable = true,
  }
}
