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

" Map terminal esc to esc
tnoremap <Esc> <C-\><C-n>

" Enable doxygen highlighting
let g:load_doxygen_syntax=1

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

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
"Plug 'LucHermitte/lh-brackets'
Plug 'LucHermitte/local_vimrc'
Plug 'jalvesaq/vimcmdline'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'tfnico/vim-gradle'
Plug 'ekalinin/dockerfile.vim'
"Plug 'vim-scripts/Conque-GDB'
Plug 'lifepillar/pgsql.vim'
Plug 'martingms/vipsql'
Plug 'alvan/vim-closetag'
Plug 'chr4/nginx.vim'
Plug 'chr4/sslsecure.vim'

Plug 'artur-shaik/vim-javacomplete2'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" This plugin is a supplicant for deoplete.nvim
" It shows function signature during completion
Plug 'Shougo/echodoc.vim'

Plug 'Shougo/deoplete-clangx'

Plug 'junegunn/fzf'

Plug 'rust-lang/rust.vim'
Plug 'LucHermitte/vim-refactor'

" vim-javacomplete2 configurations
autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_EnableDefaultMappings = 0
let g:JavaComplete_ClosingBrace = 1

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

let g:neosolarized_contrast = "low"
let g:neosolarized_visibility = "high"

set background=dark

let g:ale_linter_aliases = {'h': 'c', 'hpp': 'cpp', 'cc': 'cpp'}

let g:ale_c_cc_options = "-std=c11 -Wall"
let g:ale_cpp_cc_options = '-std=c++17 -Wall -Wno-c++11-extensions'

let g:ale_cpp_clangtidy_options = '-x c++ -std=c++17 -Wall'
let g:ale_cpp_clangcheck_options = '-- -x c++ --std=c++17 -Wall'

let g:ale_cpp_clangd_options = '-std=c++17'

" lh-brackets configurations
"let g:usemarks = 0

" vim-gitgutter configurations
let g:GitGutterLineHighlightsEnable = 1
let g:GitGutterLineNrHighlightsEnable = 1

" Shougo/deoplete-clangx configuration
call deoplete#custom#var('clangx', 'default_c_options', g:ale_c_cc_options)
call deoplete#custom#var('clangx', 'default_cpp_options', g:ale_cpp_cc_options)

autocmd BufWritePost * GitGutter "" Turn on updates when saving

" Airline-ale integration
let g:airline#extensions#ale#enabled = 1

" ale configuration
let g:ale_linter_aliases = {'ino': 'cpp'}
let g:ale_c_parse_makefile = 1
" let g:ale_cpp_gcc_options = "-std=c++17" . system("./get_CPPFLAGS.sh")

let g:ale_c_parse_compile_commands = 1

" local_vimrc configuration
" Whitelist for the Development dir so that there will be no prompt when
" opening files in there.
call lh#local_vimrc#munge('whitelist', $HOME . "/Dev")

" vim-cmdline configuration
let cmdline_map_start          = '\s'
"let cmdline_map_send           = '\<Space>'
let cmdline_map_send_and_stay  = '\l'
" Send file
let cmdline_map_source_fun     = '\f'
let cmdline_map_send_paragraph = '\p'
let cmdline_map_send_block     = '\b'
let cmdline_map_quit           = '\q'

" vimcmdline options
let cmdline_vsplit      = 1      " Split the window vertically
let cmdline_in_buffer   = 0      " Start the interpreter in tmux since vimcmdline doesn't support vim term
let cmdline_in_buffer   = 1      " Start the interpreter in a Neovim's terminal
" let cmdline_term_height = 15     " Initial height of interpreter window or pane
let cmdline_term_width  = 90     " Initial width of interpreter window or pane
let cmdline_tmp_dir     = '/tmp' " Temporary directory to save files
let cmdline_outhl       = 1      " Syntax highlight the output
let cmdline_auto_scroll = 1      " Keep the cursor at the end of terminal (nvim)

" python-mode configuration
" Turn pymode on
"let g:pymode = 1
let g:pymode = 0
" Turn off plugin's warnings
let g:pymode_warnings = 1
" Use default settings(documented in :h pymode
let g:pymode_options = 1

" Use python3 and enable indent
let g:pymode_python = 'python3'
let g:pymode_indent = 1

" Show pydoc when pressing 'K'
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'

" Run python code
let g:pymode_run = 1
" It seems that by default, '<leader>' in vim is '\'
let g:pymode_run_bind = '<leader>r'

" Linting
"let g:pymode_lint = 1
let g:pymode_lint = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = 'pylint'
let g:pymode_lint_cwindow = 1
let g:pymode_lint_signs = 1

" Turn on code completion
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1

" Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

"" Conque-GDB configuration
"let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly  "

" lifepillar/pgsql.vim configuration
let g:sql_type_default = 'pgsql'

" martingms/vipsql configuration
" Starts an async psql job, prompting for the psql arguments.
" Also opens a scratch buffer where output from psql is directed.
noremap ;po :VipsqlOpenSession<CR>

" Terminates psql (happens automatically if the output buffer is closed).
noremap <silent> ;pk :VipsqlCloseSession<CR>

" In normal-mode, prompts for input to psql directly.
nnoremap ;ps :VipsqlShell<CR>

" In visual-mode, sends the selected text to psql.
vnoremap ;ps :VipsqlSendSelection<CR>

" Sends the selected _range_ to psql.
noremap ;pr :VipsqlSendRange<CR>

" Sends the current line to psql.
noremap ;pl :VipsqlSendCurrentLine<CR>

" Sends the entire current buffer to psql.
noremap ;pb :VipsqlSendBuffer<CR>

" Sends `SIGINT` (C-c) to the psql process.
noremap ;pc :VipsqlSendInterrupt<CR>

" ale rust configuration
let g:ale_linters = {'rust': ['analyzer', 'cargo', 'rls', 'rustc', 'rustfmt']}
let g:ale_rust_cargo_use_clippy = 1

" alvan/vim-closetag configuration
" For html linting, just `brew install tidy-html5` and it will work fine with
" ale.
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

"" Disable lh-bracket for html files to prevent interference with this plugin
autocmd FileType html :let g:cb_disable_default = { '<': 'inv' }

" shougo/deoplete.nvim configuration
let g:deoplete#enable_at_startup = 1

" Shougo/echodoc.vim configuration
let g:echodoc#enable_at_startup	= 1
"" use neovim's virtual virtual text feature.
let g:echodoc#type = 'virtual'
