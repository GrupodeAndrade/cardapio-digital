# Cardápio Digital (pedido por WhatsApp)

Site estático de uma página só. Não precisa de API nem banco de dados.

## Arquivos

- `index.html`: o cardápio inteiro (visual + configuração)
- `Dockerfile`: serve o `index.html` com nginx (usado pelo Coolify)

## Como personalizar para um cliente

Abra o `index.html` e edite só o bloco `CONFIG` (perto da linha 165):

- `nome`, `slogan`, `logo`
- `whatsapp`: só números, com 55 + DDD + número (ex.: `5571999999999`)
- `corPrincipal`
- `entrega` (taxa, pedido mínimo, grátis acima de)
- `pagamentos`, `pixChave`
- `horarios`
- `categorias` e `produtos`

## Deploy no Coolify (VPS InterServer)

### 1. DNS
No painel do seu domínio, crie um registro **A**:

- Nome: `cardapio` (vira `cardapio.seudominio.com.br`)
- Valor: IP da sua VPS

### 2. GitHub
Crie um repositório (ex.: `cardapio-digital`) e envie estes arquivos
(`index.html`, `Dockerfile`, `README.md`).

### 3. Coolify
1. Projects → seu projeto → **+ New Resource**
2. Escolha **Public Repository** (ou Private, se o repositório for privado)
3. Cole a URL do repositório, branch `main`
4. Build Pack: **Dockerfile**
5. Em **Domains**, informe `https://cardapio.seudominio.com.br`
6. Porta exposta: `80`
7. Clique em **Deploy**

O Coolify gera o certificado SSL (Let's Encrypt) sozinho quando o DNS já aponta para a VPS.

### 4. Atualizações
Edite o `index.html`, faça commit no GitHub e o Coolify faz o redeploy
(ative **Auto Deploy** / webhook, ou clique em Deploy manualmente).

## Um site por cliente
Para cada cliente, duplique o repositório (ou uma pasta), troque o bloco `CONFIG`
e crie um novo recurso no Coolify com o subdomínio dele.
