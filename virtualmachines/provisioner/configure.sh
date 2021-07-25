#!/usr/bin/env bash

set -eu

# Parameters
BASTION_USER="${BASTION_USER:-Missing BASTION_USER env}"
BASTION_HOST="${BASTION_HOST:-Missing BASTION_HOST env}"
DISTRIBUTION="${DISTRIBUTION:-Missing DISTRIBUTION env}"
NODE_HOST="${NODE_HOST:-Missing NODE_HOST env}"
NODE_VARS="${NODE_VARS:-Missing NODE_VARS env}"

# Inventory based on distribution
INVENTORY="inventories/${DISTRIBUTION}/hosts.yml"

# Management port
NODE_PORT="22"
if [[ "${DISTRIBUTION}" == "windows" ]]; then
  NODE_PORT="5985"
fi

# SSH tunnel configuration
LOCAL_PORT="$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')"
TUNNEL="${LOCAL_PORT}:${NODE_HOST}:${NODE_PORT}"

# Fix fork() exceptions in Ansible
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Prepare temp path for socket used to close tunnel
SOCKET=$(mktemp -t bastion-tunnel)
rm "${SOCKET}"

# Clean thins up when requested
cleanup () {
  if [[ -S "${SOCKET}" ]]; then
    echo "Stopping bastion tunneling"
    ssh -S "${SOCKET}" -O exit "${BASTION_USER}@${BASTION_HOST}"
  fi
}

# Attach cleanup outing
trap cleanup EXIT ERR INT TERM

# Open tunnel
ssh -fNMT -o ExitOnForwardFailure=yes -S "${SOCKET}" -L "${TUNNEL}" "${BASTION_USER}@${BASTION_HOST}"

# Apply playbook
ansible-playbook -i "${INVENTORY}" -e "ansible_port=${LOCAL_PORT}" -e "@${NODE_VARS}" -t teamcity vm.yml
