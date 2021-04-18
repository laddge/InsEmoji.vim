scriptencoding utf-8

if exists('g:loaded_InsEmoji')
    finish
endif
let g:loaded_InsEmoji = 1

let s:save_cpo = &cpo
set cpo&vim

command! InsEmojiTest call InsEmoji#test()

let &cpo = s:save_cpo
unlet s:save_cpo
