REPOSITORY := $(AWS_ACCOUNT).dkr.ecr.ap-northeast-1.amazonaws.com/rails-ecs-boilerplate

build:
	docker build -t rails-ecs-boilerplate .

tag:
	docker tag rails-ecs-boilerplate:latest $(REPOSITORY):latest

push: tag
	docker push $(REPOSITORY):latest
