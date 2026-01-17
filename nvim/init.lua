-- Neovim Configuration (init.lua)
-- This is a starter configuration. Expand as needed!

-- Basic Settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.mouse = 'a'                -- Enable mouse support
vim.opt.ignorecase = true          -- Ignore case in search
vim.opt.smartcase = true           -- Unless uppercase is used
vim.opt.hlsearch = false           -- Don't highlight searches
vim.opt.wrap = true                -- Wrap lines
vim.opt.breakindent = true         -- Preserve indentation in wrapped text
vim.opt.tabstop = 2                -- Tab width
vim.opt.shiftwidth = 2             -- Indent width
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.termguicolors = true       -- True color support
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.updatetime = 250           -- Faster completion
vim.opt.timeoutlen = 300           -- Faster key sequence completion
vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard
vim.opt.undofile = true            -- Persistent undo
vim.opt.cursorline = true          -- Highlight current line
vim.opt.scrolloff = 8              -- Keep 8 lines above/below cursor

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Key Mappings
local keymap = vim.keymap.set

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize windows
keymap('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
keymap('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
keymap('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
keymap('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Better indenting
keymap('v', '<', '<gv', { desc = 'Indent left' })
keymap('v', '>', '>gv', { desc = 'Indent right' })

-- Move text up and down
keymap('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move text down' })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move text up' })

-- Clear search highlight
keymap('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })

-- Save file
keymap('n', '<C-s>', ':w<CR>', { desc = 'Save file' })

-- Quit
keymap('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- File explorer (netrw)
keymap('n', '<leader>e', ':Explore<CR>', { desc = 'Open file explorer' })

-- Plugin Manager Setup (lazy.nvim)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theme: Tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Status Line: Lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'tokyonight' }
      })
    end,
  },

  -- Fuzzy Finder: Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    end,
  },

  -- Syntax Highlighting: Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3', -- Pin to v0.9.3 to avoid breaking changes in master
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "python", "javascript", "toml", "markdown" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },
  
  -- Keybinding Helper: WhichKey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
})

-- Auto commands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd('BufWritePre', {
  group = augroup('trim_whitespace', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

print("Neovim config loaded! 🚀 Plugins will install on restart.")
