#!/bin/bash
# Create a new conda environment with Jupyter and CUDA support

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

# Install CUDA Toolkit and cuDNN
conda install -c conda-forge cudatoolkit=11.2.2 cudnn=8.1.0

# Create the directories to place our activation and deactivation scripts in:
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
mkdir -p $CONDA_PREFIX/etc/conda/deactivate.d

# Add commands to the scripts:
printf 'export OLD_LD_LIBRARY_PATH=${LD_LIBRARY_PATH}\nexport LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${CONDA_PREFIX}/lib/\n' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
printf 'export LD_LIBRARY_PATH=${OLD_LD_LIBRARY_PATH}\nunset OLD_LD_LIBRARY_PATH\n' > $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh

# Run the script once:
source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

# Update pip
pip install --upgrade pip

# Install Jupyter
pip install jupyter