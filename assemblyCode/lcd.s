.equ switches, 0x00003030
.equ leds, 0x00003020

.global _start

_start:
	call set_constants
	call initialize_lcd


# r8 -> delay de 15ms
# r9 -> delay de 4.1ms
# r10 -> delay de 0.1ms
# r11 -> contador
# r12 -> delay de 100ms
# r13 -> 0.53ms
# r14 -> espaçamento de 16 vezes

set_constants:
	movia r8, 0xF424
	movia r9, 0x42BB
	movia r10, 0x1A0
	movia r11, 0x0
	movia r12, 0x65B9A
	movia r13, 0x1312D0
	movia r14, 0x10
	movia r15, 0x0
	ret

initialize_lcd:

	call delay_100ms # Delay de 100ms quando o LCD é ligado

	movia r16, 0x30 # Function set do LCD
	call delay_0_1ms # Delay de 0.1ms
	movia r17, 0x0 # O que vai ser armazenado no PINRS
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set do LCD
	
	call delay_15ms # Delay de 15ms

	movia r16, 0x30 # Function set do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set do LCD

	call delay_15ms # Delay de 15ms

	movia r16, 0x30 # Function set do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set do LCD
	
	call delay_100ms # Delay de 100ms

	movia r16, 0x38 # Function set real do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set do LCD

	call delay_100ms # Delay de 100ms

	movia r16, 0x08 # Código para desligar o LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Desligar LCD

	call delay_100ms # Delay de 100ms

	movia r16, 0x01 # Código para limpar LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Limpando LCD

	call delay_100ms # Delay de 100ms

	movia r16, 0x06 # Código para definir o Entry Mode Set do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo Entry Mode Set do LCD

	call delay_0_053ms # Delay de 0.53ms

	movia r16, 0x0E # Código para ligar o LCD
	call delay_0_1ms # Acabou inicialização do LCD
	custom 0, r23, r17, r16 # Enviando o código para ligar o LCD

	call delay_0_053ms # Delay de 0.53ms

	movia r17, 0x1 # Mudando PINRS para envio de dados
	call delay_4_1ms # Delay de 4.1ms

	movia r16, 0x78 # Colocando o hexadecimal da letra "x" no registrador r16
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Escrevendo a letra "x" no display
	call delay_100ms # Delay de 100ms

	movia r16, 0x27 # Colocando o hexadecimal do símbolo "'" no registrador r16
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Escrevendo o símbolo "'" no display
	call delay_100ms # Delay de 100ms

	movia r17, 0x0 # Mudando PINRS para envio de instruções
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xC0 # Código para mudar cursor para segunda linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para segunda linha
	call delay_100ms # Delay de 100ms
	
	movia r17, 0x1 # Mudando PINRS para envio de dados
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x4F # Colocando o hexadecimal da letra "O" no registrador r16
	call delay_4_1ms
	custom 0, r23, r17, r16 # Escrevendo a letra "O" no display
	call delay_0_053ms

	custom 0, r23, r17, r16 # Escrevendo a letra "O" no display
	call delay_0_053ms

	call leds_playing


delay_15ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r8, delay_15ms # Verifica se r11 armazena mesmo valor que r8 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label

delay_4_1ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r9, delay_4_1ms # Verifica se r11 armazena mesmo valor que r9 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # retorna para a rotina que chamou essa label

delay_0_1ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r10, delay_0_1ms # Verifica se r11 armazena mesmo valor que r10 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label

delay_100ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r12, delay_100ms # Verifica se r11 armazena mesmo valor que r12 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label

delay_0_053ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r13, delay_0_053ms # Verifica se r11 armazena mesmo valor que r13 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label

loop_space:
	custom 0, r23, r17, r16 # Escrevendo o caractere de espaço no display
	call delay_0_053ms # Delay de 4.1ms
	addi r15, r15, 1 # Adiciona 1 no registrador r15
	bne r15, r14, loop_space # Verifica se r15 armazena mesmo valor que r14 (se não, volta pro início do looping)
	addi r15, r0, 0 # Zera o registrador r15
	ret # Retorna para a rotina que chamou essa label

leds_playing:
	movia r2, switches
	movia r3, leds
	LOOP: 
		ldbio r4, 0(r2)
		stbio r4, 0(r3)
		br LOOP
.end
