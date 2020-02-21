pdk=/usr/local/bin/pdk
puppet=/opt/puppetlabs/bin/puppet

.PHONY: help validate test apply release deploy

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

validate: ## Run static analysis tests with PDK
	${pdk} validate --parallel

test: ## Run tests with PDK
	${pdk} test unit --parallel

apply: ## Run puppet apply locally with --noop
ifeq ("$(wildcard examples/init.pp)","examples/init.pp")
	${puppet} apply examples/init.pp --noop
else
	@echo "Skipping 'puppet apply' step because missing examples/init.pp"
endif

release: ## Release module
	@echo "Not implemented - release puppet module with git tag->bb->r10k"

deploy: ## Upload module to repository
	@echo "Not implemented - upload puppet module to repository"
