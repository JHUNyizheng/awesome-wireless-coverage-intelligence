# Getting Started

This tutorial helps you choose and use public resources for wireless coverage
intelligence (WCI) research. It is written for researchers who want to run a
small, defensible reproduction study before making broader claims about radio
maps, radio environment maps (REMs), spectrum cartography, channel knowledge
maps (CKMs), or 3D low-altitude coverage.

## 1. Start From The Research Question

Choose the task before choosing the dataset. Many reported results are not
comparable because they answer different questions.

| Task | First resources to inspect | Main protocol risk |
|---|---|---|
| 2D pathloss prediction | RadioMapSeer, RadioUNet, pathloss prediction challenge papers | Random pixel splits can be much easier than held-out transmitters or environments. |
| Sparse REM reconstruction | DeepREM and sparse-measurement REM papers | Measurement mask, sparsity, and area split often dominate the reported error. |
| 3D or low-altitude coverage | SpectrumNet, UrbanRadio3D, 3DiRM3200, RadioMapMotion, low-altitude WCI papers | Height, trajectory, band, and simulator-to-real transfer must be reported. |
| Dynamic map forecasting | RadioMapMotion and temporal spectrum-cartography papers | Forecast horizon and temporal split must be explicit. |
| CKM construction | CKMImageNet, DeepMIMO-lineage resources, CKM tutorial repositories | Channel descriptor, coordinate system, and scenario split must match the claim. |
| Downstream WCI utility | Beam, routing, localization, outage, ISAC, or semantic-communication studies | Reconstruction accuracy alone does not prove communication utility. |

## 2. Build An Artifact Ledger

Before downloading data or running code, record the artifact state. Use
`resources/reproducibility_scorecard.csv` and
`resources/publication_artifact_alignment.csv` as the first-pass checklist.

| Artifact layer | Minimum question |
|---|---|
| Dataset | Is the dataset public, versioned, DOI-backed, or at least stable enough to cite? |
| Code | Are training, inference, and evaluation scripts available with dependencies? |
| Pretrained model | Are checkpoints or model cards downloadable without author contact? |
| Demo/app | Is there a runnable demo, app, or notebook that exercises the method? |
| Split/mask | Are train/test split files, sampling masks, and preprocessing steps fixed? |
| License/provenance | Are license, scenario, geometry, frequency, and environment metadata stated? |
| Downstream task | Are beam, routing, localization, outage, or other task scripts provided when task utility is claimed? |

Do not label a result "fully reproducible" only because a dataset is public.
For WCI, the weak layer is often the checkpoint, split, metric script, or
downstream-task workflow rather than the raw dataset.

## 3. Align The Benchmark Protocol

Read `resources/benchmark_performance_disclosure.csv` before comparing accuracy.
RMSE, MAE, NMSE, SSIM, PSNR, beam accuracy, localization error, and forecasting
error are meaningful only with the corresponding protocol.

For each paper or resource, write down:

- Map target: pathloss, RSS/RSRP/SINR, delay, angle, LoS/blockage, beam index,
  uncertainty, freshness, or task-action layer.
- Geometry: 2D, 2.5D, height-aware 3D, volumetric 3D, 3D-by-3D link, or moving
  source/receiver field.
- Split: random pixel, transmitter, building, city, height, trajectory, band,
  scenario, or time-forward split.
- Sampling mask: random grid, sparse sensors, road-constrained samples, UAV
  trajectory, active measurement policy, or measurement-report traces.
- Metric unit: dB error, normalized error, image similarity, top-k beam accuracy,
  outage/routing success, localization error, or task utility.

Never collapse incompatible protocols into a single leaderboard. A lower error
on a random sparse-pixel split is not necessarily better evidence than a higher
error on a held-out city, held-out height, or future-time split.

## 4. Run A Minimal Reproduction

Start with a small reproduction card rather than a full benchmark suite.

```text
Resource:
Paper/project:
Dataset version or download date:
Code commit:
Environment:
Map target:
Split/mask:
Metric:
Checkpoint:
Published value:
Observed value:
Deviation:
Blocking gaps:
WCI interpretation:
```

The first run should reconstruct the original protocol as closely as possible.
Only after that should you change architectures, sampling masks, or data splits.

## 5. Stress-Test 3D And Low-Altitude Claims

For 3D or low-altitude coverage, add at least one stress test:

| Claim | Suggested stress test |
|---|---|
| Height-aware reconstruction | Cross-height or held-out receiver-height split. |
| Urban 3D generalization | Held-out building, city, or environment split. |
| Low-altitude utility | Route-constrained or corridor-sliced evaluation. |
| Dynamic freshness | Future-time split and map-age sensitivity. |
| Band transfer | Cross-frequency or multiband transfer split. |
| Downstream decision support | Outage-aware routing, beam success, localization, or ISAC metric. |

If a resource supports only reconstruction metrics, describe it as radio-map or
CKM evidence, not as complete WCI evidence.

## 6. Report And Cite Carefully

When publishing notes, issues, or pull requests:

- Cite the original dataset, code repository, and paper.
- State whether the resource is peer-reviewed, preprint-linked, resource-first,
  or a community index.
- Separate dataset availability from code, checkpoint, demo, split, license, and
  downstream-task availability.
- Report failed or partial reproduction attempts; they are useful if they expose
  missing splits, masks, checkpoints, or metric definitions.

This repository is an index and tutorial. It does not redistribute third-party
datasets, model weights, code, or paper text unless the original license permits
redistribution.
