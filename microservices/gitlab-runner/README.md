helm install --namespace gitlab gitlab-runner-ui -f values-ui.yaml gitlab/gitlab-runner
helm install --namespace gitlab gitlab-runner-crawler -f values-crawler.yaml gitlab/gitlab-runner


helm install --namespace gitlab gitlab-runner-ui \
  --set gitlabUrl=https://gitlab2.yar2.space/ \
  runnerRegistrationToken="" \
   gitlab/gitlab-runner

helm install --namespace gitlab gitlab-runner-crawler \
  --set gitlabUrl=https://gitlab2.yar2.space/ \
  runnerRegistrationToken="79_pbbzmg2o7-1xho17X" \
   gitlab/gitlab-runner


kubectl create clusterrolebinding gitlab-cluster-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=gitlab:default