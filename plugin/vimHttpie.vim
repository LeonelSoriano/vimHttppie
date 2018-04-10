if exists("vim_httpie_leonelsoirano3")
    finish
endif
let vim_httpie_leonelsoirano3 = 1

"initialization
"=============================
if !exists('g:vimHttppieBrowser')
  let g:vimHttppieBrowser = "firefox"
endif

if !exists('g:vim_httppie_base')
  let g:vim_httppie_base = "https://jsonplaceholder.typicode.com"
endif

if !exists('g:vim_httppie_base_token')
  let g:vim_httppie_base_token = "localhost"
endif

if !exists('g:vim_httppie_base_token_response')
  let g:vim_httppie_base_token_response = "token"
endif

"=============================

"constant
"==========================

    "nombre del bufffer que se abre
    let s:nameBuffer = "Httpie"
    "nombre del archivo temporal
    let s:nameTmpFile = "./tmp/tmp.html"
"======================

"===========
"var
"======================
    "texto que guarda la salida de httpie
    let s:outputHttp = ""
"==================


" substitute(l:bar, "world", "kitten", "")



function! s:OnEvent(job_id, data, event) abort
    "echo s:data
    "echo a:event
    "call s:isLoadin()
    if a:event == 'stdout'
        let s:outputHttp = a:data
    elseif a:event == 'stderr'
        let s:outputHttp = a:data
    elseif a:event == 'exit'

        try
            let decodejson = json_decode(s:outputHttp)
            exe "%d"
            call append(line('$'), s:outputHttp)
            exe "d1"
        catch
            if g:vimHttppieBrowser is 0
                let decodejson = json_decode(s:outputHttp)
                exe "%d"
                call append(line('$'), s:outputHttp)
                exe "d1"
            else
                let concatArray = ""
                for i in s:outputHttp
                  let concatArray .= i
                endfor


                call s:makeTmpForBrowser(concatArray)
                exe "silent !". g:vimHttppieBrowser ." " . s:nameTmpFile
                exe "%d"
            endif
        endtry
        let s:outputHttp = ""
    else
        "let str = a:data
    endif

    "call append(line('$'), str)
endfunction


    let s:callbacks = {
    \ 'on_stdout': function('s:OnEvent'),
    \ 'on_stderr': function('s:OnEvent'),
    \ 'on_exit': function('s:OnEvent')
\ }


fun! Httpie(...)
    let args = split(a:1, ',')

    let argsLen = len(args)

    let l:apiUrl = ""

    "si la peticion tiene menos de dos es decir el primero es em metodo el segund
    "debe ser la url o el base
    if (argsLen < 2)
        echohl ErrorMsg
        echo "httpie Error: "
        echohl None
        echon 'debes tener por lo menos el metodo y la url en ese orden'
        return
    endif
    
    if(substitute(args[1], "\"",'','g') ==? "base")
        let l:apiUrl .=  g:vim_httppie_base
        "aca cone l cuerpo
        if(argsLen > 2)
            let l:apiUrl .= substitute(args[2], "\"",'','g')
        endif
    else
        if(argsLen > 1)
            let l:apiUrl .= substitute(args[1], "\"",'','g')
        endif
    endif
    echo l:apiUrl
    call s:open_win_preview()
   "let job1 = jobstart(['bash'], extend({'shell': 'shell 1'}, s:callbacks))
    let job2 = jobstart(['sh', '-c', 'http '. args[0] ." ".  l:apiUrl .
                \ '  --ignore-stdin --verbose  --print=b  '], extend({'shell': 'shell'}, s:callbacks))

"echo job2

"echo system("http GET  https://github.com/  --verbose")
      "echo myList[1]
  endfun
com! -nargs=+ Httpie :call Httpie('<f-args>')


function s:open_win_preview()
    "au QuickFixCmdPre * hi Search ctermbg=white
    "lexpr system('http GET https://jsonplaceholder.typicode.com/posts/1')
    "echo(responseDate)
    "lopen
    let before_win = bufnr("%")

    silent! exe "noautocmd botright pedit Httpie"
    noautocmd wincmd P
    "exe "file Httpie" 
    set nohidden
    set ft=json
    set buftype=nofile
    "put = printf("%s",P)
    "exe "noautocmd r "
    noautocmd wincmd P

    let current_buff = bufnr("%")
    "call append(line("."), strftime("%c"))
    call append(line("."), "LOADING")
    exe "d1"
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
    "put = printf("%s",P)
    exe "noautocmd r! ".a:cmd
    noautocmd wincmd P

    if g:vimHttppieBrowser isnot  0
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

    if filereadable("./tmp/tmp.html") == 0
        exe "silent! !touch ./tmp/tmp.html"
    endif

    exe "silent! !echo ". shellescape(a:content, 1) ."> " . "/home/leonel/.vim/plugged/vimHttppie/tmp/tmp.html"
endfun
