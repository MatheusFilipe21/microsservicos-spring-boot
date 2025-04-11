#!/bin/bash

set -e

echo "Iniciando configuração do ambiente de desenvolvimento..."

CAMINHO_WORKSPACE=$(pwd)
CAMINHO_SQLS="$CAMINHO_WORKSPACE/.devcontainer/sqls"
ARQUIVO_COMPOSE="$CAMINHO_WORKSPACE/.devcontainer/docker-compose.yml"
ARQUIVO_SQL_INICIAL="$CAMINHO_SQLS/inicializacao.sql"

REDE_DOCKER="dev-network"
CONTAINER_BANCO="postgres"
USUARIO_BANCO="mfnp"
NOME_BANCO="postgres"

echo "Verificando se a rede $REDE_DOCKER existe..."
docker network inspect "$REDE_DOCKER" >/dev/null 2>&1 || {
    echo "Criando rede $REDE_DOCKER..."
    docker network create "$REDE_DOCKER"
}

echo "Iniciando containers..."
docker compose -f "$ARQUIVO_COMPOSE" down
docker compose -f "$ARQUIVO_COMPOSE" up -d

echo "Aguardando o PostgreSQL aceitar conexões..."
until docker exec "$CONTAINER_BANCO" pg_isready -U "$USUARIO_BANCO" >/dev/null 2>&1; do
    sleep 2
done

if [ -f "$ARQUIVO_SQL_INICIAL" ]; then
    echo "Executando script de inicialização do banco..."
    docker exec -i "$CONTAINER_BANCO" psql -U "$USUARIO_BANCO" -d "$NOME_BANCO" < "$ARQUIVO_SQL_INICIAL"
else
    echo "Arquivo de inicialização do banco não encontrado: $ARQUIVO_SQL_INICIAL"
fi

echo "Verificando versões..."
java -version
mvn --version
git --version

echo "Inicialização concluída com sucesso!"
