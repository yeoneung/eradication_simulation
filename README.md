# eradication_simulation

This document provides Matlab codes together with explicit setup for the experimental results provided in the paper 'On a minimum eradication time for the SIR model with time-dependent coefficients' (https://arxiv.org/abs/2311.14657).

# Project Setup and Execution Guide

This manual provides step-by-step instructions to run the MATLAB files `calculate_optimal_time.m` and `solve_pde.m`.

## Prerequisites

- MATLAB (R2020a or later recommended)
- Basic understanding of MATLAB functions and scripts

## Files Overview

1. **`calculate_optimal_time.m`** - This script defines a function for calculating the optimal time in an optimal control problem.
2. **`solve_pde.m`** - This script calls `calculate_optimal_time` to solve a PDE using the optimal time calculated.

## Instructions

### Step 1: Clone the Repository

If you haven't cloned the repository, use the following command to clone it to your local machine:



### Step 2: Verify File Structure

Ensure the following files are in the root of your project directory:

- `calculate_optimal_time.m`
- `solve_pde.m`

### Step 3: Open MATLAB

Launch MATLAB and navigate to the project directory. You can set the directory by entering the path in the MATLAB command window:

```matlab
cd 'path_to_your_project_directory'


### Step 4: Run `solve_pde.m`

Execute `solve_pde.m`, which uses `calculate_optimal_time.m` internally. In the MATLAB command window, enter:

\`\`\`matlab
solve_pde
\`\`\`

### Expected Output

The script should execute the necessary computations and output the results to the MATLAB console or plot results as required by `solve_pde.m`.






