# Key to Flow: Indeterminate Frames (Slope-Deflection & Hardy Cross Distribution)

**Subject Area:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Slope_Deflection_and_Moment_Distribution`

---

## 📌 Core Concept & Mental Model
**Displacement-Based Structural Analysis Methods: Fixed-End Moments ($\text{FEM}_{AB} = \mp \frac{w L^2}{12}$ for UDL, $\mp \frac{P L}{8}$ for point load), George Maney's Slope-Deflection Equations ($M_{AB} = \text{FEM}_{AB} + \frac{2 E I}{L} (2\theta_A + \theta_B - 3\psi)$), Modified Slope-Deflection for Pinned Far Ends ($M_{AB} = \text{FEM}_{AB} - \frac{\text{FEM}_{BA}}{2} + \frac{3 E I}{L}(\theta_A - \psi)$), Multi-Story Frame Sidesway Shear Equilibrium ($\sum F_x = 0$), and Hardy Cross's Iterative Moment Distribution Method (Rotational Stiffness $K = \frac{4 E I}{L}$, Distribution Factors $\text{DF} = \frac{K}{\sum K}$, Carry-Over Factor $\text{COF} = +0.50$, and Successive Joint Relaxation Cycles)** govern continuous reinforced concrete bridge girders, high-rise building unbraced portal frames, and indeterminate structural engineering (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapters 11 & 12; Aslam Kassimali *Structural Analysis* 6th ed. Chapters 14 & 15; Hardy Cross 1930):
* **1. General Slope-Deflection Equations (Clockwise Positive):**
  $$\mathbf{M_{AB} = \text{FEM}_{AB} + \frac{2 E I}{L} \left( 2 \theta_A + \theta_B - 3 \frac{\Delta}{L} \right) \quad \Big| \quad \mathbf{M_{BA} = \text{FEM}_{BA} + \frac{2 E I}{L} \left( 2 \theta_B + \theta_A - 3 \frac{\Delta}{L} \right)}}$$
* **2. Standard Fixed-End Moment (FEM) Library:**
  $$\mathbf{\text{UDL } (w): \ \mathbf{\text{FEM}_{AB} = -\frac{w L^2}{12}, \ \text{FEM}_{BA} = +\frac{w L^2}{12}} \quad \Big| \quad \text{Center Load } (P): \ \mathbf{\text{FEM}_{AB} = -\frac{P L}{8}, \ \text{FEM}_{BA} = +\frac{P L}{8}}}$$
* **3. Hardy Cross Moment Distribution Parameters:**
  $$\mathbf{K_{\text{fixed}} = \frac{4 E I}{L} \quad \Big| \quad K_{\text{pinned}} = \frac{3 E I}{L} \quad \Big| \quad \mathbf{\text{DF}_{ij} = \frac{K_{ij}}{\sum K_i}} \quad \Big| \quad \mathbf{\text{COF} = +\frac{1}{2}}}$$
* **4. Hardy Cross Balancing Operation:**
  $$\mathbf{M_{\text{dist}} = - \text{DF}_{ij} \cdot \left( \sum M_{\text{unbalanced}} \right) \quad \Big| \quad \mathbf{M_{\text{carry}} = +0.50 \cdot M_{\text{dist}}}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Indeterminate Beam & Frame Problem-Solving Spectrum
* Kinematic Indeterminacy $\to$ Identify unknown degrees of freedom: joint rotations $\theta_B, \theta_C$ and sidesway translations $\Delta$.
* Fixed-End Moments $\to$ Clamp all joints $\to$ Compute standard FEMs using sign convention (Clockwise $= +$, Counter-Clockwise $= -$).
* Slope-Deflection Setup $\to$ Express member end moments $M_{ij}$ in terms of $\theta_i, \theta_j, \psi \to$ Enforce joint moment equilibrium $\sum M_j = 0 \to$ Solve system of simultaneous equations $\to$ Back-substitute to find final end moments.
* Frame Sidesway Equilibrium $\to$ If frame is asymmetric or carries lateral wind load $\to$ Isolate columns $\to$ Formulate story shear equation $\sum F_x = 0 \implies \frac{M_{AB} + M_{BA}}{h} + \frac{M_{DC} + M_{CD}}{h} + P_{\text{lateral}} = 0$.
* Hardy Cross Table $\to$ Compute relative stiffnesses $K \to$ Compute DFs ($\sum \text{DF} = 1.0$ at rigid joints, $0$ at fixed wall, $1.0$ at pin) $\to$ Iteratively Lock, Balance, and Carry Over until unbalanced moment $< 0.1\text{ kNm}$.

### 2. Top Recommended Resources
* **The Global Standard:** *Structural Analysis* (Russell C. Hibbeler, Pearson 10th ed. Chapters 11 & 12).
* **The Classical Foundation:** *Analysis of Continuous Frames by Distributing Fixed-End Moments* (Hardy Cross, Proceedings of the ASCE 1930).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you write the slope-deflection equations for continuous beams and frames accounting for chord rotation $\psi = \Delta/L$?
- [ ] Can you formulate the horizontal story shear equation for an unbraced frame undergoing lateral sidesway?
- [ ] Can you calculate distribution factors (DF) and carry-over moments in a multi-span continuous beam?
- [ ] Can you use modified stiffness $K = 3EI/L$ for pin/roller terminated end spans to eliminate carry-over cycles?
