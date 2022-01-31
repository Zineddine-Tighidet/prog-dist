minikube start
kubectl apply -f k8s/postgres-config.yaml
kubectl apply -f k8s/postgres-secret.yaml
kubectl apply -f k8s/postgres.yaml
cd k8s
source create_webapp1.sh
source create_webapp2.sh
cd ..
kubectl apply -f k8s/webapp1.yaml
kubectl apply -f k8s/webapp2.yaml
echo 'Waiting 120s so pods can wake up ...'
sleep 120
minikube service web-svc1
minikube service web-svc2
