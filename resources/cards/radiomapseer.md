# RadioMapSeer

| Field | Value |
|---|---|
| URL | https://radiomapseer.github.io/ |
| Publication category | Published benchmark |
| Resource type | Dataset; benchmark |
| Map target | Pathloss; ToA-style radio maps |
| Dimensionality | 2D urban layouts |
| Artifact support | Public dataset; project page; IEEE DataPort linkage; companion code through RadioUNet and related lines |
| Ledger record IDs | `RMSEER-DATA`; related code: `RUNET-CODE` |
| Availability status | `unclear-license` |
| License / version | License not recorded; project-page version |
| Last verified | 2026-07-18 |
| Reproduction scope | 2D pathloss maps and related reconstruction notebooks |
| Recommended use | 2D pathloss/radio-map estimation baselines and controlled protocol comparisons |
| Caveat | Strong for 2D raster-style radio-map prediction, but not evidence for 3D, low-altitude, CKM, or downstream WCI utility unless additional protocol layers are added. |

## Protocol Checks

- Transmitter/environment split.
- Building-mask and map-resolution convention.
- Whether sparse-sampling, complete-map prediction, or challenge scoring is used.
- Whether the metric is pathloss error, image fidelity, or localization-oriented utility.

## Survey Interpretation

RadioMapSeer is a field-shaping benchmark for 2D radio-map prediction. It
supports reconstruction-level claims. Broader network claims should also report
uncertainty, freshness, provenance, and downstream communication utility.
