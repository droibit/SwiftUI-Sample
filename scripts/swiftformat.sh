#!/bin/sh

if which mint >/dev/null; then
  xcrun --sdk macosx mint run nicklockwood/SwiftFormat swiftformat ./Sources
else
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
fi    