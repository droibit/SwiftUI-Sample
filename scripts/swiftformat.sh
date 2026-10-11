#!/bin/sh

if ! which mint >/dev/null; then
  # Xcode build phases treat this as a warning so builds still succeed without Mint.
  if [ -n "${XCODE_VERSION_ACTUAL}" ]; then
    echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
    exit 0
  fi
  echo "error: Mint not installed, download from https://github.com/yonaskolb/Mint" >&2
  exit 1
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

changed_swift_files() {
  {
    git diff --diff-filter=d --name-only -- "*.swift"
    git diff --cached --diff-filter=d --name-only -- "*.swift"
    git ls-files --others --exclude-standard -- "*.swift"
  } | sort -u
}

if [ "$RUN_LINT" = true ]; then
  project_path=$(readlink -f ".")
  xcrun --sdk macosx mint run swiftformat swiftformat --lint "${project_path}"
else
  changed_swift_files | while read filename; do run_format "${filename}"; done
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "SwiftFormat took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
