#!/bin/bash

echo "==> Loading Requirements"
terraform init
echo "===> Checking / Planning ..."
terraform plan -out plan
echo "====> Applying manifests ..."
terraform apply plan 
