---@diagnostic disable: undefined-global
-- 设置 leader 为空格
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = {
  noremap = true,
  silent = true,
}
local map = vim.api.nvim_set_keymap

-- $跳到行尾不带空格 (交换$ 和 g_)
map('v', '$', 'g_', opt)
map('v', 'g_', '$', opt)
map('n', '$', 'g_', opt)
map('n', 'g_', '$', opt)

-- 命令行下 Ctrl+j/k  上一个下一个
map('c', '<C-j>', '<C-n>', { noremap = false })
map('c', '<C-k>', '<C-p>', { noremap = false })

-- fix :set wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
map('n', '<C-j>', '5j', opt)
map('n', '<C-k>', '5k', opt)
map('v', '<C-j>', '5j', opt)
map('v', '<C-k>', '5k', opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map('n', '<C-u>', '10k', opt)
map('n', '<C-d>', '10j', opt)

-- 设置在insert模式下的光标移动
map('i', '<C-f>', '<right>', opt)
map('i', '<C-b>', '<left>', opt)
map('i', '<C-a>', '<ESC>A', opt)
map('i', '<C-e>', '<ESC>I', opt)

-- windows 分屏快捷键
map('n', 's', '', opt)
map('n', 'sv', ':vsp<CR>', opt)
map('n', 'sh', ':sp<CR>', opt)
-- 关闭当前窗口
map('n', 'sc', '<C-w>c', opt)
-- 关闭其他窗口
map('n', 'so', '<C-w>o', opt)

-- 保存退出
map('n', '<leader>w', ':w<CR>', opt)

-- Terminal相关
-- Esc 回 Normal 模式
map('t', '<Esc>', '<C-\\><C-n>', opt)
map('n', '<leader>t', ':terminal<CR>', opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
-- space + e打开关闭tree
map('n', '<leader>e', ':NvimTreeToggle<CR>', opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  { key = { 'l', '<2-LeftMouse>' }, action = '' },
  { key = 'o', action = 'edit' },
  -- 分屏打开文件
  { key = 'v', action = 'vsplit' },
  { key = 'h', action = 'split' },
  -- 显示隐藏文件
  { key = 'i', action = 'toggle_custom' }, -- 对应 filters 中的 custom (node_modules)
  { key = '.', action = 'toggle_dotfiles' }, -- Hide (dotfiles)
  -- 文件操作
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'r', action = 'rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  { key = 'y', action = 'copy_name' },
  { key = 'Y', action = 'copy_path' },
  { key = 'gy', action = 'copy_absolute_path' },
  { key = 'I', action = 'toggle_file_info' },
  { key = 'n', action = 'tabnew' },
}

-- bufferline 快捷键
map('n', '<leader>bc', ':BufferLinePick<CR>', opt)
map('n', '<leader>bd', ':BufferLinePickClose<CR>', opt)
map('n', '<leader>q', ':Bdelete!<CR>', opt)

-- telescope 的快捷键配置
map('n', '<leader>ff', ':Telescope find_files<CR>', opt)
map('n', '<leader>fw', ':Telescope live_grep<CR>', opt)
map('n', '<leader>fb', ':Telescope buffers<CR>', opt)
map('n', '<leader>fk', ':Telescope keymaps<CR>', opt)
map('n', '<leader>fp', ':Telescope projects<CR>', opt)
map('n', '<leader>fr', ':Telescope oldfiles<CR>', opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ['<C-j>'] = 'move_selection_next',
    ['<C-k>'] = 'move_selection_previous',
    ['<C-n>'] = 'move_selection_next',
    ['<C-p>'] = 'move_selection_previous',
    -- 历史记录
    ['<Down>'] = 'cycle_history_next',
    ['<Up>'] = 'cycle_history_prev',
    -- 关闭窗口
    -- ["<esc>"] = actions.close,
    ['<C-c>'] = 'close',
    -- 预览窗口上下滚动
    ['<C-u>'] = 'preview_scrolling_up',
    ['<C-d>'] = 'preview_scrolling_down',
  },
}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(lspmap)
  -- rename
  --[[
  Lspsaga 替换 rn
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  --]]
  lspmap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opt)
  -- code action
  --[[
  Lspsaga 替换 ca
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  --]]
  lspmap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opt)
  -- go xx
  --[[
    mapbuf('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opt)
  --]]
  lspmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  lspmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  --[[
  Lspsaga 替换 gh
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  --]]
  lspmap('n', 'gh', '<cmd>Lspsaga hover_doc<cr>', opt)
  --[[
  Lspsaga 替换 gr
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  --]]
  lspmap('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opt)
  --[[
  Lspsaga 替换 gp, gj, gk
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  --]]
  -- diagnostic
  lspmap('n', 'gp', '<cmd>Lspsaga show_line_diagnostics<CR>', opt)
  lspmap('n', 'gj', '<cmd>Lspsaga diagnostic_jump_next<cr>', opt)
  lspmap('n', 'gk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opt)
  lspmap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- 未用
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {
    -- 出现补全
    ['<C-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    ['<C-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 上一个
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- 如果窗口内容太多，可以滚动
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- 确认
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }
end
-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', '<leader>gj', function()
    if vim.wo.diff then
      return ']c'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end, { expr = true })

  map('n', '<leader>gk', function()
    if vim.wo.diff then
      return '[c'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return '<Ignore>'
  end, { expr = true })

  map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>')
  map('n', '<leader>gS', gs.stage_buffer)
  map('n', '<leader>gu', gs.undo_stage_hunk)
  map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
  map('n', '<leader>gR', gs.reset_buffer)
  map('n', '<leader>gp', gs.preview_hunk)
  map('n', '<leader>gb', function()
    gs.blame_line({ full = true })
  end)
  map('n', '<leader>gd', gs.diffthis)
  map('n', '<leader>gD', function()
    gs.diffthis('~')
  end)
  -- toggle
  map('n', '<leader>gtd', gs.toggle_deleted)
  map('n', '<leader>gtb', gs.toggle_current_line_blame)
  -- Text object
  map({ 'o', 'x' }, 'ig', ':<C-U>Gitsigns select_hunk<CR>')
end

return pluginKeys
