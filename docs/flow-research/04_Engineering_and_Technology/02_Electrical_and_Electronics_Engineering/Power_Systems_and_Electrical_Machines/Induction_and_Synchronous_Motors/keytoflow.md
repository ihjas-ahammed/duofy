# Key to Flow: Rotating AC Machinery (Induction & Synchronous Motors)

**Subject Area:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Induction_and_Synchronous_Motors`

---

## 📌 Core Concept & Mental Model
**Three-Phase Induction Motor Rotating Magnetic Field (RMF), Slip ($s = \frac{n_s - n_m}{n_s}$), IEEE Per-Phase Equivalent Circuit ($R_1, X_1, R_c, X_m, R_2'/s, X_2'$), the Power Flow Ratio Triangle ($P_{ag} : P_{rcu} : P_{conv} = 1 : s : (1 - s)$), Induced Torque Mechanics ($\tau_{ind} = P_{ag}/\omega_s$), Maximum Pullout Breakdown Torque ($\tau_{\text{max}}$ and its complete independence of rotor resistance $R_2'$), Cylindrical & Salient Synchronous Motor Power-Angle Dynamics ($P = \frac{3 V_\phi E_A}{X_s} \sin\delta$), and Synchronous Motor V-Curves (Under-excitation lagging PF vs Over-excitation leading PF Synchronous Condenser operation)** govern heavy industrial drives, locomotive traction, and high-voltage grid reactive power stabilization (Stephen J. Chapman *Electric Machinery Fundamentals* 5th ed. Chapters 6, 7; A. E. Fitzgerald *Electric Machinery* 7th ed. Chapters 4, 5, 6; P. C. Sen *Principles of Electric Machines* 3rd ed.):
* **1. Induction Motor Power Flow Proportion Triple:**
  $$\mathbf{P_{ag} : P_{rcu} : P_{conv} = 1 : s : (1 - s)}$$
  $$\mathbf{P_{rcu} = s \cdot P_{ag} \quad (\text{Rotor Copper Loss}) \quad \Big| \quad \mathbf{P_{conv} = (1 - s) \cdot P_{ag} = \tau_{ind} \cdot \omega_m} \quad (\text{Converted Mechanical Power})}$$
* **2. Induction Motor Breakdown Torque & Slip Formula:**
  $$\mathbf{s_{\text{max}} = \frac{R_2'}{\sqrt{R_{th}^2 + (X_{th} + X_2')^2}} \quad \Big| \quad \mathbf{\tau_{\text{max}} = \frac{3 V_{th}^2}{2\omega_s \left[ R_{th} + \sqrt{R_{th}^2 + (X_{th} + X_2')^2} \right]}}}$$
  - **The Rotor Resistance Invariant:** Maximum breakdown torque $\tau_{\text{max}}$ is **STRICTLY INDEPENDENT of rotor resistance $R_2'$**; increasing $R_2'$ shifts the maximum torque peak toward higher slips ($s_{\text{max}} \propto R_2'$), maximizing starting torque!
* **3. Synchronous Machine Power-Angle Torque Equation:**
  $$\mathbf{P_{3\phi} = \frac{3 V_{\phi} E_A}{X_s} \sin\delta \implies \mathbf{\tau_{ind} = \frac{3 V_{\phi} E_A}{\omega_s X_s} \sin\delta} \quad \left(\text{Static Stability Limit at } \delta = 90^\circ\right)}$$
* **4. Synchronous Motor Excitation & V-Curves:**
  $$\mathbf{\text{Under-Excited } (E_A \cos\delta < V_{\phi}) \implies \mathbf{\text{Lagging Power Factor (Absorbs } Q > 0\text{)}}}$$
  $$\mathbf{\text{Normal Excitation } (E_A \cos\delta = V_{\phi}) \implies \mathbf{\text{Unity Power Factor (Minimum Armature Current } I_A\text{)}}}$$
  $$\mathbf{\text{Over-Excited } (E_A \cos\delta > V_{\phi}) \implies \mathbf{\text{Leading Power Factor (Supplies } Q < 0 \implies \text{Synchronous Condenser})}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. AC Machinery Problem-Solving Spectrum
* Induction Motor Slip & Speeds $\to$ Compute synchronous speed $n_s = 120 f / P \to$ Compute slip $s = (n_s - n_m) / n_s \to$ Determine rotor electrical frequency $f_r = s f$.
* Power Flow Decomposition $\to$ Given air-gap power $P_{ag} \to$ Immediately calculate rotor copper loss $P_{rcu} = s P_{ag}$ and mechanical power $P_{conv} = (1-s)P_{ag} \to$ Deduct rotational losses to find shaft power $P_{\text{out}}$.
* Torque-Speed Scaling $\to$ To maximize starting torque at $s = 1.0 \to$ Solder external resistance into wound-rotor motor such that $s_{\text{max}} = 1.0 \implies R_{2,\text{total}}' = \sqrt{R_{th}^2 + (X_{th} + X_2')^2}$.
* Synchronous Motor Phasors $\to$ Keep power $P = 3 V_\phi I_A \cos\theta$ constant while sweeping field excitation current $I_F \to$ Trace locus of $I_A$ on V-Curve to find minimum current point at $\text{PF} = 1.0$.
* Synchronous Condenser Sizing $\to$ Run unloaded over-excited synchronous motor to inject pure reactive VARs ($Q$) into substation bus to cancel inductive factory motor loads.

### 2. Top Recommended Resources
* **The Global Standard:** *Electric Machinery Fundamentals* (Stephen J. Chapman, McGraw-Hill 5th ed. Chapters 6, 7).
* **The Theoretical Reference:** *Electric Machinery* (A. E. Fitzgerald, Charles Kingsley Jr., Stephen D. Umans, McGraw-Hill 7th ed. Chapters 4, 5, 6).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you apply the power flow ratio $P_{ag} : P_{rcu} : P_{conv} = 1 : s : (1-s)$ to compute rotor losses and converted mechanical power?
- [ ] Can you calculate the slip at maximum torque $s_{\text{max}}$ and prove that $\tau_{\text{max}}$ is independent of $R_2'$?
- [ ] Can you calculate the pullout torque and static stability power limit for a synchronous motor given $V_\phi, E_A, X_s$?
- [ ] Can you sketch and explain the synchronous motor V-Curves and differentiate between under-excited and over-excited operation?
