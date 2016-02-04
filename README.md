
#Packer : Bento

packer build -force -var-file=boxes/centos-6.7-x86_64-variables.json boxes/centos-6.7-x86_64-box.json
packer build -force -var-file=boxes/java/8/variables.json boxes/java/8/box.json
packer build -force -var-file=boxes/jenkins/variables.json boxes/jenkins/box.json


vagrant box remove bento/centos-6.7/chef-12.6.0
vagrant box remove bento/centos-6.7/chef-12.6.0/java-8
vagrant box remove bento/centos-6.7/chef-12.6.0/java-8/jenkins

vagrant box add bento/centos-6.7/chef-12.6.0 builds/centos-6.7-x86_64.virtualbox.box
vagrant box add bento/centos-6.7/chef-12.6.0/java-8 builds/centos-6.7-x86_64.java8.virtualbox.box
vagrant box add bento/centos-6.7/chef-12.6.0/java-8/jenkins builds/centos-6.7-x86_64.java8.jenkins.virtualbox.box
