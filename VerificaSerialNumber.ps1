$computerName = "ADM_RH04"
$opcoes = New-CimSessionOption -Protocol Dcom
$sessao = New-CimSession -ComputerName $computerName -SessionOption $opcoes
Get-CimInstance -ClassName win32_bios -CimSession $sessao | Format-List SerialNumber