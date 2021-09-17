docker build -t m3tr0x/multi-client:latest -t m3tr0x/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t m3tr0x/multi-server:latest -t m3tr0x/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t m3tr0x/multi-worker:latest -t m3tr0x/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push m3tr0x/multi-client:latest
docker push m3tr0x/multi-server:latest
docker push m3tr0x/multi-worker:latest

docker push m3tr0x/multi-client:$SHA
docker push m3tr0x/multi-server:$SHA
docker push m3tr0x/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=m3tr0x/multi-server:$SHA
kubectl set image deployments/client-deployment client=m3tr0x/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=m3tr0x/multi-worker:$SHA