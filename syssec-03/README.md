# Домашнее задание к занятию «Защита сети»


### Подготовка к выполнению заданий

1. Подготовка защищаемой системы:

- установите **Suricata**,
- установите **Fail2Ban**.

2. Подготовка системы злоумышленника: установите **nmap** и **thc-hydra** либо скачайте и установите **Kali linux**.

Обе системы должны находится в одной подсети.

------

### Задание 1

Проведите разведку системы и определите, какие сетевые службы запущены на защищаемой системе:

**sudo nmap -sA < ip-адрес >**

**sudo nmap -sT < ip-адрес >**

**sudo nmap -sS < ip-адрес >**

**sudo nmap -sV < ip-адрес >**

*В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.*

### Ответ 1

Защищаемая система      -    Ubuntu enp0s3 192.168.56.105
Система злоумашленника  -    Ubuntu enp0s8 192.168.56.106
![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/1.png)
**sudo nmap -sA 192.168.56.105**
Suricata не определил какое-либо сканирование.
**sudo nmap -sT 192.168.56.105**
Suricata определяет подозрительный входящий трафик на порты: 3306 mySQL, 1433 MSSQL, 5432 PostgreSQL, 1521 Oracle SQL, 47258 nginx c классифицией "Potentionally Bad Traffic" с приоритетом 2. И потенциальное сканирование VNC 5800-5820 с классификацией "Attempted Information Leak" с приоритетом 2.
**sudo nmap -sS 192.168.56.105**
Suricata определяет то же, что и при сканировании nmap -sT. Различия в портах атакующего хоста и отсутствии сканировании VNC 5800-5820.
**sudo nmap -sV 192.168.56.105**
Suricata определяет похожий трафик, что и при сканировании nmap -sT и nmap -sS, обнаруживает возможной пользовательский агент скриптового движка Nmap с классификацией "Web Application Attack" и приоритетом 1.
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/3.png)
Fail2Ban никак не отреагировал. Но, при последнем сканировании, в логах операционной системы появилась информация об ошибке и закрытии соединения атакующим хостом.
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/4.png)

---

### Задание 2

Проведите атаку на подбор пароля для службы SSH:

**hydra -L users.txt -P pass.txt < ip-адрес > ssh**

1. Настройка **hydra**:

 - создайте два файла: **users.txt** и **pass.txt**;
 - в каждой строчке первого файла должны быть имена пользователей, второго — пароли. В нашем случае это могут быть случайные строки, но ради эксперимента можете добавить имя и пароль существующего пользователя.

Дополнительная информация по **hydra**: https://kali.tools/?p=1847.

2. Включение защиты SSH для Fail2Ban:

-  открыть файл /etc/fail2ban/jail.conf,
-  найти секцию **ssh**,
-  установить **enabled**  в **true**.

*В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.*

### Ответ 2

Пароль был успешно подобран, хоть и адрес был забанен fail2ban.
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/5.png)
Только на третью попытку не удалось установить соединение.
![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/6.png)
Лог Suricata.
![Скриншот-7](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/7.png)
Системный лог.
![Скриншот-8](https://github.com/EscEller/netology-homework/blob/main/syssec-03/content/8.png)
