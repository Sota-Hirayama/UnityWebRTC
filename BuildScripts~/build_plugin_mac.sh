#!/bin/bash -eu

# TODO : このスクリプトはUnityWebRTCのルートディレクトリで実行することを前提としている

export COMMAND_DIR=$(cd $(dirname $0); pwd)
export ZIP_PATH=$(pwd)/BuildScripts~/artifacts/webrtc-mac.zip
export LIBWEBRTC_DOWNLOAD_URL=https://github.com/Unity-Technologies/com.unity.webrtc/releases/download/M116-20250805/webrtc-mac.zip
export SOLUTION_DIR=$(pwd)/Plugin~
export DYLIB_FILE=$(pwd)/Runtime/Plugins/macOS/libwebrtc.dylib

BUILD_TYPE="${1:-release}"
if [ "$BUILD_TYPE" = "debug" ]; then
  CMAKE_BUILD_TYPE="Debug"
else
  CMAKE_BUILD_TYPE="Release"
fi

# Install cmake
export HOMEBREW_NO_AUTO_UPDATE=1
brew install cmake

# Download LibWebRTC 
##curl -L $LIBWEBRTC_DOWNLOAD_URL > webrtc.zip

echo "cp WebRTC.zip"
rm -rf ./webrtc.zip
cp ${ZIP_PATH} ./webrtc.zip

echo "unzip webRtc.zip"
unzip -d $SOLUTION_DIR/webrtc webrtc.zip 

echo "remove old dylib"

# Remove old dylib file
rm -rf "$DYLIB_FILE"

# Build UnityRenderStreaming Plugin
cd "$SOLUTION_DIR"
cmake --preset=macos -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE -DBUILD_TESTING=OFF
cmake --build --preset=release-macos --target=WebRTCPlugin -verbose
