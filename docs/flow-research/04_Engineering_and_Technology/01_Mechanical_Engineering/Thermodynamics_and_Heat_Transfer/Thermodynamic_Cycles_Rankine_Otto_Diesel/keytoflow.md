# Key to Flow: Thermodynamic Cycles (Otto, Diesel, Brayton, & Rankine Power Plants)

**Subject Area:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Thermodynamics_and_Heat_Transfer / Thermodynamic_Cycles_Rankine_Otto_Diesel`

---

## 📌 Core Concept & Mental Model
**Air-Standard Internal Combustion Cycles (Spark-Ignition Constant-Volume Otto Cycle $\eta_{\text{Otto}} = 1 - \frac{1}{r^{k-1}}$ vs Compression-Ignition Constant-Pressure Diesel Cycle with Cut-Off Ratio $r_c$), Gas Turbine Brayton Jet Engines ($\eta_{\text{Brayton}} = 1 - \frac{1}{r_p^{(k-1)/k}}$ with Pressure Ratio $r_p = P_2/P_1$), and Vapor Power Generation Cycles (Ideal, Superheat, Reheat, and Regenerative Rankine Steam Turbines with Feedwater Heaters)** govern thermal power generation and internal combustion engine design (Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu *Thermodynamics: An Engineering Approach* Chapter 9 & 10; Michael J. Moran et al. *Fundamentals of Engineering Thermodynamics* Chapter 8 & 9):
* **1. Otto Cycle (Ideal Spark-Ignition SI Petrol Engine):**
  - **4 Processes:** 1-2 Isentropic Compression $\to$ 2-3 Isochoric ($v=C$) Heat Addition $\to$ 3-4 Isentropic Expansion $\to$ 4-1 Isochoric Heat Rejection.
  - **Compression Ratio:** $\mathbf{r = \frac{V_1}{V_2} = \frac{V_{\text{max}}}{V_{\text{min}}} \quad (r \approx 7 - 11 \text{ in petrol engines to prevent autoignition knock!})}$
  - **Air-Standard Thermal Efficiency:**
    $$\mathbf{\eta_{\text{th,Otto}} = 1 - \frac{1}{r^{k - 1}} \quad \left(k = \frac{c_p}{c_v} \approx 1.4 \text{ for air}\right)}$$
* **2. Diesel Cycle (Compression-Ignition CI Engine):**
  - **4 Processes:** 1-2 Isentropic Compression $\to$ 2-3 Isobaric ($P=C$) Heat Addition $\to$ 3-4 Isentropic Expansion $\to$ 4-1 Isochoric Heat Rejection.
  - **Cut-off Ratio:** $\mathbf{r_c = \frac{V_3}{V_2} = \frac{T_3}{T_2} \ (r_c > 1)}$.
  - **Thermal Efficiency:**
    $$\mathbf{\eta_{\text{th,Diesel}} = 1 - \frac{1}{r^{k - 1}} \left[ \frac{r_c^k - 1}{k(r_c - 1)} \right] \quad (r \approx 14 - 22 \text{ without knocking risk!})}$$
* **3. Brayton Cycle (Gas Turbines & Jet Aircraft Propulsion):**
  - **4 Processes:** 1-2 Isentropic Compressor $\to$ 2-3 Isobaric Combustion $\to$ 3-4 Isentropic Turbine $\to$ 4-1 Isobaric Cooler.
  - **Pressure Ratio:** $\mathbf{r_p = \frac{P_2}{P_1} \implies \eta_{\text{th,Brayton}} = 1 - \frac{1}{r_p^{(k - 1)/k}}}$.
* **4. Rankine Vapor Power Plant Cycle:**
  - **4 Processes:** 1-2 Isentropic Feed Pump ($w_p = v_1(P_2 - P_1) = h_2 - h_1$) $\to$ 2-3 Isobaric Steam Boiler ($q_{\text{in}} = h_3 - h_2$) $\to$ 3-4 Isentropic Steam Turbine ($w_t = h_3 - h_4$) $\to$ 4-1 Isobaric Condenser ($q_{\text{out}} = h_4 - h_1$).
  - **Efficiency:** $\mathbf{\eta_{\text{th,Rankine}} = \frac{w_{\text{net}}}{q_{\text{in}}} = \frac{(h_3 - h_4) - (h_2 - h_1)}{h_3 - h_2}}$.
  - **Reheat & Regeneration:**
    - **Reheat:** Expands steam through High-Pressure (HP) turbine, reheats in boiler, then expands through Low-Pressure (LP) turbine $\implies$ **Eliminates blade moisture erosion ($x_4 \ge 0.90$)**!
    - **Regeneration (Feedwater Heaters FWH):** Bleeds turbine steam to preheat boiler water $\implies$ **Raises average heat addition temperature $\bar{T}_{\text{in}}$, boosting thermal efficiency**!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Cycle Analysis Problem-Solving Spectrum
* Gas Power Cycle $\to$ Draw $P-v$ & $T-s$ $\to$ Solve state temperatures ($T_1, T_2, T_3, T_4$) using isentropic relations $T_2/T_1 = (V_1/V_2)^{k-1}$.
* Heat Addition / Rejection $\to q_{\text{in}} = c_v(T_3-T_2)$ (Otto) vs $q_{\text{in}} = c_p(T_3-T_2)$ (Diesel/Brayton).
* Vapor Power Cycle $\to$ Draw $T-s$ with vapor dome $\to$ Look up enthalpies $(h_1, h_2, h_3, h_4)$ from Steam Tables.
* Power & Heat Rate $\to \dot{W}_{\text{net}} = \dot{m}(w_t - w_p) \to \eta_{\text{th}} = \dot{W}_{\text{net}} / \dot{Q}_{\text{in}}$.
* Turbine Quality Check $\to$ Verify steam moisture at turbine exit $x_{\text{exit}} \ge 0.88-0.90$.

### 2. Top Recommended Resources
* **The Thermodynamics Standard:** *Thermodynamics: An Engineering Approach* (Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu, McGraw-Hill 9th/10th ed.).
* **The Systems Reference:** *Fundamentals of Engineering Thermodynamics* (Michael J. Moran, Howard N. Shapiro et al., Wiley 9th ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you calculate the thermal efficiency of an Otto cycle given compression ratio $r = 8$ and $k = 1.4$?
- [ ] Can you evaluate the cut-off ratio $r_c$ and efficiency for a Diesel cycle?
- [ ] Can you compute the pressure ratio $r_p$ and net work for a Brayton gas turbine?
- [ ] Can you determine all four state enthalpies in an ideal Rankine steam cycle using saturated liquid and superheated steam tables?
- [ ] Can you explain why the reheat cycle prevents turbine blade droplet erosion while regeneration increases cycle efficiency?
