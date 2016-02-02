#!/bin/sh -eux

curl -LO https://www.chef.io/chef/install.sh && sudo bash ./install.sh -v $CHEF_VERSION && rm install.sh
