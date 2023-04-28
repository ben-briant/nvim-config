if has("nvim-0.8")
  autocmd BufWritePre *.rs lua vim.lsp.buf.format(nil, 200)
else
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
endif
