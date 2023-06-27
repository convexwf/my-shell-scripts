#!/bin/bash

## Script to commit to git with a random date between 9am and 11pm on a given date
## Usage: ./git-commit.sh <date> <commit_message>
## Example: ./git-commit.sh "2020-01-01" "Coding Challenges"

input_date=$1
commit_message=$2
if [ -z "$input_date" ] || [ -z "$commit_message" ]; then
  echo "Usage: $0 <date> <commit_message>"
  exit 1
fi

# generate a number representing the hour between 9 and 23
random_hour=$((RANDOM % 15 + 9))
random_time=$(printf "%02d:%02d:%02d" $random_hour $((RANDOM%60)) $((RANDOM%60)))

formatted_date=$(date -d "$input_date" +"%b %-d $random_time %Y %z")

echo "$formatted_date" "${commit_message}"

GIT_COMMITTER_DATE="$formatted_date" git commit --date="$formatted_date" -m "${commit_message}"
