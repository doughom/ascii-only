#!/bin/bash

failedFiles=0

echo "" >> "$GITHUB_STEP_SUMMARY"
echo "| File | Status |" >> "$GITHUB_STEP_SUMMARY"
echo "| --- | --- |" >> "$GITHUB_STEP_SUMMARY"

while IFS= read -r -d "" file; do
  output=$(mktemp)
  if LC_ALL=C grep -nP "[^[:ascii:]]" "$file" > "$output"; then
    sed -i -E "s/^([0-9])+/::error file=$file,line=\1:/g" "$output"
    cat "$output"
    ((failedFiles+=1))
    echo "| $file | FAIL |" >> "$GITHUB_STEP_SUMMARY"
  else
    echo "| $file | PASS |" >> "$GITHUB_STEP_SUMMARY"
  fi
done < <(git diff --name-only -z "origin/$GITHUB_BASE_REF")

exit $failedFiles
