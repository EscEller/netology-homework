# Домашнее задание к занятию «Система мониторинга Prometheus» - Кузубов Олег


### Задание 1
Установите Prometheus.

#### Процесс выполнения
1. Выполняя задание, сверяйтесь с процессом, отражённым в записи лекции
2. Создайте пользователя prometheus
3. Скачайте prometheus и в соответствии с лекцией разместите файлы в целевые директории
4. Создайте сервис как показано на уроке
5. Проверьте что prometheus запускается, останавливается, перезапускается и отображает статус с помощью systemctl

#### Требования к результату
- Прикрепите к файлу README.md скриншот systemctl status prometheus, где будет написано: prometheus.service — Prometheus Service Netology Lesson 9.4 — [Ваши ФИО]

### Ответ 1

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/hw-04/png/1.png)

---

### Задание 2
Установите Node Exporter.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
3. Скачайте node exporter приведённый в презентации и в соответствии с лекцией разместите файлы в целевые директории
4. Создайте сервис для как показано на уроке
5. Проверьте что node exporter запускается, останавливается, перезапускается и отображает статус с помощью systemctl

#### Требования к результату
- Прикрепите к файлу README.md скриншот systemctl status node-exporter, где будет написано: node-exporter.service — Node Exporter Netology Lesson 9.4 — [Ваши ФИО]

### Ответ 2

![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/hw-04/png/2.png)

---

### Задание 3
Подключите Node Exporter к серверу Prometheus.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Отредактируйте prometheus.yaml, добавив в массив таргетов установленный в задании 2 node exporter
3. Перезапустите prometheus
4. Проверьте что он запустился

#### Требования к результату
- Прикрепите к файлу README.md скриншот конфигурации из интерфейса Prometheus вкладки Status > Configuration
- Прикрепите к файлу README.md скриншот из интерфейса Prometheus вкладки Status > Targets, чтобы было видно минимум два эндпоинта

### Ответ 3

![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/hw-04/png/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/hw-04/png/4.png)

---

### Задание 4*
Установите Grafana.

#### Требования к результату
- Прикрепите к файлу README.md скриншот левого нижнего угла интерфейса, чтобы при наведении на иконку пользователя были видны ваши ФИО

### Ответ 4

![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/hw-04/png/5.png)

---

### Задание 5*
Интегрируйте Grafana и Prometheus.

### Ответ 5

![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/hw-04/png/6.png)
