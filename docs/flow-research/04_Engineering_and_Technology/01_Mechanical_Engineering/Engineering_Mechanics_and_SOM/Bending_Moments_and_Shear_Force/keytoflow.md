# Key to Flow: Bending Moments & Shear Force (Beam Mechanics & Stress Analysis)

**Subject Area:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Bending_Moments_and_Shear_Force`

---

## 📌 Core Concept & Mental Model
**Internal Beam Equilibrium Differential Calculus ($\frac{dV}{dx} = -w(x), \ \frac{dM}{dx} = V(x)$), Continuous Function Integration ($\Delta V = -\int w \, dx, \ \Delta M = \int V \, dx$), Shear Force Diagram (SFD) and Bending Moment Diagram (BMD) Construction, Points of Maximum Bending Moment ($V=0$) and Points of Contraflexure ($M=0$), Pure Bending Kinematics (Euler-Bernoulli Beam Hypothesis: $\frac{\sigma}{y} = \frac{M}{I} = \frac{E}{R}$), Flexural Section Modulus ($Z = I/y_{\text{max}} \implies \sigma_{\text{max}} = M/Z$), and Horizontal Transverse Shear Stress Distributions (Jourawski's Formula $\tau = \frac{VQ}{Ib}$ with Parabolic Profile $\tau_{\text{max}} = \frac{3}{2}\frac{V}{A}$ on Rectangular Beams)** govern structural beam design and strength of materials (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 5 & 6; James M. Gere & Barry J. Goodno *Mechanics of Materials*; Russell C. Hibbeler):
* **1. SFD & BMD Fundamental Differential Invariants:**
  $$\mathbf{\frac{dV}{dx} = -w(x) \quad \Big| \quad \frac{dM}{dx} = V(x) \quad \Big| \quad M(x_2) - M(x_1) = \int_{x_1}^{x_2} V(x) \, dx}$$
  - **Slope of SFD:** Equals the negative intensity of distributed load $-w$. (Point load $\implies$ vertical jump in SFD).
  - **Slope of BMD:** Equals the Shear Force $V$. (When $V=0 \implies \frac{dM}{dx} = 0 \implies \mathbf{M \text{ is at a local maximum or minimum!}}$).
  - **Point of Contraflexure:** The cross-section where $M(x) = 0$ and the beam curvature changes sign (from sagging $+$ to hogging $-$).
* **2. Euler-Bernoulli Pure Bending Theory:**
  $$\mathbf{\frac{M}{I} = \frac{\sigma}{y} = \frac{E}{R} \implies \sigma(y) = \frac{M y}{I} \quad \Big| \quad \sigma_{\text{max}} = \frac{M_{\text{max}}}{Z} \quad \left(Z = \frac{I}{y_{\text{max}}}\right)}$$
  - **Neutral Axis (NA):** Passes through the cross-section **Centroid** ($\sigma = 0, \epsilon = 0$).
  - **Rectangular Beam ($b \times h$):** $I = \frac{b h^3}{12}$, $y_{\text{max}} = \frac{h}{2} \implies Z = \frac{b h^2}{6}$.
* **3. Transverse Shear Stress in Beams (Jourawski's Formula):**
  $$\mathbf{\tau(y) = \frac{V Q(y)}{I b} \quad \text{where } Q(y) = \int_y^{c} y' \, dA' = \bar{y}' A'}$$
  - **Rectangular Beam Parabolic Shear:**
    $$\mathbf{\tau(y) = \frac{3 V}{2 b h} \left(1 - \frac{4 y^2}{h^2}\right) \implies \mathbf{\tau_{\text{max}} = \frac{3}{2} \frac{V}{A} = 1.5 \, \tau_{\text{avg}} \text{ at the Neutral Axis } (y=0)}}$$
    - Top and bottom extreme fibers ($y = \pm h/2$): $\tau = 0$ (free boundary surfaces).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Beam Analysis Problem-Solving Spectrum
* Support Reactions $\to$ Draw Global FBD $\to \sum F_y = 0, \sum M_A = 0$.
* SFD Construction $\to$ Plot $V(x)$ from left to right (Jumps at point loads, slopes under UDL).
* BMD Construction $\to$ Integrate area under SFD $\to \Delta M = \int V \, dx \to$ Locate $M_{\text{max}}$ at $V=0$.
* Flexural Bending Check $\to \sigma_{\text{max}} = M_{\text{max}} / Z \le \sigma_{\text{allowable}}$.
* Transverse Shear Check $\to \tau_{\text{max}} = \frac{3}{2}\frac{V}{A} \le \tau_{\text{allowable}}$.

### 2. Top Recommended Resources
* **The Mechanics Standard:** *Mechanics of Materials* (Ferdinand P. Beer, E. Russell Johnston Jr., John T. DeWolf, David F. Mazurek, McGraw-Hill 8th ed.).
* **The Visual Structural Standard:** *Mechanics of Materials* (James M. Gere & Barry J. Goodno, Cengage 9th ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you construct an SFD and BMD for a beam with combined point loads, UDLs, and applied moments?
- [ ] Can you locate the point of maximum bending moment by finding where the shear force passes through zero ($V=0$)?
- [ ] Can you find the point of contraflexure on an overhanging beam where $M(x) = 0$?
- [ ] Can you calculate bending stress $\sigma = My/I$ at any fiber distance $y$ from the neutral axis?
- [ ] Can you compute the first moment of area $Q$ and maximum shear stress $\tau_{\text{max}} = 1.5 V/A$ for a rectangular beam?
