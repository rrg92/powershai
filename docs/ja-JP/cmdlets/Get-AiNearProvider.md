---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
現在のスクリプトから最も近いプロバイダーを取得します

## DESCRIPTION <!--!= @#Desc !-->
この cmdlet は、通常、Get-AiCurrentProvider を介してプロバイダーによって間接的に使用されます。  
PowerShell のコールスタックを確認し、呼び出し元（実行した関数）がプロバイダーのスクリプトの一部であるかどうかを特定します。  
その場合、そのプロバイダーを返します。

複数プロバイダーから呼び出された場合、最も新しいプロバイダーが返されます。 例として、次のシナリオを検討してください。

	ユーザー -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
この場合、2 つのプロバイダーコールが関与していることに注意してください。  
この場合、Get-AiNearProvider 関数は、コールスタックで最も新しいプロバイダーであるため、プロバイダー y を返します。

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
