# Datasets and Benchmarks / 数据集与基准

This page lists public resources useful for radio maps, REMs, spectrum cartography, CKMs, and WCI. Always consult the original resource license and citation instructions.

| Resource | Main target | Dimensionality / scenario | Artifact status | Link |
|---|---|---|---|---|
| RadioMapSeer | Pathloss and ToA radio maps | 2D urban layouts | Public dataset; IEEE DataPort DOI; companion code via RadioUNet | https://radiomapseer.github.io/ |
| DeepMIMO | Ray-tracing channel data | mmWave/MIMO scenarios | Public toolchain, scenarios, docs, Python package | https://github.com/DeepMIMO/DeepMIMO |
| DeepREM | RSRP REM | Sparse 2D urban REM | Dataset, trained models, Streamlit app via Zenodo/OpenAIRE | https://zenodo.org/records/7839447 |
| SpectrumNet / FDRadiomap | Multiband 3D radio maps | Terrain, climate, frequency, altitude | Public dataset distribution; code/checkpoints not observed in audit | https://github.com/ShuhangZhang/FDRadiomap |
| UrbanRadio3D | 3D-by-3D urban pathloss maps | Volumetric urban coverage | Dataset, splits, MIT license; code linked to RadioDiff family | https://github.com/UNIC-Lab/UrbanRadio3D |
| RadioMapMotion | Future radio-map sequences | Spatio-temporal vehicle trajectories | Dataset, code, split protocol, train/test scripts | https://github.com/UNIC-Lab/RadioMapMotion |
| 3DiRM3200 | Indoor 3D radio maps | Receiver-height variation | Dataset, code notebooks, partial pretrained support | https://github.com/lighttime2023/3DiRM3200 |
| CKMImageNet | Channel knowledge maps | Gain, delay, AOA, AOD, environmental representations | Dataset and scenario folders; code/checkpoints not observed in audit | https://github.com/zyktzCKM/CKMImageNet |
| RMDirectionalBerlin | Directional antenna radio maps | Urban directional measurements | Zenodo dataset with code links; journal status not confirmed | https://zenodo.org/records/13834313 |
| MobiSim RadioMap | RSRP/SINR maps | Simulated Chinese city maps | Hugging Face dataset; not yet confirmed as final peer-reviewed paper | https://huggingface.co/datasets/MobiSim/MobiSim |
| Multi-config Radiomap Dataset | Multi-band/beam-map prediction | U6G XL-MIMO multi-configuration maps | Dataset, code, pretrained checkpoints, generation pipeline | https://huggingface.co/datasets/lxj321/Multi-config-Radiomap-Dataset |
| Real-world CKM-Dataset | CIR/PDP/RSS and point-cloud CKM | Partial real-world CKM release | Partial dataset; full release pending in audit | https://github.com/ycw671/CKM-Dataset |

## 中文提示

这些资源的可比性并不相同。比较精度前，请先确认数据划分、采样掩膜、地图分辨率、频段、高度、环境来源和任务定义。
