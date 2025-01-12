param (
	[string]$Value,
	[string]$EncryptionKey
)

if (-not $Value) { throw "Value cannot be null or empty" }
if (-not $EncryptionKey) { throw "Encrpytion Key cannot be null or empty" }

$IV = [byte[]](12, 34, 56, 78, 90, 102, 114, 126)
$keyBytes = [Text.Encoding]::UTF8.GetBytes($EncryptionKey)
$valueBytes = [Text.Encoding]::UTF8.GetBytes($Value)

$cryptoProvider = New-Object Security.Cryptography.DESCryptoServiceProvider
$memoryStream = New-Object IO.MemoryStream
$cryptoStream = New-Object Security.Cryptography.CryptoStream($memoryStream, $cryptoProvider.CreateEncryptor($keyBytes, $IV), [System.Security.Cryptography.CryptoStreamMode]::Write)

$cryptoStream.Write($valueBytes, 0, $valueBytes.Length)
$cryptoStream.FlushFinalBlock()
$cryptoStream.Close()

return [Convert]::ToBase64String($memoryStream.ToArray())