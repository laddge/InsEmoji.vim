scriptencoding utf-8
if !exists('g:loaded_InsEmoji')
    finish
endif
let g:loaded_InsEmoji = 1

let s:save_cpo = &cpo
set cpo&vim

let g:InsEmoji_jsonpath = fnamemodify(expand('<sfile>:p:h'), ':h') . '/emoji/emoji.json'
let s:jsonpath = expand('<sfile>:p:h') . '/emoji/emoji.json'
let s:json = ''
for s:line in readfile(g:InsEmoji_jsonpath)
    let s:json = s:json . s:line
endfor
let s:dict = js_decode(s:json)

function! InsEmoji#Insert(name) abort
    execute 'let s:code = s:dict.' . a:name
    execute 'normal! i' . nr2char(s:code)
endfunction

function! Callback(id, result) abort
    let l:name = sort(keys(s:dict))[a:result - 1]
    call InsEmoji#Insert(l:name)
endfunction

function! InsEmoji#Popup() abort
    call popup_menu(sort(keys(s:dict)), {'callback': 'Callback'})
endfunction

function! InsEmoji#test()
  echo "hello, world"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
