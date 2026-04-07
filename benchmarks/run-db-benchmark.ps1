param(
  [Parameter(Mandatory = $true)]
  [ValidateSet('sqlite', 'postgresql')]
  [string]$Engine,

  [string]$BaseUrl = 'http://localhost:3000',
  [int]$Connections = 50,
  [int]$DurationSeconds = 15,
  [int]$Runs = 5,
  [string[]]$Endpoints = @(
    '/rest/products/search?q=a',
    '/rest/products/1/reviews',
    '/rest/products'
  )
)

$ErrorActionPreference = 'Stop'

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$resultsRoot = Join-Path $PSScriptRoot "results/$Engine/$timestamp"
New-Item -ItemType Directory -Path $resultsRoot -Force | Out-Null

Write-Host "Starting benchmark for engine=$Engine"
Write-Host "Output folder: $resultsRoot"

$summaryRows = @()

foreach ($endpoint in $Endpoints) {
  $safeEndpoint = ($endpoint -replace '[^a-zA-Z0-9]', '_').Trim('_')

  for ($run = 1; $run -le $Runs; $run++) {
    $url = "$BaseUrl$endpoint"
    Write-Host "Running $safeEndpoint - iteration $run/$Runs"

    $jsonOutput = & npx --yes autocannon $url -c $Connections -d $DurationSeconds -j
    $runResult = $jsonOutput | ConvertFrom-Json

    $runFile = Join-Path $resultsRoot ("{0}_run{1}.json" -f $safeEndpoint, $run)
    $jsonOutput | Out-File -FilePath $runFile -Encoding utf8

    $row = [PSCustomObject]@{
      engine = $Engine
      endpoint = $endpoint
      run = $run
      requests_avg = $runResult.requests.average
      requests_p50 = $runResult.requests.p50
      requests_p99 = $runResult.requests.p99
      latency_avg_ms = $runResult.latency.average
      latency_p50_ms = $runResult.latency.p50
      latency_p97_5_ms = $runResult.latency.'p97_5'
      latency_p99_ms = $runResult.latency.p99
      throughput_avg_bytes = $runResult.throughput.average
      total_errors = $runResult.errors
      total_timeouts = $runResult.timeouts
      non_2xx = $runResult.non2xx
    }

    $summaryRows += $row
  }
}

$summaryCsv = Join-Path $resultsRoot 'summary.csv'
$summaryRows | Export-Csv -Path $summaryCsv -NoTypeInformation -Encoding utf8

$aggregate = $summaryRows |
  Group-Object -Property endpoint |
  ForEach-Object {
    $groupRows = $_.Group
    [PSCustomObject]@{
      engine = $Engine
      endpoint = $_.Name
      runs = $groupRows.Count
      requests_avg_mean = [Math]::Round((($groupRows | Measure-Object -Property requests_avg -Average).Average), 2)
      latency_p95_proxy_ms = [Math]::Round((($groupRows | Measure-Object -Property latency_p97_5_ms -Average).Average), 2)
      latency_p99_mean_ms = [Math]::Round((($groupRows | Measure-Object -Property latency_p99_ms -Average).Average), 2)
      errors_total = ($groupRows | Measure-Object -Property total_errors -Sum).Sum
      timeouts_total = ($groupRows | Measure-Object -Property total_timeouts -Sum).Sum
      non_2xx_total = ($groupRows | Measure-Object -Property non_2xx -Sum).Sum
    }
  }

$aggregateCsv = Join-Path $resultsRoot 'aggregate.csv'
$aggregate | Export-Csv -Path $aggregateCsv -NoTypeInformation -Encoding utf8

Write-Host "Benchmark completed."
Write-Host "Summary:   $summaryCsv"
Write-Host "Aggregate: $aggregateCsv"
