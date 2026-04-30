# data/download_data.sh

#!/bin/bash
# Downloads 10x Genomics Visium Human Lymph Node dataset
# Run from the data/ directory

mkdir -p visium_lymph_node
cd visium_lymph_node

curl -O https://cf.10xgenomics.com/samples/spatial-exp/1.1.0/V1_Human_Lymph_Node/V1_Human_Lymph_Node_filtered_feature_bc_matrix.h5
curl -O https://cf.10xgenomics.com/samples/spatial-exp/1.1.0/V1_Human_Lymph_Node/V1_Human_Lymph_Node_spatial.tar.gz

tar -xzf V1_Human_Lymph_Node_spatial.tar.gz
echo "Download complete"