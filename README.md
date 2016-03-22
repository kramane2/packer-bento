
#Packer : Bento

If you're working in IT in a delivery capacity, sooner or later you will encounter the pain of provisioning server infrastructure.  Not only do you need to provision the machine and the base OS, but you'll also find yourself toiling away to install and configure the prerequisite software before you can begin the task you're actually interested in completing. 

Luckily tooling in this space is evolving and one of the tools that I use a lot is [Packer](https://www.packer.io).  Packer is a tool for creating identical machine images for multiple platforms.  I most often use Packer in conjunction with [Chef](https://www.chef.io/) to install and configure the prerequisite software on the machine image(s), and virtualbox (or VMware Fusion) to provide the virtualisation environment.

During the development of such images the majority of the iterations are performed locally using [VirtualBox](https://www.virtualbox.org/).  I can then use these images, typically in conjunction with [Vagrant](https://www.vagrantup.com/), to deploy various applications and services.

This repository contains a set of image source files that allow me to build images for the environments in which I work most often.  The concept of the bento box, and the source is highly derived from the [Chef Bento project](https://github.com/chef/bento)

##Repository Organisation

The repository is organised to facilitate composition of the machine images definitions.  This requires the definition of *base boxes* and *derivative boxes*.  Bases boxes are built from an iso and install the specified version of Chef.  If no version is specified the latest version will be installed.  Derivative boxes are created using an existing box as a starting point.  Typically derivative boxes layer software and configuration on top of the source box.

###Base Boxes

Base boxes are located in the boxes directory.  The following base boxes are defined:

####Centos 6.7 x86_64

To create the box you first need to create the var-file.  The var-file can contain the following variables:

| Variable | Type 			| Default | Description |
| -------- | ----- 			| ------- | ----------- |
| headless | String 		| *false* | if *true* build the image without displaying the virtualbox GUI. |
| chef_version | String 	| *latest* | if specified install specified version of Chef otherwise install the latest version. |

#####Example var-file

```
{
  "headless" : "true",
  "chef_version" : "12.6.0"
}
```

To create a Centos 6.7 x86_64 base box execute the following command from the root of the repository:

```
packer build -force -var-file=boxes/centos-6.7-x86_64-variables.json boxes/centos-6.7-x86_64-box.json
```

#####Import box into Vagrant

```
vagrant box remove bento/centos-6.7/chef-12.6.0

vagrant box add bento/centos-6.7/chef-12.6.0 builds/centos-6.7-x86_64.virtualbox.box
```

###Derivative Boxes

Derivative boxes are located in sub directories of the boxes directory.  The following base boxes are defined:

####Java 8

#####Pre-requisites
The Java 8 box can be built from any base box.

To create the box you first need to create the var-file.  The var-file can contain the following variables:

| Variable | Type 			| Default | Description |
| -------- | ----- 			| ------- | ----------- |
| headless | String 		| *false* | if *true* build the image without displaying the virtualbox GUI. |
| base_box | String 	|  | the ovf on which to base this derivative box. |
| provider | String 	| | the virtualisation provider of the base box and derivative box. |


#####Example var-file

```
{
  "headless": "true",
  "base_box": "centos-6.7-x86_64",
  "provider": "virtualbox"
}
```

To create a Java 8 box execute the following command from the root of the repository:

```
packer build -force -var-file=boxes/java/8/variables.json boxes/java/8/box.json
```

#####Import box into Vagrant

```
vagrant box remove bento/centos-6.7/chef-12.6.0/java-8

vagrant box add bento/centos-6.7/chef-12.6.0/java-8 builds/centos-6.7-x86_64.java8.virtualbox.box
```

#####Jenkins

The Jenkins box can be built from *any* Java derivative box.

To create the box you first need to create the var-file.  The var-file can contain the following variables:

| Variable | Type 			| Default | Description |
| -------- | ----- 			| ------- | ----------- |
| headless | String 		| *false* | if *true* build the image without displaying the virtualbox GUI. |
| base_box | String 	|  | the ovf on which to base this derivative box. |
| provider | String 	| | the virtualisation provider of the base box and derivative box. |

#####Example var-file

```
{
  "headless": "true",
  "base_box": "centos-6.7-x86_64.java8",
  "provider": "virtualbox"
}
```

To create a Jenkins box execute the following command from the root of the repository:

```
packer build -force -var-file=boxes/jenkins/variables.json boxes/jenkins/box.json
```

#####Import box into Vagrant

```
vagrant box remove bento/centos-6.7/chef-12.6.0/java-8/jenkins

vagrant box add bento/centos-6.7/chef-12.6.0/java-8/jenkins builds/centos-6.7-x86_64.java8.jenkins.virtualbox.box
```
