#!/bin/bash

source ./utilitarios.sh

echo "Iniciando build de comum..."
cd "$COMUM"
mvn clean install
verificar_status_comando_anterior "comum"

echo "Iniciando build de usuario-servico..."
cd "$USUARIO_SERVICO"
mvn clean install
verificar_status_comando_anterior "usuario-servico"
abrir_relatorio_jacoco_no_vs_code "$USUARIO_SERVICO"

echo "Build de todos os projetos concluído com sucesso!"
