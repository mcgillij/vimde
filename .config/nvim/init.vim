" mcgillij vim config for mostly Python / Bash and Terraform
" Is made to be run within TMUX with a companion IPython
"
" running a :checkhealth to see that everything you need is installed and
" configured properly
"
" Notes: Leader key is ( , )
"
" Some common key combinations enabled by this configuration.
" ,<space> will bring the NERDTree file view
" ,ff will open the fuzzy file search
" ,fg fuzzy grep
" ,fb fuzzy buffer
" ,ec will edit this configuration file
" ,sc will reload this configuration
" <Tab> and <Shift><Tab> will cycle splits
" <Ctrl-c> will send selection to IPython if running with TMUX
"
"
" Basic configuration
" change the leader key from "\" to ","
let mapleader=","

set list " show white space
set spell " use spellchecking
set listchars=tab:~-,trail:∙,eol:$ " whitespace charmap

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab for python
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
"set mouse=r                 " enable mouse click
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim

" Python Neovim venv
" Neovim recommends you create a virtual env just for installing the neovim and pynvim modules, so you don't need to add them to each of your projects dev dependencies.
"
" I just created a directory named, nvim-venv and then ran the following
" poetry commands: 
" mkdir -p ~/nvim-venv && \
" cd nvim-venv && \
" poetry init -n && \
" poetry add neovim
"
" and then I just pasted the link for it here.
" Use :checkhealth to make sure it's done correctly.
let g:python3_host_prog = expand('~/.cache/pypoetry/virtualenvs/nvim-venv-zUWStWUI-py3.10/bin/python3.10')

" Plugin and their Dependencies
"
" ripgrep is required for telescope
" fd is required for telescope
"
" node is required for Copilot and LspInstall
" pyenv for the python LSP
" tmux for working with vim-slime
"
" Most of these can be installed with :PlugInstall
" with the exception of vim-slime, I had to manually clone the repo in the
" ~/.config/nvim/plugged/ directory
"
call plug#begin()
" code stealing as a service
Plug 'github/copilot.vim'
" some nice colors
Plug 'dracula/vim'
" Some icons 
Plug 'ryanoasis/vim-devicons'
" required by some of the other plugins
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" File browser
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
" start page
Plug 'mhinz/vim-startify'
" LSP installer / configuration
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
" Some python / git niceties
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'jpalardy/vim-slime'
" Telescope fzf like searching
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'stevearc/dressing.nvim' " goes with telescope
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
" Buffer bar
Plug 'romgrk/barbar.nvim'
" Bottom evilline
Plug 'nvim-lualine/lualine.nvim'
" Helper for showing command keys after 500ms delay
Plug 'folke/which-key.nvim'
call plug#end()

" color schemes
if (has("termguicolors"))
set termguicolors
endif
"syntax enable
colorscheme dracula

" vim-slime configuration
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_python_ipython = 1
let g:slime_no_mappings = 1
" Ctrl-c to send selected text to ipython
xmap <C-c> <Plug>SlimeRegionSend
nmap <C-c> <Plug>SlimeMotionSend
nmap <C-c> <Plug>SlimeLineSend

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Window shenans
"open new split panes to right and below
set splitright
set splitbelow
" Remap <Tab>/<Shift><Tab> to toggle between windows
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W
"tnoremap <Esc> <C-\><C-n>
"
" Edit ~/.config/nvim/init.vim: ,ec
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Reload the configuration file after editing it: ,sc
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" Utilsnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" NerdTree with: ,<space>
nnoremap <silent> <Space> :NERDTreeToggle<CR>
tnoremap <Esc> <C-\><C-n>

" Plugin configurations made in lua
" These could all be added to a separate plugin file since they are mostly
" just copy / pasted default configurations, but for the sake of having a one
" line init.vim I left them in here.
"
lua << EOF
-- pyright LSP setup
require'lspconfig'.pyright.setup{}
-- which-key setup
require("which-key").setup {}

-- lualine setup
local lualine = require('lualine')

-- Color table for highlights
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- lualine config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

-- LSP-Installer
require("nvim-lsp-installer").setup {}
-- LSP Config
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'terraformls', 'bashls', 'tflint', 'dockerls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
