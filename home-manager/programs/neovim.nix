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
      "colorscheme gruvbox
      colorscheme base16-gruvbox-dark-medium

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

      "-------------------------------------------------------------------------------
      " LUA - bufferline
      "-------------------------------------------------------------------------------
      " see https://github.com/akinsho/bufferline.nvim
      lua << EOF
      require("bufferline").setup{
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp"
      }
      EOF


      "-------------------------------------------------------------------------------
      " LUA - lspconfig
      "-------------------------------------------------------------------------------
      " see https://github.com/neovim/nvim-lspconfig
      "lua << EOF
      "local nvim_lsp = require('lspconfig')
      "local servers = { 'tsserver' }
      "for _, lsp in ipairs(servers) do
      "  nvim_lsp[lsp].setup{}
      "end
      "EOF

      "-------------------------------------------------------------------------------
      " LUA - indent blank line
      "-------------------------------------------------------------------------------
      " see https://github.com/lukas-reineke/indent-blankline.nvim
      lua << EOF
      require("indent_blankline").setup {}
      EOF
    '';
    #extraConfig = builtins.readfile /tmp/testing/extra.vim;

    #plugins = with pkgs.vimPlugins; [
    #  neovim-sensible

    #  (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
    #  nvim-treesitter-context
    #  nvim-ts-rainbow

    #  nvim-lspconfig      # configuring lsp servers
    #  nvim-compe          # lsp completion menu
    #  lsp_signature-nvim  # signature hint while typing
    #  lspkind-nvim        # pictograms for lsp completion items

    #  neoformat           # formatting

    #  nvim-tree-lua       # file tree

    #  nvim-web-devicons   # icons

    #  telescope-nvim      # fuzzy find + preview

    #  indent-blankline-nvim # show indents on blank lines as well

    #  galaxyline-nvim
    #  nvim-bufferline-lua

    #  nvim-autopairs
    #  neoscroll-nvim
    #];

    plugins = with pkgs.vimPlugins; [
      neovim-sensible

      gruvbox
      nvim-base16

      nvim-web-devicons

      vim-airline

      nvim-bufferline-lua

      indent-blankline-nvim # show indents on blank lines as well

      gitsigns-nvim

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
