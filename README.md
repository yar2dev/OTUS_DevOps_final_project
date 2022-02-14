# README #


Предварительное краткое описание по теме проекта: 

## Создание процесса непрерывной поставки для приложения с применением Практик CI/CD и быстрой обратной связью ##


### Инфраструктура ###

Создание инфраструктыры выполняется при помощи Packer/Terraform/Ansible
При помощи Packer создается образ для развертывания сервера MongoDB

Terraform создает: 
- внутреннюю сеть
- внешний IP
- DNS запись для существующего домена (для gitlab)
- Виртуальную машину с MongoDB из образа подготовленного Packer
- Виртуальную машину для Gitlab
- Managed Service for Kubernetes с двумя нодами
- Подключает контекст кубера в конфиг

Ansible из плейбука разворачивает Gitlab на подготовленной машине

Для запуска:
> cd infra/terraform 
terraform apply

### Микросервисы ###
Для сборки приложений созданы Dockerfile
Приложения собраны и отправлены в DockerHub
- yar2dev/crawler:latest
- yar2dev/ui:latest

Rabbitmq и gitlab-runner деплоится при помощи Helm
Для Prometheus и Grafana созданы манифесты с подключенными конфигами

Установка crawler, prometheus, grafana:
> cd microservices
kubectl apply -f k8s/
kubectl apply -f app/
kubectl apply -f monitoring/

RabbitMQ:
>export RABBITMQ_PASSWORD="P@ssword"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install rabbitmq \
  --set auth.password=$RABBITMQ_PASSWORD \
    bitnami/rabbitmq

gitlab-runner:
После создания проектов в Gitlab (https://gitlab.yar2.space), получить токены раннеров и 
занести их в соответствующие файлы: microservices/gitlab-runner/ values-crawler.yaml и values-ui.yaml 
в параметр runnerRegistrationToken.
Выполнить:
> helm install --namespace gitlab gitlab-runner-ui -f values-ui.yaml gitlab/gitlab-runner
helm install --namespace gitlab gitlab-runner-crawler -f values-crawler.yaml gitlab/gitlab-runner


### CI/CD ###

В репозитарии приложений созданы .gitlab-ci.yml для сборки/тестирования/деплоя
(деплой еще не работает)

#### Принципиальная схема инфраструктуры на текущий момент ####
![otus-project](https://github.com/yar2dev/imgs/blob/main/otus_project.jpg?raw=true)