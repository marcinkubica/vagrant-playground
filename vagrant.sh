#!/usr/bin/env bash
set -euo pipefail
pp='\033[0;35m' #purple
nc='\033[0m\n'  #no color + newline

if [ "${VAGRANT_TRIGGER:-}" == "false" ]
  then
    printf "%bVAGRANT_TRIGGER is false. Skipping provisioning.%b" "${pp}" "${nc}"
  else
    printf "%b# prepping vagrant VMs%b" "${pp}" "${nc}"
    ansible-playbook test-site.yml

    printf "%b## FINISHED ##%b" "${pp}" "${nc}"
fi