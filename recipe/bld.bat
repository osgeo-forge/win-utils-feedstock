REM nircmd(c).exe from http://www.nirsoft.net/utils/nircmd-x64.zip

:: Just textreplace.exe needs built
nmake /f makefile.vc clean
nmake /f makefile.vc textreplace.exe

copy textreplace.exe "%LIBRARY_BIN%"

pushd osgeo4w\install-x86_64

  copy bin\nircmd.exe "%LIBRARY_BIN%"
  copy bin\nircmdc.exe "%LIBRARY_BIN%"

  set "LIBRARY_DOC=%LIBRARY_PREFIX%\doc"
  if not exist "%LIBRARY_DOC%" md "%LIBRARY_DOC%"
  copy apps\msvcrt\NirCmd.chm "%LIBRARY_DOC%"

popd

:: Build winhttp-head
pushd winhttp-head
  set BUILDDIR=%CD%\build
  set BUILDCONF=RelWithDebInfo

  if exist %BUILDDIR% rd /s /q %BUILDDIR%
  md %BUILDDIR%
  cd %BUILDDIR%
  if errorlevel 1 (echo build directory creation failed & goto error)

  cmake -G "%CMAKE_GENERATOR%" ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -D CMAKE_BUILD_TYPE=%BUILDCONF% ^
    -D CMAKE_CONFIGURATION_TYPES=%BUILDCONF% ^
    -D CMAKE_CXX_FLAGS_RELWITHDEBINFO="/MD /Zi /MP /Od /D NDEBUG" ^
    ..
  if errorlevel 1 (echo cmake configure failed & goto error)


  cmake --build %BUILDDIR% --config %BUILDCONF%
  if errorlevel 1 (echo cmake build failed & goto error)

  cmake --build %BUILDDIR% --target INSTALL --config %BUILDCONF%
  if errorlevel 1 (echo cmake install failed & goto error)
popd

exit /b 0

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
