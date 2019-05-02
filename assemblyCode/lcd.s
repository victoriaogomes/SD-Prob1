.equ switches, 0x00003030
.equ leds, 0x00003020

.global _start

_start:
	call set_constants
	call initialize_lcd


# r8 -> delay de 15ms
# r9 -> delay de 4.1ms
# r10 -> delay de 0.1ms
set_constants:
	movia r8, 0xF424
	movia r9, 0x42BB
	movia r10, 0x1A0
	movia r11, 0x0
	movia r12, 0x65B9A
	movia r13, 0x1312D0
	movia r14, 0x30D4
	ret

initialize_lcd:
	call delay_100ms # Delay de 100ms

	movia r16, 0x30 # Function set do display
	call delay_0_1ms
	movia r17, 0x0 # O que vai ser armazenado no PINRS
	call delay_0_1ms
	custom 0, r23, r17, r16 # Definindo modo de uso do lcd
	
	call delay_15ms

	movia r16, 0x30 # Function set do display
	call delay_0_1ms
	custom 0, r23, r17, r16 # Definindo modo de uso do lcd

	call delay_15ms

	movia r16, 0x30
	call delay_0_1ms
	custom 0, r23, r17, r16 # Definindo modo de uso do lcd
	
	call delay_100ms

	movia r16, 0x38 # Function set real do display
	call delay_0_1ms
	custom 0, r23, r17, r16 # Definindo modo de uso do lcd

	call delay_100ms

	movia r16, 0x08 # Código para desligar display
	call delay_0_1ms
	custom 0, r23, r17, r16 # Desligar display

	call delay_100ms

	movia r16, 0x01 # Código para limpar display
	call delay_0_1ms
	custom 0, r23, r17, r16 # limpando display

	call delay_100ms

	movia r16, 0x06 # Código para definir o Entry Mode do lcd
	call delay_0_1ms
	custom 0, r23, r17, r16 # Set Entry Mode -- Cursor increment, display doesn't shift

	call delay_300ms

	movia r16, 0x0E # Código para definir o Entry Mode do lcd
	call delay_0_1ms # Acabou inicialização do LCD, em teoria
	custom 0, r23, r17, r16 # Set Entry Mode -- Cursor increment, display doesn't shift

	call delay_300ms

	movia r17, 0x1 # Mudando PINRS para envio de dados
	call delay_4_1ms

	movia r16, 0x4F # Colocando o hexadecimal da letra "O" no registrador r16
	call delay_4_1ms
	custom 0, r23, r17, r16 # Escrevendo a letra "O" no display
	call delay_100ms

	movia r16, 0x50 # Colocando o hexadecimal da letra "P" no registrador r16
	call delay_4_1ms
	custom 0, r23, r17, r16 # Escrevendo a letra "P" no display
	call delay_100ms

	movia r16, 0x40 # Colocando o hexadecimal da letra "A" no registrador r16
	call delay_4_1ms
	custom 0, r23, r17, r16 # Escrevendo a letra "A" no display
	call delay_300ms

	movia r16, 0x41 # Colocando o hexadecimal da letra "A" no registrador r16
	call delay_4_1ms
	custom 0, r23, r17, r16 # Escrevendo a letra "A" no display
	call delay_300ms

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

delay_300ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r13, delay_300ms # Verifica se r11 armazena mesmo valor que r14 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label

leds_playing:
	movia r2, switches
	movia r3, leds
	LOOP: 
		ldbio r4, 0(r2)
		stbio r4, 0(r3)
		br LOOP
.end
