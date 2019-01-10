REM nircmd(c).exe from http://www.nirsoft.net/utils/nircmd-x64.zip

:: Just textreplace.exe needs built
nmake /f makefile.vc clean
nmake /f makefile.vc textreplace.exe

copy textreplace.exe "%LIBRARY_BIN%"

pushd osgeo4w\install-x86_64

  copy bin\nircmd.exe "%LIBRARY_BIN%"
  copy bin\nircmdc.exe "%LIBRARY_BIN%"

  set "LIBRARY_DOC=%LIBRARY_PREFIX%\doc"
  if not exist "%LIBRARY_DOC%" mkdir "%LIBRARY_DOC%"
  copy apps\msvcrt\NirCmd.chm "%LIBRARY_DOC%"

popd

exit /b 0
