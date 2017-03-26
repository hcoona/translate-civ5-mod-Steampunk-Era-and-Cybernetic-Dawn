$ErrorActionPreference = "Stop"


Push-Location $PSScriptRoot

$ModName = (Get-ChildItem *.modinfo).BaseName
$ModBaseFolder = Join-Path $env:USERPROFILE "Documents\My Games\Sid Meier's Civilization 5\Mods\$ModName"

if (Test-Path $ModBaseFolder) {
    Copy-Item CIV5Buildings_TextEntries_SPEra.xml (Join-Path $ModBaseFolder "XML\Buildings\CIV5Buildings_TextEntries_SPEra.xml") -Force
    Copy-Item CIV5Technologies_TextEntries_SPEra.xml (Join-Path $ModBaseFolder "XML\Technologies\CIV5Technologies_TextEntries_SPEra.xml") -Force
    Copy-Item CIV5Units_TextEntries_SPEra.xml (Join-Path $ModBaseFolder "XML\Units\CIV5Units_TextEntries_SPEra.xml") -Force
    Copy-Item "Steampunk Era and Cybernetic Dawn (v 12).modinfo" $ModBaseFolder -Force
} else {
    Write-Error "You must install $ModName from Steam before install this translation patch!"
}

Pop-Location
