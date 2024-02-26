Build your application, containerize with Docker, deploy on Kubernetes.  

__Create and use local docker image in pods__  

1. build image : `docker build -t <image-name>:latest .`

2. push local docker image to minikube : `minikube image load <image-name>`

3. set `image: <image-name>` in pod spec  

4. set `imagePullPolicy` to `Never`  

---

__Verify that image has been pushed to minikube__  

set env : `eval $(minikube docker-env)`  
verify image : `docker image ls`  
exit env : `eval $(minikube docker-env -u)`  