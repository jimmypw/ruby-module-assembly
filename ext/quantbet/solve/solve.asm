BITS 64

    global _solve

_solve:
    ; set up the stack
    push            rbp
    mov             rbp,    rsp
    sub             rsp,    0x10

    ; Incoming variables on rdi, rsi and rdx respectively
    ; copy integer a to stack at [rsp+0x00]
    mov             [rsp+0x00], rdi
    ; copy integer b to stack at [rsp+0x04]
    mov             [rsp+0x04], rsi
    ; counter (starting point)
    mov             rcx,    rdx

_loop:
    ; divide integer a [rsp+0x00] by rcx and store the remainder in rdx
    mov             rdx,        0x00
    mov             rax,        [rsp+0x00]
    div             rcx
    ; compare the result. If remainder is not zero jump to _fail
    cmp             rdx,        0x00
    jne             _fail

    ; divide integer b [rsp+0x04] by rcx and store the remainder in rdx
    mov             rdx,        0x00
    mov             rax,        [rsp+0x04]
    div             rcx
    ; compare the result. If remainder is not zero jump to _fail
    cmp             rdx,        0x00
    jne             _fail

    ; Both remainders were zero. Place the current counter in to rax ready to return
    mov             rax, rcx
    jmp             _end

_fail:
    ; decrement rcx, jump back to _loop and try again.
    dec             rcx
    jmp             _loop

_end:
    ; Restore the stack and return
    mov             rsp,    rbp
    pop             rbp
    ret