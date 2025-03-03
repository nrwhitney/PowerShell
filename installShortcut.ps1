# create desktop shortcut with desired icon
# and files to run without additional window
 
# powershell filename without extension
$fileName = 'timeDiff'

# desktop shortcut text
$linkName = 'Time difference calculator'

# icon number in windows shell32.dll
$iconNumber = 265

# -----------------------------------

$scriptLocation = "$PSScriptRoot\"
$batch =
'@echo off
powershell.exe -File "' + $scriptLocation + $filename + '.ps1"'
New-Item -Path $scriptLocation -Name "$fileName.bat" -ItemType "file" -Value $batch
$vbScript =
'command = """' + $scriptLocation + $filename + '.bat"""
set shell = CreateObject("WScript.Shell")
shell.Run command,0'
New-Item -Path $scriptLocation -Name "$fileName.vbs" -ItemType "file" -Value $vbScript
$targetLocation = "$scriptLocation$fileName.vbs"
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\$linkName.lnk")
$shortcut.IconLocation = "shell32.dll,$iconNumber"
$shortcut.TargetPath = $targetLocation
$shortcut.WorkingDirectory = $scriptLocation
$shortcut.Save()