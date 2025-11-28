#!/bin/bash

echo "🔹 Checking Kubernetes Product API Project ..."

# 1️⃣ Set minikube docker env
eval $(minikube docker-env)

# 2️⃣ Get latest pod name
POD_NAME=$(kubectl get pods -l app=product-api -o jsonpath="{.items[0].metadata.name}")

if [ -z "$POD_NAME" ]; then
  echo "❌ No pod found for product-api!"
  exit 1
fi
echo "✅ Pod found: $POD_NAME"

# 3️⃣ Check pod status
POD_STATUS=$(kubectl get pod $POD_NAME -o jsonpath="{.status.phase}")
echo "Pod status: $POD_STATUS"

if [ "$POD_STATUS" != "Running" ]; then
  echo "❌ Pod is not running!"
  exit 1
fi

# 4️⃣ Get NodePort service URL
SERVICE_URL=$(minikube service product-api-svc --url)

if [ -z "$SERVICE_URL" ]; then
  echo "❌ Service product-api-svc not found!"
  exit 1
fi
echo "✅ Service URL: $SERVICE_URL"

# 5️⃣ Test GET /api/products
echo "🔹 Testing GET /api/products ..."
GET_RESPONSE=$(curl -s $SERVICE_URL/api/products)
echo "GET Response: $GET_RESPONSE"

# 6️⃣ Test POST /api/products
echo "🔹 Testing POST /api/products ..."
POST_RESPONSE=$(curl -s -X POST -H "Content-Type:application/json" \
-d '{"name":"TestProduct","price":999}' \
$SERVICE_URL/api/products)
echo "POST Response: $POST_RESPONSE"

# 7️⃣ Test GET again to see the new product
echo "🔹 Testing GET after POST ..."
GET_RESPONSE2=$(curl -s $SERVICE_URL/api/products)
echo "GET Response after POST: $GET_RESPONSE2"

echo "✅ All checks completed!"
