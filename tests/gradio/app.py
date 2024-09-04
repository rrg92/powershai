import gradio as gr
import time


def Op1(Duracao, StartSleep):
    print("Sleeping..." + str(StartSleep) );
    
    yield f"Dur:{Duracao}, Sleeping:{StartSleep}"
    
    time.sleep(StartSleep);
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duracao) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished: {Duracao}"
    
    
def Filop(files):
    return files;

with gr.Blocks() as demo:
    Duracao = gr.Text(label="Duracao do sleep", value=5);
    Start = gr.Number(label="StartSleep", value=5);
    txt2 = gr.Text(label="Resultado");

    files = gr.File(file_count="multiple")
    files2 = gr.File(file_count="multiple")

    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [Duracao,Start], [txt2] );
    
    btnOp2 = gr.Button(value="Op2");
    filed = gr.File(file_count="multiple")
    btnOp2.click( Filop, [files], [filed] );


if __name__ == "__main__":
    demo.launch(show_api=True)