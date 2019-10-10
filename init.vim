" Basic configurations
" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
"set autoindent
set smartindent

set ruler
set number       " Show the lin number
set laststatus=2 " Always show status line

set termguicolors

" Change current dir automatically to current opened file
set autochdir "" This is nvi internal variable

" Enable completion where available.
" This setting must be set before ALE is loaded
let g:ale_competion_enabled = 1

call plug#begin('~/.local/share/nvim/plugged')

" Initialize plugins here
" E.g. (`[]` means optional arguments)
"     Plug 'url|github_username/reponame' [{ 'branch': 'stable', 'tag': '' }]
"
" Step of installing new plugins:
"     1. Add `Plug ''` below;
"     2. Restart neovim and run `:PlugInstall` in neovim.

Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } """ Load the plugin when the command `:NERTTreeToggle` is executed.
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'LucHermitte/lh-vim-lib'  """ lh-vim-lib is the runtime for all other LucHermitte plugins
Plug 'LucHermitte/lh-brackets'
Plug 'LucHermitte/local_vimrc'

call plug#end()

" NERTTree configurations
"" Open nerdtree when vim starts up
autocmd vimenter * NERDTree

"" Open nerdtree when vim open a dir
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"" keybinding for opening nerdtree
map <C-n> :NERDTreeToggle<CR>

"" Show hidden files
let g:NERDTreeShowHidden = 1

"" Close vim when nerdtree is the last tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NeoSolarized configuration
"" Put it here as only after plugin is loaded is color scheme loadable.
colorscheme NeoSolarized

let g:neosolarized_italic = 0

set background=dark

" lh-brackets configurations
let g:usemarks = 0

" vim-gitgutter configurations
let g:GitGutterLineHighlightsEnable = 1
let g:GitGutterLineNrHighlightsEnable = 1

autocmd BufWritePost * GitGutter "" Turn on updates when saving

" Airline-ale integration
let g:airline#extensions#ale#enabled = 1

" ale configuration
let g:ale_linter_aliases = {'ino': 'cpp'}
let g:ale_cpp_gcc_options = "-std=c++17" . system("./get_CPPFLAGS.sh")

" local_vimrc configuration
" Whitelist for the Development dir so that there will be no prompt when
" opening files in there.
call lh#local_vimrc#munge('whitelist', $HOME . "/Development")
