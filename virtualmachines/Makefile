.PHONY: format init build build-ubuntu build-windows export export-ubuntu export-windows
.SILENT: format init build build-ubuntu build-windows export export-ubuntu export-windows

PACKER_BUILD = packer build -on-error=ask -var-file="local.pkrvars.hcl" -var-file="../prerequisites/output/export.json"

format:
	packer fmt .

init:
	packer init .

build: build-ubuntu build-windows

export: export-ubuntu export-windows

build-ubuntu:
	$(PACKER_BUILD) -only=virtualbox-iso.teamcity-ubuntu .

export-ubuntu:
	$(PACKER_BUILD) -only=file.teamcity-ubuntu . | tee output/ubuntu/export.log
	./extract-ami-id.sh ubuntu

build-windows:
	$(PACKER_BUILD) -only=virtualbox-iso.teamcity-windows .

export-windows:
	$(PACKER_BUILD) -only=file.teamcity-windows . | tee output/windows/export.log
	./extract-ami-id.sh windows

