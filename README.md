# 🌐 NextDNS Freedom: Surfando a Web Sem ADS e Sem Censura 🚀

Bem-vindo ao NextDNS Freedom! Este repositório é sua chave para uma navegação online limpa e livre. Aprenda a instalar e configurar o NextDNS para eliminar anúncios invasivos e manter sua liberdade digital intacta, independentemente de onde você esteja no mundo. Sem ADS, sem censura, sem limites.

## 🤔 Por que NextDNS?

Porque todos merecemos um espaço digital onde nossas escolhas são respeitadas. Sem ser bombardeado por propagandas ou bloqueado por ditadores e governos autoritários. Com NextDNS, você decide o que vê, o que acessa, e como se protege.

## ✨ Funcionalidades

- 🚫 **Bloqueio de anúncios**: Diga adeus aos pop-ups e propagandas irritantes.
- 🔓 **Proteção contra censura**: Acesse conteúdos sem restrições, de qualquer lugar do planeta.
- 🕵️ **Privacidade**: Seus dados são seus. Não os deixe à mercê de quem quer que seja.

## 🚀 Começando

Pronto para viver uma vida digital sem fronteiras? Siga o guia de instalação e configure o NextDNS em minutos. Desfrute de uma navegação mais limpa, rápida e privada.

### 📥 Instalação

1. Clone este repositório:
   ```
   git clone https://github.com/seu-usuario/nextdns-freedom.git
   ```
2. Navegue até o diretório do projeto:
   ```
   cd nextdns-freedom
   ```
3. Use os scripts fornecidos abaixo para instalar e configurar o NextDNS.

### 🛠️ Scripts

#### Script de Configuração (setup_script.sh)

Este script instala o script principal e configura-o para ser executado no boot.

```bash
#!/bin/bash

# Nome do script
SCRIPT_NAME="modify_resolv_conf_and_setup_nextdns.sh"

# Caminho completo para o script
SCRIPT_PATH="/usr/local/bin/$SCRIPT_NAME"

# Conteúdo do script
cat << 'EOF' > "$SCRIPT_PATH"
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
EOF

# Torna o script executável
chmod +x "$SCRIPT_PATH"

# Adiciona o script ao crontab para ser executado no boot
(crontab -l 2>/dev/null; echo "@reboot $SCRIPT_PATH") | crontab -

echo "Script instalado com sucesso em $SCRIPT_PATH e configurado para executar no boot."
echo "Para executar o script manualmente e completar a configuração do NextDNS, use:"
echo "sudo $SCRIPT_PATH"
```

#### Script Principal (modify_resolv_conf_and_setup_nextdns.sh)

Este é o script principal que modifica o resolv.conf, instala e configura o NextDNS.

```bash
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
```

### 🌍 Uso

1. Salve o conteúdo do script de configuração em um arquivo chamado `setup_script.sh`.
2. Torne o script executável:
   ```
   chmod +x setup_script.sh
   ```
3. Execute o script de configuração com privilégios de superusuário:
   ```
   sudo ./setup_script.sh
   ```
4. O script principal será instalado e configurado para executar no boot.
5. Para executar o script principal manualmente e completar a configuração do NextDNS, use:
   ```
   sudo /usr/local/bin/modify_resolv_conf_and_setup_nextdns.sh
   ```

Uma vez configurado, o NextDNS funcionará silenciosamente em segundo plano, protegendo sua navegação e mantendo sua liberdade digital.

## 🤝 Contribuindo

Sua contribuição é bem-vinda! Se você tem ideias para melhorar o NextDNS Freedom, sinta-se à vontade para abrir uma issue ou enviar um pull request.

## 📜 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

🌟 Aproveite sua liberdade digital com NextDNS Freedom! 🌟
