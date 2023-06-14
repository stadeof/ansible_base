#!/bin/bash
docker run -tid --name centos7 centos:7
docker run -tid --name ubuntu python # ну а что?
ansible-playbook site.yml --vault-password-file ./vault_pass.txt -i inventory/prod.yml && docker rm -f ubuntu centos7 