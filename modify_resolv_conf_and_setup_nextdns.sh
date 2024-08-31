#!/bin/bash

# Função para modificar o arquivo resolv.conf
modify_resolv_conf() {
    if [ -f /etc/resolv.conf ]; then
        cp /etc/resolv.conf /etc/resolv.conf.bak
        sed -i 's/nameserver 127.0.0.53/nameserver 127.0.0.1/' /etc/resolv.conf
        echo "Arquivo /etc/resolv.conf modificado com sucesso."
    else
        echo "Arquivo /etc/resolv.conf não encontrado."
    fi
}

# Função para verificar se o NextDNS está instalado
check_nextdns() {
    if command -v nextdns &> /dev/null; then
        echo "NextDNS já está instalado."
        return 0
    else
        echo "NextDNS não está instalado."
        return 1
    fi
}

# Função para instalar o NextDNS
install_nextdns() {
    echo "Instalando NextDNS..."
    sh -c "$(curl -sL https://nextdns.io/install)"
}

# Função para configurar o NextDNS
configure_nextdns() {
    echo "Configurando NextDNS..."
    
    # Solicitar o ID de configuração do NextDNS
    read -p "Por favor, insira seu ID de configuração do NextDNS: " config_id
    
    # Configurar o NextDNS com o ID fornecido
    nextdns config set config $config_id
    
    # Ativar o modo de criptografia DNS
    nextdns config set encrypt-dns on
    
    # Aplicar as configurações
    nextdns activate
    
    echo "NextDNS configurado com sucesso."
}

# Função para iniciar o NextDNS
start_nextdns() {
    nextdns start
    echo "NextDNS iniciado com sucesso."
}

# Execução principal
modify_resolv_conf

if check_nextdns; then
    start_nextdns
else
    install_nextdns
    configure_nextdns
    start_nextdns
fi
