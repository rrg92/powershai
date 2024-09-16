---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Définit la fonction qui sera utilisée pour formater les objets passés au paramètre Send-PowershaiChat -Context

## DESCRIPTION <!--!= @#Desc !-->
Lors de l'appel de Send-PowershaiChat dans un pipeline, ou en passant directement le paramètre -Context, il injectera cet objet dans l'invite du LLM.  
Avant de l'injecter, il doit convertir cet objet en une chaîne de caractères.  
Cette conversion est appelée "Context Formatter" ici dans Powershai.  
Le Context Formatter est une fonction qui prendra chaque objet passé et le convertira en une chaîne de caractères pour être injecté dans l'invite.
La fonction utilisée doit recevoir en premier paramètre l'objet à convertir.  

Les autres paramètres sont à votre choix. Leurs valeurs peuvent être spécifiées en utilisant le paramètre -Params de cette fonction !

Powershai met à disposition des formatteurs de contexte natifs.  
Utilisez Get-Command ConvertTo-PowershaiContext* ou Get-PowershaiContextFormatters pour obtenir la liste !

Étant donné que les formatteurs de contexte natifs ne sont que des fonctions PowerShell, vous pouvez utiliser Get-Help Nom pour obtenir plus de détails.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
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

### -Func
Nom de la fonction powershell
Utilisez la commande Get-PowershaiContextFormatters pour voir la liste

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
