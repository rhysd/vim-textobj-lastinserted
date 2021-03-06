let s:pos_insert_enter = [0, 0, 0, 0]

function! textobj#lastinserted#select_i()
    return s:select('i')
endfunction

function! textobj#lastinserted#select_a()
    return s:select('a')
endfunction

function! s:invalid_buf()
    return s:pos_insert_enter[0] != getpos('.')[0]
endfunction

function! s:char_under_cursor()
    return getline('.')[col('.') - 1]
endfunction

function! s:should_strip_whitespace(motion)
    return a:motion == 'i' && s:char_under_cursor() =~ '\s'
endfunction

function! s:select(motion)
    if s:invalid_buf()
        return 0
    endif

    silent! normal! `.

    if s:should_strip_whitespace(a:motion)
        silent! normal! ge
    endif

    let lst = getpos('.')

    call setpos('.', s:pos_insert_enter)

    if s:should_strip_whitespace(a:motion)
        silent! normal! w
    endif

    let fst = getpos('.')

    if fst == lst
        return 0
    endif

    return [ 'v', fst, lst ]
endfunction

function! textobj#lastinserted#autocmd_insert_enter()
    let s:pos_insert_enter = getpos('.')
endfunction

