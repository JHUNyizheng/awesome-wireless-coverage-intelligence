# UrbanRadio3D

| Field | Value |
|---|---|
| URL | https://github.com/UNIC-Lab/UrbanRadio3D |
| Publication category | Published 3D benchmark |
| Resource type | Dataset; benchmark |
| Map target | 3D urban pathloss/radio maps |
| Dimensionality | Volumetric 3D; 3D-by-3D urban coverage |
| Artifact support | Dataset folders, recommended splits, MIT license, cloud links, and RadioDiff-family code linkage |
| Ledger record IDs | `UR3D-DATA`; `UR3D-SPLIT`; related code/model: `RDIFF-CODE`, `RDIFF-MODEL` |
| Availability status | Dataset and split `open`; code `unclear-license`; weights `restricted` |
| License / version | MIT dataset; repository release and recommended splits |
| Last verified | 2026-07-18 |
| Reproduction scope | Volumetric maps, train/test partition, training, and checkpoint-assisted inference |
| Recommended use | 3D urban radio-map generation and RadioDiff-3D style benchmarking |
| Caveat | Simulator-backed volumetric evidence should not be read as real low-altitude measurement transfer without additional validation. |

## Protocol Checks

- Dataset version and cloud-link availability.
- City/environment split.
- Receiver-height convention.
- Whether 3D descriptors are input, output, or both.
- Whether evaluation is reconstruction-only or paired with a communication task.

## Survey Interpretation

UrbanRadio3D supports the transition from 2D prediction to 3D map construction.
Uncertainty, freshness, and downstream control still require explicit evaluation.
