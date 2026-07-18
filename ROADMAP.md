# Roadmap

This roadmap keeps the companion project aligned with the radio-map and CKM survey without
turning the repository into a mirror of third-party datasets or paper text.

## Near-Term

- Add resource cards for every high-impact dataset or codebase cited in the
  open-source artifact audit.
- Keep 3D/low-altitude resources separated from 2D scalar radio-map benchmarks.
- Record whether public results include dataset, code, pretrained models, demos,
  fixed splits, license/provenance metadata, and downstream-task scripts.
- Keep resource-first artifacts clearly separated from peer-reviewed publication
  evidence.
- Refresh `resources/link_check_latest.*` before public release or major survey
  revisions.
- Preserve paper-level, artifact-level, and benchmark-level counts as separate
  views of the evidence base.

## Medium-Term

- Add reproducibility cards for common baselines on RadioMapSeer, DeepREM,
  UrbanRadio3D, RadioMapMotion, 3DiRM3200, and CKMImageNet.
- Convert all representative resource cards into schema-valid machine-readable
  metadata with status, license, version, verification date, and scope fields.
- Add a small benchmark-protocol notebook that demonstrates how to compare
  metrics only after split, mask, frequency, height, and task definitions align.
- Expand the GitHub Actions maintenance workflow with optional schema validation
  once resource cards are converted to structured metadata.

## Long-Term

- Maintain a public changelog synchronized with major survey revisions.
- Archive stable versions through Zenodo or a similar DOI-bearing service if the
  author team decides to make the evidence package public.
- Add community-maintained issue labels for datasets, code, models, demos,
  resource-first artifacts, and reproducibility reports.
