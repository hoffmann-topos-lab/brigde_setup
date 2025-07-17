{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
\
# Nome da bridge a ser criada\
BRIDGE_NAME="br0"\
\
# Fun\'e7\'e3o de uso\
usage() \{\
    echo "Uso: sudo $0 <interface_f\'edsica>"\
    echo "Exemplo: sudo $0 enp3s0"\
    exit 1\
\}\
\
# Verifica se est\'e1 rodando como root\
if [ "$EUID" -ne 0 ]; then\
    echo "Este script deve ser executado como root." >&2\
    exit 1\
fi\
\
# Verifica se o argumento foi passado\
if [ -z "$1" ]; then\
    echo "Erro: Nenhuma interface foi especificada." >&2\
    usage\
fi\
\
IFACE="$1"\
\
# Verifica se a interface existe\
if ! ip link show "$IFACE" &> /dev/null; then\
    echo "Erro: A interface '$IFACE' n\'e3o existe." >&2\
    exit 1\
fi\
\
# Cria a bridge se ainda n\'e3o existir\
if ! ip link show "$BRIDGE_NAME" &> /dev/null; then\
    echo "Criando bridge $BRIDGE_NAME..."\
    ip link add name "$BRIDGE_NAME" type bridge\
else\
    echo "Bridge $BRIDGE_NAME j\'e1 existe."\
fi\
\
# Ativa a bridge\
ip link set dev "$BRIDGE_NAME" up\
\
# Adiciona a interface f\'edsica \'e0 bridge\
ip link set "$IFACE" master "$BRIDGE_NAME"\
ip link set "$IFACE" up\
\
# Desabilita IPv6 no host para essa interface e a bridge\
sysctl -w "net.ipv6.conf.$IFACE.disable_ipv6=1"\
sysctl -w "net.ipv6.conf.$BRIDGE_NAME.disable_ipv6=1"\
\
echo "Bridge $BRIDGE_NAME criada com sucesso e vinculada \'e0 interface $IFACE."\
echo "O host n\'e3o participar\'e1 da comunica\'e7\'e3o (sem IP configurado)."\
}