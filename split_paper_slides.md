# SPLIT Paper — Slide Content

**Citation:** Bilous et al., "Resolving sensitivity, specificity and signal
contamination in Xenium spatial transcriptomics," *Nature Methods* (2026).
GitHub: github.com/bdsc-tds/SPLIT

---

## Slide A — The Problem: Signal Contamination in Xenium

**Headline:** Even high-quality spatial data has a "bleed" problem

- Imaging-based spatial transcriptomics platforms like Xenium, MERSCOPE, and CosMx provide transcript-level resolution down to the cellular and subcellular scale
- But segmentation isn't perfect — transcripts from one cell can be
  assigned to its neighbor, especially in densely packed tissue
- Some of this mixing comes from z-axis diffusion — overlapping cells cause spillover during segmentation in the x-y plane — but that alone doesn't explain the full extent of contamination observed

**Why consultants should care:** This isn't a dataset-specific quirk — it's
a platform-level characteristic that affects cell-type calls regardless of
tissue type or panel size.

---

## Slide B — The Study: What They Actually Did

**Headline:** The largest systematic Xenium benchmark to date

- Over 40 breast and lung tumor sections profiled across a diverse set of gene panels — built specifically to characterize Xenium's
  technical properties, not just to answer a biological question
- Systematically dissected technical noise (including transcript diffusion), assay specificity, panel performance, and segmentation strategies
- Directly motivated by an open question in experimental design: targeted panels vs. the newer 5K panel, and how that choice trades off sensitivity, cost, and processing time

**Why consultants should care:** This gives you an evidence base for panel
selection conversations with clients — not just "more genes is better."

---

## Slide C — Key Finding: The 5K Panel Trade-off

**Headline:** More genes ≠ more signal per gene

- The 5K panel captures more transcripts overall — but suffers from reduced per-gene sensitivity and persistent transcript diffusion, even with improved chemistry
- Single-nucleus RNA-seq markedly improves cell-type annotation accuracy and enables more precise quantification of diffusion — i.e., you
  need an orthogonal reference to know how contaminated your spatial data
  really is

**Why consultants should care:** A client choosing the 5K panel for
"more coverage" may be trading away per-gene confidence — this is a
concrete talking point for scoping conversations.

---

## Slide D — The Solution: SPLIT

**Headline:** A correction method, not just a diagnosis

- SPLIT (Spatial Purification of Layered Intracellular Transcripts) integrates snRNA-seq with RCTD deconvolution to enhance signal purity
- It resolves mixed transcriptomic signals, improving background correction and cell-type resolution
- The released tool is annotation-method agnostic — it works with any deconvolution output, requiring only a cell-by-cell-type weight matrix and a gene-by-cell-type reference, and also supports VisiumHD and full-transcriptome spatial data, not just Xenium

**Why consultants should care:** This is a practical, open-source tool
(actively maintained, with tutorials) — a real option to offer clients
who have matched snRNA-seq data and are worried about contamination.

---

## Slide E — How This Connects to Our QC Analysis

**Headline:** QC filtering and signal purification are complementary, not
competing, strategies

- Our QC threshold comparison addressed *which cells* to trust based on
  transcript/gene counts
- SPLIT addresses *which transcripts within a cell* to trust, using an
  orthogonal reference dataset
- Neither fully solves the problem alone — but the SPLIT findings reinforce
  why our "strict filtering reveals an extra cluster" result makes sense:
  noisy/contaminated cells likely obscure real population boundaries until
  filtered aggressively
- **For client work:** if snRNA-seq is available, SPLIT-style correction
  may outperform aggressive QC filtering alone — worth scoping as an add-on
  for projects with budget for matched sequencing

---

## Notes on Sourcing

All quoted/paraphrased material above is drawn from the published abstract
and GitHub README (linked above). For slide design, consider pulling the
panel comparison figure directly from the paper's supplementary materials
(check the journal's figure reuse policy first) rather than recreating it —
or simply link to the paper for audience members who want to go deeper.
