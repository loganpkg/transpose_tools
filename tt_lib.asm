;
; Copyright (c) 2025 Commonwealth of Australia
;
; Permission to use, copy, modify, and/or distribute this software for any
; purpose with or without fee is hereby granted, provided that the above
; copyright notice and this permission notice appear in all copies.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;


;
; Transpose Tools Library.
;
; Written by Logan Ryan McLintock.
;
; Thanks be to the Father, and to the Son, and to the Holy Spirit, for giving
; me the strength to be the best that I can. All glory and honour is yours,
; forever and ever.
;
; I can do all things through Christ who strengthens me.
;                                   Philippians 4:13 NKJV
;
;
; No system calls are allowed in this file. Assembly style is documented
; in the README.md file.
;


%include "defs.inc"
%include "sys.inc"


section .text
global str_len
global print_str


str_len:
;; Func: str_len: Returns the length of a string excluding the trailing zero.
;; Arg 1: rdi: String.

push rbp
mov rbp, rsp

xor rax, rax

push rdi
push r10

.loop:
    mov r10b, byte [rdi]
    test r10b, r10b
    jz .end

    inc rdi
    inc rax
    jmp .loop

.end:

pop r10
pop rdi

mov rsp, rbp
pop rbp
ret




print_str:
;; Func: print_str: Prints a string.
;; Arg 1: rdi: File descriptor.
;; Arg 2: rsi: String.

push rbp
mov rbp, rsp

push rdx
push rdi
mov rdi, rsi
call str_len
mov rdx, rax
pop rdi

call write
; Pass through error code in rax.

pop rdx

mov rsp, rbp
pop rbp
ret
