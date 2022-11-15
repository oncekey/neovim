local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  vim.notify('没有找到 nvim-tree')
  return
end

-- 列表操作快捷键
local list_keys = require('keybindings').nvimTreeList

nvim_tree.setup({
  -- 完全精致内置的netrw
  disabel_netrw = true,
  -- 是否显示git状态栏
  git = {
    enable = true,
  },
  -- project plugin的菜单设置
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    -- 隐藏 .文件
    dotfiles = true,
    custom = { 'node_moudles' },
  },
  view = {
    width = 34,
    side = 'left',
    hide_root_folder = false,
    mappings = {
      custom_only = true, -- 只使用内置快捷键
      list = list_keys,
    },
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
  },
  actions = {
    open_file = {
      -- 首次打开文件大小适配
      resize_window = true,
      -- 打开文件时是否关闭tree
      quit_on_open = false,
    },
  },
  system_open = {
    -- mac
    cmd = 'open',
  },
})
