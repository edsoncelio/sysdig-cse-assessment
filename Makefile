
.PHONY: help
help: ## this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

     
.PHONY: expose-vote
expose-vote: ## expose the vote endpoint
		@echo "expose the vote endpoint"
		kubectl port-forward svc/vote 8080:8080 -n voting-app

.PHONY: expose-results
expose-results: ## expose the result sendpoint
		@echo "expose the result endpoints"
		kubectl port-forward svc/result 8081:8081 -n voting-app

