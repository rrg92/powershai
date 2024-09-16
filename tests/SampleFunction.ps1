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

<#
	.DESCRIPTION
		Filtra os logs do Windows dos últimos segundos
#>
function GetLastLogs {
	param(
		#Quantas unidades , #5min
		$LastSeconds = 300
	)
	
	$AllLogs = @()
	
	$LogList = Get-WinEvent -ListLog * -EA SilentlyContinue
	
	foreach($Log in $LogList){
		$LogName = $Log.LogName;
		write-host "Filtrando log: $LogName"
		$Filters = @{
			LogName 	= $LogName
			StartTime 	= (Get-Date).addSeconds(-$LastSeconds)
			Level 		= 1,2,3
		}
		
		$AllLogs += Get-WinEvent -FilterHashTable $Filters -EA SilentlyContinue;
	}
	

	return $AllLogs
}