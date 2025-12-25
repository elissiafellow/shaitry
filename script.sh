#!/usr/bin/env python3
import pandas as pd
import sys
from pathlib import Path

csv_file = Path("shai-hulud-report.csv")
html_file = Path("shai-hulud-report.html")

if not csv_file.exists():
    print("❌ CSV report not found, skipping HTML generation")
    sys.exit(0)

df = pd.read_csv(csv_file)
df.columns = [c.strip() for c in df.columns]

CSS = """
<style>
body {
  font-family: Arial, sans-serif;
  margin: 20px;
  background-color: #fafafa;
}
h1 { color: #333; }
table {
  border-collapse: collapse;
  width: 100%;
  font-size: 14px;
}
th, td {
  border: 1px solid #ddd;
  padding: 8px;
}
th { background-color: #f0f0f0; }
tr.safe { background-color: #f9fff9; }
tr.forensic { background-color: #ffecec; }
tr.forensic td { color: #b30000; font-weight: bold; }
.badge {
  padding: 3px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
}
.badge-safe { background: #e0f7e9; color: #1b5e20; }
.badge-forensic { background: #ffebee; color: #b30000; }
</style>
"""


def classify_row(issue):
    return "forensic" if issue == "FORENSIC_MATCH" else "safe"


df["RowClass"] = df["Issue_Type"].apply(classify_row)

df["Issue_Type"] = df["Issue_Type"].apply(
    lambda x: '<span class="badge badge-forensic">FORENSIC_MATCH</span>'
    if x == "FORENSIC_MATCH"
    else '<span class="badge badge-safe">SAFE_MATCH</span>'
)

headers = "".join(f"<th>{c}</th>" for c in df.columns if c != "RowClass")

rows = []
for _, row in df.iterrows():
    cls = row["RowClass"]
    cells = "".join(
        f"<td>{row[c]}</td>" for c in df.columns if c != "RowClass"
    )
    rows.append(f'<tr class="{cls}">{cells}</tr>')

html = f"""
<html>
<head>
<title>Shai-Hulud Scan Report</title>
{CSS}
</head>
<body>

<h1>🛡️ Shai-Hulud Supply Chain Scan Report</h1>

<p>
<span class="badge badge-forensic">FORENSIC_MATCH</span> = Malicious / Critical<br>
<span class="badge badge-safe">SAFE_MATCH</span> = Known Safe
</p>

<table>
<thead><tr>{headers}</tr></thead>
<tbody>
{''.join(rows)}
</tbody>
</table>

</body>
</html>
"""

html_file.write_text(html)
print(f"✅ HTML report generated: {html_file}")


SCANNER_VERSION="${{ inputs.scanner_version }}"

  - name: Cache scanner
        uses: actions/cache@v3
        id: scanner-cache
        with:
          path: ~/.cache/shai-hulud-scanner
          key: shai-hulud-scanner-${{ inputs.scanner_version }}
          restore-keys: |
            shai-hulud-scanner-

            https://github.com/elissiafellow/shai-hulud-2-scanner.git 


root bad, frontend good
Run set -euo pipefail
📦 Shai-Hulud 2 Scan
Targets: .,frontend
Fail on: low
Workdir: /home/runner/work/shaitry/shaitry/npm-scanner
--------------------------------
📥 Cloning scanner repository
Cloning into '.'...

🔍 Scanning: .
📦 Installing dependencies in .
npm error code ETARGET
npm error notarget No matching version found for event-stream@3.3.6.
npm error notarget In most cases you or one of your dependencies are requesting
npm error notarget a package version that doesn't exist.
npm error A complete log of this run can be found in: /home/runner/.npm/_logs/2025-12-25T12_48_10_565Z-debug-0.log
Error: Process completed with exit code 1.
root good, frontend bad
Run set -euo pipefail
📦 Shai-Hulud 2 Scan
Targets: .,frontend
Fail on: low
Workdir: /home/runner/work/shaitry/shaitry/npm-scanner
--------------------------------
📥 Cloning scanner repository
Cloning into '.'...

🔍 Scanning: .
📦 Installing dependencies in .

added 1 package in 669ms
✅ Passed: .

🔍 Scanning: frontend
📦 Installing dependencies in frontend
npm error code ETARGET
npm error notarget No matching version found for event-stream@3.3.6.
npm error notarget In most cases you or one of your dependencies are requesting
npm error notarget a package version that doesn't exist.
npm error A complete log of this run can be found in: /home/runner/.npm/_logs/2025-12-25T12_49_31_920Z-debug-0.log
Error: Process completed with exit code 1.