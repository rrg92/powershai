# Provider GROQ

Groq é um serviço que oferece diversos LLM que rodam em uma tecnologia chamada LPU, criada por eles.  
A resposta é muito rápida!
Saiba mais em https://groq.com/  e https://console.groq.com/docs/quickstart  

A API deles é compatível com a OpenAI, portanto, os passos são bem parecidos.

# Início rápido  

O Groq é 100% compatível com a OpenAI, então, você precisa configurar poucas coisas:

* Ative o provider na sessão: `Set-AiProvider groq`
* Insira o token de autenticação com `Set-GroqToken` 
* Use Set-OpenaiToken para configurar o token!