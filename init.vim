" Install vim plug if it is not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" vim plugins
call plug#begin()
" nicer statusline + filebrowser + tab bar + icons
Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdtree'
Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" onedark colour scheme
Plug 'joshdick/onedark.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins recommended by https://sharksforarms.dev/posts/neovim-rust/ "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Completion framework
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" See hrsh7th's other plugins for more completion sources!
" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'
" Snippet engine
Plug 'hrsh7th/vim-vsnip'

call plug#end()

" enable syntax highlighting
syntax enable
filetype plugin indent on

" set colorscheme
colorscheme onedark

" configure indentation rules
set tabstop=4 
set shiftwidth=4 
set expandtab

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

""""""""""""""""""""""
" Normal mode remaps "
""""""""""""""""""""""

" Make switching betweens splits easier
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Open file browser to side
let g:netrw_winsize=30
nnoremap <C-b> :NERDTreeToggle<return>


""""""""""""""""""""""
" Insert mode remaps "
""""""""""""""""""""""

" Map shift-tab to unindent in insert mode
inoremap <S-Tab> <C-d>

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

" Source lua side of config
lua require('config')
" Initialize statusline
lua require('lualine').setup()

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Only show errors after a certain amount of time
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

