```json
{
  "openapi": "3.0.0",
  "info": {
    "title": "Hugging Face Inference API",
    "version": "1.0.0",
    "description": "Invoke the Hugging Face Inference API https://huggingface.co/docs/hub/en/api"
  },
  "paths": {
    "/inference": {
      "post": {
        "summary": "Invoke inference",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "properties": {
                  "model": {
                    "type": "string",
                    "description": "Model name"
                  },
                  "params": {
                    "type": "object",
                    "description": "Inference parameters"
                  },
                  "public": {
                    "type": "boolean",
                    "description": "Use public model"
                  },
                  "openaiChatCompletion": {
                    "type": "boolean",
                    "description": "Force use of chat completion endpoint. Params should be treated as the same params from the OpenAI API (See the Get-OpenaiChat cmdlet). More info: https://huggingface.co/blog/tgi-messages-api. Only works with models that have a chat template!"
                  },
                  "streamCallback": {
                    "type": "object",
                    "description": "Stream callback for streams"
                  }
                },
                "required": [
                  "model"
                ]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful inference",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "description": "Inference result"
                }
              }
            }
          },
          "400": {
            "description": "Invalid request"
          },
          "500": {
            "description": "Internal server error"
          }
        }
      }
    }
  }
}
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
