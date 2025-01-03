param (
    [string]$FilePath,
	[string]$BasePath = $PSScriptRoot,
    [string]$Key,
    [string]$Value
)

$absoluteFilePath = Join-Path -Path $BasePath -ChildPath $FilePath

if (-Not (Test-Path -Path $absoluteFilePath)) {
    Write-Error "File or directory not found: $absoluteFilePath"
    exit
}

[xml]$config = Get-Content $absoluteFilePath

$addNode = $config.configuration.appSettings.add | Where-Object { $_.key -eq $Key }

if ($addNode){
	$addNode.value = $Value
	Write-Host "Update $Key key in appSettings"
}
else
{
	$newNode = $config.CreateElement("add")
	$newNode.SetAttribute("key", $Key)
	$newNode.SetAttribute("value", $Value)

	$config.configuration.appSettings.AppendChild($newNode) | Out-Null
	Write-Host "Add $Key key in appSettings"
}

$config.Save($absoluteFilePath)