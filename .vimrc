
set wildmenu"按TAB键时命令行自动补齐"
set number "显示行号"
set ruler"显示当前光标位置"
set mouse-=a"开启鼠标支持"
set autoindent
set expandtab
set softtabstop=4
set tabstop=4
syn on

set hlsearch "开启搜索结果的高亮显示"
set incsearch "边输入边搜索(实时搜索)"

"when editing a file, always jump to the last cursor position 
 autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif 

"========================"
"11.txt文件按照wiki语法高亮"
"========================"
 autocmd BufNewFile *.txt set ft=confluencewiki 
 autocmd BufEnter *.txt set ft=confluencewiki

 "12.设置文件编码，解决中文乱码问题"
 "======================"
 if has("multi_byte")
    set fileencodings=utf-8,ucs-bom,cp936,cp1250,big5,euc-jp,euc-kr,latin1
 else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
 endif

 "==================="
 "13. 对gvim 的设置"
 "=================="
 if has("gui_running")
     colorscheme  morning
     set guifont=Monaco:h13
     set guioptions=mr "只显示菜单和右侧滚动条"
 endif

"set colorcolumn=80
