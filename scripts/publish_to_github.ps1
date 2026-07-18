param(
  [string]$Owner,
  [string]$RepoName = "awesome-wireless-coverage-intelligence",
  [ValidateSet("public", "private")]
  [string]$Visibility = "public",
  [string]$RemoteUrl,
  [string]$UserName,
  [string]$UserEmail,
  [string]$CommitMessage = "Initial wireless coverage intelligence resource guide",
  [switch]$CreateRemoteWithGh,
  [switch]$SkipPublicLinkCheck,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $scriptDir
Set-Location $root

function Invoke-Logged {
  param(
    [string]$Label,
    [scriptblock]$Command,
    [switch]$AllowFailure
  )
  Write-Host "==> $Label"
  if ($DryRun) {
    Write-Host "DRY RUN: skipped command."
    return $true
  }
  & $Command
  $exitCode = $LASTEXITCODE
  if ($null -eq $exitCode) { $exitCode = 0 }
  if ($exitCode -ne 0 -and -not $AllowFailure) {
    throw "$Label failed with exit code $exitCode."
  }
  return ($exitCode -eq 0)
}

function Get-GitText {
  param([string[]]$GitArgs)
  $oldErrorActionPreference = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  try {
    $output = (& git @GitArgs 2>$null) -join "`n"
    if ($LASTEXITCODE -ne 0) { return "" }
    return $output.Trim()
  } finally {
    $ErrorActionPreference = $oldErrorActionPreference
  }
}

$insideRepo = Get-GitText @("rev-parse", "--is-inside-work-tree")
if ($insideRepo -ne "true") {
  throw "This folder is not a Git work tree. Run git init first or restore the companion repository."
}

if (-not [string]::IsNullOrWhiteSpace($UserName)) {
  Invoke-Logged "Configure git user.name" { git config user.name $UserName } | Out-Null
}
if (-not [string]::IsNullOrWhiteSpace($UserEmail)) {
  Invoke-Logged "Configure git user.email" { git config user.email $UserEmail } | Out-Null
}

if (-not $SkipPublicLinkCheck) {
  Invoke-Logged "Refresh public-link check" { powershell -ExecutionPolicy Bypass -File scripts\check_public_links.ps1 } | Out-Null
}
Invoke-Logged "Run structural resource check" { powershell -ExecutionPolicy Bypass -File scripts\check_resources.ps1 } | Out-Null

$currentName = Get-GitText @("config", "user.name")
$currentEmail = Get-GitText @("config", "user.email")
if ($DryRun -and [string]::IsNullOrWhiteSpace($currentName) -and -not [string]::IsNullOrWhiteSpace($UserName)) {
  $currentName = $UserName
}
if ($DryRun -and [string]::IsNullOrWhiteSpace($currentEmail) -and -not [string]::IsNullOrWhiteSpace($UserEmail)) {
  $currentEmail = $UserEmail
}
if ([string]::IsNullOrWhiteSpace($currentName) -or [string]::IsNullOrWhiteSpace($currentEmail)) {
  throw "Git user.name and user.email must be configured before creating the initial commit. Pass -UserName and -UserEmail or configure them manually."
}

if ([string]::IsNullOrWhiteSpace($RemoteUrl) -and -not [string]::IsNullOrWhiteSpace($Owner)) {
  $RemoteUrl = "https://github.com/$Owner/$RepoName.git"
}

if ($CreateRemoteWithGh) {
  $ghCommand = Get-Command gh -ErrorAction SilentlyContinue
  if ($null -eq $ghCommand) {
    throw "GitHub CLI (gh) is not installed. Install gh or create the GitHub repository manually and pass -RemoteUrl."
  }
  if ([string]::IsNullOrWhiteSpace($Owner)) {
    throw "Pass -Owner when using -CreateRemoteWithGh."
  }
  $sourceRepo = "$Owner/$RepoName"
  $existingRemote = Get-GitText @("remote", "get-url", "origin")
  if ([string]::IsNullOrWhiteSpace($existingRemote)) {
    Invoke-Logged "Create GitHub repository with gh" { gh repo create $sourceRepo "--$Visibility" --source . --remote origin } | Out-Null
  } else {
    Write-Host "origin already exists: $existingRemote"
  }
}

$remote = Get-GitText @("remote", "get-url", "origin")
if ([string]::IsNullOrWhiteSpace($remote) -and -not [string]::IsNullOrWhiteSpace($RemoteUrl)) {
  Invoke-Logged "Add origin remote" { git remote add origin $RemoteUrl } | Out-Null
  $remote = $RemoteUrl
}

if ([string]::IsNullOrWhiteSpace($remote)) {
  throw "No origin remote configured. Pass -RemoteUrl, pass -Owner, or use -CreateRemoteWithGh after installing/authenticating gh."
}

$status = Get-GitText @("status", "--short")
if (-not [string]::IsNullOrWhiteSpace($status)) {
  Invoke-Logged "Stage companion project files" { git add . } | Out-Null
  $staged = Get-GitText @("diff", "--cached", "--name-only")
  if (-not [string]::IsNullOrWhiteSpace($staged)) {
    Invoke-Logged "Create publication commit" { git commit -m $CommitMessage } | Out-Null
  } else {
    Write-Host "No staged changes to commit."
  }
} else {
  Write-Host "Working tree is clean; no commit needed."
}

Invoke-Logged "Rename current branch to main" { git branch -M main } | Out-Null
Invoke-Logged "Push to GitHub origin/main" { git push -u origin main } | Out-Null

Write-Host "Companion project publication flow completed."
Write-Host "Remote: $remote"
