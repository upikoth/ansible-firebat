# Ansible

1. Устанавливаем ubuntu, в процессе установки настраиваем подключение к интернету
2. На роутере настраиваем статичный ip в локальной сети для устройства
3. Настраиваем ssh подключение к серверу

```shell
ansible-playbook -i inventory.yaml init_openvpn_server.yaml --ask-become-pass

ansible-playbook -i inventory.yaml init_k3s_master.yaml --ask-become-pass

# после выполнения можно скопировать вывод из консоли и создать конфиг клиента echo "..." > client.ovpn
ansible-playbook -i inventory.yaml create_openvpn_client_config.yaml --ask-become-pass --extra-vars="client_name=test"
```
