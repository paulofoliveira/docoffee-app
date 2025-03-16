param (
    [string]$FilePath,
    [string]$Key,
    [string]$Value
)

[xml]$resx = Get-Content $FilePath

$dataNode = $resx.root.data | Where-Object { $_.name -eq $Key }

if ($dataNode) {	
    $dataNode.value = $Value
} else {
    throw "$Key not found in $FilePath to update resx!" 
}

$resx.Save($FilePath)
