# Reproducibility Protocol

Use this protocol before claiming that a radio-map, REM, CKM, or WCI result is
reproduced. The protocol is deliberately stricter than "the code runs" because
WCI results depend on dataset splits, sampling masks, metrics, provenance, and
downstream task definitions.

## 1. Identify The Claim Level

| Claim level | What must be reproduced |
|---|---|
| Reconstruction | Same dataset, split, mask, metric, and map target. |
| Generalization | Held-out transmitter, building, city, height, band, scenario, or environment split. |
| Dynamic / freshness | Forecast horizon, map age, temporal split, and static baseline. |
| CKM | Same channel descriptor, scenario, coordinate system, and environmental representation. |
| Downstream WCI | Communication-task metric such as beam success, route reliability, outage, localization, or semantic utility. |

## 2. Check Artifact Availability

Before running experiments, record:

- Dataset URL, DOI, version, and license.
- Code URL and commit hash.
- Environment file or dependency list.
- Pretrained checkpoint availability.
- Demo/app availability.
- Fixed split and preprocessing scripts.
- Metric implementation and reporting unit.
- Hardware assumptions and random seeds.

## 3. Reconstruct The Original Protocol

Do not start by changing models. First reconstruct the published protocol:

```text
resource:
paper_or_project:
dataset_version:
code_commit:
map_target:
split:
sampling_mask:
metric:
checkpoint:
expected_result:
observed_result:
deviation:
reason:
```

If a paper reports only an aggregate score without split or mask details, mark
the result as partially reproducible rather than failed.

Before interpreting the number, cross-check the row in
`resources/benchmark_performance_disclosure.csv`. A reproduced RMSE or SSIM
value is not enough by itself; the claim should also state whether the protocol
uses a random sparse grid, a held-out transmitter, a held-out city, a
cross-height split, a future-time split, or a downstream communication task.

## 4. Stress-Test The Claim

After reproducing the baseline protocol, run at least one stress test matched to
the paper's claim:

| Claimed property | Stress test |
|---|---|
| 3D robustness | Cross-height or cross-building split. |
| Low-altitude utility | Route-constrained or altitude-sliced evaluation. |
| Transferability | Cross-city, cross-frequency, or new-environment test. |
| Freshness | Time-forward split and map-age sensitivity. |
| Uncertainty | Calibration curve, coverage probability, or risk-conditioned error. |
| Downstream utility | Beam, routing, localization, outage, or semantic-task metric. |

## 5. Apply The Network-Utility Gate

A low reconstruction error is not yet a WCI result. Before upgrading a result
from radio-map reconstruction or CKM construction to WCI evidence, record the
decision that consumes the map and the failure that the map is meant to avoid:

| Decision family | Utility evidence to seek | Failure to inspect |
|---|---|---|
| Coverage planning | outage reduction, coverage repair cost, handover risk | over/under-coverage caused by stale or simulated maps |
| Beam/RIS/CSI | beam hit rate, pilot reduction, throughput, search cost | wrong beam subspace or stale channel prior |
| UAV / low altitude | route reliability, energy, outage probability, sensing cost | unsafe route or altitude-specific coverage hole |
| Localization / ISAC | positioning error, source-localization success, sensing gain | NLoS bias or inconsistent radio/environment map |
| Semantic tasks | semantic accuracy, protection gain, semantic outage | protecting the wrong samples under channel risk |

## 6. Report A Reproduction Card

Use this compact format in notes, issues, or pull requests:

```text
Reproduction card
- Resource:
- Claim level:
- Dataset/link/version:
- Code/link/commit:
- Checkpoint:
- Split/mask:
- Metric:
- Published value:
- Reproduced value:
- Protocol alignment:
- Stress test:
- Artifact grade:
- Hardware/runtime:
- Blocking gaps:
- WCI interpretation:
```

Suggested `Protocol alignment` values are `matched`, `partially matched`,
`changed split`, `changed mask`, `changed metric`, `changed checkpoint`, and
`not enough detail`. Suggested `Stress test` values include `cross-height`,
`cross-city`, `cross-band`, `time-forward`, `route-constrained`,
`uncertainty calibration`, and `downstream task`.

## 7. Decide The Evidence Grade

| Grade | Meaning |
|---|---|
| A | Dataset, code, fixed split, metric implementation, and checkpoint/demo are public; result reproduced within tolerance. |
| B | Dataset and code are public; checkpoint or preprocessing detail is missing; retraining reproduces the trend. |
| C | Dataset is public but code, splits, or metric implementation are incomplete. |
| D | Only a project page or paper result is visible; no independent reproduction is possible. |
| Resource-first | Useful artifact exists, but final peer-reviewed publication linkage is not yet established. |

## 中文说明

复现 WCI 论文时，不要只问“代码是否开源”。更关键的问题是：数据集是否稳定、划分是否固定、采样掩膜是否公开、指标是否一致、checkpoint 是否可获得、是否有 demo 或下游任务脚本。若缺少 split、mask 或 metric 细节，应将结果标注为“部分可复现”，而不是强行认定为同等可比的精度结果。

对于 3D 或低空覆盖论文，还应单独记录高度、轨迹、频段、城市/场景和时间划分。只有当复现实验进一步检验跨高度、跨城市、跨频段、未来时间或下游通信任务时，才适合把结论提升为 WCI 级证据；否则它更准确地属于 radio-map reconstruction 或 CKM construction 证据。
