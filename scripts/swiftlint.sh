#!/bin/sh

if ! which mint >/dev/null; then
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
  exit 0
fi

START_DATE=$(date +"%s")

RUN_ALL=false
for arg in "$@"; do
  if [ "$arg" = "--all" ]; then
    RUN_ALL=true
  fi
done

run_lint() {
  local filepath=$(readlink -f "${1}")
  xcrun --sdk macosx mint run swiftlint swiftlint "${filepath}" --strict
}

if [ "$RUN_ALL" = true ]; then
  project_path=$(readlink -f ".")
  xcrun --sdk macosx mint run swiftlint swiftlint "${project_path}" --strict
else
  git diff --diff-filter=d --name-only -- "*.swift" | while read filename; do run_lint "${filename}"; done
  git diff --cached --diff-filter=d --name-only -- "*.swift" | while read filename; do run_lint "${filename}"; done
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "SwiftLint took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
