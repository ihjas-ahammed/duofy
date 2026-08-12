# Key to Flow: Differential Equations (ODEs and PDEs)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs`

---

## 📌 Core Concept & Mental Model
Differential Equations describe how physical quantities change continuously in space and time. 
* **Ordinary Differential Equations (ODEs):** Single independent variable (e.g. time $t$).
* **Partial Differential Equations (PDEs):** Multiple independent variables (e.g. space $x, y, z$ and time $t$).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Classification & Solution Taxonomy
* **ODEs:**
  * **Picard-Lindelöf Existence & Uniqueness Theorem:** Guarantees unique local solution if $f(t, y)$ is Lipschitz continuous.
  * **Linear Systems:** $\dot{x} = A x \implies x(t) = e^{A t} x(0)$ (Matrix Exponential).
* **PDEs (The Three Canonicals):**
  1. **Elliptic (Laplace Eq $\Delta u = 0$):** Steady-state equilibrium, smooth solutions (harmonic functions).
  2. **Parabolic (Heat Eq $u_t = \Delta u$):** Diffusion, infinite speed of propagation, smoothing over time.
  3. **Hyperbolic (Wave Eq $u_{tt} = c^2 \Delta u$):** Waves, finite propagation speed, characteristics $x \pm c t$.

### 2. Methodological Toolbox
* **Analytical Techniques:** Separation of Variables, Method of Characteristics, Green's Functions, Fourier & Laplace Transforms.
* **Modern Weak Solutions:** Sobolev spaces $H^1(\Omega)$, Variational Formulations, and Lax-Milgram Theorem.

### 3. Top Recommended Resources
* **Intuitive ODEs:** *Ordinary Differential Equations* by Morris Tenenbaum & Harry Pollard.
* **Dynamical Systems ODEs:** *Nonlinear Dynamics and Chaos* by Steven Strogatz.
* **Standard PDE Text:** *Partial Differential Equations* by Lawrence C. Evans (The ultimate graduate PDE reference).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute matrix exponential $e^{A t}$ using eigenvalues and eigenvectors?
- [ ] Can you solve 1D Wave Equation using d'Alembert's formula $u(x,t) = \frac{1}{2}[g(x-ct) + g(x+ct)]$?
- [ ] Can you solve 1D Heat Equation on bounded domain using Separation of Variables?
- [ ] Can you use Method of Characteristics to solve first-order quasilinear PDEs?
