echo "**Note: If it's the fist time launching the project, it may take some time to download the images from the Docker Hub (this depends on the quality of your internet).**"
minikube start
kubectl apply -f k8s/postgres-config.yaml
kubectl apply -f k8s/postgres-secret.yaml
kubectl apply -f k8s/postgres.yaml
sleep 30
cd k8s
source create_webapp1.sh
source create_webapp2.sh
cd ..
kubectl apply -f k8s/webapp1.yaml
kubectl apply -f k8s/webapp2.yaml
echo 'Waiting 120s so pods can wake up ...'
sleep 120
minikube service web-svc2
#minikube service web-svc1 --url=false
