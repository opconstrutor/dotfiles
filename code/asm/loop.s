    .section    .data
info:
    .ascii   "Loop similar ao while em linguagens de alto nível\n"
    info_len = .-info

repete:
    .ascii   "Repete\t"
    repete_len = .-repete

    .section    .text
    .globl   _start

_start:

    movl    $0x4,        %eax
    movl    $0x1,        %ebx
    movl    $info,       %ecx
    movl    $info_len,   %edx
    int     $0x80

    movl    $0x1,        %edi
    jmp     _loop

_loop:

    movl    $0x4,        %eax
    movl    $0x1,        %ebx
    movl    $repete,     %ecx
    movl    $repete_len, %edx
    int     $0x80
    
    incl    %edi
    cmpl    $0xa,         %edi
    jg      _end
    jmp     _loop

_end:
    
    movl    $0x1,       %eax
    movl    $0x0,       %ebx
    int     $0x80
    
