---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
يرجع قائمة المعلمات المتاحة في دردشة

## DESCRIPTION <!--!= @#Desc !-->
يعيد هذا الأمر كائنًا يحتوي على قائمة الخصائص.  
الكائن في الواقع هو مجموعة، حيث يمثل كل عنصر خاصية.  

تحتوي هذه المجموعة المرجعة على بعض التعديلات لتسهيل الوصول إلى المعلمات. 
يمكنك الوصول إلى المعلمات باستخدام الكائن المرجّع مباشرةً، دون الحاجة إلى تصفية قائمة المعلمات.
وهذا مفيد عند الرغبة في الوصول إلى معلمة محددة من القائمة.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
