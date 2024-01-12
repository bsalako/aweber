# Nginx deployment to the kubernetes cluster

## There are 2 ways of deploying nginx on kubernetes cluster described in this repository:

1) Using kubernetes manifests to deploy them on existing kubernetes cluster:

   Steps:
    - cd kubernetes_manifests/
    - kubectl apply -f namespace.yaml
    - kubectl apply -f configmap.yaml
    - kubectl apply -f deployment.yaml
    - kubectl apply -f service.yaml
3) Using terraform code, created in terraform/ folder. This will create a new VPC with all network components (subnets, routing tables, NAT gateway, NIG, etc.), AWS EKS cluster, deploy nginx to your newly created kubernetes cluster.

   Steps:
     - specify the name of the bucket created in your aws account in the backend.tf (remote state storage)
     - aws configure (configure your credentials) in order to deploy resources on AWS using aws terraform provider
     - terraform init
     - terraform plan
     - terraform apply
     - PS: in order to control your kubernetes cluster from the cli you should save its kubeconfig first. It can be done using this command: aws eks update-kubeconfig --region <region> --name <cluster_name>
