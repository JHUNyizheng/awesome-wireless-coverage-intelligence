# UrbanRadio3D

| Field | Value |
|---|---|
| URL | https://github.com/UNIC-Lab/UrbanRadio3D |
| Publication category | Published 3D benchmark |
| Resource type | Dataset; benchmark |
| Map target | 3D urban pathloss/radio maps |
| Dimensionality | Volumetric 3D; 3D-by-3D urban coverage |
| Artifact support | Dataset folders, recommended splits, MIT license, cloud links, and RadioDiff-family code linkage |
| Recommended use | 3D urban radio-map generation and RadioDiff-3D style benchmarking |
| Caveat | Simulator-backed volumetric evidence should not be read as real low-altitude measurement transfer without additional validation. |

## Protocol Checks

- Dataset version and cloud-link availability.
- City/environment split.
- Receiver-height convention.
- Whether 3D descriptors are input, output, or both.
- Whether evaluation is reconstruction-only or paired with a communication task.

## WCI Interpretation

UrbanRadio3D is central for moving beyond 2D radio-map prediction. In WCI terms,
it supports 3D map-construction claims, while uncertainty, freshness, and
downstream control still require explicit evaluation.

