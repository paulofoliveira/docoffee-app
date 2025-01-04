param (
    [string]$FilePath,	
    [string]$Key,
    [string]$Value
)

if (-Not (Test-Path -Path $FilePath)) {
    throw "File or directory not found: $FilePath"
}

[xml]$config = Get-Content $FilePath

$addNode = $config.configuration.appSettings.add | Where-Object { $_.key -eq $Key }

if ($addNode){
	$addNode.value = $Value
	Write-Host "Update $Key!"
}
else
{
	throw "$Key not found in $FilePath on appSettings section!"
}

$config.Save($FilePath)