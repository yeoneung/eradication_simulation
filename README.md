# eradication_simulation

This document provides Matlab codes for the experimental results provided in the paper 'On a minimum eradication time for the SIR model with time-dependent coefficients' (https://arxiv.org/abs/2311.14657).

## Prerequisites

- MATLAB (R2020a or later recommended)
- Basic understanding of MATLAB functions and scripts

## Files Overview

1. **`calculate_optimal_time.m`** - This script defines a function for calculating the optimal time in an optimal control problem.
2. **`solve_pde.m`** - This script calls `calculate_optimal_time` to solve a PDE using the optimal time calculated.

### Step 1: Run `solve_pde.m`

Execute `solve_pde.m`, which uses `calculate_optimal_time.m` internally. In the MATLAB command window, enter:

'solve_pde`.

### Step 2: Run `reference.m`

Execute `solve_pde.m`, which uses `calculate_optimal_time.m` internally. In the MATLAB command window, enter:

'reference`.

It computes reference values of $u$ at $t=0.1,0.3,0.5$.

### Step 3: Run `plot_u_surface.m` and `plot_fix_x.m`

Execute plot_u_surface.m` and `plot_fix_x.m`. In the MATLAB command window, enter:

`solve_pde.m` and `plot_fix_x.m`.


### Expected Output

The script should execute the necessary computations and plots of the results to the MATLAB console.







