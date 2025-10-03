# Домашнее задание к занятию «Работа с данными (DDL/DML)»


### Задание 1
1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

1.2. Создайте учётную запись sys_temp.

1.3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)

1.4. Дайте все права для пользователя sys_temp.

1.5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

1.6. Переподключитесь к базе данных от имени sys_temp.

Для смены типа аутентификации с sha2 используйте запрос:
```sql
ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

1.7. Восстановите дамп в базу данных.

1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*

## Ответ 1

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/1.png)

![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/2.png)

![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/3.png)

![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/4.png)

![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/5.png)

![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/6.png)

---

### Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)
```
Название таблицы | Название первичного ключа
customer         | customer_id
```

## Ответ 2

![Скриншот-7](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/7.png)

---

### Задание 3*
3.1. Уберите у пользователя sys_temp права на внесение, изменение и удаление данных из базы sakila.

3.2. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*

## Ответ 3

![Скриншот-8](https://github.com/EscEller/netology-homework/blob/main/sdbsql-02/content/8.png)
