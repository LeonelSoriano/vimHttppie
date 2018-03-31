

let s:nameBuffer = "Httpie"
function! Hola()
    au QuickFixCmdPre * hi Search ctermbg=white
    lexpr system('http GET https://jsonplaceholder.typicode.com/posts/1')
    "echo(responseDate)
    lopen
endfunction




fun! Runcmd(cmd)

    silent! exe "noautocmd botright pedit ".a:cmd
    noautocmd wincmd P
    exe "file" s:nameBuffer
    set nohidden
    set ft=json
    set buftype=nofile
    exe "noautocmd r! ".a:cmd
    noautocmd wincmd p

endfun
"com! -nargs=1 Runcmd :call Runcmd("<args>")
"lexpr system('date')
