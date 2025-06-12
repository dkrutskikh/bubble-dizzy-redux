#!/bin/bash

# Script to determine whether the source code in the Pull Request is formatted correctly.
# Exits with a non-zero exit code if formatting is needed.
#
# It is assumed that this script is called from the project root directory.

set -e -o pipefail

FILES_TO_CHECK=$(git diff --name-only HEAD^ | (grep -E ".*\.(cpp|cc|c\+\+|cxx|c|h|hpp|inl|java|js)$" || true) \
                                            | (grep -v "^src/thirdparty/.*/.*" || true))

if [ -z "$FILES_TO_CHECK" ]; then
  echo "There is no source code to check the formatting."
  exit 0
fi

if FORMAT_DIFF=$(git diff -U0 HEAD^ -- $FILES_TO_CHECK | clang-format-diff -p1 -style=file) && [ -z "$FORMAT_DIFF" ]; then
  echo "All the source code in the PR is formatted correctly."
  exit 0
else
  echo "Formatting errors found!"
  echo "$FORMAT_DIFF"
  exit 1
fi
