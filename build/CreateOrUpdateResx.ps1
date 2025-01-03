param (
    [string]$FilePath,
    [string]$Key,
    [string]$Value
)

# Carrega o arquivo .resx como XML

[xml]$resx = Get-Content $FilePath

# Procura pelo elemento <data> com o atributo "name" igual à chave

$dataNode = $resx.root.data | Where-Object { $_.name -eq $Key }

if ($dataNode) {
	
    # Atualiza o valor existente:
    $dataNode.value = $Value
} else {
	
    # Cria um novo nó <data>:
	
    $newData = $resx.CreateElement("data")
    $newData.SetAttribute("name", $Key)
    $newData.SetAttribute("xml:space", "preserve")

    $valueNode = $resx.CreateElement("value")
    $valueNode.InnerText = $Value
    $newData.AppendChild($valueNode)

    # Insere o novo nó antes do fechamento de </root>:
	
    $resx.root.AppendChild($newData) | Out-Null
}

# Salva o arquivo mantendo o formato original:

$resx.Save($FilePath)
