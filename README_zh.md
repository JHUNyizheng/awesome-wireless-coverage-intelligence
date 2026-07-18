# Awesome Wireless Coverage Intelligence

这是论文

**From Radio Maps and Channel Knowledge Maps to Wireless Coverage Intelligence for 6G: Foundations, Construction, Applications, and Open Challenges**

的中英双语配套资源项目，用于汇总无线电地图、无线电环境地图（REM）、频谱制图、信道知识地图（CKM）和无线覆盖智能（WCI）相关的公开数据集、代码、预训练模型、demo 以及复现注意事项。

## 快速入口

- [数据集与基准](resources/datasets.md)
- [3D 与低空覆盖资源](resources/low_altitude_3d_coverage.md)
- [资源卡片](resources/cards/README.md)
- [代码仓库](resources/code.md)
- [预训练模型与 demo](resources/models_and_demos.md)
- [论文-artifact 对齐表](resources/publication_artifact_alignment.csv)
- [复现成熟度评分表](resources/reproducibility_scorecard.csv)
- [公开基准性能披露表](resources/benchmark_performance_disclosure.csv)
- [公开结果卡台账](resources/benchmark_result_card_ledger.md)
- [资源核查记录](resources/source_verification_20260604.md)
- [资源监测清单](resources/monitoring_watchlist_20260606.md)
- [发布闭环包](resources/publication_closure_packet_20260606.md)
- [公开链接检查报告](resources/link_check_latest.md)
- [入门教程](tutorials/getting_started_zh.md)
- [3D/低空基准复现流程](tutorials/low_altitude_benchmark_workflow.md)
- [复现协议](tutorials/reproducibility_protocol.md)
- [English README](README.md)
- [Roadmap](ROADMAP.md)

## 使用方式

1. 先确认研究任务：2D 路径损耗预测、稀疏 REM 重建、3D/低空无线覆盖、动态地图预测、CKM 构建，还是下游 WCI 通信效用。
2. 再查看复现成熟度评分表。只有公开数据但没有代码、固定划分或 checkpoint 的资源，不应被视为完整可复现。
3. 比较论文精度前，先查看公开基准性能披露表。RMSE、MAE、NMSE、SSIM、beam accuracy 和任务指标必须结合 split、采样掩膜、地图分辨率、频段、高度和任务定义解释。
4. 记录论文原始精度或本地复现实验时，使用公开结果卡台账，把数值和协议、artifact 状态绑定在一起。
5. 对 3D/低空方向，优先核查高度、轨迹、频段、城市/场景划分和下游通信任务，而不是把所有结果压缩成一个二维 RMSE 排名。
6. 本项目只提供资源索引和教程，不重新分发第三方数据集、代码或模型权重。

## 本地检查

发布或提交 pull request 前，建议运行结构检查：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_resources.ps1
```

正式公开发布或论文大修前，建议刷新公开链接检查：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_public_links.ps1
```

首次发布到 GitHub 前，可以先运行受保护的 dry-run 发布助手：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish_to_github.ps1 -DryRun -SkipPublicLinkCheck -Owner JHUNyizheng -UserName "<your name>" -UserEmail "<your email>"
```

也可以先运行发布准备度检查，生成 `resources/publication_decision_snapshot_latest.md`，用于记录当前 Git 身份、remote、GitHub CLI、release bundle SHA 以及“立即发布/手动建库/延期发布”的待办项：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_publish_readiness.ps1
```

如果暂时没有配置 GitHub remote，也可以先生成本地发布包，供维护者审阅或手动创建 GitHub 仓库：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/build_release_bundle.ps1
```

`.github/workflows/resource-check.yml` 会在 GitHub push 和 pull request 中运行结构检查与公开链接检查。由于部分公开平台会限制自动化访问，链接检查结果应作为维护信号，而不是直接等同于资源有效性评价。

## 资源类别

- **2D 无线电地图基准：** RadioMapSeer、RadioUNet、路径损耗预测挑战。
- **稀疏 REM 与频谱地图：** DeepREM 及相关稀疏测量资源。
- **3D 与低空覆盖：** SpectrumNet、UrbanRadio3D、3DiRM3200、RadioMapMotion、RadioLAM、REM-Net+、真实城市 3D GPR 等相关资源。
- **动态地图：** RadioMapMotion 和时序 REM 预测资源。
- **CKM 资源：** CKMImageNet、CKM 教程相关代码、真实 CKM 数据集。
- **开源社区监测：** GitHub、IEEE DataPort/项目主页、Zenodo/OpenAIRE、Hugging Face 和社区索引。
- **监测清单资源：** 新出现或 resource-first 的工具链/数据集候选，只进入伴随项目维护队列，不自动改变 210 篇正式稿引用库。

## 复现维度

本项目从七个维度描述资源：

- 数据集持久性
- 可执行代码
- 预训练模型或 checkpoint
- demo 或 app 支撑
- 固定划分与预处理
- 许可证与来源元数据
- 下游任务脚本

该评分不是论文质量排名，而是判断其他研究者能否获得复现、压力测试或复用所需的 artifact。

## 贡献

欢迎补充新资源。提交 issue 或 pull request 前请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)。除非许可证明确允许，请不要上传第三方数据集、模型权重或受版权保护的论文全文。

## 许可证

本仓库中的文档和资源索引采用 CC BY 4.0。第三方数据集、代码、模型、论文和项目主页仍遵循其原始许可证。
