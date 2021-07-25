.PHONY: all prerequisites virtualmachines infrastructure
.SILENT: all prerequisites virtualmachines infrastructure

all: prerequisites virtualmachines infrastructure

prerequisites:
	cd prerequisites && make all

virtualmachines:
	cd virtualmachines && make all

infrastructure:
	cd infrastructure && make all
