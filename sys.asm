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
; System calls for Transpose Tools.
;
; Written by Logan Ryan McLintock.
;
; This is the only file that is allowed to make direct system calls.
;


%include "defs.inc"


%ifidn __OUTPUT_FORMAT__, win64
    %define arg_5 rsp + 32

    ; Maximum shaddow space needed, as a multiple of 16-bytes.
    MAX_HOME_SPACE equ 6 * 8

    STD_OUT_HDL equ -11
    INVALID_HDL equ -1

%else
    EXIT_SYS_CALL_NUM equ 60
    WRITE_SYS_CALL_NUM equ 1
%endif




; Do not know what volatile registers will get clobbered by a system call,
; so will need to backup and restore all of them. Both versions of the macros
; below have an even number of pushes, so they will not break the 16-byte
; alignment.
%ifidn __OUTPUT_FORMAT__, win64
    %macro backup 0
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
    %endmacro

    %macro restore 0
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
    %endmacro

    %macro restore_backup 0
        restore
        sub rsp, 6 * 8 ; Undo the increments from the pops.
    %endmacro

%else
    %macro backup 0
        push rdi
        push rsi
        push rdx
        push rcx
        push r8
        push r9
        push r10
        push r11
    %endmacro

    %macro restore 0
        pop r11
        pop r10
        pop r9
        pop r8
        pop rcx
        pop rdx
        pop rsi
        pop rdi
    %endmacro

    %macro restore_backup 0
        restore
        sub rsp, 8 * 8 ; Undo the increments from the pops.
    %endmacro
%endif




section .text
%ifidn __OUTPUT_FORMAT__, win64
    extern ExitProcess
    extern GetStdHandle
    extern WriteFile
%endif

global exit
global write




exit:
;; Func: exit: Exits this process.
;; Arg 1: rdi: Error code.

and rsp, ~ 0xf ; Force 16-byte stack alignment.

%ifidn __OUTPUT_FORMAT__, win64
    mov rcx, rdi
    call ExitProcess
%else
    mov rax, EXIT_SYS_CALL_NUM
    syscall
%endif




write:
;; Func: write: Writes data.
;; Arg 1: rdi: File descriptor.
;; Arg 2: rsi: Pointer to data.
;; Arg 3: rdx: Size in bytes.
;; Return: rax: Success 0, Error 1.

push rbp
mov rbp, rsp

; Local variables.
%ifidn __OUTPUT_FORMAT__, win64
    push 0 ;; Local Variable: rbp - 8: Bytes written.
%endif

and rsp, ~ 0xf

%ifidn __OUTPUT_FORMAT__, win64
    backup
    sub rsp, MAX_HOME_SPACE
    mov rcx, STD_OUT_HDL
    call GetStdHandle
    add rsp, MAX_HOME_SPACE
    restore_backup
    cmp rax, INVALID_HDL
    je .error

    sub rsp, MAX_HOME_SPACE
    mov rcx, STD_OUT_HDL
    mov r8, rdx
    mov rdx, rsi

    ; Bytes written.
    mov r9, rbp
    sub r9, 8

    mov [arg_5], byte 0
    call WriteFile
    add rsp, MAX_HOME_SPACE
    restore
    test rax, rax
    jz .error
    cmp [rbp - 8], rdx
    jne .error

%else
    backup
    mov rax, WRITE_SYS_CALL_NUM
    syscall
    restore
    cmp rax, rdx
    jne .error
%endif

; Success.
xor rax, rax

.end:
mov rsp, rbp
pop rbp
ret

.error:
mov rax, ERROR
jmp .end
