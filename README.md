# NGINX Deployment on Kubernetes

This project demonstrates how to deploy NGINX on a Kubernetes cluster using a Deployment, Service, and ConfigMap.

## Prerequisites

- Docker Desktop with Kubernetes enabled
- Visual Studio Code or iTerm installed
- kubectl command-line tool installed

## Deployment Steps

1. Create the Kubernetes manifests:
   - Create the files `deployment.yaml`, `service.yaml`, and `configmap.yaml` with the specified content.
2. Deploy the manifests:
   - Navigate to the directory containing the manifests in a terminal.
   - Run the following commands:

     ```bash
     kubectl apply -f deployment.yaml
     kubectl apply -f service.yaml
     kubectl apply -f configmap.yaml
     ```

3. Access NGINX:
   - Open your web browser and access NGINX at `http://localhost:30080`.
   - You should be met with the "Hello, world!" message.
