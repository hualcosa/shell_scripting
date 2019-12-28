#!/bin/bash

# This script demonstrates the use of functions.
log() {
  # This function sends a message to syslog and to standard output if VERBOSE is true.

  local MESSAGE="${@}"
  if [[ "${VERBOSE}" -eq 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t demo10-hugo.sh "${MESSAGE}"

}
backup_file() {
  # This function creates a backup of a file.  Returns non-zero status on error.

  local FILE="${1}"

  # make sure the file exists.
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command.
    # -p stands for "preserve" and it keeps unaltered the timestamp of the file.
    cp -p ${FILE} ${BACKUP_FILE}

    # Make a decision based on the exit status of the cp command
    if [[ "${?}" -eq '0' ]]
    then
      log 'File backup succeded!'
    else
      log 'File backup failed!'
    fi
  else
    # The file does not exist, so return a non zero status.
    return 1
  fi
}


readonly VERBOSE='true'
log 'Hello!'
log 'This is fun!'
backup_file /etc/passwd
