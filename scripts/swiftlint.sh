#!/bin/sh

if ! which mint >/dev/null; then
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
  exit 0
fi

PROJECT_GIT_DIR=$1
START_DATE=$(date +"%s")

run_lint() {
  local filepath=$(readlink -f "${PROJECT_GIT_DIR}/${1}")
  xcrun --sdk macosx mint run swiftlint swiftlint "${filepath}"
}

git diff --diff-filter=d --name-only -- "*.swift" | while read filename; do run_lint "${filename}"; done
git diff --cached --diff-filter=d --name-only -- "*.swift" | while read filename; do run_lint "${filename}"; done

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "SwiftLint took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
