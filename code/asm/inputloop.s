    .section    .data
input_msg:
    .ascii   "Insira uma frase (23bits): "
    inputmsg_len = .-input_msg

    .section    .text
    .globl   _start

_start:

    movl    $0x4,           %eax
    movl    $0x1,           %ebx
    movl    $input_msg,     %ecx
    movl    $inputmsg_len,  %edx
    int     $0x80

    movl    $0x3,           %eax
    movl    $0x1,           %ebx
    movl    $input,          %ecx
    movl    $0x18,          %edx
    int     $0x80

    movl    $0x1,           %edi
    jmp     _loop

_loop:

    movl    $0x4,           %eax
    movl    $0x1,           %ebx
    movl    $input,         %ecx
    movl    $0x18,          %edx
    int     $0x80
    
    incl    %edi
    cmpl    $0xa,            %edi
    jg      _end
    jmp     _loop

_end:
    
    movl    $0x1,           %eax
    movl    $0x0,           %ebx
    int     $0x80
    
    .section    .bss

input:
    .skip   25
