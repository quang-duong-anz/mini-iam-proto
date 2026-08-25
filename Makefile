.PHONY: lint generate breaking

lint:
	buf lint

generate:
	buf generate

# Compares against the last commit on main to catch breaking API changes.
breaking:
	buf breaking --against '.git#branch=main'
