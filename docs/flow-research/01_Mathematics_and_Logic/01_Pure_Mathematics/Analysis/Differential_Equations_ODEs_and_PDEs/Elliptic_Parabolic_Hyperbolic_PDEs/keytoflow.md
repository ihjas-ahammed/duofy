# Key to Flow: Elliptic, Parabolic, and Hyperbolic PDEs (Analysis)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Elliptic_Parabolic_Hyperbolic_PDEs`

---

## 📌 Core Concept & Mental Model
Second-order linear PDEs in two variables:
$$A u_{xx} + B u_{xy} + C u_{yy} + D u_x + E u_y + F u = G$$
are classified by the **Discriminant $\Delta = B^2 - 4AC$**, mirroring conic sections:

| PDE Type | Discriminant $\Delta = B^2 - 4AC$ | Prototype Equation | Physical Phenomenon | Propagation Speed | Characteristic Curves |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Elliptic** | $\Delta < 0$ | Laplace $\Delta u = 0$ | Equilibrium / Steady-State | Omnidirectional / Infinite | Complex (No real characteristics) |
| **Parabolic** | $\Delta = 0$ | Heat $u_t = k u_{xx}$ | Diffusion / Dissipation | Infinite (Time-asymmetric) | 1 family of real characteristics |
| **Hyperbolic** | $\Delta > 0$ | Wave $u_{tt} = c^2 u_{xx}$ | Waves / Vibrations / Transport | Finite speed ($c$) | 2 families of real characteristics |

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Characteristic Coordinates & Canonical Forms
Solve the characteristic ODE:
$$\frac{dy}{dx} = \frac{B \pm \sqrt{B^2 - 4AC}}{2A}$$
* **Hyperbolic ($\Delta > 0$):** Two real coordinates $\xi(x, y), \eta(x, y) \implies u_{\xi\eta} = \dots$ (d'Alembert wave solution $u(x, t) = f(x-ct) + g(x+ct)$).
* **Parabolic ($\Delta = 0$):** One real coordinate $\xi(x, y)$ and independent $\eta \implies u_{\eta\eta} = \dots$
* **Elliptic ($\Delta < 0$):** Complex coordinates $\xi + i\eta \implies u_{\alpha\alpha} + u_{\beta\beta} = \dots$ (Laplace-type canonical form).

### 2. Qualitative Properties & Theorems
* **Maximum Principles:**
  * **Elliptic & Parabolic:** Satisfy the Strong and Weak Maximum Principles (extrema of $u$ occur strictly on the boundary $\partial \Omega$ or initial time slice).
  * **Hyperbolic:** Fails maximum principles; preserves energy ($\frac{1}{2} \int (u_t^2 + c^2 u_x^2) dx = \text{const}$) and propagates discontinuities along characteristics.
* **Well-Posedness (Hadamard):**
  * Elliptic PDEs require **Dirichlet/Neumann Boundary Conditions** on closed domains.
  * Parabolic PDEs require **Initial-Boundary Value Conditions** ($t \ge 0$).
  * Hyperbolic PDEs require **Cauchy Initial Conditions** ($u(x, 0)$ and $u_t(x, 0)$).

### 3. Top Recommended Resources
* **The Definitive Reference:** *Partial Differential Equations* by Lawrence C. Evans (Chapters 2, 6, 7).
* **Applied & Intuitive:** *Partial Differential Equations for Scientists and Engineers* by Stanley J. Farlow.
* **Classical Foundation:** *Methods of Mathematical Physics* by Courant & Hilbert (Vol. II).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute $B^2 - 4AC$ to classify a PDE with variable coefficients at various points in the plane?
- [ ] Can you find the characteristic curves and reduce a hyperbolic PDE to canonical form $u_{\xi\eta} = 0$?
- [ ] Can you apply the Weak Maximum Principle to prove uniqueness of solutions to Poisson's equation?
- [ ] Can you determine the domain of dependence and range of influence for the 1D wave equation?
