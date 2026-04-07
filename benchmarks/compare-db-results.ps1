param(
  [Parameter(Mandatory = $true)]
  [string]$SqliteAggregateCsv,

  [Parameter(Mandatory = $true)]
  [string]$PostgresAggregateCsv,

  [string]$OutputCsv = ''
)

$ErrorActionPreference = 'Stop'

$sqliteRows = Import-Csv -Path $SqliteAggregateCsv
$postgresRows = Import-Csv -Path $PostgresAggregateCsv

if ($sqliteRows.Count -eq 0 -or $postgresRows.Count -eq 0) {
  throw 'Input aggregate files are empty.'
}

$joined = foreach ($sqlite in $sqliteRows) {
  $postgres = $postgresRows | Where-Object { $_.endpoint -eq $sqlite.endpoint } | Select-Object -First 1

  if ($null -eq $postgres) {
    continue
  }

  $sqliteReq = [double]$sqlite.requests_avg_mean
  $postgresReq = [double]$postgres.requests_avg_mean

  $sqliteP95 = [double]$sqlite.latency_p95_proxy_ms
  $postgresP95 = [double]$postgres.latency_p95_proxy_ms

  $sqliteP99 = [double]$sqlite.latency_p99_mean_ms
  $postgresP99 = [double]$postgres.latency_p99_mean_ms

  $reqDeltaPct = if ($sqliteReq -ne 0) { (($postgresReq - $sqliteReq) / $sqliteReq) * 100 } else { 0 }
  $p95DeltaPct = if ($sqliteP95 -ne 0) { (($postgresP95 - $sqliteP95) / $sqliteP95) * 100 } else { 0 }
  $p99DeltaPct = if ($sqliteP99 -ne 0) { (($postgresP99 - $sqliteP99) / $sqliteP99) * 100 } else { 0 }

  [PSCustomObject]@{
    endpoint = $sqlite.endpoint
    sqlite_req_avg = [Math]::Round($sqliteReq, 2)
    postgres_req_avg = [Math]::Round($postgresReq, 2)
    req_improvement_pct = [Math]::Round($reqDeltaPct, 2)
    sqlite_latency_p95_ms = [Math]::Round($sqliteP95, 2)
    postgres_latency_p95_ms = [Math]::Round($postgresP95, 2)
    p95_change_pct = [Math]::Round($p95DeltaPct, 2)
    sqlite_latency_p99_ms = [Math]::Round($sqliteP99, 2)
    postgres_latency_p99_ms = [Math]::Round($postgresP99, 2)
    p99_change_pct = [Math]::Round($p99DeltaPct, 2)
    sqlite_errors_total = [int]$sqlite.errors_total
    postgres_errors_total = [int]$postgres.errors_total
    sqlite_timeouts_total = [int]$sqlite.timeouts_total
    postgres_timeouts_total = [int]$postgres.timeouts_total
  }
}

if ($joined.Count -eq 0) {
  throw 'No matching endpoints were found between SQLite and PostgreSQL aggregate files.'
}

$global = [PSCustomObject]@{
  endpoint = 'ALL'
  sqlite_req_avg = [Math]::Round((($joined | Measure-Object -Property sqlite_req_avg -Average).Average), 2)
  postgres_req_avg = [Math]::Round((($joined | Measure-Object -Property postgres_req_avg -Average).Average), 2)
  req_improvement_pct = [Math]::Round((($joined | Measure-Object -Property req_improvement_pct -Average).Average), 2)
  sqlite_latency_p95_ms = [Math]::Round((($joined | Measure-Object -Property sqlite_latency_p95_ms -Average).Average), 2)
  postgres_latency_p95_ms = [Math]::Round((($joined | Measure-Object -Property postgres_latency_p95_ms -Average).Average), 2)
  p95_change_pct = [Math]::Round((($joined | Measure-Object -Property p95_change_pct -Average).Average), 2)
  sqlite_latency_p99_ms = [Math]::Round((($joined | Measure-Object -Property sqlite_latency_p99_ms -Average).Average), 2)
  postgres_latency_p99_ms = [Math]::Round((($joined | Measure-Object -Property postgres_latency_p99_ms -Average).Average), 2)
  p99_change_pct = [Math]::Round((($joined | Measure-Object -Property p99_change_pct -Average).Average), 2)
  sqlite_errors_total = ($joined | Measure-Object -Property sqlite_errors_total -Sum).Sum
  postgres_errors_total = ($joined | Measure-Object -Property postgres_errors_total -Sum).Sum
  sqlite_timeouts_total = ($joined | Measure-Object -Property sqlite_timeouts_total -Sum).Sum
  postgres_timeouts_total = ($joined | Measure-Object -Property postgres_timeouts_total -Sum).Sum
}

$reportRows = @($joined) + @($global)
$reportRows | Format-Table -AutoSize

if ([string]::IsNullOrWhiteSpace($OutputCsv)) {
  $OutputCsv = Join-Path (Split-Path $PostgresAggregateCsv -Parent) 'comparison.csv'
}

$reportRows | Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding utf8
Write-Host "Comparison report written to $OutputCsv"
