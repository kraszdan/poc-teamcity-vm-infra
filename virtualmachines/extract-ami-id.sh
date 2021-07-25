#!/usr/bin/env bash

set -ue

FAMILY="${1:-'Wrong usage'}"
AMI_ID="$(grep -h ': ami-' "output/${FAMILY}/export.log" | cut -d' ' -f2)"

echo -n "teamcity_${FAMILY}_ami_id = \"${AMI_ID}\"" > "output/${FAMILY}/ami.tfvars"
