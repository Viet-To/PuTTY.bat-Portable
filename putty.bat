@ECHO OFF
REM This script is to automate these instructions @ https://documentation.help/PuTTY/config-file.html#S4.29
REM Script Version 1.0.1 2024-09-01
REM https://github.com/Viet-To/PuTTY.bat-Portable

set ProgramName=PuTTY


REM Start of comment block Versions
	REM How-to comment block https://www.robvanderwoude.com/comments.php
	GOTO Versions
	App Versions tested:
		Release 0.81	https://www.chiark.greenend.org.uk/~sgtatham/putty/releases/0.81.html
		Release 0.79	https://www.chiark.greenend.org.uk/~sgtatham/putty/releases/0.79.html
		Release 0.59	https://www.chiark.greenend.org.uk/~sgtatham/putty/releases/0.59.html

	https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
	https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe
	
	Windows Versions tested:
		Windows 10
:Versions
	REM See above. Ends coment block Versions


:Warning
	REM you can escape shell metacharacters with ^
	REM Color Text https://gist.githubusercontent.com/mlocati/fdabcaeb8071d5c75a2d51712db24011/raw/b710612d6320df7e146508094e84b92b34c77d48/win10colors.cmd
	Echo /------------------------------------------------------------------------------------\
	echo ^|  [31mWarning[0m                                                                           ^|
	echo ^|Do not close this window, as it handles import/export of profile settings for %ProgramName% ^|
	echo ^|                                                                                    ^|
	Echo ^|This window will automatically close when %ProgramName% is closed                           ^|
	echo \------------------------------------------------------------------------------------/

:Reg_Creation
	REM https://www.dostips.com/forum/viewtopic.php?p=67479#p67479 Echo blank lines
	
	REM Creates puttydel.reg file
	echo REGEDIT4>puttydel.reg
	echo( >>puttydel.reg
	echo [-HKEY_CURRENT_USER\Software\SimonTatham\PuTTY]>>puttydel.reg

	REM Creates puttyrnd.reg file
	echo REGEDIT4>puttyrnd.reg
	echo( >>puttyrnd.reg
	echo [HKEY_CURRENT_USER\Software\SimonTatham\PuTTY]>>puttyrnd.reg
	echo "RandSeedFile"="putty.rnd">>puttyrnd.reg




REM https://www.eolsoft.com/freeware/registry_jumper/regedit_switches.htm
	REM For silent execution of the Regedit program, use the /s parameter
	REM To export all registry contens to the file c:\all.reg, use the /e switch as follows:
	REM regedit /E c:\all.reg
	REM To export a specific registry key to the file file.reg, use the /e switch as follows:
	REM regedit /E file.reg <registry_key>

:Backup
	REM Backup existing Registry on HOST
	regedit /ea host.reg HKEY_CURRENT_USER\Software\SimonTatham\PuTTY

	REM Removes Putty registry key [-HKEY_CURRENT_USER\Software\SimonTatham\PuTTY] so we work in a clean registry environment
	regedit /s puttydel.reg

:Import
	REM Imports putty.reg (which contains your profiles) to Registry
	regedit /s putty.reg

	REM Adds putty.rnd to Registry
	regedit /s puttyrnd.reg

:Launch
	REM start /w halts the batch script and does not continue until the program is closed
	echo( & echo Starting %ProgramName%
	start /w putty.exe

	REM When above program is closed, do the following



:Export
	REM https://github.com/geekcomputers/Batch/blob/master/putty_backup.bat
	REM The /e is for part of the registry, in this case the key listed above in the variable regkey
	REM The /a is for ASCII output, if you omit the /a the file will be twice a large
	regedit /ea new.reg HKEY_CURRENT_USER\Software\SimonTatham\PuTTY
	copy new.reg putty.reg
	del new.reg
	echo Exporting Registry

:Sanitize
	REM Removes Putty registry key [-HKEY_CURRENT_USER\Software\SimonTatham\PuTTY]
	regedit /s puttydel.reg
	echo Sanitizing Registry

:Restore
	REM Restores backup of HOST
	regedit /s host.reg
	echo Restoring HOST registry
	timeout 10
		REM timeout may not work on older Windows Versions
