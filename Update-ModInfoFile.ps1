$ErrorActionPreference = "Stop"


Push-Location $PSScriptRoot

$ChangedFiles = (Get-ChildItem *.xml).Name
$ChangedFilesMd5 = Get-FileHash -Path $ChangedFiles -Algorithm MD5

$ModInfoFilePath = (Resolve-Path *.modinfo).Path
$ModInfoXml = Get-Content $ModInfoFilePath

$NewModeInfoXml = $ModInfoXml | ForEach-Object {
    if ($_ -match "<File md5=`"\w+`" import=`"0`">([\w/\.]+)</File>") {
        $MatchFileName = [System.Linq.Enumerable]::Last($Matches[1].Split("/"))
        if ($MatchFileName -in $ChangedFiles) {
            $MatchFileMd5 = (Get-FileHash -Path $MatchFileName -Algorithm MD5).Hash
            $_ -replace "md5=`"\w+`"", "md5=`"$MatchFileMd5`""
        } else {
            $_
        }
    } else {
        $_
    }
}

Set-Content $ModInfoFilePath -Value $NewModeInfoXml

Pop-Location
