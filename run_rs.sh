#!/bin/bash
#SBATCH -n 20
#SBATCH -N 1
#SBATCH --array=0-3
#SBATCH --gres=gpu:1
#SBATCH --constraint=8GB
#SBATCH -t 168:00:00
#SBATCH -p tenenbaum

source ~/.bashrc
cd /om2/user/gua/Documents/sam
module load openmind/anaconda/3-2022.05
conda activate /scratch2/weka/tenenbaum/gua/anaconda3/envs/smoothing
wandb enabled

# rho_values=(0 0.01 0.02 0.05 0.1 0.2 0.5)
rho_values=(0 0.01 0.05 0.1)
rho=${rho_values[$SLURM_ARRAY_TASK_ID]}
wandb_run_name="rs_rho_$rho"
python3 example/train.py --rs --rho $rho --wandb_run_name $wandb_run_name
