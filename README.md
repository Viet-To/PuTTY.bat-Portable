# PuTTY.bat-Portable
Script Version 1.0.1 2024-09-01


This script is to automate these instructions @ https://documentation.help/PuTTY/config-file.html#S4.29  to make PuTTY portable between different computers.

## Instructions:
1. Download and extract PuTTY (https://the.earth.li/~sgtatham/putty/latest/w64/putty.zip or https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) to a folder/DropBox/USB_Drive/etc
2. Download putty.bat and place in the same folder as above
3. Launch putty.bat. It will backup the computer's Registry settings for PuTTY, and import the portable Registry settings. On closing of PuTTY, it will export and save the current settings and restore the Registry from before putty.bat was launched.
