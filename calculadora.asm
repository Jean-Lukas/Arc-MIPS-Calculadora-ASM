.data
menu:	.asciiz "Calculadora, entre com um número:  \n1 - Somar\n2 - Subtrair \n3 - Multiplicar \n4 Dividir \n0 Sair Opção \n"
n1:	.asciiz "Entre com o primeiro número: "
n2:	.asciiz "Entre com o segundo número: "
r:	.asciiz "Resultado: "
pula:	.asciiz "\n\n"
close: .asciiz "Finalizado com sucesso!"
.macro pula_linha	# Criando uma macro com a função pula_linha.
li $v0, 4		# imprimir uma string na tela.
la $a0, pula		# string que vai ser imprimida é a variável pula
syscall			# executar instruções.
.end_macro

.macro menu
li $v0, 4
la $a0, menu
syscall
li $v0, 5
syscall
move $t0, $v0		# copiando os dados de $v0 para $t0, isso é necessário para que não se perca os dados em $v0.
.end_macro

.text			# diretiva onde vai conter todo o código.
.globl principal	# definindo a função principal que vai ser executada pela diretiva globl.

principal:		# criando a função principal.
menu			# chamando a função menu da macro.

# condições
beq $t0, 1, somar	# se $t0 == 1 caia no bloco somar.
# bloco somar
beq $t0, 2, subtrair	# se $t0 == 2 caia no bloco subtrair.
# bloco subtrair
beq $t0, 3, multiplicar	# se $t0 == 3 caia no bloco multiplicar.
# bloco multiplicar
beq $t0, 4, dividir	# se $t0 == 4 caia no bloco dividir.
# bloco dividir		
beq $t0, 0, sair	# se $t0 == 0 caia no bloco sair.
# bloco sair

somar:			# definindo a função somar.
li $v0, 4		# imprimir string.
la $a0, n1		# string que vai ser imprimida.
syscall			# executar instruções.
li $v0, 5		# ler um número inteiro digitado pelo usuário.
syscall			# execute.
move $t1, $v0		# cp os dados em $v0 para $t1.

# Pede o segundo número.
li $v0, 4		# imprimir uma string na tela.
la $a0, n2		# ler endereço de memória da variável n2.
syscall			# executar instruções.
li $v0, 5		# ler um inteiro.
syscall			# executando instrução.
move $t2, $v0 		# $t2 = $v0.
add $t3, $t1, $t2	# Soma $t3 = $t1 + $t2.

# Mostra o resultado na tela.
li $v0, 4	
la $a0, r
syscall
li $v0, 1		# imprimir um número inteiro.
la $a0, ($t3)		# $t3 é o número digitado a ser imprimido.
syscall
pula_linha		# chamando a função pula_linha da macro.
j principal		# criando um laço de repetição e voltando pra função principal.

subtrair:		# subtração.
li $v0, 4
la $a0, n1
syscall
li $v0, 5
syscall
move $t1, $v0
# Pede o segundo número.
li $v0, 4
la $a0, n2
syscall
li $v0, 5
syscall
move $t2, $v0
sub $t3, $t1, $t2

# Mostra o resultado na tela.
li $v0, 4
la $a0, r
syscall
li $v0, 1
la $a0, ($t3)
syscall
pula_linha
j principal

multiplicar:
li $v0, 4
la $a0, n1
syscall
li $v0, 5
syscall
move $t1, $v0
# Pede o segundo número.
li $v0, 4
la $a0, n2
syscall
li $v0, 5
syscall
move $t2, $v0
mul $t3, $t1, $t2

# Mostra o resultado na tela
li $v0, 4
la $a0, r
syscall
li $v0, 1
la $a0, ($t3)
syscall
pula_linha
j principal

dividir:	# função dividir.
li $v0, 4
la $a0, n1
syscall
li $v0, 5
syscall
move $t1, $v0
# Pede o segundo número.
li $v0, 4
la $a0, n2
syscall
li $v0, 5
syscall
move $t2, $v0
div $t3, $t1, $t2

# Mostra o resultado na tela.
li $v0, 4
la $a0, r
syscall
li $v0, 1
la $a0, ($t3)
syscall
pula_linha		# chamando a função pula_linha da macro.
j principal		# criando um laço de repetição na função principal.

sair:			
li $v0, 4		# imprimir string
la $a0, close		# chamando a função da macro.
syscall			# executando instrulções.