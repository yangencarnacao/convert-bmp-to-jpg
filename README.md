The script is executed in PowerShell to insert 'M' at the beginning of filenames:
O script é executado no PowerShell para inserir 'M' no início dos nomes de arquivos:
Get-ChildItem -File | Where-Object { $_.Name -notlike "M*" } | Rename-Item -NewName { "M" + $_.Name }

Remove 'FA' from the beginning of filenames:
Remover 'FA' do início dos nomes de arquivos:
Get-ChildItem -Filter "FA*" | Rename-Item -NewName { $_.Name -replace '^FA', '' }


# Conversor Avançado de Imagens (GUI)

Este é um script híbrido (**Batch + PowerShell**) que fornece uma interface gráfica simples (GUI) para processar, renomear e converter em lote imagens de um formato específico (como `.bmp`) para `.jpg`.

O utilitário foi projetado para automatizar tarefas repetitivas de organização de fotos, permitindo recortar prefixos antigos e adicionar novos padrões de nomenclatura simultaneamente.

---

## 🚀 Funcionalidades

* **Interface Gráfica Intuitiva:** Sem necessidade de usar linhas de comando para configurar os parâmetros.
* **Seleção de Diretório:** Permite navegar e escolher a pasta de imagens facilmente.
* **Filtro por Extensão:** Processa apenas os arquivos que correspondem ao filtro definido (ex: `*.bmp`, `*.png`).
* **Renomeação Dinâmica:** * Remove prefixos indesejados do início do nome do arquivo (ex: remover "FA").
  * Adiciona novos prefixos customizados (ex: adicionar "M").
* **Conversão Automática:** Converte as imagens nativamente para o formato `.jpg`.

---

## 🛠️ Como Funciona o Script Híbrido

O arquivo utiliza uma técnica chamada *polyglot script*. O início do código é interpretado pelo Prompt de Comando do Windows (`cmd.exe`) como um arquivo de lote (`.bat` ou `.cmd`), que invoca o PowerShell em segundo plano passando o próprio arquivo como argumento. Isso permite que você execute o script com um **duplo clique**, sem precisar abrir o PowerShell manualmente ou alterar políticas de execução globais.

---

## 📋 Pré-requisitos

* **Sistema Operacional:** Windows 7 / 8 / 10 / 11
* **PowerShell 5.1 ou superior** (nativo no Windows 10/11)
* O script utiliza a biblioteca `.NET` nativa (`System.Windows.Forms` e `System.Drawing`), dispensando instalações externas.

---

## 💻 Como Usar

1. Baixe o código do script e salve-o com a extensão `.bat` ou `.cmd` (por exemplo: `conversor.bat`).
2. Dê um **duplo clique** sobre o arquivo criado.
3. Na janela que se abrir:
   * Escolha a pasta onde estão suas fotos originais.
   * Defina o filtro da extensão atual (ex: `*.bmp`).
   * Informe o prefixo que deseja remover (se houver).
   * Informe o novo texto que deseja adicionar no início do arquivo.
4. Clique em **"Iniciar Conversão e Renomeação"**.
5. Uma mensagem confirmará quantos arquivos foram processados com sucesso.

---

## 📝 Exemplo Prático

Se você configurou a ferramenta para:
* **Filtro:** `*.bmp`
* **Letras para remover:** `FA`
* **Texto para adicionar:** `M`

Um arquivo original chamado `FA_foto01.bmp` será transformado em **`M_foto01.jpg`**.

---

## ⚖️ Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter mais detalhes.
