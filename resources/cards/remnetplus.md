# REM-Net+

| Field | Value |
|---|---|
| Identifier | DOI `10.1109/TVT.2025.3623917`; no public artifact URL verified |
| Paper | REM-Net+: Quantified 3D Radio Environment Map Construction Guided by Radio Propagation Model |
| Publication category | Published IEEE Transactions on Vehicular Technology article |
| Resource type | Paper-linked result card; public standalone code/checkpoint URL not verified in the current audit |
| Map target | 3D pathloss / radio environment map construction |
| Dimensionality | Height-aware 3D REM over the RadioMap3DSeer challenge protocol |
| Artifact support | Published numerical protocol and RadioMap3DSeer benchmark linkage; independent replay still needs code, preprocessing, split, metric script, and checkpoint evidence |
| Ledger record IDs | Pending integration; no public artifact record assigned |
| Availability status | `unavailable` for executable reproduction artifacts |
| License / version | Publisher DOI; implementation license not applicable |
| Last verified | 2026-07-18 |
| Reproduction scope | Protocol-bound published result only |
| Recommended use | Journal-backed RadioMap3DSeer result comparison and physics-guided 3D REM taxonomy evidence |
| Caveat | Treat the reported 0.0349 RMSE as a protocol-bound published value, not as a fully reproduced open-source result, until executable artifacts and exact commit-level provenance are verified. |

## Protocol Checks

- RadioMap3DSeer reserved competition-test split and Istanbul scenario details.
- Whether building pixels, receiver-area masks, and tensor-level aggregation match the reported RMSE definition.
- Propagation-model feature generation and least-squares parameter-estimation settings.
- REM-Net versus REM-Net+ ablation protocol.
- Code, metric implementation, checkpoint, and preprocessing release status.

## Survey Interpretation

REM-Net+ is valuable for the survey because it demonstrates how a learned 3D
REM estimator can be constrained by propagation-model structure. Its current
open-source value is more limited: the article supplies a strong journal result
card. Reproducibility claims remain conditional until the
training, checkpoint, and metric pipeline can be replayed independently.
