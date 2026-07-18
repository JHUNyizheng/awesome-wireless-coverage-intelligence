param(
  [string]$PackageDir = "dist\awesome-wireless-coverage-intelligence-release",
  [string]$ZipPath = "dist\awesome-wireless-coverage-intelligence-release.zip",
  [string]$ReportPath = "dist\release_bundle_validation_latest.md",
  [string]$JsonPath = "dist\release_bundle_validation_latest.json"
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

$zipSha256 = ""
if (Test-Path $ZipPath) {
  $zip = Get-Item $ZipPath
  $zipSha256 = (Get-FileHash -Algorithm SHA256 -Path $ZipPath).Hash
  Add-Check "Release ZIP" "PASS" "$ZipPath exists; $($zip.Length) bytes; SHA256=$zipSha256."
} else {
  Add-Check "Release ZIP" "OPEN" "$ZipPath missing."
}

if (Test-Path $PackageDir) {
  Add-Check "Release directory" "PASS" "$PackageDir exists."
} else {
  Add-Check "Release directory" "OPEN" "$PackageDir missing."
}

$summaryPath = Join-Path $PackageDir "RELEASE_BUNDLE_SUMMARY.json"
$manifestPath = Join-Path $PackageDir "RELEASE_BUNDLE_MANIFEST.csv"
$summary = $null
if (Test-Path $summaryPath) {
  $summary = Get-Content -Path $summaryPath -Raw -Encoding UTF8 | ConvertFrom-Json
  if ([int]$summary.copied_files -ge 35 -and [int]$summary.missing_files -eq 0) {
    Add-Check "Release summary" "PASS" "$($summary.copied_files) copied files / $($summary.missing_files) missing."
  } else {
    Add-Check "Release summary" "OPEN" "Unexpected copied/missing counts: copied=$($summary.copied_files), missing=$($summary.missing_files)."
  }
} else {
  Add-Check "Release summary" "OPEN" "RELEASE_BUNDLE_SUMMARY.json missing."
}

if (Test-Path $manifestPath) {
  $manifest = @(Import-Csv $manifestPath)
  $summaryCount = if ($summary) { [int]$summary.copied_files } else { -1 }
  if ($manifest.Count -eq $summaryCount) {
    Add-Check "Release manifest" "PASS" "$($manifest.Count) manifest rows match summary copied_files."
  } else {
    Add-Check "Release manifest" "OPEN" "$($manifest.Count) manifest rows vs summary copied_files=$summaryCount."
  }
} else {
  Add-Check "Release manifest" "OPEN" "RELEASE_BUNDLE_MANIFEST.csv missing."
}

$required = @(
  "README.md",
  "README_zh.md",
  "LICENSE",
  "CITATION.cff",
  "PUBLISHING.md",
  "CONTRIBUTING.md",
  "ROADMAP.md",
  ".github/workflows/resource-check.yml",
  ".github/ISSUE_TEMPLATE/resource_submission.yml",
  "resources/datasets.md",
  "resources/low_altitude_3d_coverage.md",
  "resources/monitoring_watchlist_20260606.md",
  "resources/reproducibility_scorecard.csv",
  "resources/publication_artifact_alignment.csv",
  "resources/benchmark_performance_disclosure.csv",
  "resources/benchmark_result_card_ledger.md",
  "resources/source_verification_20260604.md",
  "resources/publication_closure_packet_20260606.md",
  "resources/cards/README.md",
  "resources/cards/radiolam.md",
  "resources/cards/remnetplus.md",
  "resources/cards/urban_3d_gpr_measurement.md",
  "tutorials/getting_started.md",
  "tutorials/getting_started_zh.md",
  "tutorials/low_altitude_benchmark_workflow.md",
  "tutorials/reproducibility_protocol.md",
  "schemas/resource_card.schema.json",
  "scripts/check_resources.ps1",
  "scripts/check_public_links.ps1",
  "scripts/check_publish_readiness.ps1",
  "scripts/publish_to_github.ps1",
  "scripts/build_release_bundle.ps1",
  "scripts/check_release_bundle.ps1"
)
$missingRequired = @($required | Where-Object { -not (Test-Path (Join-Path $PackageDir $_)) })
if ($missingRequired.Count -eq 0) {
  Add-Check "Required release files" "PASS" "$($required.Count) required files found."
} else {
  Add-Check "Required release files" "OPEN" "Missing: $($missingRequired -join '; ')"
}

$disallowedPatterns = @(
  "\.git/",
  "\.git\\",
  "^dist/",
  "^dist\\",
  "^data/",
  "^data\\",
  "^datasets/",
  "^datasets\\",
  "^checkpoints/",
  "^checkpoints\\",
  "^weights/",
  "^weights\\",
  "^third_party/",
  "^third_party\\"
)
$disallowed = New-Object System.Collections.Generic.List[string]
if (Test-Path $manifestPath) {
  foreach ($row in @(Import-Csv $manifestPath)) {
    foreach ($pattern in $disallowedPatterns) {
      if ($row.path -match $pattern) { $disallowed.Add($row.path) }
    }
  }
}
if ($disallowed.Count -eq 0) {
  Add-Check "Release hygiene" "PASS" "No .git, dist, data, dataset, checkpoint, weight, or third_party entries found."
} else {
  Add-Check "Release hygiene" "OPEN" "Disallowed entries: $(($disallowed | Select-Object -First 10) -join '; ')"
}

$badTextFiles = New-Object System.Collections.Generic.List[string]
function New-TextPattern {
  param([int[]]$CodePoints)
  return -join ($CodePoints | ForEach-Object { [char]$_ })
}

$mojibakePatterns = @(
  (New-TextPattern @(0x6D93, 0xE15F)),
  (New-TextPattern @(0x9428, 0x52ED)),
  (New-TextPattern @(0x951B)),
  (New-TextPattern @(0x9286)),
  (New-TextPattern @(0x7EC2)),
  (New-TextPattern @(0x93C2, 0x56E9)),
  (New-TextPattern @(0x9366, 0x677F)),
  (New-TextPattern @(0x9359, 0xE219)),
  (New-TextPattern @(0x6D63, 0x6EC0)),
  (New-TextPattern @(0x7EE0, 0x6941)),
  (New-TextPattern @(0x4E7B, 0x0070, 0x0065, 0x0063, 0x0074, 0x0072, 0x0075, 0x006D)),
  (New-TextPattern @(0x4E37, 0x0045, 0x004D)),
  (New-TextPattern @(0x93B4, 0x003F)),
  (New-TextPattern @(0x9369, 0x54C4, 0x566F)),
  (New-TextPattern @(0x9428, 0x52EC)),
  (New-TextPattern @(0x6D93, 0x20AC)),
  (New-TextPattern @(0x6D63, 0x5EA3, 0x2516)),
  (New-TextPattern @(0x7455, 0x55D9, 0x6D0A)),
  (New-TextPattern @(0x7ECB, 0x20AC, 0x9424)),
  (New-TextPattern @(0x59AF, 0x2033)),
  (New-TextPattern @(0x9422, 0x71B8)),
  (New-TextPattern @(0x95C2, 0xE1C0)),
  (New-TextPattern @(0x7F01, 0x64B4)),
  (New-TextPattern @(0x7039, 0x70B4)),
  (New-TextPattern @(0x9357, 0x5FDA, 0xE185))
)
if (Test-Path $PackageDir) {
  $textFiles = Get-ChildItem -LiteralPath $PackageDir -Recurse -File |
    Where-Object { $_.Extension -in @(".md", ".csv", ".json", ".yml", ".yaml", ".ps1", ".cff", ".txt") }
  foreach ($file in $textFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $relative = $file.FullName.Substring((Resolve-Path $PackageDir).Path.Length).TrimStart("\", "/")
    if ($text.Contains([string][char]0xFFFD) -or $text.Contains([string][char]0x0007)) {
      $badTextFiles.Add($relative)
    }
    foreach ($pattern in $mojibakePatterns) {
      if ($text.Contains($pattern)) {
        $badTextFiles.Add("$relative contains mojibake marker '$pattern'")
      }
    }
  }
}
if ($badTextFiles.Count -eq 0) {
  Add-Check "Text encoding sanity" "PASS" "No replacement-character, bell, or common GBK/UTF-8 mojibake markers detected in text files."
} else {
  Add-Check "Text encoding sanity" "OPEN" "Encoding markers found: $(($badTextFiles | Select-Object -First 10) -join '; ')"
}

$pass = @($checks | Where-Object { $_.status -eq "PASS" }).Count
$review = @($checks | Where-Object { $_.status -eq "REVIEW" }).Count
$open = @($checks | Where-Object { $_.status -eq "OPEN" }).Count

$result = [pscustomobject]@{
  generated_at = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  package_dir = $PackageDir
  zip_path = $ZipPath
  zip_sha256 = $zipSha256
  pass = $pass
  review = $review
  open = $open
  checks = $checks
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ReportPath) | Out-Null
$result | ConvertTo-Json -Depth 6 | Out-File -FilePath $JsonPath -Encoding UTF8

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Release Bundle Validation")
$lines.Add("")
$lines.Add("Generated: $($result.generated_at)")
$lines.Add("")
$lines.Add("| Metric | Value |")
$lines.Add("|---|---:|")
$lines.Add("| PASS | $pass |")
$lines.Add("| REVIEW | $review |")
$lines.Add("| OPEN | $open |")
$lines.Add("| ZIP SHA256 | $zipSha256 |")
$lines.Add("")
$lines.Add("| Status | Check | Detail |")
$lines.Add("|---|---|---|")
foreach ($check in $checks) {
  $detail = ($check.detail -replace '\|', '/')
  $lines.Add("| $($check.status) | $($check.name) | $detail |")
}
$lines.Add("")
$lines.Add("Interpretation: this QA validates the local ZIP intended for manual GitHub repository creation or maintainer review. It does not prove that the repository has been pushed to GitHub.")
$lines | Out-File -FilePath $ReportPath -Encoding UTF8

Write-Host "Release bundle validation report: $ReportPath"
Write-Host "Release bundle validation JSON:   $JsonPath"
Write-Host "PASS/REVIEW/OPEN:                 $pass / $review / $open"

if ($open -gt 0) { exit 1 }
exit 0
