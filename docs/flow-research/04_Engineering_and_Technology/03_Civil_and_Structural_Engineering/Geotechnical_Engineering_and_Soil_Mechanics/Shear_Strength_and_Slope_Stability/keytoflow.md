# Key to Flow: Geotechnical Failure (Shear Strength, Consolidation, & Slopes)

**Subject Area:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shear_Strength_and_Slope_Stability`

---

## 📌 Core Concept & Mental Model
**Mohr-Coulomb Shear Failure Criterion ($\tau_f = c' + \sigma' \tan\phi'$ where $\sigma' = \sigma - u$), Triaxial Shear Testing (Consolidated-Drained $CD$, Consolidated-Undrained $CU$, Unconsolidated-Undrained $UU$), Terzaghi's 1D Primary Consolidation Theory ($\frac{\partial u}{\partial t} = c_v \frac{\partial^2 u}{\partial z^2}$, Time Factor $T_v = \frac{c_v t}{H_{dr}^2}$, Primary Settlement $S_c = \frac{C_c H_0}{1+e_0} \log_{10}\frac{\sigma_0'+\Delta\sigma'}{\sigma_0'}$), Infinite Slope Stability with Parallel Seepage ($FS = \frac{\gamma'}{\gamma_{\text{sat}}} \frac{\tan\phi'}{\tan\beta} \approx 0.5 \frac{\tan\phi'}{\tan\beta}$), and the Simplified Bishop Method of Slices ($FS = \frac{1}{\sum W \sin\alpha} \sum \frac{c' b + (W - u b)\tan\phi'}{m_\alpha}$)** govern open-pit mining excavations, highway cuts, earthen dams, and structural foundation stability (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapters 11-14; J. Michael Duncan, Stephen G. Wright *Soil Strength and Slope Stability* 2nd ed.; Karl Terzaghi *Theoretical Soil Mechanics*):
* **1. Mohr-Coulomb Effective Stress Failure Criterion:**
  $$\mathbf{\tau_f = c' + \sigma' \tan\phi' = c' + (\sigma - u) \tan\phi'}$$
  $$\mathbf{\sigma_1' = \sigma_3' \tan^2\left( 45^\circ + \frac{\phi'}{2} \right) + 2 c' \tan\left( 45^\circ + \frac{\phi'}{2} \right) = \sigma_3' N_\phi + 2 c' \sqrt{N_\phi}}$$
* **2. Terzaghi 1D Primary Consolidation Settlement:**
  $$\mathbf{S_c = \frac{C_c \cdot H_0}{1 + e_0} \log_{10}\left( \frac{\sigma_0' + \Delta\sigma'}{\sigma_0'} \right) \quad (\text{Normally Consolidated Clay})}$$
  $$\mathbf{T_v = \frac{c_v \cdot t}{H_{dr}^2} \quad \left(H_{dr} = \frac{H_0}{2} \text{ for two-way drainage, } H_{dr} = H_0 \text{ for one-way}\right)}$$
* **3. Infinite Slope Factor of Safety with Groundwater Seepage:**
  $$\mathbf{FS_{\text{dry}} = \frac{\tan\phi'}{\tan\beta} \quad \Big| \quad \mathbf{FS_{\text{seepage}} = \frac{\gamma'}{\gamma_{\text{sat}}} \frac{\tan\phi'}{\tan\beta} \approx \frac{1}{2} FS_{\text{dry}} \quad (\text{For } c' = 0)}$$
* **4. Simplified Bishop Method of Slices (Iterative $FS$):**
  $$\mathbf{FS = \frac{\sum \left[ \frac{c' b + (W - u b) \tan\phi'}{m_\alpha} \right]}{\sum W \sin\alpha} \quad \text{where } \mathbf{m_\alpha = \cos\alpha \left( 1 + \frac{\tan\alpha \tan\phi'}{FS} \right)}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Geotechnical Stability Problem-Solving Spectrum
* Effective Stress Principle $\to$ Total stress $\sigma$ is carried jointly by the soil mineral skeleton $\sigma'$ and pore water pressure $u$ ($\sigma = \sigma' + u$). Water cannot sustain shear stress ($\tau_w = 0$); therefore, all shear resistance derives solely from effective stress $\sigma'$.
* Consolidation Calculation $\to$ Determine pre-consolidation pressure $\sigma_p'$ from oedometer $e-\log\sigma'$ curve $\to$ Check if Normally Consolidated ($\sigma_0' = \sigma_p'$) or Overconsolidated ($\sigma_0' < \sigma_p'$) $\to$ Apply compression index $C_c$ or recompression index $C_s$ to evaluate total vertical settlement $S_c$.
* Infinite Slope Seepage Hazard $\to$ For granular slopes ($c'=0$), steady groundwater seepage parallel to the slope face cuts the Factor of Safety almost in half ($\frac{\gamma'}{\gamma_{\text{sat}}} \approx \frac{10}{20} = 0.50$), triggering catastrophic debris flows when slope angle $\beta > \phi'/2$.
* Method of Slices Iteration $\to$ Subdivide slip circle into vertical slices $\to$ Assume initial $FS^{(0)} \approx 1.50 \to$ Compute $m_\alpha = \cos\alpha (1 + \frac{\tan\alpha\tan\phi'}{FS})$ for each slice $\to$ Sum numerator and denominator $\to$ Iterate until $\Delta FS < 0.001$.

### 2. Top Recommended Resources
* **The Global Standard:** *Principles of Geotechnical Engineering* (Braja M. Das, Khaled Sobhan, Cengage Learning 9th ed. Chapters 11-14).
* **The Definitive Slope Authority:** *Soil Strength and Slope Stability* (J. Michael Duncan, Stephen G. Wright, Thomas L. Brandon, Wiley 2nd ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you determine effective cohesion $c'$ and friction angle $\phi'$ from triaxial test failure envelopes?
- [ ] Can you calculate primary consolidation settlement $S_c$ and time-rate factor $T_v$ for a clay layer under foundation loading?
- [ ] Can you evaluate the Factor of Safety for an infinite slope under dry, submerged, and steady seepage conditions?
- [ ] Can you execute the iterative Bishop simplified method of slices to calculate the overall slope stability factor of safety?
