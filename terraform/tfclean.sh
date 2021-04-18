#!/bin/bash

terraform destroy --auto-approve

rm -rf .terraform
rm -f .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup