---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Formate un objet pour être injecté dans le contexte d'un message envoyé dans un Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
Étant donné que les LLM ne traitent que les chaînes, les objets passés dans le contexte doivent être convertis en un format de chaîne avant d'être injectés dans l'invite.
Et, comme il existe plusieurs représentations d'un objet en chaîne, Powershai permet à l'utilisateur d'avoir un contrôle total sur cela.  

Chaque fois qu'un objet doit être injecté dans l'invite, lorsqu'il est appelé avec Send-PowershaAIChat, via une pipeline ou un paramètre Contexte, cet applet de commande sera appelé.
Cet applet de commande est responsable de transformer cet objet en chaîne, indépendamment de l'objet, qu'il s'agisse d'un tableau, d'une table de hachage, d'un objet personnalisé, etc.  

Il le fait en appelant la fonction de formateur configurée à l'aide de Set-PowershaiChatContextFormatter
En général, vous n'avez pas besoin d'appeler cette fonction directement, mais vous pouvez le faire si vous souhaitez effectuer des tests !

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
Tout objet à injecter

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

### -params
Paramètre à passer à la fonction de formateur

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

### -func
Remplace la fonction à appeler. Si non spécifié, utilise la valeur par défaut du chat.

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

### -ChatId
Chat sur lequel opérer

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
