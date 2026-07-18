# Monitoring Watchlist / 资源监测清单（2026-06-06）

This watchlist records public resources that are relevant to WCI but should not
be automatically merged into the survey bibliography, benchmark tables, or
reproducibility scorecard. A watchlist item may be new, resource-first,
toolchain-oriented, preprint-first, or insufficiently aligned with the current
210-work journal-centered evidence base.

Use this page as a maintenance queue: re-open each source before a manuscript
revision, decide whether it has become publication-grade evidence, and then
update the main survey, resource tables, and validation records only when the
paper/resource linkage and artifact boundary are clear.

## Inclusion Rules

| Status | Meaning | Manuscript treatment |
|---|---|---|
| Monitor | Public source is relevant, but the publication, protocol, or artifact boundary is not yet stable enough for the cited evidence base. | Keep outside `references.bib`; mention only in freshness notes if needed. |
| Candidate | Public source appears technically central and may deserve promotion after DOI, venue, license, split, or artifact checks. | Review against `core_coding_matrix.csv`, benchmark tables, and open-source audit before adding. |
| Resource-first | Dataset/code/model is useful even when the final peer-reviewed paper is absent or pending. | Keep in companion resources; avoid using it as journal-level evidence. |
| Toolchain | Software enables WCI experiments but is not a fixed benchmark or WCI method paper. | Cite only if the manuscript makes a toolchain/deployment claim. |

## Watchlist Items

| Resource | Current public source | Status | Artifact signal | Why monitor | Promotion test |
|---|---|---|---|---|---|
| Sionna Large Radio Maps | https://github.com/NVlabs/sionna-large-radio-maps | Toolchain / resource-first | Public Python/Jupyter repository, Apache-2.0 license, large-area Sionna RT coverage-map pipeline; users provide transmitter data and generate scenes/maps locally. | It is directly relevant to city-scale coverage-map generation and deployment-scale WCI experiments, but it is currently better treated as a generation toolchain than a peer-reviewed benchmark line. | Promote only if a corresponding paper, stable dataset release, or reproducible benchmark protocol is identified. |
| Instant Radio Maps | https://github.com/NVlabs/instant-rm | Toolchain / method candidate | Public differentiable radio-map code supporting path loss, delay-spread, and angular radio-map quantities; installation requires a specific Mitsuba/Dr.Jit setup. | It connects radio maps with differentiable radiance-field/ray-tracing ideas, an important WCI construction axis, but protocol comparability and benchmark linkage need careful checking. | Promote only if the manuscript expands neural/radiance-field toolchains or if a paper-linked benchmark protocol is added. |
| Sionna RT | https://github.com/NVlabs/sionna-rt | Foundation toolchain | Stand-alone Sionna ray-tracing package, pip-installable, Apache-2.0, with TensorFlow/PyTorch/JAX interoperability. | It underpins several simulation and radio-map generation resources, but it is not itself a radio-map benchmark or CKM dataset. | Cite or score only when a WCI result depends on Sionna RT as the experimental engine. |
| BostonTwin | https://github.com/wineslab/boston_twin | Digital-twin resource candidate | Public API repository with tutorials, data folder, Dockerfile, requirements, demo notebook, and links to a Boston digital-twin dataset. | It is relevant to digital-twin and ray-tracing-ready urban coverage studies, especially real-city geometry plus antenna metadata, but it is not a radio-map accuracy benchmark by itself. | Promote when used in a WCI reproduction protocol or when a paper-linked coverage-map benchmark emerges. |
| RadioLAM | https://arxiv.org/abs/2509.11571 | Candidate / accepted-paper monitor | arXiv record reports IEEE JSAC acceptance and frames fine-grained 3D radio-map construction with ultra-low sampling rates; public code/checkpoints were not yet verified in this companion audit. | It is strongly aligned with the 3D/low-altitude WCI direction, but it should be checked for final IEEE metadata, open artifacts, splits, and reproducible metrics before changing the journal evidence base. | Promote only after DOI/final metadata and artifact availability are checked, or record explicitly as non-open-artifact evidence. |
| R2Net / 3DiRM3200 article metadata | https://github.com/lighttime2023/3DiRM3200 | Already represented; monitor metadata | Public 3DiRM3200 dataset/code repository; the article metadata should be checked against DOI `10.1109/TVT.2026.3689969` before any manuscript-facing update. | The companion already tracks 3DiRM3200, but the publication metadata should be refreshed before final submission because early-access records can change and DOI resolvers may block automated probes. | Update venue/profile and resource-card metadata after final IEEE Xplore DOI and artifact status are verified. |

## Use In The Survey Workflow

- Do not add watchlist items to `references.bib` merely because a public URL
  exists.
- If a watchlist item becomes central to an argument, first classify whether it
  is a paper, dataset, codebase, pretrained model, demo, or toolchain.
- If it is promoted into the manuscript, update `references.bib`,
  `core_coding_matrix.csv`, DOI/URL/OpenAlex evidence, the open-source audit,
  benchmark disclosure tables, Chinese draft, and the final validation package.
- If it remains unpromoted, keep it in the companion project and cite this page
  as the maintenance record rather than the formal literature evidence.

## Promotion Rule

A watchlist item can be promoted into the manuscript-facing evidence base only
after its publication status, DOI or archival metadata, artifact type,
license/provenance, split or benchmark protocol, code, checkpoints, demos, and
downstream-task scripts have been checked against the survey's coding and
validation workflow. Promotion requires synchronized updates to the manuscript,
coding matrix, BibTeX, open-source audit, benchmark disclosure table, Chinese
draft, and validation package.

## 中文说明

本页用于记录“值得继续跟踪，但不应自动加入正式 210 篇引用库”的资源。它们可能是
新出现的 GitHub 项目、数字孪生工具链、预印本、数据集优先发布资源，或者尚未确认
最终 IEEE 元数据和 artifact 支撑的候选工作。正式投稿稿件仍以经过验证的
`references.bib`、`core_coding_matrix.csv` 和自动验证报告为准；本清单只作为
伴随项目的开源生态监测队列。
