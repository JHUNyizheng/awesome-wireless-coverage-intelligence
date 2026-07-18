param(
  [string]$Root = "."
)

$ErrorActionPreference = "Stop"
$rootPath = Resolve-Path $Root
Push-Location $rootPath
try {
  $issues = New-Object System.Collections.Generic.List[string]

  $required = @(
    "README.md",
    "README_zh.md",
    "CONTRIBUTING.md",
    "LICENSE",
    "CITATION.cff",
    "resources/datasets.md",
    "resources/low_altitude_3d_coverage.md",
    "resources/reproducibility_scorecard.csv",
    "resources/benchmark_performance_disclosure.csv",
    "resources/benchmark_result_card_ledger.md",
    "resources/publication_artifact_alignment.csv",
    "resources/source_verification_20260604.md",
    "resources/monitoring_watchlist_20260606.md",
    "resources/publication_closure_packet_20260606.md",
    "resources/link_check_latest.csv",
    "resources/link_check_latest.md",
    "tutorials/getting_started.md",
    "tutorials/getting_started_zh.md",
    "tutorials/low_altitude_benchmark_workflow.md",
    "tutorials/reproducibility_protocol.md",
    "schemas/resource_card.schema.json",
    "scripts/check_public_links.ps1",
    "scripts/build_release_bundle.ps1",
    "scripts/check_release_bundle.ps1",
    ".github/workflows/resource-check.yml",
    ".github/ISSUE_TEMPLATE/resource_submission.yml"
  )
  foreach ($path in $required) {
    if (-not (Test-Path $path)) {
      $issues.Add("missing required file: $path")
    }
  }

  $csvExpectations = @{
    "resources/reproducibility_scorecard.csv" = 18
    "resources/benchmark_performance_disclosure.csv" = 10
    "resources/publication_artifact_alignment.csv" = 18
  }
  foreach ($entry in $csvExpectations.GetEnumerator()) {
    if (Test-Path $entry.Key) {
      $rows = @(Import-Csv $entry.Key)
      if ($rows.Count -lt $entry.Value) {
        $issues.Add("$($entry.Key) has $($rows.Count) rows, expected at least $($entry.Value)")
      }
    }
  }

  $ledgerPath = "resources/benchmark_result_card_ledger.md"
  $ledgerSignals = @(
    "First Extracted Native Cards",
    "RadioMap3DSeer / 2023 Pathloss Challenge",
    "REM-Net+ / RadioMap3DSeer Competition Test Set",
    "RadioLAM / SpectrumNet and AERPAW",
    "High-Efficiency Urban 3D GPR / Real UAV Measurements",
    "3DiRM3200 / R2Net",
    "RadioMapSeer Protocol Reported by R2Net",
    "RadioMapMotion and SpectrumNet Extraction Status",
    "Inference time per km2"
  )
  if (Test-Path $ledgerPath) {
    $ledgerText = Get-Content -Path $ledgerPath -Raw -Encoding UTF8
    foreach ($signal in $ledgerSignals) {
      if (-not $ledgerText.Contains($signal)) {
        $issues.Add("$ledgerPath missing signal: $signal")
      }
    }
  }

  $linkFiles = @("README.md", "README_zh.md")
  $relativeLinks = New-Object System.Collections.Generic.List[string]
  foreach ($file in $linkFiles) {
    if (-not (Test-Path $file)) { continue }
    $text = Get-Content -Path $file -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($text, '\]\(([^)]+)\)')) {
      $link = $match.Groups[1].Value
      if ($link -notmatch '^https?://' -and $link -notmatch '^#' -and $link -notmatch '^mailto:') {
        $relativeLinks.Add($link)
        if (-not (Test-Path $link)) {
          $issues.Add("$file has missing relative link: $link")
        }
      }
    }
  }

  $cards = @(Get-ChildItem -Path "resources/cards" -Filter "*.md" -File -ErrorAction SilentlyContinue)
  $requiredCardFiles = @(
    "resources/cards/radiolam.md",
    "resources/cards/remnetplus.md",
    "resources/cards/urban_3d_gpr_measurement.md"
  )
  foreach ($cardPath in $requiredCardFiles) {
    if (-not (Test-Path $cardPath)) {
      $issues.Add("missing required result-boundary card: $cardPath")
    }
  }

  if ($cards.Count -lt 10) {
    $issues.Add("resources/cards has $($cards.Count) cards, expected at least 10")
  }

  if ($issues.Count -gt 0) {
    "FAIL"
    $issues | ForEach-Object { "- $_" }
    exit 1
  }

  "PASS"
  "required_files=$($required.Count)"
  "relative_links=$($relativeLinks.Count)"
  "resource_cards=$($cards.Count)"
  foreach ($entry in $csvExpectations.GetEnumerator()) {
    $rows = @(Import-Csv $entry.Key)
    "$($entry.Key)=$($rows.Count)"
  }
  "benchmark_result_card_signals=$($ledgerSignals.Count)"
} finally {
  Pop-Location
}
