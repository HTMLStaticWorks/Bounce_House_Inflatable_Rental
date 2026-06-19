$files = Get-ChildItem -Path . -Filter *.html
$regex = 'href="login\.html"\s+class="sidebar-link[^"]*"\s*><i class="bi bi-box-arrow-left"></i> Logout'
$replacement = 'href="index.html" class="sidebar-link mt-4 text-danger"><i class="bi bi-box-arrow-left"></i> Logout'
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
