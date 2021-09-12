@ECHO OFF

CALL :CASE_%1
IF ERRORLEVEL 1 CALL :DEFAULT_CASE

ECHO Done!
EXIT /B

:CASE_remove
    ECHO Removing...
    docker-compose down -v
    GOTO END_CASE

:CASE_rebuild
    ECHO Removing...
    docker-compose down -v
    ECHO Building...
    docker-compose up -d --build
    GOTO CASE_keys
    GOTO END_CASE

:CASE_build
    ECHO Building...
    docker-compose up -d --build
    GOTO CASE_keys
    GOTO END_CASE

:CASE_restart
    ECHO Stopping...
    docker-compose down
    ECHO Starting...
    docker-compose up -d
    GOTO CASE_keys
    GOTO END_CASE

:CASE_stop
    ECHO Stopping...
    docker-compose down
    GOTO END_CASE

:CASE_start
    ECHO Starting...
    docker-compose up -d
    GOTO CASE_keys
    GOTO END_CASE

:CASE_keys
    docker container exec -w /root php80 ./keys.sh
    docker container exec -w /root php74 ./keys.sh
    docker container exec -w /root node ./keys.sh
    GOTO END_CASE

:DEFAULT_CASE
    ECHO Unknown function %1
    GOTO END_CASE
:END_CASE
    GOTO :EOF