set noshowmode
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set smartindent
set scrolloff=8
set number
set relativenumber
set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=99
let javascript_fold=1
let rust_fold=1

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'ms-jpq/coq_nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'jparise/vim-graphql'
Plug 'tomlion/vim-solidity'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'shaunsingh/nord.nvim'
Plug 'itchyny/lightline.vim'

call plug#end()

if exists('$TMUX')
    " Colors in tmux
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme nord
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

let g:coq_settings = { 'auto_start': 'shut-up' }
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
lua << EOF

-- LSP

local lsp_installer = require("nvim-lsp-installer")
local coq = require "coq"

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(coq.lsp_ensure_capabilities(opts))
end)

-- TELESCOPE

require("telescope").setup {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}

EOF

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" LSP maps
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>e :lua vim.diagnostic.open_float()<CR>

" Telescope maps
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ file_ignore_patterns = {'node_modules/.*'} })<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fr :Telescope lsp_references<CR>
nnoremap <leader>fd :Telescope lsp_definitions<CR>
nnoremap <leader>ft :Telescope lsp_type_definitions<CR>
nnoremap <leader>fi :Telescope lsp_implementations<CR>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fS <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

nnoremap <leader>gc :Telescope git_commits<CR>
nnoremap <leader>gg :G<space>
nnoremap <leader>gb :G blame<CR>

nnoremap <leader>dl :diffget //2
nnoremap <leader>dr :diffget //3

nnoremap <leader>so :Telescope lsp_document_symbols<CR>

autocmd Filetype rust setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
