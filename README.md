# Bridge Isolada para Testes com Protótipo de Roteador

Este projeto fornece um script Bash que cria uma bridge de rede entre uma interface física e uma máquina virtual, garantindo que o host não participe da comunicação. É ideal para cenários de teste com protótipos de roteadores ou dispositivos embarcados conectados via Ethernet.

## Objetivo

Permitir que uma VM comunique-se diretamente com um dispositivo conectado à interface física (por exemplo, um roteador em desenvolvimento), sem que o sistema host participe da rede ou interfira no tráfego.

## Aviso

- Este script modifica a configuração de rede do sistema. Use com cuidado.
- As alterações não são persistentes após reinicialização, a menos que sejam automatizadas via systemd, scripts de boot ou arquivos de configuração como /etc/network/interfaces (em sistemas baseados em Debian) ou perfis do NetworkManager.
  
## Requisitos

- Linux com suporte a `iproute2` (`ip`)
- Permissões de root
- Interface física dedicada (por exemplo, `enp3s0`)
- Módulo de bridge carregado (normalmente já está por padrão)

## Instalação

Clone o repositório ou copie o script para seu sistema.

```bash
git clone https://github.com/seuusuario/brigde_setup.git
cd bridge-isolada
chmod +x criar_bridge.sh
```


## Uso
```
sudo ./criar_bridge.sh <interface_física>
```

## Exemplo 
```
sudo ./criar_bridge.sh enp3s0
```
Isso irá:

1 - Criar uma bridge chamada br0 (se ainda não existir).
2 - Associar a interface física enp3s0 à bridge.
3 - Ativar a bridge e a interface.
4 - Desativar IPv6 no host para evitar qualquer atribuição de IP.
5 - Importante: Nenhum endereço IP será atribuído à interface ou à bridge no host, garantindo isolamento.

## Integração com a VM

Configure sua máquina virtual (por exemplo, com VirtualBox, QEMU, libvirt, etc.) para usar a bridge br0 como adaptador de rede. A VM será então a única parte do sistema com acesso à rede do protótipo conectado à interface física.





