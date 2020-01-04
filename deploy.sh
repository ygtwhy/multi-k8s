docker build -t ygtwhy/multi-client:latest -t ygtwhy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ygtwhy/multi-server:latest -t ygtwhy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ygtwhy/multi-worker:latest -t ygtwhy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ygtwhy/multi-client:latest
docker push ygtwhy/multi-server:latest
docker push ygtwhy/multi-worker:latest

docker push ygtwhy/multi-client:$SHA
docker push ygtwhy/multi-server:$SHA
docker push ygtwhy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ygtwhy/multi-server:$SHA
kubectl set image deployments/client-deployment client=ygtwhy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ygtwhy/multi-worker:$SHA