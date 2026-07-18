# RadioMapSeer

| Field | Value |
|---|---|
| URL | https://radiomapseer.github.io/ |
| Publication category | Published benchmark |
| Resource type | Dataset; benchmark |
| Map target | Pathloss; ToA-style radio maps |
| Dimensionality | 2D urban layouts |
| Artifact support | Public dataset; project page; IEEE DataPort linkage; companion code through RadioUNet and related lines |
| Recommended use | 2D pathloss/radio-map estimation baselines and controlled protocol comparisons |
| Caveat | Strong for 2D raster-style radio-map prediction, but not evidence for 3D, low-altitude, CKM, or downstream WCI utility unless additional protocol layers are added. |

## Protocol Checks

- Transmitter/environment split.
- Building-mask and map-resolution convention.
- Whether sparse-sampling, complete-map prediction, or challenge scoring is used.
- Whether the metric is pathloss error, image fidelity, or localization-oriented utility.

## WCI Interpretation

RadioMapSeer is a field-shaping benchmark for 2D radio-map prediction. It
supports reconstruction-level claims well, but claims about WCI should additionally
report uncertainty, freshness, provenance, and downstream communication utility.

