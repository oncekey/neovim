# VIM Lua知识

## vim相关设置分类
- vim.g.{name}: 全局变量
- vim.b.{name}: 缓冲区变量
- vim.w.{name}: 窗口变量
- vim.bo.{option}: buffer-local 选项
- vim.wo.{option}: window-local 选项

## 快捷键设置相关

- vim.api.nvim_set_keymap() 全局快捷键
- vim.api.nvim_buf_set_keymap() Buffer 快捷键

一般情况下，都是定义使用全局快捷键， Buffer 快捷键一般是在某些异步回调函数里指定
例如某插件初始化结束后，会有回调函数提供 Buffer，这个时候我们可以只针对这一个 Buffer 设置快捷键

模式参照
- n Normal 模式
- i Insert 模式
- v Visual 模式
- t Terminal 模式
- c Command 模式

options 大部分会设置为 { noremap = true, silent = true }。
noremap 表示不会重新映射，比如你有一个映射 A -> B , 还有一个 B -> C，这个时候如果你设置 noremap = false 的话，表示会重新映射，那么 A 就会被映射为 C。silent 为 true，表示不会输出多余的信息。

## 代码格式化
使用`use("mhartington/formatter.nvim")`作为通用格式化，golang除外
formatter:https://github.com/mhartington/formatter.nvim/
### 使用方法 - 以lua为例
我们以 Lua 语言为例，看看如何配置一个语言格式化功能。

第一步需要知道你使用的编程语言有哪些 Code Formatter。 
像 Lua 比较常见的应该是 StyLua 或者是 lua-fmt，前端开发的话通常就是用 Prettier 来格式化。

如果不知道也没关系，可以直接到 Formatter 配置文件示例 中搜索关键字，比如我 Ctrl + f 搜索 lua 就搜到了 stylua 的配置方法。

![image](/image/stylua.png)

