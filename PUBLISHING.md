# Publishing Guide

The companion resource index was published on 2026-07-18 at
<https://github.com/JHUNyizheng/awesome-wireless-coverage-intelligence>.
The first complete resource-tree commit is
`87163754fa3f8daa1d8b8e1eeaeab006540b1bcb`; GitHub Actions run
[`resource-check #1`](https://github.com/JHUNyizheng/awesome-wireless-coverage-intelligence/actions/runs/29636436306)
completed successfully. The local environment used for release did not provide
the GitHub CLI (`gh`), so repository creation and publication were performed
through the authenticated GitHub web session and GitHub repository API.

## Option 0: Build A Local Release Bundle

If a maintainer wants to review or manually upload the project before Git
identity and a remote are configured, build a clean ZIP bundle:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/build_release_bundle.ps1
```

The bundle is written to
`dist/awesome-wireless-coverage-intelligence-release.zip`, with validation
results in `dist/release_bundle_validation_latest.md`. It excludes `.git`,
`dist`, local datasets, checkpoints, weights, and third-party mirrors. This
does not close the GitHub publication blocker by itself; it creates a
reviewable package for manual GitHub repository creation or author-team handoff.

## Publication Decision Record / 发布决策记录

Before the manuscript-side companion-publication gate is marked closed, archive
one of the following decisions with the author team. The local release bundle is
handoff evidence, but it is not a publication decision by itself.
Each run of `scripts/check_publish_readiness.ps1` also writes
`resources/publication_decision_snapshot_latest.md/json`, which records the
current Git identity, remote, GitHub CLI state, release-bundle SHA, and exact
actions needed to publish or defer publication.
Use `resources/publication_closure_packet_20260606.md` as the formal evidence
template for closing the manuscript-side companion publication gate.

```text
Decision:
[ ] Publish before IEEE CST submission.
[ ] Publish manually from the validated local release bundle.
[ ] Defer public release until first revision / acceptance / camera-ready.

If publishing now:
- GitHub owner:
- Repository URL:
- Visibility: public / private-until-acceptance
- Initial commit hash:
- GitHub Actions/resource-check status:

If publishing manually from the release bundle:
- Bundle path:
- Bundle SHA256:
- Maintainer:
- Manual repository creation date:
- First pushed commit hash:

If deferring:
- Reason for deferral:
- Planned release trigger:
- Responsible person:
- Manuscript or cover-note wording, if needed:
```

中文说明：如果选择投稿前公开发布，需要记录仓库 URL、可见性和初始 commit；
如果使用本地 release bundle 手动建库，需要记录 bundle SHA 和首次 push 的
commit；如果延期发布，需要记录延期原因、触发时间和负责人。没有公开仓库或
明确延期决定时，不应把 companion GitHub publication gate 视为关闭。

## Option 1: Publish With GitHub CLI

After installing and authenticating `gh`:

```powershell
gh auth login
gh repo create JHUNyizheng/awesome-wireless-coverage-intelligence --public --source . --remote origin --push
```

You can also use the guarded publication helper, which refreshes local checks,
configures local Git identity when provided, creates the remote with `gh` when
requested, creates the initial commit, and pushes `main`:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish_to_github.ps1 `
  -Owner JHUNyizheng `
  -UserName "<your name>" `
  -UserEmail "<your email>" `
  -CreateRemoteWithGh
```

For a dry run that does not write Git config, commit, add remotes, or push:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish_to_github.ps1 `
  -Owner JHUNyizheng `
  -UserName "<your name>" `
  -UserEmail "<your email>" `
  -RemoteUrl https://github.com/JHUNyizheng/awesome-wireless-coverage-intelligence.git `
  -SkipPublicLinkCheck `
  -DryRun
```

## Option 2: Publish With A Manually Created Remote

Create a new public repository named `awesome-wireless-coverage-intelligence`
on GitHub, then run:

```powershell
git config user.name "<your name>"
git config user.email "<your email>"
git add .
git commit -m "Initial wireless coverage intelligence resource guide"
git branch -M main
git remote add origin https://github.com/JHUNyizheng/awesome-wireless-coverage-intelligence.git
git push -u origin main
```

The same flow can be executed through the helper without `gh`:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish_to_github.ps1 `
  -RemoteUrl https://github.com/JHUNyizheng/awesome-wireless-coverage-intelligence.git `
  -UserName "<your name>" `
  -UserEmail "<your email>"
```

## Suggested Repository Description

Companion index of papers, datasets, code, models, demos, evaluation protocols,
and benchmark disclosures for radio maps and channel knowledge maps in 6G.

## Suggested Topics

`radio-map`, `wireless-coverage`, `channel-knowledge-map`, `rem`,
`spectrum-cartography`, `low-altitude-network`, `6g`, `reproducibility`,
`dataset`, `benchmark`

## Pre-Publication Checks

Before the first public release, run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check_public_links.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_resources.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_release_bundle.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_publish_readiness.ps1
powershell -ExecutionPolicy Bypass -File scripts/build_release_bundle.ps1
powershell -ExecutionPolicy Bypass -File scripts/publish_to_github.ps1 -DryRun -SkipPublicLinkCheck -Owner JHUNyizheng -UserName "<your name>" -UserEmail "<your email>"
```

The GitHub Actions workflow `.github/workflows/resource-check.yml` will repeat
the same maintenance checks after the repository is pushed. Public-link results
should be inspected manually because some third-party hosts rate-limit or block
automated link probes.

`scripts/check_publish_readiness.ps1` is a local dry-run gate. It checks Git
identity, remote configuration, required publication files, structural resource
checks, release-bundle generation, public-link review status, and GitHub CLI
availability. It also writes the latest publication-decision snapshot under
`resources/`. Use `-Strict` when you want the command to fail if any OPEN
publication blocker remains.
