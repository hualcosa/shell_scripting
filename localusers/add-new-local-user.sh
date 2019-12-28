#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo 'The script needs to be executed with superuser privileges'
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
USAGE=${#}
if [[ ${USAGE} -eq 0 ]]
then
  echo "Usage: ${USAGE} USER_NAME [COMMENT]..."
  echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT."
  exit 1
fi

# The first parameter is the user name
# The rest of the parameters are for the account comments.
USER_NAME="${1}"
shift
COMMENT="${@}"

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created'
  exit 1
fi
# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd succeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# Force password change on the first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
