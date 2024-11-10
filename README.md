# eradication_simulation

This document provides Matlab codes together with explicit setup for the experimental results provided in the paper 'On a minimum eradication time for the SIR model with time-dependent coefficients' (https://arxiv.org/abs/2311.14657).

## Setup

We set $\mu_0=0.2$, $\mu=0.1$, $N_x=40$, $N_y=38$, $N_T=100$, hence, $h_x=h_y=0.05$ and $\Delta t = 0.01$. For $\beta$ and $\gamma$, we use $\beta(t)= e^{-t} \sin(t/2)+0.5$ and $\gamma(t)=e^{-t} \cos(t/2)+0.7$.

Before running, you should add 'calculate_optimal_time.m' to the path.

## Reference values
The reference values are computed via the multiple shooting algorithm. To obtain these values, run 'ref_shooting.m' file.

It will generate reference values of $u(x,y,0)$, $u(x,y,0.5)$, $u(x,y,1)$ on the domain $&#123 x_i,y_j): x_i= 0.05 \times i, y_j= 0.05 \times j + 0.02 &#125$

# Solving Hamilton-Jacobi-Bellman equation
Run 'solve_pde_w_shooting'.





