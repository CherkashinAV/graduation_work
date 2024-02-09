.PHONY: clear-docker
clear-docker:
	@echo "Clearing docker..."
	@docker stop `docker ps -qa`
	@docker rm `docker ps -qa`
	@docker rmi -f `docker images -qa `
	@docker volume prune

.PHONY: services-run
services-run:
	@echo "Running services..."
	@docker compose up -d
	@echo "Done"
	@echo "Migrating..."
	@echo "Passport DB: "
	@cd ./passport && make db.migrate
	@echo "Sender DB: "
	@cd ./sender && make db.migrate
	@echo "Themes DB: "
	@cd ./themes && make db.migrate