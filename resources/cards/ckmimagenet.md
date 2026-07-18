# CKMImageNet

| Field | Value |
|---|---|
| URL | https://github.com/zyktzCKM/CKMImageNet |
| Publication category | Published CKM dataset line |
| Resource type | Dataset |
| Map target | Channel gain; delay; AOA; AOD; environmental representations |
| Dimensionality | CKM; multi-scenario; environment-conditioned channel descriptors |
| Artifact support | Dataset and scenario folders visible; code/checkpoint support is limited in the audited public page |
| Ledger record IDs | `CKMI-DATA`; `CKMI-CODE` |
| Availability status | Dataset `unclear-license`; training code `unavailable` |
| License / version | License not recorded; scenario folders |
| Last verified | 2026-07-18 |
| Reproduction scope | Gain, delay, AOA, and AOD map data |
| Recommended use | CKM dataset inspection and channel-descriptor prediction protocol design |
| Caveat | CKM scores are not directly comparable with scalar pathloss-map RMSE because target layers and channel descriptors differ. |

## Protocol Checks

- Channel descriptor type.
- Scenario or environment split.
- Coordinate and representation convention.
- Whether the method is supervised, unsupervised, generative, or retrieval-based.
- Whether code and metric scripts are public.

## Survey Interpretation

CKMImageNet is important because it shifts benchmark design from scalar coverage
maps toward channel-knowledge layers. It shows that evaluation
must identify the map layer before comparing metrics.
