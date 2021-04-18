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

function! s:emojing(name) abort
    execute 'let s:code = s:dict.' . a:name
    return nr2char(s:code)
endfunction

function! InsEmoji#Insert(name) abort
    execute 'normal! i' . s:emojing(a:name)
endfunction

function! MenuEnter(num) abort
    execute "bw"
    let l:name = sort(keys(s:dict))[a:num - 1]
    call InsEmoji#Insert(l:name)
endfunction

function! InsEmoji#Menu() abort
    silent new InsEmojiMenu
    setlocal buftype=nofile bufhidden=wipe noswapfile nonumber buflisted cursorline
    redraw
    let s:title = []
    for l:name in sort(keys(s:dict))
        let l:append = s:emojing(l:name) . ' ' . l:name
        call add(s:title, l:append)
    endfor
    call setline(1, s:title)
    exec "nnoremap <silent> <buffer> <CR> :call MenuEnter(line('.'))<CR>"
    setlocal nomodifiable
endfunction

function! InsEmoji#test()
  echo "hello, world"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
