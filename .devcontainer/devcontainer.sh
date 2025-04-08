#!/bin/bash
echo "Iniciando configuração do ambiente de desenvolvimento..."

echo "Verificando se a rede dev-network existe..."
docker network ls | grep dev-network >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Rede dev-network já existe."
else
    echo "Criando rede dev-network..."
    docker network create dev-network
fi

echo "Iniciando containers..."
docker compose -f .devcontainer/docker-compose.yml down
docker compose -f .devcontainer/docker-compose.yml up -d

echo "Verificando versões..."
java -version
mvn --version
git --version

echo "Inicialização concluída com sucesso!"
