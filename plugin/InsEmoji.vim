scriptencoding utf-8

if exists('g:loaded_InsEmoji')
    finish
endif
let g:loaded_InsEmoji = 1

let s:save_cpo = &cpo
set cpo&vim

let g:InsEmoji_jsonpath = fnamemodify(expand('<sfile>:p:h'), ':h') . '/emoji/emoji.json'

command! -nargs=1 -complete=customlist,CompName InsEmoji call InsEmoji#Insert(<f-args>)
command! InsEmojiPopup call InsEmoji#Popup()
command! InsEmojiMenu call InsEmoji#Menu()
command! InsEmojiTest call InsEmoji#test()

function! CompName(lead, line, pos) abort
    let s:json = ''
    for s:line in readfile(g:InsEmoji_jsonpath)
        let s:json = s:json . s:line
    endfor
    let s:dict = js_decode(s:json)
    return sort(keys(s:dict))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
