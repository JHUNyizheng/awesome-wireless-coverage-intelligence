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
| Recommended use | Real low-altitude measurement evidence and sim-to-real calibration discussion |
| Caveat | The paper is important because it uses real UAV measurements, but it should not be treated as an open benchmark unless the measurement data, split policy, and reconstruction code become public or are supplied by the authors. |

## Protocol Checks

- Measurement area, height planes, base-station settings, and UAV trajectory.
- Wireless InSite simulation configuration and real-measurement alignment.
- GPR kernel, residual-correction strategy, and sampling-rate sweep.
- Whether the reported 2% and 20% sampling claims are computed over identical
  measurement masks and baselines.
- Dataset, code, and license availability.

## WCI Interpretation

This study is a useful counterweight to synthetic 3D benchmarks because it
quantifies how ray-tracing output diverges from real UAV measurements and how
few calibrated measurements can reduce reconstruction error. For WCI, the main
lesson is not only the reported RMSE reduction, but the need to expose
measurement provenance, simulator mismatch, sampling geometry, and deployment
cost before a map-estimation result can support low-altitude network decisions.
