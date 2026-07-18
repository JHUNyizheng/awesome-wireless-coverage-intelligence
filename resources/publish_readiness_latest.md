# Companion Publication Readiness

Generated: 2026-06-18 15:51:00

| Metric | Value |
|---|---:|
| PASS | 6 |
| REVIEW | 2 |
| OPEN | 3 |

| Status | Check | Detail |
|---|---|---|
| PASS | Git repository | Folder is a Git work tree. |
| OPEN | Git user.name | Missing local Git user.name. |
| OPEN | Git user.email | Missing local Git user.email. |
| OPEN | Git remote | No remote configured. |
| REVIEW | GitHub CLI | gh is not installed; use the manual GitHub remote workflow or install/authenticate gh before CreateRemoteWithGh. |
| REVIEW | Git working tree | 13 uncommitted or untracked entries; this is expected before the initial commit. |
| PASS | Required publication files | 16 required files found; publication/deferral decision record signals present. |
| PASS | Resource structural check | PASS required_files=26 relative_links=38 resource_cards=11 resources/reproducibility_scorecard.csv=21 resources/publication_artifact_alignment.csv=18 resources/benchmark_performance_disclosure.csv=10 benchmark_result_card_signals=9 |
| PASS | Public-link review | 19 public links; all automated checks OK. |
| PASS | Publication helper dry-run | scripts/publish_to_github.ps1 completed a no-write dry run with placeholder owner and Git identity. |
| PASS | Release bundle dry-run | scripts/build_release_bundle.ps1 produced and validated a local ZIP bundle for manual GitHub publication. |

Interpretation: OPEN rows must be fixed before first GitHub publication. REVIEW rows need human release-time judgment but may be acceptable for an initial commit.
