# Домашнее задание к занятию 2 «Кластеризация и балансировка нагрузки»


### Задание 1
- Запустите два simple python сервера на своей виртуальной машине на разных портах
- Установите и настройте HAProxy, воспользуйтесь материалами к лекции по [ссылке](2/)
- Настройте балансировку Round-robin на 4 уровне.
- На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

### Ответ 1

[haproxi.cfg](https://github.com/EscEller/netology-homework/blob/main/sflt-02/content/haproxy.cfg)

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sflt-02/content/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sflt-02/content/2.png)

---

### Задание 2
- Запустите три simple python сервера на своей виртуальной машине на разных портах
- Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
- HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
- На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.

### Ответ 2

[haproxy.cfg](https://github.com/EscEller/netology-homework/blob/main/sflt-02/content/haproxy2.cfg)

![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/sflt-02/content/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/sflt-02/content/4.png)
