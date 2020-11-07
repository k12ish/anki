ECHO on
set BAZEL=\bazel\bazel.exe --output_user_root=\bazel\anki --output_base=\bazel\anki\base
REM rollup will fail on the first build
call %BAZEL% build --config=ci ... -k

call %BAZEL% test --config=ci ...
IF %ERRORLEVEL% NEQ 0 exit /B 1
