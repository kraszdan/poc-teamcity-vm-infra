.PHONY: format all init plan apply destroy
.SILENT: format all init plan apply destroy

format:
	terraform fmt

all: init plan apply

init:
	terraform init -backend-config=../prerequisites/output/backend.tfvars

plan:
	terraform plan \
		-out=output/tfplan \
		-var-file=../prerequisites/output/region.tfvars \
		-var-file=../virtualmachines/output/ubuntu/ami.tfvars \
		-var-file=../virtualmachines/output/windows/ami.tfvars \
		-var-file=local.tfvars

apply:
	terraform apply output/tfplan

destroy:
	terraform destroy \
		-var-file=../prerequisites/output/region.tfvars \
		-var-file=../virtualmachines/output/ubuntu/ami.tfvars \
		-var-file=../virtualmachines/output/windows/ami.tfvars \
		-var-file=local.tfvars
