 #!/bin/bash

# Nome da bridge a ser criada
BRIDGE_NAME="br0"

# Função de uso
usage() {
    echo "Uso: sudo $0 <interface_fisica>"
    echo "Exemplo: sudo $0 enp3s0"
    exit 1
}

# Verifica se est\'e1 rodando como root
if [ "$EUID" -ne 0 ]; then
    echo "Este script deve ser executado como root." >&2
    exit 1
fi

# Verifica se o argumento foi passado
if [ -z "$1" ]; then
    echo "Erro: Nenhuma interface foi especificada." >&2
    usage
fi

IFACE="$1"

# Verifica se a interface existe
if ! ip link show "$IFACE" &> /dev/null; then
    echo "Erro: A interface '$IFACE' não existe." >&2
    exit 1
fi

# Cria a bridge se ainda não existir
if ! ip link show "$BRIDGE_NAME" &> /dev/null; then
    echo "Criando bridge $BRIDGE_NAME"
    ip link add name "$BRIDGE_NAME" type bridge
else
    echo "Bridge $BRIDGE_NAME já existe."
fi

# Ativa a bridge
ip link set dev "$BRIDGE_NAME" up

# Adiciona a interface física da bridge
ip link set "$IFACE" master "$BRIDGE_NAME"
ip link set "$IFACE" up

# Desabilita IPv6 no host para essa interface e a bridge
sysctl -w "net.ipv6.conf.$IFACE.disable_ipv6=1"
sysctl -w "net.ipv6.conf.$BRIDGE_NAME.disable_ipv6=1"

echo "Bridge $BRIDGE_NAME criada com sucesso e vinculada à interface $IFACE."
echo "O host não participará da comunicação (sem IP configurado)."
}
