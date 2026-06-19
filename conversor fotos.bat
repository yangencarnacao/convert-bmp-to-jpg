<# : arquivo lote do windows
@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression ([System.IO.File]::ReadAllText('%~f0'))"
goto :eof
#>

# --- CÓDIGO POWERSHELL ---
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Conversor Avançado de Imagens"
$form.Size = New-Object System.Drawing.Size(450, 420)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# 1. Campo da Pasta
$lblPasta = New-Object System.Windows.Forms.Label
$lblPasta.Text = "Caminho da pasta das imagens:"
$lblPasta.Location = New-Object System.Drawing.Point(20, 15)
$lblPasta.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($lblPasta)

$txtPasta = New-Object System.Windows.Forms.TextBox
$txtPasta.Text = "D:\Fotos PROEJA JPEG"
$txtPasta.Location = New-Object System.Drawing.Point(20, 35)
$txtPasta.Size = New-Object System.Drawing.Size(310, 20)
$form.Controls.Add($txtPasta)

$btnProcurar = New-Object System.Windows.Forms.Button
$btnProcurar.Text = "..."
$btnProcurar.Location = New-Object System.Drawing.Point(340, 33)
$btnProcurar.Size = New-Object System.Drawing.Size(70, 23)
$btnProcurar.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.SelectedPath = $txtPasta.Text
    if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $txtPasta.Text = $folderBrowser.SelectedPath
    }
})
$form.Controls.Add($btnProcurar)

# 2. Campo do Filtro Extensão
$lblFiltro = New-Object System.Windows.Forms.Label
$lblFiltro.Text = "Buscar arquivos do tipo (Filtro):"
$lblFiltro.Location = New-Object System.Drawing.Point(20, 75)
$lblFiltro.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($lblFiltro)

$txtFiltro = New-Object System.Windows.Forms.TextBox
$txtFiltro.Text = "*.bmp"
$txtFiltro.Location = New-Object System.Drawing.Point(20, 95)
$txtFiltro.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($txtFiltro)

# 3. Campo para tirar letras
$lblRemover = New-Object System.Windows.Forms.Label
$lblRemover.Text = "Letras para REMOVER do início (ex: FA):"
$lblRemover.Location = New-Object System.Drawing.Point(20, 140)
$lblRemover.Size = New-Object System.Drawing.Size(350, 20)
$form.Controls.Add($lblRemover)

$txtRemover = New-Object System.Windows.Forms.TextBox
$txtRemover.Text = "FA"  # Alterado para vir preenchido com 'FA' por padrão
$txtRemover.Location = New-Object System.Drawing.Point(20, 160)
$txtRemover.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($txtRemover)

# 4. Campo para colocar novas letras
$lblAdicionar = New-Object System.Windows.Forms.Label
$lblAdicionar.Text = "Texto para ADICIONAR no início (ex: M):"
$lblAdicionar.Location = New-Object System.Drawing.Point(20, 205)
$lblAdicionar.Size = New-Object System.Drawing.Size(350, 20)
$form.Controls.Add($lblAdicionar)

$txtAdicionar = New-Object System.Windows.Forms.TextBox
$txtAdicionar.Text = "M"   # Alterado para vir preenchido com 'M' por padrão
$txtAdicionar.Location = New-Object System.Drawing.Point(20, 225)
$txtAdicionar.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($txtAdicionar)

# Botão: Converter
$btnConverter = New-Object System.Windows.Forms.Button
$btnConverter.Text = "Iniciar Conversão e Renomeação"
$btnConverter.Location = New-Object System.Drawing.Point(20, 290)
$btnConverter.Size = New-Object System.Drawing.Size(390, 45)
$btnConverter.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnConverter.BackColor = [System.Drawing.Color]::LightGreen

$btnConverter.Add_Click({
    $pastaAlvo = $txtPasta.Text
    $filtroAlvo = $txtFiltro.Text
    $remover = $txtRemover.Text
    $adicionar = $txtAdicionar.Text

    if (-not (Test-Path -Path $pastaAlvo)) {
        [System.Windows.Forms.MessageBox]::Show("A pasta especificada não existe!", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    $arquivos = Get-ChildItem -Path $pastaAlvo -Filter $filtroAlvo

    if ($arquivos.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Nenhum arquivo '$filtroAlvo' encontrado nesta pasta.", "Aviso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }

    $sucessos = 0
    foreach ($arquivo in $arquivos) {
        $nomeBase = $arquivo.BaseName

        # Se o arquivo começar com a parte que você quer tirar, ele remove
        if ($remover -and $nomeBase.StartsWith($remover)) {
            $nomeBase = $nomeBase.Substring($remover.Length)
        }

        # Junta a nova letra com o que sobrou
        $novoNomeArquivo = $adicionar + $nomeBase + ".jpg"
        $novoCaminho = Join-Path $pastaAlvo $novoNomeArquivo

        try {
            $bmp = [System.Drawing.Image]::FromFile($arquivo.FullName)
            $bmp.Save($novoCaminho, [System.Drawing.Imaging.ImageFormat]::Jpeg)
            $bmp.Dispose()
            $sucessos++
        }
        catch {}
    }

    [System.Windows.Forms.MessageBox]::Show("Processo concluído!`n`n$sucessos de $($arquivos.Count) arquivos foram convertidos e renomeados.", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})
$form.Controls.Add($btnConverter)

$form.ShowDialog() | Out-Null