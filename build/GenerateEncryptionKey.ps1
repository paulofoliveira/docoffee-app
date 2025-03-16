param (
	[int]$Length = 12,
	[string]$SpecialCharacters = '!@#$%^&*'
)

$letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
$numbers = '0123456789'
$allCharacters = $letters + $numbers + $SpecialCharacters

$randomCode = ''

for ($i = 1; $i -le $Length; $i++) {
	$randomIndex = Get-Random -Minimum 0 -Maximum $allCharacters.Length
	$randomCode += $allCharacters[$randomIndex]
}

return $randomCode