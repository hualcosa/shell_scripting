#!/bin/bash

# verifica se o script esta sendo executado com privilegios administrativos
if [[ "${UID}" -ne 0 ]]
then
  echo 'O script precisa ser executado com privilegios administrativos'
  exit 1
fi
# pergunta ao usuario seu username
read -p 'Digite o nome de usuario a ser criado: ' USER_NAME

# pergunta o nome real
read -p 'Digite o nome da pessoa a quem essa conta pertencera: ' COMMENT

# pergunta a senha
read -p 'Digite a senha para essa conta: ' PASSWORD

# cria o usuario
useradd -c "${COMMENT}" -m ${USER_NAME}

# checa se o comando useradd foi executado corretamente
if [[ "${?}" -ne 0 ]]
then
  echo 'Nao foi possivel criar a conta'
  exit 1
fi

# configura a senha
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# checa se a senha foi configurada corretamente
if [[ "${?}" -ne 0 ]]
then
  echo 'Nao foi possivel configurar a senha'
  exit 1
fi

# força a mudança de senha quando do primeiro login
passwd -e ${USER_NAME}

echo
echo "usuario: ${USER_NAME}"
echo "senha incial: ${PASSWORD}"
echo "hostname: ${HOSTNAME}"

exit 0
