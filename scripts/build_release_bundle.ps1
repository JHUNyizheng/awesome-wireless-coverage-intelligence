param(
  [string]$OutputDir = "dist",
  [string]$PackageName = "awesome-wireless-coverage-intelligence-release",
  [int]$LinkTimeoutSeconds = 12,
  [switch]$SkipPublicLinkCheck
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $scriptDir
Set-Location $root

if (-not $SkipPublicLinkCheck) {
  & powershell -ExecutionPolicy Bypass -File scripts\check_public_links.ps1 -TimeoutSeconds $LinkTimeoutSeconds | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "check_public_links.ps1 failed." }
}

& powershell -ExecutionPolicy Bypass -File scripts\check_resources.ps1 | Out-Null
if ($LASTEXITCODE -ne 0) { throw "check_resources.ps1 failed." }

$staging = Join-Path $OutputDir $PackageName
$zipPath = Join-Path $OutputDir "$PackageName.zip"
$validationReport = Join-Path $OutputDir "release_bundle_validation_latest.md"
$validationJson = Join-Path $OutputDir "release_bundle_validation_latest.json"

if (Test-Path $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
New-Item -ItemType Directory -Force -Path $staging | Out-Null
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

$excludeDirs = @(".git", "dist", "data", "datasets", "checkpoints", "weights", "third_party", "__pycache__", ".ipynb_checkpoints")
$excludeFiles = @(
  ".DS_Store",
  "Thumbs.db",
  "publication_decision_snapshot_latest.md",
  "publication_decision_snapshot_latest.json"
)
$copied = New-Object System.Collections.Generic.List[object]

$rootPath = (Resolve-Path ".").Path
$files = Get-ChildItem -LiteralPath $rootPath -Recurse -File -Force | Sort-Object FullName
foreach ($file in $files) {
  $relative = $file.FullName.Substring($rootPath.Length).TrimStart("\", "/")
  $parts = $relative -split '[\\/]'
  if (@($parts | Where-Object { $excludeDirs -contains $_ }).Count -gt 0) { continue }
  if ($excludeFiles -contains $file.Name) { continue }
  if ($file.Name -like "*.tmp" -or $file.Name -like "*.log") { continue }

  $destination = Join-Path $staging $relative
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
  Copy-Item -LiteralPath $file.FullName -Destination $destination -Force
  $copied.Add([pscustomobject]@{
    path = ($relative -replace '\\', '/')
    bytes = $file.Length
  })
}

$manifestPath = Join-Path $staging "RELEASE_BUNDLE_MANIFEST.csv"
$copied | Sort-Object path | Export-Csv -NoTypeInformation -Encoding UTF8 $manifestPath

$summary = [pscustomobject]@{
  generated_at = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  package_name = $PackageName
  copied_files = $copied.Count
  missing_files = 0
  skip_public_link_check = [bool]$SkipPublicLinkCheck
  excluded_directories = $excludeDirs
  excluded_files = $excludeFiles
  zip_path = $zipPath
}
$summary | ConvertTo-Json -Depth 5 | Out-File -FilePath (Join-Path $staging "RELEASE_BUNDLE_SUMMARY.json") -Encoding UTF8

$readme = @"
# Radio Maps and Channel Knowledge Maps Companion Release Bundle

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

This ZIP is a local, reviewable release bundle for the companion repository.
It is intended for manual GitHub repository creation, maintainer review, or
archival handoff when a GitHub remote is not yet configured.

## Intended GitHub Repository

- Repository name: 'awesome-wireless-coverage-intelligence'
- Suggested visibility: public, unless the author team decides to keep it
  private until revision or acceptance.
- Suggested description: Companion index of papers, datasets, code, models,
  demos, evaluation protocols, and benchmark disclosures for radio maps and
  channel knowledge maps in 6G.

## Contents

The bundle includes README files, resource tables, resource cards, tutorials,
local validation scripts, publication helpers, GitHub issue templates, and the
GitHub Actions workflow. It intentionally excludes '.git', 'dist', local data,
datasets, checkpoints, weights, and third-party mirrors.

## Manual Publication Workflow

1. Create a new GitHub repository named 'awesome-wireless-coverage-intelligence'.
2. Extract this ZIP into the repository working tree.
3. Review 'PUBLISHING.md', 'README.md', 'README_zh.md', and the tutorials.
4. Run:

~~~powershell
powershell -ExecutionPolicy Bypass -File scripts\check_resources.ps1
powershell -ExecutionPolicy Bypass -File scripts\check_public_links.ps1
powershell -ExecutionPolicy Bypass -File scripts\check_publish_readiness.ps1
~~~

5. Configure real Git identity, commit, add a GitHub remote, and push.

## Integrity

Use 'RELEASE_BUNDLE_MANIFEST.csv' to inspect file contents and
'RELEASE_BUNDLE_SUMMARY.json' for generation metadata. The companion root keeps
the latest bundle QA report under 'dist/release_bundle_validation_latest.md'.
"@
$readme | Out-File -FilePath (Join-Path $staging "RELEASE_BUNDLE_README.md") -Encoding UTF8

if (Test-Path $zipPath) { Remove-Item -LiteralPath $zipPath -Force }
Compress-Archive -Path (Join-Path $staging "*") -DestinationPath $zipPath -Force

Write-Host "Release bundle staging: $(Join-Path $root $staging)"
Write-Host "Release bundle zip:     $(Join-Path $root $zipPath)"
Write-Host "Copied files:           $($copied.Count)"

& powershell -ExecutionPolicy Bypass -File scripts\check_release_bundle.ps1 -PackageDir $staging -ZipPath $zipPath -ReportPath $validationReport -JsonPath $validationJson | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Release bundle validation failed with exit code $LASTEXITCODE."
  exit 1
}

exit 0
