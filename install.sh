#!/bin/bash

echo -e "
 ██████╗ ██████╗ ███████╗███╗   ██╗     █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗  ██████╗ █████╗  ██████╗ 
██╔═══██╗██╔══██╗██╔════╝████╗  ██║    ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔═══██╗
██║   ██║██████╔╝█████╗  ██╔██╗ ██║    ███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║██║     ███████║██║   ██║
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║    ██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║██║     ██╔══██║██║   ██║
╚██████╔╝██║     ███████╗██║ ╚████║    ██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║╚██████╔╝
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ 
                                                                                                                      "

# Menu
echo "Selecione uma opção:"
echo "1 - Instalar"
echo "2 - Atualizar"

read option

case $option in
    1)
        echo "Atualizando o sistema e adicionando repositórios..."
        apt-get update -y && apt-get upgrade -y
        curl -sL https://deb.nodesource.com/setup_16.x | bash -
        echo "Instalando o NodeJS/Essentials/Gyp/GIT"
        apt-get install -y nodejs npm git build-essential
        echo "Digite a porta (Enter para padrão (5678)):"
            read PORTA
            if [ -z "$PORTA" ]; then
            PORTA=5678
            fi
        echo "Definindo a porta..."
        PORTAATUAL=$(sed -n '4 s/[^0-9]*\([0-9]\+\).*/\1/p' cypress.config.js)
        sed -i 's/$PORTAATUAL/$PORTA/g' package.json cypress.config.js packages/workflow/test/RoutingNode.test.ts packages/editor-ui/src/stores/n8nRootStore.ts packages/editor-ui/package.json cypress/support/commands.ts packages/cli/src/config/schema.ts 
        echo "Continuando a Instalação..."
        npm install
        npm install node-gyp
        npm run build
        npm start
        ;;
    2)
        echo "Atualizando..."
        git pull && rm -rf node_modules && rm -rf package-lock.json && npm install
        ;;
    *)
        echo "Opção inválida."
        ;;
esac