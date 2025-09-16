nota = int(input('(De 0 a 100)\nDigite a sua nota: ')) # Entrada da nota.

if nota >= 90 and nota <= 100:
    # A regra considera 'Qualidade' para notas acima de 90.
    print(f"\nSua nota foi de {nota}\nRepresenta: \033[32mQualidade!\033[0m\nObrigado pela sua nota!")
elif nota >= 70 and nota <= 89:
    # A regra considera 'Neutro' para a faixa de 70 a 89.
    print(f"\nSua nota foi de {nota}\nRepresenta: \033[33mNeutro!\033[0m\nObrigado pela sua nota!")
elif nota >= 0 and nota < 70:
    # A regra considera 'Insatisfatório' para qualquer nota abaixo de 70.
    print(f"\nSua nota foi de {nota}\nRepresenta: \033[31mInsatisfatório!\033[0m\nObrigado pela sua nota!")
else:
    # Bloco final para pegar qualquer valor inválido (menor que 0 ou maior que 100).
    print(f"\nA nota {nota} é \033[31minválida\033[0m.\nPor favor, digite um valor entre 0 e 100.")