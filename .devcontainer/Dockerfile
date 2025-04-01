# Imagem base com Java 21
FROM openjdk:21-slim

# Instala dependências básicas para desenvolvimento e operação
# - Ferramentas de build (Maven)
# - Controle de versão (Git)
# - Utilitários (vim, curl, etc)
RUN apt-get update && apt-get install -y \
    maven \
    git \
    git-flow \
    vim \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Docker CLI (para integração com Docker a partir do container)
# Necessário para usar a comunicação com host
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli

# Define diretório de trabalho padrão
WORKDIR /workspace

# Copia todo o conteúdo do projeto para o container
COPY . .

# Comando padrão ao executar o container
CMD ["bash"]
