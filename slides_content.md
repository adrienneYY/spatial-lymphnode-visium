# Contribution Day Slides — Content Draft

Paste each section into its own slide in Google Slides / Keynote.
Figure references point to files in `figures/`.

---

## Slide 1 — What is Xenium?

**Headline:** Spatial transcriptomics at near-single-cell resolution

- Xenium maps individual RNA transcripts to their physical location in
  intact tissue — you get gene expression *and* the X/Y coordinates of
  every cell
- Key stat: **5,101 genes**, sub-cellular resolution, ~700k cells in a
  single tissue section

**Image:** `figures/spatial_clusters_standard.png` (full tissue, cluster
overlay) — gives a strong visual hook for "this is what the data looks like"

---

## Slide 2 — Why does this matter for consulting?

**Headline:** Clients are starting to generate this data — and standard
pipelines don't just work out of the box

- New file formats: `.parquet`, `.h5`, segmentation boundary files
- New QC questions: transcript count / gene count thresholds behave very
  differently than scRNA-seq (median here: **49 transcripts, 46 genes per
  cell** — far sparser than typical single-cell data)
- New visualization needs: spatial overlays, not just UMAPs

No image needed — text-only slide.

---

## Slide 3 — The SPLIT Paper (Context)

**Headline:** Even the 5K panel has signal contamination problems

- Published *Nature Methods*, 2026
- Key finding: transcript spillover/diffusion between neighboring cells is
  a persistent issue in Xenium data, even with expanded gene panels
- This motivates careful, defensible QC — not just "filter low counts and
  move on"

No image — or optionally a simple text callout box with the paper citation.

---

## Slide 4 — What I Did

**Headline:** Standard pipeline + a practical QC stress-test

- **Dataset:** 10x Genomics Xenium Prime Breast Cancer (FFPE), 699,110 cells,
  5,101-gene panel
- **Tools:** Seurat 5, `LoadXenium()`, sketch-based clustering workflow
  (50k-cell subsample → cluster → project to all cells)
- **Analysis:** Ran the full pipeline three times under different QC
  thresholds (lenient / standard / strict) and compared results

No image — bullet/text slide, sets up the results slides.

---

## Slide 5 — Results: UMAP + Spatial

**Headline:** Recovered clusters map cleanly onto tissue structure

- 11 clusters recovered under standard filtering
- Cluster boundaries in UMAP correspond to spatially coherent regions in
  the tissue — not scattered noise
- Marker genes (EPCAM, CD3E, MS4A1, CD68, PECAM1) localize to expected
  regions: epithelial/tumor areas (EPCAM) are spatially distinct from
  immune-rich regions (CD3E, CD68, MS4A1)

**Images:**
- `figures/umap_spatial_standard.png` (UMAP + spatial side by side)
- `figures/spatial_markers.png` (5-marker spatial expression panel)

---

## Slide 6 — Results: QC Comparison

**Headline:** QC choices meaningfully change what you find

| Condition | Cells Retained | % of Lenient | Clusters |
|---|---|---|---|
| Lenient (nCount>10, nFeature>10) | 490,610 | 100% | 13 |
| Standard (nCount>25, nFeature>20) | 454,652 | 92.7% | 11 |
| Strict (nCount>100, nFeature>50) | 184,408 | 37.6% | **14** |

**Key message:**
- Lenient → Standard: lost only ~7% of cells, but **two clusters
  disappeared** — likely low-quality/noise populations, not real biology
- Strict filtering kept just 37.6% of cells but **gained a cluster** —
  aggressive filtering can unmask rare populations, at a steep cost in
  cell yield
- There is no universally "correct" threshold — the right choice depends
  on whether your priority is comprehensive cell-type recovery or
  high-confidence per-cell calls

**Image:** `figures/qc_comparison_umaps.png` and/or
`figures/qc_comparison_spatial.png` (3-panel side-by-side)

---

## Slide 7 — Takeaways + Collaborator Angle

**Headline:** Practical QC recommendations + what's next

- **Recommendation for Xenium 5K data:** Start with standard thresholds
  (nCount > 25, nFeature > 20) as a baseline — minimal cell loss, cleaner
  clusters. Consider a strict-filtering pass as a *follow-up* if rare
  populations are a specific focus, not as the default.
- **Always run a QC sensitivity comparison** before committing to a
  threshold for a client deliverable — the "right" answer isn't obvious
  from summary stats alone.
- **Collaborator angle:** [Name] is exploring segmentation strategies
  (nucleus vs. cell vs. expanded boundary) and spot deconvolution on this
  same dataset — QC and segmentation are complementary halves of the same
  data-quality story.
- **Joint output:** Wiki entry — *"Xenium Data Quality: What Every
  Bioinformatician Should Know"*
- **Repo:** github.com/[username]/xenium_breast_cancer_analysis

No image — or a simple "Thank you / Questions" closing slide with the repo
QR code / link.
