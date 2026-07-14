#!/bin/bash
set -e

swift build

APP_NAME="FocusNotch"
BUILD_DIR=".build/debug"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"

mkdir -p "$APP_BUNDLE/Contents/MacOS"
cp "$BUILD_DIR/$APP_NAME" "$APP_BUNDLE/Contents/MacOS/"
cp "Info.plist" "$APP_BUNDLE/Contents/"
codesign --force --sign - --deep "$APP_BUNDLE"

echo "✅ App bundle created at $APP_BUNDLE"
echo "Run with: open $APP_BUNDLE"
