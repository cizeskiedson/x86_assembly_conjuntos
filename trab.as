.section .data
    msgInicio:  .asciz  "Bem vindo ao Manipulador de Conjuntos Numericos\n"
    msgTamA:    .asciz  "Informe o tamanho desejado para o vetor A! \n"
    msgTamB:    .asciz  "Informe o tamanho desejado para o vetor B! \n"
    msgOpcao:   .asciz  "Digite o numero da opcao desejada. \n" 
    msgErroOpcao:   .asciz  "Valor invalido! Por favor, digite novamente. \n\n\n"
    msgMenu:    .asciz  "1- Leitura dos Conjuntos\n2- Encontrar Uniao\n3-Encontrar Interseccao\n4-Encontrar Diferenca\n5-Encontrar Complemento\n6- Sair\n"
    msgAvisoMenu: .asciz "Erro! As opcoes 2 a 5 so podem ser acessadas depois da definicao dos vetores pela opcao 1!\n"   
    msgLeVetorA: .asciz  "Leitura do Vetor A, informe os valores.\n"
    msgLeVetorB: .asciz  "Leitura do Vetor B, informe os valores.\n"
    mostraVetorA: .asciz "Vetor A lido:\n"
    mostraVetorB: .asciz "Vetor B lido:\n"
    mostraVetorC: .asciz "Conjunto Uniao:\n"
    mostraInter:    .asciz "Conjunto Interseccao:\n"
    msgSaida:   .asciz  "Encerrando programa...\n"
    msgIguais:  .asciz  "Vetores iguais! Por favor, insira novamente com valores distintos.\n"
    msgDiferentes:  .asciz "Vetores diferentes. Continuando a execucao...\n"
    souBurro:   .asciz  "oi\n"
    pedeNum:    .asciz  "Entre com o numero %d\n"
    tipoIn:     .asciz  "%d"
    tipoOut:    .asciz  " %d"
    pulaLinha:  .asciz  "\n"
    
    num:    .int    0
    opcao:  .int    0
    vetorA: .space  4
    vetorB: .space  4
    vetorC: .space  4
    tamA:   .int    0
    tamB:   .int    0
    tamC:   .int    0
    aux:    .int    0
.section .text

.globl  _start

_start:
    call    _abertura
    call    _menu

_abertura:
    pushl   $msgInicio
    call    printf
    addl    $4, %esp  

    ret  

_menu:
    pushl   $msgMenu
    call    printf

    pushl   $msgOpcao
    call    printf

    pushl   $opcao
    pushl   $tipoIn
    call    scanf

    addl    $12, %esp

    movl    opcao, %eax

    cmpl    $1, %eax
    jne     _opcao2
    call    _leitura
    call    _menu

_opcao2:
    cmpl     $2, %eax
    jne     _opcao3
    call    _uniao
    call    _menu

_opcao3:
    cmpl     $3, %eax
    jne     _opcao4
    call    _interseccao
    pushl   $souBurro
    call    printf
    call    _menu

_opcao4:
    cmpl     $4, %eax
    jne     _opcao5
    call    _diferenca
    call    _menu

_opcao5:
    cmpl     $5, %eax
    jne     _opcao6
    call    _complemento
    call    _menu

_opcao6:
    cmpl     $6, %eax
    je     _saida
    pushl   $msgErroOpcao
    call    printf
    call    _menu

_uniao:
    movl    tamA, %eax
    addl    tamB, %eax
    movl    %eax, tamC
    movl    $4, %ebx
    mull    %ebx
    pushl   %eax 
    call    malloc  
    movl    %eax, vetorC
    addl    $4, %esp
    call    _copiaVetorA
    call    _mostraVetores
    call    _mostraVetorC
    ret

_copiaVetorA:
    movl    tamA, %ecx
    movl    vetorC, %edi
    movl    vetorA, %esi

_loopCopiaA:
    movl    (%esi), %ebx
    movl    %ebx, (%edi)
    addl    $4, %edi
    addl    $4, %esi
    loop    _loopCopiaA

_copiaVetorB:
    movl    tamB, %ecx
    movl    vetorB, %esi

_loopCopiaB:
    movl    (%esi), %ebx
    movl    %ebx, (%edi)
    addl    $4, %edi
    addl    $4, %esi
    loop    _loopCopiaB
    ret

_interseccao:

    pushl   $mostraInter
    call    printf
    movl    vetorA, %edi
    movl    vetorB, %esi
    movl    tamB, %ecx
    movl    tamA, %ebx
    

_loopIgual:
    movl    (%edi), %eax
    movl    (%esi), %edx
    cmpl    %eax, %edx
    je      _mostraIgual
    addl    $4, %esi    
    loop    _loopIgual
    jmp     _verificaVetorA

_mostraIgual:
    
    pushl   %eax
    pushl   $tipoOut
    call    printf
    addl    $4, %esp

    jmp    _verificaVetorA

_verificaVetorA:
    movl    $0, %eax

    cmpl    %eax, %ebx
    jne     _incrementaA

    pushl   $pulaLinha
    call    printf
    addl    $4, %esp

    ret

_incrementaA:
    addl    $4, %edi
    decl    %ebx
    movl    vetorB, %esi
    movl    tamB, %ecx
    jmp     _loopIgual


_diferenca:
    ret

_complemento:
    ret

_leitura:

    cmpl    $0, tamA
    jne     _desalocaVetor

    call    _leTamA
    call    _leTamB

    call    _alocarVetorA
    call    _alocarVetorB

    call    _leVetorA
    call    _leVetorB

    movl      tamA, %eax
    cmpl      %eax, tamB
    jne      _mostraVetores

    call    _comparaVetor

_mostraVetores:
    call    _mostraVetorA
    call    _mostraVetorB

    ret

_leTamA:
    pushl   $msgTamA
    call    printf
    pushl   $tamA
    pushl   $tipoIn
    call    scanf
    addl    $12, %esp
    
    ret

_leTamB:
    pushl   $msgTamB
    call    printf
    pushl   $tamB
    pushl   $tipoIn
    call    scanf
    addl    $12, %esp

    ret

_alocarVetorA:
    movl    tamA, %eax
    movl    $4, %ebx
    mull    %ebx
    pushl   %eax
    call    malloc
    movl    %eax, vetorA
    addl    $4, %esp

    ret 

_alocarVetorB:
    movl    tamB, %eax
    movl    $4, %ebx
    mull    %ebx
    pushl   %eax
    call    malloc
    movl    %eax, vetorB
    addl    $4, %esp

    ret

_leVetorA:
    pushl   $msgLeVetorA
    call    printf
    addl    $4, %esp
    movl    vetorA, %edi
    movl    tamA, %ecx 
    movl    $1, %ebx
    call    _leVet
    ret

_leVetorB:
    pushl   $msgLeVetorB
    call    printf
    addl    $4, %esp
    movl    vetorB, %edi
    movl    tamB, %ecx 
    movl    $1, %ebx
    call    _leVet
    ret

_leVet:
    pushl   %ecx
    pushl   %edi
    pushl   %ebx
    pushl   $pedeNum
    call    printf
    addl    $4, %esp



    pushl   $num
    pushl   $tipoIn
    call    scanf
    addl    $8, %esp


    popl    %ebx
    popl    %edi
    popl    %ecx

    movl    num, %edx
    movl    %edx, (%edi)
    addl    $4, %edi
    incl    %ebx

    loop    _leVet 
    ret

_mostraVetorA:
    pushl   $mostraVetorA
    call    printf
    movl    vetorA, %edi
    movl    tamA, %ecx
    addl    $4, %esp
    call    _mostraVet

    pushl   $pulaLinha
    call    printf
    addl    $4, %esp

    ret

_mostraVetorB:
    pushl   $mostraVetorB
    call    printf
    movl    vetorB, %edi
    movl    tamB, %ecx
    addl    $4, %esp
    call    _mostraVet

    pushl   $pulaLinha
    call    printf
    addl    $4, %esp

    ret

_mostraVetorC:
    pushl   $mostraVetorC
    call    printf
    movl    vetorC, %edi
    movl    tamC, %ecx
    addl    $4, %esp
    call    _mostraVet

    pushl   $pulaLinha
    call    printf
    addl    $4, %esp

    ret

_mostraVet:
    pushl   %edi
    pushl   %ecx
    movl    (%edi), %eax
    pushl   %eax
    pushl   $tipoOut
    call    printf
    
    addl    $8, %esp
    popl    %ecx
    popl    %edi
    addl    $4, %edi


    loop _mostraVet


    ret

_desalocaVetor:
    pushl   vetorA
    call    free

    pushl   vetorB
    call    free

    addl    $8, %esp

    ret

_comparaVetor:
    movl    tamA, %ecx
    movl    vetorA, %edi
    movl    vetorB, %esi

_flagCompara:

    movl    (%edi), %eax
    movl    (%esi), %ebx
    cmpl    %ebx, %eax
    jne     _saoDiferentes
    addl    $4, %edi
    addl    $4, %esi
    loop    _flagCompara

_saoIguais:
    pushl   $msgIguais
    call    printf
    addl    $4, %esp
    call    _leitura

_saoDiferentes:
    pushl   $msgDiferentes
    call    printf
    addl    $4, %esp
    ret

_saida:
    pushl   $msgSaida
    call    printf
    pushl   $0
    call    exit 
