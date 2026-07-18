# 3D and Low-Altitude Coverage Resources

This page tracks public resources that are especially relevant to 3D radio maps,
low-altitude coverage, height-aware CKM, dynamic coverage prediction, and
UAV-oriented WCI studies. The goal is not to merge all metrics into one
leaderboard; the goal is to make each result interpretable by its dimensionality,
split protocol, artifact support, and deployment claim.

## Why 3D / Low-Altitude Coverage Is A Separate Axis

3D and low-altitude coverage cannot be reduced to 2D raster interpolation. A
claim that is valid for a fixed 2D pathloss image may fail when receiver height,
flight corridor, building height, motion, band, weather or terrain, and
trajectory-biased sampling are changed. For WCI, a 3D/low-altitude benchmark
should therefore report not only RMSE/MAE/NMSE/SSIM, but also which map layer is
predicted, which height or trajectory split is used, and whether the result
supports a communication decision such as UAV routing, beam selection, outage
avoidance, or sensing.

For an experiment-oriented checklist, see the
[3D / low-altitude benchmark workflow](../tutorials/low_altitude_benchmark_workflow.md).

## Resource Matrix

| Resource | 3D / low-altitude relevance | Artifact support | Protocol fields to inspect | Critical caveat |
|---|---|---|---|---|
| [UrbanRadio3D](https://github.com/UNIC-Lab/UrbanRadio3D) | 3D-by-3D urban radio maps and RadioDiff-3D benchmark | Dataset folders, recommended splits, MIT license, cloud links, RadioDiff-family code links | City/environment split, 3D descriptor, receiver-height convention, cloud-access stability | Strong 3D simulator benchmark, but real low-altitude measurement transfer is not established by the dataset alone. |
| [SpectrumNet / FDRadiomap](https://github.com/ShuhangZhang/FDRadiomap) | Multiband and altitude/context-aware radio maps | Dataset distribution visible; code/checkpoint support thinner in the current audit | Frequency, terrain, altitude, climate/context labels, train/test separation | Best treated as a dataset resource unless executable baselines and checkpoints are confirmed. |
| [3DiRM3200 / R2Net](https://github.com/lighttime2023/3DiRM3200) | Indoor height-aware 3D radio maps with object-height embedding | Dataset, notebooks, one public trained model, remaining trained models by author contact | Indoor/outdoor variant, receiver-height split, model variant, training-set size | Indoor height-aware evidence should not be generalized to outdoor UAV corridors without additional validation. |
| [RadioLAM](https://github.com/liuzhiyuan-pku/RadioLAM) | Large/generative fine-grained 3D radio-map construction under ultra-sparse samples | Public implementation, requirements, train/test scripts, and SpectrumNet dataset instructions; no release/checkpoint bundle observed in this audit | SpectrumNet version, target height, sampling rate, candidate count, model/checkpoint provenance, AERPAW transfer protocol | Strong low-altitude/large-model evidence, but numerical replay depends on external data, model paths, and checkpoint provenance. |
| REM-Net+ (DOI `10.1109/TVT.2025.3623917`) | Physics-guided quantified 3D REM construction on RadioMap3DSeer | Journal result and benchmark linkage; public standalone code/checkpoint URL not verified | Reserved test split, RMSE aggregation, propagation-model feature generation, ablation protocol | Use as a journal-backed result card, not as a fully open reproduction package until executable artifacts are verified. |
| High-Efficiency Urban 3D GPR Measurement Study (DOI `10.1109/TVT.2025.3573595`) | Real UAV-measured urban 3D RSRP reconstruction and sparse-measurement calibration | Published real-measurement protocol; public dataset/code URL not verified | Measurement geometry, height planes, Wireless InSite alignment, GPR kernel, sampling-rate sweep | Valuable real low-altitude evidence, but not yet an open benchmark without public measurements and code. |
| [RadioMapMotion](https://github.com/UNIC-Lab/RadioMapMotion) | Spatio-temporal radio map sequences and future-map prediction | Dataset parts, code, fixed splits, train/test scripts, metric list | Forecast horizon, same-environment versus new-environment test, static/dynamic baseline | Closer to operational freshness than static RME, but still needs downstream control utility to substantiate WCI claims. |
| [CKMImageNet](https://github.com/zyktzCKM/CKMImageNet) | Multi-scenario CKM layers, including channel gain, delay, AOA, and AOD | Dataset folders and citation metadata; code/checkpoint support not visible in the current audit | Scenario type, city/location/area split, channel descriptor type, environmental representation | CKM metrics are not directly comparable with scalar pathloss-map metrics. |
| [Multi-config Radiomap Dataset](https://huggingface.co/datasets/lxj321/Multi-config-Radiomap-Dataset) | Multi-configuration radiomap generation and beam-map style prediction | Dataset, code, pretrained checkpoints, generation pipeline | Configuration split, band/array setting, checkpoint provenance, publication status | Strong artifact stack, but final peer-reviewed publication linkage should be checked before treating it as journal evidence. |
| [Real-world CKM-Dataset](https://github.com/ycw671/CKM-Dataset) | Partial real-world CKM release with CIR/PDP/RSS and point-cloud context | Partial dataset; release appears resource-first | Measurement environment, released subset, license/provenance, missing modalities | Important because real CKM is scarce, but the release is not yet a complete reproduction package. |

## Minimum Reporting Protocol

For a 3D/low-altitude WCI paper or reproduction, report the following fields:

| Field | Minimum disclosure |
|---|---|
| Map layer | Pathloss, RSS/RSRP/SINR, delay, angle, LoS/blockage, CKM descriptor, uncertainty, freshness, or task-action layer. |
| Geometry | 2D, 2.5D, height-aware 3D, volumetric 3D, 3D-by-3D link, or moving-source field. |
| Split | Cross-transmitter, cross-building, cross-city, cross-height, cross-trajectory, cross-band, time-forward, or new-environment split. |
| Sampling mask | Random grid, road-constrained, UAV trajectory, sparse sensor, active measurement, or measurement-report mask. |
| Metric | RMSE/MAE/NMSE/PSNR/SSIM, beam/top-k accuracy, outage/routing reliability, localization error, or semantic-task score. |
| Artifact | Dataset DOI/link, code, environment file, pretrained checkpoint, demo/app, fixed preprocessing, license, and provenance. |
| WCI claim level | Reconstruction only, transfer/generalization, freshness, uncertainty calibration, downstream utility, or deployment integration. |

## Practical Workflow

Use the resources above in the following order when planning a 3D or
low-altitude reproduction study:

1. Select one map layer and one claim level. For example, choose volumetric
   pathloss reconstruction, future map forecasting, CKM descriptor prediction,
   or outage-aware route support. Avoid mixing these claims in the first run.
2. Record artifact maturity before running code: dataset host, license,
   published paper, code commit, fixed splits, checkpoint availability, and
   metric script.
3. Reproduce the published protocol as closely as possible. If the original
   split, mask, checkpoint, or preprocessing is unavailable, mark the run as
   partially reproducible rather than failed.
4. Add one stress test matched to the 3D/low-altitude claim: cross-height,
   cross-building, cross-city, cross-band, route-constrained, or time-forward.
5. Report both the reconstruction metric and the WCI interpretation. A model
   can improve RMSE while still failing the route, beam, outage, or freshness
   requirement that motivated the map.

## Reproduction Task Templates

| Template | Minimum setup | Result to report | Interpretation boundary |
|---|---|---|---|
| Cross-height reconstruction | Train on a subset of receiver heights and test on held-out heights. | Error by height slice and aggregate error. | Supports height generalization, not necessarily UAV route utility. |
| Cross-city or cross-environment transfer | Train on one city/environment and test on another if the dataset permits. | Error by source/target domain and degradation relative to in-domain test. | Tests spatial transfer; simulator bias remains possible. |
| Route-constrained low-altitude evaluation | Evaluate only points along UAV-like corridors or altitude bands. | Error, outage prediction, or route success by corridor. | Closer to low-altitude utility than dense-grid reconstruction. |
| Time-forward freshness | Train on earlier map states and test on later states. | Forecasting error and degradation with map age. | Supports freshness claims, not static-map superiority. |
| Artifact-maturity replication | Run the published code/checkpoint/demo without modifying the model. | Reproduced metric and missing-artifact list. | Tests reproducibility support rather than algorithmic novelty. |

## Open Gaps

- Public 3D radio-map datasets are growing, but real low-altitude measurement
  datasets with stable DOI, fixed splits, and executable baselines remain scarce.
- Many 3D studies disclose reconstruction metrics without downstream utility,
  so they substantiate map estimation rather than full WCI.
- Checkpoints and demo support remain uneven; this makes it hard to reproduce
  reported accuracy without retraining assumptions.
- Indoor height-aware protocols and outdoor UAV protocols should be treated as
  different evidence classes unless cross-domain validation is reported.
- A future WCI benchmark should pair reconstruction metrics with freshness,
  uncertainty, and a communication-task metric such as outage-aware route
  success or beam-selection reliability.

## 中文说明

3D/低空覆盖不应被压缩成一个二维 RMSE 问题。复现实验前，应先核查地图层、三维表示、划分协议、采样掩膜、频段/高度、指标和 artifact 支撑。特别是，室内高度感知无线电地图、仿真城市体素地图、动态未来地图预测和真实 CKM 数据集代表不同证据类型；除非论文报告跨高度、跨场景或下游通信任务验证，否则不能把它们的精度直接横向排名。

实际使用时，建议先选择一个地图层和一个 claim level，再复现原论文协议，最后增加一个压力测试，例如跨高度、跨城市、跨频段、路径约束或时间前向划分。若原始 split、mask、checkpoint 或 metric script 缺失，应把结果标注为部分可复现，而不是把差异简单归因于模型优劣。
