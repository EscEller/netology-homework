# Домашнее задание к занятию "Что такое DevOps. СI/СD" - Кузубов Олег


### Задание 1

**Что нужно сделать:**

1. Установите себе jenkins по инструкции из лекции или любым другим способом из официальной документации. Использовать Docker в этом задании нежелательно.
2. Установите на машину с jenkins [golang](https://golang.org/doc/install).
3. Используя свой аккаунт на GitHub, сделайте себе форк [репозитория](https://github.com/netology-code/sdvps-materials.git). В этом же репозитории находится [дополнительный материал для выполнения ДЗ](https://github.com/netology-code/sdvps-materials/blob/main/CICD/8.2-hw.md).
3. Создайте в jenkins Freestyle Project, подключите получившийся репозиторий к нему и произведите запуск тестов и сборку проекта ```go test .``` и  ```docker build .```.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Ответ 1

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/8-02/png/1/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/8-02/png/1/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/8-02/png/1/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/8-02/png/1/4.png)
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/8-02/png/1/5.png)

---

### Задание 2

**Что нужно сделать:**

1. Создайте новый проект pipeline.
2. Перепишите сборку из задания 1 на declarative в виде кода.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Ответ 2

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/8-02/png/2/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/8-02/png/2/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/8-02/png/2/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/8-02/png/2/4.png)

---

### Задание 3

**Что нужно сделать:**

1. Установите на машину Nexus.
1. Создайте raw-hosted репозиторий.
1. Измените pipeline так, чтобы вместо Docker-образа собирался бинарный go-файл. Команду можно скопировать из Dockerfile.
1. Загрузите файл в репозиторий с помощью jenkins.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Ответ 3

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/4.png)
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/5.png)
![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/6.png)
![Скриншот-7](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/7.png)
![Скриншот-8](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/8.png)
![Скриншот-9](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/9.png)
![Скриншот-10](https://github.com/EscEller/netology-homework/blob/main/8-02/png/3/10.png)

---

### Задание 4*

Придумайте способ версионировать приложение, чтобы каждый следующий запуск сборки присваивал имени файла новую версию. Таким образом, в репозитории Nexus будет храниться история релизов.

Подсказка: используйте переменную BUILD_NUMBER.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Ответ 4

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/4.png)
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/5.png)
![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/6.png)
![Скриншот-7](https://github.com/EscEller/netology-homework/blob/main/8-02/png/4/7.png)
