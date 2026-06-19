$appendContent = @"

/* Dashboard Banner Text Visibility Fix */
.dash-banner h1, 
.dash-banner h2, 
.dash-banner h3, 
.dash-banner h4, 
.dash-banner h5, 
.dash-banner h6, 
.dash-banner p, 
.dash-banner span {
  color: #ffffff !important;
}
"@

Add-Content -Path "css\style.css" -Value $appendContent
Write-Host "Appended banner text color fix to style.css"
