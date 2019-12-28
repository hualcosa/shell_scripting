#!/bin/bash

# Redirect STDOUT to a file.
FILE="/tmp/data"
# echo ${FILE}
head -n1 /etc/passwd > ${FILE}
#
# # Redirect STDIN to a program.
# read LINE < ${FILE}
# echo "LINE contains: ${LINE}"
#
# # Redirect STDOUT to a file, overwriting the file.
# head -n3 /etc/passwd > ${FILE}
# echo
# echo "Contents of ${FILE}:"
# cat ${FILE}
#
# # Redirect STDOUT to a file, appending to that file.
# echo "${RANDOM} ${RANDOM}" >> ${FILE}
# echo "${RANDOM} ${RANDOM}" >> ${FILE}
# echo
# echo "Contents of ${FILE}:"
# cat ${FILE}
#
# # Redirect STDIN to a program, using FD 0.
# read LINE1 0< ${FILE}
# echo "LINE contains: ${LINE1}"

# Redirect STDOUT to a file using FD 1, overwriting the file.
# head -n3 /etc/passwd 1> ${FILE}
# echo
# echo "Contents of ${FILE}:"
# cat ${FILE}
#
# # Redirect STDERR to a file, using FD 2.
# ERR_FILE="/tmp/data.err"
# head -n3 /etc/passwd/fakefile 2> ${ERR_FILE}
# cat ${ERR_FILE}
#
# # Redirect STDERR and STDOUT to a file.
# head -n3 /etc/passwd/fakefile &> ${FILE}
# echo
# echo "Contents of file: ${FILE}:"
# cat ${FILE}

# Redirect STDOUT and STDERR through a pipe.
echo
head -n3 /etc/passwd/fakefile |& cat -n

# Send output to STDERR
echo "This is STDERR!!!" >&2

# Discard STDOUT
echo
echo "Discarding STDOUT: "
head -n3 /etc/passwd/fakefile > /dev/null

# Discard STDERR
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd/fakefile 2> /dev/null

# Discard STDOUT and STDERR
echo
echo "Discarding STDOUT AND STDERR:"
head -n3 /etc/passwd/fakefile &> /dev/null

# clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
