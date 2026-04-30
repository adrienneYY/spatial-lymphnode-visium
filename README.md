# Spatial Transcriptomics of Human Lymph Node
## 10x Genomics Visium Analysis in R/Seurat

### Overview
Spatial transcriptomic analysis of a human lymph node using the 
10x Genomics Visium platform. 
1. Maps gene expression patterns within tissue architecture
2. Identifies spatially variable genes and immune cell organization across tissue compartments

Skillset note: This work extends prior experience with NanoString GeoMx DSP spatial 
profiling and multiparameter immunofluorescence of lymphoid tissue 
to a spot-based transcriptomic platform.

### Biological Questions
- Which genes show spatially variable expression across lymph node compartments?
- Can we identify known structural regions (germinal centers, T cell zones, 
  B cell follicles) solely from transcriptomic data?
- What cell types are enriched in different spatial domains?

### Dataset
10x Genomics Visium Human Lymph Node v1  
Public dataset available at: https://www.10xgenomics.com/datasets

### Methods
- Quality control and normalization: Seurat v5
- Spatially variable gene identification: Seurat (Moran's I)
- Clustering: graph-based clustering with spatial context
- Cell type deconvoluton:RCTD (in progress)
- Visualization: Seurat, ggplot2

### Analysis Steps
| Script | Description |
|--------|-------------|
| 01_load_and_qc.R | load raw data, QC metrics, filtering |
| 02_normalization_clustering.R | normalization, dimesionality reduction, clustering |
| 03_spatially_variable_genes.R | identify and visualize spatially variable genes |
| 04_deconvolution.R | cell type deconvolution with scRNA-seq reference |

### Requirements
R 4.4.x  
Key packages: Seurat, SeuratData, ggplot2, patchwork

### How to reproduce
1. Clone this repo
2. Run data/download_data.sh to download raw data
3. Run scripts in order

### Author
Adrienne Yanez, Ph.D.  
Translational Bioinformatics | Clinical Biomarkers