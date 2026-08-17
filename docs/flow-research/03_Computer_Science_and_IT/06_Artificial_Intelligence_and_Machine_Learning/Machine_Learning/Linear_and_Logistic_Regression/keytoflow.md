# Key to Flow: Linear and Logistic Regression (OLS Normal Equation, L1/L2 Regularization, & Logit Loss)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Machine_Learning / Linear_and_Logistic_Regression`

---

## 📌 Core Concept & Mental Model
**Ordinary Least Squares (OLS) Closed-Form Projections ($\mathbf{\theta = (X^T X)^{-1} X^T y}$), Gradient Descent Convergence ($\theta \leftarrow \theta - \alpha \nabla_\theta J(\theta)$), Regularization Geometry ($L_2$ Ridge Hypersphere vs $L_1$ Lasso Diamond Sparsity), The Sigmoid Logit Transformation ($\sigma(z) = \frac{1}{1 + e^{-z}}$), and Convex Binary Cross-Entropy (Log-Loss)** govern linear regression, classification boundaries, and parameter optimization in machine learning (Carl Friedrich Gauss 1809 Least Squares; Trevor Hastie, Robert Tibshirani, Jerome Friedman *The Elements of Statistical Learning (ESL)* Chapters 3 & 4; Christopher Bishop *PRML* Chapter 3–4; Kevin Murphy *PML* Chapter 10–11):
* **1. Linear Regression & Ordinary Least Squares (OLS):**
  - Linear Hypothesis: $\mathbf{\hat{y} = X\theta = \theta_0 + \theta_1 x_1 + \dots + \theta_d x_d}$.
  - Residual Sum of Squares Loss: $\mathbf{J(\theta) = \frac{1}{2m} \|X\theta - y\|_2^2 = \frac{1}{2m} (X\theta - y)^T (X\theta - y)}$.
  - **The Closed-Form Normal Equation:**
    $$\mathbf{\nabla_\theta J(\theta) = 0 \implies \mathbf{\theta^* = (X^T X)^{-1} X^T y}}$$
    - *Geometric Interpretation:* Orthogonal projection of target vector $y$ onto the column space of design matrix $X$.
    - *Invertibility Hazard:* Requires $X^T X$ to be non-singular (fails under multicollinearity or when features $d >$ samples $m$).
* **2. Regularization Geometry: Ridge ($L_2$) vs Lasso ($L_1$):**
  - **Ridge Regression ($L_2$ Tikhonov Regularization):**
    - Objective: $J_{\text{Ridge}}(\theta) = \text{MSE} + \mathbf{\lambda \|\theta\|_2^2 = \text{MSE} + \lambda \sum_{j=1}^d \theta_j^2}$.
    - Analytical Solution: $\mathbf{\theta = (X^T X + \lambda I)^{-1} X^T y}$ (Guarantees invertibility!).
    - *Geometry:* Spherical/circular $L_2$ contour. Shrinks coefficients towards zero, but never produces exact zeroes.
  - **Lasso Regression ($L_1$ Least Absolute Shrinkage and Selection Operator):**
    - Objective: $J_{\text{Lasso}}(\theta) = \text{MSE} + \mathbf{\lambda \|\theta\|_1 = \text{MSE} + \lambda \sum_{j=1}^d |\theta_j|}$.
    - *Geometry:* Diamond/cross-polytope with sharp vertices along the coordinate axes.
    - *Sparse Feature Selection:* The elliptic MSE loss contours hit the diamond corners first, forcing non-informative feature weights to **exactly zero ($\theta_j = 0$)**!
* **3. Logistic Regression for Binary Classification:**
  - Probability Hypothesis (Sigmoid / Logistic Link Function):
    $$\mathbf{P(y=1|x; \theta) = h_\theta(x) = \mathbf{\sigma(\theta^T x) = \frac{1}{1 + e^{-\theta^T x}}}}$$
  - **Odds Ratio and Log-Odds (Logit):**
    $$\mathbf{\text{Odds} = \frac{p}{1-p} \implies \mathbf{\ln\left(\frac{p}{1-p}\right) = \theta^T x = \theta_0 + \theta_1 x_1 + \dots + \theta_d x_d}}$$
  - Linear Decision Boundary: $\theta^T x = 0 \implies P(y=1|x) = 0.5$.
* **4. Maximum Likelihood Estimation & Binary Cross-Entropy (Log-Loss):**
  - Squared error is non-convex for sigmoid outputs; instead, Maximum Likelihood Estimation yields **Binary Cross-Entropy Loss (Log-Loss)**:
    $$\mathbf{\mathcal{L}(\theta) = -\frac{1}{m} \sum_{i=1}^m \Big[ y^{(i)} \ln(h_\theta(x^{(i)})) \ + \ (1 - y^{(i)}) \ln(1 - h_\theta(x^{(i)})) \Big]}$$
  - Gradient Descent Update Equation (Convex Optimization):
    $$\mathbf{\theta \leftarrow \theta - \alpha \frac{1}{m} X^T \big(\sigma(X\theta) - y\big)}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Regression & Classification Progression
* Linear Model $\to$ OLS Residuals $\to$ Normal Equation $\to$ Gradient Descent.
* Overfitting $\to$ Regularization ($L_2$ Smooth Shrinkage vs $L_1$ Sharp Sparse Corners).
* Classification $\to$ Probability Bounds $\to$ Sigmoid $\to$ Log-Odds.
* Convex Optimization $\to$ MLE $\to$ Binary Cross-Entropy Gradient Step.

### 2. Top Recommended Resources
* **The Definitive Textbook:** *The Elements of Statistical Learning (ESL)* (Trevor Hastie, Robert Tibshirani, Jerome Friedman), Chapters 3 & 4.
* **Pattern Recognition Classic:** *Pattern Recognition and Machine Learning (PRML)* (Christopher Bishop), Chapters 3 & 4.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive the OLS Normal Equation $\theta = (X^T X)^{-1} X^T y$ from $\nabla_\theta J = 0$?
- [ ] Can you explain the geometric diamond intuition of why Lasso ($L_1$) causes exact sparsity?
- [ ] Can you convert between a Sigmoid probability $P(y=1|x)$ and Log-Odds $\theta^T x$?
- [ ] Can you write and compute the Binary Cross-Entropy loss for a dataset?
