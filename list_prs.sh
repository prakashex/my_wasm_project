#!/bin/bash

usage() {
    echo "Usage: $0 [-s]"
    echo "  -s    Output only the PR numbers and no other details"
    exit 1
}

silent=false
while getopts ":s" opt; do
    case ${opt} in
        s)
            silent=true
            ;;
        \?)
            usage
            ;;
    esac
done

git fetch --tags

latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

commits=$(git log ${latest_tag}..master --pretty=format:"%H %ci %s" --reverse)

echo "PR numbers and their commit messages merged into main since the last tag (${latest_tag}):"
echo "Listed in ascending order (oldest to most recent):"

echo "$commits" | while read -r hash date time timezone message; do
    if [[ $message =~ Merge\ pull\ request\ \#([0-9]+) ]]; then
        pr_number=${BASH_REMATCH[1]}
        if $silent; then
            echo "#${pr_number}"
        else
            echo "#${pr_number} - ${message}"
        fi
    fi
done
