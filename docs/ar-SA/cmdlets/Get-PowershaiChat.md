---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
يرجع واحدًا أو أكثر من الدردشات التي تم إنشاؤها باستخدام New-PowershaAIChat

## DESCRIPTION <!--!= @#Desc !-->
يُمكن لهذا الأمر إرجاع الكائن الذي يمثل دردشة Powershai.  
هذا الكائن هو الكائن الذي يتم الإشارة إليه داخليًا بواسطة الأوامر التي تعمل في دردشة Powershai.  
على الرغم من إمكانية تغيير بعض المعلمات مباشرة، لا يُنصح بإجراء هذه الإجراءات.  
من الأفضل دائمًا استخدام إخراج هذا الأمر كمدخل للأوامر الأخرى في PowershaiChat.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
معرف الدردشة
أسماء خاصة:
	. - يشير إلى الدردشة نفسها 
 	* - يشير إلى جميع الدردشات

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

### -SetActive
تعيين الدردشة كنشطة، عندما لا يكون المعرف المحدد اسمًا خاصًا.

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

### -NoError
تجاهل أخطاء التحقق من الصحة

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
