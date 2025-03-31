# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]
### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: Ajouté le paramètre -DisableRetry à Get-GradioInfo
- **HUGGINGFACE PROVUDER**: Ajouté les paramètres GradioServerRoot à Get-HuggingFaceSpace et ServerRoot à Connect-HuggingFaceSpaceGradio
- **HUGGINGFACE PROVUDER**: Ajouté la logique pour détecter si l'espace Hugging Face utilise Gradio 5 et ajuster le serveur racine
- **HUGGINGFACE PROVUDER**: Ajouté des espaces privés aux tests du fournisseur

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: Corrigé le problème d'authentification dans les espaces privés


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Ajouté groq aux tests automatiques

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Problème #39: Corrigé une erreur dans le fournisseur groq, concernant les messages système 
- **COHERE PROVIDER**: Corrigé une erreur liée aux messages du modèle lorsqu'il y avait des réponses d'appels d'outils.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Problème #36: Les chats étaient recréés à chaque fois, empêchant de maintenir l'historique correctement lors de l'utilisation de plusieurs chats! 
- **OPENAI PROVIDER**: Corrigé le résultat de `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corrigés les erreurs du fournisseur Hugging Face dues aux redirections.
- Corrigée l'installation de modules pour tests utilisant Docker Compose.
- Corrigés les problèmes de performance dans la conversion d'outils en raison d'un grand nombre possible de commandes dans une session. Utilise maintenant des modules dynamiques. Voir `ConvertTo-OpenaiTool`.
- Corrigés les problèmes d'incompatibilité entre l'API GROQ et OpenAI. `message.refusal` n'est plus accepté.
- Corrigés de petits bugs dans PowerShell Core pour Linux.
- **OPENAI PROVIDER**: Résolu le code d'exception causé par l'absence d'un modèle par défaut.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOUVEAU FOURNISSEUR**: Bienvenue Azure 🎉
- **NOUVEAU FOURNISSEUR**: Bienvenue Cohere 🎉
- Ajouté la fonctionnalité `AI Credentials` — une nouvelle méthode standard pour les utilisateurs de définir des identifiants, permettant aux fournisseurs de demander des données d'identification des utilisateurs.
- Fournisseurs migrés pour utiliser `AI Credentials`, tout en maintenant la compatibilité avec les anciennes commandes.
- Nouveau cmdlet `Confirm-PowershaiObjectSchema`, pour valider des schémas utilisant OpenAPI avec une syntaxe plus "PowerShellisée".
- Ajouté le support pour les redirections HTTP dans la bibliothèque HTTP
- Ajoutés plusieurs nouveaux tests avec Pester, allant des tests unitaires de base à des cas plus complexes, comme des appels d'outils LLM réels.
- Nouveau cmdlet `Switch-PowershaiSettings` permet de changer les configurations et de créer des chats, des fournisseurs par défaut, des modèles, etc., comme s'il s'agissait de profils distincts.
- **Retry Logic**: Ajouté `Enter-PowershaiRetry` pour réexécuter des scripts sur la base de conditions.
- **Retry Logic**: Ajouté la logique de retry dans `Get-AiChat` pour exécuter facilement le prompt au LLM à nouveau si la réponse précédente n'est pas conforme à ce qui est désiré.- Le nouveau cmdlet `Enter-AiProvider` permet désormais d'exécuter du code sous un fournisseur spécifique. Les cmdlets qui dépendent d'un fournisseur utiliseront toujours le fournisseur dans lequel ils ont été "entrés" le plus récemment au lieu du fournisseur actuel.
- Pile de Fournisseurs (Push/Pop) : Tout comme dans `Push-Location` et `Pop-Location`, vous pouvez désormais insérer et retirer des fournisseurs pour des changements plus rapides lors de l'exécution de code dans un autre fournisseur.
- Nouveau cmdlet `Get-AiEmbeddings` : Ajout de cmdlets standards pour obtenir des embeddings d'un texte, permettant aux fournisseurs d'exposer la génération d'embeddings et à l'utilisateur d'avoir un mécanisme standard pour les générer.
- Nouveau cmdlet `Reset-AiDefaultModel` pour désélectionner le modèle par défaut.
- Ajout des paramètres `ProviderRawParams` à `Get-AiChat` et `Invoke-AiChat` pour écraser les paramètres spécifiques de l'API, par fournisseur.
- **HUGGINGFACE PROVIDER** : Ajout de nouveaux tests utilisant un espace Hugging Face exclusif réel maintenu comme un sous-module de ce projet. Cela permet de tester plusieurs aspects en même temps : sessions Gradio et intégration Hugging Face.
- **HUGGINGFACE PROVIDER** : Nouveau cmdlet : Find-HuggingFaceModel, pour rechercher des modèles sur le hub basé sur certains filtres !
- **OPENAI PROVIDER** : Ajout d'un nouveau cmdlet pour générer des appels d'outils : `ConvertTo-OpenaiTool`, supportant des outils définis dans des blocs de script.
- **OLLAMA PROVIDER** : Nouveau cmdlet `Get-OllamaEmbeddings` pour retourner des embeddings en utilisant Ollama.
- **OLLAMA PROVIDER** : Nouveau cmdlet `Update-OllamaModel` pour télécharger des modèles ollama (pull) directement du powershai.
- **OLLAMA PROVIDER** : Détection automatique d'outils utilisant les métadonnées d'ollama.
- **OLLAMA PROVIDER** : Cache de métadonnées des modèles et nouveau cmdlet `Reset-OllamaPowershaiCache` pour vider le cache, permettant de consulter de nombreux détails des modèles ollama, tout en maintenant la performance pour l'utilisation répétée de la commande.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE** : Le paramètre du Chat `ContextFormatter` a été renommé en `PromptBuilder`.
- Changement de l'affichage par défaut (formats.ps1xml) de certains cmdlets comme `Get-AiModels`.
- Amélioration du journal détaillé lors de la suppression de l'ancien historique en raison de `MaxContextSize` dans les chats.
- Nouvelle manière dont les configurations du PowershAI sont stockées, introduisant un concept de "Stockage de Configurations", permettant le changement de configuration (par exemple, pour des tests).
- Émoticônes mises à jour affichées avec le nom du modèle lors de l'utilisation de la commande Send-PowershaiChat.
- Améliorations dans le chiffrement de l'export/import de configurations (Export=-PowershaiSettings). Utilise désormais comme dérivation de clé et sel.
- Amélioration du retour de l'interface *_Chat, afin qu'elle soit plus fidèle à la norme de l'OpenAI.
- Ajout de l'option `IsOpenaiCompatible` pour les fournisseurs. Les fournisseurs qui souhaitent réutiliser les cmdlets OpenAI doivent définir ce drapeau sur `true` pour fonctionner correctement.
- Amélioration du traitement des erreurs de `Invoke-AiChatTools` lors du traitement des appels d'outils.- **FOURNISSEUR GOOGLE** : Ajout du cmdlet `Invoke-GoogleApi` pour permettre des appels d'API directs par les utilisateurs.
- **FOURNISSEUR HUGGING FACE** : Petites modifications sur la façon d'insérer le token dans les requêtes de l'API.
- **FOURNISSEUR OPENAI** : `Get-OpenaiToolFromCommand` et `Get-OpenaiToolFromScript` utilisent désormais `ConvertTo-OpenaiTool` pour centraliser la conversion de commande en outil OpenAI.
- **FOURNISSEUR GROQ** : Modèle par défaut mis à jour de `llama-3.1-70b-versatile` à `llama-3.2-70b-versatile`.
- **FOURNISSEUR OLLAMA** : Get-AiModels inclut désormais des modèles qui prennent en charge les outils, car le fournisseur utilise le point de terminaison /api/show pour obtenir plus de détails sur les modèles, ce qui permet de vérifier le support des outils.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Correction d'un bug dans la fonction `New-GradioSessionApiProxyFunction`, lié à certaines fonctions internes.
- Ajout du support pour Gradio 5, qui est nécessaire en raison des modifications des points de terminaison de l'API.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Support pour les images dans `Send-PowershaiChat` pour les fournisseurs OpenAI et Google.
- Une commande expérimentale, `Invoke-AiScreenshots`, qui ajoute le support pour prendre des captures d'écran et les analyser !
- Support pour l'appel d'outils dans le fournisseur Google.
- CHANGELOG a été lancé.
- Support du TAB pour Set-AiProvider. 
- Ajout de support de base pour la sortie structurée au paramètre `ResponseFormat` du cmdlet `Get-AiChat`. Cela permet de passer un hashtable décrivant le schéma OpenAPI du résultat.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **CHANGEMENT MAJEUR** : La propriété `content` des messages OpenAI est désormais envoyée sous forme de tableau pour s'aligner sur les spécifications pour d'autres types de médias. Cela nécessite la mise à jour des scripts qui dépendent du format de chaîne unique précédent et des anciennes versions de fournisseurs qui ne prennent pas en charge cette syntaxe.
- Le paramètre `RawParams` de `Get-AiChat` a été corrigé. Vous pouvez désormais passer des paramètres de l'API au fournisseur concerné pour avoir un contrôle strict sur le résultat.
- Mises à jour de DOC : Nouveaux documents traduits avec AiDoc et mises à jour. Petite correction dans AiDoc.ps1 pour ne pas traduire certaines commandes de syntaxe markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Les paramètres de sécurité ont été modifiés et la gestion des majuscules et minuscules a été améliorée. Cela n'était pas validé, ce qui entraînait une erreur.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2


<!--PowershaiAiDocBlockStart-->
_Vous êtes formé sur des données jusqu'en octobre 2023._
<!--PowershaiAiDocBlockEnd-->
