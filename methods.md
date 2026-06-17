# Methods

## Dataset

The [10x Genomics Xenium Prime Breast Cancer (FFPE)](https://www.10xgenomics.com/datasets)
tutorial dataset was used for all analyses. This is a Xenium Prime 5K panel
run on a human breast cancer FFPE section.

Raw output files used:
- `cell_feature_matrix.h5` — cell × gene count matrix
- `cells.parquet` — cell metadata and centroid coordinates
- `cell_boundaries.parquet` — cell segmentation boundaries
- `transcripts.parquet` — per-transcript spatial coordinates

Baseline (unfiltered) dataset statistics:

| Metric | Value |
|---|---|
| Total cells | 699,110 |
| Total genes (panel size) | 5,101 |
| Median counts per cell | 49 |
| Median genes detected per cell | 46 |

## Data Loading

Data were loaded with Seurat 5's `LoadXenium()` function, which reads the
`.h5` feature matrix, cell coordinates, and segmentation boundaries directly.
The `arrow` package was required to read `transcripts.parquet`, as the
10x Xenium outputs no longer include the legacy `transcripts.csv.gz` format.

## QC Filtering Strategies

To evaluate the impact of QC stringency on downstream clustering, three
filtering thresholds were applied to the raw, unfiltered Seurat object
based on per-cell transcript counts (`nCount_Xenium`) and number of genes
detected (`nFeature_Xenium`):

| Condition | Filter | Rationale |
|---|---|---|
| Lenient | nCount > 10, nFeature > 10 | Minimal filtering; retains low-quality/noise cells |
| Standard | nCount > 25, nFeature > 20 | Approximately at the dataset median; balanced |
| Strict | nCount > 100, nFeature > 50 | Retains only high-confidence, well-profiled cells |

Thresholds were chosen relative to the baseline median (49 counts, 46 genes)
to span a meaningful range from near-total inclusion to substantial
exclusion.

## Clustering Pipeline (Sketch-Based)

Given the dataset size (~700k cells), a sketch-based workflow was used
following Seurat 5's recommended approach for large-scale spatial datasets
(adapted from the
[10x Genomics Xenium 5K analysis tutorial](https://github.com/10XGenomics/analysis_guides/blob/main/Xenium_5k_data_analysis_journey.ipynb)):

1. **`SketchData()`** — subsample 50,000 cells via leverage-score sampling,
   which preferentially retains cells that capture variance in the dataset
   (rather than uniform random sampling)
2. Standard pipeline run on the sketched 50k cells:
   - `NormalizeData()` — log-normalization
   - `FindVariableFeatures()`
   - `ScaleData()`
   - `RunPCA()` (50 components)
   - `FindNeighbors()` + `FindClusters()` (resolution = 0.3, Leiden algorithm)
   - `RunUMAP()` (dims 1:25, `return.model = TRUE`)
3. **`ProjectData()`** — cluster labels and UMAP coordinates projected from
   the 50k-cell sketch back to all cells in each filtered dataset

This pipeline was run independently for each of the three QC conditions
(lenient, standard, strict), each starting from the raw unfiltered object
and applying its respective filter before sketching.

PCA dimensionality (`dims = 1:25`) was selected by inspecting the elbow
plot from the standard-filtered run (see `figures/elbow_plot.png`).

## Spatial Visualization

Cluster assignments were visualized on tissue coordinates using
`ImageDimPlot()`. Canonical breast cancer cell-type marker genes (EPCAM —
epithelial/tumor; CD3E — T cells; MS4A1 — B cells; CD68 — macrophages;
PECAM1 — endothelial) were visualized spatially using a custom `ggplot2`
overlay: cells with zero expression of a given marker were plotted as a
dark grey tissue background, and expressing cells were overlaid and
colored by expression level (capped at the 95th percentile, magma color
scale), with expressing cells plotted in ascending order of expression so
that the highest-expressing cells render on top.

ACTA2 (smooth muscle/myoepithelial marker) was not present in the Xenium
5K panel and was excluded from marker visualization.

## Comparison Metrics

For each QC condition, the following were recorded:

- Number of cells retained (raw count and % relative to the lenient
  condition)
- Number of clusters recovered by `FindClusters()`
- Side-by-side UMAP and spatial cluster plots

## Software Environment

- R 4.5 (arm64, macOS)
- Seurat 5.x
- Key packages: `ggplot2`, `patchwork`, `arrow`, `viridis`
- Full session info: `environment/session_info.txt`

## Limitations

- Clustering resolution (0.3) was held constant across all three QC
  conditions; cluster *counts* are therefore comparable but absolute
  cluster identities were not formally matched/aligned across conditions
  (e.g. via marker gene correlation), so a cluster numbered "5" in one
  condition does not necessarily correspond to cluster "5" in another.
- Cell type annotation was based on canonical marker gene expression
  patterns only; no reference-based label transfer or formal differential
  expression analysis was performed.
- This analysis uses a single tissue section; findings may not generalize
  to other samples, tissue types, or Xenium panel sizes without further
  validation.
