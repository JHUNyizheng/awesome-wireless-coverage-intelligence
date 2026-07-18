# Open-Artifact Taxonomy and Counting Rules

Verified baseline: 2026-07-18

This repository treats artifact availability as an evidence dimension. It does not use openness as a proxy for technical quality.

## Artifact Types

| Type | Evidence recorded |
|---|---|
| Paper | Publisher page, DOI, open full text, or author preprint. |
| Dataset | Canonical download, persistent identifier, license, version, metadata, and fixed split. |
| Code | Repository, license, environment file, executable entry point, and maintained version or commit. |
| Model | Weights, configuration, version, license, and inference instructions. |
| Demo/API | Reachable application or service interface with example inputs and access conditions. |
| Evaluation protocol | Data split, metric implementation, task script, and reproduction instructions. |

## Availability States

- `open`: access, reuse permission, and the cited version are verified.
- `restricted`: access requires a request, account, agreement, partial release, or another material condition.
- `unavailable`: the claimed material was not observed at the canonical location.
- `link-broken`: the recorded canonical link fails after automated and manual checks.
- `unclear-license`: files are reachable, but reuse or redistribution permission is not explicit.

## Three Denominators

1. **Paper level:** asks whether a selected study has at least one direct public-resource match.
2. **Artifact level:** counts each distinct dataset, code release, model, demo, protocol, or index record.
3. **Benchmark level:** assesses whether the material combination supports an end-to-end reproduction under a fixed protocol.

The three units are reported separately. They cannot be merged into one open-source rate. A reachable link also cannot substitute for a license, fixed version, or executable workflow.

## Conservative Verification

Each ledger row records the canonical URL, status, license evidence, version or commit, verification date, reproduction scope, and a short note. Missing information remains explicit. A status change requires a new verification date and an evidence note.
