echo "--------------"
sudo docker container start mysql
#sudo docker container rm mysql
#sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=1234 -p3306:3306 -d mysql:latest
echo "--------------"
PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
echo $PASSWORD
echo -n $PASSWORD | sudo faas-cli login --username admin --password-stdin
echo "--------------"
sudo kubectl get pod -o wide -n openfaas
echo "--------------"
sudo kubectl port-forward -n openfaas svc/gateway --address 0.0.0.0 8080:8080 &
sudo kubectl port-forward -n openfaas svc/prometheus --address 0.0.0.0 9090:9090 &
kubectl logs -n openfaas-fn deploy/pwd-reader
# sudo kubectl port-forward deployment/prometheus 9090:9090 -n openfaas
