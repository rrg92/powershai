# Provider Hugging Face

O Hugging Face é o maior repositório de modelos de IA do mundo!  
Lá, você tem acesso a uma gama incrível de modelos, datasets, demonstrações com o Gradio, e muito mais!  

É o GitHub da Inteligência Artificial, comercial e open source!

O provider do Hugging Face do PowershAI conecta o seu powershell com uma gama incrível de serviços e modelos.  

## O Gradio

O Gradio é um framework para criar demonstrações para modelos de IA. Com pouco código em python, é possível subir interfaces que aceitam diveros inputs, como texto, arquivo, etc.  
E, além disso, ele gerencia muitas questões como filas, uploads, etc.  E, para completar, junto com a interface, ele pode disponibilizar uma API para que a funcionalidade exposta via UI também seja acessível através de linguagens de programação.  
O PowershAI se beneficia disso, e expoe as APIs do Gradio de uma forma mais fácil, onde é possível invocar uma funcionalidade do seu terminal e ter praticamente a mesma experiência!


## Hugging Face Hub  

O Hugging Face Hub é a plataforma que você acessa em https://huggingface.co  
Ele é organizado em modelos (models), que são basicamente o código fonte dos modelos de IA que outras pessoas e empresas criam ao redor do mundo.  
Há também os "Spaces", que são onde você pode subir um código para publciar aplicações escritas em python (usando o Gradio, por exemplo) ou docker.  

Conheça mais sobre o Hugging Face [neste post do blog Ia Talking](https://iatalk.ing/hugging-face/)
E, conheça o Hugging Face Hub [na doc oficial](https://huggingface.co/docs/hub/en/index)

Com o PowershaAI, você pode listar modelos e até interagir com a API de vários spaces, executando as mais variadas apps de IA a partir do seu terminal.  


# Uso básico

O provider do Hugging Face do PowershAI possui muitos cmdlets para interação.  
Ele está organizado nos seguintes comandos:

* comandos que interagem com o Hugging Face possem `HuggingFace` ou `Hf` no nome. Exemplo: `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* comandos que interagem com o Gradio, independente se são um Space do Hugging Face, ou não, possuem `Gradio` ou `GradioSession'  no nome: `Send-GradioApi`, `Update-GradioSessionApiResult`
* Você pode usar este comando para obter a lista completa: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Você não precisa se autenticar para acessar os recursos públicos do Hugging Face.  
Há uma infinidades de modelos  e spaces disponíveis gratuitamente sem a necessidade de autenticação.  
Por exemplo, o seguinte comando lista os top 5 modelos mais baixados da Meta (autor: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

O cmdlet Invoke-HuggingFaceHub é responsável por invocar endpoints da API do Hub.  Os parâmetros são os mesmos documentandos em https://huggingface.co/docs/hub/en/api
Porém, você vai precisar de um token caso necessite acessar recursos privados: `Set-HuggingFaceToken` (ou `Set-HfToken`)  é o cmdlet para inserir o token default usados em todas as requisições.  



# Esturtura de comandos do provider Hugging Face  

O provider do Hugging Face está organizado em 3 principais grupos de comandos: Gradio, Gradio Session e Hugging Face.  


## Comandos Gradio*`

Os cmdlets do grupo "gradio" possuem a estrutra Verbo-GradioNome.  Estes comandos implementam o acesso a API do Gradio.  
Estes comandos são baiscamente wrappers para as APIs. A construção deles foi baseada nesta doc: https://www.gradio.app/guides/querying-gradio-apps-with-curl  e também observando o código fonte do Gradio (ex.: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
Estes comandos podem ser usados com qualquer app gradio, independente de ondem estejam hospedadas: na sua máquina local, em um space do Hugging Face, em um server na cloud... 
Você precisa apenas da URL principal da aplicação.  


Considere essa app gradio:

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Basicamente, esta app exibe 2 campos de texto, sendo um deles onde o usuário digita um texto e o outro é usado para mostrar a saída.  
Um botão, que ao ser clicado, dispara a função Op1. A função faz um loop durante um detemrinaod numero de segundos infomaod no parametro.  
A cada segundo, ela devole o quanto se passou.  

Suponha que ao iniciar, esta app esteja acessível em http://127.0.0.1:7860.
Com este provider, conectar nessa app é simples:

```powershell
# instale o powershai, se não tiver instalado!
Install-Module powershai 

# Importe
import-module powershai 

# Verifique os endpoints da api!
Get-GradioInfo http://127.0.0.1:7860
```

O cmdlet `Get-GradioInfo` é o mais simples. Ele apenas lê o endpiunt /info que toda app gradio possui.  
Este endpoint retorna informacoes valiosas, como os endpoints da API disponíveis:

```powershell
# Verifique os endpoints da api!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# lista os parâmetros do endpoint
$AppInfo.named_endpoints.'/op1'.parameters
```

Você pode invocar a API usando o cmdlet `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Note que precisamos passar a URL, o nome do endpoint sem a barra e o array com lista de parâmetros.
O resultado dessa requisição é um evento que poderá ser usado para consultar o resultado da API.
Para obter os resultados, você deve usar `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

O cmdlet `Update-GradioApiResult` irá escrever os eventos gerados pela API no pipeline.  
Será devolvido um objeto para cada evento gerado pelo servidor. A propriedade `data` desse objeto tem os dados retornados, se houverem.  


Há ainda, o comando `Send-GradioFile`, que permite fazer uploads.  Ele devolve um array de objetos FileData, que representam o arquivo no servidor.  

Note como estes cmdlets são bem primitivos: Você deve manualmente fazer tudo. Obter os endpoitns, invocar a api, enviar os parâmetros como array, fazer o upload dos arquivos.  
Apesar destes comandos abstrairem as chamadas HTTP diretas do Gradio, eles aindam exigem muito do usuário.  
É por isso, que foi criado o grupo de comandos GradioSession, que ajudam a abstrair mais ainda e tornar a vida do usuário mais fácil!


## Comandos GradioSession*  

Os comandos do grupo GradioSession ajudam a abstrair mais ainda o acesso a uma app Gradio.  
Com eles, você mais próximo do powershell ao interagir com uma app gradio e mais longe das chamadas nativas.  

Vamos usar o proprio exemplo da app anterior para fazer alguns comparativos:

```powershell
# cria uma nova session 
New-GradioSession http://127.0.0.1:7860
```

O comdlet `New-GradioSession` cria uma nova sessão com o Gradio.  Esta nova sessão tem elemenots únicos como um SessionId, lsita de arquivos feitos upload, configuraões, etc.  
O comando retorna o objeto que representa esta session, e você pode obter todas as session criadas usando `Get-GradioSession`.  
Imagina que uma GradoSession como um aba do browser aberta com a sua app gradio aberta.  

Os comandos GradioSession operam, por padrão, na default session. Se existe apenas 1 session, ela é a default session.  
Se existe mais de uma, o usuário deve escolher qual é a default usando o comando `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

Um dos comandos mais poderosos é o `New-GradioSessionApiProxyFunction` (ou alias GradioApiFunction).  
Este comando transforma as APIs do Gradio da session em funções powershell, isto é, você pode invocar a API como se fosse uma função powershell.  
Vamos voltar ao exemplo anterior


```powershell
# primeiro, abrindo a sessao!
New-GradioSession http://127.0.0.1:7860

# Agora, vamos criar as funcoes!
New-GradioSessionApiProxyFunction
```

O código acima vai gerar uma funão powershell chamada Invoke-GradioApiOp1.  
Esta função tem os mesmos parâmetros que o endpoint '/op1', e você pode usar o get-help para mais informacoes:  

```powershell
get-help -full Invoke-GradioApiOp1
```

Para executar, é só invocar:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Note como o parâmetro `Duration` definido na app gradio virou um parâmetro powershell.  
Por debaixo dos panos, Invoke-GradioApiOp1 está executando o `Update-GradioApiResult`, isto é, o retorno é o mesmo objeto!
Mas, perceba o quanto foi mais simples invocar a API do Gradio e receber o resultado!

Apps que definem arquivos, como músicas, imagens, etc., geram funções que automaticamente fazem o upload desses arquivos.  
O usuário precida apenas especificar o caminho local.  

Eventualment,e pode existir algum ou outro tipo de dado não suportado na conversão, e, caso você encontre, abra uma issue (ou submeta um PR) para avaliarmos e implementarmos!



## Comandos HuggingFace* (ou Hf*)  

Os comandos deste grupo foram criados para operar com a API do Hugging Face.  
Basicamente, eles encapsulam as chamadas HTTP para os diversos endpoints do Hugging Face.  

Um exemplo:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

Este comando retorna um objeto que contém diversas informações sobre o space diffusers-labs, do usuário rrg92.  
Como é um space gradio, você pode conectá-lo com os demais cmdlets (os cmdlets GradioSession conseguem entender quando um objeto retornado por Get-HuggingFaceSpace é passado para eles!)

```
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

# cria uma nova gradiosession para a app gradio que existe neste space!
$diff | Connect-HuggingFaceSpaceGradio

#Default
Set-GradioSession -Default $diff

# Cria funcoes!
New-GradioSessionApiProxyFunction

# invoca!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**IMPORTANTE: Lembre-se que acesso a determindados spaces pode ser feito apenas com autenticação, nestes casos, você deve usar o Set-HuggingFaceToken e especificar um token de acesso.;**