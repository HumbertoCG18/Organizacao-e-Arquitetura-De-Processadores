# Programa de Raiz Quadrada - Newton-Raphson Recursivo

# Função recursiva para calcular a raiz quadrada usando Newton-Raphson
def sqrt_nr(x, i):
    # Caso base: i = 0, retorna 1
    if i == 0:
        return 1

    # Caso recursivo: i > 0
    # Calcula o valor anterior
    prev_sqrt = sqrt_nr(x, i-1)

    # Calcula x / sqrt_nr(x, i-1)
    divisao = x // prev_sqrt  # Usando divisão inteira como no Assembly

    # Calcula (sqrt_nr(x, i-1) + x/sqrt_nr(x, i-1))
    soma = prev_sqrt + divisao

    # Divide por 2 (como o shift right no Assembly)
    resultado = soma // 2

    return resultado

# Função principal
def main():
    # Mensagens iniciais
    print("Programa de Raiz Quadrada – Newton-Raphson")
    print("Desenvolvedor: Humberto Corrêa Gomes")

    while True:
        # Prompt principal
        print("\nDigite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução")

        # Leitura de x
        print("Digite o valor de x: ", end="")
        x = int(input())

        # Verifica se deve encerrar
        if x < 0:
            print("Programa encerrado.")
            break

        # Leitura de i
        print("Digite o número de iterações i: ", end="")
        i = int(input())

        # Verifica se deve encerrar
        if i < 0:
            print("Programa encerrado.")
            break

        # Chama a função sqrt_nr
        resultado = sqrt_nr(x, i)

        # Exibe resultado
        print(f"sqrt({x}, {i}) = {resultado}")

# Executa o programa principal
if __name__ == "__main__":
    main()