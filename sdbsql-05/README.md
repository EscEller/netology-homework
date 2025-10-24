# Домашнее задание к занятию «Индексы»


### Задание 1

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

## Ответ 1

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sdbsql-05/content/1.png)

---

### Задание 2

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
- перечислите узкие места;
- оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.

## Ответ 2

![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sdbsql-05/content/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/sdbsql-05/content/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/sdbsql-05/content/4.png)
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/sdbsql-05/content/5.png)

