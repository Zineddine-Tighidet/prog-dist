# prog-dist
dependencies :
- express
- ejs

dev-dependencies :
- nodemon (make changes on the flow)
- dotenv (permet d'avoir des variables d'environement qu'on va stocker dans un fichier env pour les charger dans le serveur)


## Run the Application:

**Important:** make sure to change the paths to the psql data specified in the `db.sql` script (lines 61, 66 and 71)


- Open a terminal on `psql` and run the script `db.sql`.
- Open another terminal and run `npm run devStart`
- You can now use the app at `localhost:3000`

## To run the application on a Kubernetes cluster:
### **Important:** make sure to have minikube installed on your machine and enough space on your disk to pull the images
- **First** : launch a k8s cluster wite : minikube start ( that could take some time so you can make to yourself a coffee)  
- **Second** : launch Deployments and Services with : source launch.sh ( that could aussi take some time because then pods need to start )
- **Third** : A new page should open in your favorite browser, enjoy the planets !
