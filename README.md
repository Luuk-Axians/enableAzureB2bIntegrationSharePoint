# ✅ Enable Azure B2B Integration for Sharepoint Online

This repository provides a solution to enable Azure B2B Integration for SharePoint and describes the advantages and impact of this integration. Within the repository you will find a PowerShell script `enableAzureB2BforSharepoint.ps1` to automate the process.

## 📋 Overview
Azure AD B2B provides authentication and management of guests, allowing for seamless sharing of files, folders, list items, document libraries, and sites with people outside your organization. The integration with SharePoint and OneDrive offers improved security and user experience compared to the existing secure external sharing recipient experience.

## ➕ Advantages
- External users are given an account in the directory and are subject to Azure AD access policies such as multi-factor authentication.
- Invitations to a SharePoint site no longer require users to have or create a Microsoft account.
- If Google federation is configured in Azure AD, federated users can access shared SharePoint and OneDrive resources.
- SharePoint and OneDrive sharing is subject to Azure AD organizational relationships settings, providing a more consistent access control experience.

## ⚠️ Impact
- Enabling this integration doesn't change your sharing settings. If you have site collections where external sharing is turned off, it will remain off.
- Once the integration is enabled, users don't have to reshare or do any manual migration for guests previously shared with. When someone outside your organization clicks on a link that was created before Azure AD B2B integration was enabled, SharePoint will automatically create a B2B guest account for the user who originally created the sharing link.
- Guest users can't share the site or the documents themselves.

## 🔧 Prerequisites

None, the script will check if the required modules are installed and if not it will install them for you.

# Running the Script

1. Open PowerShell as an administrator.
2. Download the script to your machine.
3. Replace `YourTenantName` in the $adminURL with the name of your tenant.
4. Run the script by typing `.\enableAzureB2BforSharepoint.ps1` and pressing Enter.
5. Type `get-SPOTenant` to get a list of all the SharePoint Online Tenant Properties. You should see the `EnableAzureADB2BIntegration` property set to `True`.

## 📚 Script Breakdown
1. Install SharePoint Online Management Shell:
This part of the script checks if the "Microsoft.Online.SharePoint.PowerShell" module is installed. If it's not, it installs the module for the current user.
```
if (-not (Get-InstalledModule -Name "Microsoft.Online.SharePoint.PowerShell" -ErrorAction SilentlyContinue)) {
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Force
}
```

2. Import SharePoint Online Management Shell module:
This line imports the SharePoint Online Management Shell module, which provides the necessary cmdlets to interact with SharePoint Online.
```
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
```

3. Connect to SharePoint:
This part of the script sets the admin URL for your SharePoint tenant (replace "YourTenantName" with your tenant name) and another window will pop up asking you to sign in to your tenant.

```
$adminUrl = "https://YourTenantName-admin.sharepoint.com" # Replace "YourTenantName" with your tenant name
Connect-SPOService -Url $adminUrl
```

4. Enable Azure B2B Integration:
This line enables the Azure B2B Integration for SharePoint by setting the EnableAzureADB2BIntegration flag to $true.
```
Set-SPOTenant -EnableAzureADB2BIntegration $true
```

5. Display a success message:
This line writes a message to the console indicating that the Azure B2B Integration for SharePoint has been enabled successfully.

```
Write-Host "Azure B2B Integration for SharePoint enabled successfully."
```

# 🔧 Disabling the Integration
If you need to disable the integration, run the following PowerShell command:
```
Set-SPOTenant -EnableAzureADB2BIntegration $false
```

**Important:** Once disabled, users who were shared while the integration was enabled will always be an AAD Guest User for future shares. To convert a user from an AAD Guest User back to a SharePoint OTP user, you will need to delete the guest in AAD and remove all SPUser objects in your organization that reference that guest user.