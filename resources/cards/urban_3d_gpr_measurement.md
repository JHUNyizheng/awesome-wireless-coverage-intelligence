# High-Efficiency Urban 3D GPR Measurement Study

| Field | Value |
|---|---|
| Identifier | DOI `10.1109/TVT.2025.3573595`; no public artifact URL verified |
| Paper | High-Efficiency Urban 3D Radio Map Estimation Based on Sparse Measurements |
| Publication category | Published IEEE Transactions on Vehicular Technology article |
| Resource type | Real-measurement study; public dataset/code/checkpoint URL not verified in the current audit |
| Map target | Urban 3D RSRP radio map |
| Dimensionality | Real UAV-measured urban 3D coverage with multiple height planes |
| Artifact support | Published real-measurement scale and protocol evidence; public reproduction artifacts remain unverified |
| Ledger record IDs | Pending integration; no public artifact record assigned |
| Availability status | `unavailable` for public data and code |
| License / version | Publisher DOI; artifact license not applicable |
| Last verified | 2026-07-18 |
| Reproduction scope | Protocol-bound measured UAV result card |
| Recommended use | Real low-altitude measurement evidence and sim-to-real calibration discussion |
| Caveat | The paper is important because it uses real UAV measurements, but it should not be treated as an open benchmark unless the measurement data, split policy, and reconstruction code become public or are supplied by the authors. |

## Protocol Checks

- Measurement area, height planes, base-station settings, and UAV trajectory.
- Wireless InSite simulation configuration and real-measurement alignment.
- GPR kernel, residual-correction strategy, and sampling-rate sweep.
- Whether the reported 2% and 20% sampling claims are computed over identical
  measurement masks and baselines.
- Dataset, code, and license availability.

## Survey Interpretation

This study complements synthetic 3D benchmarks by quantifying divergence
between ray tracing and real UAV measurements. It also shows how calibrated
measurements can reduce reconstruction error. Interpretation requires the RMSE,
measurement provenance, simulator mismatch, sampling geometry, and deployment
cost before a map estimate can support low-altitude network decisions.
