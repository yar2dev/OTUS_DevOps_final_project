# Changelog

## (22-02-20)

### Added

* Добавлен сборщик логов Filebeat
* Обработчик Logstash
* Визуализация логов Kibana
* В конфиг Filebeat добавлено раскрытие json поля message 
* В конфиг Logstash добавлена обработка поля message => удаление двойных кавычек, перименование созданного поля в filebeat json.service в servicename
* По полю servicename в Kibana можно искать события относящиеся к приложению search engine (например servicename:crawler)

## (22-02-18)

### Changed

* Количество нод Кубернетис изменено с 2 на 3

### Added

* В папке infra/logging добавлены манифесты для для создания Elasticsearch кластера из 3 нод
  создаются Persistent Volumes, Persistent Volumes Claims, сам сервер из 3 нод.



## (2022-02-16)
* Created this CHANGELOG.md

## (2022-02-15)

:tada: Опубликован MVP про проекту :tada:

### Added

* Шаблон Packer для MongoDB
* Манифесты Terraform для создания VM's Gitlab, MongoDB, Yandex-K8s кластера, A DNS запись для gitlab.yar2.space
* Ansible плейбук для поднятия Gitlab на VM
* Манифесты для установки в Kubernetes prometheus, grafana, gitlab-runner, rabbitmq 
* Манифесты для установки в Kubernetes приложения search_engine
* README.md