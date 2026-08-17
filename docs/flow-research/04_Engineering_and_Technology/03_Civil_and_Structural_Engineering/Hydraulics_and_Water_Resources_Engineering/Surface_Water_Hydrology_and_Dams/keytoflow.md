# Key to Flow: Water Resources Engineering (Hydrographs, Routing, & Dam Stability)

**Subject Area:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Surface_Water_Hydrology_and_Dams`

---

## 📌 Core Concept & Mental Model
**Surface Water Hydrology & Hydraulic Structures: Rational Peak Runoff Formula ($Q = \frac{CIA}{360}$), LeRoy Sherman's Unit Hydrograph Theory (Linearity, Time-Invariance, $D$-hour Duration, S-Curve Transformation, Direct Runoff Convolution $Q(t) = \sum P_{\text{eff}} \cdot U$), Level-Pool Reservoir Flood Routing via the Modified Puls / Storage Indication Method ($\left(\frac{2S_2}{\Delta t} + O_2\right) = (I_1 + I_2) + \left(\frac{2S_1}{\Delta t} - O_1\right)$ with Ogee Spillway Rating $O = C_d L H^{3/2}$), and Concrete Gravity Dam Stability Analysis (Self-Weight $W$, Hydrostatic Thrust $F_H = \frac{1}{2}\gamma_w H^2$, Base Uplift $U = \frac{1}{2}\gamma_w H B$, Overturning Factor $FS_{\text{overturn}} \ge 1.50$, Sliding Factor $FS_{\text{sliding}} \ge 1.50$, and the Middle-Third No-Tension Rule $e = |B/2 - x| \le B/6$)** govern municipal flood mitigation, watershed management, hydroelectric reservoirs, and structural dam engineering (Ven Te Chow, David R. Maidment, Larry W. Mays *Applied Hydrology*; Warren Viessman *Introduction to Hydrology* 5th ed.; USBR *Design of Small Dams* 3rd ed.):
* **1. Rational Method for Peak Catchment Runoff:**
  $$\mathbf{Q_{\text{peak}} = \frac{C \cdot I \cdot A}{360} \quad \left(Q \text{ in m}^3\text{/s}, \ I \text{ in mm/hr}, \ A \text{ in hectares}\right)}$$
* **2. Unit Hydrograph Linear Convolution:**
  $$\mathbf{Q(t) = \sum_{m=1}^M P_{\text{eff},m} \cdot U\left(t - (m-1)D\right) + \text{Baseflow}}$$
* **3. Modified Puls Storage Indication Formulation:**
  $$\mathbf{\left( \frac{2 S_2}{\Delta t} + O_2 \right) = \left( I_1 + I_2 \right) + \left( \frac{2 S_1}{\Delta t} - O_1 \right) \quad \Big| \quad \mathbf{O = C_d \cdot L \cdot H^{3/2}}}$$
* **4. Concrete Gravity Dam Stability & Middle-Third Rule:**
  $$\mathbf{x = \frac{\sum M_{\text{toe}}}{\sum V} \quad \Big| \quad \mathbf{e = \left| \frac{B}{2} - x \right| \le \frac{B}{6} \implies \sigma_{\text{heel}} \ge 0 \ (\text{No Tension Cracking})}}$$
  $$\mathbf{\sigma_{\text{toe/heel}} = \frac{\sum V}{B} \left( 1 \pm \frac{6 e}{B} \right) \quad \Big| \quad \mathbf{FS_{\text{overturn}} = \frac{\sum M_R}{\sum M_O} \ge 1.50} \quad \Big| \quad \mathbf{FS_{\text{sliding}} = \frac{\mu \sum V}{\sum H} \ge 1.50}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Water Resources & Dam Problem-Solving Spectrum
* Unit Hydrograph Linearity $\to$ The Unit Hydrograph (UH) represents the catchment response to exactly $1.0\text{ cm}$ of effective excess rainfall. Scale ordinates proportionally by excess rainfall depth $P_{\text{eff}}$, lag consecutive storm bursts by duration $D$, and superimpose the results before adding baseflow.
* Modified Puls Reservoir Table $\to$ Given elevation vs storage ($S$) and elevation vs spillway outflow ($O$) curves $\to$ Tabulate the Storage Indication function $\frac{2S}{\Delta t} + O$ versus $O \to$ Given inflow hydrograph $I_t$, recursively calculate $\frac{2S_2}{\Delta t} + O_2$ and look up next outflow $O_2$.
* Gravity Dam Load Combination $\to$ Calculate vertical self-weights $W_1, W_2$ and horizontal hydrostatic thrust $F_H = 0.5 \gamma_w H^2$ acting at $H/3$ above the base. Include triangular or trapezoidal internal uplift pressure $U$.
* Dam Middle-Third Verification $\to$ Sum vertical forces $\sum V$ and moments about the downstream toe $\sum M_{\text{toe}} \to$ Compute location of resultant $x = \sum M_{\text{toe}} / \sum V \to$ Compute eccentricity $e = |B/2 - x| \to$ If $e \le B/6$, the entire base remains in compression without tensile joint opening.

### 2. Top Recommended Resources
* **The Global Hydrologic Authority:** *Applied Hydrology* (Ven Te Chow, David R. Maidment, Larry W. Mays, McGraw-Hill).
* **The Classical Dam Reference:** *Design of Small Dams* (United States Bureau of Reclamation - USBR, 3rd ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you convolve a multi-period rainfall excess hyetograph with a Unit Hydrograph to produce a flood discharge hydrograph?
- [ ] Can you route a flood hydrograph through a gated or un-gated reservoir using the Modified Puls storage indication method?
- [ ] Can you check a concrete gravity dam for overturning safety ($FS_{\text{overturn}} \ge 1.50$) and sliding safety ($FS_{\text{sliding}} \ge 1.50$)?
- [ ] Can you compute resultant eccentricity $e$ at a dam base and evaluate base compressive stresses using the Middle-Third Rule?
