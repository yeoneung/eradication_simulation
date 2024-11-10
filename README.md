# eradication_simulation

This document provides Matlab codes together with explicit setup for the experimental results provided in the paper 'On a minimum eradication time for the SIR model with time-dependent coefficients' (https://arxiv.org/abs/2311.14657).

# Setup

We set $\mu_0=0.2$, $\mu=0.1$, $N_x=40$, $N_y=38$, $N_T=100$, hence, $h_x=h_y=0.05$ and $\Delta t = 0.01$. For $\beta$ and $\gamma$, we use $\beta(t)= e^{-t} \sin(t/2)+0.5$ and $\gamma(t)=e^{-t} \cos(t/2)+0.7$.
\]


### True system parameters

- Stabilizable $(A,B)$ 

$T=300$ and $N=200$ are used.

(i) $n=m=3$

$A={\left\lbrack \matrix{0.5 & 0 & 0.6 \cr 0.2 & 0 & 0.1 \cr 0 & 0.5 & 0.3} \right\rbrack}$, $B={\left\lbrack \matrix{0.4 & 0 & 0.4 \cr 0 & 0.3 & 0.1 \cr 0.3 & 0.2 & 0.1} \right\rbrack}$

(ii) $n=m=5$

$A={\left\lbrack \matrix{0.5 & 0 & 0.6 & 0.3 & 0.1 \cr 0.2 & 0 & 0.1 & 0.4 & 0.2  \cr 0 & 0.2 & 0 & 0.5 & 0.3 \cr 0.6 & 0.1 & 0.2 & 0 & 0.3 \cr 0.1 & 0.4 & 0.3 & 0.5 & 0.1 } \right\rbrack}$, 
$B={\left\lbrack \matrix{0.4 & 0 & 0.5 & 0 & 0.4 \cr 0 & 0.1 & 0.2 & 0.3 & 0.1  \cr 0.3 & 0 & 0 & 0.2 & 0.1 \cr 0.1 & 0.5 & 0.1 & 0.2 & 0.4 \cr 0.4 & 0 & 0.5 & 0.3 & 0.1 } \right\rbrack}$

- Unstabilizable $(A,B)$ with $n=m=3$ and $n=m=5$

$T=50$ and $N=100$ are used.

(i) $n=m=3$

$A={\left\lbrack \matrix{0 & -1  & 1 \cr 1 & 0 & 1 \cr 0 & 0 & 1} \right\rbrack}$, $B={\left\lbrack \matrix{1 & 0 & 0 \cr 0 & 0 & 1 \cr 0 & 0 & 0} \right\rbrack}$

(ii) $n=m=5$

$A={\left\lbrack \matrix{1 & 0 & 0 & 0 & 0 \cr 1 & 0 & 1 & 0 & -1  \cr 0 & 0 & -1 & 0 & 1 \cr 1 & 1 & 1 & 0 & 0 \cr 1 & 0 & -1 & 0 & 0 } \right\rbrack}$, 
$B={\left\lbrack \matrix{0 & 0 & 0 & 0 & 0 \cr 1 & 0 & 0 & 0 & 0  \cr 0 & 0 & 0 & 0 & 0 \cr 1 & 0 & 1 & 0 & 0 \cr 1 & 0 & 0 & 0 & 0 } \right\rbrack}$


### Type of system noise
Three different types of system noise are considered to test the performance of the algorithm.
(i) Gaussian
(ii) Gaussian mixture, and (iii) asymmetric noise.

For (i) and (ii), built-in random number generators in Matlab are used while we synthesize (iii) based on Langevin Markov Chain Monte Carlo (MCMC).

### - Comparison with other method
We compare the performance of our algorithm with those proposed in [On the Sample Complexity of the Linear Quadratic Regulator](
https://link.springer.com/article/10.1007/s10208-019-09426-y). 

# Auxiliary functions

We include all auxiliary functions in 'bayesian_system_id/auxiliary' which are called automatically once the user adds this folder to the path.

- '(type_of_noise)_grad_log.m' computes the gradient of the potential with respect to the system parameter 
 associated with the noise type indicated in the filename.
- '(type_of_noise)_grad_log_w.m' computes the gradient of the potential with respect to the noise variable indicated in the filename.
- '(type_of_noise)_hess_log.m' computes the Hessian of the potential functions associated with the noise indicated in the filename.
- 'Newton_method_(noise_type).m' implements the second-order Newton's method where (noise_type) is denoted by either 'as' for asymmetric noise or 'gm' for Gaussian mixture noise
- 'Tr_Theta_to_theta.m' vectorizes the system parameter.

# Running

#### - Asymmetric noise generators
Running 'ULA_asymmetric_1D.m' generates a set of synthetic asymmetric noises based on Langevin Markov Chain Monte Carlo. 
This file will generate a set of 1000000 independent noises and save it 'asymmetric_noise_1D.csv'. 

#### - Before running 'main.m', you should add all folders (LSE, Ours, assymmetric_noise_generator, auxiliary) to the path.
The output will be plots for the error, and the data is saved as csv file in the current directory.

(i) stabilizable system parameters in 3D and 5D with 
- Gaussian noise
- Gaussian mixture noise
- asymmetric noise

(ii) unstabilizable system parameters in 3D, 5D
- Gaussian noise
- Gaussian mixture noise
- asymmetric noise







