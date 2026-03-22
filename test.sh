#!/bin/bash

testsFailed=0

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

echo "## Test 1: Good file" >> "$GITHUB_STEP_SUMMARY"

echo "OK" > good.txt
git add good.txt
git commit -m "Good"

./entrypoint.sh
[[ $? -eq 0 ]] || ((testsFailed+=1))

echo "## Test 2: Good file and bad file" >> "$GITHUB_STEP_SUMMARY"

printf '\xE2\x9D\x8C' > bad.txt
git add bad.txt
git commit -m "Bad"

./entrypoint.sh
[[ $? -eq 1 ]] || ((testsFailed+=1))

exit $testsFailed
