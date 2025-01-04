param (
    [string]$FilePath,	
    [string]$Key,
    [string]$Value
)

$absoluteFilePath = Join-Path -Path $BasePath -ChildPath $FilePath

if (-Not (Test-Path -Path $absoluteFilePath)) {
    throw "File or directory not found: $absoluteFilePath"
}

[xml]$config = Get-Content $absoluteFilePath

$addNode = $config.configuration.appSettings.add | Where-Object { $_.key -eq $Key }

if ($addNode){
	$addNode.value = $Value
	Write-Host "Update $Key!"
}
else
{
	throw "$Key not found in $FilePath on appSettings section!"
}

$config.Save($absoluteFilePath)