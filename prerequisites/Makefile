.PHONY: format all init plan apply destroy
.SILENT: format all init plan apply destroy

format:
	terraform fmt

all: init plan apply

init:
	terraform init

plan:
	terraform plan -out=output/tfplan

apply:
	terraform apply output/tfplan

destroy:
	terraform destroy
