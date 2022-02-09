# ft_services

Sujet d'administration système :

- Mise en place d'un cluster Kubernetes au paramétrage automatisé par script bash
- Infrastructure de 7 containers de services
- Interdiction d'avoir recours à d'autres images préconstruites que celle d'Alpine Linux
- Chaque container est construit via un Dockerfile customisé
- Les containers : WordPress, MySQL, phpMyAdmin, nginx, FTPS, Grafana, Influxdb, avec un load balancer Metallb
- Persistence des bases de données en cas de crash
- Persistence des volumes en cas de suppression
- Redémarrage automatique en cas de crash ou d'arrêt d'un des éléments
