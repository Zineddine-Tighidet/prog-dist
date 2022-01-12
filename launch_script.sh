kubectl apply -f k8s/postgres-config.yaml
kubectl apply -f k8s/postgres-secret.yaml
kubectl apply -f k8s/postgres.yaml
kubectl apply -f k8s/webapp.yaml
