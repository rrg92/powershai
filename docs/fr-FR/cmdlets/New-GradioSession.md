---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Crée une nouvelle session Gradio.

## DESCRIPTION <!--!= @#Desc !-->
Une session représente une connexion à une application Gradio.  
Imaginez une session comme un onglet de navigateur ouvert connecté à une application Gradio spécifique.  
Les fichiers envoyés, les appels effectués, les connexions sont tous enregistrés dans cette session.

Cette cmdlet renvoie un objet que nous appelons "GradioSession".  
Cet objet peut être utilisé dans d'autres cmdlets qui dépendent de la session (et une session active peut être définie, que tous les cmdlets utilisent par défaut si elle n'est pas spécifiée).  

Chaque session a un nom qui l'identifie de manière unique. Si l'utilisateur ne le renseigne pas, il sera créé automatiquement en fonction de l'URL de l'application.  
Il ne peut pas exister 2 sessions avec le même nom.

Lorsqu'une session est créée, cette cmdlet enregistre cette session dans un référentiel interne de sessions.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
Url de l'application

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

### -Name
Nom unique qui identifie cette session !

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

### -DownloadPath
Répertoire où télécharger les fichiers

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

### -Force
Forcer la recréation

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
