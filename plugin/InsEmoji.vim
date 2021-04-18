scriptencoding utf-8

if exists('g:loaded_InsEmoji')
    finish
endif
let g:loaded_InsEmoji = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 -complete=customlist,CompName InsEmojiByName call InsEmoji#InsByName(<f-args>)
command! InsEmojiTest call InsEmoji#test()

function! CompName(lead, line, pos)
    let s:jsonpath = expand('<sfile>:p:h') . '/emoji/emoji.json'
    let s:json = ''
    for s:line in readfile(s:jsonpath)
        let s:json = s:json . s:line
    endfor
    let s:dict = js_decode(s:json)
    return keys(s:dict)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
