# 3D / Low-Altitude Benchmark Workflow

This workflow turns the survey's 3D and low-altitude WCI emphasis into a
small, auditable experiment plan. It is intended for researchers who want to
compare public radio-map, REM, CKM, or WCI resources without turning
incompatible protocols into a misleading leaderboard.

## 1. Define The Claim

Start by choosing exactly one claim level.

| Claim level | Suitable resources | Minimum evidence |
|---|---|---|
| 3D reconstruction | UrbanRadio3D, SpectrumNet, 3DiRM3200 | Error or fidelity by height, scene, or volume. |
| Low-altitude transfer | UrbanRadio3D, SpectrumNet, UAV-oriented papers | Held-out height, corridor, city, band, or route slice. |
| Dynamic freshness | RadioMapMotion and temporal REM resources | Future-time split, forecast horizon, and map-age sensitivity. |
| CKM descriptor prediction | CKMImageNet, DeepMIMO-lineage resources | Descriptor-specific metric for gain, delay, angle, LoS, or beam layer. |
| Downstream WCI utility | Beam, routing, localization, outage, ISAC, or semantic studies | Task metric tied to the reconstructed or predicted map. |

If the experiment only reports dense-grid error, describe it as radio-map,
REM, or CKM construction evidence. Reserve WCI-level language for experiments
that also expose provenance, split assumptions, freshness, uncertainty, artifact
support, or downstream utility.

## 2. Build A Protocol Ledger

Before running code, create a ledger row for the resource.

```text
resource:
paper_or_project:
publication_status:
dataset_url:
dataset_version_or_download_date:
code_url:
code_commit:
checkpoint:
map_layer:
geometry:
frequency_or_band:
height_or_altitude_range:
split:
sampling_mask:
metric:
published_value:
expected_runtime:
artifact_gaps:
```

Use `resources/reproducibility_scorecard.csv`,
`resources/publication_artifact_alignment.csv`, and
`resources/benchmark_performance_disclosure.csv` to fill the ledger. A missing
split, mask, checkpoint, or metric script is a protocol gap, not a minor
administrative detail.

## 3. Reproduce The Native Protocol

The first run should match the published protocol as closely as possible.

| Step | Decision rule |
|---|---|
| Dataset | Use the original version, scenario list, and preprocessing script when available. |
| Split | Prefer published split files. If absent, document the generated split seed and policy. |
| Mask | Preserve sparse-measurement, trajectory, road, or height masks instead of replacing them with IID pixels. |
| Checkpoint | Use a public checkpoint when available; otherwise mark the run as retraining-based. |
| Metric | Use the reported metric script or reproduce its units and aggregation rule. |

The result should be marked `matched`, `partially matched`, or `not enough
detail`. This label is as important as the numerical score because it tells
readers whether a discrepancy reflects a model issue or an artifact gap.

## 4. Add One Stress Test

After the native protocol is reproduced, add one stress test that corresponds
to the low-altitude or 3D claim.

| Stress test | When to use | Report |
|---|---|---|
| Cross-height | The paper claims height-aware or 3D generalization. | Error by held-out height and aggregate degradation. |
| Cross-city / cross-environment | The paper claims spatial transfer. | In-domain score, target-domain score, and relative degradation. |
| Cross-band | The paper claims multiband reuse. | Error by source/target frequency and any calibration samples. |
| Route-constrained | The paper motivates UAV or low-altitude corridors. | Error or outage prediction along route slices rather than dense grids only. |
| Time-forward | The paper claims dynamic or freshness-aware maps. | Forecast error versus horizon and map age. |
| Downstream task | The paper claims WCI utility. | Beam success, route reliability, localization error, outage, or semantic-task score. |

Do not add all stress tests at once. One well-documented stress test is more
useful than a broad table whose split assumptions are unclear.

## 5. Write A Result Card

Use the following card for notes, issues, or pull requests.

```text
3D / low-altitude WCI result card
- Resource:
- Claim level:
- Artifact grade:
- Native protocol alignment:
- Dataset version:
- Code commit:
- Checkpoint:
- Split/mask:
- Metric:
- Published value:
- Reproduced value:
- Stress test:
- Stress-test value:
- Main deviation:
- Missing artifact:
- WCI interpretation:
```

Suggested artifact grades:

| Grade | Meaning |
|---|---|
| A | Dataset, code, split, metric script, and checkpoint/demo are public; result matches within tolerance. |
| B | Dataset and code are public; checkpoint or preprocessing is incomplete; retraining reproduces the trend. |
| C | Dataset is public, but code, split, mask, or metric support is incomplete. |
| D | Only paper/project claims are visible; independent reproduction is not possible. |
| Resource-first | A useful open resource exists, but final peer-reviewed publication linkage is not established. |

## 6. Interpret Conservatively

Use precise wording when reporting results.

| Evidence observed | Defensible wording |
|---|---|
| Native reconstruction reproduced only | "The result supports the published reconstruction protocol." |
| Cross-height degradation measured | "The method's height transfer is bounded by the held-out height result." |
| Route-constrained error reported | "The evaluation is closer to low-altitude utility than dense-grid RMSE, but it still needs a routing or outage metric." |
| Task metric improves | "The map contributes to a downstream decision under the tested protocol." |
| Dataset only, no code/checkpoint | "The resource supports benchmarking but not full independent reproduction." |

Avoid phrases such as "state-of-the-art low-altitude WCI" unless the experiment
uses comparable splits, artifacts, and task metrics. In this repository, the
preferred comparison unit is a documented protocol, not a single best number.

## 中文说明

这个流程用于把 3D/低空无线覆盖论文的复现工作拆成可核验步骤。先确定 claim
level，再建立协议台账，然后复现原论文协议，最后只增加一个与结论对应的压力测试。
对于低空方向，推荐的压力测试包括跨高度、跨城市、跨频段、路径约束、时间前向和
下游通信任务。若只复现了密集网格 RMSE，应把结论限定为 radio-map/REM/CKM
构建证据；只有当实验同时暴露划分协议、artifact 支撑、不确定性/新鲜度或下游任务
收益时，才适合使用 WCI 级表述。
