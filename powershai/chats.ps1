###
### POWERHSAI CHATS
###		
###	Funcoes relacionadas ao Powershai Chat
###
###


# Cria um objeto que representa um ChatContext
function NewChatContext {
	return @{
		messages = @()
		size = 0
	}
}

<#
	.SYNOPSIS 
		Cria um novo objeto que representa os parâmetros de um PowershaiChat 
		
		
	.DESCRIPTION
		Cria um ojbeto padrao contendo todos o spossveis parametros que podem ser usados no chat!
		O usuário pode usar um get-help New-PowershaiParameters para obter a doc dos parametros.  	
#>
function New-PowershaiParameters {
	[CmdLetBinding()]
	param(
		#Quando true, usa o modo stream, isto é, as mensagens são mostradas a medida que o modelo as produz
			$stream = $true
			
		,# Habilia o modo JSON. Nesse modo, o modelo é forçado a retornar uma resposta com JSON.  
		 # Quandoa ativado, as mensagens geradas via stream não sãoe xibidas a medida que são produzidas, e somente o resultado final é retornado.  
			[bool]$Json = $false
			
		,# Nome do modelo a ser usado  
		 # Se null, usa o modelo definido com Set-AiDefaultModel
			[string]$model = $null
			
		,# Maximo de tokens a ser retornado pelo modelo  
		   [int]$MaxTokens = 2048
		
		,#Printa o prompt inteiro que está sendo enviado ao LLM 
			[bool]$ShowFullSend = $False 
			
		,#Ao final de cada mensagem, exibe as estatísticas de consumo, em tokens, retornadas pela API 
			$ShowTokenStats  = $False 
			
		,#Maximo de interacoes a serem feitas de um só vez 
		 #Cada vez uma mensagem é enviada, o modelo executa 1 iteração (envia a mensagem e recebe uma resposta).  
		 #Se o modelo pedir um function calling, a restpoa gerada será enviada novamente ao modelo. Isso conta como outra interacao.  
		 #Esse parâmetro controla o máximo de interacoes que podem existir em cada chamada.
		 #Isso ajuda a prevenir loops infinitos inesperados. 
			$MaxInteractions = 50
			
		,#MAximo de erros em sequencia gerado por Tool Calling.  
		 #Ao usar tool calling, esse parametro limita quantos tools sem sequencia que resultaram em erro podem ser chamados.  
		 #O erro consideraod é a exception disparada pelo script ou comando configuirado. 
			$MaxSeqErrors = 5
			
		,#Tamanho máximo do contexto, em caracteres 
		 #No futuro, será em tokens 
		 #Controla a quantidade de mensagens no contexto atual do chat. Quando esse número ultrapassar, o Powershai limpa automaticamente as mensagens mais antigas.
			$MaxContextSize = 8192
		
		,#Função usada para formatação dos objetos passados via pipeline 
			$ContextFormatterFunc = "ConvertTo-PowershaiContextOutString"
			
		,#Argumentos para ser passados para a ContextFormatterFunc
			$ContextFormatterParams = $null 
			
		,#Se true, exibe os argumenots das funcoes quando o Tool Calling é ativado para executar alguma funcao 
		 #DEPRECIADO. Será removido em breve. Use -PrintToolCalls
			$ShowArgs = $true 
			
		,#Exibe os resultados das tools quando são executadas pelo PowershAI em resposta ao tool calling do modelo 
			$PrintToolsResults = $false
			
		,#System Message que é garantida ser enviada sempre, independente do histórico e clenaup do chat!
			$SystemMessageFixed = $null
			
		,#Parâmetros a serem passados diretamente para a API que invoca o modelo.  
		 #O provider deve implementar o suporte a esse.  
		 #Para usá-lo você deve saber os detalhes de implementação do provider e como a API dele funciona!
			$RawParams = @{}
			
			
		,# Controla o template usado ao injetar dados de contexto!
		 # Este parâmetro é um scriptblock que deve retornar uma string com o contexto a ser injetado no prompt!
		 # Os parâmetros do scriptblock são:
		 #		FormattedObject 	- O objeto com os dados do contexto (Enviado via pipe), já formatado com o Formatter configurado
		 #		CmdParams 			- Os parâmetros passados para Send-PowershaAIChat. É o mesmo objeto retorndo por GetMyParams
		 #		Chat 				- O chat no qual os dados estão sendo enviados.
		 # Se nulo, irá gerar um default. Verifique o cmdlet Send-PowershaiChat para detalhes
			$PromptBuilder = $null
			
		,#Controla como as Tools Calls são exibidas pelo comando Send-PowershaiChat
		 #Valores possíveis:
		 #	No			- não exibe nada relacionado ao tool calls.
		 #	NameOnly 	- Exibe apenas o nome no formato FunctionaName{...} , em uma linha própria.
		 #	NameArgs	- Exibe o nome e os argumentos!
			[ValidateSet("No","NameOnly","NameArgs")]
			$PrintToolCalls = $null
	)
	
    # Get the command name
    $CommandName = $PSCmdlet.MyInvocation.InvocationName;
    # Get the list of parameters for the command
    $ParameterList = (Get-Command -Name $CommandName).Parameters;
	
	$NewParams = @{}
	
	# compatibility
	if($ShowArgs -and $PrintToolCalls -eq $null){
		$PrintToolCalls = "NameArgs"
	}
	
	
	foreach($ParamName in @($ParameterList.keys) ){
		
		if($ParamName -in [System.Management.Automation.PSCmdlet]::CommonParameters){
			continue;
		}
		
		$ParamValue = Get-Variable $ParamName -ValueOnly -EA SilentlyContinue
		
		$NewParams[$ParamName] = $ParamValue;
	}
	
	return $NewParams;
	
}

<#
	.SYNOPSIS 
		Cria um novo Powershai Chat.
		
	.DESCRIPTION 
		O PowershaAI traz um conceito de "chats", semelhantes aos chats que você vê na OpenAI, ou as "threads" da API de Assistants.  
		Cada chat criado tem seu próprio conjunto de parâmetros, contexto e histórico.  
		Quando você usa o cmdlet Send-PowershaiChat (alias ia), ele está enviando mensagens ao modelo, e o histórico dessa conversa com o modelo fica no chat criado aqui pelo PowershAI.  
		Ou seja, todo o histórico da sua conversa com o modelo é mantido aqui na sua sessão do PowershAI, e não lá no modelo ou na API.  
		Com isso o PowershAI mantém todo o controle do que enviar ao LLM e não depende de mecanismos das diferentes APIs de diferentes providers para gerenciar o histórico. 
		
		
		Cada Chat possui um conjunto de parâmetros que ao serem alterados afetam somente quele chat.  
		Certos parâmetros do PowershAI são globais, como por exemplo, o provider usado. Ao mudar o provider, o Chat passa a usar o novo provider, mas mantém o mesmo histórico.  
		Isso permite conversar com diferentes modelos, enquanto mantém o mesmo histórico.  
		
		Além destes parâmetros, cada Chat possui um histórico.  
		O histórico contém todas as conversas e interações feitas com os modelos, guardando as repostas retornadas pelas APIs.
		
		Um Chat também tem um contexto, que é nada mais do que todas as mensagesn enviadas.  
		Cada vez que uma nova mensagem é enviada em um chat, o Powershai adiciona esta mensage ao contexto.  
		Ao receber a resposta do modelo, esta resposta é adicionada ao contexto.  
		Na próxima mensagem enviada, todo ess ehistórico de mensagem do contexto é enviado, fazendo com que o modelo, independente do provider, tenha a memória da conversa.  
		
		o fato do contexto ser mantido aqui na sua sessão do Powershell permite funcionaldiades como gravar o seu histórico em disco, implementar um provider exclusivo para guardar o seu hitórico na nuvem, manter apenas no seu Pc, etc. Futuras funcionalidades podem se beneficiar disso.
		
		Todos os comandos *-PowershaiChat giram em todos do chat ativo ou do chat que voce explicitamente especifica no parametro (geralmente com o nome -ChatId).  
		O ChatAtivo é o chat em que as mensagens serão enviadas, caso nao seja especificado o ChatId  (ou se o comando não permite especificar um chat explicito).  

		Existe um chat especial chamado "default" que é o chat criado sempre que voce usa o Send-PowershaiChat sem especifciar um chat e se não houver chat ativo definido.  
		
		Se você fechar sua sessão do Powershell, todo esse histoico de Chats é perdido.  
		Você pode salvar em disco, usando o comando Export-PowershaiSettings. O conteudo é salvo criptografado por uma senha que voce especificar.
		
		Ao emviar mensagens, o PowershaAI mantém um mecanismo interno que limpa o contexto do chat, para evitar enviar mais do que o necessário.
		O tamanho do contexto local (aqui na sua sessao do Powershai, e nao do LLM), é controlado por um parametro (use Get-PowershaiChatParameter para ver a lista de parametros)
		
		Note que, devido a essa maneira do Powershai funcionar, dependendo da quantidade de informacoes enviadas e retornadas, mais as configuracoes dos parametros, voce pode fazer seu Powershell consumir bastante memória. Voce pode limpar o contexto e historico manualmente do seu chat usando Reset-PowershaiCurrentChat
		
		Veja mais detalhes sobre no tópico about_Powershai_Chats,
#>
function New-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat. Se não especifico, irá gerar um padrão 
		#ALguns padrões de id são reservados para uso interno. Se você us´-alos poderá causar instabilidades no PowershAI.
		#Os seguintes valores são reservados:
		# default 
		# _pwshai_*
			$ChatId
			
		,#Cria somente se não existe um chat com o mesmo nome 
			[switch]$IfNotExists
			
		,#Forçar recriar o chat se ele já estiver criado!
			[switch]$Recreate
			
		,#Cria o chat e inclui essas tools!
			$Tools = @()
	)
	
	if(!$ChatId){
		$ChatId = (Get-Date).toString("yyyyMMddHHmmss")
	}
	
	# Create chat!
	$Chats = $POWERSHAI_SETTINGS.chats;
	
	if(!$Chats -isnot [hashtable]){
		$Chats = @{};
		$POWERSHAI_SETTINGS.chats = $Chats;
	}
	
	$ChatSlot = $Chats[$ChatId];
	
	if($ChatSlot){
		if($IfNotExists){
			return $ChatSlot;
		}
		
		if(!$Recreate){
			throw "POWERSHAI_START_CHAT: Chat $ChatId already exists";
		}
		
		verbose "Recreate Enabled";
	}
	
	try {
		$CurrentUser = Get-LocalUser -SID ([System.Security.Principal.WindowsIdentity]::GetCurrent().User)
		$FullName = $CurrentUser.FullName;
		$UserAllNames = $FullName.split(" ");
		$UserFirstName = $UserAllNames[0];
	} catch {
		verbose "Cannot get logged username: $_"
	}
	
	$ApiParams = @{					}
	
	$ChatParams = New-PowershaiParameters
	
	$ChatSlot = [PsCustomObject]@{
		#Id unico e interno do chat!
		id 			 	= $ChatId
		
		#Data/hora de criacao do chat!
		CreateDate 		= (Get-Date)
		
		#Numero sequencia da msg atual enviada
		num 			= 0
		
		#Ultimo prompt enviado!
		LastPrompt 		= $null
		
		#Metados de controle do chat!
		metadata 		= @{}
		
		#Historico completo de todas as mensagens enviadas, com os objetos
		history 		= @()
		
		#Parametros configuraveis do chat
		params 			= $ChatParams 
		
		#Contexto dos chats. é onde fica as mensagens que deve ser enviadas
		context  = (NewChatContext)
		
		#Informacoes do usuario atual
		UserInfo = @{
			FullName = $FullName
			AllNames = @($UserAllNames)
		}
		
		#Estatisticas de uso de tokens ao longo de todo o chat!
		stats = @{
			TotalChats 	= 0
			
			TotalCost 	= 0
			TotalInput 	= 0
			TotalOutput = 0
			
			TotalTokensI = 0
			TotalTokensO = 0
		}
		
		#Slot contendo tudo o que é necessario para controlar as tools dos chats!
		Tools = @{
			compiled = $null
			raw = @{}
		}
	}
	
	SetType $ChatSlot "Chat";

	verbose "Updating slot of chatid: $ChatId";
	$Chats[$ChatId] = $ChatSlot;
	
	$null = Get-PowershaiChat -SetActive $ChatId
	
	if($Tools){
		 Add-AiTool -names $Tools -ChatId $ChatId
	}
	
	return $ChatSlot;
}

<#
	.SYNOPSIS
		Remove um chat e retorna o objeto com todo o histórico e contexto
#>
function Remove-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat a ser removido, ou objeto representando o chat!
		[Parameter(ValueFromPipelineByPropertyName=$true)]
		[Alias("id")]
		$ChatId
	)
	
	$CurrentChat = Get-PowershaiChat "."
	$TargetChat = Get-PowershaiChat $ChatId
	
	if($CurrentChat -eq $TargetChat){
		throw "POWERSHAI_REMOVECHAT: Cannot remove active chat!";
	}
	
	#return removed!
	$Chats = $POWERSHAI_SETTINGS.chats;
	$Chats.remove($TargetChat.id);
	
	return $TargetChat;
}

<#
	.SYNOPSIS 
		Retorna um ou mais Chats criados com New-PowershaAIChat
		
	.DESCRIPTION
		Este comando permite retornar o objeto que representa um Powershai Chat.  
		Este objeto é o objeto referenciando internamente pelos comandos que operam no Powershai Chat.  
		Apesar de certos parâmetros você poder alterar diretamente, não é recomendável que faça esta ação.  
		Prefira sempre usar a saída desse comando como entrada para os outros que comandos PowershaiChat.
#>
function Get-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat
		#Nomes especiais:
		#	. - Indica o proprio chat 
		# 	* - Indica todos os chats 
			$ChatId 
		
		,#Define o chat como ativo, quando o id especifciado não é um nome especial.
			[switch]$SetActive
			
		,#Ignora erros zde validação 
			[switch]$NoError
	)
	
	try {
		if(!$ChatId){
			throw "POWERSHAI_GET_CHAT: Must inform -ChatId"
		}
		
		if(IsType $ChatId "Chat"){
			return $ChatId;
		}
		
		if($ChatId -eq '*'){
			@($POWERSHAI_SETTINGS.chats.values) | Sort-Object CreateDate
			return;
		}
		
		# Create chat!
		$Chats 	= $POWERSHAI_SETTINGS.chats;
		
		if(!$Chats){
			 $POWERSHAI_SETTINGS.chats = @();
		}
		
		$OriginalChatId =$ChatId 
		
		if($ChatId -eq "."){
			$ChatId = $POWERSHAI_SETTINGS.ActiveChat;
			
			if(!$ChatId -or $ChatId -isnot [string]){
				throw "POWERSHAI_GET_CHAT: No active ChatId!"
			}
			
		}
		
		$Chat = $Chats[$ChatId];
		
		if(!$Chat){
			throw "POWERSHAI_GET_CHAT: Chat $ChatId not found!";
		}
		
		if($SetActive -and $OriginalChatId -ne "."){
			$POWERSHAI_SETTINGS.ActiveChat = $ChatId;
		}
	
		return $Chat
	} catch {
		if($NoError){
			return;
		}
		
		throw;
	}
	
	
	
}

<#
	.SYNOPSIS 
		Altera o chat ativo
		
	.DESCRIPTION
		O chat ativo é o chat padrão nos quais os comandos do Powershai Chat são enviados.  
		Se existem somente 1 chat, ele é considerado ativo, por padrão.
#>
function Set-PowershaiActiveChat {
	[CmdletBinding()]
	param(
		$ChatId
	)
	
	if(IsType $ChatId "Chat"){
		$ChatId = $ChatId.id;
	}
	
	Get-PowershaiChat -SetActive $ChatId;
}

<#
	.SYNOPSIS
		Atualiza o valor de um parâmetro do chat do Powershai Chat.  
		
	.DESCRIPTION 
		Atualiza o valor de um parâmetro de um Powershai Chat.  
		Se o parâmetro não existe, um erro é retornado.
#>
function Set-PowershaiChatParameter {
	param(
		#Nome do parâmetro 
			$parameter
		,#Valor do parâmetro
			$value
		,# Chat que deseja atualizar. Por padrão atualiza o chat ativo 
			$ChatId = "."
			
		,#Forçar atualização, mesmo se o parâmetro não existe na lista de parâmetros 
			[switch]$Force
	)
	
	$AllParameters = Get-PowershaiChatParameter -ChatId $ChatId
	
	$Param = $AllParameters | ? { $_.name -eq $parameter }
	
	if(!$Param -and $Force){
		throw "POWERSHAI_CHAT_SETPARAM: Parameter $Parameter not found";
	}
	
	
	$Chat = Get-PowershaiChat $ChatId;
	$CurrentValue = $Chat.params[$parameter];
	
	$Chat.params[$parameter] = $value;
	
	return [PsCustomObject]@{ Parameter = $parameter; OldValue = $CurrentValue; Newvalue = $Chat.params[$parameter] }
}

<#
	.SYNOPSIS
		Retorna a lista de parâmetros disoponíveis em um chat
		
	.DESCRIPTION 
		Este comando retorna um objeto contendo a lista de propriedades.  
		O objeto é, na verdade, um array, onde cada elemento representa uma propriedade.  
		
		Esse array retornado possui algumas modificações para faciltiar o acesso aos parametros. 
		Você pode acessar os parâmetros usando o objeto retornado diretamente, sem a necessidade de fitrar sobre a lista de parâmetros.
		Isso é útil quando se desejar acessar um parâmetro específico da lista.  
		
	.EXAMPLE 	
		> $MyParams = Get-PowershaiChatParameter
		> $MyParams.MaxTokens # Acessa o parâmetro max TOKENS
		> $MyParams | %{ write-host Parametro $_.name tem o valor $_.value } # itera sobre os parametros!
		
#>
function Get-PowershaiChatParameter {
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	
	[Collections.ArrayList]$ParamsHelp = @()
	
	SetType $ParamsHelp "ChatParameterList"
	
	$ParamBaseHelp = @(get-help New-PowershaiParameters).parameters.parameter
	
	#Lista tudo para garantir mesmo os chats criados previamente possam exibir novas opcoes que aparecem!
	$AllParams = @($Chat.params.keys) + @($ParamBaseHelp | %{$_.name}) | Sort-object -Unique
	
	# Parametros da funcao!
	$AiChatParams = ((Get-Command Invoke-AiChatTools).Parameters).Keys;
	
	foreach($ParamName in $AllParams){
		$ParamHelp = $ParamBaseHelp | ? {$_.name -eq $ParamName}
		
		$IsDirectParam = $ParamName -in $AiChatParams;
		
		if($ParamHelp){
			$help = @($ParamHelp.description | %{$_.text}) -Join "`n"
		} else {
			$help = "Raw API param. Check model docs"
		}
		
		$ParameterInfo = [PsCustomObject]@{}
		$ParameterInfo | Add-Member Noteproperty name $ParamName
		$ParameterInfo | Add-Member Noteproperty value $Chat.params[$ParamName]
		$ParameterInfo | Add-Member Noteproperty description $help
		
		#Direct informa se o parâmetro é um parâmetro direto da função Invoke-AiChatTools, que é a função base invocada Powershai Chats.
		$ParameterInfo | Add-Member Noteproperty direct $IsDirectParam
		
		$null = $ParamsHelp.add($ParameterInfo)
		Add-Member -InputObject $ParamsHelp -force Noteproperty $ParameterInfo.name $ParameterInfo.value;
	}
	
	
	write-output -NoEnumerate $ParamsHelp;
}


$PARAM_LIST = @();

RegArgCompletion Set-PowershaiChatParameter parameter {
	param($cmd,$param,$word,$ast,$fake)
	 
	Get-PowershaiChatParameter -ChatId . | ? {$_.name -like "$word*"} | %{$_.Name};
}


<#
	.SYNOPSIS
		Permite invocar a maioria das funções de uma maneira compacta
		
	.DESCRIPTION 
		Este é um simples utilizario que permite invocar diversas funcoes de uma forma mais reduzia na linha de comando.  
		Note que nem todos os comandos podem ser suportados ainda.
		
		É melhor usado com o alia pshai.
		
	.EXAMPLE 	
		> pshai tools # lista as tools
		> pshai params MaxTokens 2048 #atualiza um parâmetro
		
#>
function Invoke-PowershaiCommand {
	[CmdletBinding()]
	param(
		#Command name
			[ValidateSet("params","tools")]
			$CommandName
		
		,[Parameter(ValueFromRemainingArguments=$true)]
			$RemArgs
	)
	
	switch($CommandName){
		"params" {
			Set-PowershaiChatParameter @RemArgs
		}
		
		"tools" {
			Get-AiTools
		}
		
		default {
			write-warning "Unkown command";
		}
	}
	
}

Set-Alias pshai Invoke-PowershaiCommand

$POWERSHAI_FORMATTERS_SHORTCUTS = @{}
<#
	.SYNOPSIS
		Define qual será a funcao usada para formatar os objetos passados pro parâmetro Send-PowershaiChat -Context
	
	.DESCRIPTION
		Ao invocar Send-PowershaiChat em um pipe, ou passando diretamente o parâmetro -Context, ele irá injetar esse objeto no prompt do LLM.  
		Antes de injetar, ele deve converter esse objeto para uma string.  
		Essa conversão é chamada de "Context Formatter" aqui no Powershai.  
		O Context Formatter é uma funcao que irá pegar cada objeto passado e convertê-lo para uma string para ser injetada no prompt.
		A função usada deve receber como primeiro parametro o objeto a ser convertido.  
		
		Os demais parametros ficam a criterio. Os valor deles pode ser especicicados usando o parametro -Params dessa funcao!
		
		O powershai disponibiliza context formatters nativos.  
		Utilize Get-Command ConvertTo-PowershaiContext* ou Get-PowershaiContextFormatters para obter a lista!
		
		Uma vez que os context formatters nativos são apenas funções powershell, você pode usar o Get-Help Nome, para obter mais detalhes.  
#>
function Set-PowershaiChatContextFormatter {
	param(
		$ChatId = "."
		,#Nome da funcao powershell
		 #Use o comando Get-PowershaiContextFormatters para ver a lista
			$Func = "Str"
		
		,$Params = $null
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId
	$Chat.params.ContextFormatterFunc 	=  $Func 
	$Chat.params.ContextFormatterParams =  $Params
}

<#
	.SYNOPSIS
		Lista todos os Context Formatters compactos disponíveis
	
	.DESCRIPTION
		Certos Context Formatters disponibilizados pelo PowershAI podem ter um nome compacto (ou alias, se preferir), para facilitar sua definição.  
		Este cmdlet retorna todos esses momes que podem ser usados ao uisar Set-PowershaiChatContextFormatter
#>
function  Get-PowershaiContextFormatters {
	param()
	
	@($POWERSHAI_FORMATTERS_SHORTCUTS.keys) |  %{ [PsCustomObject]@{name = $_; func = $POWERSHAI_FORMATTERS_SHORTCUTS[$_]} }
}

<#
	.SYNOPSIS
		Converte o contexto para JSON usando ConverTo-Json
#>
function ConvertTo-PowershaiContextJson {
	param($context)
	
	$context | convertto-json @params
}
$POWERSHAI_FORMATTERS_SHORTCUTS['json'] = 'ConvertTo-PowershaiContextJson'

<#
	.SYNOPSIS
		Converte o contexto para JSON usando ConverTo-Json
#>
function ConvertTo-PowershaiContextOutString {
	param(
		#Objeto a ser injetado no contexto 
		$context
	)
	
	$context | out-string @params
}
$POWERSHAI_FORMATTERS_SHORTCUTS['str'] = 'ConvertTo-PowershaiContextOutString'

<#
	.SYNOPSIS
		Converte o objeto para um formato lista usando Format-List.
#>
function ConvertTo-PowershaiContextList  {
	param(
		#Objeto que será injetado no contexto
			$context
		
		,#Parâmetros do comando Format-List 
			$FlParams = @{}
	)
	
	$context | Format-List @FlParams | out-string
}
$POWERSHAI_FORMATTERS_SHORTCUTS['list'] = 'ConvertTo-PowershaiContextList'

<#
	.SYNOPSIS
		Converte o objeto para um formato Table usando Format-Table
#>
function ConvertTo-PowershaiContextTable {
	param(
		#Objeto que será injetado no contexto
			$context
			,$FlParams = @{}
	)
	
	$context | Format-Table -AutoSize @FlParams | out-string
}
$POWERSHAI_FORMATTERS_SHORTCUTS['table'] = 'ConvertTo-PowershaiContextTable'


<#
	.SYNOPSIS
		Formato um objeto para ser injetado no contexto de uma mensagem envianda em um Powershai Chat
	
	.DESCRIPTION 
		Dado que LLM processam apenas strings, os objetos passados no contexto precisam ser convertidos para um formato em string, antes de serem injetados no prompt.
		E, como existem várias reprsentações de um objeto em string, o Powershai permite que o usuário tenha total controle sobre isso.  
		
		Sempre que um objeto precisar ser injado no prompt, quando invocado com Send-PowershaAIChat, via ppipeline ou parâmetro Contexto, este cmdlet será invocado.
		Este cmdlet é responsavel por transformar este objeto em string, independente do objeto, seja array, hashtable, customizado, etc.  
		
		Ele faz isso invocando a função de formatter configurada usando Set-PowershaiChatContextFormatter
		NO geral, você não precisa invocar essa funções diretamente, mas pode querer invocar quando quiser fazer algum teste!
#>
function Format-PowershaiContext {
	[CmdletBinding()]
	param(
		#Objeto qualquer a ser injetado 
			$obj
			
		,#Parâmetro a ser passado para a função formatter 
			$params
			
		,#Sobrescrever a função ser invocada. Se não especificado usa o defualt do chat.
			$func 
			
		,#Chat em qual operar 
			$ChatId = "."
	)
	
	verbose "Getting ChatId..."
	$Chat = Get-PowershaiChat -ChatId $ChatId
	
	if(!$func){
		$func = $Chat.params.ContextFormatterFunc
		
		if(!$func){
			$func = "str"
		}
	}
	
	$ShortCut = $POWERSHAI_FORMATTERS_SHORTCUTS[$Func];
	if($ShortCut){
		$Func = $ShortCut
	}
	
	verbose "FormatFunction: $func"
	
	if(!$params){
		$params =  $Chat.params.ContextFormatterParams
	}
	
	
	if($params -eq $null){
		$params = @{}
	}
	
	verbose "FormatParams: $($params|out-string)";

	
	verbose "Invoking formatter...: $func"
	& $func $obj @params
}


function Send-PowershaiChat {
	<#
		.SYNOPSIS 
			Envia uma mensagem em um Chat do Powershai
		
		.DESCRIPTION 
			Este cmdlet permite que você envie uma nova mensagem para o LLM do provider atual.  
			Por padrão, ele envia no chat ativo. Você pode sobrescrever o chat usando o parâmetro -Chat.  Se não houver um chat ativo, ele irá usar o default.  
			
			Diversos parâmetros do Chat afetam como este comando. Veja o comando Get-PowershaiChatParameter para mais info sobre os parâmetros do chat.  
			Além dos parâmetros do chat, os próprios parâmetros do comando podem sobrescrever comportamento.  Para mais detalhes, consule a documentação de cada parâmetro deste cmdlet usando get-help.  
			
			Para simplicidade, e manter a liNha de comando limmpa, permitindo o usuário focar mais no prompt e nos dados, alguns alias são disponibilizados.  
			Estes alias podem ativar certos parâmetros.
			São eles:
				ia|ai
					Abreviação de "Inteligência Artifical" em português. Este é um alias simples e não muda nenum parâmetro. Ele ajuda a reduzir bastante a linha de comando.
				
				iat|ait
					O mesmo que Send-PowershaAIChat -Temporary
					
				io|ao
					O mesmo que Send-PowershaAIChat -Object
					
				iam|aim 
					O mesmo que Send-PowershaaiChat -Screenshot 
			
			O usuário pode criar seus próprios alias. Por exemplo:
				Set-Alias ki ia # DEfine o alias para o alemao!
				Set-Alias kit iat # DEfine o alias kit para iat, fazendo o comportamento ser igual ao iat (chat temporaria) quando usado o kit!
	#>
	[CmdletBinding(PositionalBinding=$false)]
	param(
		[parameter(mandatory=$false, position=0, ValueFromRemainingArguments)]
		# o prompt a ser enviado ao modelo 
			$prompt
		
		,#System message para ser incluída 
			$SystemMessages = @()
		
		,#O contexto 
		 #Esse parâmetro é pra usado preferencialmente pelo pipeline.
		 #Ele irá fazer com que o comando coloque os dados em tags <contexto></contexto> e injeterá junto no prompt.
		[parameter(mandatory=$false, ValueFromPipeline=$true)]
			$context = $null
			
		,#Força o cmdlet executar para cada objeto do pipeline
		 #Por padrão, ele acumula todos os objetos em um array, converte o array para string só e envia de um só vez pro LLM.
			[switch]$ForEach
			
		,#Habilia o modo json 
		 #nesse modo os resultados retornados sempre será um JSON.
		 #O modelo atual deve suportar!
			[switch]$Json
			
		,#Modo Object!
		 #neste modo o modo JSON será ativado automaticamente!
		 #O comando não vai escrever nada na tela, e vai retornar os resultados como um objeto!
		 #Que serão jogados de volta no pipeline!
			[switch]$Object
			
		,# Mostra os dados de contexto enviados ao LLM antes da resposta!
		 # É útil para debugar o que está senod injetado de dados no prompt.
			[switch]$PrintContext
			
		,#Não enviar as conversas anteriores (o histórico de contexto), mas incluir o prompt e a resposta no contexto histórico.
			[switch]$Forget
			
		,#Ignorar a resposta do LLM, e não incluir o prompt no contexto histórico
			[switch]$Snub
			
		,#Não envia o histórico e nem inclui a resposta e prompt.  
		 #É o mesmo que passar -Forget e -Snub juntos.
			[switch]$Temporary 
			
		,# Desliga o function call para esta execução somente!
			[Alias('NoCalls','NoTools','nt')]
			[switch]$DisableTools
			
		,# Alterar o contexto formatter pra este
		 # Veha mais sobre em Format-PowershaiContext
			$FormatterFunc = $null
			
		,# Parametros do contexto formatter alterado.
			$FormatterParams = $null
			
		,# Retorna as mensagens de volta no pipeline, sem escrever direto na tela!
		 # Esta opção assume que o usuário irá ser o responsável por dar o correto destino da mensagem!
		 # O objeto passado ao pipeline terá as seguintes propriedades:
		 #		text 			- O texto (ou trecho) do texto retornado pelo modelo 
		 #		formatted		- O texto formatado, incluindo o prompt, como se fosse escrito direto na tela (sem as cores)
		 #		event			- O evento. Indica o evento que originou. São os mesmos eventos documentaados em Invoke-AiChatTools
		 #		interaction 	- O objeto interaction gerado por Invoke-AiChatTools
			[switch]$PassThru
		
		,#Retorna um array de linhas 
		 #Se o modo stream estiver ativado, retornará uma linha por vez!
			[switch]$Lines
			
		,#Sobrescrever parâmetros do chat!
		 #Especifique cada opção em umas hastables!
		 $ChatParamsOverride = @{}
		 
		,#Especifica diretamente o valor do chat parameter RawParams!
		 #Se especificado também em ChatParamOverride, um merge é feito, dando prioridade aos parametros especificados aqui.
		 #O RawParams é um chat parameter que define parametros que serão enviados diretamente a api do modelo!
		 #Estes parametros irão sobrescrever os valores padrões calculados pelo powershai!
		 #Com isso, o usuario tem total controle sobre os parâmetros, mas precisa conmhecer cada provider!
		 #Também, cada provider é responsável por prover essa implementaão e usar esses parâmetros na sua api.
			$RawParams = @{}
			
		,#Captura um print screen da tela que está atrás da janela do powershell e envia junto com o prompt. 
		 #Note que o mode atual deve suportar imagens (Vision Language Models).
			[switch]
			[Alias("ss")]
			$Screenshot
	)
	
	
	begin {
		$ErrorActionPreference = "Stop";
		
		
		
		$ProcessedPrompt = @();
		@($prompt) | %{
			if($_ -is [IO.FileInfo]){
				$ProcessedPrompt += "file: $($_.FullName)";
			} else {
				$ProcessedPrompt += $_;
			}
		}
		
		$prompt = $ProcessedPrompt;
		
		$MyInvok 		= $MyInvocation;
		$CallName 		= $MyInvok.InvocationName;
		$MyRealName 	= $MyInvocation.MyCommand.Name;
		$CurrentName 	= $CallName;
		$MyParameters 	= GetMyParams
		
		# resolve até chegar no command!
		$LoopProtection = 50;
		while($CurrentName -ne $MyRealName -and $LoopProtection--){
			$CallName = $CurrentName;
			$CurrentName = (Get-Alias $CurrentName).Definition
		}
		
		if($LoopProtection -lt 0){
			write-warning "Cannot determined alias. This can be a bug!";
		}
		
		
		if($CallName -eq "io"){
			verbose "Invoked vias io alias. Setting Object to true!";
			$Object = $true;
		}
		
		if($CallName -eq "iat"){
			verbose "Invoked vias iat alias. Setting Temporary to true!";
			$Temporary = $true;
		}
		
		if($CallName -eq "iam"){
			$Screenshot = $true;
		}
		
		if($Temporary){
			write-warning "Temporary Chat enabled";
			$Snub 	= $true;
			$Forget = $true;
		}
		
		$ActiveChat = Get-PowershaiChat "." -NoError
		
		if(!$ActiveChat){
			verbose "Creating new default chat..."
			$NewChat = New-PowershaiChat -ChatId "default" -IfNotExists
			
			verbose "Setting active...";
			$ActiveChat = Get-PowershaiChat -SetActive $NewChat.id;
		}
		
		if($Screenshot){
			if(-not(Get-Command -EA SilentlyContinue Get-PowershaiPrintSCreen)){
				throw "POWERSHAI_ENABLE_EXPLAIN: Você deve habilitar com Enable-AiScreenshots"
			}
			
			$sspath = Get-PowershaiPrintSCreen;
			
			$prompt += "file: $sspath";
		}
		
		
		$IsPipeline = $PSCmdlet.MyInvocation.ExpectingInput   
		
		$MainCmdlet = $PsCmdLet;
		
		$ChatMyParams 		= Get-PowershaiChatParameter  -ChatId $ActiveChat.id 
		$CurrentChatParams 	= @{
			all = @{}
			direct = @{}
		};
		
		#Merge raw params!
		$ChatParamsOverride['RawParams'] = HashTableMerge $ChatParamsOverride['RawParams'] $RawParams;
		
		$ChatMyParams | %{
			
			$ParamValue = $_.value;
			
			if($ChatParamsOverride.Contains($_.name)){
				verbose "ChatParam $($_.name) overrided"
				$ParamValue = $ChatParamsOverride[$_.name];
			}

			if($_.direct){
				verbose "Adding direct param $($_.name)";
				$CurrentChatParams.direct[$_.name] = $ParamValue;
			}
			
			$CurrentChatParams.all[$_.name] = $ParamValue;
		}
		
		
		# This is the default code used to build the final prompt to be sent to LLM!
		$PromptBuilderScript = $CurrentChatParams.all.PromptBuilder;
		
		if(!$PromptBuilderScript){
			$PromptBuilderScript = {
				param($Params)
				
				$ContextObject 	= $Params.FormattedObject;
				$UserPrompt 	= $Params.prompt;
				
				@(
					"Answer user message based on context data inside tag <data-context>"
					"Context data:`n<data-context>`n$($ContextObject)`n</data-context>"
					"Answer in same language of user, or in language explicit asked"
					"User message:"
					$UserPrompt	
				)
			}
		}
		
		
		function ProcessPrompt {
			param($prompt)
			
			
			$WriteData = @{
				BufferedText 	= ""
				LinesBuffer		= @()
				streamed 		= $False;
				premsg 			= $false
			}
			function WriteModelAnswer {
				param(
					$interaction
					,$evt
				)
				
				$Stream = $interaction.stream;
				$str = "";
				$EventName = $evt.event;
				
				if($interaction -eq "FlushLine"){
					if($WriteData.BufferedText){
						$MainCmdlet.WriteObject($WriteData.BufferedText)
					}
					
					return;
				}
				
				if($EventName -eq "answer" -and $WriteData.streamed){
					return;
				}
					
				
				if($Object){
					verbose "ObjectMode enabled. No writes...";
					return;
				}
				
				$WriteParams = @{
					NoNewLine = $false
					ForegroundColor = "Cyan"
				}
				

				
				
				function FormatPrompt {
					
					$str = Invoke-PowershaiProviderInterface "FormatPrompt" -Ignore -FuncParams @{
						model = $model
					}
					
					if($str -eq $null){
						$str = "🤖 $($model): ";
					}
					
					return $str;
				}
		


				if($Stream){
					$WriteData.streamed 	= $true;
					$PartNum 				= $Stream.num;
					$text 					= $Stream.answer.choices[0].delta.content;
					$WriteParams.NoNewLine 	= $true;
					$model 					= $Stream.answer.model;
					
					if(!$WriteData.premsg){
						$str = FormatPrompt
						$WriteData.premsg = $true;
					}

					if($text){
						$Str += $text
					}
					
					if($EventName -eq "answer"){
						$str = "`n`n";
					}
				} else {
					#So entrará nesse quando o stream estiver desligado!
					$ans 	= $interaction.rawAnswer;
					$text 	= $ans.choices[0].message.content;
					$model 	= $ans.model;
					$prempt = FormatPrompt;
					$str 	= "$($prempt)$text`n`n" 
				}

				if($PassThru){
					$MessageOutput = @{
						event 		= $EventName
						text 		= $text
						formatted 	= $str
						interaction = $interaction
					}
					
					$MainCmdlet.WriteObject($MessageOutput);
					return;
				}
				
				if($Lines){
					$WriteData.BufferedText += $text;
					
					$Lines 		= $WriteData.BufferedText -split '\r?\n'
					$LastLine 	= $Lines.count - 1;
					
					if($LastLine -gt 0){
						$LastDelivery = $LastLine - 1
						$DeliveryLines = $Lines[0..$LastDelivery];
						$DeliveryLines | %{ $MainCmdlet.WriteObject($_) }
						$WriteData.BufferedText = $Lines[-1];
					}
					
					return;
				}
				

				if($str){
					write-host @WriteParams $Str;
				}
				
				
			}

			#Get active chat!
			$Chat = Get-PowershaiChat "."
			
			if(!$Chat){
				throw "POWERSHAI_SEND: No active chats"
			}
			
			#Parameters 
			$ChatStats 			= $Chat.stats;
			$ChatMetadata 		= $Chat.metadata;
			$UserFirstName		= $Chat.UserInfo.AllNames[0];
			$ChatContext 		= $Chat.context;
			
			verbose "Iniciando..."
			
			$ChatUserParams = $CurrentChatParams.all
			$DirectParams 	= $CurrentChatParams.Direct;
			
			$VerboseEnabled = $ChatUserParams.VerboseEnabled;
			$ShowFullSend 	= $ChatUserParams.ShowFullSend
			$ShowTokenStats = $ChatUserParams.ShowTokenStats
			# Vou considerar isso como o número de caracter por uma questão simples...
			 # futuramente, o correto é trabalhar com tokens!
			$MaxContextSize = $ChatUserParams.MaxContextSize 
			
			function AddContext($msg) {

				while($ChatContext.size -ge $MaxContextSize -and $ChatContext.messages){
					$removed,$LeftMessages = $ChatContext.messages;
					
					$ChatContext.messages = $LeftMessages;
					
					$RemovedCount = $removed.length;
					if($removed.content){
						$RemovedCount = $removed.content.length;
					}
					
					verbose "-- CHAT REMOVED DUE MAX CONTEXT SIZE: $removed $RemovedCount"
					$ChatContext.size -= [int]$RemovedCount;
				}
				
				$ChatContext.messages += @($msg);

				if($msg.content){
					$ChatContext.size += $msg.content.length;
				} else {
					$ChatContext.size += $msg.length;
				}
			}
			
			
			$Chat.num++
			$InternalMessages = @();
			try {
				verbose "Verbose habilitado..." 
				
				$Chat.LastPrompt = $prompt
				
				if($Object){
					$Exemplo1Json = @{PowerShaiJsonResult = @{
						prop1 = 123
						prop2 = "text value..."
						someArray = 1,2,3
					}} | ConvertTo-Json -Compress;
					
					$Exemplo2Json = @{PowerShaiJsonResult = "valor 1",123,"valor 3"} | ConvertTo-Json -Compress;
					
					$InternalMessages += @(
						"
							Retornar o resultado como JSON no formato: PowerShaiJsonResult:{JSON}
							EXEMPLO 1: $Exemplo1Json
							EXEMPLO 2: $Exemplo2Json
						"
					)
				}
				
				
				$Msg = @(
					@($SystemMessages|%{ [string]"s: $_"})
					@($InternalMessages|%{ [string]"s: $_"})
					$prompt
				)
				
				if($ShowFullSend){
					write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
				}
	
				if(!$Snub){
					$Msg | %{ AddContext $_ };
					$FullPrompt = $ChatContext.messages;
				}
				
				if($Forget){
					$FullPrompt = $Msg
				}
				

	
				#Generate functions!
				if($Chat.Tools.compiled -eq $null){
					$Chat.Tools.compiled  = @{
						CachedTime 	= (Get-Date)
						Tools 		= $null
					}
					
					verbose "Updating ParsedTools cached...";
					$Chat.Tools.compiled = CompileChatTools
				}
				
				
				$ToolList = @(
					$Chat.Tools.compiled
				)
				
				if($ChatUserParams.SystemMessageFixed){
					#Envia essa system message sempre!
					$FullPrompt = @("s: " + $ChatUserParams.SystemMessageFixed) + @($FullPrompt)
				}
				
				#obtem os parametros que são 

				$ChatParams = $DirectParams +  @{
					prompt 			= $FullPrompt
					Tools 			= $ToolList
					
					
					on 			= @{
								
								send = {
									if($VerboseEnabled){
										write-host -ForegroundColor DarkYellow "-- waiting model... --";
									}
								}
								
								stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
								answer = {param($inter,$evt) WriteModelAnswer $inter $evt}

								
								func = {
									param($interaction)
									
									$ans 		= $interaction.rawAnswer;
									$model 		= $ans.model;
									$funcName 	= $interaction.toolResults[-1].name
									
									
									if($PassThru){
										$MainCmdlet.WriteObject(@{event="func";interaction=$interaction});
										return;
									}
									
									if($ChatUserParams.PrintToolCalls -like "Name*"){
										write-host -ForegroundColor Blue "$funcName{" -NoNewLine
									
										if($ChatUserParams.PrintToolCalls -eq "NameArgs"){
												write-host ""
												write-host "Args:"
												$ToolArgs = $interaction.toolResults[-1].obj;
												write-host ($ToolArgs|fl|out-string)
										} else {
												write-host -ForegroundColor Blue -NoNewLine ...
										}
									
									}
								}
								
								funcresult = {
									param($interaction, $currentool, $FuncResp)
									
									# format using same formatter!
									$FuncResp.content = Format-PowershaiContext $FuncResp.content;
									
									$LastResult = $funcName = $interaction.toolResults[-1].resp.content;
									
									if($PassThru){
										$MainCmdlet.WriteObject(@{event="funcresult";interaction=$interaction});
										return;
									}
									
									if($ChatUserParams.PrintToolsResults){
										write-host "Result:"
										write-host $LastResult
									}
									
								}
						
								exec = {
									param($interaction)
									
									if($PassThru){
										$MainCmdlet.WriteObject(@{event="exec";interaction=$interaction});
										return;
									}
									
									if($ChatUserParams.PrintToolCalls -like "Name*"){
										write-host -ForegroundColor Blue "}"
										write-host ""
									}

								}
						}
				}
				
				if($Json){
					$ChatParams.Json = $true;
				}
				
				if($Object){
					$ChatParams.Json = $true;
					$ChatParams.Stream = $false;
				}
				
				if($VerboseEnabled){
					$ChatParams.Verbose = $true;
				}
				
				if($DisableTools){
					$ChatParams.Remove('Tools');
				}
				
				verbose "Params: $($ChatParams|out-string)"
				
				$Start = (Get-Date);
				$Ret 	= Invoke-AiChatTools @ChatParams;
				$End = Get-Date;
				$Total = $End-$Start;
				
				if($lines){
					WriteModelAnswer "FlushLine";
				}

				
				foreach($interaction in $Ret.interactions){ 
					
					$Msg = $interaction.rawAnswer.choices[0].message;
					
					if(!$msg){
						throw "POWERSHAI_CHAT_INVALIDRESULT: Model answer incorrect format. This can be a bug in provider."
					}
				
					AddContext $Msg
					
					$toolsResults = $interaction.toolResults;
					if($toolsResults){
						$toolsResults | %{ AddContext $_.resp }
					}

				}
				
				#Store the history of chats!
				$HistoryEntry = @{
					Ret = $Ret
					Elapsed = $Total
					object = $null
				}
				$Chat.history += $HistoryEntry
						
				if($Object){
					verbose "Object mode! Parsing json..."
					$JsonContent = @($Ret.answer)[0].choices[0].message.content
					verbose "Converting json to object: $JsonContent";
					$JsonObject = $JsonContent | ConvertFrom-Json;
					$ResultObj = $JsonObject;
					
					if($JsonObject.PowerShaiJsonResult){
						$ResultObj = $JsonObject.PowerShaiJsonResult
					}
					
					$HistoryEntry.object = $ResultObj
					write-output $ResultObj
				}
				
				
				$AllAnswers 	= @($Ret.interactions | %{$_.rawAnswer});
				$AnswersCost	= $Ret.costs
				
				

				
				# current chat
				$AnswerCount 	= $AllAnswers.count;
				$TotalCost 		= $AnswersCost.total
				$InputCost 		= $AnswersCost.input
				$OutputCost 	= $AnswersCost.output
				$TotalTokens 	= $AnswersCost.tokensTotal
				$InputTokens 	= $AnswersCost.tokensInput
				$OutputTokens 	= $AnswersCost.tokensOutput
				
				# all chats
				$ChatStats.TotalChats += $Chat.history.count;
				$TotalChats = $ChatStats.TotalChats
				
				## COSTS (total, input,output)
				$ChatStats.TotalCost += $TotalCost 
				$ChatStats.TotalInput += $InputCost
				$ChatStats.TotalOutput += $OutputCost
				
				## TOKENS QTY (total, input, output)
				$ChatStats.TotalTokens += $TotalTokens 
				$ChatStats.TotalTokensI += $InputTokens
				$ChatStats.TotalTokensO += $OutputTokens
				
				
				$AnswerLog = @(
					"Answer: $AnswerCount"
					"Cost: $TotalCost (i:$InputCost/o:$OutputCost)"
					"Tokens: $TotalTokens (i:$InputTokens/o:$OutputTokens)"
					"time: $($Total.totalMilliseconds) ms"
				) -Join " "
				
				$HistoryLog = @(
					"AllChats: $($ChatStats.TotalChats)"
					
					@(
						"Cost: $($ChatStats.TotalCost)"
						"(i:$($ChatStats.TotalInput)"
						"/"
						"o:$($ChatStats.TotalOutput))"
					) -Join ""
					
					@(
						"Tokens: $($ChatStats.TotalTokens)"
						"(i:$($ChatStats.TotalTokensI)"
						"/"
						"o:$($ChatStats.TotalTokensO))"
					) -Join ""
					
				) -Join " "
				
				
				if($ShowTokenStats){
					write-host "** $AnswerLog"
					write-host "** $HistoryLog"
				}
			} catch {
				$StackTrace = $_.ScriptStackTrace;
				$Msg = [string]$_;
				$ex = New-PowershaiError -Message "$Msg`n$StackTrace" -parent $_.Exception
				throw $ex;
			}
		}

		function ProcessContext {
			param($context)
			
			if($PrintContext){
				write-host -ForegroundColor Blue Contexto:
				write-host -ForegroundColor Blue $Context;
			}
			
			

			$ContextScriptParams = @{
				FormattedObject = $Context
				CmdParams 		= $MyParameters
				Chat 			= $ActiveChat
				prompt 			= $Prompt #processed prompt!
			}
			
			
			$ContextPrompt = & $PromptBuilderScript $ContextScriptParams
			
			verbose "Adding to context: $($Context|out-string)"
			ProcessPrompt $ContextPrompt
		}
	

		$ContextFormatParams = @{
			func 	= $FormatterFunc
			params 	= $FormatterParams
			ChatId 	= $ActiveChat.id
		}
		
		verbose "finishing beging block... start processing pipeline input..."
		[Collections.ArrayList]$AllContext = @()
	}
	
	process {

		if($ForEach -and $IsPipeline){
			# Convete o contexto para string!
			$StrContext = Format-PowershaiContext -obj $context @ContextFormatParams;
			ProcessContext $StrContext;
		} else {
			$null = $AllContext.Add($context);
		}
	}
	
	
	end {
		
		verbose "start processing endblock!"
		
		if(!$IsPipeline){
			ProcessPrompt $prompt
			return;
		}
		
		if($AllContext.length){
			# Convete o contexto para string!
			$StrContext = Format-PowershaiContext -obj $AllContext @ContextFormatParams;
			ProcessContext $StrContext;
		}

		if($Temporary){
			write-warning "Temporary chat"
		}
	}
	
	
	

}

# Send-PowershaaiChat é esperado ser o comando mais utilizado talvez.
# Reduzir o seu nome pode deixar mais confortável para o usuário.
# Os seguintes alias são os alias primários, em que o Send-PowershaiChat pode alterar seu comportamento se um deles for utilizado.
Set-Alias -Name ia -Value Send-PowershaiChat
Set-Alias -Name iat -Value Send-PowershaiChat
Set-Alias -Name io -Value Send-PowershaiChat
Set-Alias -Name iam -Value Send-PowershaiChat

# Estes são alias secundários, que são criados apenas para melhor interface com usuários de outros idiomas.
# Definimos uma alias para o alias primario, pois isso manterá o comportamento do Send-PowershaiChat, que pode alterar conforme o alias primário.
# 	Ele contém toda a lógica necessáro para detecta esse cenário!
Set-Alias -Name ai 	-Value ia
Set-Alias -Name ait -Value iat
Set-Alias -Name ao 	-Value io
Set-Alias -Name aim -Value io



function Clear-PowershaiChat {
	<#
		.SYNOPSIS
			Apaga elementos de um chat!
		.DESCRIPTION
			Apaga elementos específico de um chat.  
			Útil apra liberar recursos, ou tirar o vício do llm devido ao histórico.
	#>
	param(
		
		#Apaga todo o histórico
			[switch]$History
			
		,#Apaga o contexto 
			[switch]$Context
		
		#Id do chat. Padrão: ativo.
		,$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId;
	
	if($context){
		verbose "Clearing context..."
		$Chat.context = NewChatContext
	}
	
	if($history){
		verbose "Clearing history"
		$Chat.history = @();
	}
	
}

function Reset-PowershaiCurrentChat {
	<#
		.SYNOPSIS
			Apaga o histórico e o contexto do chat atual.
	#>
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat -ChatId $ChatId
	
    if($PSCmdlet.ShouldProcess("Current chat: $($Chat.id)")) {
        Clear-PowershaiChat -History -Context
    }
}

function Reset-PowershaiChatToolsCache {
	<#
		.SYNOPSIS
			Limpa o cache de AI Tools.
		
		.DESCRIPTION
			O PowershAI mantém um cache com as tools "compiladas".
			Quando o PowershAI envia a lista de tools pro LLM, ele precisa enviar junto a descrição da tools, lista de paraemtros, descrição, etc.  
			Montar essa lista pode consumir um tempo signifciativo, uma vez que ele vai varrer a lista de tools, funcoes, e pra cada um, varrer o help (e o help de cada parametro).
			
			Ao adicionar um cmdlet como Add-AiTool, ele não compila naquele momento.
			Ele deixa para fazer isso quando ele precisa invocar o LLM, na funcao Send-PowershaiChat.  
			Se o cache não existe, então ele compila ali na hora, o que pode fazer com que esse primeiro envio ao LLM, demora alguns millisegundos ou segundos a mais que o normal.  
			
			Esse impacto é proprocional ao numero de funcoes e parâmetros enviados.  
			
			Sempre que você usa o Add-AiTool ou Add-AiScriptTool, ele invalida o cache, fazendo com que na proxima execução, ele seja gerado.  
			ISso permite adicionar muitas funcoes de uma só vez, sem que seja compilado cada vez que você adicona.
			
			Porém, se você alterar sua função, o cache não é recalcuado.  
			Então, você deve usar esse cmdlet para que a proxima execução contenha os dados atualizados das suas tools após alteracoes de código ou de script.
	#>
	[CmdletBinding()]
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId
	
	$ChatTools = $Chat.Tools
	
	if($ChatTools.compiled){
		$ChatTools.compiled = $null
	}
}

#
####
#### CHAT TOOLS
####
#
#


function  Add-PowershaiChatTool {
	<#
		.SYNOPSIS
			Adiciona funcoes, scripts, executáveis como uma tool invocável pelo LLM no chat atual (ou default para todos).
		
		.DESCRIPTION
			Adiciona funcoes na sessao atual para a lista de Tool caling permitidos!
			Quando um comando é adicionado, ele é enviado ao modelo atual como uma opcao para Tool Calling.
			O help dsponivel da função será usado para descrevê-la, iuncluindo os parâmetros.
			Com isso, você pode, em runtime, adicionar novas habilidades na IA que poderão ser invocadas pelo LLM e executadas pelo PowershAI.  
			
			AO adicionar scritps, todas as funcoes dentro do script são adicionadas de uma só vez.
			
			Para mais informações sobre tools consule o topico about_Powershai_Chats
			
			MUITO IMPORTANTE: 
			NUNCA ADICIONEI COMANDOS QUE VOCÊ NÃO CONHEÇA OU QUE POSSAM COMPROMETER SEU COMPUTADOR.  
			O POWERSHELL VAI EXECUTÁ-LO A PEDIDO DO LLM E COM OS PARÂMETROS QUE O LLM INVOCAR, E COM AS CREDENCIAIS DO USUÁRIO ATUAL.  
			SE VOCÊ ESTIVER LOGADO COM UMA CONTA PRIVILEGIADA, COMO O ADMINISTRADOR, NOTE QUE VOCÊ PODERÁ EXECUTAR QUALQUER AÇÃO A PEDIDO DE UM SERVER REMOTO (O LLM).
	#>
	[CmdletBinding()]
	param(
		#Nome do comando, caminho do script ou executável
		#Pode ser um array de string com estes elementos misturados.
		#Quando nome que termina com .ps1 é passado, é tratado como um script (isto é, será carregado as funcoes do script)
		#Caso queria tratar com um comando (executar o script), informe o parâmetor -Command, para forçar ser tratado como um comando!
			$names
			
		,#Descrição para esse tool a ser passada ao LLM.  
		 #O comando vai usar o help e enviar, também o conteúdo descrito
		 #Se este parâmetro for adicionado, ele é enviado junto com o help.
			$description
		
		,#Força tratar como command. Útil quando você quer que um script seja executado como comando.
		 #ùtil somente quando você passa um nome ambíguo de arquivo, que coincide como nome de algum comando!
			[switch]$ForceCommand
			
		,#Chat em qual criar a tool 
			$ChatId = "."
			
		,#Cria a tool globalmente, isto é, será disponível em todos os chats 
			[switch]$Global
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Tools = $Chat.tools.raw;
	
	$scope = "chat"
	if($Global){
		$Tools = $POWERSHAI_SETTINGS.UserTools
		$scope = "global"
	}
	
	if(!$names){
		throw "POWERSHAI_AITOOLS_NOTOOL: Must inform some tool -names parameter";
	}
	
	
	foreach($CommandName in $names){
		$ToolIndex = $CommandName;
		$ToolType = "command"
		
		#Se é uma uri vlaida
		$uri = [uri]$CommandName
		$IsScript = $false;
		
		if($CommandName -like "*.ps1" -and !$ForceCommand){
			$IsScript = $true;
		}
		
		$CommandInfo = $null;
		if($IsScript){
			[string]$AbsPath = Resolve-Path $CommandName -EA SilentlyContinue
			
			if(!$AbsPath){
				throw "POWERSHAI_AITOOL_SCRIPT_FILENOTFOUND: $CommandName";
			}
	
			$ToolIndex = "Path:" + $AbsPath;
			$CommandName = $AbsPath;
			$ToolType = "file"
		}
		else {
			$CommandInfo = Get-Command $CommandName;
		}
		
		$ToolInfo = [PsCustomObject]@{
			name 			= $CommandName
			ComamndInfo 	= $CommandInfo
			UserDescription = $description
			type 			= $ToolType 
			formatter 		= $null #deprecated!
			enabled 		= $true
			chats 			= @()
			scope 			= $scope
		}
		
		SetType $ToolInfo AiToolInfo;
		
		$Tools[$ToolIndex] = $ToolInfo;
	}
	
	#Atualiza o cache das tools!
	Reset-PowershaiChatToolsCache -ChatId $ChatId
}
Set-Alias Add-AiTool Add-PowershaiChatTool


function Get-PowershaiChatTool {
	<#
		.SYNOPSIS
			Obtéma a list de tools atuais.
	#>
	[CmdletBinding()]
	param(
		# obter especifico pelo nome ou o proprio objeto!
		# Se terminar como um .ps1, trata como script, a menos que ForceCommand seja usado!
			$tool = "*"
			
		,#listar somente as tools habilitadas 
			[switch]$Enabled
			
		,#Chat de origem 
			$ChatId = "."

		,#Quando obtendo uma tool específica, procurar na lista de tools globais.
			[switch]$global 
		
		,#Trata tool como um command!
			[switch]$ForceCommand
	)
	
	$Chat = Get-PowershaiChat $ChatId
	
	$IsScript = $false;

	function ListTools {
		param($src, $scope)
		
		$Names = @($src.keys)
		foreach($ToolName in $Names){
			$ToolInfo = $src[$ToolName];
			
			
			if($Enabled -and !$ToolInfo.enabled){
				continue
			}
			
			
			$ToolInfo
		}
	}

	if(!$tool){
		throw "POWERSHAI_GETTOOLS_EMPTY: Must inform -tool";
	}
	
	if($tool -eq "*"){
		ListTools $Chat.Tools.raw "chat"
		ListTools $POWERSHAI_SETTINGS.UserTools "global"
	} else {
		
		if($Tool -like "*.ps1" -and !$ForceCommand){
			$IsScript = $true;
		}
		
		if(IsType $tool AiToolInfo){
			return $tool;
		} else {
			$ToolsStore = $Chat.Tools.raw
			if($Global){
				$ToolsStore = $POWERSHAI_SETTINGS.UserTools
			}
			
			[string]$ToolIndex = $tool;
			if($IsScript){
				[string]$AbsPath = Resolve-Path $tool
				$ToolIndex = "Path:" + $AbsPath
			} 
			
			$ToolInfo = $ToolsStore[$ToolIndex];
			
			if(!$ToolInfo){
				throw "POWERSHAI_GETTOOLS_NOTFOUND: Tool not found, name $tool. Global=$([bool]$Global), Script=$([bool]$IsScript)";
			}
			
			return $ToolInfo;
		}
	}
}
Set-Alias Get-AiTools Get-PowershaiChatTool


function Remove-PowershaiChatTool {
	<#
		.SYNOPSIS
			Remove uma tool definitivamente!
	#>
	[CmdletBinding()]
	param(
		#Nome do comando, script, funcoes que foi previamente adicioonado como tool.
		#Se for um arquivo .ps1, trata como um script, a menos que -Force command é usado.
		#Você pode usar o resultado de Get-PowershaiChatTool via pipe para este comando, que ele irá reconhecer
		#Ao enviar o objeto retornado, todos os demais parâmetros são ignorados.
		[parameter(ValueFromPipeline=$true)]
			$tool
			
		,#Força tratar tool como um comando, quando é uma string 
			[switch]$ForceCommand 
			
		,#Chat de onde remover 
			$ChatId = "."
			
		,#Remover da lista global, se a tool foi adicionada previamente como global 
			[switch]$global
	)
	
	begin {
		$Chat = Get-PowershaiChat $ChatId
		$ToolStore = $Chat.Tools.Raw;
		$IsGlobal = [bool]$global;		
	}
	
	process {
		$IsPath = $False;
		
		if(IsType $tool AiToolInfo){
			$IsPath = $tool.type -eq "file"
			$IsGlobal = $tool.scope -eq "global"
			$name = $tool.name
		}
		else {
			$name = [string]$tool
			if($name -like "*.ps1" -and !$ForceCommand){
				$IsPath = $true;
			}
		}
			
		if($IsGlobal){
			verbose "Using global tools store"
			$ToolStore = $POWERSHAI_SETTINGS.UserTools
		}
		
		$ToolIndex = $name;
		if($IsPath){
			[string]$AbsPath = Resolve-Path $name -EA SilentlyContinue
			$ToolIndex = "Path:" + $AbsPath;
		}
		verbose "Tool Index: $ToolIndex";
		
		
		if($ToolStore.contains($ToolIndex)){
			verbose "Removing tool";
			$ToolStore.Remove($ToolIndex);
		}
		
		verbose "Reseting cache";
		#Atualiza o cache das tools!
		Reset-PowershaiChatToolsCache -ChatId $ChatId
	}
}
Set-Alias Remove-AiTool Remove-PowershaiChatTool


function Set-PowershaiChatTool {
	<#
		.SYNOPSIS
			Desabilita um tool (mas não remove). Tool desabiltiada não é enviada ao LLM.
	#>
	[CmdletBinding()]
	param(
		#Nome da tool (mesmo de Add-PowershaiChatTool) ou via pipe o resultado de Get-PowershaiChatTool
			[parameter(ValueFromPipeline=$true)]
			$tool 
		
		,#habilita a tool.
			[Parameter(ParameterSetName="Enable")]
			[switch]$Enable
			
		,#desabilita a tool.
			[Parameter(ParameterSetName="Disable")]
			[switch]$Disable
		
		,#Se informado, e tool é um nome, força o mesmo a ser tratado como script!
			[switch]$ForceCommand
			
		,#Chat em qual a tool está 
			$ChatId = "."
			
		,#Procura a tool na lista global de Tools	
			[switch]$Global
	)
	
	begin {
		$Chat = Get-PowershaiChat $ChatId
	}
	
	process {	
		$Tool = Get-AiTools -ChatId $ChatId -tool $tool -global:$global -ForceCommand:$ForceCommand
		
		if($Tool){
			$OldState = $Tool.enabled
			
			if($Enable){
				$Tool.enabled = $true
			}
			
			if($Disable){
				$Tool.enabled = $false
			}
			
			verbose "	Setting from $OldState to $($Tool.enabled)"
		}
		
	}
	
	end {
		Reset-PowershaiChatToolsCache
	}
	
}
Set-Alias Set-AiTool Set-PowershaiChatTool

RegArgCompletion Set-AiTool,Remove-AiTool tool {
	param($cmd,$param,$word,$ast,$fake)
	
	Get-AiTools | ? { $_.name -like "$word*" } | %{
		if($_.type -eq "file"){
			"path:" + $_.name
		} else {
			$_.name
		}
		
	}
}



<#
	.SYNOPSIS 
		Converte todas as tools adicionadas no formato esperado pela função Invoke-AiChatTools.
		
	.DESCRIPTION  
		Obtém todas as tools cadastradas pelo usuário com New-PowershaiChatTool e compila em um único objeto para ser enviado ao LLM usando Invoke-AiChatTools.  
		Este processo pode ser bem lento, dependendo da quantidade de tools adicionadas.
		
		O cmdlet vai pecorrer todas as tools, obter o help dos comando e dos parâmetros, e converter isso em um formato que possa ser enviado em Invoke-AiChatTools
		Como o PowershAI define que o mecanismo de tools deve seguir o padrão da OpenAI, a função Get-OpenaiTool* do provider OpenAI é usada.  
		Estas funcões contém a lógica necessária para gerar o schema da tool calling seguindo as especificações da OpenAI.  
		
		Este comando, itera em cada tool disponível para o chat atual e cria o que é necessário para ser enviado com Invoke-AiChatTools. 
		Invoke-AiChatTools contém toda a lógica para lidar com o envio, execução e resposta do LLM.  
		
		Basicamente, existem 2 tipos de tools que o Powershai Suporte: Script ou Comando.  
		Comando é qualquer código executável pelo powershell: funções, .exe, cmdlets nativos, etc.
		
		Scripts são simples arquivos .ps1 que definem as funções que podem ser usadas como tools.
		É como se fosse um grupo de comandos.
		
		Este comando invoca tudo o que é necessário para converter essas tools no formato padrão esperado Invoke-AiChatTools.  
		Invoke-AiChatTools não sabe nada sobre chats, tools globais. Ela é uma função genérica que não depende do mecanismo de Chats criado pelo Powershai.  
		
		Por isso, é necessário que esta função faça toda essa "tradução" das facilidades do Powershai Chat para o esperado pelo Invoke-AiChatTools.
#>
function Invoke-CompilePowershaiChatTools {
	[CmdletBinding()]
	param(
		#Chat do qual serão obtidos as tools 
		#Além do chat, as tools globais serão inclusas
		$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Compiled = @{
		ToolList = @()
	}
	
	function CompileTools {
		param($src, $scope)
		
		$Names = @($src.keys)
		
		
		
		$CmdIndex = @{}
		$CmdTools = @{
			tools = @()
			CmdIndex = $CmdIndex
			src = $scope
			type = "toolbox"
			map = {
				param($ToolName,$Me)
				
				$ToolData = $Me.CmdIndex[$ToolName];
				$Original = $ToolData.original
				
				# obtém a tool!
				$Tool = & $Original.map $ToolName $Original
				
				$Script = {
					param($HashArgs)
					
					$Result = & $Tool.func @HashArgs
					
					if($ToolData.formatter -and $ToolData.formatter -is [scriptblock]){
						return & $ToolData.formatter $Result
					} else {
						return $Result
					}
				}.GetNewClosure()
				
				@{func = $Script; NoSplatArgs = $true}
			}
			
		}
			
		foreach($name in $names){
			$Tool = $src[$name];
			
			if(!$Tool.enabled){
				continue;
			}
			
			if($Tool.type -eq "file"){
				$Compiled.ToolList += Get-OpenaiToolFromScript $Tool.name
			}
			
			if($Tool.type -eq "command"){
				
				$ParamList = "*"
				
				if($Tool.parameter){
					$ParamList = $Tool.parameter 
				}
				
				$OpenaiTools = @(Get-OpenaiToolFromCommand -functions $Tool.name -parameters $ParamList -UserDescription $Tool.UserDescription)
				$OriginalTool = $OpenaiTools[0]
				
				$ToolData = @{
					original 	= $OriginalTool
					formatter 	= $Tool.formatter
				}
				
				$CmdIndex[$Tool.name] = $ToolData
				$CmdTools.tools += $OriginalTool.tools;
			}
		}
		
		$Compiled.ToolList += $CmdTools
	}
	

	CompileTools $Chat.Tools.raw "chat"
	CompileTools $POWERSHAI_SETTINGS.UserTools "global"
	
	
	return $Compiled.ToolList
}
Set-Alias CompilePowershaiChatTools Invoke-CompilePowershaiChatTools 
Set-Alias CompileChatTools Invoke-CompilePowershaiChatTools



