```markdown
# Kit de Conversão e Renomeação de Imagens

Este repositório contém um conjunto de ferramentas automatizadas para converter formatos de imagem (focado em `.bmp` para `.jpg`) e padronizar a nomenclatura de arquivos em lote, removendo prefixos antigos (como `FA`) e adicionando novos (como `M`).

![Demonstração do Conversor](preview.png) *(Opcional: adicione uma captura de tela com este nome na raiz do projeto para exibição no GitHub)*

Escolha a ferramenta que melhor se adapta ao seu fluxo de trabalho:
1. **Interface Gráfica (GUI) - Híbrido Batch/PowerShell** (Mais fácil e visual)
2. **Script Python** (Ideal para automações e multiplataforma)
3. **Comandos PowerShell** (Direto no terminal, focado em renomeação rápida)

---

## 🛠️ Opção 1: Conversor Avançado com Interface Gráfica (GUI)

Um script híbrido utilizando a técnica *polyglot*. O arquivo é interpretado pelo Prompt de Comando do Windows (`cmd.exe`) como um arquivo de lote (`.bat`), que invoca o PowerShell em segundo plano. Isso permite que você execute a interface com um **duplo clique**, sem alterar políticas de execução globais do sistema.

### 📋 Pré-requisitos
* Sistema Operacional Windows 7, 8, 10 ou 11.
* PowerShell 5.1 ou superior (nativo do Windows).
* Utiliza as bibliotecas `.NET` nativas (`System.Windows.Forms` e `System.Drawing`), dispensando instalações adicionais.

### 💻 Como Usar
1. Salve o código da ferramenta com a extensão `.bat` ou `.cmd` (ex: `conversor_gui.bat`).
2. Dê um **duplo clique** sobre o arquivo criado.
3. Na janela que se abrir:
   * **Caminho da pasta:** Selecione o diretório onde estão as imagens.
   * **Filtro:** Defina a extensão atual (ex: `*.bmp`).
   * **Remover:** Informe o prefixo que deseja tirar do início (ex: `FA`).
   * **Adicionar:** Informe o novo texto para o início (ex: `M`).
4. Clique em **"Iniciar Conversão e Renomeação"**.

---

## 🐍 Opção 2: Script em Python

Ideal se você já possui o ambiente Python configurado ou precisa integrar o processo em pipelines e automações multiplataforma.

### 📋 Pré-requisitos
Instale a biblioteca Pillow para o processamento de imagens:
```bash
pip install Pillow

```

### 💻 Como Usar

1. Salve o script como `conversor.py` dentro da mesma pasta onde estão as imagens.
2. Execute o comando no terminal:

```bash
python conversor.py

```

*O script buscará os arquivos `.bmp`, removerá o prefixo `FA` do início (caso exista), aplicará a conversão para `.jpg` com 90% de qualidade e manterá os arquivos originais seguros.*

---

## 💻 Opção 3: Comandos Rápidos em PowerShell

Se você precisa apenas renomear os arquivos em lote rapidamente diretamente pelo terminal, sem alterar o formato original ou a extensão deles.

### Adicionar o prefixo 'M' no início de todos os arquivos:

```powershell
Get-ChildItem -File | Where-Object { $_.Name -notlike "M*" } | Rename-Item -NewName { "M" + $_.Name }

```

### Remover o prefixo 'FA' do início de todos os arquivos:

```powershell
Get-ChildItem -Filter "FA*" | Rename-Item -NewName { $_.Name -replace '^FA', '' }

```

---

## 📝 Exemplo Prático do Resultado

Independentemente do método escolhido, as ferramentas foram desenhadas para seguir a seguinte lógica de transformação:

| Estado do Arquivo | Nome do Arquivo | Extensão / Formato |
| --- | --- | --- |
| **Antes (Original)** | `FA_foto01` | `.bmp` |
| **Ações Aplicadas** | Remover `FA` do início e Adicionar `M` | Converter para JPEG |
| **Depois (Resultado)** | `M_foto01` | `.jpg` |

---

## ⚖️ Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](https://www.google.com/search?q=LICENSE) para obter mais detalhes.
