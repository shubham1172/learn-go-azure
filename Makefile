# source: https://www.zachjohnsondev.com/posts/go-docker-hot-reload-example/
default:
	@echo "=============building Local API============="
	docker build -t learn-go-azure:latest .

up: default
	@echo "=============starting api locally============="
	docker-compose up

logs:
	docker-compose logs -f

down:
	docker-compose down

test:
	go test -v -cover ./...