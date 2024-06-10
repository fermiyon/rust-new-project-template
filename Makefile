SHELL := /bin/bash
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

rust-version: ## Display Rust utilities' versions
	@echo "Rust command-line utility versions:"
	rustc --version 			#rust compiler
	cargo --version 			#rust package manager
	rustfmt --version			#rust code formatter
	rustup --version			#rust toolchain manager
	clippy-driver --version		#rust linter

format: ## Format the code
	cargo fmt --quiet

format-check: ## Check code formatting
	@rustup component add rustfmt 2> /dev/null
	@cargo fmt --all -- --check

lint: ## Lint the code
	cargo clippy --quiet

test: ## Run tests
	cargo test --quiet

run: ## Run the application
	cargo run

release: ## Build release version
	cargo build --release

build-release: ## Build release for the current platform
	@echo "Building release version for platfomr $(shell uname -s)"
	cargo build --release 

all: format lint test run
