# Contributing

Thank you for helping maintain this WCI resource index.

## What To Submit

Please include:

- Resource name
- URL
- Related paper or preprint, if any
- Resource type: dataset, code, model, demo, tutorial, or index
- Publication category: published, foundation-toolchain, preprint, resource-first, community-index, or unknown
- Map target: radio map, REM, spectrum map, CKM, or WCI
- Dimensionality: 2D, 3D, multiband, dynamic, low-altitude, indoor, or outdoor
- Artifact support: data, code, checkpoints, demo/app, fixed splits, license/provenance, downstream task scripts
- Known limitations and recommended use

## What Not To Submit

Do not upload:

- Third-party datasets unless redistribution is explicitly permitted
- Model weights unless redistribution is explicitly permitted
- Copyrighted paper text or extracted full-text files
- Private author metadata or reviewer correspondence

## Review Criteria

Resources are accepted when they are relevant to radio maps, REMs, spectrum cartography, CKMs, or WCI and when the artifact status can be described clearly. A resource can be useful even if it is incomplete; incomplete resources should be labeled honestly rather than excluded silently.

Before submitting a pull request, run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_resources.ps1
```

## 中文说明

提交新资源时，请尽量说明资源名称、链接、对应论文、资源类型、发表状态、地图目标、维度、artifact 支撑情况、推荐用途和已知局限。请不要上传第三方数据集、模型权重或论文全文，除非许可证明确允许重新分发。
