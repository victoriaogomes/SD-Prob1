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

	call state_zero
	# call leds_playing




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

line_one:
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4
	stw r31, 0(r27)
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x80 # Código para mudar cursor para primeira linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para primeira linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

line_two:
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4
	stw r31, 0(r27)
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xC0 # Código para mudar cursor para segunda linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para segunda linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

line_three:
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4
	stw r31, 0(r27)
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x94 # Código para mudar cursor para terceira linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para terceira linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

line_four:
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4
	stw r31, 0(r27)
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xD4 # Código para mudar cursor para quarta linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para quarta linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

leds_playing:
	movia r2, switches
	movia r3, leds
	LOOP: 
		ldbio r4, 0(r2)
		stbio r4, 0(r3)
		br LOOP



# ASCII: M=0x4d  E=0x45  N=0x4e  U=0x55  0=0x30 1=0x31 2=0x32 3=0x33 4=0x34 -=0x2D >=0x3E

state_zero: # Estado inicial (Todas as labels 'state' possuem lógica parecida então só vou comentar essa)
	call clear_lcd

	call line_one

	movia r2, switches # Acho que isso é para pegar os endereços dos leds e swirches
	movia r3, leds

	call write_arrow #desenha uma seta na opção selecionada

	call write_menu # função que escreve literalmente "MENU"
	movia r16, 0x30 # Move o caractere "0" para r16
	call write # chama a função que escreve no lcd o que está em r16
	call line_two # função que supostamente pula uma linha

	call write_menu 
	movia r16, 0x31 # Caractere "1"
	call write
	call line_three

	call write_menu
	movia r16, 0x32 # Caractere "2"
	call write
	call line_four

	call write_menu
	movia r16, 0x33 # Caractere "3"
	call write
	call write

	call loop_zero # chama a label que contém o loop que irá esperar por comandos dos botões

state_one: 
	call clear_lcd

	call line_one

	call write_menu
	movia r16, 0x30 # Caractere "0"
	call write
	call line_two

	call write_arrow

	call write_menu
	movia r16, 0x31 # Caractere "1"
	call write
	call line_three

	call write_menu
	movia r16, 0x32 # Caractere "2"
	call write
	call line_four
	

	call write_menu
	movia r16, 0x33 # Caractere "3"
	call write
	call write
	

	call loop_one

state_two:
	call line_one
	call write_menu
	movia r16, 0x30 # Caractere "0"
	call write
	call line_two

	call write_menu
	movia r16, 0x31 # Caractere "1"
	call write
	call line_three

	call write_arrow

	call write_menu
	movia r16, 0x32 # Caractere "2"
	call write
	call line_four

	call write_menu
	movia r16, 0x33 # Caractere "3"
	call write
	call write

	call loop_two

state_three:
	call clear_lcd

	call line_one
	call write_menu
	movia r16, 0x30 # Caractere "0"
	call write
	call line_two

	call write_menu
	movia r16, 0x31 # Caractere "1"
	call write
	call line_three

	call write_menu
	movia r16, 0x32 # Caractere "2"
	call write
	call line_four

	call write_arrow

	call write_menu
	movia r16, 0x33 # Caractere "3"
	call write
	call write
	
	call loop_three

state_four:
	call clear_lcd

	call line_one
	call write_menu
	movia r16, 0x31 # Caractere "1"
	call write
	call line_two

	call write_menu
	movia r16, 0x32 # Caractere "2"
	call write
	call line_three

	call write_menu
	movia r16, 0x33 # Caractere "3"
	call write
	call line_four

	call write_arrow

	call write_menu
	movia r16, 0x34 # Caractere "4"
	call write
	call write
	
	call loop_four

# ------------------------------------------------------- labels de loop
loop_zero:
	movia r18, 0x8 # move o valor 8 para r18. r18 é usado para acender o led correspondente a opção do menu
	ldbio r4, 0(r2) # carrega o valor do button em r4 (acho)

	movia r15, 0x7 # usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_one

	movia r15, 0xD
	beq r4, r15, leds_on

	br loop_zero # caso seja apertado uma combinação errada, ele volta a esperar

loop_one:
	movia r18, 0x4
	ldbio r18, 0(r2)

	movia r15, 0x7
	beq r4, r15, state_two

	movia r15, 0xB
	beq r4, r15, state_zero

	movia r15, 0xD
	beq r4, r15, leds_on

	br loop_one

loop_two:
	movia r18, 0x2
	ldbio r4, 0(r2)

	movia r15, 0x7
	beq r4, r15, state_three

	movia r15, 0xB
	beq r4, r15, state_one

	movia r15, 0xD
	beq r4, r15, leds_on

	br loop_two

loop_three:
	movia r18, 0x1
	ldbio r4, 0(r2)

	movia r15, 0x7
	beq r4, r15, state_four

	movia r15, 0xB
	beq r4, r15, state_two

	movia r15, 0xD
	beq r4, r15, leds_on
	br loop_three

loop_four:
	movia r18, 0x3
	ldbio r4, 0(r2)

	movia r15, 0xB
	beq r4, r15, state_three

	movia r15, 0xD
	beq r4, r15, leds_on

	br loop_four


# --------------------------------------------------------
leds_on: # label para acender um led
	addi r27, r27, -4
	stw r31, 0(r27)
	stbio r18, 0(r3)
	movia r15, 0xE
	led_loop:
		ldbio r4, 0(r2)
	 	bne r4, r15, led_loop
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

write: # função para escrever no LCD o valor do registrador r16
	addi r27, r27, -4
	stw r31, 0(r27)
	custom 0, r23, r17, r16
	call delay_4_1ms
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret
write_menu: # função para escrever "MENU"
	addi r27, r27, -4
	stw r31, 0(r27)
	movia r16, 0x4D # Caractere "M"
	call write

	movia r16, 0x45 # Caractere "E"
	call write

	movia r16, 0x4E # Caractere "N"
	call write

	movia r16, 0x55 # Caractere "U"
	call write

	ldw r31, 0(r27)
	addi r27, r27, 4
	ret
	
clear_lcd:
	addi r27, r27, -4
	stw r31, 0(r27)
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	movia r16, 0x01 # Código para limpar LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Limpando LCD
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

write_arrow: # função para escrever "->"
	addi r27, r27, -4
	stw r31, 0(r27)
	movia r16, 0x2D # Caractere "-"
	call write

	movia r16, 0x3E # Caractere ">"
	call write
	ldw r31, 0(r27)
	addi r27, r27, 4
	ret

.end # ----------------------------- FIM DO ARQUIVO