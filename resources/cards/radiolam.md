# RadioLAM

| Field | Value |
|---|---|
| URL | https://github.com/liuzhiyuan-pku/RadioLAM |
| Paper | A Fine-Grained 3D Radio Map Construction Paradigm With Ultra-Low Sampling Rates by Large Generative Models |
| Publication category | Published IEEE JSAC article; arXiv record reports IEEE JSAC acceptance and the GitHub README lists DOI `10.1109/JSAC.2026.3677149` |
| Resource type | Code; external dataset dependency; no release archive observed in the public GitHub page |
| Map target | Fine-grained 3D radio-map construction at target receiver heights |
| Dimensionality | 3D region with 2D target-height radio maps; low-altitude/UAV-relevant evaluation |
| Artifact support | Public Python implementation, requirements file, training and inference scripts, and SpectrumNet dataset instructions |
| Ledger record IDs | Pending integration; no manuscript-ledger record assigned |
| Availability status | `restricted` pending checkpoint and dependency provenance |
| License / version | License and immutable release not recorded |
| Last verified | 2026-07-18 |
| Reproduction scope | Public training/inference code with external data and model dependencies |
| Recommended use | Ultra-sparse 3D radio-map construction, low-altitude benchmark protocol study, and large/generative-model artifact audit |
| Caveat | The repository requires external SpectrumNet data and local model-path configuration; no public release package or checkpoint bundle was observed in the current audit, so numerical replay still needs commit, dataset version, preprocessing, and checkpoint provenance. |

## Protocol Checks

- SpectrumNet dataset version, scenario subset, and bad-data removal procedure.
- Target frequency and height, especially 3.5 GHz and 1.5/30/200 m settings.
- Sampling rate and sparse-sensor placement policy.
- Candidate-generation count, model size, and MoE/router configuration.
- Whether the reported run uses public checkpoints, local retraining, or author-provided weights.
- AERPAW or other real-measurement transfer protocol, including sample count and normalization.

## Survey Interpretation

RadioLAM is a public-code example connecting large/generative radio-map models
with 3D and low-altitude coverage claims. A complete result card records
MSE/MAE/PSNR, the SpectrumNet or AERPAW split, target height, sample count,
model/checkpoint provenance, and candidate-generation cost. A low pixel error
without these fields remains a protocol-specific reconstruction result and does
not establish deployment readiness.
