# Database benchmark kit (SQLite vs PostgreSQL)

This folder contains a minimal benchmark kit to generate measurable evidence for PostgreSQL advantages.

## What it measures

- request throughput (average, p50, p99)
- latency (average, p50, p97.5 as p95 proxy, p99)
- error, timeout, and non-2xx counts

## Requirements

- PowerShell 5.1+
- Node.js with `npx`
- Running Juice Shop instance
- `autocannon` available through `npx autocannon`

## 1. Run baseline with SQLite

Start the app with SQLite configuration, then execute:

```powershell
./benchmarks/run-db-benchmark.ps1 -Engine sqlite -BaseUrl http://localhost:3000 -Connections 50 -DurationSeconds 15 -Runs 5
```

## 2. Run benchmark with PostgreSQL

Start the app pointing to PostgreSQL and execute:

```powershell
./benchmarks/run-db-benchmark.ps1 -Engine postgresql -BaseUrl http://localhost:3000 -Connections 50 -DurationSeconds 15 -Runs 5
```

## 3. Compare both engines

Use the generated `aggregate.csv` files from each run:

```powershell
./benchmarks/compare-db-results.ps1 -SqliteAggregateCsv ./benchmarks/results/sqlite/<timestamp>/aggregate.csv -PostgresAggregateCsv ./benchmarks/results/postgresql/<timestamp>/aggregate.csv
```

This generates a `comparison.csv` report and prints a summary table.

## Notes

- Keep the same endpoints, connections, duration, and run count for both engines.
- Run both scenarios under similar machine conditions.
- If results differ too much between runs, increase `-Runs` to 7 or 10.
