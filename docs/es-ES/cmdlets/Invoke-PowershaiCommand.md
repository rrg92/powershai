---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiCommand

## SYNOPSIS <!--!= @#Synop !-->
Permite invocar a maioria das funções de uma maneira compacta

## DESCRIPTION <!--!= @#Desc !-->
Este é um simples utilitário que permite invocar diversas funções de uma forma mais reduzida na linha de comando.  
Note que nem todos os comandos podem ser suportados ainda.

É melhor usado com o alias pshai.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
pshai tools # lista as tools
```


## PARAMETERS <!--!= @#Params !-->

### -CommandName
Nome do comando

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RemArgs

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
