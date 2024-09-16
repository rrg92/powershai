---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiCommand

## SYNOPSIS <!--!= @#Synop !-->
Permite invocar a maioria das funções de uma maneira compacta

## DESCRIPTION <!--!= @#Desc !-->
Este é um simples utilizario que permite invocar diversas funcoes de uma forma mais reduzia na linha de comando.  
Note que nem todos os comandos podem ser suportados ainda.

É melhor usado com o alia pshai.

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
Command name

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