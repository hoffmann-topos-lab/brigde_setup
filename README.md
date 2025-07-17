# Bridge Isolada para Testes com Protótipo de Roteador

Este projeto fornece um script Bash que cria uma bridge de rede entre uma interface física e uma máquina virtual, garantindo que o host não participe da comunicação. É ideal para cenários de teste com protótipos de roteadores ou dispositivos embarcados conectados via Ethernet.

## Objetivo

Permitir que uma VM comunique-se diretamente com um dispositivo conectado à interface física (por exemplo, um roteador em desenvolvimento), sem que o sistema host participe da rede ou interfira no tráfego.

## Requisitos

- Linux com suporte a `iproute2` (`ip`)
- Permissões de root
- Interface física dedicada (por exemplo, `enp3s0`)
- Módulo de bridge carregado (normalmente já está por padrão)

## Instalação

Clone o repositório ou copie o script para seu sistema.

```bash
git clone https://github.com/seuusuario/bridge-isolada.git
cd bridge-isolada
chmod +x criar_bridge.sh

