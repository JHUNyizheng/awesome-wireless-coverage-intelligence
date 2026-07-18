# Awesome Wireless Coverage Intelligence

A bilingual companion resource index for the survey:

**Radio Maps and Channel Knowledge Maps for 6G Wireless Networks: A Survey of Construction, Applications, Evaluation, and Deployment**

This repository is the public companion index for radio maps, radio environment maps (REMs), spectrum cartography, and channel knowledge maps (CKMs). It records papers, datasets, code, models, demos, and evaluation protocols without mirroring third-party content.

## Survey Revision Alignment

The companion index follows the evidence structure used in the IEEE CST survey revision:

- **Technical evidence:** construction methods and communication applications are compared under their stated map targets, data regimes, and assumptions.
- **Protocol-bound results:** disclosed numbers retain their split, sampling mask, normalization, frequency, height, and task context.
- **Artifact availability:** paper, dataset, code, model, demo/API, and evaluation-protocol records use conservative status and license fields.
- **Separated denominators:** paper-level linkage, artifact-level availability, and benchmark-level reproduction maturity are reported independently.

## Quick Navigation

- [Datasets and benchmarks](resources/datasets.md)
- [3D and low-altitude coverage resources](resources/low_altitude_3d_coverage.md)
- [Resource cards](resources/cards/README.md)
- [Code repositories](resources/code.md)
- [Pretrained models and demos](resources/models_and_demos.md)
- [Publication-artifact alignment](resources/publication_artifact_alignment.csv)
- [Machine-readable artifact ledger](resources/artifact_availability_ledger.csv)
- [Artifact browser by paper and material type](resources/artifact_index.md)
- [Open-artifact taxonomy and counting rules](resources/open_artifact_taxonomy.md)
- [Reproducibility scorecard](resources/reproducibility_scorecard.csv)
- [Benchmark-performance disclosure table](resources/benchmark_performance_disclosure.csv)
- [Benchmark result-card ledger](resources/benchmark_result_card_ledger.md)
- [Source verification note](resources/source_verification_20260604.md)
- [Monitoring watchlist](resources/monitoring_watchlist_20260606.md)
- [Publication closure packet](resources/publication_closure_packet_20260606.md)
- [Public link-check report](resources/link_check_latest.md)
- [Getting started tutorial](tutorials/getting_started.md)
- [3D / low-altitude benchmark workflow](tutorials/low_altitude_benchmark_workflow.md)
- [Reproducibility protocol](tutorials/reproducibility_protocol.md)
- [Roadmap](ROADMAP.md)
- [中文说明](README_zh.md)

## How To Use This Repository

1. Start with the dataset page and identify whether your task is 2D pathloss prediction, sparse REM reconstruction, 3D/low-altitude mapping, dynamic forecasting, or CKM construction.
2. Check the artifact ledger before planning experiments. A reachable URL does not establish an open license, fixed version, or executable reproduction path.
3. Read the benchmark-performance disclosure table before comparing reported accuracy. RMSE, MAE, NMSE, SSIM, beam accuracy, and task metrics are only meaningful with the corresponding split, sampling mask, map resolution, frequency, height, and task definition.
4. Use the benchmark result-card ledger when recording numerical results from published papers or local reproductions.
5. Translate any reconstruction score into a network claim only after identifying the downstream decision: beam/RIS control, UAV routing, coverage repair, localization/ISAC, or semantic protection.
6. Use the tutorials as a lightweight workflow guide. The repository links to canonical hosts and does not redistribute third-party papers, datasets, code, or model weights.

## Local Checks

Run the lightweight repository check before publishing or submitting a pull request:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_resources.ps1
```

Refresh the public-link audit before a public release or major manuscript revision:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_public_links.ps1
```

Prepare the first GitHub publication with the guarded helper:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish_to_github.ps1 -DryRun -SkipPublicLinkCheck -Owner JHUNyizheng -UserName "<your name>" -UserEmail "<your email>"
```

Build a clean local release bundle for maintainer review or manual GitHub
repository creation:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/build_release_bundle.ps1
```

The GitHub Actions workflow in `.github/workflows/resource-check.yml` runs both checks on pushes and pull requests. External-link checks are treated as maintenance signals because public hosts may rate-limit automated requests.

## Resource Categories

- **2D radio-map benchmarks:** RadioMapSeer, RadioUNet, pathloss prediction challenges.
- **Sparse REM and spectrum maps:** DeepREM and related sparse-measurement resources.
- **3D and low-altitude coverage:** SpectrumNet, UrbanRadio3D, 3DiRM3200, RadioLAM, REM-Net+, real urban 3D GPR, and related resources.
- **Dynamic maps:** RadioMapMotion and temporal REM forecasting resources.
- **CKM resources:** CKMImageNet, CKM tutorial-lineage repositories, real-world CKM datasets.
- **Open-source monitoring:** GitHub, IEEE DataPort/project pages, Zenodo/OpenAIRE, Hugging Face, and community indexes.
- **Watchlist resources:** Newly observed or resource-first toolchains that should be monitored without automatically changing the 210-work manuscript evidence base.

## Reproducibility Rubric

Resources are described along seven artifact dimensions:

- Dataset persistence
- Executable code
- Pretrained models or checkpoints
- Demo or app support
- Fixed splits and preprocessing
- License and provenance metadata
- Downstream task scripts

The scorecard is not a scientific ranking. It asks whether another group can obtain the artifacts needed to reproduce, stress-test, or reuse a published or community resource.

Availability states are `open`, `restricted`, `unavailable`, `link-broken`, and `unclear-license`. Public downloads without explicit license evidence remain `unclear-license`. The status describes access at the recorded verification date and does not grade technical merit.

## Contributing

New resources are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening an issue or pull request. Do not upload third-party datasets, model weights, or copyrighted paper text unless their license explicitly permits redistribution.

## License

The documentation and resource index in this repository are released under CC BY 4.0. Third-party datasets, code, models, papers, and project pages remain under their own licenses.
