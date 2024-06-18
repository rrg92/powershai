<#
	.DESCRIPTION
		Lista a hora atual
#>
function HoraAtual {
	return Get-Date
}

<#
	.DESCRIPTION
		Obtem um numero aleatorio!
#>
function NumeroAleatorio {
	param(
		#Numero minimo
		$Min = $null
		
		,#Numero maximo
		$Max = $null
	)
	return Get-Random -Min $Min -Max $max;
}

<#
	.DESCRIPTION
		Lista os TOP X process por CPU!
#>
function GetProcesses($x) 
{
	Get-Process | Sort-Object -Descending CPU | Select-Object -First $x name,CPU,WorkingSet64 | ConvertTo-Json -Compress;
}

<#
	.DESCRIPTION
		Executa qualquer codigo sql em uma instância SQL SERVER
#>
function Sql($sql) 
{
	write-host "Rodando sql: $sql";
	$result = Invoke-SqlCmd -Server .\A22 -Query $sql
	
	write-host "Ok, convertendo pra json..."
	$result | ConvertTo-Json -Compress -Depth 1
}

