#  Дипломная работа по профессии «Системный администратор»

# Содержание
- [Задача](#Задача)
- [Инфраструктура](#Инфраструктура)
    - [Сайт](#Сайт)
    - [Мониторинг](#Мониторинг)
    - [Логи](#Логи)
    - [Сеть](#Сеть)
    - [Резервное копирование](#Копирование)
# Выполнение дипломной работы
# Содержание
### Terraform
- [Инфраструктура](#инфраструктура2)
    - [Сеть](#сеть-1)
    - [Группы безопасности](#группы-безопасности)
    - [Load Balancer](#load-balancer)
    - [Резервное копирование](#копирование2)
### Ansible
- [Nginx](#Nginx)
- [Мониторинг](#мониторинг-1)
- [Логи](#логи-1)
    -  [Elasticsearch](#Elasticsearch)
    -  [Kibana](#Kibana)
    -  [Filebeat](#Filebeat)

**Ссылки на ресурсы**
- [Сайт](http://158.160.143.235/)
- [Kibana](http://89.169.130.144:5601/)
- [Zabbix](http://93.77.176.242/zabbix) (User: guest)

---

## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/) и отвечать минимальным стандартам безопасности: запрещается выкладывать токен от облака в git. Используйте [инструкцию](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials).

**Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**

## <a id="инфраструктура">Инфраструктура</a>
Для развёртки инфраструктуры используйте Terraform и Ansible.

Не используйте для ansible inventory ip-адреса! Вместо этого используйте fqdn имена виртуальных машин в зоне ".ru-central1.internal". Пример: example.ru-central1.internal  - для этого достаточно при создании ВМ указать name=example, hostname=examle !!

Важно: используйте по-возможности **минимальные конфигурации ВМ**:2 ядра 20% Intel ice lake, 2-4Гб памяти, 10hdd, прерываемая.

**Так как прерываемая ВМ проработает не больше 24ч, перед сдачей работы на проверку дипломному руководителю сделайте ваши ВМ постоянно работающими.**

Ознакомьтесь со всеми пунктами из этой секции, не беритесь сразу выполнять задание, не дочитав до конца. Пункты взаимосвязаны и могут влиять друг на друга.

### Сайт
Создайте две ВМ в разных зонах, установите на них сервер nginx, если его там нет. ОС и содержимое ВМ должно быть идентичным, это будут наши веб-сервера.

Используйте набор статичных файлов для сайта. Можно переиспользовать сайт из домашнего задания.

Виртуальные машины не должны обладать внешним Ip-адресом, те находится во внутренней сети. Доступ к ВМ по ssh через бастион-сервер. Доступ к web-порту ВМ через балансировщик yandex cloud.

Настройка балансировщика:

1. Создайте [Target Group](https://cloud.yandex.com/docs/application-load-balancer/concepts/target-group), включите в неё две созданных ВМ.

2. Создайте [Backend Group](https://cloud.yandex.com/docs/application-load-balancer/concepts/backend-group), настройте backends на target group, ранее созданную. Настройте healthcheck на корень (/) и порт 80, протокол HTTP.

3. Создайте [HTTP router](https://cloud.yandex.com/docs/application-load-balancer/concepts/http-router). Путь укажите — /, backend group — созданную ранее.

4. Создайте [Application load balancer](https://cloud.yandex.com/en/docs/application-load-balancer/) для распределения трафика на веб-сервера, созданные ранее. Укажите HTTP router, созданный ранее, задайте listener тип auto, порт 80.

Протестируйте сайт
`curl -v <публичный IP балансера>:80`

### <a id="мониторинг">Мониторинг</a>
Создайте ВМ, разверните на ней Zabbix. На каждую ВМ установите Zabbix Agent, настройте агенты на отправление метрик в Zabbix.

Настройте дешборды с отображением метрик, минимальный набор — по принципу USE (Utilization, Saturation, Errors) для CPU, RAM, диски, сеть, http запросов к веб-серверам. Добавьте необходимые tresholds на соответствующие графики.

### <a id="логи">Логи</a>
Cоздайте ВМ, разверните на ней Elasticsearch. Установите filebeat в ВМ к веб-серверам, настройте на отправку access.log, error.log nginx в Elasticsearch.

Создайте ВМ, разверните на ней Kibana, сконфигурируйте соединение с Elasticsearch.

### <a id="сеть">Сеть</a>
Разверните один VPC. Сервера web, Elasticsearch поместите в приватные подсети. Сервера Zabbix, Kibana, application load balancer определите в публичную подсеть.

Настройте [Security Groups](https://cloud.yandex.com/docs/vpc/concepts/security-groups) соответствующих сервисов на входящий трафик только к нужным портам.

Настройте ВМ с публичным адресом, в которой будет открыт только один порт — ssh.  Эта вм будет реализовывать концепцию  [bastion host]( https://cloud.yandex.ru/docs/tutorials/routing/bastion) . Синоним "bastion host" - "Jump host". Подключение  ansible к серверам web и Elasticsearch через данный bastion host можно сделать с помощью  [ProxyCommand](https://docs.ansible.com/ansible/latest/network/user_guide/network_debug_troubleshooting.html#network-delegate-to-vs-proxycommand) . Допускается установка и запуск ansible непосредственно на bastion host.(Этот вариант легче в настройке)

Исходящий доступ в интернет для ВМ внутреннего контура через [NAT-шлюз](https://yandex.cloud/ru/docs/vpc/operations/create-nat-gateway).``

### <a id="копирование">Резервное копирование</a>
Создайте snapshot дисков всех ВМ. Ограничьте время жизни snaphot в неделю. Сами snaphot настройте на ежедневное копирование.

---

# Выполнение дипломной работы

## Terraform

### <a id="инфраструктура2">Инфраструктура</a>

Поднимаем инфраструктуру в Yandex Cloud, используя **Terraform**. Запускаем процесс поднятия инфраструктуры командой `terraform apply` в конце выполнения получаем данные output, которые мы прописывали в файле **outputs.tf**.

![output](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/output.png)

После завершения работы **Terraform** можно проверить в web консоли YC созданную инфраструктуру, сервера **web-vm1** и **web-vm2** созданы в разных зонах.

![vms](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/vms.png)

### <a id="сеть-1">Сеть</a>

**VPC и subnet**

Создаем 1 VPC с публичными и внутренними подсетями и таблицей маршрутизации для доступа к интернету ВМ, находящихся внутри сети за **bastion**, который будет выступать в роли интернет-шлюза.

![vpcmap](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/vpcmap.png)

### <a id="группы-безопасности">Группы безопасности</a>

![sg](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/sg.png)

**bastion-sg** - открытый порт 22 для SSH и порт 10051 для **Zabbix agent**.

![bastion-sg](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/bastion-sg.png)

**lan-sg** - группа безопасноти для внутренней сети между ВМ за бастионом.

![lan-sg](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/lan-sg.png)

**web-sg** - открытый порт 9200 для SSH тунеля между **Kibana** и **Elasticsearch** и порт 80 для сайта и проверки его состояния.

![web-sg](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/web-sg.png)

**public-sg** - открытые порты 5601, 80 и 10051 для доступа c интернета к web интерфейсу **Kibana**, Zabbix и работы **Zabbix agent** через **Zabbix proxy**.

![public-sg](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/public-sg.png)

### <a id="load-balancer">Load Balancer</a>

Создаем Target Group.

![alb-target](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/alb-target.png)

Создаем Backend Group. Настраиваем backends на target group, ранее созданную, healthcheck на корень (/) и порт 80, протокол HTTP.

![alb](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/alb.png)

![hc](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/hc.png)

Создаем HTTP router.

![router](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/router.png)

Создаем Application load balancer. Для распределения трафика на веб-сервера, созданные ранее. Указываем HTTP router, созданный ранее, задаем listener тип auto, порт 80.

![alb-back](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/alb-back.png)

![listener](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/listener.png)

### <a id="копирование2">Резервное копирование</a>

Создаем в **Terraform** блок с расписанием резервного копирования snapshots.

![snap-sch](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/snap-sch.png)

Проверяем на следующий день, что снимки создались по расписанию.

![snap](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/snap.png)


### Ansible

### Установка и настройка Ansible

Устанавливаем **Ansible** на локальном хосте где работали с **Terraform** и настраиваем его на работу через **bastion**. Создаем inventory файл hosts.ini c использованием FQDN имен серверов.

![inventory](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/inventory.png)

### Установка и конфигурация Nginx

Устанавливаем **Nginx**, меняем web страницы.

![nginx](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/nginx.png)

Проверяем доступность сайта в браузере по публичному ip адресу **Load Balancer**.

![web1](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/web1.png)

![web2](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/web2.png)

Делаем запрос на ip адрес **Load Balancer** curl 158.160.143.235.

![curl](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/curl.png)

### <a id="мониторинг2">Мониторинг</a>

Устанавливаем **Zabbix сервер**.

![zabbix](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix.png)

Проверяем доступность web интерфейса **Zabbix сервера**.

![zabbix-init](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix-init.png)

![zabbix-web](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix-web.png)

Устанавливаем и настраиваем **Zabbix proxy** на **bastion**.

![zabbix-proxy](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix-proxy.png)

Устанавливаем **Zabbix agents** на web сервера, настройка для работы с **Zabbix proxy**.

![zabbix-agents](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix-agents.png)

Добавляем proxy, хосты через proxy и настраиваем дашборд.

![zabbix-proxy-web](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix-proxy-web.png)

![zabbix-hosts](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/zabbix-hosts.png)

![dashboard](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/dashboard.png)

## <a id="логи2">Логи</a>

### Elasticsearch

Устанавливаем **Elasticsearch**.

![elastic](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/elastic.png)

### Filebeat

Устанавливаем **Filebeat**.

![filebeat](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/filebeat.png)

### Kibana

Устанавливаем **Kibana**.

![kibana](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/kibana.png)

Настраиваем SSH туннель на проброс порта 9200 через **bastion** для получения информации от **Elasticsearch**.

![kibana-tunnel-conf](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/kibana-tunnel-conf.png)

![kibana-tunnel-service](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/kibana-tunnel-service.png)

Проверяем что **Kibana** работает.

![kibana-web](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/kibana-web.png)

Настраиваем получение логов, проверяем в **Kibana** что **Filebeat** доставляет логи в **Elasticsearch**.

![kibana-web-filebeat](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/kibana-web-filebeat.png)

![kibana-web-logs](https://github.com/EscEller/netology-homework/blob/main/sysdiploma-02/content/kibana-web-logs.png)

