#!/bin/bash

# this script generates a list of random passwords
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# three random numbers together
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# use the current date/time as the basis for the password.
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# use the nanoseconds to act as a randomization.
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# a better password.
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# an even better password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# Append a special character to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"
