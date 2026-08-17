# Key to Flow: Hydraulic Turbines & Pumps (Turbomachinery & Cavitation)

**Subject Area:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Hydraulic_Turbines_and_Pumps`

---

## 📌 Core Concept & Mental Model
**The Euler Turbomachine Equation ($w_{\text{euler}} = u_2 V_{t2} - u_1 V_{t1}$), Blade Velocity Triangles ($\mathbf{V} = \mathbf{u} + \mathbf{W}$), Centrifugal Pump Impeller Kinematics (Backward-Curved $\beta_2 < 90^\circ$ Self-Limiting Stability), Dynamic Pump Affinity Scaling Laws ($Q \propto N D^3, \ H \propto N^2 D^2, \ P \propto N^3 D^5$), Hydraulic Turbine Classification (Impulse Pelton Wheel High-Head $H > 300\text{ m}$ vs Reaction Francis Medium-Head vs Axial Kaplan Low-Head $H < 30\text{ m}$), Dimensionless Specific Speed ($N_s = \frac{N \sqrt{Q}}{H^{3/4}}$ / $N_{st} = \frac{N \sqrt{P}}{H^{5/4}}$), Net Positive Suction Head Margins ($\text{NPSH}_{\text{available}} \ge \text{NPSH}_{\text{required}}$), and Impeller Cavitation Mitigation** govern fluid machinery and hydroelectric power plant engineering (Frank M. White *Fluid Mechanics* Chapter 11; S.M. Yahya *Turbines, Compressors and Fans*; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 12):
* **1. Euler Turbomachine Equation & Velocity Triangles:**
  $$\mathbf{w_{\text{euler}} = \frac{T \omega}{\dot{m}} = u_2 V_{t2} - u_1 V_{t1} \quad \Big| \quad H_{\text{euler}} = \frac{u_2 V_{t2} - u_1 V_{t1}}{g}}$$
  - **Vector Triangle Decomposition:**
    - $\mathbf{V}$: Absolute fluid velocity vector.
    - $\mathbf{u} = \omega r = \frac{2 \pi N r}{60}$: Tangential blade speed.
    - $\mathbf{W}$: Relative fluid velocity across the blade surface ($\mathbf{V} = \mathbf{u} + \mathbf{W}$).
    - $\mathbf{V_t} = V \cos\alpha$: Whirl / tangential velocity component (generates torque).
    - $\mathbf{V_f} = V \sin\alpha$: Flow / meridional velocity component (carries mass flow $Q$).
* **2. Centrifugal Pumps & The Affinity Laws:**
  - **Backward-Curved Blades ($\beta_2 < 90^\circ$):** Provides stable drooping $H-Q$ curve, self-limiting power consumption, and peak hydraulic efficiency $>85\%$.
  - **Pump Affinity Scaling Laws (Constant Efficiency):**
    $$\mathbf{\frac{Q_1}{Q_2} = \left(\frac{N_1}{N_2}\right)\left(\frac{D_1}{D_2}\right)^3 \quad \Big| \quad \mathbf{\frac{H_1}{H_2} = \left(\frac{N_1}{N_2}\right)^2\left(\frac{D_1}{D_2}\right)^2} \quad \Big| \quad \mathbf{\frac{P_1}{P_2} = \left(\frac{N_1}{N_2}\right)^3\left(\frac{D_1}{D_2}\right)^5}}$$
* **3. Hydraulic Turbines Classification:**
  $$\begin{array}{|l|l|l|l|l|}
  \hline
  \textbf{Turbine Type} & \textbf{Working Principle} & \textbf{Head Range } H & \textbf{Discharge } Q & \textbf{Specific Speed } N_{st} \\
  \hline
  \mathbf{\text{Pelton Wheel}} & \mathbf{\text{Impulse (Jet in air)}} & \mathbf{H > 300\text{ m (High)}} & \text{Low Discharge} & N_{st} \approx 10 - 50 \text{ (Low)} \\
  \mathbf{\text{Francis Turbine}} & \mathbf{\text{Mixed Inward Reaction}} & \mathbf{30 - 300\text{ m (Medium)}} & \text{Medium Flow} & N_{st} \approx 60 - 300 \text{ (Medium)} \\
  \mathbf{\text{Kaplan / Propeller}} & \mathbf{\text{Axial Reaction (Propeller)}} & \mathbf{H < 30\text{ m (Low)}} & \mathbf{\text{High Flow (Rivers)}} & \mathbf{N_{st} \approx 300 - 1000 \text{ (High)}} \\
  \hline
  \end{array}$$
* **4. Net Positive Suction Head (NPSH) & Cavitation Invariant:**
  $$\mathbf{\text{NPSH}_{\text{available}} = \frac{P_{\text{atm}} - P_{\text{vapor}}}{\rho g} - z_{\text{suction}} - h_{f,\text{suction}} \ge \mathbf{\text{NPSH}_{\text{required}}}}$$
  - If $\text{NPSH}_A < \text{NPSH}_R$, static pressure at the pump impeller eye drops below vapor pressure $P_v$, causing violent cavitation bubbles, pitting, vibration, and loss of pump prime!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Turbomachinery Problem-Solving Spectrum
* Velocity Triangle $\to$ Draw inlet/outlet triangles $\to$ Calculate $u = \omega r, V_t, V_f \to$ Apply Euler equation $w_{\text{euler}} = u_2 V_{t2} - u_1 V_{t1}$.
* Affinity Scaling $\to$ Adjust pump speed $N_1 \to N_2 \to$ Scale $Q \propto N, H \propto N^2, P \propto N^3$.
* Turbine Selection $\to$ Given head $H$ and power $P \to$ Compute specific speed $N_{st} \to$ Choose Pelton vs Francis vs Kaplan.
* Suction Installation $\to$ Compute $\text{NPSH}_A = \frac{P_{\text{atm}}-P_v}{\gamma} - z_s - h_{fs} \to$ Verify $\text{NPSH}_A \ge \text{NPSH}_R$.

### 2. Top Recommended Resources
* **The Fluid Machinery Standard:** *Fluid Mechanics* (Frank M. White, McGraw-Hill 8th/9th ed.).
* **The Turbomachinery Classic:** *Turbines, Compressors and Fans* (S.M. Yahya, McGraw-Hill 4th ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you construct inlet and outlet velocity triangles for a centrifugal pump impeller?
- [ ] Can you apply the Affinity Laws to predict new head $H_2$ and power $P_2$ when pump speed doubles ($N_2 = 2 N_1$)?
- [ ] Can you select the optimal turbine (Pelton, Francis, or Kaplan) given a hydro site's available head and flow?
- [ ] Can you calculate the maximum allowable suction lift height $z_s$ to prevent pump cavitation ($\text{NPSH}_A \ge \text{NPSH}_R$)?
