#!/usr/bin/env bash
# Student and system information script — Ruslan Omargali (IT2-2309)

# Folder of this script and of the project (works from any current directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INFO_FILE="$PROJECT_DIR/Omargali_Ruslan_info.txt"

LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo
echo "Name: Ruslan"
echo "Surname: Omargali"
echo "Group: IT2-2309"
echo "Student ID: 37858"
echo
echo "$LINE"
echo "System Information"
echo "$LINE"
echo

# Operating system name: from /etc/os-release if available, otherwise uname
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_NAME="$PRETTY_NAME"
else
  OS_NAME="$(uname -s)"
fi

echo "Username: $(whoami)"
echo "Hostname: $(hostname 2>/dev/null || cat /etc/hostname)"
echo "Current Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Operating System: $OS_NAME, kernel $(uname -r) ($(uname -m))"
echo "Disk Usage:"
df -h /
echo "Memory Usage:"
free -h
echo

# Check that the student information file exists
if [ -f "$INFO_FILE" ]; then
  echo "Student information file exists."
else
  echo "Student information file does not exist."
fi
