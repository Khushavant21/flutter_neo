Get-ChildItem -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $newContent = $content -replace '\.withOpacity\(([^)]+)\)', '.withValues(alpha: $1)'
    Set-Content $_.FullName $newContent
}
