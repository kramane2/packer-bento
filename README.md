
packer build -force -var-file=variables.json centos-6.7-x86_64.json

packer build -var "chef_version=12.6.0" centos-6.7-x86_64.json
