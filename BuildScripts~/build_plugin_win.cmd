@echo off

set LIBWEBRTC_DOWNLOAD_URL=https://github.com/Unity-Technologies/com.unity.webrtc/releases/download/M116-20250805/webrtc-win.zip
set LIBWEBRTC_ZIP_PATH=%cd%\artifacts\webrtc-win.zip

set SOLUTION_DIR=%cd%\Plugin~

set "BUILD_TYPE=%~1"
if "%BUILD_TYPE%"=="" set "BUILD_TYPE=release"
if /i "%BUILD_TYPE%"=="debug" (
  set CMAKE_BUILD_TYPE=Debug
) else (
  set CMAKE_BUILD_TYPE=Release
)
call "%~dp0env_win.cmd"

echo Download LibWebRTC

if not exist %SOLUTION_DIR%\webrtc (
  copy /Y "%LIBWEBRTC_ZIP_PATH%" .\webrtc.zip
  7z x -aoa webrtc.zip -o%SOLUTION_DIR%\webrtc
)

echo Build com.unity.webrtc Plugin

rem CMake doesn't support building CUDA kernel with Clang compiler on Windows. 
rem https://gitlab.kitware.com/cmake/cmake/-/issues/20776
rem This program use CUDA kernel to change the video resolution when using NVIDIA Video Codec.

cd %SOLUTION_DIR%
cmake --preset=x64-windows-msvc -T v142,version=14.29 -DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% -DBUILD_TESTING=OFF
cmake --build --preset=release-windows-msvc --target=WebRTCPlugin