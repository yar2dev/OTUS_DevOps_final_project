export RABBITMQ_PASSWORD=

helm install rabbitmq \
  --set auth.password=$RABBITMQ_PASSWORD \
    bitnami/rabbitmq