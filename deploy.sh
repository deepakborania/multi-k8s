docker build -t deepakborania/multi-client:latest -t deepakborania/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deepakborania/multi-server:latest -t deepakborania/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deepakborania/multi-worker:latest -t deepakborania/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deepakborania/multi-client:latest
docker push deepakborania/multi-client:$SHA
docker push deepakborania/multi-server:latest
docker push deepakborania/multi-server:$SHA
docker push deepakborania/multi-worker:latest
docker push deepakborania/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deepakborania/multi-server:$SHA
kubectl set image deployments/worker-deployment server=deepakborania/multi-worker:$SHA
kubectl set image deployments/client-deployment server=deepakborania/multi-client:$SHA