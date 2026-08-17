# Key to Flow: Perturbation Theory (Time-Independent & Time-Dependent)

**Subject Area:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Perturbation_Theory_Time_Dependent_and_Independent`

---

## 📌 Core Concept & Mental Model
**Quantum Perturbation Theory** approximates the energy spectra, eigenstates, and transition dynamics of complex Hamiltonians $\hat{H} = \hat{H}_0 + \lambda \hat{H}'$ ($\lambda \ll 1$):
* **Non-Degenerate Time-Independent Perturbation Theory (Rayleigh-Schrödinger):**
  - **1st-Order Energy Shift:** $E_n^{(1)} = \langle n^{(0)} | \hat{H}' | n^{(0)} \rangle$.
  - **1st-Order Wavefunction Correction:** $|n^{(1)}\rangle = \sum_{k \ne n} \frac{\langle k^{(0)} | \hat{H}' | n^{(0)} \rangle}{E_n^{(0)} - E_k^{(0)}} |k^{(0)}\rangle$.
  - **2nd-Order Energy Shift:** $E_n^{(2)} = \sum_{k \ne n} \frac{|\langle k^{(0)} | \hat{H}' | n^{(0)} \rangle|^2}{E_n^{(0)} - E_k^{(0)}}$.
  *(Note: Ground state 2nd-order energy correction $E_0^{(2)} \le 0$ is ALWAYS non-positive!).*
* **Degenerate Perturbation Theory (Subspace Diagonalization):**
  - Diagonalize the perturbation matrix within the $g$-fold degenerate subspace:
    $$\det\left( W_{ij} - E^{(1)} \delta_{ij} \right) = 0, \qquad W_{ij} \equiv \langle \psi_i^{(0)} | \hat{H}' | \psi_j^{(0)} \rangle$$
* **Atomic Applications:**
  - **Hydrogen Fine Structure ($\sim \alpha^4 m c^2 \sim 10^{-4}\text{ eV}$):** Relativistic kinetic correction $+ \mathbf{L}\cdot\mathbf{S}$ Spin-Orbit $+ \text{Darwin term} \implies E_{nj} = -\frac{13.6\text{ eV}}{n^2}\left[1 + \frac{\alpha^2}{n^2}\left(\frac{n}{j+1/2} - \frac{3}{4}\right)\right]$.
  - **Zeeman Effect (Magnetic Field $\mathbf{B}$):** Weak field splits states by $\Delta E = \mu_B g_J B m_j$ (Landé $g$-factor); Strong field (Paschen-Back) uncouples $\mathbf{L}$ and $\mathbf{S}$.
  - **Stark Effect (Electric Field $\mathbf{E}$):** Linear Stark effect in degenerate hydrogen $n=2$; Quadratic Stark effect in non-degenerate ground states.
* **Time-Dependent Perturbation Theory & Transition Dynamics:**
  - **Fermi's Golden Rule (Enrico Fermi, 1927):**
    $$\Gamma_{i \to f} = \frac{2\pi}{\hbar} |\langle f | \hat{V} | i \rangle|^2 \rho(E_f)$$
    where $\rho(E_f)$ is the final density of states.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Conceptual "Good States" Framework
* In degenerate subspaces, pick mutually commuting operators $[\hat{A}, \hat{H}_0] = 0 = [\hat{A}, \hat{H}']$ to immediately diagonalize the perturbation without calculating full secular determinants!

### 2. Top Recommended Resources
* **The Definitive Standard Text:** *Introduction to Quantum Mechanics* by David J. Griffiths (Chapters 6–7, 9).
* **Operator & Theoretical Masterpiece:** *Modern Quantum Mechanics* by J.J. Sakurai & Jim Napolitano (Chapters 5).
* **Comprehensive Quantum Guide:** *Quantum Mechanics (Vol. II)* by Claude Cohen-Tannoudji (Chapters XI, XIII).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute 1st- and 2nd-order energy corrections for perturbed infinite square wells and harmonic oscillators?
- [ ] Can you set up and diagonalize the $2 \times 2$ or $4 \times 4$ degenerate secular determinant $\det(W - E^{(1)}I) = 0$?
- [ ] Can you calculate the Landé $g$-factor $g_J = 1 + \frac{j(j+1) + s(s+1) - l(l+1)}{2j(j+1)}$?
- [ ] Can you evaluate transition rates and decay lifetimes using Fermi's Golden Rule?
