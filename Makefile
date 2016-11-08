TAGS = $(shell find . -maxdepth 1 -type d -regex '\./[0-9]\.[0-9]' | sed 's/\.\///' | sort)
LATEST = $(shell find . -maxdepth 1 -type d -regex '\./[0-9]\.[0-9]' | sed 's/\.\///' | sort | tail -1)
IMAGE =  elasticsearch-aws
REPO = s55labs

.PHONY: default build tag push

default: build

build:
	@for tag in $(TAGS); do \
		set -e ; \
		docker build --pull --tag $(IMAGE):$$tag $$tag/ ; \
	done

tag:
	@for tag in $(TAGS); do \
		set -e ; \
		docker tag $(IMAGE):$$tag $(REPO)/$(IMAGE):$$tag ; \
	done

	@docker tag $(IMAGE):$(LATEST) $(REPO)/$(IMAGE)

push:
	@for tag in $(TAGS); do \
		set -e ; \
		docker push $(REPO)/$(IMAGE):$$tag ; \
	done

	@docker push $(REPO)/$(IMAGE)
