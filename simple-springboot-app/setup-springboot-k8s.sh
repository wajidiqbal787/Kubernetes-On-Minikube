#!/bin/bash
# Script: setup-springboot-k8s.sh
# Purpose: Automate Spring Boot build, Docker image creation, and Minikube deployment

# Variables
APP_NAME="simple-springboot-app"
IMAGE_NAME="simple-springboot-app:latest"
DEPLOYMENT_FILE="k8s-deployment.yaml"

echo "Step 1: Maven clean and package..."
mvn clean package || { echo "Maven build failed!"; exit 1; }

echo "Step 2: Build Docker image..."
docker build -t $IMAGE_NAME . || { echo "Docker build failed!"; exit 1; }

echo "Step 3: Start Minikube..."
minikube start --driver=docker || { echo "Minikube start failed!"; exit 1; }

echo "Step 4: Use Minikube Docker environment..."
eval $(minikube -p minikube docker-env)

echo "Step 5: Apply Kubernetes deployment..."
kubectl apply -f $DEPLOYMENT_FILE || { echo "Kubernetes deployment failed!"; exit 1; }

echo "Step 6: Wait for pod to be ready..."
kubectl rollout status deployment/simple-springboot-deployment

echo "Step 7: Get Minikube IP and NodePort..."
MINIKUBE_IP=$(minikube ip)
NODE_PORT=$(kubectl get svc simple-springboot-service -o=jsonpath='{.spec.ports[0].nodePort}')

echo "✅ Deployment complete!"
echo "Access your app at: http://$MINIKUBE_IP:$NODE_PORT/hello"
