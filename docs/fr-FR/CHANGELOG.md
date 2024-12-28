# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction des erreurs du fournisseur Hugging Face dues aux redirections.
- Correction de l'installation des modules pour les tests à l'aide de Docker Compose.
- Correction des problèmes de performances lors de la conversion des outils en raison d'un nombre potentiellement élevé de commandes dans une session. Utilise désormais des modules dynamiques. Voir `ConvertTo-OpenaiTool`.
- Correction des problèmes d'incompatibilité entre l'API GROQ et OpenAI. `message.refusal` n'est plus accepté.
- Correction de petits bogues dans PowerShell Core pour Linux.
- **FOURNISSEUR OPENAI**: Code d'exception résolu causé par l'absence d'un modèle par défaut.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOUVEAU FOURNISSEUR**: Bienvenue Azure 🎉
- **NOUVEAU FOURNISSEUR**: Bienvenue Cohere 🎉
- Ajout de la fonctionnalité `AI Credentials` - une nouvelle manière standard pour les utilisateurs de définir les informations d'identification, permettant aux fournisseurs de demander des données d'identification aux utilisateurs.
- Fournisseurs migrés pour utiliser `AI Credentials`, en maintenant la compatibilité avec les commandes plus anciennes.
- Nouveau cmdlet `Confirm-PowershaiObjectSchema`, pour valider les schémas à l'aide d'OpenAPI avec une syntaxe plus "PowerShellisée".
- Ajout de la prise en charge des redirections HTTP dans la bibliothèque HTTP
- Ajout de plusieurs nouveaux tests avec Pester, allant de tests unitaires de base à des cas plus complexes, tels que les appels d'outils LLM réels.
- Nouveau cmdlet `Switch-PowershaiSettings` permettant de basculer les paramètres et de créer des chats, des fournisseurs par défaut, des modèles, etc., comme s'il s'agissait de profils distincts.
- **Logique de nouvelle tentative**: Ajout de `Enter-PowershaiRetry` pour relancer les scripts en fonction de conditions.
- **Logique de nouvelle tentative**: Ajout d'une logique de nouvelle tentative dans `Get-AiChat` pour relancer facilement l'invite auprès du LLM si la réponse précédente ne correspond pas à ce qui est souhaité.
- Le nouveau cmdlet `Enter-AiProvider` permet désormais d'exécuter du code sous un fournisseur spécifique. Les cmdlets qui dépendent d'un fournisseur utiliseront toujours le fournisseur auquel il a été "entré" le plus récemment au lieu du fournisseur actuel.
- Pile de fournisseurs (Push/Pop) : Comme avec `Push-Location` et `Pop-Location`, vous pouvez désormais pousser et retirer des fournisseurs pour des changements plus rapides lors de l'exécution de code sur un autre fournisseur.
- Nouveau cmdlet `Get-AiEmbeddings` : Ajout de cmdlets standard pour obtenir des embeddings d'un texte, permettant aux fournisseurs d'exposer la génération d'embeddings et aux utilisateurs d'avoir un mécanisme standard pour les générer.
- Nouveau cmdlet `Reset-AiDefaultModel` pour désélectionner le modèle par défaut.
- Ajout des paramètres `ProviderRawParams` à `Get-AiChat` et `Invoke-AiChat` pour écraser les paramètres spécifiques de l'API, par fournisseur.
- **FOURNISSEUR HUGGINGFACE**: Ajout de nouveaux tests utilisant un espace Hugging Face réel et unique maintenu comme sous-module de ce projet. Cela permet de tester plusieurs aspects simultanément : sessions Gradio et intégration Hugging Face.
- **FOURNISSEUR OPENAI**: Ajout d'un nouveau cmdlet pour générer des appels d'outils : `ConvertTo-OpenaiTool`, prenant en charge les outils définis dans des blocs de script.
- **FOURNISSEUR OLLAMA**: Nouveau cmdlet `Get-OllamaEmbeddings` pour renvoyer des embeddings à l'aide d'Ollama.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **MODIFICATION IMPORTANTE**: Le paramètre du chat `ContextFormatter` a été renommé `PromptBuilder`.
- Modification de l'affichage par défaut (formats.ps1xml) de certains cmdlets tels que `Get-AiModels`.
- Amélioration du journal détaillé lors de la suppression de l'historique ancien en raison de `MaxContextSize` dans les chats.
- Nouvelle façon de stocker les paramètres PowershAI, introduisant un concept de "Stockage des paramètres", permettant le changement de paramètres (par exemple, pour les tests).
- Mises à jour des émojis affichés avec le nom du modèle lors de l'utilisation de la commande Send-PowershaiChat
- Améliorations du chiffrement de l'exportation/importation des paramètres (Export=-PowershaiSettings). Utilise désormais le hachage de clé et de sel.
- Amélioration du retour de l'interface *_Chat, pour qu'il soit plus fidèle à la norme OpenAI.
- Ajout de l'option `IsOpenaiCompatible` pour les fournisseurs. Les fournisseurs qui souhaitent réutiliser les cmdlets OpenAI doivent définir ce drapeau sur `true` pour fonctionner correctement.
- Amélioration de la gestion des erreurs de `Invoke-AiChatTools` lors du traitement des appels d'outils.
- **FOURNISSEUR GOOGLE**: Ajout du cmdlet `Invoke-GoogleApi` pour permettre aux utilisateurs d'effectuer des appels d'API directs.
- **FOURNISSEUR HUGGING FACE**: Petits ajustements de la manière d'insérer le jeton dans les requêtes de l'API.
- **FOURNISSEUR OPENAI**: `Get-OpenaiToolFromCommand` et `Get-OpenaiToolFromScript` utilisent désormais `ConvertTo-OpenaiTool` pour centraliser la conversion de la commande en outil OpenAI.
- **FOURNISSEUR GROQ**: Mise à jour du modèle par défaut de `llama-3.1-70b-versatile` à `llama-3.2-70b-versatile`.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction d'un bogue dans la fonction `New-GradioSessionApiProxyFunction`, lié à certaines fonctions internes.
- Ajout de la prise en charge de Gradio 5, nécessaire en raison de modifications des points de terminaison de l'API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Prise en charge des images dans `Send-PowershaiChat` pour les fournisseurs OpenAI et Google.
- Une commande expérimentale, `Invoke-AiScreenshots`, qui ajoute la prise en charge de la capture d'écran et de son analyse !
- Prise en charge des appels d'outils dans le fournisseur Google.
- Le CHANGELOG a été démarré.
- Prise en charge de la touche TAB pour Set-AiProvider.
- Ajout de la prise en charge de base de la sortie structurée au paramètre `ResponseFormat` du cmdlet `Get-AiChat`. Cela permet de passer une table de hachage décrivant le schéma OpenAPI du résultat.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **MODIFICATION IMPORTANTE**: La propriété `content` des messages OpenAI est désormais envoyée sous forme de tableau pour s'aligner sur les spécifications pour les autres types de médias. Cela nécessite la mise à jour des scripts qui dépendent de l'ancien format de chaîne unique et des anciennes versions des fournisseurs qui ne prennent pas en charge cette syntaxe.
- Le paramètre `RawParams` de `Get-AiChat` a été corrigé. Vous pouvez désormais transmettre des paramètres de l'API au fournisseur en question pour avoir un contrôle strict sur le résultat
- Mises à jour de la DOC : Nouveaux documents traduits avec AiDoc et mises à jour. Petite correction dans AiDoc.ps1 pour ne pas traduire certaines commandes de syntaxe markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction du problème n° 13. Les paramètres de sécurité ont été modifiés et la gestion de la casse a été améliorée. Cela n'était pas validé, ce qui entraînait une erreur.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et de l'IA
_
<!--PowershaiAiDocBlockEnd-->
