def sqrt_nr(x, i):
    # Caso base: quando i = 0, retorna 1
    if i == 0:
        return 1

    # Caso recursivo: calcula com base no resultado anterior
    prev_sqrt = sqrt_nr(x, i-1)
    return (prev_sqrt + x/prev_sqrt) / 2

def main():
    print("Programa de Raiz Quadrada – Newton-Raphson")
    print("Desenvolvedores: Humberto Corrêa Gomes")

    while True:
        print("\nDigite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução")

        try:
            x = int(input("Digite o valor de x: "))
            if x < 0:
                print("Programa encerrado.")
                break

            i = int(input("Digite o número de iterações i: "))
            if i < 0:
                print("Programa encerrado.")
                break

            # Calcula a raiz quadrada usando o método Newton-Raphson
            result = sqrt_nr(x, i)
            print(f"sqrt({x}, {i}) = {int(result) if result.is_integer() else result}")

        except ValueError:
            print("Por favor, digite apenas números inteiros.")
        except ZeroDivisionError:
            print("Erro: divisão por zero ocorreu durante o cálculo.")

if __name__ == "__main__":
    main()