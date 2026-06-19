$appendContent = @"

/* Pricing Featured Card - Mobile Fix */
@media (max-width: 991px) {
  .glass-card[style*='scale(1.05)'] {
    transform: scale(1) !important;
  }
}
"@

Add-Content -Path "css\style.css" -Value $appendContent
Write-Host "Appended CSS fix"
