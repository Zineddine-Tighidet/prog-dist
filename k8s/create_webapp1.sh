echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment1
  labels:
    app: web1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web1
  template: # blueprint for pods
    metadata:
      labels:
        app: web1
    spec:
      containers:
        - name: webapp
          image: aallal18032000/express:ms1-f-ver .
          ports:
            - name: http
              containerPort: 3000
          env:
            - name: USER_NAME
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: postgres-user
            - name: PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: postgres-pwd
            - name: POSTGRES_HOST
              valueFrom:
                configMapKeyRef:
                  name: postgres-config
                  key: postgres-url
            - name: NODE_IP_ADDR
              value: '`minikube ip`'
          
---
apiVersion: v1
kind: Service
metadata:
  name: web-svc1
spec:
  type: LoadBalancer #To make it an external service, we put NodePort ( instead of clusterIp which is the type of an internal service )
  selector:
    app: web1
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000 #Port of the pods
      nodePort: 30300 #Open the port of a node

" > webapp1.yaml