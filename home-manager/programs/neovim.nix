{ config, pkgs, ...}:

let
  folding-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "folding-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "pierreglaser";
      repo = "folding-nvim";
      rev = "5d2b3d98c47c8c16aade06ebfd411bc74ad6d205";
      sha256 = "sha256-LitLBBdGGJltivCRE3Rc33KwM7fs1uqB6+gCXGogw3A=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      neovim-sensible
      nvim-base16

      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-treesitter-context
      #nvim-ts-rainbow

      #nvim-cmp            # completion menu
      #cmp-buffer          # buffer completion source
      #cmp-nvim-lsp        # lsp source
      #cmp-path            # path source
      #cmp-treesitter      # treesitter source
      #cmp-vsnip           # snippets source
      #vim-vsnip

      nvim-lspconfig      # configuring lsp servers
      lsp_signature-nvim  # signature hint while typing
      lspkind-nvim        # pictograms for lsp completion items
      #folding-nvim
      aerial-nvim         # Code outline window
      #tagbar              #   .. another outline
      FixCursorHold-nvim  # recommended for lightbulb
      nvim-lightbulb      # Lightbulb for neovim's built-in LSP

      neoformat           # formatting

      nvim-tree-lua       # file tree

      nvim-web-devicons   # icons

      twilight-nvim       # dim inactive portions of code

      telescope-nvim      # fuzzy find + preview

      indent-blankline-nvim # show indents on blank lines as well

      #nvim-cursorline

      gitsigns-nvim

      lualine-nvim

      bufferline-nvim

      nvim-autopairs
      #neoscroll-nvim

      # languages
      #nim-vim
      #omnisharp-vim
      #kotlin-vim
      #python-mode
      rust-tools-nvim
      #rust-vim
      #vim-csharp
      #vim-fsharp
      #vim-elixir
      #vim-go
      #vim-json
      vim-lua
      vim-nix
      #zig-vim

      #lens-vim
    ];

    extraConfig = ''
      set nocompatible
      set pastetoggle=<F2>
      set clipboard+=unnamedplus

      "-------------------------------------------------------------------------------
      " Turn off paste mode when leaving insert
      "-------------------------------------------------------------------------------
      au InsertLeave * set nopaste

      "-------------------------------------------------------------------------------
      " Mouse
      "-------------------------------------------------------------------------------
      "set mouse=a
      set mouse=v " paste with 3rd button

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
      " toggle file tree
      "-------------------------------------------------------------------------------
      nnoremap <Leader>e :NvimTreeToggle<CR>

      "-------------------------------------------------------------------------------
      " format file
      "-------------------------------------------------------------------------------
      nnoremap <Leader>F :Neoformat<CR>
      vnoremap <Leader>F :Neoformat<CR>

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
      " Make search case insensitive and incremental
      "-------------------------------------------------------------------------------
      set showmatch
      set hlsearch
      set incsearch
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
      " Scrolling
      "-------------------------------------------------------------------------------
      "nnoremap <silent> j jzz
      "nnoremap <silent> k kzz
      set ttyfast
      set cursorline

      "-------------------------------------------------------------------------------
      " filetype plugins
      "-------------------------------------------------------------------------------
      filetype plugin on
      filetype indent on

      "-------------------------------------------------------------------------------
      " syntax
      "-------------------------------------------------------------------------------
      syntax on

      "-------------------------------------------------------------------------------
      " Highlight multiple spaces and trailing whitespace
      "-------------------------------------------------------------------------------
      "set list
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
          let $NVIM_TUI_ENABLE_TRUE_COLOR=1
          set termguicolors
      endif
      set background=dark
      "colorscheme gruvbox
      colorscheme base16-gruvbox-dark-medium

      "-------------------------------------------------------------------------------
      " some suggestions from coc
      "-------------------------------------------------------------------------------
      " TextEdit might fail if hidden is not set
      "set hidden
      " no backup files
      " less delays
      set updatetime=300
      " don't pass messages to |ins-completion-menu|
      set shortmess+=c
      "set signcolumn=yes

      "-------------------------------------------------------------------------------
      " other annoyancies
      "-------------------------------------------------------------------------------
      set nobackup
      set nowritebackup
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
      " some lsp mappings
      "-------------------------------------------------------------------------------
      "nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
      nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
      "nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
      nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
      "nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
      nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
      nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> ga  <cmd>lua vim.lsp.buf.code_action()<CR>

      "-------------------------------------------------------------------------------
      " LUA - bufferline
      "-------------------------------------------------------------------------------
      " see https://github.com/akinsho/bufferline.nvim
      lua << EOF
      require('bufferline').setup{
        numbers = "buffer_id",
        number_style = "subscript",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
      }
      EOF

      "-------------------------------------------------------------------------------
      " LUA - cmp
      "-------------------------------------------------------------------------------
      lua << EOF
      -- local cmp = require('cmp')
      -- -- autocomplete config
      -- cmp.setup {
      --   snippet = {
      --     expand = function(args)
      --       vim.fn['vsnip#anonymous'](args.body)
      --     end,
      --   },
      --   mapping = {
      --     ['<Tab>'] = cmp.mapping.select_next_item(),
      --     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      --     ['<CR>'] = cmp.mapping.confirm({
      --       behavior = cmp.ConfirmBehavior.Replace,
      --       select = true,
      --     })
      --   },
      --   sources = {
      --     { name = 'nvim_lsp' },
      --     { name = 'vsnip' },
      --     { name = 'path' },
      --     { name = 'buffer' }
      --   },
      --   formatting = {
      --     format = require('lspkind').cmp_format({
      --       with_text = true,
      --       menu = {
      --         nvim_lsp = '[LSP]'
      --       },
      --     })
      --   },
      -- }
      EOF

      "-------------------------------------------------------------------------------
      " LUA - lspconfig - omnisharp + vsnip
      "-------------------------------------------------------------------------------
      lua << EOF
      -- local pid = vim.fn.getpid()

      --  Neovim doesn't support snippets out of the box, so we need to mutate the
      --  capabilities we send to the language server to let them know we want snippets.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- require('lspconfig').omnisharp.setup {
      --   -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
      --   on_attach = function(client, bufnr)
      --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      --     -- require('folding').on_attach()
      --   end,
      --   cmd = { "/etc/profiles/per-user/andreas/bin/omnisharp", "--languageserver" , "--hostPID", tostring(pid) },
      -- }
      EOF


      "-------------------------------------------------------------------------------
      " LUA - lspconfig - nim
      "-------------------------------------------------------------------------------
      lua << EOF
      -- require('lspconfig').nimls.setup {
      --   cmd = { '/etc/profiles/per-user/andreas/bin/nimlsp' },
      --   --filetypes = { 'nim' },
      --   --rootdir = require('lspconfig/util').root_pattern('*.nimble'),
      --   --settings = {},
      -- }
      EOF

      "-------------------------------------------------------------------------------
      " LUA - rust tools
      "-------------------------------------------------------------------------------
      " see https://sharksforarms.dev/posts/neovim-rust/
      " Configure LSP through rust-tools.nvim plugin.
      " rust-tools will configure and enable certain LSP features for us.
      " See https://github.com/simrat39/rust-tools.nvim#configuration
      lua <<EOF
      -- local nvim_lsp = require'lspconfig'

      -- local opts = {
      --   tools = { -- rust-tools options
      --     autoSetHints = true,
      --     hover_with_actions = true,
      --     inlay_hints = {
      --       show_parameter_hints = false,
      --       parameter_hints_prefix = "",
      --       other_hints_prefix = "",
      --     },
      --   },

      --   -- all the opts to send to nvim-lspconfig
      --   -- these override the defaults set by rust-tools.nvim
      --   -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
      --   server = {
      --     -- on_attach is a callback called when the language server attachs to the buffer
      --     --on_attach = function(client, bufnr) .. end,
      --     settings = {
      --       -- to enable rust-analyzer settings visit:
      --       -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      --       ["rust-analyzer"] = {
      --         -- enable clippy on save
      --         checkOnSave = {
      --           command = "clippy"
      --         },
      --       }
      --     }
      --   },
      -- }

      -- require('rust-tools').setup(opts)

      require('rust-tools').setup()
      EOF


      "-------------------------------------------------------------------------------
      " LUA - lspconfig - python
      "-------------------------------------------------------------------------------
      lua << EOF
      -- require('lspconfig').pylsp.setup {
      --     cmd = { '/etc/profiles/per-user/andreas/bin/pylsp' },
      -- }
      EOF

      "-------------------------------------------------------------------------------
      " LUA - indent blank line
      "-------------------------------------------------------------------------------
      " see https://github.com/lukas-reineke/indent-blankline.nvim
      lua << EOF

      vim.opt.list = true
      vim.opt.listchars:append("space:⋅")
      vim.opt.listchars:append("eol:↴")

      --vim.opt.termguicolors = true
      --vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      --vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      require("indent_blankline").setup {
        --char = "",
        --char_highlight_list = {
        --    "IndentBlanklineIndent1",
        --    "IndentBlanklineIndent2",
        --},
        space_char_blankline = " ",
        --space_char_highlight_list = {
        --    "IndentBlanklineIndent1",
        --    "IndentBlanklineIndent2",
        --},
        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true
      }
      EOF

      "-------------------------------------------------------------------------------
      " LUA - file tree
      "-------------------------------------------------------------------------------
      " see https://github.com/kyazdani42/nvim-tree.lua
      lua << EOF
      require('nvim-tree').setup {}
      EOF

      "-------------------------------------------------------------------------------
      " LUA - treesitter
      "-------------------------------------------------------------------------------
      " see https://github.com/nvim-treesitter/nvim-treesitter
      lua << EOF
      require('nvim-treesitter.configs').setup {
        -- one of "all" or a list of languages
        ensure_installed = "all",
        -- ensure_installed = { "bash", "c", "c_sharp", "cpp", "css", "go",
        --                    "html", "java", "javascript", "json", "kotlin",
        --                    "latex", "lua", "markdown", "nix", "python", "ruby",
        --                    "rust", "toml", "typescript", "yaml", "zig" },
        -- List of parsers to ignore installing
        -- ignore_install = { },
        highlight = {
          -- false will disable the whole extension
          enable = true,
          -- list of language that will be disabled
          disable = { "nix", "verilog" },
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          -- experimental feature
          enable = true
        },
      }
      EOF

      " 1. enable toggle fold with <Leader>f
      " 2. don't have everything collapsed on file load
      " 3. uncomment treesitter usage for folding
      "set foldmethod=expr
      "set foldexpr=nvim_treesitter#foldexpr()

      "-------------------------------------------------------------------------------
      " Aerial
      "-------------------------------------------------------------------------------
      lua << EOF
      require("aerial").setup({})
      EOF

      "-------------------------------------------------------------------------------
      " Lightbulb
      "-------------------------------------------------------------------------------
      lua << EOF
      require("nvim-lightbulb").setup({
        autocmd = {enabled = true},
        sign = {enabled = true},
        --float = {enabled = true, text = ""},
        --virtual_text = {enabled = false, text = ""},
        --status_text = {enabled = false, text = "", text_unavailable = ""}
      })

      EOF

      "-------------------------------------------------------------------------------
      " LUA - telescope
      "-------------------------------------------------------------------------------
      " see https://github.com/nvim-telescope/telescope.nvim
      lua << EOF
      require('telescope').setup{
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
          },
          prompt_prefix = "> ",
          selection_caret = "> ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              mirror = false,
            },
            vertical = {
              mirror = false,
            },
          },
          file_sorter = require'telescope.sorters'.get_fuzzy_file,
          file_ignore_patterns = {},
          generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
          winblend = 0,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          color_devicons = true,
          use_less = true,
          path_display = {},
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
          file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
          grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
          qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
        }
      }
      EOF

      "-------------------------------------------------------------------------------
      " Twilight
      "-------------------------------------------------------------------------------
      lua << EOF
      require("twilight").setup { }
      EOF
      map <Leader>t :Twilight<CR>

      ""-------------------------------------------------------------------------------
      "" GPS
      ""-------------------------------------------------------------------------------
      "lua << EOF
      "require("nvim-gps").setup()
      "EOF

      "-------------------------------------------------------------------------------
      " lualine
      "-------------------------------------------------------------------------------
      lua << EOF
      --local gps = require("nvim-gps")
      require("lualine").setup({
        sections = {
          --lualine_c = {
          --  { gps.get_location, cond = gps.is_available }
          --},

          lualine_c = { "aerial" }

        }
      })
      EOF
    '';
    #extraConfig = builtins.readfile /tmp/testing/extra.vim;
  };
}
