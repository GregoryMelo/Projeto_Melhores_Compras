import json

# (Item c) Lista para armazenar os produtos cadastrados.
produtos = []

# (Item b) Função lambda para calcular 18% de ICMS.
calcula_icms = lambda valor: valor * 0.18

print("--- Cadastro de Produtos ---")

# (Item c) Loop principal para cadastrar múltiplos produtos.
while True:
    print("\n--- Novo Produto ---")

    # (Item a) Solicita as informações do produto ao usuário.
    descricao = input("Digite a descrição do produto: ").strip().title() # remove espaços e coloca inicial maiúscula.
    if not descricao: # (Tratamento Opcional) Tratamento que impede o usuario de prosseguir sem inserir a descrição.
        print('[\033[91mERRO!\033[0m] Campo vazio, a descrição não pode ficar vazia. Por favor, tente novamente.')
        continue

    # (Item d) Tratamento de erro específico se o valor não for um número.
    try:
        valor_produto = float(input("Digite o valor do produto: R$"))

        # (Tratamento Opcional) Tratamento que impede o usuario de inserir valores negativos como '-10'.
        if valor_produto <= 0:
            print('[\033[91mERRO!\033[0m] Valor inválido, o valor deve ser um numero positivo. Por favor, tente novamente.')
            continue

    except ValueError:
        print("\n[\033[91mERRO!\033[0m] O valor do produto deve ser um número. Por favor, tente novamente.")
        continue

    tipo_embalagem = input("Digite o tipo de embalagem: ").strip().title() # novamente remove espaços e coloca inicial maiúscula.

    if not tipo_embalagem: # (Tratamento Opcional) Tratamento que impede o usuario de prosseguir sem inserir a embalagem.
        print('[\033[91mERRO!\033[0m] Campo vazio, o tipo de embalagem não pode ficar vazio. Por favor, tente novamente.')
        continue

    # Usa a função lambda e armazena os dados do produto direto em um dicionário.
    produtos.append({
        "descrição_produto": descricao,
        "valor_produto": valor_produto,
        "tipo_embalagem": tipo_embalagem,
        "valor_icms": round(calcula_icms(valor_produto), 2)
    })

    print(f"[\033[32msucesso!\033[0m] Produto '\033[36m{descricao}\033[0m' cadastrado com sucesso!")

    print("\nProdutos cadastrados até agora:")
    for i, p in enumerate(produtos, start=1):
        print(f"{i}. {p['descrição_produto']} - R${p['valor_produto']:.2f} ({p['tipo_embalagem']})")

    # Valida a resposta do usuário para continuar (s) ou parar (n).
    while True:
        resposta = input("\nDeseja cadastrar um novo produto? (s/n): ").strip().lower() # remove espaços e coloca a letra minúscula.
        if resposta in ['s', 'n']:
            break
        else:
            print("[\033[91mERRO!\033[0m] Opção inválida. Por favor, digite 's' para sim ou 'n' para não.")

    if resposta == 'n':
        break
print("\n--- Fim do Cadastro ---")

def salvar_produtos(produtos, arquivo='1_5_arquivo_produto.json'):
    ''' Função usada para salvar os produtos em um arquivo JSON '''
    try:
        with open(arquivo, 'w', encoding='utf-8') as f:
            json.dump(produtos, f, indent=4, ensure_ascii=False)
        print(f"Arquivo '{arquivo}' gerado com sucesso com {len(produtos)} produtos.")
    except Exception as e:
        print(f"Ocorreu um erro ao gerar o arquivo JSON: {e}")

# (Item e) Ao final, verifica se o mínimo de 5 produtos foi inserido.
if len(produtos) >= 5:
    salvar_produtos(produtos)
else:
    print(f"\n[\033[33mAtenção!\033[0m] São necessários no mínimo 5 produtos para gerar o arquivo. Você cadastrou apenas {len(produtos)} produto(s).")