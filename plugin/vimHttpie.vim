if exists("vim_httpie_leonelsoirano3")
    finish
endif
let vim_httpie_leonelsoirano3 = 1

"initialization
"=============================
    if !exists('g:vimHttppieBrowser')
      let g:vimHttppieBrowser = "firefox"
    endif
"=============================

"constant
"==========================

    "nombre del bufffer que se abre
    let s:nameBuffer = "Httpie"
    "nombre del archivo temporal
    let s:nameTmpFile = "./tmp/tmp.html"
"======================


function! Hola()
    au QuickFixCmdPre * hi Search ctermbg=white
    lexpr system('http GET https://jsonplaceholder.typicode.com/posts/1')
    "echo(responseDate)
    lopen
endfunction



fun! Runcmd(cmd)
    "let dict = json_decode("{\"hola\":  \"hola\"}")
    "echo(dict["hola"])

    silent! exe "noautocmd botright pedit ".a:cmd
    noautocmd wincmd P
    exe "file" s:nameBuffer
    set nohidden
    set ft=json
    set buftype=nofile
    "put = printf("%s","2")
    "noautocmd r! ".a:cmd
    noautocmd wincmd P
     
    if g:vimHttppieBrowser isnot 0
        call s:makeTmpForBrowser("<html><body>hola</body></html>")
        exe "silent !". g:vimHttppieBrowser ." " . s:nameTmpFile
    endif
endfun
"com! -nargs=1 Runcmd :call Runcmd("<args>")
"lexpr system('date')

fun s:makeTmpForBrowser(content)
    if(!isdirectory("./tmp"))
        call mkdir("./tmp", "p")
    endif

    "if filereadable("./tmp/tmp.html")
    "    !touch .tmp
    "endif
    exe "silent! !echo ". string(a:content) ."> " . s:nameTmpFile
endfun
