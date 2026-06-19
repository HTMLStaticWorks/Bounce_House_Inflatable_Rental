$dashboardFiles = @(
    "upcoming-events.html",
    "saved-rentals.html",
    "profile-settings.html",
    "payments.html",
    "notifications.html",
    "dashboard.html",
    "bookings.html",
    "availability-calendar.html"
)

foreach ($file in $dashboardFiles) {
    if (Test-Path $file) {
        $content = Get-Content -Path $file -Raw
        
        # Regex to match the footer block injected earlier
        $regex = "(?is)<!-- Footer -->\s*<footer>.*?</footer>"
        
        if ($content -match $regex) {
            $content = $content -replace $regex, ""
            Set-Content -Path $file -Value $content
            Write-Host "Removed footer from $file"
        } else {
            Write-Host "No footer found in $file"
        }
    }
}
Write-Host "Done."
