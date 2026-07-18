param(
  [string]$Root = ".",
  [string]$CsvOut = "resources/link_check_latest.csv",
  [string]$MarkdownOut = "resources/link_check_latest.md",
  [int]$TimeoutSeconds = 20,
  [switch]$FailOnBroken
)

$ErrorActionPreference = "Stop"

$rootPath = Resolve-Path $Root
Push-Location $rootPath
try {
  $files = @(
    "README.md",
    "README_zh.md",
    "resources/datasets.md",
    "resources/low_altitude_3d_coverage.md",
    "resources/code.md",
    "resources/models_and_demos.md",
    "resources/source_verification_20260604.md",
    "resources/monitoring_watchlist_20260606.md",
    "resources/reproducibility_scorecard.csv",
    "resources/publication_artifact_alignment.csv",
    "resources/benchmark_performance_disclosure.csv"
  )
  $files += @(Get-ChildItem -Path "resources/cards" -Filter "*.md" -File -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })

  $linkRows = New-Object System.Collections.Generic.List[object]
  foreach ($file in $files) {
    if (-not (Test-Path $file)) { continue }
    $displayPath = Resolve-Path $file -Relative
    $text = Get-Content -Path $file -Raw -Encoding UTF8
    $matches = [regex]::Matches($text, 'https?://[^\s\]\),;"''<>]+')
    foreach ($match in $matches) {
      $url = $match.Value.TrimEnd(".", ":", ";")
      $linkRows.Add([pscustomobject]@{
        source = ($displayPath -replace '^\.\\', '')
        url = $url
      })
    }
  }

  $uniqueLinks = $linkRows |
    Group-Object url |
    ForEach-Object {
      [pscustomobject]@{
        url = $_.Name
        sources = (($_.Group | Select-Object -ExpandProperty source -Unique) -join "; ")
      }
    } |
    Sort-Object url

  $results = New-Object System.Collections.Generic.List[object]
  foreach ($link in $uniqueLinks) {
    $statusCode = $null
    $status = "unknown"
    $method = "HEAD"
    $errorText = ""
    try {
      $response = Invoke-WebRequest -Uri $link.url -Method Head -TimeoutSec $TimeoutSeconds -MaximumRedirection 5 -UseBasicParsing
      $statusCode = [int]$response.StatusCode
      $status = if ($statusCode -ge 200 -and $statusCode -lt 400) { "ok" } else { "review" }
    } catch {
      try {
        $method = "GET"
        $response = Invoke-WebRequest -Uri $link.url -Method Get -TimeoutSec $TimeoutSeconds -MaximumRedirection 5 -UseBasicParsing
        $statusCode = [int]$response.StatusCode
        $status = if ($statusCode -ge 200 -and $statusCode -lt 400) { "ok" } else { "review" }
      } catch {
        $status = "review"
        $errorText = ($_.Exception.Message -replace '\s+', ' ').Trim()
      }
    }

    $results.Add([pscustomobject]@{
      url = $link.url
      status = $status
      status_code = $statusCode
      method = $method
      sources = $link.sources
      checked_at = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
      error = $errorText
    })
  }

  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $CsvOut) | Out-Null
  $results | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $CsvOut

  $okCount = @($results | Where-Object { $_.status -eq "ok" }).Count
  $reviewCount = @($results | Where-Object { $_.status -ne "ok" }).Count
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("# Public Link Check")
  $lines.Add("")
  $lines.Add("Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")")
  $lines.Add("")
  $lines.Add("| Metric | Value |")
  $lines.Add("|---|---:|")
  $lines.Add("| Unique public links | $($results.Count) |")
  $lines.Add("| OK links | $okCount |")
  $lines.Add("| Review links | $reviewCount |")
  $lines.Add("")
  $lines.Add("External-link status is a maintenance signal, not a scientific ranking. Some services reject HEAD requests, rate-limit anonymous clients, or require browser sessions; review therefore means the link should be manually checked before a public release, not that the resource is invalid.")
  $lines.Add("")
  $lines.Add("| Status | Code | Method | URL | Sources |")
  $lines.Add("|---|---:|---|---|---|")
  foreach ($row in $results) {
    $url = $row.url -replace '\|', '%7C'
    $sources = $row.sources -replace '\|', '/'
    $code = if ($null -eq $row.status_code -or "$($row.status_code)" -eq "") { "" } else { $row.status_code }
    $lines.Add("| $($row.status) | $code | $($row.method) | $url | $sources |")
  }
  $lines | Out-File -FilePath $MarkdownOut -Encoding UTF8

  "public_links=$($results.Count)"
  "ok=$okCount"
  "review=$reviewCount"
  "csv=$CsvOut"
  "markdown=$MarkdownOut"

  if ($FailOnBroken -and $reviewCount -gt 0) {
    exit 1
  }
  exit 0
} finally {
  Pop-Location
}
