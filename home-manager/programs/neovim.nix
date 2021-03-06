{ pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    extraConfig = ''
      set pastetoggle=<F2>
      set clipboard+=unnamedplus

      "-------------------------------------------------------------------------------
      " Turn off paste mode when leaving insert
      "-------------------------------------------------------------------------------
      au InsertLeave * set nopaste

      "-------------------------------------------------------------------------------
      " Mouse
      "-------------------------------------------------------------------------------
      set mouse=a

      "-------------------------------------------------------------------------------
      " <Leader> key
      "-------------------------------------------------------------------------------
      let mapleader=","

      "-------------------------------------------------------------------------------
      " Learn to move..
      "-------------------------------------------------------------------------------
      nnoremap <Left> :echoe "Use h"<CR>
      vnoremap <Left> :echoe "Use h"<CR>
      nnoremap <Right> :echoe "Use l"<CR>
      vnoremap <Right> :echoe "Use l"<CR>
      nnoremap <Up> :echoe "Use k"<CR>
      vnoremap <Up> :echoe "Use k"<CR>
      nnoremap <Down> :echoe "Use j"<CR>
      vnoremap <Down> :echoe "Use j"<CR>

      "-------------------------------------------------------------------------------
      " Jump to (help-)subject and back
      "-------------------------------------------------------------------------------
      nnoremap ü <C-]>
      nnoremap Ü <C-t>

      "-------------------------------------------------------------------------------
      " faster split resize
      "-------------------------------------------------------------------------------
      map <Leader>+ <esc>:vertical resize +5<CR>
      map <Leader>- <esc>:vertical resize -5<CR>

      "-------------------------------------------------------------------------------
      " new split below/right of current
      "-------------------------------------------------------------------------------
      set splitbelow
      set splitright
      "set diffopt+=vertical
      "silent! set splitvertical

      "-------------------------------------------------------------------------------
      " move between splits
      "-------------------------------------------------------------------------------
      map <Leader>h <C-W><C-H>
      map <Leader>j <C-W><C-J>
      map <Leader>k <C-W><C-K>
      map <Leader>l <C-W><C-L>

      "-------------------------------------------------------------------------------
      " easier buffer switching
      "-------------------------------------------------------------------------------
      map <Leader>n <esc>:bprevious<CR>
      map <Leader>m <esc>:bnext<CR>

      "-------------------------------------------------------------------------------
      " open new (empty) buffer
      "-------------------------------------------------------------------------------
      map <Leader>a <esc>:enew<CR>

      "-------------------------------------------------------------------------------
      " open new vertical split
      "-------------------------------------------------------------------------------
      map <Leader>v <esc>:vnew<CR>

      "-------------------------------------------------------------------------------
      " open new horizontal split
      "-------------------------------------------------------------------------------
      map <Leader>b <esc>:new<CR>

      "-------------------------------------------------------------------------------
      " close current file, but keep buffers intact
      "-------------------------------------------------------------------------------
      map <Leader>x <esc>:bp\|bd #<CR>

      "-------------------------------------------------------------------------------
      " change directory to that of current file
      "-------------------------------------------------------------------------------
      map <Leader>cd :cd %:p:h<CR>

      "-------------------------------------------------------------------------------
      " map sort to a key
      "-------------------------------------------------------------------------------
      vnoremap <Leader>s :sort<CR>

      "-------------------------------------------------------------------------------
      " easier moving of code blocks
      "-------------------------------------------------------------------------------
      vnoremap < <gv
      vnoremap > >gv

      "-------------------------------------------------------------------------------
      " Make search case insensitive
      "-------------------------------------------------------------------------------
      set hlsearch
      set ignorecase
      set smartcase

      "-------------------------------------------------------------------------------
      " Automatically insert \v when searching, for sensible regex matching.
      "-------------------------------------------------------------------------------
      nnoremap <M-/> \v
      vnoremap <M-/> /\v
      nnoremap <M-?> ?\v
      vnoremap <M-?> ?\v

      "-------------------------------------------------------------------------------
      " Keep search matches in the middle of the screen, and pulse the line when moving
      "-------------------------------------------------------------------------------
      nnoremap <silent> n nzz
      nnoremap <silent> N Nzz
      nnoremap <silent> * *zz
      nnoremap <silent> # #zz
      nnoremap <silent> g* g*zz
      nnoremap <silent> g# g#zz

      "-------------------------------------------------------------------------------
      " Clear search highlight
      "-------------------------------------------------------------------------------
      noremap  <silent> <C-n> :nohl<CR>
      vnoremap <silent> <C-n> :nohl<CR>
      inoremap <silent> <C-n> <esc>:nohl<CR>

      "-------------------------------------------------------------------------------
      " Highlight multiple spaces and trailing whitespace
      "-------------------------------------------------------------------------------
      set list
      highlight Whitespace cterm=underline gui=underline ctermfg=94 guifg=#875f00
      au ColorScheme * highlight Whitespace cterm=underline gui=underline ctermfg=94 guifg=#875f00
      " highlight multiple spaces
      au BufWinEnter * call matchadd('Whitespace', '\s\s\+\($\)\@!', -1)
      " highlight trailing whitespace
      au BufWinEnter * call matchadd('ErrorMsg', '\s\+$', -1)

      "-------------------------------------------------------------------------------
      " Set color scheme
      "-------------------------------------------------------------------------------
      if !has('gui_running')
          set t_Co=256
      endif
      set background=dark
      "colorscheme landscape
      "colorscheme despacio
      "colorscheme moonshine
      "colorscheme moonshine_lowcontrast
      "colorscheme moonshine_minimal
      colorscheme gruvbox
      "colorscheme hybrid_material
      "
      "let g:one_allow_italics = 1 " I love italic for comments
      "colorscheme one
      "let g:alduin_Shout_Dragon_Aspect = 1 " almost black
      "colorscheme alduin

      "-------------------------------------------------------------------------------
      " some suggestions from coc
      "-------------------------------------------------------------------------------
      " TextEdit might fail if hidden is not set
      set hidden
      " no backup files
      set nobackup
      set nowritebackup
      " give more space for displaying messages
      set cmdheight=2
      " less delays
      set updatetime=300
      " don't pass messages to |ins-completion-menu|
      set shortmess+=c
      set signcolumn=yes

      "-------------------------------------------------------------------------------
      " other annoyancies
      "-------------------------------------------------------------------------------
      set noswapfile

      "-------------------------------------------------------------------------------
      " linenumbers
      "-------------------------------------------------------------------------------
      set number
      augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
      augroup END

    '';
    #extraConfig = builtins.readfile /tmp/testing/extra.vim;

    plugins = with pkgs.vimPlugins; [
      vim-airline
      gruvbox

      neovim-sensible

      vim-nix
      nim-vim

      coc-nvim
      coc-fzf
      coc-json
      coc-python
      coc-vimtex
      coc-yaml
    ];
  };
}
