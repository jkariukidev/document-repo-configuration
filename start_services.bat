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
	
	goto startDB

:startDB
	echo Starting DB...
	%POSTGRES_INSTALL_PATH%\bin\pg_ctl.exe start -D "%POSTGRES_INSTALL_PATH%\data"
	if errorlevel 1 (goto end) else (goto startACS)

:startACS
	echo.
	echo Starting ACS...
	SET CATALINA_HOME=%ALF_INSTALL_PATH%\web-server
	start /MIN /WAIT cmd /c %ALF_INSTALL_PATH%\web-server\bin\catalina.bat start
	if errorlevel 1 (goto end) else (goto startSolr)
	
:startSolr
	echo.
	set "initial=false"

	:: check if cores exists
	echo.
	set "initial=false"
	CD %SOLR_INSTALL_PATH%\solrhome
	:: check if cores exists
	
	set Exts=alfresco archive
	for %%A in (%Exts%) do (
	  echo Checking core: %%A
	  if not exist %%A\NUL (
		echo %%A doesn't exist
	    set "initial=true"
	  ) else (
		echo %%A already exist
		set "initial=false"
	  )
	)

	CD %ALF_INSTALL_PATH%
	if "%initial%" == "true" (
		GOTO startSolrInitial
	) else (
		GOTO startSolrConsecutive
	)

:startSolrInitial
	echo.
	echo Starting SOLR for the first time, alfresco and archive cores will be created...	
	start /MIN /WAIT cmd /c %SOLR_INSTALL_PATH%\solr\bin\solr.cmd start -a "-Dcreate.alfresco.defaults=alfresco,archive"
	if errorlevel 1 (goto startActiveMQ)
	
:startSolrConsecutive
	echo.
	echo Starting SOLR...
	start /MIN /WAIT cmd /c %SOLR_INSTALL_PATH%\solr\bin\solr.cmd start
	if errorlevel 1 (goto startActiveMQ)
	
:startActiveMQ
	echo.
	echo Starting ActiveMQ...
	SET ACIVEMQ_HOME=%ACTIVEMQ_INSTALL_PATH%\bin
	start /MIN /WAIT cmd /c %ACTIVEMQ_INSTALL_PATH%\bin\activemq.bat start
	if errorlevel 1 (goto end) else (goto startACS)
	

:end
	echo.
    echo Exiting..
	timeout 10
	