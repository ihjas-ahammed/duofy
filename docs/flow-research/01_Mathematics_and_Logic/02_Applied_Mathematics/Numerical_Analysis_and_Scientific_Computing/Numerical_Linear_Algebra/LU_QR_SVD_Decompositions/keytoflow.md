# Key to Flow: LU, QR, and SVD Decompositions (Numerical Linear Algebra)

**Subject Area:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / LU_QR_SVD_Decompositions`

---

## 📌 Core Concept & Mental Model
**Matrix Factorizations** form the backbone of Numerical Linear Algebra, transforming dense computational problems into structured, backward-stable canonical forms:
* **LU Decomposition ($P A = L U$):** Gaussian elimination with row permutations $P$, unit lower-triangular $L$, and upper-triangular $U$ ($\frac{2}{3}n^3$ flops to factor, $\mathcal{O}(n^2)$ forward/backward substitution).
* **QR Decomposition ($A = Q R$):** Column orthogonalization with unitary $Q$ ($Q^* Q = I$) and upper-triangular $R$ via Householder reflectors $H = I - 2\frac{v v^*}{v^* v}$ ($\frac{4}{3}n^3$ flops for square matrices).
* **Singular Value Decomposition (SVD / The Master Factorization):**
  $$A = U \Sigma V^* = \sum_{j=1}^r \sigma_j u_j v_j^*$$
  Geometrically: Any linear map transforms the unit sphere into a hyper-ellipsoid with principal semi-axis lengths $\sigma_1 \ge \sigma_2 \ge \dots \ge \sigma_r > 0$ along orthogonal directions $u_j$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Stability, Conditioning, and Backward Error
* **Condition Number $\kappa(A) = \|A\|_2 \|A^{-1}\|_2 = \frac{\sigma_{\max}}{\sigma_{\min}}$:** Governs sensitivity of linear systems $\frac{\|\delta x\|}{\|x\|} \le \kappa(A) \frac{\|\delta b\|}{\|b\|}$.
* **Householder vs Gram-Schmidt:** Classical Gram-Schmidt (CGS) suffers catastrophic loss of orthogonality; Modified Gram-Schmidt (MGS) improves stability; **Householder QR is backward stable to machine precision** $\epsilon_{\text{mach}}$.
* **Cholesky Factorization ($A = L L^*$):** For Symmetric Positive Definite (SPD) matrices, stable without pivoting in $\frac{1}{3}n^3$ flops (half the cost of LU!).

### 2. The Eckart-Young-Mirsky Theorem (Optimal Low-Rank Approximation)
* For any matrix $A$ and target rank $k < \operatorname{rank}(A)$, the **truncated SVD** $A_k = \sum_{j=1}^k \sigma_j u_j v_j^*$ is the unique best rank-$k$ approximation in both spectral and Frobenius norms:
  $$\|A - A_k\|_2 = \sigma_{k+1}, \qquad \|A - A_k\|_F = \sqrt{\sum_{j=k+1}^r \sigma_j^2}$$
* **Applications:** Principal Component Analysis (PCA), image compression, latent semantic analysis, and randomized NLA.

### 3. Top Recommended Resources
* **The Gold Standard Text:** *Numerical Linear Algebra* by Lloyd N. Trefethen & David Bau III.
* **The Comprehensive Reference:** *Matrix Computations* by Gene H. Golub & Charles F. Van Loan.
* **Accuracy and Stability:** *Accuracy and Stability of Numerical Algorithms* by Nicholas J. Higham.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute the $PA = LU$ factorization of a $3 \times 3$ matrix with partial pivoting?
- [ ] Can you construct a Householder reflector $v = x \pm \|x\| e_1$ that zeroes out subdiagonal vector entries?
- [ ] Can you compute the SVD of a rank-1 or rank-2 rectangular matrix by hand?
- [ ] Can you calculate the low-rank Frobenius approximation error using singular values?
