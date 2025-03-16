param (
	[string]$Url
)

# Constantes:

$PREFIX = "asmv1"
$PREFIX_V2 = "asmv2"
$NAMESPACE = "urn:schemas-microsoft-com:asm.v1"
$NAMESPACE_V2 = "urn:schemas-microsoft-com:asm.v2"
$ASSEMBLY = "//${PREFIX}:assemblyIdentity"
$DESCRIPTION = "//${PREFIX}:description"
$DEPLOYMENT = "//${PREFIX_V2}:deployment"
$VERSION = "version"
$MINIMUM_VERSION = "minimumRequiredVersion"
$PRODUCT = "${PREFIX_V2}:product"
$PUBLISHER = "${PREFIX_V2}:publisher"

# Carrega o XML da URL:

$xmlDoc = New-Object System.Xml.XmlDocument
$xmlDoc.Load($Url)

# Gerenciador de namespace:

$namespaceManager = New-Object System.Xml.XmlNamespaceManager $xmlDoc.NameTable
$namespaceManager.AddNamespace($PREFIX, $NAMESPACE)
$namespaceManager.AddNamespace($PREFIX_V2, $NAMESPACE_V2)

# Seleciona o nó de descrição:

$descriptionNode = $xmlDoc.SelectSingleNode($DESCRIPTION, $namespaceManager)

if ($descriptionNode -and $descriptionNode.Attributes) {
	$productNameAttr = $descriptionNode.Attributes.GetNamedItem($PRODUCT)
	$publisherNameAttr = $descriptionNode.Attributes.GetNamedItem($PUBLISHER)

	# Seleciona o nó de assembly:
	
	$assemblyNode = $xmlDoc.SelectSingleNode($ASSEMBLY, $namespaceManager)
	
	Write-Host $assemblyNode

	if ($assemblyNode -and $assemblyNode.Attributes) {
		$versionAttr = $assemblyNode.Attributes.GetNamedItem($VERSION)

		# Seleciona o nó de deployment:
		
		$deploymentNode = $xmlDoc.SelectSingleNode($DEPLOYMENT, $namespaceManager)

		if ($deploymentNode -and $deploymentNode.Attributes) {
			$minimumVersionAttr = $deploymentNode.Attributes.GetNamedItem($MINIMUM_VERSION)

			# Se todos os atributos necessários existirem:
			
			if ($versionAttr -and $productNameAttr -and $publisherNameAttr -and $minimumVersionAttr) {				
				
				$items = $versionAttr.Value -split '\.'

				if ($items.Length -lt 4) {
					throw "Formato inválido para o versionamento. A versão deve ter pelo menos quatro partes separadas por '.'"
				}

				[int]$major = 0
				[int]$minor = 0
				[int]$patch = 0
				[int]$revision = 0
				
				# Converte as partes em inteiros ou define como 0 se falhar:
				
				if ([int]::TryParse($items[0], [ref]$major) -and [int]::TryParse($items[1], [ref]$minor) -and [int]::TryParse($items[2], [ref]$patch) -and [int]::TryParse($items[3], [ref]$revision))
				{
					$version = @{
						Major = $major
						Minor = $minor
						Patch = $patch
						Revision = $revision
						NextVersion = "$($major).$($minor).$($patch).$($revision + 1)"
					}	
		
					return @{
						MinimumRequiredVersion = $minimumVersionAttr.Value
						ProductName = $productNameAttr.Value
						PublisherName = $publisherNameAttr.Value
						Version = $version						
					}
				}
			}
		}
	}
}

# Retorna valores padrão caso não encontre os atributos

return @{
	MinimumRequiredVersion = $null
	ProductName = $null
	PublisherName = $null
	Version = $null
}