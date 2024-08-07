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

# Ensure we're on the master branch
git checkout master

# Fetch the latest tags
git fetch origin --tags

latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

if [ -z "$latest_tag" ]; then
    echo "No tags found in the repository."
    exit 1
fi

commits=$(git log ${latest_tag}..master --pretty=format:"%H %ci %s" --reverse)

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
