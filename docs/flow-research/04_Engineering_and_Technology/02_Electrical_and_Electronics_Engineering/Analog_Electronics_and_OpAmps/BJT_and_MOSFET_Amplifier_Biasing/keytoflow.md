# Key to Flow: Transistor Amplifiers (BJT & MOSFET Biasing, Small-Signal Models, & Topologies)

**Subject Area:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / BJT_and_MOSFET_Amplifier_Biasing`

---

## 📌 Core Concept & Mental Model
**Bipolar Junction Transistor (BJT) Forward-Active Biasing ($I_C = \beta I_B = I_S e^{V_{BE}/V_T}$, $V_{BE} \approx 0.7\text{ V}, V_{CE} > 0.2\text{ V}$), Four-Resistor Voltage-Divider $\beta$-Immunity Criterion ($R_{TH} = R_1 \parallel R_2 \le 0.1 (\beta + 1) R_E \implies I_C \approx \frac{V_{TH} - V_{BE}}{R_E}$), BJT Hybrid-$\pi$ Small-Signal Model ($g_m = \frac{I_C}{V_T} \approx \frac{I_C}{26\text{ mV}}, \ r_\pi = \frac{\beta}{g_m}, \ r_e = \frac{V_T}{I_E}, \ r_o = \frac{V_A}{I_C}$), MOSFET Saturation Biasing ($I_D = \frac{1}{2} k_n' \frac{W}{L} (V_{GS} - V_{th})^2 = \frac{1}{2} k_n V_{ov}^2$ for $V_{DS} \ge V_{ov}$), MOSFET Small-Signal Parameters ($g_m = \frac{2 I_D}{V_{ov}} = \sqrt{2 k_n I_D}, \ r_o = \frac{1}{\lambda I_D}$, $R_{\text{in}} = \infty$), Canonical Single-Stage Topologies (Common-Emitter / Common-Source for High Inverting Gain $A_v = -g_m R_L'$, Common-Collector / Common-Drain Emitter/Source Follower for Unity Gain Buffering $A_v \approx 1.0, \ R_{\text{out}} \approx r_e \text{ or } 1/g_m$, Common-Base / Common-Gate for Wideband Non-Inverting Current Buffers), and High-Frequency Bandwidth Limits via Miller's Theorem ($C_M = C_{gd}(1 - A_v)$)** govern analog integrated circuit and discrete amplifier engineering (Adel S. Sedra, Kenneth C. Smith *Microelectronic Circuits* 8th ed. Chapters 5, 6, 7; Behzad Razavi *Fundamentals of Microelectronics* 3rd ed. Chapters 4, 5, 6; Robert L. Boylestad *Electronic Devices and Circuit Theory* 11th ed. Chapters 3, 4, 5, 6):
* **1. BJT & MOSFET Transconductance Comparison:**
  $$\mathbf{g_{m,\text{BJT}} = \frac{I_C}{V_T} \approx \frac{I_C}{26\text{ mV}} \quad \Big| \quad \mathbf{g_{m,\text{MOS}} = \frac{2 I_D}{V_{GS} - V_{th}} = \sqrt{2 \mu_n C_{ox} \frac{W}{L} I_D}} \quad (g_{m,\text{BJT}} \gg g_{m,\text{MOS}})}$$
* **2. Voltage-Divider BJT Stiff Bias Invariant:**
  $$\mathbf{V_{TH} = V_{CC} \frac{R_2}{R_1 + R_2} \quad \Big| \quad R_{TH} = R_1 \parallel R_2 \le 0.1 (\beta + 1) R_E \implies \mathbf{I_C \approx I_E = \frac{V_{TH} - 0.7\text{ V}}{R_E}}}$$
* **3. Master Amplifier Topologies Comparison Matrix:**
  $$\begin{array}{|l|l|l|l|l|}
  \hline
  \textbf{Topology (BJT / MOS)} & \textbf{Voltage Gain } A_v & \textbf{Input Impedance } R_{\text{in}} & \textbf{Output Impedance } R_{\text{out}} & \textbf{Primary Function} \\
  \hline
  \mathbf{\text{CE / CS (Common Emitter/Source)}} & \mathbf{\text{High Inverting } (-g_m R_L')} & \text{Moderate } (r_\pi) \text{ / } \infty & \text{Moderate } (R_C \parallel r_o) & \text{Core Voltage Amplification} \\
  \mathbf{\text{CE with } R_E \text{ Degeneration}} & \mathbf{\approx -\frac{R_C \parallel R_L}{R_E + r_e}} & \mathbf{\text{High } [r_\pi + (\beta+1)R_E]} & \text{Moderate } (R_C) & \text{Linearized Gain, High } R_{\text{in}} \\
  \mathbf{\text{CC / CD (Emitter/Source Follower)}} & \mathbf{\approx +1.0 \ (\text{Non-inverting})} & \mathbf{\text{Very High / Infinite}} & \mathbf{\text{Ultra-Low } (r_e \parallel \frac{R_S}{\beta+1})} & \mathbf{\text{Impedance Buffer Driver}} \\
  \mathbf{\text{CB / CG (Common Base/Gate)}} & \mathbf{\text{High Non-Inverting } (+g_m R_L')} & \mathbf{\text{Ultra-Low } (r_e \text{ or } 1/g_m)} & \text{Moderate } (R_C) & \text{High-Freq / Current Buffer} \\
  \hline
  \end{array}$$
* **4. Miller's Theorem & Bandwidth Roll-off:**
  $$\mathbf{C_{\text{in,Miller}} = C_{\mu} (1 - A_v) = C_{\mu} (1 + g_m R_L') \quad \Big| \quad \mathbf{f_H \approx \frac{1}{2\pi R_{\text{sig}}' C_{\text{total}}}}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Transistor Circuit Problem-Solving Spectrum
* DC Operating Point $\to$ Turn OFF all AC sources and replace coupling/bypass capacitors with OPEN circuits $\to$ Solve for $I_C, I_D$ and verify Active/Saturation state ($V_{CE} > 0.2\text{ V}, \ V_{DS} \ge V_{GS} - V_{th}$).
* Parameter Calculation $\to$ Compute $g_m = I_C/26\text{ mV}$ (or $2I_D/V_{ov}$), $r_\pi = \beta/g_m$, $r_e = V_T/I_E$, $r_o = V_A/I_C$.
* AC Small-Signal Modeling $\to$ Turn OFF all DC supply sources (replace with AC ground) and replace all AC coupling/bypass capacitors with SHORT circuits $\to$ Draw Hybrid-$\pi$ or T-model.
* Sizing Gain and Impedances $\to$ Calculate input impedance $R_{\text{in}}$, unloaded voltage gain $A_{v0}$, loaded voltage gain $A_v = A_{v0} \frac{R_L}{R_{\text{out}} + R_L}$, and overall gain $G_v = A_v \frac{R_{\text{in}}}{R_{\text{sig}} + R_{\text{in}}}$.
* Follower Buffering $\to$ Use Common-Collector (Emitter Follower) or Common-Drain to drive heavy low-impedance loads without loading down previous high-gain stages.

### 2. Top Recommended Resources
* **The Global Standard:** *Microelectronic Circuits* (Adel S. Sedra, Kenneth C. Smith, Oxford University Press 8th ed. Chapters 5, 6, 7).
* **The Analog Master:** *Fundamentals of Microelectronics* (Behzad Razavi, Wiley 3rd ed. Chapters 4, 5, 6).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you design a four-resistor voltage-divider BJT bias network satisfying $R_{TH} \le 0.1 (\beta + 1) R_E$?
- [ ] Can you compute BJT small-signal parameters ($g_m, r_\pi, r_e, r_o$) from DC collector current $I_C$?
- [ ] Can you derive the voltage gain and input/output impedances of a Common-Emitter amplifier with emitter degeneration?
- [ ] Can you explain why the Common-Collector (Emitter Follower) has voltage gain near $1.0$ and ultra-low output impedance $R_{\text{out}} \approx r_e$?
- [ ] Can you calculate the MOSFET transconductance $g_m$ given overdrive voltage $V_{ov}$ and bias current $I_D$?
