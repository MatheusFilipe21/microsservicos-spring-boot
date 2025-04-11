#!/bin/bash

source ./utilitarios.sh

echo "Iniciando build de comum..."
cd "$COMUM"
mvn clean install
verificar_status_comando_anterior "comum"
abrir_relatorio_jacoco_no_vs_code "$COMUM"

echo "Build de todos os projetos concluído com sucesso!"
