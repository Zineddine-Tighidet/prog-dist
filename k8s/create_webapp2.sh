echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment2
  labels:
    app: web2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web2
  template: # blueprint for pods
    metadata:
      labels:
        app: web2
    spec:
      containers:
        - name: webapp
          image: aallal18032000/express:ms2-f-ver
          ports:
            - name: http
              containerPort: 4000
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
  name: web-svc2
spec:
  type: LoadBalancer #To make it an external service, we put NodePort ( instead of clusterIp which is the type of an internal service )
  selector:
    app: web2
  ports:
    - protocol: TCP
      port: 4000
      targetPort: 4000 #Port of the pods
      nodePort: 30400 #Open the port of a node
" > webapp2.yaml