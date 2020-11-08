ECHO on
set BAZEL=\bazel\bazel.exe --output_user_root=d:\bazel\anki --output_base=d:\bazel\anki\base 
set BUILDARGS=--config=ci --disk_cache=c:\bazel\disk --repository_cache=c:\bazel\repo
REM rollup will fail on the first build
call %BAZEL% build %BUILDARGS% ... -k

call %BAZEL% test %BUILDARGS% ...
IF %ERRORLEVEL% NEQ 0 exit /B 1
