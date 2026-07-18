# Benchmark Result-Card Ledger

This ledger is a template for recording published or reproduced accuracy values
on public radio-map, REM, CKM, and WCI resources. It complements
`benchmark_performance_disclosure.csv`: the CSV identifies which metric families
are disclosed, while this ledger records the protocol details needed before a
number can be compared across papers.

Do not use this file as a leaderboard. A result is useful only when the dataset,
split, sampling mask, map layer, frequency, height, metric implementation, and
artifact state are visible enough for another group to interpret or reproduce
the value.

## Minimum Result Card

```text
resource:
paper_or_project:
publication_status:
dataset_url:
dataset_version_or_download_date:
code_url:
code_commit:
checkpoint_or_model:
demo_or_notebook:
map_layer:
geometry:
frequency_or_band:
height_or_altitude_range:
split:
sampling_mask:
metric_name:
metric_unit:
published_value:
reproduced_value:
runtime_or_hardware:
artifact_grade:
protocol_alignment:
main_deviation:
missing_artifact:
wci_interpretation:
```

## Comparison Rules

| Rule | Rationale |
|---|---|
| Compare only within a benchmark line unless split, mask, and metric definitions match. | RMSE, MAE, NMSE, SSIM, beam accuracy, and forecasting errors are not interchangeable across map targets. |
| Keep 2D pathloss, sparse REM, 3D/low-altitude maps, dynamic maps, and CKM descriptors separate. | They test different map layers and expose different failure modes. |
| Record the native published value before adding stress tests. | The native protocol establishes whether the public artifact supports the original paper claim. |
| Add one stress test at a time. | Cross-height, cross-city, cross-band, route-constrained, and time-forward tests answer different questions. |
| Report artifact grade with every numerical value. | A strong number without code, fixed split, checkpoint, or metric script may be only partially reproducible. |

## Seed Rows To Fill

The following rows identify where result cards should be added first. They are
intentionally left without numerical values until the paper-specific protocol,
code commit, and metric implementation have been checked.

| Priority | Benchmark line | Representative resource | First result card to collect | Critical protocol fields |
|---|---|---|---|---|
| P1 | RadioMapSeer / pathloss challenges | RadioUNet, RadioMapSeer, pathloss challenge papers | Native pathloss or ToA metric under the published split. | transmitter split, environment split, sparse-sample setting, metric unit. |
| P1 | DeepREM | DeepREM | Sparse-measurement REM reconstruction result. | measurement sparsity, area split, RSRP generation process, baseline configuration. |
| P1 | UrbanRadio3D / RadioDiff-3D | UrbanRadio3D, RadioDiff-3D | Volumetric or height-conditioned pathloss result. | city split, receiver-height convention, 3D descriptor, dataset version. |
| P1 | SpectrumNet | SpectrumNet | Multiband or 3D reconstruction/generation result. | frequency, terrain, altitude, climate/context label, scenario split. |
| P1 | 3DiRM3200 | 3DiRM3200 / R2Net | Height-aware indoor pathloss result and parameter/speed report. | indoor scenario split, held-out height, model variant, training-set size. |
| P1 | RadioMapMotion | RadioMapMotion | Multi-step future-map forecasting result. | forecast horizon, temporal split, vehicle-trajectory generation, static baseline. |
| P1 | CKMImageNet | CKMImageNet | Descriptor-specific CKM prediction result. | descriptor type, environmental representation, scenario split, supervised/generative protocol. |
| P2 | Resource-first or monitoring resources | RadioLAM, Sionna Large Radio Maps, BostonTwin, Multi-config Radiomap Dataset | Artifact status and first reproducible protocol, if publication linkage is stable. | publication status, license/provenance, fixed split, code/checkpoint/demo availability. |

## First Extracted Native Cards

These cards summarize values extracted from the local manuscript audit. They
should be treated as protocol-bound starting points, not as cross-benchmark
rankings. Before public release, check each value against the paper table image,
the repository commit, and the metric implementation.

### RadioMap3DSeer / 2023 Pathloss Challenge

| Protocol field | Recorded value |
|---|---|
| Source | IEEE Open Journal of Signal Processing overview of the 2023 First Pathloss Radio Map Prediction Challenge |
| Dataset/protocol | RadioMap3DSeer challenge test dataset |
| Metric | $\mathrm{RMSE}_{T}$ |
| Artifact grade | C/B boundary: public challenge page and baseline code are visible, but a release-grade reproduction card still needs exact commit, preprocessing, and metric-script replay. |

| Method | Reported $\mathrm{RMSE}_{T}$ |
|---|---:|
| PPNet | 0.0507 |
| Agile (MSE) | 0.0514 |
| Agile (MSE, LOS) | 0.0461 |
| Agile (KL, LOS) | 0.0451 |
| PMNet (H/16 x W/16, with fine tuning) | 0.0959 |
| PMNet (H/16 x W/16) | 0.0633 |
| PMNet (H/8 x W/8) | 0.0383 |

Indoor-pathloss challenge context: the ICASSP 2025 indoor challenge overview
reports top-ten weighted RMSE values from 9.41 to 14.47 dB under three
generalization tasks. This is useful protocol context, but this ledger keeps it
separate from the journal-centered RadioMap3DSeer result card.

### REM-Net+ / RadioMap3DSeer Competition Test Set

| Protocol field | Recorded value |
|---|---|
| Source | IEEE TVT 2026 REM-Net+ article |
| Dataset/protocol | Reserved RadioMap3DSeer competition test set from Istanbul |
| Metric | RMSE |
| Artifact grade | C/B boundary: code is reported as released, but commit, preprocessing, metric script, and checkpoint status still need release-grade replay. |

| Method | Reported RMSE |
|---|---:|
| PPNet | 0.0507 |
| Agile (MSE) | 0.0514 |
| Agile (MSE, LOS) | 0.0461 |
| Agile (KL, LOS) | 0.0451 |
| PMNet (with fine tuning) | 0.0959 |
| PMNet (with data augmentation) | 0.0633 |
| PMNet (H/8 x W/8) | 0.0383 |
| REM-Net | 0.0374 |
| REM-Net+ | 0.0349 |

### RadioLAM / SpectrumNet and AERPAW

| Protocol field | Recorded value |
|---|---|
| Source | IEEE JSAC 2026 RadioLAM article |
| Synthetic protocol | SpectrumNet, 3.5 GHz, target heights 1.5 m / 30 m / 200 m, 0.1% sampling |
| Split | 6327 training maps and 1590 test maps |
| Real-measurement protocol | AERPAW Dataset-22 zero-shot evaluation with 781 preprocessed grid samples |
| Artifact grade | C/B boundary: data and code URL are visible, but model checkpoint, exact environment, and long-term DOI archival need verification. |

RadioLAM MSE from the averaged SpectrumNet Table III protocol:

| Environment | 1.5 m | 30 m | 200 m |
|---|---:|---:|---:|
| Suburban | 0.0224 | 0.0108 | 0.0013 |
| Dense urban | 0.0153 | 0.0193 | 0.0030 |
| Rural | 0.0249 | 0.0123 | 0.0019 |
| Ordinary urban | 0.0165 | 0.0182 | 0.0056 |

RadioLAM zero-shot AERPAW values:

| Input samples | MSE | MAE |
|---:|---:|---:|
| 25 | 0.0176 | 0.1092 |
| 50 | 0.0146 | 0.0978 |
| 75 | 0.0150 | 0.0995 |

### High-Efficiency Urban 3D GPR / Real UAV Measurements

| Protocol field | Recorded value |
|---|---|
| Source | IEEE TVT 2025 high-efficiency urban 3D radio-map estimation article |
| Data source | UAV-collected urban 3D RSRP measurements |
| Scale | More than 4.2 million m3 and more than 4000 data points |
| Simulation prior | Wireless InSite with OpenStreetMap-based 3D buildings |
| Key checked values | Wireless InSite mismatch 24.57 dB RMSE; best kernel 7.9286 dB RMSE; online/offline GPR reaches 10 dB RMSE with 2% UAV measurements; at 20% sampling the proposed schemes are at least 2.5 dB lower than listed baselines. |
| Artifact grade | D/C boundary: useful paper-level real-measurement evidence, but public data/code availability and fixed replay protocol still need verification. |

### 3DiRM3200 / R2Net

| Protocol field | Recorded value |
|---|---|
| Dataset | 3DiRM3200 indoor 3D radio maps |
| Scale | 3,200 samples over 200 indoor scenes |
| Receiver grid | 16 x 256 x 256 receiver locations |
| Split | 2,560 train, 320 validation, 320 test |
| Frequency and power | 5.9 GHz, 10 MHz bandwidth, 23 dBm transmit power |
| Artifact grade | C/B boundary: dataset and code are visible; model support is partial and should be rechecked by commit before reproduction. |

| Method | NMSE | RMSE | SSIM | PSNR | Params | MACs | Inference time per km2 |
|---|---:|---:|---:|---:|---:|---:|---:|
| RadioUNet | 0.0292 | 0.0471 | 0.8883 | 29.54 | 13M | 25.8G | 74.80 s |
| FadeNet | 0.0583 | 0.0604 | 0.7723 | 26.25 | 65M | 51.7G | 84.15 s |
| RadioTrans | 0.0714 | 0.0680 | 0.7228 | 25.44 | 55M | 18.7G | 65.45 s |
| PPNet | 0.1433 | 0.0935 | 0.5746 | 21.82 | 15M | 34.7G | 84.15 s |
| R2Net-In | 0.0268 | 0.0395 | 0.8908 | 29.65 | 8M | 6.5G | 46.75 s |

### RadioMapSeer Protocol Reported by R2Net

| Method | NMSE | RMSE | SSIM | PSNR | Params | MACs | Inference time |
|---|---:|---:|---:|---:|---:|---:|---:|
| RadioUNet | 0.0106 | 0.0202 | 0.9202 | 34.43 | 13M | 23.5G | 0.1190 s |
| FadeNet | 0.0142 | 0.0240 | 0.9023 | 32.83 | 65M | 49.1G | 0.1450 s |
| RadioTrans | 0.0101 | 0.0196 | 0.9267 | 34.57 | 55M | 18.7G | 0.1053 s |
| PPNet | 0.0986 | 0.0647 | 0.7417 | 24.39 | 15M | 34.0G | 0.0778 s |
| R2Net-Out | 0.0046 | 0.0156 | 0.9491 | 37.00 | 85M | 161.0G | 0.2136 s |
| R2Net-Outlite | 0.0059 | 0.0178 | 0.9403 | 35.92 | 4M | 13.8G | 0.1328 s |

### RadioMapMotion and SpectrumNet Extraction Status

| Benchmark line | Extracted from paper | Values to verify before release |
|---|---|---|
| RadioMapMotion | 30,000 sequences; 450,000 maps; NMSE/RMSE/SSIM/PSNR; Table III and Table IV visually checked. | Additional horizon-by-horizon plots and context-length ablations, if the companion later wants frame-level cards. |
| SpectrumNet | More than 300,000 images; 11 terrain scenarios; 3 climate scenarios; 5 frequencies; 3 height levels; Tables IV-VI and diagnostic values from Tables VII-XII visually checked. | Full table-by-table reproduction cards only if the companion later needs a SpectrumNet-specific benchmark notebook. |

RadioMapMotion native Table III values for context length 10 and prediction
horizon 5:

| Test setting | Method | NMSE | RMSE | SSIM | PSNR |
|---|---|---:|---:|---:|---:|
| Test Set 1 | Last-Frame Repeat | 0.009517 | 0.029257 | 0.9421 | 30.6755 |
| Test Set 1 | Static-UNet | 0.002751 | 0.015731 | 0.9700 | 36.0648 |
| Test Set 1 | ConvMambaUNet | 0.004300 | 0.019666 | 0.9656 | 34.5753 |
| Test Set 1 | RadioMotionNet | 0.002562 | 0.015181 | 0.9779 | 36.3742 |
| Test Set 2 | Last-Frame Repeat | 0.007519 | 0.028530 | 0.9460 | 30.8941 |
| Test Set 2 | Static-UNet | 0.011265 | 0.034921 | 0.9338 | 29.1382 |
| Test Set 2 | ConvMambaUNet | 0.004553 | 0.022201 | 0.9609 | 33.0726 |
| Test Set 2 | RadioMotionNet | 0.002121 | 0.015154 | 0.9800 | 36.3894 |

SpectrumNet core checked values:

| Protocol axis | Best or most diagnostic checked value | WCI interpretation |
|---|---|---|
| Terrain scenario | Ocean produces much stronger scores than dense urban or forest under several models, e.g. CBAM SSIM 0.848 and RMSE 0.031 on Ocean versus SSIM 0.603 and RMSE 0.101 on Dense urban. | Terrain and obstruction structure change the difficulty of map generation. |
| Height | For CBAM, RMSE improves from 0.117 at 1.5 m to 0.043 at 200 m; Swin-unet reaches RMSE 0.042 at 200 m. | Height is not a cosmetic metadata field; it changes propagation-map complexity. |
| Frequency | CBAM has RMSE 0.107 at 150 MHz and 0.076 at 22 GHz, while SSIM drops from 0.740 to 0.637. | A single metric can tell a partial story; frequency effects should be reported with multiple metrics. |
| Cross-terrain generalization | CBAM trained on Mountainous data reports SSIM/RMSE 0.681/0.090 on Mountainous but 0.478/0.176 on Dense urban. | Terrain-domain transfer is not equivalent to building/urban-domain transfer. |
| Cross-frequency generalization | CBAM trained at 150 MHz reports SSIM 0.458 at 22 GHz, while CBAM trained at 22 GHz reports SSIM 0.637 at 22 GHz. | Training-band choice materially changes high-band reconstruction. |
| Complexity | UNet: 1.28G FLOP, 0.22M parameters, 0.06s; CBAM: 1.29G, 0.23M, 0.08s; Swin-unet: 2.02G, 27.2M, 0.08s. | A benchmark card should record cost next to accuracy. |

## Artifact Grades

| Grade | Meaning |
|---|---|
| A | Dataset, code, fixed split or mask, metric script, and checkpoint/demo are public; reproduced value matches the native claim within a stated tolerance. |
| B | Dataset and code are public; checkpoint, preprocessing, or metric script is incomplete, but retraining reproduces the reported trend. |
| C | Dataset is public, but code, split, mask, checkpoint, or metric support is incomplete. |
| D | Only paper or project claims are visible; independent reproduction is not currently possible. |
| Resource-first | Useful public artifact exists, but final peer-reviewed publication linkage or benchmark protocol remains unstable. |

## Chinese Note

本文件用于记录公开数据集上的论文原始精度和复现精度，但它不是排行榜。每个数值必须同时记录数据集版本、划分协议、采样掩膜、地图层、频段、高度、指标脚本和 artifact 等级。若这些条件不一致，RMSE、MAE、NMSE、SSIM、beam accuracy 或预测误差不能直接横向比较。
