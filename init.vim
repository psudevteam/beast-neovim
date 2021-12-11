call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sbdchd/neoformat'
Plug 'windwp/nvim-autopairs'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'voldikss/vim-floaterm'

call plug#end()

autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.html Neoformat
autocmd BufWritePre *.vue Neoformat
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 
autocmd BufEnter * lua require'completion'.on_attach()

map <C-f> :NERDTreeToggle <CR> 
map ff : FloatermNew --autoclose=0 sh test.sh <CR> 
map ee : FloatermNew --autoclose=0 sh compile.sh && sh run.sh <CR> 
map <C-s> : FZF <CR> 

if has('nvim') || has('termguicolors')
  set termguicolors
endif

let g:NERDTreeGitStatusUseNerdFonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme='challenger_deep'

set completeopt=menuone,noinsert,noselect
set tabstop=2
set softtabstop=2
set expandtab
set smartindent
set number
set numberwidth=4
set relativenumber
set signcolumn=number
set noswapfile
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set hidden
set scrolloff=5
set noshowmode
set updatetime=250
set encoding=UTF-8
set mouse=a
set cursorline

hi CursorLine cterm=bold ctermbg=NONE 

lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", 
  sync_install = true, 
  ignore_install = { "" }, 
  highlight = {
    enable = true,              
    additional_vim_regex_highlighting = false,
  },
}

require('nvim-autopairs').setup{}

require'lspconfig'.pyright.setup{}

require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}

require'lspconfig'.vuels.setup{on_attach=require'completion'.on_attach}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

local actions = require('telescope.actions')

require('telescope').setup{}      
EOF


colorscheme challenger_deep
"colorscheme gruvbox


