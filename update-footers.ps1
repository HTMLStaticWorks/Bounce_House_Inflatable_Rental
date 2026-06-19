$sourceFile = "index.html"
$htmlContent = Get-Content -Path $sourceFile -Raw

$regexSource = "(?is)<!-- Footer -->\s*<footer>.*?</footer>"
if ($htmlContent -match $regexSource) {
    $footerContent = $matches[0]
} else {
    Write-Host "Could not find footer in index.html"
    exit 1
}

$files = Get-ChildItem -Path . -Filter *.html
$updated = 0

foreach ($file in $files) {
    if ($file.Name -eq "index.html" -or $file.Name -eq "login.html" -or $file.Name -eq "signup.html") {
        continue
    }
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # Dashboard pages might not have a footer. Let's see if we can find a place to put it.
    if ($content -match "(?is)(?:<!-- Footer -->\s*)?<footer\b[^>]*>.*?</footer>") {
        # It has a footer
        $newContent = $content -replace "(?is)(?:<!-- Footer -->\s*)?<footer\b[^>]*>.*?</footer>", "`n`n    $footerContent`n"
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Replaced footer in $($file.Name)"
        $updated++
    } else {
        # It doesn't have a footer, we need to append it.
        # Find where to append: before "<!-- Back to Top -->" or before "<script src="
        if ($content -match "(?i)<!-- Back to Top -->") {
            $newContent = $content -replace "(?i)<!-- Back to Top -->", "`n`n    $footerContent`n`n    <!-- Back to Top -->"
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "Injected footer in $($file.Name) before Back to Top"
            $updated++
        } elseif ($content -match "(?i)<script src=") {
            # Find the FIRST <script src= that is near the bottom. Or just the last closing main/div tag?
            # A safe bet is right before the first script tag that comes after the body.
            # Actually, simpler: replace </body> with footer + </body>
            $newContent = $content -replace "(?i)</body>", "`n`n    $footerContent`n</body>"
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "Injected footer in $($file.Name) before body end"
            $updated++
        } else {
            Write-Host "Could not figure out where to put footer in $($file.Name)"
        }
    }
}
Write-Host "Done. Updated $updated files."
