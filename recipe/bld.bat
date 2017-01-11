set CMAKE_CONFIG=Release

mkdir build_%CMAKE_CONFIG%
pushd build_%CMAKE_CONFIG%

cmake -G"%CMAKE_GENERATOR%" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DBUILD_SHARED_LIBS:BOOL=ON ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DGFLAGS_REGISTER_BUILD_DIR:BOOL=OFF ^
      -DGFLAGS_REGISTER_INSTALL_PREFIX:BOOL=OFF ^
      -DBUILD_gflags_nothreads_LIB:BOOL=OFF ^
      "%SRC_DIR%"

cmake --build . --target install --config %CMAKE_CONFIG%

:: move the gflags dll to bin
move "%LIBRARY_LIB%\gflags.dll" "%LIBRARY_BIN%\gflags.dll"

:: patch the cmake file accordingly
"%PYTHON%" "%RECIPE_DIR%\patch_cmake_targets.py" ^
           "%LIBRARY_PREFIX%\CMake\gflags-targets-release.cmake" ^
           "${_IMPORT_PREFIX}/Lib/gflags.dll" ^
           "${_IMPORT_PREFIX}/bin/gflags.dll"

popd