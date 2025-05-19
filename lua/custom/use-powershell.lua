vim.o.shell = "pwsh"
vim.o.shellquote = ""
vim.o.shellxquote = ""
vim.o.shellcmdflag = "-NoLogo -NoProfile -Command $PSStyle.OutputRendering=[System.Management.Automation.OutputRendering]::PlainText;Remove-Alias -Name tee -Force -ErrorAction SilentlyContinue;"
vim.o.shellpipe = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.o.shellredir = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'