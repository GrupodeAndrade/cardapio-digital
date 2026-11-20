# Cardápio Digital (pedido por WhatsApp), versão multi-cliente

Site estático. Não precisa de API nem banco de dados.
Um único código serve vários clientes: cada cliente tem seu arquivo de configuração.

## Estrutura

- `index.html`: o cardápio (visual e lógica). Não precisa mexer para cada cliente.
- `editor.html`: editor visual que gera o arquivo de cada cliente
- `clientes/<nome>.json`: a configuração de cada cliente (nome, logo, cor, WhatsApp, produtos...)
- `nginx.conf` e `Dockerfile`: servem o site (usados pelo Coolify)

## Links

- `https://cardapio.gda.app.br/` abre o cliente `demo`
- `https://cardapio.gda.app.br/?c=exemplo-padaria` abre `clientes/exemplo-padaria.json`
- Se o arquivo não existir, aparece "Cardápio não encontrado".

O nome do cliente no link só aceita letras minúsculas, números e hífen (ex.: `padaria-do-ze`).

## Editor visual (editor.html)

Em vez de mexer no JSON à mão, abra `https://cardapio.gda.app.br/editor.html`:

1. Digite o nome do cliente e clique em **Carregar** (ou **Novo cliente**, para começar em branco)
2. Edite dados, entrega, horários, categorias e produtos; a prévia ao lado atualiza na hora
3. Clique em **Editar no GitHub** (cliente existente) ou **Criar no GitHub** (cliente novo): o JSON é copiado
4. No GitHub, apague o conteúdo, cole (Ctrl+A, Ctrl+V) e clique em **Commit changes**
5. No Coolify, clique em **Redeploy**

O editor avisa em vermelho se algo estiver errado (WhatsApp inválido, produto sem preço, categoria repetida)
e só deixa salvar quando estiver tudo certo. Ele não grava nada sozinho: só gera o arquivo.
A página não é indexada pelo Google (`noindex`), mas o endereço é público; ela não contém dados sensíveis.

## Como criar um novo cliente (à mão)

1. No GitHub, entre na pasta `clientes/`
2. Abra `exemplo-padaria.json` → **copiar** (ou **Add file → Create new file**) e salve como `padaria-do-ze.json`
3. Edite os campos do cliente:
   - `nome`, `slogan`, `logo` (emoji ou endereço de imagem)
   - `whatsapp`: só números, com 55 + DDD + número
   - `corPrincipal`: cor em hexadecimal (ex.: `#8d5524`)
   - `entrega`, `pagamentos`, `pixChave`, `horarios`
   - `categorias` e `produtos` (cada produto precisa de um `id` único dentro do cliente)
4. **Commit changes**
5. No Coolify, clique em **Redeploy**
6. Envie ao cliente o link `https://cardapio.gda.app.br/?c=padaria-do-ze`

Atenção: o JSON é rigoroso. Use aspas duplas, vírgula entre itens e **sem vírgula depois do último item**.
Se o cardápio sumir, o erro mais provável é uma vírgula ou aspa faltando; valide em jsonlint.com.

## Frete por região

No arquivo do cliente, o frete é configurado em `entrega.zonas`. O cliente escolhe a região no pedido:

```json
"entrega": {
  "ativa": true,
  "pedidoMinimo": 15,
  "zonas": [
    { "nome": "Bairros comuns", "taxa": 5, "gratisAcimaDe": 60 },
    { "nome": "Orla", "aCombinar": true, "descricao": "Frete calculado pelo comércio e informado no WhatsApp." }
  ]
}
```

- `taxa`: valor fixo da região (`0` = grátis)
- `gratisAcimaDe`: pedido a partir do qual a taxa zera (`0` ou omitir = desativado)
- `aCombinar: true`: o frete não entra no total; a mensagem do WhatsApp avisa "frete a combinar" e o comércio informa o valor (útil para a orla, tipo app de corrida)
- `descricao`: texto de ajuda abaixo da lista (opcional)
- Com uma região só, a lista não aparece para o cliente.
- O formato antigo (`taxa` e `gratisAcimaDe` direto em `entrega`) continua funcionando.

## Deploy no Coolify

1. Novo recurso → **Public Repository** → URL do repositório
2. Build Pack: **Dockerfile**, porta `80`
3. Domínio: `https://cardapio.gda.app.br`
4. **Deploy**

## Próximos passos (segunda versão)

Hoje cada arquivo `clientes/<nome>.json` é a configuração de um cliente. Quando existir o painel
Super Admin do GDA Soluções, esses mesmos dados passam a vir do banco de dados, e o dono do
comércio edita preço e produto sozinho, sem GitHub e sem redeploy.
