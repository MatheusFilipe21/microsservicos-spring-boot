#!/bin/bash

# Diretórios
CAMINHO_WORKSPACE=/workspaces/microsservicos-spring-boot
COMUM="$CAMINHO_WORKSPACE/comum"
USUARIO_SERVICO="$CAMINHO_WORKSPACE/usuario-servico"

# Função para verificar o status do comando anterior
verificar_status_comando_anterior() {
    if [ $? -ne 0 ]; then
        echo "Erro no build de $1. Abortando."
        exit 1
    fi
}

# Função para abrir o relatório JaCoCo no VS Code
abrir_relatorio_jacoco_no_vs_code() {
    local projeto_dir="$1"
    local relatorio_html="$projeto_dir/target/site/jacoco/index.html"

    if [ -f "$relatorio_html" ]; then
        echo "Abrindo relatório JaCoCo no VS Code..."
        code -r -g "$relatorio_html"
    else
        echo "Relatório JaCoCo não encontrado em: $relatorio_html"
    fi
}