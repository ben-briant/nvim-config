-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Creates a silent mapping
function smap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, {silent = true})
end

local nvim_lsp = require('lspconfig')

-- Code navigation shortcuts
smap("n", "<c-]>", "vim.lsp.buf.definition()<CR>")
smap("n", "K"    , "<cmd>lua vim.lsp.buf.hover()<CR>")
smap("n", "gD"   , "<cmd>lua vim.lsp.buf.implementation()<CR>")
smap("n", "1gD"  , "<cmd>lua vim.lsp.buf.type_definition()<CR>")
smap("n", "gr"   , "<cmd>lua vim.lsp.buf.references()<CR>")
smap("n", "g0"   , "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
smap("n", "gW"   , "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
smap("n", "gd"   , "<cmd>lua vim.lsp.buf.definition()<CR>")
smap("n", "ga"   , "<cmd>lua vim.lsp.buf.code_action()<CR>")
smap("n", "g["   , "<cmd>lua vim.diagnostic.goto_prev()<CR>")
smap("n", "g]"   , "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- LSP diagnostic toggles
map("n", "<leader>tlu", "<Plug>(toggle-lsp-diag-underline)")
map("n", "<leader>tls", "<Plug>(toggle-lsp-diag-signs)")
map("n", "<leader>tlv", "<Plug>(toggle-lsp-diag-vtext)")
map("n", "<leader>tlp", "<Plug>(toggle-lsp-diag-update_in_insert)")

map("n", "<leader>tld", " <Plug>(toggle-lsp-diag)")
map("n", "<leader>tldd", "<Plug>(toggle-lsp-diag-default)")
map("n", "<leader>tldo", "<Plug>(toggle-lsp-diag-off)")
map("n", "<leader>tldf", "<Plug>(toggle-lsp-diag-on)")


--  Configure LSP through rust-tools.nvim plugin.
--  rust-tools will configure and enable certain LSP features for us.
--  See https://github.com/simrat39/rust-tools.nvim#configuration
local rt = require('rust-tools')

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        },
        on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	end,
    },

}



-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- Server configurations
-- Available here:
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

require('rust-tools').setup(opts)

nvim_lsp['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

nvim_lsp.hls.setup{}

nvim_lsp.bashls.setup{}

nvim_lsp.clangd.setup{}
