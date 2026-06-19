$files = Get-ChildItem -Path . -Filter *.html
$updated = 0
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    $modified = $false
    if ($content -match '<nav class="d-none d-lg-flex align-items-center">') {
        $content = $content -replace '<nav class="d-none d-lg-flex align-items-center">', '<nav class="d-none d-xl-flex align-items-center">'
        $modified = $true
    }
    
    if ($content -match '<button class="btn btn-outline-primary d-lg-none"') {
        $content = $content -replace '<button class="btn btn-outline-primary d-lg-none"', '<button class="btn btn-outline-primary d-xl-none"'
        $modified = $true
    }
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
        $updated++
    }
}
Write-Host "Done. Updated $updated HTML files."
