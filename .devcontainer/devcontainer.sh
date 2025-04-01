#!/bin/bash
echo "Iniciando containers..."
docker compose -f .devcontainer/docker-compose.yml down
docker compose -f .devcontainer/docker-compose.yml up -d

echo "Verificando versões..."
java -version
mvn --version
git --version

echo "Inicialização concluída com sucesso!"
