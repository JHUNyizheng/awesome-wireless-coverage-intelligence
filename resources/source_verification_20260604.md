# Source Verification Note

Date: 2026-06-04

Purpose: record the resource-maintenance interpretation used by this companion
repository. This note is not a citation index and does not replace the survey
paper bibliography. It documents how public project pages are interpreted when
classifying artifact support.

## Verification Scope

The current companion repository distinguishes four resource categories:

| Category | Meaning |
|---|---|
| Published benchmark/resource | A paper-linked dataset or codebase is visible and the resource can be used as published evidence. |
| Foundation toolchain | A reusable simulator, scenario generator, or channel-data platform rather than one fixed benchmark. |
| Preprint/resource-first | The artifact is public and useful, but final journal linkage or archival status should be checked before treating it as high-level publication evidence. |
| Community index | The page helps discovery, but it is not itself a dataset, codebase, checkpoint, or benchmark. |

## Resource Links Checked

| Resource | Public source | Current interpretation |
|---|---|---|
| RadioMapSeer | https://radiomapseer.github.io/ | Field-shaping public benchmark with project page and IEEE DataPort linkage. |
| DeepMIMO | https://github.com/DeepMIMO/DeepMIMO | Reusable channel-data generation toolchain. |
| DeepREM | https://zenodo.org/records/7839447 | Strong artifact stack because dataset, trained-model, and app support are visible through the Zenodo/OpenAIRE-linked resource. |
| SpectrumNet / FDRadiomap | https://github.com/ShuhangZhang/FDRadiomap | Dataset-first public resource; executable reproduction support should be checked before claiming full reproducibility. |
| UrbanRadio3D | https://github.com/UNIC-Lab/UrbanRadio3D | 3D urban radio-map benchmark with dataset/split support and RadioDiff-family linkage. |
| RadioMapMotion | https://github.com/UNIC-Lab/RadioMapMotion | Dynamic radio-map dataset with code and train/test workflow. |
| 3DiRM3200 | https://github.com/lighttime2023/3DiRM3200 | Height-aware indoor 3D radio-map resource with code notebooks and partial model support. |
| CKMImageNet | https://github.com/zyktzCKM/CKMImageNet | CKM dataset resource; code/checkpoint support is limited in the audited public page. |
| Multi-config Radiomap Dataset | https://huggingface.co/datasets/lxj321/Multi-config-Radiomap-Dataset | Resource-first artifact stack with dataset, code, and pretrained checkpoint signals; publication linkage should be rechecked. |
| Real-world CKM-Dataset | https://github.com/ycw671/CKM-Dataset | Partial real-world CKM release; useful but not yet a complete benchmark package. |

## Maintenance Rules

- Do not mirror third-party datasets, code, checkpoints, or paper text in this repository.
- Record resource status as evidence strength, not as author or paper quality.
- Separate dataset availability from full reproducibility. A public dataset with
  no split, metric script, or checkpoint is not a complete reproduction package.
- Mark resource-first items clearly until final publication and archival metadata
  are known.
- Recheck public links before a formal paper revision or public release of this
  companion repository.
- Use `resources/monitoring_watchlist_20260606.md` for newly observed resources
  that are relevant to WCI but not yet stable enough to alter the manuscript
  bibliography, benchmark tables, or reproducibility scorecard.

## 2026-06-05 Public-Link Audit

`scripts/check_public_links.ps1` was added to make link freshness repeatable.
The generated report covered 15 unique public URLs: 13 returned an OK status
through automated HEAD/GET probing, while 2 GitHub URLs required manual
release-time review because the PowerShell request was closed unexpectedly.

This audit does not change the scientific interpretation of the corresponding
resources. It only records whether a future maintainer should manually re-open a
resource before a public release or manuscript revision.

## 2026-06-06 Public-Link Reclassification

The two review-only GitHub URLs were manually re-opened through public web
access on 2026-06-06 and returned 404 responses. The companion repository
therefore no longer treats those URLs as active artifact links:

| Resource | Previous public URL | Current release treatment |
|---|---|---|
| Grid-Free Radio Map Estimation | `github.com/err-alberto/grid-free-rme` | Retained only as a literature pointer until a replacement repository is verified. |
| Awesome-Radio-Map-Categorized | `github.com/RM-Research/Awesome-Radio-Map-Categorized` | Retained only as a discovery pointer until a replacement index is verified. |

This reclassification is deliberately conservative: it prevents unreachable
repositories from inflating the dataset/code/model reproducibility evidence
while preserving the audit trail for future manual recovery.

## 2026-06-06 Monitoring Watchlist

`resources/monitoring_watchlist_20260606.md` was added to separate ecosystem
monitoring from manuscript evidence. The watchlist records resources such as
Sionna Large Radio Maps, Instant Radio Maps, Sionna RT, BostonTwin, RadioLAM,
and the R2Net/3DiRM3200 metadata line. These resources are relevant to 3D,
low-altitude, differentiable ray-tracing, digital-twin, and large-scale
coverage-map workflows, but they are not automatically promoted into the
210-work CST manuscript evidence base.

The promotion rule is intentionally strict: before a watchlist item is cited as
survey evidence, the maintainer must confirm its publication status, DOI or
archival metadata where applicable, artifact type, license/provenance, fixed
split or benchmark protocol, and whether code, checkpoints, demos, or
downstream-task scripts are actually available.
