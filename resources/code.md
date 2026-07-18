# Code Repositories / 代码仓库

| Resource | Code support | Typical use | Caveat |
|---|---|---|---|
| RadioUNet | Strong notebooks and workflows | 2D pathloss prediction over RadioMapSeer-style data | No standalone checkpoint package observed |
| DeepMIMO | Strong Python package and scenario tooling | Standardized ray-tracing channel data generation | Dataset/toolchain rather than one WCI model |
| RadioDiff | Training/inference scripts and model-family links | Diffusion-based radio-map generation | Pretrained weights appear request-based rather than open download |
| RadioMapMotion | Dataset code, split protocol, train/test scripts | Dynamic radio-map forecasting | No public pretrained checkpoint observed in audit |
| 3DiRM3200 / R2Net | Dataset and code notebooks | Height-aware indoor 3D RME | Some weights are public; others require author contact |
| Grid-Free Radio Map Estimation | Public artifact unavailable in the 2026-06-06 link audit | Grid-free RME literature pointer | Previously recorded repository returned 404; do not count as open-code support until a replacement is verified |
| Environment_Aware_Communications | MATLAB/Python examples and ray-tracing data | CKM tutorial-lineage examples | Example-oriented, not a complete benchmark package |
| Channel-Knowledge-Map- | MATLAB simulation scripts | CKM spatial prediction simulations | Documentation and provenance are weak |
| Awesome-Radio-Map-Categorized | Public index unavailable in the 2026-06-06 link audit | Discovery pointer | Previously recorded repository returned 404; not a reproduction package |

## Minimum Reproduction Checklist

- Exact commit hash
- Environment file or dependency versions
- Dataset version and host
- Train/validation/test split
- Sampling mask generation rule
- Preprocessing and normalization
- Expected metric range
- Hardware/runtime notes

## 中文提示

如果一个仓库只提供示例代码，不能自动视为完整复现包。完整复现至少需要数据版本、固定划分、预处理流程、训练和测试脚本、环境依赖以及预期指标范围。若公开链接在发布前审计中不可达，应降级为文献线索，而不是作为数据集、代码或模型开源证据。
