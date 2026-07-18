# Pretrained Models and Demos / 预训练模型与 Demo

Public pretrained-model support is currently the weakest artifact layer in radio-map, REM, CKM, and WCI research.

| Resource | Model/demo support | Notes |
|---|---|---|
| DeepREM | Dataset, trained models, and app support are visible through the Zenodo/OpenAIRE-linked resource | One of the stronger examples of model/demo support |
| Multi-config Radiomap Dataset | Dataset, code, pretrained checkpoints, and generation pipeline | Strong artifact stack; final publication metadata was pending in the audit |
| RadioDiff | Code is public; pretrained weights appear to require author contact | Strong code family, partial model availability |
| 3DiRM3200 / R2Net | R2Net-Outlite public; other weights require author contact | Partial model support |
| RadioMapMotion | Train/test workflow visible | No public pretrained checkpoint observed |
| CKMImageNet | Dataset visible | No code or pretrained model observed in audit |
| SpectrumNet / FDRadiomap | Dataset visible | No executable model/checkpoint package observed |

## Recommended Reporting Standard

Learning-based WCI papers should report:

- Downloadable checkpoints or a clear release constraint
- Model configuration files
- Training logs or expected reproduction ranges
- Dataset version and split files
- Preprocessing and normalization scripts
- Runtime and hardware notes
- Downstream task scripts when task utility is claimed

## 中文提示

目前数据集开放程度最好，代码次之，预训练模型和端到端 demo 最弱。未来高水平论文应把 checkpoint、配置文件、固定划分和预期复现指标作为基本 artifact。
