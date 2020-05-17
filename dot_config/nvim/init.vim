" Nikki NeoVim Config. LAST MAJOR UPDATE: 11/04/20

" Plugin manager {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
"{{ The Basics }}
	Plug 'chaimleib/vim-renpy'
	Plug 'jeetsukumaran/vim-buffergator'
	Plug 'plasticboy/vim-markdown'
"{{ Colors }}
	Plug 'morhetz/gruvbox'
	Plug 'chriskempson/base16-vim'
	Plug 'arcticicestudio/nord-vim'
"{{ Stylize }}
	" Plug 'vim-airline/vim-airline'
	" Plug 'vim-airline/vim-airline-themes'
	Plug 'itchyny/lightline.vim'
	Plug 'ryanoasis/vim-devicons'
	Plug 'nathanaelkane/vim-indent-guides'
"{{ File management }}
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	" Plug 'ctrlpvim/ctrlp.vim'
"{{ Productivity }}
	Plug 'vimwiki/vimwiki'
	Plug 'jreybert/vimagit'
"{{ Junegunn Choi Plugins }}
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
	Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
"{{ Tim Pope Plugins }}
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-eunuch'
"{{ Parenthesis }}
	Plug 'alvan/vim-closetag'
	Plug 'luochen1990/rainbow'
	" Plug 'raimondi/delimitmate'
"{{ Syntax Highlighting and Colors }}
	Plug 'ap/vim-css-color'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'kovetskiy/sxhkd-vim'
	Plug 'cakebaker/scss-syntax.vim'
	Plug 'pangloss/vim-javascript'
	Plug 'vim-syntastic/syntastic'
	Plug 'davidhalter/jedi-vim'
	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()
" }}}

" Basic {{{
set nocompatible
let mapleader =" "
" }}}

" Some plugin specific things {{{
let g:rainbow_active = 1
let g:indent_guides_enable_on_vim_startup = 1

" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#wordcount#enabled = 1
" let g:airline_theme = 'base16_tomorrow'
" let g:airline_theme = 'nord'

let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ }

" let g:lightline = {
"       \ 'colorscheme': 'nord',
"       \ }

let g:jedi#usages_command = "<A>z"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#auto_vim_configuration = 0

augroup pyjedi
    autocmd!
    autocmd FileType python setlocal omnifunc=jedi#completions
                                \ textwidth=79
                                \ completeopt-=preview
                                \ formatoptions+=c
augroup END

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" }}}

" UI {{{
syntax enable
filetype plugin indent on
set number
set relativenumber
set modelines=1
set showcmd
set cursorline
set mouse=a
set ruler
set wrap
set textwidth=0
set wrapmargin=0
set wrapscan
set backspace=indent,eol,start
set background=dark
set guioptions=a
set showmatch
call matchadd('ColorColumn', '\%81v', 100)
nnoremap <leader>= :vertical resize +10<CR>
nnoremap <leader>- :vertical resize -10<CR>
nnoremap <leader>h :split<Space>
nnoremap <leader>v :vsplit<Space>
set splitbelow
set splitright
set termguicolors
set t_Co=256
colorscheme base16-tomorrow-night
" colorscheme nord
highlight Normal guibg=NONE ctermbg=NONE

" Syntastic recommends
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" Searching {{{
set incsearch
nnoremap <leader><space> :nohlsearch<CR>
set hlsearch
" S for find and replace.
nnoremap S :%s//g<Left><Left>
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" }}}

" Section Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
nnoremap <space>z za
" }}}

" Tabs and Spaces {{{
"set shiftwidth=4
set listchars=tab:__
"set tabstop=4
" }}}

" Spelling {{{
set spell spelllang=en_us
set spellsuggest=best,10
map <leader>s :setlocal spell!<CR>

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
hi clear SpellRare
hi SpellRare cterm=underline,bold ctermfg=red
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=blue
hi clear SpellLocal
hi SpellLocal cterm=underline ctermfg=green
set spellfile=$HOME/Dropbox/Backups/vim/en.utf-8.add
" }}}

"File Find {{{
set path+=**
set wildmenu
set wildmode=longest,list,full
" }}}

" NerdTree {{{
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	autocmd BufWritePre * %s/\s\+$//e
"}}}

" Random Options {{{
let g:tex_flavor = "latex"
set encoding=utf-8
set nowritebackup
set nobackup
set history=500
set noshowmode
set linebreak
set list
set clipboard=unnamedplus
set hidden
map <leader>r :source ~/.config/nvim/init.vim<CR>
set ignorecase
set smartcase
set lazyredraw
set viminfo^=%
set grepprg=grep\ -nH\ $*
set noerrorbells visualbell t_vb=
map Q gq
" autocmd VimLeave * !pkill -9 "entr"
"match Error /\t/
" }}}

" Status Line {{{
set laststatus=2
set statusline =\ D:%{getcwd()}  " Working directory
set statusline+=\ F:%f           " Current file
set statusline+=\ S:%m           " File's modification state
set statusline+=\ R:%r           " File's permissions
set statusline+=\ T:%y           " File's language type
set statusline+=\ L:%l/%L        " Current line vs lines number
" }}}

" CTRLP Plugin {{{
"let g:ctrlp_map = '<C-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_switch_buffer = 'et'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.iml,*.jpg,*.gif,*.png,*.pdf
"let g:ctrlp_user_command = 'find %s -type f'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <C-x><C-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" Advanced customization using Vim function
inoremap <expr> <C-x><C-k> fzf#vim#complete#word({'left': '15%'})

"}}}

" Tab navigation {{{
nnoremap <Leader>n :tabnew<Space>
nnoremap <Leader>h :tabfirst<CR>
nnoremap <Leader>j :tabprevious<CR>
nnoremap <Leader>k :tabnext<CR>
nnoremap <Leader>l :tablast<CR>

nnoremap <silent> <A-h> :tabprevious<CR>
nnoremap <silent> <A-l> :tabnext<CR>

" }}}

" Basic file system bindings {{{
nnoremap gl $
nnoremap gh 0
nnoremap gk H
nnoremap gj L

map Y y$
nnoremap j gj
nnoremap k gk

nnoremap <leader>q :wq<CR>
nnoremap <leader>w :w<CR>
" }}}}

" Key settings {{{
noremap <C-j> <C-W><C-J>
noremap <C-k> <C-W><C-K>
noremap <C-h> <C-W><C-H>
noremap <C-l> <C-W><C-L>

map <A-p> :PlugInstall<CR>
map <C-n> :NERDTreeToggle<CR>
"map <C-N> :NERDTreeFind<CR>
map <C-q> :!wc -w %<CR>
map <A-t> ggO---<ESC>odate:<ESC>:r!date "+\%F"<CR>kJo---<ESC>o
map <A-d> o DATE: <ESC>:r!date "+\%x"<CR>kJA BY: NikkiSatmaka<ESC>kJA
map <leader>p :!zathura %:r.pdf &<CR><CR>
map <leader>o :!pandoc % -t beamer -o %:r.pdf &<CR><CR>
"map <leader>c :!setsid vim_compile %<CR><CR>
" map <leader>c :!setsid auto_vim_compile % &<CR><CR>
map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>
" }}}}

" Auto -  file types {{{
autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType,BufRead *.rpy,*.rpyc set tabstop=4|set shiftwidth=4|set expandtab
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
" autocmd BufRead,BufNewFile *.md set tw=79
" }}}

"SNIPPETS {{{
	inoremap ,<Tab> <Esc>/<++><Enter>"_c4l
	vnoremap ,<Tab> <Esc>/<++><Enter>"_c4l
	map ,<Tab> <Esc>/<++><Enter>"_c4l
" MARK DOWN
	"autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	"autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,n \pagebreak<Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,i ![]()<Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a []()<Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,p ---<Enter>title:<Enter>-<++><Enter>author:<Enter>-<++><Enter>theme:<Enter>-Copenhagen Antibes Bergen Berkeley Berlin Marburg<++><Enter>---<Enter><++><Esc>gg
" https://hartwork.org/beamer-theme-matrix/ <-for more themes
" PHP/HTML
	autocmd FileType php,html inoremap ,b <b></b><Space><Esc>FbT>i
	autocmd FileType php,html inoremap ,it <em></em><Space><Esc>FeT>i
	autocmd FileType php,html inoremap ,1 <h1></h1><Enter><Enter><Esc>2kf<i
	autocmd FileType php,html inoremap ,2 <h2></h2><Enter><Enter><Esc>2kf<i
	autocmd FileType php,html inoremap ,3 <h3></h3><Enter><Enter><Esc>2kf<i
	autocmd FileType php,html inoremap ,p <p></p><Enter><Enter><Esc>02kf>a
	autocmd FileType php,html inoremap ,a <a<Space>href=""></a><Space><Esc>14hi
	autocmd FileType php,html inoremap ,e <a<Space>target="_blank"<Space>href=""></a><Space><Esc>14hi
	autocmd FileType php,html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><Esc>03kf<i
	autocmd FileType php,html inoremap ,li <Esc>o<li></li><Esc>F>a
	autocmd FileType php,html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><Esc>03kf<i
	autocmd FileType php,html inoremap ,im <img src="" alt=""><esc>Fcf"a
	autocmd FileType php,html inoremap ,td <td></td><Esc>Fdcit
	autocmd FileType php,html inoremap ,tr <tr></tr><Enter><Esc>kf<i
	autocmd FileType php,html inoremap ,th <th></th><Esc>Fhcit
	autocmd FileType php,html inoremap ,tab <table><Enter></table><Esc>O
	autocmd FileType php,html inoremap ,gr <font color="green"></font><Esc>F>a
	autocmd FileType php,html inoremap ,rd <font color="red"></font><Esc>F>a
	autocmd FileType php,html inoremap ,yl <font color="yellow"></font><Esc>F>a
	autocmd FileType php,html inoremap ,dt <dt></dt><Enter><dd></dd><Enter><esc>2kcit
	autocmd FileType php,html inoremap ,dl <dl><Enter><Enter></dl><enter><enter><esc>3kcc
	autocmd FileType php,html inoremap &<space> &amp;<space>

" LATEX
	autocmd FileType tex inoremap ,b  \documentclass{article}<Enter>\begin{document}<Enter><Enter>\end{document}<Enter><Esc>2ki
	autocmd FileType tex inoremap ,t  \title{}<enter>\date{<++>}<Enter>\author{<++>}<Enter><++><Esc>3k7li
	autocmd FileType tex inoremap ,f \pagenumbering{gobble}<Enter>\maketitle<Enter>\newpage<Enter>\pagenumbering{arabic}<enter><Esc>
	autocmd FileType tex inoremap ,s  \section{}<++><Esc>4hi
	autocmd FileType tex inoremap ,ss \subsection{}<++><Esc>4hi
	autocmd FileType tex inoremap ,p  \paragraph{Paragraph}<Esc>
	autocmd FileType tex inoremap ,im \begin{figure}<Enter>  \includegraphics[width=\linewidth]{}<Enter>\caption{<++>}<Enter>\label{<++>}<Enter>\end{figure}<Enter><++><Esc>4k%2li
" }}}

" Helper functions {{{
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0
