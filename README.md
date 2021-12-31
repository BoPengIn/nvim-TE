# nvim-TE
nvim-TE, structural config for neovim. 
it can works on WSL and Windows through Windows Terminal, or on iOS & iPadOS through Blink Shell.

## 目录

* [平台支持](#平台支持) 
* [安装](#安装)
  - [终端设置](#终端设置)
  - [安装`neovim`](#安装neovim)
  - [安装依赖](#安装依赖)
  - [安装`nvim-TE`](#安装nvim-TE)
* [插件快捷键](#插件快捷键)
* [注意事项](#注意事项)
* [插件说明](#插件说明)
* [基础配置说明](#基础配置说明)
* [自定义扩展](#自定义扩展)

## 平台支持

| 平台       | 终端工具         | 系统版本    |
| ---------- | ---------------- | ----------- |
| `Windows`    | `Windows Terminal` | `Windows 10`  |
| `WSL`        | `Windows Terminal` | `Ubuntu 20.+ `|
| `iOS&iPadOS` | `Blink Shell`      | `iOS15`       |

## 安装

###  终端设置

* **`Windows & WSL`**

1. 安装 [`Windows Termainal`](https://aka.ms/terminal)

2. 安装 [`nerd font`](https://www.nerdfonts.com/font-downloads)

   在<https://www.nerdfonts.com/font-downloads>中选择一个`nerd font`下载后解压，双击打开安装

3. 在`Windows Terminal`设置中选择对应的终端，在外观的字体中进行选择设置并保存


* **`iOS & iPadOS`**

1. 安装[`Blink Shell`](https://blink.sh/)

2. 安装 [`nerd font`](https://github.com/blinksh/fonts)

   在<https://github.com/blinksh/fonts>中选择一个`nerd font`,复制它的`"raw"`地址，设置到`Blink Shell`的`Settings->Appeareance->FONTS->Add a new font`中的`CSS FONT-FAMILY STYLESHEET`中，点击`Import`，并在`FONT-FAMILY NAME`设置一个字体名，再进行`Save`.在`Settings->Appeareance->FONTS`中选择这个设置的这个字体名

### 安装`neovim`
* **`Windows`**
1. 在 `PowerShell`中打开远程权限 
   ```
   Set-ExecutionPolicy RemoteSigned -scope CurrentUser;
   ```
2. 下载并安装`scoop`
   ```
   iwr -useb get.scoop.sh | iex
   scoop update
   ```
3. 下载并安装`neovim`
   ```
   scoop bucket add versions
   scoop install neovim
   ```
* **`Ubuntu`**
1. 需要安装`Clang`或`GCC 4.4+`，`CMake 2.8.12+`
2. 安装依赖库
   ```
   sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
   ```
3. 下载并安装`neovim`
   ```
   sudo wget https://github.com/neovim/neovim/archive/refs/tags/v0.5.1.tar.gz
   tar -xzvf v0.5.1.tar.gz
   cd neovim-0.5.1 
   make CMAKE_BUILD_TYPE=Release
   sudo make install
   ```
### 安装依赖

#### 插件需求依赖库`ripgrep`, `fd`

  * **`Windows`**

    ```
    scoop install ripgrep
    scoop install fd
    ```
  * **`Ubuntu`**

    ```
    sudo apt install ripgrep
    sudo apt install fd-find
    ```

#### `C/C++`语言`LSP`依赖库[`clangd`](https://clangd.llvm.org/installation.html),[`cmake`](https://github.com/regen100/cmake-language-server),[`ccls`](https://github.com/MaskRay/ccls)

  * **`Windows`**
    * [`clangd`](https://clangd.llvm.org/installation.html)
    ```
    scoop install llvm
    ```
    * [`cmake`](https://github.com/regen100/cmake-language-server)
    ```
    scoop install Python
    pip install cmake-language-server
    ```
    * [`ccls`](https://github.com/MaskRay/ccls)
    1. 需要使用`Developer Command Prompt for VS`中执行以下命令
    ```
    git clone https://github.com/llvm/llvm-project.git
    cd llvm-project
    cmake -Hllvm -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS=clang
    ninja -C Release clangFormat clangFrontendTool clangIndex clangTooling clang
       
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    cd ccls
    cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=cl -DCMAKE_PREFIX_PATH="llvm-project/Release"
    ninja -C Release
    ```
    
    2. 增加`ccls\Release` 到环境变量`Path`中
    
  * **`Ubuntu`**
    * [`clangd`](https://clangd.llvm.org/installation.html)
    ```
     sudo apt install clang-12
     sudo apt install clangd-12
    ```
    * [`cmake`](https://github.com/regen100/cmake-language-server)
    ```
    pip install cmake-language-server
    ```
    * [`ccls`](https://github.com/MaskRay/ccls)
    ```
    apt install ccls
    ```

#### `Lua`语言`LSP`依赖库[`sumneko_Lua`](https://github.com/sumneko/lua-language-server)
  * **`Windows`**
  1. Install ninja
     ```
     scoop install ninja
     ```
  2. Clone project
     ```
     mkdir (system disk):\Users\(you user name)\AppData\Local\nvim-data\lsp\ 
     cd (system disk):\Users\(you user name)\AppData\Local\nvim-data\lsp\
       
     git clone https://github.com/sumneko/lua-language-server
     cd lua-language-server
     git submodule update --init --recursive
     ```
  3. Build
     ```
     cd 3rd\luamake
     compile\install.bat
     cd ..\..
     3rd\luamake\luamake.exe rebuild
     ```
  * **`Ubuntu`**
  1. Install ninja
     ```
     sudo apt install ninja-build
     ```
  2. Clone project
     ```
     mkdir -p ~/.local/share/nvim/lsp/
     cd ~/.local/share/nvim/lsp/
     git clone https://github.com/sumneko/lua-language-server
     cd lua-language-server
     git submodule update --init --recursive
     ```
  3. Build
     ```
     cd 3rd/luamake
     ./compile/install.sh
     cd ../..
     ./3rd/luamake/luamake rebuild
     ```
### 安装nvim-TE
  * **`Windows`**
    ```
    git clone https://github.com/PengBo-cn/nvim-TE.git (system disk):\Users\(you user name)\AppData\Local\nvim
    ```
  * **`Ubuntu`**
    
    ```
    git clone https://github.com/PengBo-cn/nvim-TE.git ~/.config/nvim
    ```
## 插件快捷键

|    按键    |         模式         |          功能          | 来源插件  |
| :--------: | :------------------: | :--------------------: | :-------: |
| \<A-h>  |        insert        | 插入模式左移光标 | neovim |
| \<A-l> |        insert        | 插入模式右移光标 | neovim |
| \<A-k> |        insert        | 插入模式上移一行 | neovim |
| \<A-j> |        insert        | 插入模式下移一行 | neovim |
| \<A-d> |        insert        |           插入模式删除           | neovim |
| \<C-u> |        insert        | 插入模式向上移动半页 | neovim |
| \<C-d> |        insert        | 插入模式向下移动半页 | neovim |
| \<C-s> |        normal,insert        | 保存文件 | neovim |
| \<C-h> |        normal,insert        | 插入模式移动光标至行首 | neovim |
| \<C-l> |        normal,insert        | 插入模式移动光标至行尾 | neovim |
| \<leader>h  |        normal        | c/c++头文件源文件切换  | lspconfig |
|     gd     |        normal        |        转到定义        | lspconfig |
|     gs     |        normal        |        转到声名        | lspconfig |
|     gt     |        normal        |      转到类型定义      | lspconfig |
|     gr     |        normal        |        转到引用        | lspconfig |
|     gi     |        normal        |        转到实现        | lspconfig |
|     K      |        normal        |      显示悬停文档      | lspconfig |
|  \<space>f  |        normal        |       自动格式化       | lspconfig |
|     gh     |        normal        |  查找光标词定义和引用  |  lspsaga  |
|     [e     |     normal      |   转到前一个诊断提示   |        lspsaga         |
|     ]e     |     normal      |   转到下一个诊断提示   |        lspsaga         |
|   \<C-t>    | normal,tnoremap |        悬浮终端        |        lspsaga         |
| \<leader>pd |        normal        |        预览定义        |  lspsaga  |
| \<leader>rf |        normal        |         重命名         |  lspsaga  |
|     ]]     | normal,visual | 移动至下一个函数开始行 |           treesitter-textobjects|
|     ][     | normal,visual | 移动至下一个函数结束行 | treesitter-textobjects |
|     [[     |  normal,visual  | 移动至上一个函数开始行 | treesitter-textobjects |
|     []     |  normal,visual  | 移动至上一个函数结束行 | treesitter-textobjects |
|     ]m     |  normal,visual  |  移动至下一个类开始行  | treesitter-textobjects |
|     ]n     |  normal,visual  |  移动至下一个类结束行  | treesitter-textobjects |
|     [m     |  normal,visual  |  移动至上一个类开始行  | treesitter-textobjects |
|     [n     |  normal,visual  |  移动至上一个类结束行  | treesitter-textobjects |
|     af     |     select      |      选择整个函数      | treesitter-textobjects |
|     if     |     select      |   只选择函数内部实现   | treesitter-textobjects |
| ac | select | 选择整个类 | treesitter-textobjects |
| ic | select | 只选择类内部实现 | treesitter-textobjects |
| \<C-n> | normal | 开关文件浏览器 | nvim-tree |
| v | nvim-tree action | vsplit方式打开 | nvim-tree |
| \<C-x> | nvim-tree action | split方式打开 | nvim-tree |
| \<Tab> | nvim-tree action | 预览 | nvim-tree |
| \<BS> | nvim-tree action | 关闭文件夹 | nvim-tree |
| R | nvim-tree action | 刷新 | nvim-tree |
| a | nvim-tree action | 创建 | nvim-tree |
| d | nvim-tree action | 删除 | nvim-tree |
| r | nvim-tree action | 重命名 | nvim-tree |
| x | nvim-tree action | 剪切 | nvim-tree |
| c | nvim-tree action | 拷贝 | nvim-tree |
| p | nvim-tree action | 粘贴 | nvim-tree |
| y | nvim-tree action | 拷贝名称 | nvim-tree |
| q | nvim-tree action | 关闭 | nvim-tree |
| [b |      normal      | 下一个标签页 | bufferline |
| b] | normal | 上一个标签页 | bufferline |
| gb | normal | 激活标签页切换选取功能 | bufferline |
| bd | normal | 激活标签页关闭选取功能 | bufferline |
| bh | normal | 关材左侧标签页 | bufferline |
| bl | normal | 关材右侧标签页 | bufferline |
| \<A-(1-9)> | normal | 按序号顺序切换标签页 | bufferline |
| \<leader>xx | normal | 激活诊断列表 | trouble |
| \<leader>xd | normal | 关闭诊断列表 | bufferline |
| \<leader>xr | normal | 刷新诊断列表 | bufferline |
| \<leader>fb | normal | 列出当前neovim实例中打开的缓冲区 | telescope |
| \<leader>ff | normal | 列出当前工作目录中的文件 | telescope |
| \<leader>fg | normal | 在当前工作目录中搜索字符串 | telescope |
| \<leader>fh | normal | 列出可用的帮助标签 | telescope |
| \<C-p> | nvim-cmp action | 选择上一个 | nvim-cmp |
| \<C-n> | nvim-cmp action | 选择下一个 | nvim-cmp |
| \<C-b> | nvim-cmp action | 前上滚动文档 | nvim-cmp |
| \<C-f> | nvim-cmp action | 前后下动文档 | nvim-cmp |
| \<C-y> | nvim-cmp action | 完成 | nvim-cmp |
| \<C-e> | nvim-cmp action | 关闭 | nvim-cmp |
| \<CR> | nvim-cmp action | 确认 | nvim-cmp |
| \<C-j> | nvim-cmp action | 跳下一个 | nvim-cmp |
| \<C-k> | nvim-cmp action | 跳上一个 | nvim-cmp |
| m | normal,visual | 代码注释 | nvim-comment |
| \<A-m> | insert | 代码注释 | nvim-comment |
| jk | insert | 退出插入模式 | better-escape |

## 注意事项

### 中国区域用户无法访问`GitHub`或是访问不稳定问题
1. 使用代理进行访问，如下
```
git clone https://github.com/PengBo-cn/nvim-TE.git
```
修改为
```
git clone https://mirror.ghproxy.com/https://github.com/PengBo-cn/nvim-TE.git
```
2. 将`git clone`到本地的`nvim-TE`中的`init.lua`，解开以下注释代码
```
local proxyMirror = "https://mirror.ghproxy.com/"
```

## 插件说明

### 配置插件说明
> - **`packer.nvim`**
>   * 功能：`neovim`插件/软件包的管理工具
>   * 地址：[`wbthomason/packer.nvim`](https://github.com/wbthomason/packer.nvim) 
> - **`nvim-lspconfig`**
>   * 功能：`neovim`内置语言服务客户端
>   * 地址：[`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)
> - **`lsp_signature.nvim`**
>   * 功能：显示函数信息的浮动窗口
>   * 地址：[`ray-x/lsp_signature.nvim`](https://github.com/ray-x/lsp_signature.nvim)
>   * 需要：`nvim-lspconfig`
> - ~~**`lspsaga.nvim`**~~
>   * ~~功能：一个轻量级、高性能的的`LSP UI`插件~~
>   * ~~地址：[`glepnir/lspsaga.nvim`](https://github.com/glepnir/lspsaga.nvim)~~
>   * ~~需要：`nvim-lspconfig`~~
> - **`lspsaga.nvim`**
>   * 功能：一个轻量级、高性能的的`LSP UI`插件
>   * 地址：[`tami5/lspsaga.nvim`](https://github.com/tami5/lspsaga.nvim)
>   * 需要：`nvim-lspconfig`
>  - **`nvim-treesitter`**
>    * 功能：语法高亮插件
>    * 地址：[`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)
>  - **`nvim-treesitter-textobjects`**
>    * 功能：文本对象的选择及移动（支持函数及类方式）
>    * 地址：[`nvim-treesitter/nvim-treesitter-textobjects`](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
>    * 需要：`nvim-treesitter`
> - **`nvim-treesitter-context`**(暂时废弃`Windows`下有`BUG`)
>   * 功能：在上下文窗口中，显示正在查看的函数、类、方法
>   * 地址：[`romgrk/nvim-treesitter-context`](https://github.com/romgrk/nvim-treesitter-context)
>   * 需要：`nvim-treesitter`
> - **`vim-matchup`**
>   * 功能：高亮显示、导航及操作符的文本匹配
>   * 地址：[`andymass/vim-matchup`](https://github.com/andymass/vim-matchup)
>   * 需要：`nvim-treesitter`
> - **`nvim-web-devicnos`**
>   * 功能：图标及颜色
>   * 地址：[`kyazdani42/nvim-web-devicons`](https://github.com/kyazdani42/nvim-web-devicons)
> - **`lualine.nvim`**
>   * 功能：状态行
>   * 地址：[`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)
>   * 需要：`nvim-web-devicons`,`nvim-gps`
> - **`nvim-tree.lua`**
>   * 功能：文件浏览器
>   * 地址：[`kyazdani42/nvim-tree.lua`](https://github.com/kyazdani42/nvim-tree.lua)
>   * 需要：`nvim-web-devicons`
> - **`bufferline.nvim`**
>   * 功能：标签页
>   * 地址：[`akinsho/bufferline.nvim`](https://github.com/akinsho/bufferline.nvim)
>   * 需要：`nvim-web-devicons`
> - **`trouble.nvim`**
>   * 功能：用于显示诊断结果列表
>   * 地址：[`folke/trouble.nvim`](https://github.com/folke/trouble.nvim)
>   * 需要：`nvim-web-devicons`
> - **`telescope.nvim`**
>   * 功能：文件模糊搜索
>   * 地址：[`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
>   * 需要：[`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvi),[`nvim-telescope/telescope-fzy-native.nvim`](https://github.com/nvim-telescope/telescope-fzy-native.nvim)
>   * 依赖库：`ripgrep`,`fd`
> - **`LuaSnip`**
>   * 功能：代码段引擎
>   * 地址：[`L3L3MON4D3/LuaSnip`](https://github.com/L3MON4D3)
>   * 需要：[`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets)
> - **`nvim-cmp`**
>   * 功能：自动补全
>   * 地址：[`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)
>   * 需要：[`onsails/lspkind-nvim`](https://github.com/onsails/lspkind-nvim),[`saadparwaiz1/cmp_luasnip`](https://github.com/saadparwaiz1/cmp_luasnip),[`hrsh7th/cmp-buffer`](https://github.com/hrsh7th/cmp-buffer),[`hrsh7th/cm-nvim-lsp`](https://github.com/hrsh7th/cm-nvim-lsp),[`hrsh7th/cmp-nvim-lua`](https://github.com/hrsh7th/cmp-nvim-lua),[`hrsh7th/cmp-path`](https://github.com/hrsh7th/cmp-path),[`f3fora/cmp-spell`](https://github.com/f3fora/cmp-spell),[`kdheepak/cmp-latex-symbols`](https://github.com/kdheepak/cmp-latex-symbols)
> - **`nvim-autopairs`**
>   * 功能：自动配对
>   * 地址：[`windup/nvim-autopairs`](https://github.com/windup/nvim-autopairs)
>   * 需要：`nvim-cmp`
> - **`nvim_comment`**
>   * 功能：代码注释
>   * 地址：[`terrortylor/nvim-comment`](https://github.com/terrortylor/nvim-comment)
> - **`indent-blankline.nvim`**
>   * 功能：缩进显示
>   * 地址：[`lukas-reineke/indent-blankline.nvim`](https://github.com/lukas-reineke/indent-blankline.nvim)
> - **`better-escape.nvim`**
>   * 功能：插入模式退出`Esc`映射至`jk`
>   * 地址：[`max397574/better-escape.nvim`](https://github.com/max397574/better-escape.nvim)
> - **`lsp-colors.nvim`**
>   * 功能：补充配色
>   * 地址：[`folke/lsp-colors.nvim`](https://github.com/folke/lsp-colors.nvim)
> - **`sonokai`**
>   * 功能：主题
>   * 地址：[`sainnhe/sonokai`](https://github.com/sainnhe/sonokai)
### 插件查寻地址
- [`vimawesome`](https://vimawesome.com)
- [`rockerBOO/awesome-neovim`](https://github.com/rockerBOO/awesome-neovim)

## 基础配置说明
> - ***`encode`***
>   `encoding` 内部使用的编码方式
>   `filenecoding` 多行文本的文件编码
> - ***`file`***
>   `backup` 覆盖文件时保留备份文件
>   `swapfile` 缓冲区是否使用交换文件 
>   `autoread` 在`Vim`之外改动时会自动重读文件
>   `autowrite` 使切换文件时，修改的文件被自动保存
> - ***`cursor line`***
>   `cursorline` 高亮光标所在屏幕行
>   `relativenumber` 每行前显示相对行号
>   `number` 行前显示行号
>   `scrolloff` 光标上下的最少行数
>   `sidesrolloff` 光标左右最少出现列数
> - ***`tab`***
>   `expandtab` 键入`<Tab>`时使用空格
>   `shiftwidth` 自动缩进使用的步进空格数
>   `tabstop` `<Tab>`在文件中使用的空格数
>   `smarttab` 插入`<Tab>`时使用`shiftwidth`
> - ***`search`***
>   `ignorecase` 搜索模式时忽略大小写
>   `insearch` 输入搜索模式时同时高亮部份的匹配
>   `wrapscan` 搜索在文件尾折回文件头
> - ***`ui`***
>   `showmode` 在状态行上显示当前模式
>   `showtagline` 是否显示标签页行
>   `showcmd` 在状态行里显示命令
>   `splitbelow` 分割窗口时新窗口在当前窗口之下
>   `splitright` 新窗口在肖前窗口之右 
>   `pumheight` 弹出窗口的最大高度
>   `foldenable` 显示所用打开的折叠
>   `foldmethod` 折叠类型
>   `foldexpr` 折叠表达式
> - ***`other`***
>   `backspace` 退格键的处理模式 
>   `completeopt` 插入补全使用的选项
>   `conceallevel` 是否显示可隐藏文本
>   `history` 记住的命令行的行数
>   `smartcase` 模式中有大写字母时不忽略大小写
>   `smartindent` 智能缩进
>   `clipboard` 使用剪切板
>   `mouse` 允许使用鼠标
>   `redrawtime` 在`hlsearch`和`match`时高亮超时
>   `timeout` 映射和键盘代码等待超时
>   `timeoutlen` 超时时间
>   `timeout` 映射等待超时
>   `ttimeoutlen` 键盘代码超时时间
>   `wildignorecase` 匹配文件名时忽略大小写
>   `wrap` 长行回绕并在下一行继续

## 自定义扩展
### 扩展插件
在`lua/pluginList.lua`中增加扩展插件配置
### 扩展语言
1. 在`lua/languageServer/`目录下可增加对应所需的扩展语言服务。
2. 在`lua/languageConfig.lua`中的`setup`方法中加入扩展语言服务设置，在`list`方法中加入需`nvim-treesitter`安装的扩展语言。

