# Домашнее задание к занятию «GitLab» - Кузубов Олег


### Задание 1

**Что нужно сделать:**

1. Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в [этом репозитории](https://github.com/netology-code/sdvps-materials/tree/main/gitlab).
2. Создайте новый проект и пустой репозиторий в нём.
3. Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа в репозиторий шаблона с решением добавьте скриншоты с настройками раннера в проекте.

### Ответ 1

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/1/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/1/2.png)

---

### Задание 2

**Что нужно сделать:**

1. Запушьте [репозиторий](https://github.com/netology-code/sdvps-materials/tree/main/gitlab) на GitLab, изменив origin. Это изучалось на занятии по Git.
2. Создайте .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа в шаблон с решением добавьте:

 * файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне;
 * скриншоты с успешно собранными сборками.

### Ответ 2

.gitlab-ci.yaml
```
stages:
  - test
  - build

test:
  stage: test
  image: golang:1.17
  script:
   - go test .
  tags:
    - neto

build:
  stage: build
  image: docker:latest
  script:
   - docker build .
  tags:
    - neto
```

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/2/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/2/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/2/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/2/4.png)

---

### Задание 3*

Измените CI так, чтобы:

 - этап сборки запускался сразу, не дожидаясь результатов тестов;
 - тесты запускались только при изменении файлов с расширением *.go.

В качестве ответа добавьте в шаблон с решением файл gitlab-ci.yml своего проекта или вставьте код в соответсвующее поле в шаблоне.

### Ответ 3

Тесты запускаюстся только при изменении файлов с расширением *.go, но этап сборки начинается после завершения теста:

.gitlab-ci.yaml
```
stages:
  - test
  - build

test:
  rules:
    - changes:
      - "*.go"
  stage: test
  image: golang:1.17
  script:
   - go test .
  tags:
    - neto

build:
  stage: build
  image: docker:latest
  script:
   - docker build .
  tags:
    - skip
  dependencies: []
  needs: []
```

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/3/1.png)
![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/3/2.png)
![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/3/3.png)
![Скриншот-4](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/3/4.png)
![Скриншот-5](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/3/5.png)
![Скриншот-6](https://github.com/EscEller/netology-homework/blob/main/sdvps-03/png/3/6.png)
