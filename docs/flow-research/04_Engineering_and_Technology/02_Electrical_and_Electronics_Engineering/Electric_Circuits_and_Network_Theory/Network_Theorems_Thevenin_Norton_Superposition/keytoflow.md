# Key to Flow: Network Theorems (Thévenin, Norton, Superposition, & Power Matching)

**Subject Area:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Network_Theorems_Thevenin_Norton_Superposition`

---

## 📌 Core Concept & Mental Model
**Superposition Theorem for Linear Multi-Source Networks ($v = \sum v_k, \ i = \sum i_k$), Source Transformations ($V_{\text{source}} = I_{\text{source}} R$), Thévenin Equivalent Circuits ($V_{th} = V_{oc}$ in series with $R_{th}$), Norton Equivalent Circuits ($I_N = I_{sc}$ in parallel with $R_N = R_{th}$), $R_{th}$ Evaluation Methods (Independent Deactivation, Open/Short Ratio $R_{th} = \frac{V_{oc}}{I_{sc}}$, and Test Source Method $R_{th} = \frac{v_{\text{test}}}{i_{\text{test}}}$ for Active Dependent Circuits), Maximum Power Transfer Theorem (DC: $R_L = R_{th} \implies P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}}$ with $50\%$ efficiency; AC: Complex Conjugate Matching $Z_L = Z_{th}^* = R_{th} - j X_{th}$), Millman's Parallel Branch Voltage Law ($V_m = \frac{\sum V_k G_k}{\sum G_k}$), and Tellegen's Universal Power Conservation Theorem ($\sum v_k i_k = 0$)** govern electrical network simplification and impedance matching (Charles K. Alexander, Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 4; James W. Nilsson, Susan A. Riedel *Electric Circuits* Chapter 4; William H. Hayt, Jack E. Kemmerly *Engineering Circuit Analysis* Chapter 5):
* **1. Superposition Theorem & Linearity:**
  $$\mathbf{v_{\text{total}} = \sum_{k=1}^N v_k \quad \Big| \quad i_{\text{total}} = \sum_{k=1}^N i_k}$$
  - **Deactivation Rules:** Voltage Source $\to$ Short Circuit ($V = 0$); Current Source $\to$ Open Circuit ($I = 0$).
  - **Dependent Sources & Power Invariants:** Dependent sources are **NEVER turned off**; Superposition applies **ONLY to linear voltages and currents, NEVER directly to power ($P \ne \sum P_k$)** because power is quadratic ($P = i^2 R$)!
* **2. Thévenin & Norton Equivalent Duals:**
  $$\mathbf{V_{th} = V_{oc} \quad \Big| \quad I_N = I_{sc} \quad \Big| \quad \mathbf{R_{th} = R_N = \frac{V_{oc}}{I_{sc}} = \frac{v_{\text{test}}}{i_{\text{test}}}} \quad \Big| \quad \mathbf{V_{th} = I_N R_{th}}}$$
  - **The Load Invariance Principle:** A complex multi-mesh active circuit behaves identically to a single voltage source $V_{th}$ in series with $R_{th}$ at its two access terminals $A-B$ for ANY connected load $R_L$!
* **3. Maximum Power Transfer Theorem (MPTT):**
  - **DC Resistive Networks:**
    $$\mathbf{R_L = R_{th} \implies \mathbf{P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}} \quad (\text{Efficiency } \eta = 50\%)}}$$
  - **AC Reactive Networks:**
    $$\mathbf{Z_L = Z_{th}^* = R_{th} - j X_{th} \implies \mathbf{P_{\text{max}} = \frac{|V_{th}|^2}{8 R_{th}} \ (\text{Peak}) = \frac{V_{\text{rms}}^2}{4 R_{th}}}}$$
    - If load is purely resistive ($R_L$ only): $\mathbf{R_L = |Z_{th}| = \sqrt{R_{th}^2 + X_{th}^2}}$.
* **4. Tellegen's & Millman's Theorems:**
  - **Tellegen's Theorem:** $\mathbf{\sum_{k=1}^B v_k i_k = 0}$ (holds for ANY network topology, linear or nonlinear, active or passive, time-invariant or time-varying!).
  - **Millman's Theorem:** $\mathbf{V_m = \frac{\sum_{k=1}^n V_k G_k}{\sum_{k=1}^n G_k} = \frac{\sum \frac{V_k}{R_k}}{\sum \frac{1}{R_k}}}$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Network Theorems Problem-Solving Spectrum
* Superposition $\to$ Deactivate sources one by one (Short $V$, Open $I$) $\to$ Solve sub-responses $\to$ Sum algebraically.
* Thévenin Sizing $\to$ Open terminals $\to$ Solve $V_{oc} = V_{th} \to$ Short terminals $\to$ Solve $I_{sc} = I_N \to$ Compute $R_{th} = V_{oc}/I_{sc}$.
* Active Dependent $R_{th} \to$ Turn off independent sources $\to$ Connect $v_{\text{test}} = 1\text{ V}$ at terminals $\to$ Solve injected current $i_{\text{test}} \to R_{th} = 1 / i_{\text{test}}$.
* Maximum Power Matching $\to$ Find Thévenin equivalent $V_{th}, R_{th} \to$ Set $R_L = R_{th} \to$ Compute $P_{\text{max}} = V_{th}^2 / (4 R_{th})$.
* AC Matching $\to$ Size $Z_L = R_{th} - j X_{th}$ to cancel internal reactive reactance $X_{th}$.

### 2. Top Recommended Resources
* **The Circuit Theory Classic:** *Fundamentals of Electric Circuits* (Charles K. Alexander, Matthew N.O. Sadiku, McGraw-Hill 7th ed. Chapter 4).
* **The Analysis Guide:** *Electric Circuits* (James W. Nilsson, Susan A. Riedel, Pearson 11th ed. Chapter 4).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you apply Superposition by shorting voltage sources and opening current sources?
- [ ] Can you explain why power cannot be calculated by adding individual power contributions from each source?
- [ ] Can you determine $V_{th}$ and $R_{th}$ for circuits with dependent sources using the test source method?
- [ ] Can you calculate the maximum power transferred to a load $R_L$ in both DC and AC circuits?
- [ ] Can you apply Millman's theorem to reduce parallel voltage source branches into a single equivalent source?
