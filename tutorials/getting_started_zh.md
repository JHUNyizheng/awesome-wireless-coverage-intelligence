# 入门教程

本教程用于帮助研究者选择和使用无线覆盖智能（WCI）相关公开资源。它的目标不是给不同论文做简单排行榜，而是帮助你在复现前先判断：数据集、代码、预训练模型、demo、固定划分、指标脚本和下游任务是否足以支撑论文中的结论。

## 1. 先确定研究问题

先选任务，再选数据集。许多论文的精度不能直接比较，因为它们解决的问题、划分协议和地图层并不相同。

| 任务 | 优先查看的资源 | 主要协议风险 |
|---|---|---|
| 2D 路径损耗预测 | RadioMapSeer、RadioUNet、路径损耗预测挑战论文 | 随机像素划分通常比跨发射机或跨环境划分容易。 |
| 稀疏 REM 重建 | DeepREM 和稀疏测量 REM 论文 | 测量掩膜、稀疏率和区域划分会显著影响误差。 |
| 3D 或低空覆盖 | SpectrumNet、UrbanRadio3D、3DiRM3200、RadioMapMotion、低空 WCI 论文 | 高度、轨迹、频段和仿真到真实迁移必须单独说明。 |
| 动态地图预测 | RadioMapMotion 和时序频谱制图论文 | 预测时域和时间划分必须明确。 |
| CKM 构建 | CKMImageNet、DeepMIMO 相关资源、CKM 教程仓库 | 信道描述符、坐标系统和场景划分必须与论文结论一致。 |
| 下游 WCI 效用 | 波束、路径规划、定位、中断率、ISAC 或语义通信研究 | 单纯重建精度不能证明通信决策效用。 |

## 2. 建立 Artifact 台账

下载数据或运行代码前，先记录 artifact 状态。可以把 `resources/reproducibility_scorecard.csv` 和 `resources/publication_artifact_alignment.csv` 当作第一轮检查清单。

| Artifact 层 | 最低检查问题 |
|---|---|
| 数据集 | 是否公开、版本化、带 DOI，或至少具备稳定可引用入口？ |
| 代码 | 是否提供训练、推理、评估脚本和依赖说明？ |
| 预训练模型 | checkpoint 或模型卡是否可以直接下载，而不是只能联系作者？ |
| demo/app | 是否有可运行 demo、app 或 notebook？ |
| split/mask | 训练/测试划分、采样掩膜和预处理步骤是否固定？ |
| 许可证/来源 | 许可证、场景、几何、频段和环境元数据是否清楚？ |
| 下游任务 | 若论文声称任务效用，是否提供波束、路径规划、定位、中断率等任务脚本？ |

不要因为数据集公开就把论文称为“完全可复现”。在 WCI 中，真正薄弱的环节常常是 checkpoint、划分文件、指标脚本或下游任务流程。

## 3. 对齐基准协议

比较精度前，先阅读 `resources/benchmark_performance_disclosure.csv`。RMSE、MAE、NMSE、SSIM、PSNR、beam accuracy、定位误差和预测误差只有在协议一致时才有可比意义。

每篇论文或每个资源至少记录：

- 地图目标：pathloss、RSS/RSRP/SINR、delay、angle、LoS/blockage、beam index、不确定性、新鲜度或 task-action layer。
- 几何形态：2D、2.5D、高度感知 3D、体素化 3D、3D-by-3D 链路，或移动源/接收机无线场。
- 划分协议：随机像素、发射机、建筑、城市、高度、轨迹、频段、场景或时间前向划分。
- 采样掩膜：随机网格、稀疏传感器、道路约束采样、UAV 轨迹、主动测量策略或测量报告轨迹。
- 指标单位：dB 误差、归一化误差、图像相似度、top-k 波束准确率、中断/路由成功率、定位误差或任务效用。

不要把不兼容协议压缩成单一排行榜。随机稀疏像素上的低误差，不一定比跨城市、跨高度或未来时间划分上的较高误差更有说服力。

## 4. 先做最小复现实验

建议先写一个小型 reproduction card，而不是直接搭建完整 benchmark suite。

```text
Resource:
Paper/project:
Dataset version or download date:
Code commit:
Environment:
Map target:
Split/mask:
Metric:
Checkpoint:
Published value:
Observed value:
Deviation:
Blocking gaps:
WCI interpretation:
```

第一轮应尽量复原原论文协议。只有在原始协议复原之后，才适合改变模型结构、采样掩膜或数据划分。

## 5. 对 3D 与低空结论做压力测试

若论文涉及 3D 或低空覆盖，至少增加一个压力测试：

| 论文声称 | 建议压力测试 |
|---|---|
| 高度感知重建 | 跨高度或未见接收机高度划分。 |
| 城市 3D 泛化 | 未见建筑、城市或环境划分。 |
| 低空通信效用 | 路径约束或空中走廊切片评估。 |
| 动态新鲜度 | 未来时间划分和地图年龄敏感性。 |
| 频段迁移 | 跨频率或多频段迁移划分。 |
| 下游决策支撑 | 中断感知路径规划、波束成功率、定位或 ISAC 指标。 |

如果一个资源只支持重建指标，应把它描述为 radio-map 或 CKM 证据，而不是完整 WCI 证据。

## 6. 谨慎报告和引用

发布复现笔记、issue 或 pull request 时：

- 引用原始数据集、代码仓库和论文。
- 说明资源是 peer-reviewed、preprint-linked、resource-first，还是 community index。
- 分开报告数据、代码、checkpoint、demo、split、license 和下游任务脚本的可用性。
- 记录失败或部分复现实验；它们能暴露缺失的划分、掩膜、checkpoint 或指标定义。

本仓库是索引和教程，不重新分发第三方数据集、模型权重、代码或论文全文，除非原始许可证明确允许。
