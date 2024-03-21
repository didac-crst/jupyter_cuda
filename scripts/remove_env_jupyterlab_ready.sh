#!/bin/bash
# Remove a conda environment from Jupyter and from conda

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 environment_name"
    exit 1
fi

# Get the environment name and python version from the arguments
env_name=$1

# Activate conda
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init

# Check if the environment is active, if yes deactivate it
if [ "$CONDA_DEFAULT_ENV" == "$env_name" ]; then
    conda deactivate
fi

# Remove the environment from Jupyter
jupyter kernelspec uninstall $env_name

# Remove the environment from conda
conda remove --name $env_name --all