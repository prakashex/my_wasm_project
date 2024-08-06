#!/bin/bash

# Set up some variables
BRANCH_NAME="change-$(date +%s)"  # Generate a unique branch name
COMMIT_MESSAGE="Dummy change at $(date)"  # Generate a unique commit message
FILE_PATH="src/lib.rs"  # File to modify

# Check out a new branch
git checkout -b $BRANCH_NAME

# Make a dummy change
echo "// Dummy comment added by automation script" >> $FILE_PATH

# Stage the changes
git add $FILE_PATH

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push the changes to the remote repository
git push origin $BRANCH_NAME

# Print the new branch name
echo "Changes have been pushed to branch: $BRANCH_NAME"

