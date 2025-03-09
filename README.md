# Ansible

1. Устанавливаем ubuntu, в процессе установки настраиваем подключение к интернету
2. На роутере настраиваем статичный ip в локальной сети для устройства
3. Настраиваем ssh подключение к серверу

## Инициализация openvpn и получение конфига для клиента 
```shell
ansible-playbook -i inventory.yaml init_openvpn_server.yaml --ask-become-pass

# после выполнения можно скопировать вывод из консоли и создать конфиг клиента echo "..." > client.ovpn
ansible-playbook -i inventory.yaml create_openvpn_client_config.yaml --ask-become-pass --extra-vars="client_name=test"
```

## Настройка мастер ноды k3s

```shell
ansible-playbook -i inventory.yaml init_k3s_master.yaml --ask-become-pass
```

После установки argocd:

```shell
# получаем начальный пароль для того, чтобы залогиниться в argocd
argocd admin initial-password -n argocd

kubectl get svc

git clone https://github.com/upikoth/argocd-firebat.git
cd argocd-firebat

kubectl apply -f applicationset.yaml
```

```shell
# как получить сертификат (можно просто из браузера взять значение)
# после получения нужно запустить файл cert.crt, добавить в систему, разрешить все
kubectl get secret argocd-certificate -n argocd -o jsonpath="{.data.tls\.crt}" | base64 --decode > cert.crt
```

## TODO

- убрать ручные действия настройки argocd
