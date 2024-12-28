---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiCredential

## SYNOPSIS <!--!= @#Synop !-->
Executa um código e disponibiliza uma credential específica sempre

## DESCRIPTION <!--!= @#Desc !-->
Este comando permite executar um código que sempre vai usar uma credencial específica.
Sempre que a fução Get-AiDefaultCredential for invocada, a credential informada será retornada sempre.

## SYNTAX <!--!= @#Syntax !-->

```
Enter-AiCredential [[-credential] <Object>] [[-code] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -credential

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

### -code

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