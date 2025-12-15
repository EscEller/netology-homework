# Домашнее задание к занятию «Уязвимости и атаки на информационные системы»


### Задание 1

Скачайте и установите виртуальную машину Metasploitable: https://sourceforge.net/projects/metasploitable/.

Это типовая ОС для экспериментов в области информационной безопасности, с которой следует начать при анализе уязвимостей.

Просканируйте эту виртуальную машину, используя **nmap**.

Попробуйте найти уязвимости, которым подвержена эта виртуальная машина.

Сами уязвимости можно поискать на сайте https://www.exploit-db.com/.

Для этого нужно в поиске ввести название сетевой службы, обнаруженной на атакуемой машине, и выбрать подходящие по версии уязвимости.

Ответьте на следующие вопросы:

- Какие сетевые службы в ней разрешены?
- Какие уязвимости были вами обнаружены? (список со ссылками: достаточно трёх уязвимостей)

*Приведите ответ в свободной форме.*

### Ответ 1
- Какие сетевые службы в ней разрешены?

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/1.png)

- Какие уязвимости были вами обнаружены? (список со ссылками: достаточно трёх уязвимостей)

1. 8180/tcp open  http        Apache Tomcat/Coyote JSP engine 1.1
 - [Apache Tomcat 5.5.0 < 5.5.29 / 6.0.0 < 6.0.26 - Information Disclosure](https://www.exploit-db.com/exploits/12343)
 - [Apache Tomcat 5.x/6.0.x - Directory Traversal](https://www.exploit-db.com/exploits/29739)
 - [Apache Tomcat < 5.5.17 - Remote Directory Listing](https://www.exploit-db.com/exploits/2061)

2. 5432/tcp open  postgresql  PostgreSQL DB 8.3.0 - 8.3.7
 - [PostgreSQL 8.3.6 - Conversion Encoding Remote Denial of Service](https://www.exploit-db.com/exploits/32849)
 - [PostgreSQL 8.3.6 - Low Cost Function Information Disclosure](https://www.exploit-db.com/exploits/32847)
 - [PostgreSQL 8.2/8.3/8.4 - UDF for Command Execution](https://www.exploit-db.com/exploits/7855)

3. 3306/tcp open  mysql       MySQL 5.0.51a-3ubuntu5
 - [Oracle MySQL < 5.1.50 - Privilege Escalation](https://www.exploit-db.com/exploits/34796)
 - [Oracle MySQL < 5.1.49 - 'DDL' Statements Denial of Service](https://www.exploit-db.com/exploits/34522)
 - [Oracle MySQL < 5.1.49 - Malformed 'BINLOG' Arguments Denial of Service](https://www.exploit-db.com/exploits/34521)
 - [Oracle MySQL 5.1.48 - 'HANDLER' Interface Denial of Service](https://www.exploit-db.com/exploits/34520)
 - [OraclMySQL 5.1.48 - 'LOAD DATA INFILE' Denial of Service](https://www.exploit-db.com/exploits/34510)
 - [MySQL 5.0.75 - 'sql_parse.cc' Multiple Format String Vulnerabilities](https://www.exploit-db.com/exploits/33077)
 - [MySQL 5.0.x - IF Query Handling Remote Denial of Service](https://www.exploit-db.com/exploits/30020)
 - [MySQL 5.0.x - Single Row SubSelect Remote Denial of Service](https://www.exploit-db.com/exploits/29724)
 - [MySQL 4.x/5.x - Server Date_Format Denial of Service](https://www.exploit-db.com/exploits/28234)

![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/3.png)

---

### Задание 2

Проведите сканирование Metasploitable в режимах SYN, FIN, Xmas, UDP.

Запишите сеансы сканирования в Wireshark.

Ответьте на следующие вопросы:

- Чем отличаются эти режимы сканирования с точки зрения сетевого трафика?
- Как отвечает сервер?

*Приведите ответ в свободной форме.*


### Ответ 2
# SYN
Отправляется пакет с флагом SYN для установки соединения. Ответ SYN/ACK - порт открыт (После происходит сброс соединения RST). Ответ RST/ACK - порт закрыт.
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/4.png)
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/5.png)
# FIN
Отправляется пакет с флагом FIN. Ответ RST/ACK - порт закрыт. Если ответа нет - порт открыт|фильтруется. png
![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/6.png)
![Скриншот-7](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/7.png)
# Xmas
Отправляется пакет с флагами FIN/PSH/URG. Ответ RST/ACK - порт закрыт. Если ответа нет - порт открыт|фильтруется. png
![Скриншот-8](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/8.png)
![Скриншот-9](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/9.png)
# UDP
Отправляет пустой UDP заголовок на каждый порт. Ответ ICMP ошибка о недостижимости порта (тип 3, код 3) - порт закрыт. Другие ICMP ошибки недостижимости - порт фильтруется. После нескольких попыток без ответа - порт открыт|фильтруется. Ответ UDP - порт открыт.
![Скриншот-10](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/10.png)
![Скриншот-11](https://github.com/EscEller/netology-homework/blob/main/syssec-01/content/11.png)
