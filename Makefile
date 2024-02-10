.PHONY: clear-docker
clear-docker:
	@echo "Clearing docker..."
	@docker stop `docker ps -qa`
	@docker rm `docker ps -qa`
	@docker rmi -f `docker images -qa `
	@docker volume prune

.PHONY: migrate-passport
migrate-passport: export DB_CONNECTION_NAME=passport
migrate-passport:
	@echo "Passport DB: "
	@cd ./passport && make db.migrate 

.PHONY: migrate-sender
migrate-sender: export DB_CONNECTION_NAME=sender
migrate-sender:
	@echo "Sender DB: "
	@cd ./sender && make db.migrate

.PHONY: migrate-themes
migrate-themes: export DB_CONNECTION_NAME=themes
migrate-themes:
	@echo "Themes DB: "
	@cd ./themes && make db.migrate

.PHONY: up-services
up-services:
	@echo "Running services..."
	@docker compose up -d
	@echo "Done"

.PHONY: migrate
migrate: migrate-themes
migrate: migrate-passport
migrate: migrate-sender

.PHONY: services-run
services-run: up-services
services-run: migrate