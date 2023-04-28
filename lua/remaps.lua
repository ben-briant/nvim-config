-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------------------------
--   Normal mode remaps   --
----------------------------

-- Make switching betweens splits easier
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

-- Open file browser to side
map("n", "<C-b>", ":NERDTreeToggle<CR>")

-- Make double-Esc clear highlights
map("n", "<Esc><Esc>", "<Esc>:noh<CR><Esc>")

-- Comment the current selection
map("n", "<C-_>", ":Commentary<CR><Esc>")

----------------------------
--   Insert mode remaps   --
----------------------------

-- Map shift-tab to unindent
map("i", "<S-Tab>", "<C-d>")
