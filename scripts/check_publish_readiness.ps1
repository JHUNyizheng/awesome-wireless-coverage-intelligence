param(
  [string]$ReportPath = "resources/publish_readiness_latest.md",
  [string]$JsonPath = "resources/publish_readiness_latest.json",
  [switch]$Strict
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $scriptDir
Set-Location $root

$checks = New-Object System.Collections.Generic.List[object]

function Add-Check {
  param(
    [string]$Name,
    [ValidateSet("PASS", "OPEN", "REVIEW")]
    [string]$Status,
    [string]$Detail
  )
  $script:checks.Add([pscustomobject]@{
    name = $Name
    status = $Status
    detail = $Detail
  })
}

function Invoke-GitText {
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

function Invoke-CommandText {
  param([scriptblock]$Command)
  $oldErrorActionPreference = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  try {
    $output = @(& $Command 2>&1)
    $exitCode = if ($null -eq $LASTEXITCODE) { 0 } else { [int]$LASTEXITCODE }
    return [pscustomobject]@{
      exit_code = $exitCode
      text = (($output | Select-Object -Last 10) -join " ").Trim()
    }
  } finally {
    $ErrorActionPreference = $oldErrorActionPreference
  }
}

function Read-Json {
  param([string]$Path)
  if (Test-Path $Path) {
    $text = Get-Content -Path $Path -Raw -Encoding UTF8
    if (-not [string]::IsNullOrWhiteSpace($text)) {
      return ($text | ConvertFrom-Json)
    }
  }
  return $null
}

$insideRepo = Invoke-GitText @("rev-parse", "--is-inside-work-tree")
if ($insideRepo -eq "true") {
  Add-Check "Git repository" "PASS" "Folder is a Git work tree."
} else {
  Add-Check "Git repository" "OPEN" "Folder is not a Git work tree."
}

$userName = Invoke-GitText @("config", "user.name")
$userEmail = Invoke-GitText @("config", "user.email")
if ([string]::IsNullOrWhiteSpace($userName)) {
  Add-Check "Git user.name" "OPEN" "Missing local Git user.name."
} else {
  Add-Check "Git user.name" "PASS" "Configured."
}

if ([string]::IsNullOrWhiteSpace($userEmail)) {
  Add-Check "Git user.email" "OPEN" "Missing local Git user.email."
} else {
  Add-Check "Git user.email" "PASS" "Configured."
}

$remotes = Invoke-GitText @("remote", "-v")
if ([string]::IsNullOrWhiteSpace($remotes)) {
  Add-Check "Git remote" "OPEN" "No remote configured."
} elseif ($remotes -match "github.com") {
  Add-Check "Git remote" "PASS" "GitHub remote is configured."
} else {
  Add-Check "Git remote" "REVIEW" "Remote exists but does not appear to be GitHub."
}

$ghCommand = Get-Command gh -ErrorAction SilentlyContinue
if ($null -eq $ghCommand) {
  Add-Check "GitHub CLI" "REVIEW" "gh is not installed; use the manual GitHub remote workflow or install/authenticate gh before CreateRemoteWithGh."
} else {
  $ghStatus = Invoke-CommandText { gh auth status }
  if ($ghStatus.exit_code -eq 0) {
    Add-Check "GitHub CLI" "PASS" "gh is installed and authentication status returned success."
  } else {
    Add-Check "GitHub CLI" "REVIEW" "gh is installed but authentication was not confirmed. Tail: $($ghStatus.text)"
  }
}

$status = Invoke-GitText @("status", "--short")
if ([string]::IsNullOrWhiteSpace($status)) {
  Add-Check "Git working tree" "PASS" "No uncommitted changes."
} else {
  $statusLines = @($status -split "`n" | Where-Object { $_.Trim().Length -gt 0 })
  Add-Check "Git working tree" "REVIEW" "$($statusLines.Count) uncommitted or untracked entries; this is expected before the initial commit."
}

$requiredFiles = @(
  "README.md",
  "README_zh.md",
  "LICENSE",
  "CITATION.cff",
  "PUBLISHING.md",
  "scripts/publish_to_github.ps1",
  "scripts/build_release_bundle.ps1",
  "scripts/check_release_bundle.ps1",
  "resources/datasets.md",
  "resources/monitoring_watchlist_20260606.md",
  "resources/publication_closure_packet_20260606.md",
  "resources/reproducibility_scorecard.csv",
  "resources/publication_artifact_alignment.csv",
  "resources/benchmark_performance_disclosure.csv",
  "resources/benchmark_result_card_ledger.md",
  ".github/workflows/resource-check.yml"
)
$missingFiles = @($requiredFiles | Where-Object { -not (Test-Path $_) })
if ($missingFiles.Count -eq 0) {
  $publishingText = Get-Content -Path "PUBLISHING.md" -Raw -Encoding UTF8
  $publishingSignals = @(
    "Publication Decision Record",
    "publication_closure_packet_20260606.md",
    "Defer public release",
    "Bundle SHA256",
    "Responsible person"
  )
  $missingPublishingSignals = @($publishingSignals | Where-Object { -not $publishingText.Contains($_) })
  if ($missingPublishingSignals.Count -eq 0) {
    Add-Check "Required publication files" "PASS" "$($requiredFiles.Count) required files found; publication/deferral decision record signals present."
  } else {
    Add-Check "Required publication files" "OPEN" "PUBLISHING.md missing decision-record signals: $($missingPublishingSignals -join ', ')"
  }
} else {
  Add-Check "Required publication files" "OPEN" "Missing: $($missingFiles -join ', ')"
}

$resourceCheck = (& powershell -ExecutionPolicy Bypass -File scripts\check_resources.ps1 2>&1) -join " "
if ($resourceCheck -match "^PASS") {
  Add-Check "Resource structural check" "PASS" $resourceCheck.Trim()
} else {
  Add-Check "Resource structural check" "OPEN" $resourceCheck.Trim()
}

if (Test-Path "resources/link_check_latest.csv") {
  $links = Import-Csv "resources/link_check_latest.csv"
  $okLinks = @($links | Where-Object { $_.status -eq "ok" }).Count
  $reviewLinks = @($links | Where-Object { $_.status -ne "ok" }).Count
  if ($reviewLinks -eq 0) {
    Add-Check "Public-link review" "PASS" "$($links.Count) public links; all automated checks OK."
  } else {
    Add-Check "Public-link review" "REVIEW" "$($links.Count) public links; $okLinks OK, $reviewLinks need manual release-time review."
  }
} else {
  Add-Check "Public-link review" "OPEN" "resources/link_check_latest.csv not found; run scripts/check_public_links.ps1."
}

if (Test-Path "scripts/publish_to_github.ps1") {
  $helperDryRun = Invoke-CommandText {
    powershell -ExecutionPolicy Bypass -File scripts\publish_to_github.ps1 -DryRun -SkipPublicLinkCheck -Owner example-owner -UserName "Example Author" -UserEmail "author@example.com"
  }
  if ($helperDryRun.exit_code -eq 0 -and $helperDryRun.text -match "Companion project publication flow completed") {
    Add-Check "Publication helper dry-run" "PASS" "scripts/publish_to_github.ps1 completed a no-write dry run with placeholder owner and Git identity."
  } else {
    Add-Check "Publication helper dry-run" "OPEN" "Dry run failed or did not reach completion. Tail: $($helperDryRun.text)"
  }
} else {
  Add-Check "Publication helper dry-run" "OPEN" "scripts/publish_to_github.ps1 is missing."
}

if ((Test-Path "scripts/build_release_bundle.ps1") -and (Test-Path "scripts/check_release_bundle.ps1")) {
  $bundleDryRun = Invoke-CommandText {
    powershell -ExecutionPolicy Bypass -File scripts\build_release_bundle.ps1 -SkipPublicLinkCheck
  }
  if ($bundleDryRun.exit_code -eq 0 -and $bundleDryRun.text -match "Copied files") {
    Add-Check "Release bundle dry-run" "PASS" "scripts/build_release_bundle.ps1 produced and validated a local ZIP bundle for manual GitHub publication."
  } else {
    Add-Check "Release bundle dry-run" "OPEN" "Release bundle build failed or did not reach validation. Tail: $($bundleDryRun.text)"
  }
} else {
  Add-Check "Release bundle dry-run" "OPEN" "Release bundle scripts are missing."
}

$openCount = @($checks | Where-Object { $_.status -eq "OPEN" }).Count
$reviewCount = @($checks | Where-Object { $_.status -eq "REVIEW" }).Count
$passCount = @($checks | Where-Object { $_.status -eq "PASS" }).Count

$summary = [pscustomobject]@{
  generated_at = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  pass = $passCount
  review = $reviewCount
  open = $openCount
  strict = [bool]$Strict
  checks = $checks
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ReportPath) | Out-Null
$summary | ConvertTo-Json -Depth 5 | Out-File -FilePath $JsonPath -Encoding UTF8

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Companion Publication Readiness")
$lines.Add("")
$lines.Add("Generated: $($summary.generated_at)")
$lines.Add("")
$lines.Add("| Metric | Value |")
$lines.Add("|---|---:|")
$lines.Add("| PASS | $passCount |")
$lines.Add("| REVIEW | $reviewCount |")
$lines.Add("| OPEN | $openCount |")
$lines.Add("")
$lines.Add("| Status | Check | Detail |")
$lines.Add("|---|---|---|")
foreach ($check in $checks) {
  $detail = ($check.detail -replace '\|', '/')
  $lines.Add("| $($check.status) | $($check.name) | $detail |")
}
$lines.Add("")
$lines.Add("Interpretation: OPEN rows must be fixed before first GitHub publication. REVIEW rows need human release-time judgment but may be acceptable for an initial commit.")
$lines | Out-File -FilePath $ReportPath -Encoding UTF8

$bundleJson = Read-Json "dist/release_bundle_validation_latest.json"
$bundleZipPath = if ($bundleJson) { $bundleJson.zip_path } else { "dist/awesome-wireless-coverage-intelligence-release.zip" }
$bundleSha = if ($bundleJson) { $bundleJson.zip_sha256 } else { "" }
$openItems = @($checks | Where-Object { $_.status -eq "OPEN" } | ForEach-Object { $_.name })
$reviewItems = @($checks | Where-Object { $_.status -eq "REVIEW" } | ForEach-Object { $_.name })
$decisionStatus = if ($openItems.Count -eq 0) { "READY_FOR_PUBLICATION_OR_DEFERRAL_DECISION" } else { "PUBLICATION_DECISION_PENDING" }

$decision = [pscustomobject]@{
  generated_at = $summary.generated_at
  status = $decisionStatus
  suggested_repository_name = "awesome-wireless-coverage-intelligence"
  suggested_visibility = "public or private-until-acceptance"
  open_items = $openItems
  review_items = $reviewItems
  git_user_name_configured = -not [string]::IsNullOrWhiteSpace($userName)
  git_user_email_configured = -not [string]::IsNullOrWhiteSpace($userEmail)
  git_remote_configured = -not [string]::IsNullOrWhiteSpace($remotes)
  github_cli_available = ($null -ne $ghCommand)
  release_bundle_zip = $bundleZipPath
  release_bundle_sha256 = $bundleSha
  next_actions = @(
    "If publishing before submission, configure Git identity, create or provide the GitHub remote, then run scripts/publish_to_github.ps1.",
    "If publishing manually, upload the validated release bundle and record the repository URL, visibility, first commit hash, and Actions status.",
    "If deferring public release, record the reason, release trigger, responsible person, and manuscript wording in PUBLISHING.md."
  )
}

$decisionJsonPath = "resources/publication_decision_snapshot_latest.json"
$decisionMdPath = "resources/publication_decision_snapshot_latest.md"
$decision | ConvertTo-Json -Depth 5 | Out-File -FilePath $decisionJsonPath -Encoding UTF8

$openSection = if ($openItems.Count -eq 0) { "- None." } else { ($openItems | ForEach-Object { "- $_" }) -join "`n" }
$reviewSection = if ($reviewItems.Count -eq 0) { "- None." } else { ($reviewItems | ForEach-Object { "- $_" }) -join "`n" }
$decisionMarkdown = @"
# Companion Publication Decision Snapshot

Generated: $($decision.generated_at)

| Metric | Value |
|---|---|
| Status | $($decision.status) |
| Suggested repository | $($decision.suggested_repository_name) |
| Suggested visibility | $($decision.suggested_visibility) |
| Git user.name configured | $($decision.git_user_name_configured) |
| Git user.email configured | $($decision.git_user_email_configured) |
| Git remote configured | $($decision.git_remote_configured) |
| GitHub CLI available | $($decision.github_cli_available) |
| Release bundle | $($decision.release_bundle_zip) |
| Release bundle SHA256 | $($decision.release_bundle_sha256) |

## Open Items

$openSection

## Review Items

$reviewSection

## Publication Paths

### Publish Before Submission

- git config user.name YOUR_NAME
- git config user.email YOUR_EMAIL
- powershell -ExecutionPolicy Bypass -File scripts\publish_to_github.ps1 -RemoteUrl https://github.com/OWNER/awesome-wireless-coverage-intelligence.git -UserName YOUR_NAME -UserEmail YOUR_EMAIL

### Manual Repository Creation From Bundle

- Bundle path: $($decision.release_bundle_zip)
- Bundle SHA256: $($decision.release_bundle_sha256)
- Required record: repository URL, visibility, maintainer, first pushed commit hash, and GitHub Actions/resource-check status.

### Defer Public Release

- Record the reason for deferral, planned release trigger, responsible person, and manuscript/cover-note wording in PUBLISHING.md.
- Do not close the companion GitHub publication gate until either a live repository URL or an explicit deferral decision is archived.

## Chinese Note

See README_zh.md and PUBLISHING.md for the Chinese publication/deferral guidance.
"@
$decisionMarkdown | Out-File -FilePath $decisionMdPath -Encoding UTF8

Write-Host "Publication readiness report: $ReportPath"
Write-Host "Publication readiness JSON:   $JsonPath"
Write-Host "Publication decision snapshot: $decisionMdPath"
Write-Host "PASS/REVIEW/OPEN:             $passCount / $reviewCount / $openCount"

if ($Strict -and $openCount -gt 0) { exit 1 }
exit 0
