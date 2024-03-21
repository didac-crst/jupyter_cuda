#!/bin/bash

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

# Check if the environment is active, if no activate it
if [ "$CONDA_DEFAULT_ENV" != "$env_name" ]; then
    conda deactivate
    conda activate $env_name
fi

# Launch JupyterLab in a conda environment
jupyter lab  --notebook-dir='~/Repositories/' --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token='mytoken'