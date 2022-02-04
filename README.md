# prog-dist
dependencies :
- **Express**
- **Ejs**
- **Minikube**

**dev-dependencies :**
- **nodemon** (make changes on the flow)
- **dotenv** (permet d'avoir des variables d'environement qu'on va stocker dans un fichier env pour les charger dans le serveur)


## Run the Application:

### **Important:** make sure to have minikube installed on your machine and enough space on your disk to pull the images
- **First** : Make sure to give the permissions to the launcing script `launch.sh` by writing `chmod +x launch.sh`.
- **Second** : launch Deployments and Services with : `source launch.sh` (that could also take some time because then pods need to start).
- **Third** : A new page should open in your favorite browser, enjoy the planets !

#### Notice :  
- If you want to delete the Deployments and Services, user : `source delete.sh`s
