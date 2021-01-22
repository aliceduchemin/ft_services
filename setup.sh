#!/bin/sh
echo "Delete any Minikube"
minikube stop && minikube delete

echo ""
echo "(Re)start Minikube"
sudo chmod 666 /var/run/docker.sock
minikube start --vm-driver=docker
sleep 15
eval $(minikube docker-env --unset)
export CLUSTERIP=`docker network inspect bridge | grep '"IPv4Address"' | cut -b 33-42`

echo ""
echo "Get inside minikube"
eval $(minikube docker-env)

echo ""
echo "Download minikube addons"
minikube addons enable dashboard && minikube addons enable metrics-server

echo ""
echo "Setting MetalLB"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

echo ""
echo "Lauching custom pods"
echo "Cluster gateway IP =" $CLUSTERIP
sed -i -e "s/clusterip/$CLUSTERIP/g" ./srcs/nginx/srcs/my_ng.conf
sed -i -e "s/clusterip/$CLUSTERIP/g" ./srcs/metallb/metallb.yaml
sed -i -e "s/clusterip/$CLUSTERIP/g" ./srcs/ftps/srcs/vsftpd.conf

echo "nginx:"
docker build -t nginx ./srcs/nginx/ > /dev/null 2>&1
kubectl apply -f ./srcs/nginx/nginx.yaml
sed -i -e "s/$CLUSTERIP/clusterip/g" ./srcs/nginx/srcs/my_ng.conf

echo ""
echo "wordpress:"
docker build -t wordpress ./srcs/wordpress/ > /dev/null 2>&1
kubectl apply -f ./srcs/wordpress/wordpress.yaml

echo ""
echo "phpmyadmin:"
docker build -t phpmyadmin ./srcs/phpmyadmin/ > /dev/null 2>&1
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml

echo ""
echo "mysql:"
docker build -t mysql ./srcs/mysql/ > /dev/null 2>&1
kubectl apply -f ./srcs/mysql/mysql.yaml

echo ""
echo "ftps:"
docker build -t ftps ./srcs/ftps/ > /dev/null 2>&1
kubectl apply -f ./srcs/ftps/ftps.yaml
sed -i -e "s/$CLUSTERIP/clusterip/g" ./srcs/ftps/srcs/vsftpd.conf

echo ""
echo "grafana:"
docker build -t grafana ./srcs/grafana/ > /dev/null 2>&1
kubectl apply -f ./srcs/grafana/grafana.yaml

echo ""
echo "influxdb:"
docker build -t influxdb ./srcs/influxdb/ > /dev/null 2>&1
kubectl apply -f ./srcs/influxdb/influxdb.yaml

sleep 15

echo ""
echo "Setting Metallb custom config"
kubectl apply -f ./srcs/metallb/metallb.yaml
sed -i -e "s/$CLUSTERIP/clusterip/g" ./srcs/metallb/metallb.yaml

echo ""
echo "Checking services and deployments"
echo "Services:"
kubectl get service
echo ""
echo "Deployments:"
kubectl get deployment
echo ""
echo "Pods"
kubectl get pods
echo ""
echo "Pods, detailled"
kubectl get pod -n metallb-system -o wide
kubectl get pod -o wide
echo ""
echo "Login information :"
echo "For Grafana :"
echo "   Login : admin"
echo "   Password : lolilol"
echo "For Ftps :"
echo "  Login: aduchemi"
echo "  Password: password1!"
echo ""
echo "Press Enter to open dashboard"
read REPLY
minikube dashboard
