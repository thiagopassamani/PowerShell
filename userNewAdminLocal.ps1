# Define o comprimento da senha
[int]$PasswordLenght = "12"

# Define o nome do usuário (administrador) local 
[string]$userAdminLocal = "Admin.userLocal"

Add-Type -AssemblyName System.Web

$PassComplexCheck = $false

while($PassComplexCheck -eq $false)
{
    $newPassword=[System.Web.Security.Membership]::GeneratePassword($PasswordLenght,1)

    If ( ($newPassword -cmatch "[A-Z\p{Lu}\s]") -and ($newPassword -cmatch "[a-z\p{Ll}\s]") -and ($newPassword -match "[\d]") -and ($newPassword -match "[^\w]") )
    {
        $PassComplexCheck=$True
    }
}

Write-Host "Senha criada: $newPassword"

# Senha gerada
$localPassword = ConvertTo-SecureString -AsPlainText -Force -String $newPassword

# Verifica se o usuário existe, se não, será criado
$op = Get-LocalUser | Where-Object {$_.Name -eq $userAdminLocal}

if ( -not $op)
{
    
	# Cria o usuário
  New-LocalUser -Name $userAdminLocal -Description "Administrador Local" -Password $localPassword

  $SeacherLocalGroup = Get-LocalGroup | Where-Object {$_.Name -eq "Administrators" }

  If(-not $SeacherLocalGroup)
  {

    Add-LocalGroupMember -Group "Administradores" -Member $userAdminLocal	
        
	  #Get-LocalGroupMember -Group "Administradores"

  }
  Else
  {
        Add-LocalGroupMember -Group "Administrators" -Member $userAdminLocal

	    #Get-LocalGroupMember -Group "Administrators"
    }

	Write-Host "Usuário criado com sucesso!"

}

Else
{

	Write-Host "Usuário já Existe!"

	$UserAccount = Get-LocalUser -Name $userAdminLocal

	$UserAccount | Set-LocalUser -Password $localPassword

  Write-Host "Senha será alterada!"

}
