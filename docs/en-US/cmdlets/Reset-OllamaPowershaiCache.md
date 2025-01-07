---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-OllamaPowershaiCache

## SYNOPSIS <!--!= @#Synop !-->
Resets the ollama model cache in powershai

## DESCRIPTION <!--!= @#Desc !-->
Ollama maintains a model cache to avoid querying detailed information all the time.  
This command resets that cache. When retrieving the information next time (using Get-AiModels), the cache is populated again.

This cache is also reset automatically whenever powershai is imported again.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-OllamaPowershaiCache [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
