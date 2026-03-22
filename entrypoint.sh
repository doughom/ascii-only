#!/bin/bash
exitCode=0

cd "$GITHUB_WORKSPACE"

git remote -v

git fetch origin "$GITHUB_BASE_REF"

while IFS= read -r -d "" file; do
  output=$(mktemp)
  if LC_ALL=C grep -nP "[^[:ascii:]]" "$file" > "$output"; then
    sed -i -E "s/^([0-9])+/::error file=$file,line=\1:/g" "$output"
    cat "$output"
    ((exitCode+=1))
  fi
done < <(git diff --name-only -z "origin/$GITHUB_BASE_REF..$GITHUB_SHA")

exit $exitCode
