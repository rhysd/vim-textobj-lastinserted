if exists('g:loaded_textobj_lastinserted')
    finish
endif

call textobj#user#plugin('lastinserted', {
            \ '-' : {
            \       'select-a' : 'au', '*select-a-function*' : 'textobj#lastinserted#select_a',
            \       'select-i' : 'iu', '*select-i-function*' : 'textobj#lastinserted#select_i'
            \    }
            \ })

augroup TextobjLastInserted
    autocmd!
    autocmd InsertEnter * call textobj#lastinserted#autocmd_insert_enter()
augroup END

let g:loaded_textobj_lastinserted = 1
