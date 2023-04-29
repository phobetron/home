vim.cmd([[
  comm! W :w                                                                   " Write on accidental shift
  comm! W exec 'w !sudo tee % > /dev/null' | e!                                " Sudo write

  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file

  au BufWritePre * :retab                                                      " Convert tabs to spaces on save
  au BufWritePre * :%s/\s\+$//e                                                " Remove trailing whitespace on save
  au BufWritePre <buffer> lua vim.lsp.buf.format()

  augroup cline                                                                " Only show cursorline in the current window and in normal mode.
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
  augroup END

  au FocusLost * :silent! wall                                                 " Save when losing focus
]])
