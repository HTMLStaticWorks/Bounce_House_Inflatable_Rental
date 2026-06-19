$files = Get-ChildItem -Path . -Filter *.html
$faviconTag = '    <link rel="icon" type="image/svg+xml" href="favicon.svg">'
$updated = 0

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if favicon already exists
    if ($content -notmatch 'href="favicon\.svg"') {
        $newContent = $content -replace "(?i)</head>", "`n$faviconTag`n</head>"
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated $($file.Name)"
        $updated++
    }
}
Write-Host "Done. Updated $updated files."
