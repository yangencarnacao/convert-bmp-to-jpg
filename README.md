The script is executed in PowerShell to insert 'M' at the beginning of filenames:
O script é executado no PowerShell para inserir 'M' no início dos nomes de arquivos:
Get-ChildItem -File | Where-Object { $_.Name -notlike "M*" } | Rename-Item -NewName { "M" + $_.Name }

Remove 'FA' from the beginning of filenames:
Remover 'FA' do início dos nomes de arquivos:
Get-ChildItem -Filter "FA*" | Rename-Item -NewName { $_.Name -replace '^FA', '' }
