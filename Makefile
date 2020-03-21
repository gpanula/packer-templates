mainline: centos-mainline

minimal: centos-minimal


centos-minimal:
	packer build centos-8-x86_64-minimal.json

centos-mainline:
	packer build centos-7-x86_64-mainline.json


.PHONY: mainline minimal