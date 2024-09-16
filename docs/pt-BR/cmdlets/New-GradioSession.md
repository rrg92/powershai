---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Cria uma nova sessão Gradio.

## DESCRIPTION <!--!= @#Desc !-->
Uma Sessions representa uma conexão para uma app Gradio.  
Imagina que uma session seja como se fosse uma aba do browser aberto conectado em uma determinada app gradio.  
Os arquivos enviados, chamadas feitas, logins, são todas gravas nesta session.

Este cmndlet retorna um objeto que chamamos de "GradioSesison".  
Este objeto pode ser usado em outros commandlets que dependem de session (e pode ser definido uma session ativa, que todos os cmdlets usam por padrão se não especificado).  

Toda session tem um nome que a identifica unicamente. Se não informado pelo usuário, será criado autoamticamente com base na URL da app.  
Não podem existir 2 sessions com o mesmo nome.

Ao criar um session, este cmdlet salva esta session em um repositorio interno de sessions.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
Url da app

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
Nome unico que identifica esta sessao!

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
Diretório onde fazer o donwload dos arqiovpos

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
Force recreate

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