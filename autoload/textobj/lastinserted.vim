let s:pos_insert_enter = [0, 0, 0, 0]

function! textobj#lastinserted#select_i()
    return s:select('v')
endfunction

function! textobj#lastinserted#select_a()
    return s:select('V')
endfunction

function! s:invalid_buf()
    return s:pos_insert_enter[0] != getpos('.')[0]
endfunction

function! s:invalid_region(first, last)
    if first[1] > last[1]
        return 1
    elseif first[1] == last[1]
        if first[2] >= last[2]
            return 1
        endif
    endif
    return 0
endfunction

function! s:select(motion)

    if s:invalid_buf()
        throw "Last inserted buffer is not current buffer."
    endif

    let first = getpos("'^")
    let last = s:pos_insert_enter

    if s:invalid_region(first, last)
        throw "Previous inserted region is invalid."
    endif

    return [ a:motion, first, last ]
endfunction

function! textobj#lastinserted#autocmd_insert_enter()
    let s:pos_insert_enter = getpos('.')
endfunction

