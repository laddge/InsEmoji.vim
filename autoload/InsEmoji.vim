scriptencoding utf-8
if !exists('g:loaded_InsEmoji')
    finish
endif
let g:loaded_InsEmoji = 1

let s:save_cpo = &cpo
set cpo&vim

function! InsEmoji#InsByName(name)
    let s:jsonpath = expand('<sfile>:p:h') . '/emoji/emoji.json'
    let s:json = ''
    for s:line in readfile(s:jsonpath)
        let s:json = s:json . s:line
    endfor
    let s:dict = js_decode(s:json)
    execute 'let s:code = s:dict.' . a:name
    execute 'normal! i' . nr2char(s:code)
endfunction

function! InsEmoji#test()
  echo "hello, world"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
