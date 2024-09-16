# Utilidades

[english](README.en.md)

Este diretório contém scrips úteis, para ajudar no processo de desenvolvimento e documentação do PowershAI.  

# Dicas

## Como gerar a doc a partir do código (coentários)?  

Use o script Cmdlets2Markdown.ps1:  

```powershell
. .\util\Cmdlets2Markdown.ps1 -Update
```

Isso vai atualizar todos os arquivos no diretório docs/pt-BR/cmdlets  
A documentação direta no código está em pt-BR, pois é mais rápido para mim documentar no meu idioma nativo.  
Mas isso pode mudar no futuro.  Por enquanto, usamos a pt-BR como fonte para a documentação em markdonw e outras linguagens.  

## Como traduzi os arquivos em docs/ para outros idiomas?

O script aidoc.ps1 pode ajudar a gerar uma tradução automática.  
Ele usa o próprio powershai para enviar os dados ao provider desejado e atualizar os arquivos.  
Ele mantém controles para evitar enviar arquivos que não foram alterados, ou tentar sobrescrever arquivos que já foram alterados por alguém.  

Como usar:

- Crie o diretório do idioma desejado em docs/, se ele não existe. ISso diz ao script que esse idioma é suportado. Usar o código BCP 47 (formato aa-BB)
- Escolha um provider e modelo que suportam grandes quantidade de contexto. Particulamente, eu tenho feito com o Google Gemini Flash 1.5, que tem um contexto muito de 1M, custo baixo e um resultado muito bom.

Tendo feito esses pré-requisitos, rode o script, exemplos:

```
# Example 
.\util\aidoc.ps1 -SourceLang pt-BR -TargetLang en-US -Provider google -MaxTokens 32000
```

Note que estou uando pt-BR como origem.  
Eu sempre uso pt-BR como origem, pois é a linguagem em que confio o contéudo no momento.  

### Importante sobre a tradução da documentação com IA

Note que esse processo tende a ser automático, você talvez não precise se preocupar (mas, caso queria aprender e estudar um uso prático do powershai, é um bom teste).  
Apenas lembre-se que usar o provider pode incorrer custos.  
Os custos das traduções que feitas até aqui, foram pagos pelo autor do projeto, Rodrigo, usando seus próprios tokens.  
Tenha em mente que, ao fazer testes, você usará seus próprios tokens, e por isso, terá o seu próprio custo (e não há garantia que essas modificações serão aprovadas).  



## Como gerar a doc compilada do Powershell a partir de docs/  

O script doc.ps1 foi criado para converter a doc em docs/ para um help compialdo do powershell que pode ser distribuído junto com módulo.  
Este éum process que estou testando ainda, e, por isso, não há nada sendo publicado.  

O script doc.ps1 faz diversas validações e ajustes para adaptar os arquivos em docs/ para o formato esperado pelo PlatyPS.  
PlatyPs é um módulo que ajuda a gerar a documentação no formao MAML do powershell, compilada no .xml  

```
.\util\doc.ps1 -WorkDir T:\platy -SupportedLangs ja-JP  -MaxAboutWidth 150
```

`workDir` é um diretorio temporário onde ele irá copiar e modificar os arquivos, além de usar como stage do processo.  
`SupportedLangs` é uma lista de idiomas que quer gerar.  
`MaxAboutWidth` controla o tamanho máximo de uma linha. O PlatyPS pode gerar um erro devido a um bug do módulo,e  aumentar o MaxAboutWidth pode evitar esse erro.  


