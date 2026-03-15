#!/bin/sh

if ! which mint >/dev/null; then
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
  exit 0
fi

START_DATE=$(date +"%s")

RUN_LINT=false
for arg in "$@"; do
  if [ "$arg" = "--lint" ]; then
    RUN_LINT=true
  fi
done

run_format() {
  local filepath=$(readlink -f "${1}")
  xcrun --sdk macosx mint run swiftformat swiftformat "${filepath}"
}

if [ "$RUN_LINT" = true ]; then
  project_path=$(readlink -f ".")
  xcrun --sdk macosx mint run swiftformat swiftformat --lint "${project_path}"
else
  git diff --diff-filter=d --name-only -- "*.swift" | while read filename; do run_format "${filename}"; done
  git diff --cached --diff-filter=d --name-only -- "*.swift" | while read filename; do run_format "${filename}"; done
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "SwiftFormat took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
