#!/bin/bash
# Create a new conda environment installed in Jupyter

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 environment_name python_version"
    exit 1
fi

# Get the environment name and python version from the arguments
env_name=$1
python_version=$2

# Create a new conda environment
conda create -n $env_name python=$python_version

# Activate conda
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init

# Activate the new environment
conda activate $env_name

# Update pip
pip install --upgrade pip

# Install ipykernel
pip install ipykernel

# Register the new environment with Jupyter
python -m ipykernel install --user --name=$env_name