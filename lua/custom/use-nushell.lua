-- https://www.kiils.dk/en/blog/2024-06-22-using-nushell-in-neovim/
vim.o.shell = 'nu'
vim.o.shellcmdflag = '--login --stdin --no-newline -c'
vim.o.shellredir = 'out+err> %s'
vim.o.shellpipe = '| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record'
vim.o.shellxescape = ''
vim.o.shellxquote = ''
vim.o.shellquote = ''
