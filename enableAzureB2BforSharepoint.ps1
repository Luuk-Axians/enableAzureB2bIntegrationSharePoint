# Install SharePoint Online Management Shell
if (-not (Get-InstalledModule -Name "Microsoft.Online.SharePoint.PowerShell" -ErrorAction SilentlyContinue)) {
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Force
}

# Import SharePoint Online Management Shell module
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

# Connect to SharePoint
$adminUrl = "https://YourTenantName-admin.sharepoint.com" # Replace "YourTenantName" with your tenant name
$credential = Get-Credential
Connect-SPOService -Url $adminUrl -Credential $credential

# Enable Azure B2B Integration
Set-SPOTenant -EnableAzureADB2BIntegration $true

Write-Host "Azure B2B Integration for SharePoint enabled successfully."