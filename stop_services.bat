@echo off

ECHO ################ Stopping Alfresco Community, ActiveMQ, PostgreSQL and SOLR Services ##############
ECHO.

SET ALF_INSTALL_PATH=%1
SET SOLR_INSTALL_PATH=%2
SET ACTIVEMQ_INSTALL_PATH=%3
SET POSTGRES_INSTALL_PATH=%4

:init
	IF "%~1" == "" (
	   SET ALF_INSTALL_PATH=C:\Alfresco
	)
	
	IF "%~2" == "" (
		SET SOLR_INSTALL_PATH=C:\Alfresco\solr6
	)
	
	IF "%~3" == "" (
		SET ACTIVEMQ_INSTALL_PATH=C:\Alfresco\activemq
	)
	
	IF "%~4" == "" (
		SET POSTGRES_INSTALL_PATH=C:\PROGRA~1\PostgreSQL\11
	)
	
	goto stopACS

:stopACS
	echo.
	echo Stopping ACS from %ALF_INSTALL_PATH% ...
	SET CATALINA_HOME=%ALF_INSTALL_PATH%\web-server
	start /MIN /WAIT cmd /c %ALF_INSTALL_PATH%\web-server\bin\catalina.bat stop
	if errorlevel 1 (goto end) else (goto stopDB)

:stopDB
	echo.
	echo Stopping DB from %POSTGRES_INSTALL_PATH% ...
	%POSTGRES_INSTALL_PATH%\bin\pg_ctl.exe stop -D "%POSTGRES_INSTALL_PATH%\data"
	if errorlevel 1 (goto end) else (goto stopActiveMQ)
	
:stopActiveMQ
	echo.
	echo Stopping ActiveMQ from %ACTIVEMQ_INSTALL_PATH% ...
	%ACTIVEMQ_INSTALL_PATH%\bin\activemq.bat stop
	if errorlevel 1 (goto stopSolr)
	
:stopSolr
	echo.
	echo Stopping SOLR from %SOLR_INSTALL_PATH% ...
	%SOLR_INSTALL_PATH%\solr\bin\solr.cmd stop -all
	if errorlevel 1 (goto end)

:end
	echo.
    echo Exiting..
	timeout 10
	