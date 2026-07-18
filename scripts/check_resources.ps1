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
    "resources/artifact_availability_ledger.csv",
    "resources/artifact_index.md",
    "resources/open_artifact_taxonomy.md",
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
    "resources/artifact_availability_ledger.csv" = 31
  }

  $artifactLedgerPath = "resources/artifact_availability_ledger.csv"
  if (Test-Path $artifactLedgerPath) {
    $artifactRows = @(Import-Csv $artifactLedgerPath)
    $requiredColumns = @(
      "record_id", "resource", "linked_work", "artifact_type", "canonical_url",
      "status", "license", "version_or_commit", "last_verified",
      "reproduction_scope", "verification_note"
    )
    $actualColumns = @($artifactRows[0].PSObject.Properties.Name)
    foreach ($column in $requiredColumns) {
      if ($actualColumns -notcontains $column) {
        $issues.Add("$artifactLedgerPath missing column: $column")
      }
    }
    $allowedStatuses = @("open", "restricted", "unavailable", "link-broken", "unclear-license")
    $duplicateIds = @($artifactRows | Group-Object record_id | Where-Object { $_.Count -gt 1 })
    foreach ($duplicate in $duplicateIds) {
      $issues.Add("$artifactLedgerPath has duplicate record_id: $($duplicate.Name)")
    }
    foreach ($row in $artifactRows) {
      if ($allowedStatuses -notcontains $row.status) {
        $issues.Add("$artifactLedgerPath has invalid status for $($row.record_id): $($row.status)")
      }
      if ($row.canonical_url -notmatch '^https://') {
        $issues.Add("$artifactLedgerPath requires an HTTPS canonical_url for $($row.record_id)")
      }
      if ($row.last_verified -notmatch '^\d{4}-\d{2}-\d{2}$') {
        $issues.Add("$artifactLedgerPath has invalid last_verified for $($row.record_id)")
      }
      foreach ($field in @("license", "version_or_commit", "reproduction_scope", "verification_note")) {
        if ([string]::IsNullOrWhiteSpace($row.$field)) {
          $issues.Add("$artifactLedgerPath has an empty $field for $($row.record_id)")
        }
      }
    }
  }

  $schemaPath = "schemas/resource_card.schema.json"
  if (Test-Path $schemaPath) {
    try {
      $schema = Get-Content -Path $schemaPath -Raw -Encoding UTF8 | ConvertFrom-Json
      foreach ($field in @("availability_status", "license", "version_or_commit", "last_verified", "reproduction_scope")) {
        if ($schema.required -notcontains $field) {
          $issues.Add("$schemaPath does not require field: $field")
        }
      }
    } catch {
      $issues.Add("$schemaPath is not valid JSON: $($_.Exception.Message)")
    }
  }

  $readmeText = Get-Content -Path "README.md" -Raw -Encoding UTF8
  $surveyTitle = "Radio Maps and Channel Knowledge Maps for 6G Wireless Networks: A Survey of Construction, Applications, Evaluation, and Deployment"
  if (-not $readmeText.Contains($surveyTitle)) {
    $issues.Add("README.md does not contain the current survey title")
  }
  if ($readmeText.Contains("From Radio Maps and Channel Knowledge Maps to Wireless Coverage Intelligence for 6G")) {
    $issues.Add("README.md contains the retired survey title")
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
