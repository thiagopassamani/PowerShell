# Importa o módulo Active Directory
Import-Module ActiveDirectory

# Define a OU alvo
$OU = "OU=Matriz - ES,OU=NovaForma,OU=Empresas,DC=novaforma,DC=local"

# Busca todos os usuários na OU e sub-OUs
Get-ADUser -SearchBase $OU -SearchScope Subtree -Filter * -Properties mail |
Select-Object Name, mail |
#Format-Table -AutoSize

Export-Csv -Path "C:\Temp\Usuarios.csv" -NoTypeInformation -Encoding UTF8
