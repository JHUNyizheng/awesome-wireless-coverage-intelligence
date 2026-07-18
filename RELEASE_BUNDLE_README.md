# Awesome Wireless Coverage Intelligence Release Bundle

Generated: 2026-06-18 15:51:17; publication status updated 2026-07-18

This ZIP is a local, reviewable release bundle for the companion repository.
It is intended for manual GitHub repository creation, maintainer review, or
archival handoff when a GitHub remote is not yet configured.

The reviewed contents were published at
<https://github.com/JHUNyizheng/awesome-wireless-coverage-intelligence>.
The first complete resource-tree commit is
`87163754fa3f8daa1d8b8e1eeaeab006540b1bcb`, and GitHub Actions
`resource-check #1` completed successfully.

## Intended GitHub Repository

- Repository name: 'awesome-wireless-coverage-intelligence'
- Suggested visibility: public, unless the author team decides to keep it
  private until revision or acceptance.
- Suggested description: Curated datasets, code, pretrained-model, demo, and
  benchmark-disclosure resources for wireless coverage intelligence, radio
  maps, REM, CKM, and low-altitude 3D coverage research.

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
