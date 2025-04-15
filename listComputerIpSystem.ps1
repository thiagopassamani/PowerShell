Get-ADComputer -filter {OperatingSystem -Like '*Windows*'} -property * | select name, ipv4address, operatingsystem | Export-CSV -Path c:\Tools\Versio_Windows.csv -NoTypeInformation
