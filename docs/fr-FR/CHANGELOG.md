# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Ajout de groq aux tests automatiques

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Correction d'une erreur dans le provider groq, liée aux messages système
- **COHERE PROVIDER**: Correction d'une erreur liée aux messages du modèle lorsqu'ils contenaient des réponses d'appels d'outils.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Les chats étaient recréés à chaque fois, empêchant de conserver l'historique correctement lors de l'utilisation de plusieurs chats !
- **OPENAI PROVIDER**: Correction du résultat de `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction des erreurs du provider Hugging Face dues aux redirections.
- Correction de l'installation des modules pour les tests en utilisant Docker Compose.
- Correction des problèmes de performance lors de la conversion des outils en raison d'un nombre potentiellement élevé de commandes dans une session. Utilise désormais des modules dynamiques. Voir `ConvertTo-OpenaiTool`.
- Correction des problèmes d'incompatibilité entre l'API GROQ et OpenAI. `message.refusal` n'est plus accepté.
- Correction de petits bugs dans PowerShell Core pour Linux.
- **OPENAI PROVIDER**: Résolution du code d'exception causé par l'absence d'un modèle par défaut.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOUVEAU PROVIDER**: Bienvenue Azure 🎉
- **NOUVEAU PROVIDER**: Bienvenue Cohere 🎉
- Ajout de la fonctionnalité `AI Credentials` — une nouvelle manière standard pour les utilisateurs de définir des informations d'identification, permettant aux providers de demander des données d'identification aux utilisateurs.
- Providers migrés pour utiliser `AI Credentials`, tout en maintenant la compatibilité avec les commandes plus anciennes.
- Nouvelle cmdlet `Confirm-PowershaiObjectSchema`, pour valider les schémas en utilisant OpenAPI avec une syntaxe plus "PowerShellzada".
- Ajout du support des redirections HTTP dans la lib HTTP
- Ajout de plusieurs nouveaux tests avec Pester, allant des tests unitaires de base à des cas plus complexes, tels que les appels d'outils LLM réels.
- Nouvelle cmdlet `Switch-PowershaiSettings` permet de basculer entre les paramètres et de créer des chats, des providers par défaut, des modèles, etc., comme s'il s'agissait de profils distincts.
- **Retry Logic**: Ajout de `Enter-PowershaiRetry` pour réexécuter des scripts en fonction de conditions.
- **Retry Logic**: Ajout de la logique de retry dans `Get-AiChat` pour exécuter facilement le prompt au LLM à nouveau si la réponse précédente n'est pas conforme à ce qui est souhaité.
- Nouvelle cmdlet `Enter-AiProvider` permet désormais d'exécuter du code sous un provider spécifique. Les cmdlets qui dépendent d'un provider utiliseront toujours le provider dans lequel on est "entré" le plus récemment au lieu du provider actuel.
- Pile de Provider (Push/Pop) : Tout comme dans `Push-Location` et `Pop-Location`, vous pouvez maintenant insérer et supprimer des providers pour des changements plus rapides lors de l'exécution de code dans un autre provider.
- Nouvelle cmdlet `Get-AiEmbeddings`: Ajout de cmdlets standards pour obtenir des embeddings d'un texte, permettant aux providers d'exposer la génération d'embeddings et aux utilisateurs d'avoir un mécanisme standard pour les générer.
- Nouvelle cmdlet `Reset-AiDefaultModel` pour désélectionner le modèle par défaut.
- Ajout des paramètres `ProviderRawParams` à `Get-AiChat` et `Invoke-AiChat` pour écraser les paramètres spécifiques dans l'API, par provider.
- **HUGGINGFACE PROVIDER**: Ajout de nouveaux tests utilisant un space Hugging Face exclusif réel maintenu comme un sous-module de ce projet. Cela permet de tester plusieurs aspects en même temps : sessions Gradio et intégration Hugging Face.
- **HUGGINGFACE PROVIDER**: Nouvelle cmdlet : Find-HuggingFaceModel, pour rechercher des modèles dans le hub en fonction de certains filtres !
- **OPENAI PROVIDER**: Ajout d'une nouvelle cmdlet pour générer des appels d'outils : `ConvertTo-OpenaiTool`, supportant les outils définis dans des blocs de script.
- **OLLAMA PROVIDER**: Nouvelle cmdlet `Get-OllamaEmbeddings` pour retourner des embeddings en utilisant Ollama.
- **OLLAMA PROVIDER**: Nouvelle cmdlet `Update-OllamaModel` pour télécharger des modèles ollama (pull) directement depuis powershai
- **OLLAMA PROVIDER**: Détection automatique des tools en utilisant les métadonnées d'ollama
- **OLLAMA PROVIDER**: Cache des métadonnées des modèles et nouvelle cmdlet `Reset-OllamaPowershaiCache` pour nettoyer le cache, permettant de consulter de nombreux détails des modèles ollama, tout en maintenant la performance pour l'utilisation répétée de la commande

### Changed <!--AiDoc:Translator:IgnoreLine-->
- <!--!**BREAKING CHANGE**:--> **Changement cassant :** Le paramètre du Chat `ContextFormatter` a été renommé en `PromptBuilder`.
- Modification de l'affichage par défaut (formats.ps1xml) de certaines cmdlets comme `Get-AiModels`.
- Amélioration de la journalisation détaillée lors de la suppression de l'ancien historique en raison de `MaxContextSize` dans les chats.
- Nouvelle façon dont les paramètres de PowershAI sont stockés, introduisant un concept de "Stockage de Paramètres", permettant l'échange de configuration (par exemple, pour les tests).
- Mise à jour des emojis affichés avec le nom du modèle lors de l'utilisation de la commande Send-PowershaiChat
- Améliorations de la cryptographie de l'export/import de paramètres (Export=-PowershaiSettings). Utilise désormais comme dérivation de clé et salt.
- Amélioration du retour de l'interface *_Chat, pour qu'elle soit plus fidèle au standard de OpenAI.
- Ajout de l'option `IsOpenaiCompatible` pour les providers. Les providers qui souhaitent réutiliser les cmdlets OpenAI doivent définir cet indicateur sur `true` pour fonctionner correctement.
- Amélioration du traitement des erreurs de `Invoke-AiChatTools` dans le traitement de l'appel d'outils.
- **GOOGLE PROVIDER**: Ajout de la cmdlet `Invoke-GoogleApi` pour permettre aux utilisateurs d'effectuer des appels d'API directs.
- **HUGGING FACE PROVIDER**: Petits ajustements dans la façon d'insérer le token dans les requêtes de l'API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` et `Get-OpenaiToolFromScript` utilisent désormais `ConvertTo-OpenaiTool` pour centraliser la conversion de commande en outil OpenAI.
- **GROQ PROVIDER**: Mise à jour du modèle par défaut de `llama-3.1-70b-versatile` vers `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels inclut désormais les modèles qui supportent les tools, car le provider utilise le endpoint /api/show pour obtenir plus de détails sur les modèles, ce qui permet de vérifier le support des tools

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction d'un bug dans la fonction `New-GradioSessionApiProxyFunction`, lié à certaines fonctions internes.
- Ajout du support de Gradio 5, qui est nécessaire en raison des modifications des endpoints de l'API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Support des images dans `Send-PowershaiChat` pour les providers OpenAI et Google.
- Une commande expérimentale, `Invoke-AiScreenshots`, qui ajoute le support pour prendre des captures d'écran et les analyser !
- Support pour l'appel d'outils dans le provider Google.
- Le CHANGELOG a été démarré.
- Support du TAB pour Set-AiProvider.
- Ajout du support de base pour la sortie structurée au paramètre `ResponseFormat` de la cmdlet `Get-AiChat`. Cela permet de passer une table de hachage décrivant le schéma OpenAPI du résultat.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- <!--!**BREAKING CHANGE**:--> **Changement cassant :** La propriété `content` des messages OpenAI est désormais envoyée sous forme de tableau pour s'aligner sur les spécifications pour les autres types de médias. Cela nécessite la mise à jour des scripts qui dépendent du format de chaîne unique précédent et des anciennes versions de providers qui ne supportent pas cette syntaxe.
- Le paramètre `RawParams` de `Get-AiChat` a été corrigé. Vous pouvez désormais passer les paramètres de l'API au provider en question pour avoir un contrôle strict sur le résultat
- Mises à jour de DOC : Nouveaux documents traduits avec AiDoc et mises à jour. Petite correction dans AiDoc.ps1 pour ne pas traduire certaines commandes de syntaxe markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction #13. Les paramètres de sécurité ont été modifiés et le traitement de la casse a été amélioré. Cela n'était pas validé, ce qui entraînait une erreur.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et de l'IA_
<!--PowershaiAiDocBlockEnd-->
