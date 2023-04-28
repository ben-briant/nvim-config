" Set mapelader to space
let mapleader = " "

" Set the colorscheme
colorscheme onedark

" configure indentation rules
set tabstop=4 
set shiftwidth=4 
set expandtab

lua require("plugins")
lua require("remaps")

" Line numbers
set number

" Highlight current line
set cursorline

set smartindent
set backspace=indent,eol,start
set incsearch
set ruler
set wildmenu
set mouse=a

" Ignore case when searching with lowercase
" Check case when searching with uppercase
set ignorecase
set smartcase

" merge number and diagnostics column
" this removes the jitter when warnings/errors flow in
set signcolumn=number

" Limit suggestion menu height to 15 items
set pumheight=10

let g:netrw_winsize=30

"""""""""""""""""""""""
" Neovim LSP settings "
"""""""""""""""""""""""
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Only show errors after a certain amount of time
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error

let g:LanguageClient_serverCommands = { 'haskell': ['haskell-language-server-wrapper', '--lsp'] }
" Auto format c/cpp files on save
let g:clang_format#auto_format = 1

xnoremap <expr> I mode() ==# 'v' ? "\<c-v>I" : mode() ==# 'V' ? "\<c-v>^o^I" : "I"
xnoremap <expr> A mode() ==# 'v' ? "\<c-v>A" : mode() ==# 'V' ? "\<c-v>Oo$A" : "A"
