default: build

build:
	go get ./...
	go build

install:
	go install

docker:
	docker build -t mapitman/beats-service:latest .

run:
	docker run --rm -p 8080:8080 mapitman/beats-service:latest

docker-push:
	docker push mapitman/beats-service:latest

cluster-up:
	gcloud container clusters create micro --machine-type=f1-micro
	gcloud container clusters get-credentials micro

cluster-down:
	gcloud container clusters delete micro
	
deploy:
	kubectl run beats-as-a-service --image mapitman/beats-service:latest --port 8080
	kubectl expose deployment beats-as-a-service --type LoadBalancer --port 80 --target-port 8080

destroy:
	kubectl delete deployments.extensions "beats-as-a-service"
	kubectl delete services "beats-as-a-service"

