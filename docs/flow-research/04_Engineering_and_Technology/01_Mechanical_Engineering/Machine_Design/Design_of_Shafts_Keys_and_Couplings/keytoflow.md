# Key to Flow: Design of Shafts, Keys, & Couplings (Machine Design Elements)

**Subject Area:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Shafts_Keys_and_Couplings`

---

## 📌 Core Concept & Mental Model
**Transmission Shaft Fatigue Sizing under Combined Fluctuating Bending and Steady Torsion (ASME Code & DE-Goodman Criterion $d = \left[\frac{16 n}{\pi}\left(\frac{2 K_f M_a}{S_e} + \frac{\sqrt{3} K_{fs} T_m}{S_{ut}}\right)\right]^{1/3}$), Equivalent Twisting/Bending Moments ($T_e = \sqrt{M^2 + T^2}, \ M_e = \frac{1}{2}(M + \sqrt{M^2 + T^2})$), Sunk Key Design under Dual Failure Modes (Shear $\tau = \frac{2T}{d w L} \le \tau_{\text{allow}}$ vs Crushing $\sigma_c = \frac{4T}{d h L} \le \sigma_{c,\text{allow}}$), Involute Splined Shaft Torque Capacity, Rigid Flanged Coupling Bolt Shear Sizing ($\tau_{\text{bolt}} = \frac{8T}{\pi d_b^2 D_c N_b} \le \tau_{\text{allow}}$), and Flexible Bushed-Pin Couplings for Misalignment Compensation** govern mechanical powertrain transmission systems (Richard G. Budynas, J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 7 & 8; Robert L. Norton *Machine Design: An Integrated Approach* Chapter 9 & 10; V.B. Bhandari *Design of Machine Elements* Chapter 9):
* **1. Transmission Shaft Fatigue Design (DE-Goodman & ASME):**
  - Standard Rotating Shaft: Bending stress is completely reversed ($M_m = 0, M_a = M$), while Torsion is steady ($T_a = 0, T_m = T$):
    $$\mathbf{d = \left[ \frac{16 n}{\pi} \left( \frac{2 K_f M}{S_e} + \frac{\sqrt{3} K_{fs} T}{S_{ut}} \right) \right]^{1/3}}$$
  - **Static Maximum Shear Stress (Tresca) Invariant:**
    $$\mathbf{T_e = \sqrt{M^2 + T^2} \implies d = \left(\frac{16 T_e}{\pi \tau_{\text{allow}}}\right)^{1/3} \quad \Big| \quad M_e = \frac{1}{2}\left(M + \sqrt{M^2 + T^2}\right)}$$
* **2. Design of Sunk Keys (Shear vs Crushing Failure):**
  - Tangential Force on Key: $F = \frac{2 T}{d}$ (where $d$ is shaft diameter).
  - **Shear Stress Failure Mode:**
    $$\mathbf{\tau = \frac{F}{w \cdot L} = \frac{2 T}{d \cdot w \cdot L} \le \tau_{\text{allow}}}$$
  - **Crushing (Bearing Compression) Failure Mode:**
    $$\mathbf{\sigma_c = \frac{F}{(h/2) \cdot L} = \frac{4 T}{d \cdot h \cdot L} \le \sigma_{c,\text{allow}}}$$
  - **Equal Strength Sunk Key Invariant:** For standard ductile steels where $\sigma_{c,\text{allow}} \approx 2 \tau_{\text{allow}}$, a **Square Key ($w = h = d/4$)** possesses **EXACTLY EQUAL strength against shear and crushing**!
* **3. Rigid & Flexible Flange Couplings:**
  - **Rigid Flanged Coupling (Bolt Shear Design):**
    $$\mathbf{T = N_b \cdot \left(\frac{\pi}{4} d_b^2 \tau_b\right) \cdot \frac{D_c}{2} \implies \mathbf{\tau_b = \frac{8 T}{\pi d_b^2 D_c N_b} \le \tau_{\text{allow}}}}$$
    - $N_b$: Number of fitted bolts (typically 3, 4, 6, or 8);
    - $D_c$: Pitch Circle Diameter of the bolt circle ($D_c = 3 d$);
    - $d_b$: Nominal diameter of bolts.
  - **Flexible Bushed-Pin Coupling:** Rubber bushes isolate high-frequency torsional shock waves and accommodate angular ($\le 2^\circ$) and lateral ($\le 0.5\text{ mm}$) shaft misalignments.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Machine Design Problem-Solving Spectrum
* Load Diagramming $\to$ Construct free-body diagrams $\to$ Draw SFD and BMD $\to$ Identify maximum resultant bending moment $M = \sqrt{M_y^2 + M_z^2}$ and torque $T$.
* Shaft Fatigue Sizing $\to$ Apply DE-Goodman criterion with stress concentration factors $K_f, K_{fs}$ to solve required diameter $d$.
* Key Selection $\to$ Standardize key dimensions ($w = d/4, h = d/4$) $\to$ Calculate required key length $L = \max(L_{\text{shear}}, L_{\text{crushing}})$.
* Coupling Sizing $\to$ Size hub outer diameter $D_{\text{hub}} = 2d$, pitch circle $D_c = 3d \to$ Size bolts $d_b$ using shear equation $\tau = \frac{8T}{\pi d_b^2 D_c N_b}$.

### 2. Top Recommended Resources
* **The Machine Design Standard:** *Shigley's Mechanical Engineering Design* (Richard G. Budynas, J. Keith Nisbett, McGraw-Hill 11th ed. Chapter 7).
* **The Applied Design Textbook:** *Design of Machine Elements* (V.B. Bhandari, McGraw-Hill 4th ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you calculate the shaft diameter $d$ under combined bending and torsion using the ASME / DE-Goodman equation?
- [ ] Can you determine whether a square key fails first by shear or by crushing?
- [ ] Can you calculate the required key length $L$ to transmit a specified torque $T$?
- [ ] Can you size the bolts for a rigid flange coupling using the pitch circle shear equation?
- [ ] Can you explain why flexible bushed-pin couplings protect bearings from shaft misalignment damage?
