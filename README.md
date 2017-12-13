# apache-rsync

Este repositório defina uma imagem de apache com rsync e ssh instalados

## Objetivo

Criamos essa imagem para poder testar o deploy em servidores que tem acesso somente por rsync.

O usuário da conta é `ssh_user` e a senha `sshpassword`.

## Como executar

Para rodar a imagem localmente, execute o seguinte comando:

```bash
docker run --rm -it -p 2222:22 -p 8080:80 --name apache_test pevangelista/apache-rsync
```

Com o docker no ar, já é possível executar o comando de rsync:

```bash
rsync -a --delete-after --quiet -e "ssh -p 2222" meu_site/ ssh_user@localhost:public_html/
```

Para acessar o site, acesse http://localhost:8080
