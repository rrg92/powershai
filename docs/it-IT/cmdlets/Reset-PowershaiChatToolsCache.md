---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
Limpa a cache das ferramentas de IA.

## DESCRIPTION <!--!= @#Desc !-->
Il PowershAI mantiene una cache con le tools "compilate".
Quando il PowershAI invia l'elenco delle tools al LLM, deve inviare insieme la descrizione delle tools, l'elenco dei parametri, la descrizione, ecc.
Costruire questo elenco può richiedere un tempo significativo, poiché deve scorrere l'elenco delle tools, delle funzioni e per ciascuna, deve scorrere l'help (e l'help di ciascun parametro).

Quando si aggiunge un cmdlet come Add-AiTool, non viene compilato in quel momento.
Lo fa quando deve invocare il LLM, nella funzione Send-PowershaiChat.
Se la cache non esiste, allora la compila in quel momento, il che può far sì che il primo invio al LLM impieghi qualche millisecondo o secondo in più del normale.

Questo impatto è proporzionale al numero di funzioni e parametri inviati.

Ogni volta che si utilizza Add-AiTool o Add-AiScriptTool, invalida la cache, in modo che alla successiva esecuzione venga generata.
Questo consente di aggiungere molte funzioni in una sola volta, senza che vengano compilate ogni volta che si aggiunge una funzione.

Tuttavia, se si modifica la funzione, la cache non viene ricalcolata.
Pertanto, è necessario utilizzare questo cmdlet affinché la successiva esecuzione contenga i dati aggiornati delle proprie tools dopo modifiche di codice o di script.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
