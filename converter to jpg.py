import os
from PIL import Image

pasta_atual = os.getcwd()
convertidos = 0

for arquivo in os.listdir(pasta_atual):
    # Verifica se é um arquivo BMP
    if arquivo.lower().endswith('.bmp'):
        
        # 1. TRATA O NOME: Remove o "FA" do início, se existir
        novo_nome_base = arquivo
        if arquivo.upper().startswith("FA"):
            novo_nome_base = arquivo[2:] # Remove os 2 primeiros caracteres
            
        # Altera a extensão para .jpg
        novo_nome_jpg = os.path.splitext(novo_nome_base)[0] + '.jpg'
        
        caminho_origem = os.path.join(pasta_atual, arquivo)
        caminho_destino = os.path.join(pasta_atual, novo_nome_jpg)
        
        try:
            # 2. CONVERTE PARA JPEG
            with Image.open(caminho_origem) as img:
                if img.mode in ("RGBA", "P"):
                    img = img.convert("RGB")
                
                img.save(caminho_destino, "JPEG", quality=90)
            
            print(f"Sucesso: {arquivo} -> {novo_nome_jpg}")
            convertidos += 1
            
            # 3. LIMPEZA (Opcional)
            # Descomente a linha abaixo se quiser apagar o BMP original automaticamente
            # os.remove(caminho_origem)
            
        except Exception as e:
            print(f"Erro ao processar {arquivo}: {e}")

print(f"\nProntinho! {convertidos} imagens foram renomeadas e convertidas.")