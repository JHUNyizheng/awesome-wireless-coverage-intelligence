# RadioMapMotion

| Field | Value |
|---|---|
| URL | https://github.com/UNIC-Lab/RadioMapMotion |
| Publication category | Published dynamic benchmark |
| Resource type | Dataset; code |
| Map target | Future radio-map sequences |
| Dimensionality | Dynamic; spatio-temporal; trajectory-influenced maps |
| Artifact support | Dataset parts, code, fixed splits, training/testing scripts, and metric definitions |
| Ledger record IDs | `RMM-DATA`; `RMM-CODE`; `RMM-PROTO` |
| Availability status | `unclear-license` |
| License / version | License not recorded; repository parts and documented split |
| Last verified | 2026-07-18 |
| Reproduction scope | Dynamic map training, testing, split, and forecast horizon |
| Recommended use | Dynamic radio-map forecasting and freshness-aware WCI studies |
| Caveat | Forecasting metrics should be tied to map age and downstream decision utility before being interpreted as operational WCI evidence. |

## Protocol Checks

- Forecast horizon.
- Same-environment or new-environment test.
- Static versus dynamic baseline.
- Whether vehicle trajectories are part of the input, target, or simulation process.

## Survey Interpretation

RadioMapMotion is valuable because it makes time a benchmark variable. It is a
natural bridge from static reconstruction to freshness-aware map services when
forecasting errors are connected to communication decisions.
