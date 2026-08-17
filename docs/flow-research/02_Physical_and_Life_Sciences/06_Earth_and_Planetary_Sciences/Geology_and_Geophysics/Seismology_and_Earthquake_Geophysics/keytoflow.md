# Key to Flow: Seismology and Earthquake Geophysics (Earth Interior & Source Physics)

**Subject Area:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Seismology_and_Earthquake_Geophysics`

---

## 📌 Core Concept & Mental Model
**Elastodynamic Wave Propagation, Global Velocity Discontinuities, Seismic Source Moment Tensors, and Focal Mechanism Radiation Patterns** govern the geophysical probing of Earth's internal structure and earthquake fault rupture mechanics (Beno Gutenberg 1914, Inge Lehmann 1936, Hiroo Kanamori 1977):
* **Seismic Wave Propagation Physics:**
  - **Body Waves (Propagate through 3D Earth Volume):**
    - **P-Waves (Primary / Compressional):** Longitudinal particle motion parallel to propagation direction. Travel through **both solids and liquids**:
      $$v_p = \sqrt{\frac{K + \frac{4}{3}\mu}{\rho}} \qquad (\approx 6-13\text{ km/s})$$
    - **S-Waves (Secondary / Shear):** Transverse particle motion perpendicular to propagation direction. **Travel ONLY through solids** (shear modulus $\mu_{\text{liquid}} = 0 \implies v_s = 0$):
      $$v_s = \sqrt{\frac{\mu}{\rho}} \qquad (\approx 3.5-7.5\text{ km/s})$$
  - **Surface Waves (Propagate along 2D Boundary Interfaces):**
    - **Rayleigh Waves:** Retrograde elliptical vertical particle motion in vertical-radial plane (ground roll).
    - **Love Waves:** Transverse horizontal particle motion polarized parallel to the surface in a low-velocity crustal waveguide ($v_{\text{Love}} < v_s$).
* **Earth's Internal Radial Structure & Shadow Zones:**
  - **1. Mohorovičić Discontinuity (Moho - Andrija Mohorovičić 1909):** Crust-mantle boundary ($v_p$ jumps from $\sim 6.5\text{ km/s} \to 8.1\text{ km/s}$).
  - **2. The S-Wave Shadow Zone ($103^\circ - 180^\circ$):**
    - S-waves cannot penetrate the liquid outer core at the **Gutenberg Discontinuity / Core-Mantle Boundary (CMB, depth $2891\text{ km}$)** $\implies$ Produces a total global S-wave shadow on the opposite hemisphere!
  - **3. The P-Wave Shadow Zone ($103^\circ - 143^\circ$):**
    - P-waves slow down drastically as they refract into the low-velocity liquid iron outer core ($v_p$ drops from $13.7 \to 8.1\text{ km/s}$), leaving a shadow band from $103^\circ$ to $143^\circ$.
  - **4. Inge Lehmann's Discovery of the Solid Inner Core (1936):**
    - Observed faint, high-frequency P-wave arrivals ($PKIKP$ phase) inside the $103^\circ-143^\circ$ shadow zone, proving the presence of a **solid iron-nickel inner core** with radius $\approx 1220\text{ km}$ reflecting and refracting seismic energy!
* **Earthquake Source Mechanics & Moment Magnitude ($M_w$):**
  - **The Seismic Moment ($M_0$ - Aki 1966):** Fundamental physical measure of total mechanical work:
    $$\mathbf{M_0 = \mu A D}$$
    *(where $\mu$ is rock shear modulus $[\approx 3 \times 10^{10}\text{ Pa}]$, $A$ is rupture fault area, and $D$ is average slip displacement)*.
  - **The Moment Magnitude Scale ($M_w$ - Kanamori & Hanks 1979):**
    $$\mathbf{M_w = \frac{2}{3}\log_{10}(M_0) - 6.07 \qquad (M_0 \text{ in }\text{N}\cdot\text{m})}$$
    *(Unlike local Richter $M_L$ or surface-wave $M_s$, $M_w$ **never saturates** for gigantic megathrust earthquakes like Valdivia 1960 $M_w 9.5$ or Tohoku 2011 $M_w 9.1$)*.
  - **Gutenberg-Richter Recurrence Law:** $\log_{10} N = a - b M$ (where $b \approx 1.0 \implies$ each unit increase in magnitude yields a $10$-fold decrease in earthquake frequency).
* **Focal Mechanisms & Beachball Diagrams (Double-Couple Model):**
  - Quadrantal radiation pattern of initial P-wave first motions:
    - **Compressional (Upward first arrival $\implies$ Shaded Quadrant)**.
    - **Dilatational / Tensional (Downward first arrival $\implies$ White Quadrant)**.
  - **Fault Geometries on Lower-Hemisphere Stereonet Projections:**
    - **Strike-Slip Fault:** 4 equal quadrants intersecting in a cross (e.g. San Andreas).
    - **Normal Fault (Extension):** White circle center with two shaded outer lobes ("cats-eye white center").
    - **Thrust / Reverse Fault (Compression):** Shaded center flanked by white outer lobes ("dark center").

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Shadow Zone Ray-Tracing & Beachball P/T Axes
* S-Wave Shadow ($>103^\circ$) = Proves Liquid Outer Core. PKIKP Arrivals = Proves Solid Inner Core.
* Thrust = Dark Center Beachball (P-axis horizontal). Normal = White Center Beachball (T-axis horizontal).

### 2. Top Recommended Resources
* **The Seismology Bible:** *Introduction to Seismology* by Peter M. Shearer (Cambridge University Press).
* **Global Seismology Standard:** *Modern Global Seismology* by Thorne Lay & Terry C. Wallace (Academic Press).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive the velocities of P-waves and S-waves from elastic moduli ($K, \mu$) and density ($\rho$)?
- [ ] Can you explain why S-waves cannot travel through the outer core and trace the resulting shadow zone?
- [ ] Can you calculate the seismic moment $M_0$ and moment magnitude $M_w$ given fault dimensions and slip?
- [ ] Can you interpret a focal mechanism beachball diagram to identify strike-slip, normal, and thrust faulting?
