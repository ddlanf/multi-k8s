docker build -t danlan26/multi-client:latest -t danlan26/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danlan26/multi-server:latest -t danlan26/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danlan26/multi-worker:latest -t danlan26/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push danlan26/multi-client:latest
docker push danlan26/multi-server:latest
docker push danlan26/multi-worker:latest

docker push danlan26/multi-client:$SHA
docker push danlan26/multi-server:$SHA
docker push danlan26/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danlan26/multi-server:$SHA
kubectl set image deployments/client-deployment client=danlan26/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danlan26/multi-worker:$SHA