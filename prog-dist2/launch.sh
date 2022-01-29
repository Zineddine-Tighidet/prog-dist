kubectl apply -f k8s/postgres-config.yaml
kubectl apply -f k8s/postgres-secret.yaml
kubectl apply -f k8s/postgres.yaml
kubectl apply -f k8s/webapp.yaml
echo 'Waiting a minute so pods can wake up ...'
sleep 60
minikube service web-svc
