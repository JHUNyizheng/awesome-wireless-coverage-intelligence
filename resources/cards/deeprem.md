# DeepREM

| Field | Value |
|---|---|
| URL | https://zenodo.org/records/7839447 |
| Publication category | Published resource |
| Resource type | Dataset; trained models; demo/app |
| Map target | Sparse-measurement RSRP REM |
| Dimensionality | 2D urban REM |
| Artifact support | Dataset, trained-model support, and app/demo signals are visible through the Zenodo/OpenAIRE-linked resource |
| Recommended use | Sparse-measurement REM reconstruction and artifact-maturity comparison |
| Caveat | Protocol comparability depends on the measurement sparsity, area split, and baseline configuration. |

## Protocol Checks

- Measurement sparsity and mask pattern.
- Cross-area or in-area split.
- Baseline configuration and metric implementation.
- Whether trained models are used directly or retrained.

## WCI Interpretation

DeepREM is one of the stronger examples of multi-dimensional artifact support in
this domain. It is useful for demonstrating why dataset, model, and demo support
should be audited separately.
