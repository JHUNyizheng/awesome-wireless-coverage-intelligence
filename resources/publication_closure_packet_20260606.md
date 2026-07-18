# Companion Publication Closure Packet

Generated for the WCI survey companion project on 2026-06-06.

This packet defines the minimum evidence required to close the manuscript-side
`Companion GitHub publication` gate. It is intentionally stricter than a local
ZIP handoff: a release bundle proves that the materials can be shared, whereas
publication closure requires either a live repository record or an explicit
author-team deferral decision.

## Current Local Evidence

| Item | Current state |
|---|---|
| Local repository | `awesome-wireless-coverage-intelligence` is initialized as a Git work tree |
| Resource check | PASS; required files 26, relative README links 38, resource cards 11 |
| Scorecard rows | `reproducibility_scorecard.csv`: 21 |
| Publication-alignment rows | `publication_artifact_alignment.csv`: 18 |
| Benchmark-disclosure rows | `benchmark_performance_disclosure.csv`: 10 |
| Benchmark result-card signals | 9 |
| Release bundle | `dist/awesome-wireless-coverage-intelligence-release.zip` |
| Publication decision | Pending until Git identity/remote or deferral evidence is supplied |

## Closure Path A: Publish Before IEEE CST Submission

Archive the following evidence after the repository is pushed.

```text
Decision: Publish before IEEE CST submission
GitHub owner:
Repository URL:
Visibility: public / private-until-acceptance
Local git user.name:
Local git user.email:
Initial commit hash:
Default branch:
GitHub Actions resource-check URL or status:
Release bundle SHA256 used for cross-check:
Maintainer:
Date:
```

Acceptance rule: the repository URL must be reachable by the author team, the
initial commit hash must be recorded, and the resource-check workflow or local
equivalent must pass after publication.

## Closure Path B: Manual Repository Creation From Bundle

Use this path when a maintainer creates the GitHub repository manually from the
validated ZIP rather than pushing from this local work tree.

```text
Decision: Publish manually from validated release bundle
Bundle path:
Bundle SHA256:
Maintainer:
Manual repository creation date:
Repository URL:
Visibility: public / private-until-acceptance
First pushed commit hash:
GitHub Actions resource-check URL or status:
Any files intentionally omitted from the bundle:
```

Acceptance rule: the recorded repository must contain the release-bundle
contents, preserve the license and citation files, and pass the structural
resource check.

## Closure Path C: Defer Public Release

Use this path only when the author team decides that the companion should remain
local until a defined manuscript milestone.

```text
Decision: Defer public release
Reason for deferral:
Planned release trigger: first revision / acceptance / camera-ready / other
Responsible maintainer:
Validated release bundle path:
Validated release bundle SHA256:
Manuscript data/code availability wording:
Cover-letter wording, if needed:
Decision date:
Approving author:
```

Acceptance rule: deferral must be explicit, time-bounded or milestone-bounded,
and accompanied by wording that avoids claiming a live public GitHub repository.

## Minimal Maintainer Reply

```text
Companion publication decision:

[ ] Publish now from this local repository.
[ ] Publish manually from the validated ZIP bundle.
[ ] Defer public release.

GitHub owner or organization:
Repository URL, if already created:
Visibility:
Maintainer name:
Maintainer email:
Decision rationale:
Release trigger if deferred:
```

## Post-Decision Verification

Run these commands after the publication or deferral evidence is recorded:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_resources.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_public_links.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_publish_readiness.ps1
powershell -ExecutionPolicy Bypass -File scripts/build_release_bundle.ps1
```

Then rerun the manuscript-side suite from `manuscript/survey_cst`:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/run_submission_readiness_suite.ps1
```

Also copy the accepted decision into the manuscript-side machine-readable
status block in
`manuscript/survey_cst/evidence/external_response_intake_checklist_20260606.md`
under `companion_publication`. This keeps the GitHub publication/deferral
decision, release-bundle SHA, responsible maintainer, and post-decision
validation result tied to the same closure record used for author and expert
responses.

## Chinese Note

关闭 companion GitHub publication gate 需要两类证据之一：第一，真实 GitHub
仓库 URL、初始 commit、可见性和资源检查状态；第二，作者团队明确决定延期公开，
并记录延期原因、触发节点、负责人和投稿文件中的 data/code availability 表述。
本地 ZIP 包只能证明材料已经可交接，不能单独证明 GitHub 发布已经完成。

发布或延期决定被接受后，还应同步填写论文侧
`external_response_intake_checklist_20260606.md` 中的 `companion_publication`
机器可读状态块，记录 repository URL、commit、release bundle SHA、负责人和
验证结果。
