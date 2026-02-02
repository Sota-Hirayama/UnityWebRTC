set "vs2022_install=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
set "VCToolsVersion=14.29.30133"
@REM set VCToolsInstallDir=%vs2022_install%\VC\Tools\MSVC\%VCToolsVersion%
@REM set GYP_MSVS_OVERRIDE_PATH=%vs2022_install%
@REM call "%vs2022_install%\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64 -vcvars_ver=14.29

@REM cl.exeなどのBuildTools付属のツールを使うためにpathを通してもらう
set "VSDEVCMD=%vs2022_install%\Common7\Tools\VsDevCmd.bat"
if exist "%VSDEVCMD%" (
  call "%VSDEVCMD%" -arch=amd64 -host_arch=amd64 -vcvars_ver=%VCToolsVersion%
) else (
  echo Warning: VsDevCmd.bat not found at "%VSDEVCMD%"
)
