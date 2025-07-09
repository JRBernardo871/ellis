# 1. Imagem Base
# Usamos uma imagem oficial do Python. A tag 'slim' é uma boa escolha por ser menor que a padrão.
# A versão 3.11 é estável e compatível com o que é pedido no readme.md (3.10+).
FROM python:3.11-slim

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Instalação de Dependências
# Copia primeiro o arquivo de dependências e as instala.
# Isso aproveita o cache do Docker: se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# 4. Copiar Código da Aplicação
# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 5. Expor a Porta
# Informa ao Docker que o contêiner escuta na porta 8000.
EXPOSE 8000

# 6. Comando de Execução
# Comando para iniciar a aplicação com Uvicorn.
# '--host 0.0.0.0' é essencial para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]