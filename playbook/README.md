# Домашнее задание к занятию 1 «Введение в Ansible»

1. some_fact имеет значение 12

```bash
stade@stade-A320M-H:~/work/ansible/playbook$ ansible-playbook site.yml -i inventory/test.yml 
```
```bash
TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}
```
2. Отредактировал ./group_vars/all/examp.yml
3. Подготовил почву для экспериментов
```
docker run -tid --name centos7 centos:7
docker run -tid --name ubuntu ubuntu
```
4. В контейнер с ubuntu пришлось доставить python. Зафиксировал значения.

```sh
TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}
```

5. Поменял значения в group_vars

6. Повторный запуск 

```sh
TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
```

7. Шифрую
```
stade@stade-A320M-H:~/work/ansible/playbook$ ansible-vault encrypt ./group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful

stade@stade-A320M-H:~/work/ansible/playbook$ ansible-vault encrypt ./group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
```

8. Добавил флаг --ask-vault-pass, playbook отработал корректно
```yml
ansible-playbook site.yml --ask-vault-pass -i inventory/prod.yml 
```

9. ansible.builtin.apt_repository подойдет для работы на control_node

    P.S. Возможно не правильно понял вопрос.

10. Добавил

```yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```

11, 

```sh
TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

```

12. push main

## Необязательные задания

1. Выполнил дешифровку 

```sh
stade@stade-A320M-H:~/work/ansible/playbook/group_vars$ ansible-vault decrypt deb/examp.yml 
Vault password: 
Decryption successful
stade@stade-A320M-H:~/work/ansible/playbook/group_vars$ ansible-vault decrypt el/examp.yml 
Vault password: 
Decryption successful
```

2. Зашифровал значение

```yml
stade@stade-A320M-H:~/work/ansible$ ansible-vault encrypt_string 
New Vault password: 
Confirm New Vault password: 
Reading plaintext input from stdin. (ctrl-d to end input, twice if your content does not already have a newline)
PaSSw0rd        
Encryption successful
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          37623063643230643039346237323565366336633930356366656164346236633065323139356365
          3133343263303266626238316434663665613533666662330a666235376334663836333161376566
          62613464626333653061316538343739653838366138616130356237666432376530656133366432
          3538323666353433650a313230393665353231383464393839393331393332663362623938663730
          3439
```
4. ansible-playbook site.yml --ask-vault-pass -i inventory/prod.yml

```yml
TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd\n"
}
```
5. script.sh прикладываю в репу