$files = Get-ChildItem -Path . -Filter *.html
$regex = '(?is)<i class="bi bi-balloon-fill text-primary"></i>\s*<span class="[^"]+">Bounce</span>\s*<span class="[^"]+">Elite</span>'
$replacement = '<i class="bi bi-balloon-fill text-primary"></i> <span class="text-primary">Bounce</span> <span class="text-main">Elite</span>'
$updated = 0

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -match $regex) {
        $newContent = $content -replace $regex, $replacement
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated $($file.Name)"
        $updated++
    }
}
Write-Host "Done. Updated $updated files."
