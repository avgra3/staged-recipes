
cmake %CMAKE_ARGS% -G"Ninja" ^
      -S%SRC_DIR% ^
      -Bbuild ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_C_FLAGS="/wd4101 /wd4996 %CFLAGS%" ^
      -DCMAKE_CXX_FLAGS="/wd4101 /wd4996 %CXXFLAGS%" ^
      -DPYMOD_INSTALL_LIBDIR="/" ^
      -DPYTHON_EXECUTABLE="%PYTHON%" ^
      -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
      -DBUILD_SHARED_LIBS=ON ^
      -DENABLE_OPENMP=OFF ^
      -DCMAKE_INSIST_FIND_PACKAGE_pybind11=ON ^
      -DCMAKE_INSIST_FIND_PACKAGE_qcelemental=ON ^
      -DCMAKE_DISABLE_FIND_PACKAGE_libefp=ON ^
      -DENABLE_XHOST=OFF ^
      -DBUILD_TESTING=OFF ^
      -DFRAGLIB_UNDERSCORE_L=OFF ^
      -DFRAGLIB_DEEP=OFF ^
      -DINSTALL_DEVEL_HEADERS=ON ^
      -DLAPACK_LIBRARIES="%PREFIX%/Library/lib/mkl_rt.lib"

if errorlevel 1 exit 1

cd build
cmake --build . ^
      --config Release ^
      --target install ^
      -- -j %CPU_COUNT%
if errorlevel 1 exit 1

:: tests outside build phase

:: Relocate python scripts to expected location:
xcopy /f /i /s /y "%PREFIX%\Library\lib\pylibefp" "%SP_DIR%\pylibefp"
if errorlevel 1 exit 1
