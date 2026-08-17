# Key to Flow: Frequency & s-Domain Stability (Root Locus, Bode Plots, & Nyquist)

**Subject Area:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Root_Locus_and_Bode_Plot_Analysis`

---

## 📌 Core Concept & Mental Model
**Evans Root Locus Construction (Angle Criterion $\angle G(s)H(s) = \pm 180^\circ$, Magnitude Formula $K = 1/|GH|$, Asymptote Centroid $\sigma_a = \frac{\sum p_i - \sum z_i}{n - m}$, Angles $\theta_a = \frac{\pm(2k+1)180^\circ}{n-m}$, Breakaway Points $\frac{dK}{ds} = 0$), Logarithmic Frequency Response (Bode Magnitude $20\log_{10}|G(j\omega)|$ and Phase $\angle G(j\omega)$), Relative Stability Margins (Gain Crossover $\omega_{gc}$, Phase Crossover $\omega_{pc}$, Phase Margin $\text{PM} = 180^\circ + \angle G(j\omega_{gc})$, Gain Margin $\text{GM} = -20\log_{10}|G(j\omega_{pc})|\text{ dB}$), Nyquist Encirclement Criterion ($Z = N + P$ around critical point $-1+j0$), and Phase-Lead / Phase-Lag Cascade Compensator Synthesis** govern classical aerospace guidance, precision robotics, and feedback loop shaping (Walter R. Evans 1948; Hendrik W. Bode 1940; Harry Nyquist 1932; Katsuhiko Ogata *Modern Control Engineering* Chapters 6, 7, 8; Norman S. Nise *Control Systems Engineering* Chapters 8, 10, 11; Richard C. Dorf *Modern Control Systems* 13th ed.):
* **1. Evans Root Locus Angle & Magnitude Rules ($1 + K G(s)H(s) = 0$):**
  $$\mathbf{\angle G(s)H(s) = \sum \angle(s + z_i) - \sum \angle(s + p_i) = \pm (2k + 1) 180^\circ \quad \Big| \quad \mathbf{K = \frac{\prod_{i=1}^n |s + p_i|}{\prod_{j=1}^m |s + z_j|}}}$$
  $$\mathbf{\sigma_a = \frac{\sum_{i=1}^n p_i - \sum_{j=1}^m z_j}{n - m} \quad \Big| \quad \mathbf{\theta_a = \frac{\pm (2k + 1) 180^\circ}{n - m}} \quad \Big| \quad \mathbf{\frac{dK}{ds} = 0 \ (\text{Breakaway / Break-in})}}$$
* **2. Bode Plot Relative Stability Margins:**
  $$\mathbf{|G(j\omega_{gc})H(j\omega_{gc})| = 1 \ (0\text{ dB}) \implies \mathbf{\text{PM} = 180^\circ + \angle G(j\omega_{gc})H(j\omega_{gc})}}$$
  $$\mathbf{\angle G(j\omega_{pc})H(j\omega_{pc}) = -180^\circ \implies \mathbf{\text{GM} = -20 \log_{10} |G(j\omega_{pc})H(j\omega_{pc})| \ [\text{dB}] = \frac{1}{|G(j\omega_{pc})H(j\omega_{pc})|}}}$$
  - **Stability Invariant:** For minimum-phase systems, closed-loop stability requires **both $\text{PM} > 0^\circ$ and $\text{GM} > 0\text{ dB}$ (which occurs when $\omega_{gc} < \omega_{pc}$)**!
* **3. Nyquist Stability Criterion (Cauchy's Argument Principle):**
  $$\mathbf{Z = N + P \quad \left(Z = \text{Unstable RHP Closed-Loop Poles}, \ P = \text{Unstable RHP Open-Loop Poles}\right)}$$
  $$\mathbf{\text{For Closed-Loop Stability: } Z = 0 \implies \mathbf{N = -P \text{ (Exact } P \text{ Counter-Clockwise Encirclements of } -1+j0\text{)}}}$$
* **4. Phase-Lead / Phase-Lag Compensator Transfer Function:**
  $$\mathbf{G_c(s) = K_c \left( \frac{s + 1/T}{s + 1/(\alpha T)} \right) \quad \Big| \quad \mathbf{\text{Lead: } \alpha < 1 \ (\text{Boosts PM and Bandwidth})} \quad \Big| \quad \mathbf{\text{Lag: } \beta > 1 \ (\text{Boosts } K_v \text{ and } e_{ss})}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Classical Control Problem-Solving Spectrum
* Root Locus Sketching $\to$ Plot open-loop poles and zeros $\to$ Identify real-axis segments (left of odd count) $\to$ Calculate centroid $\sigma_a$ and asymptote angles $\theta_a \to$ Solve $\frac{dK}{ds} = 0$ for breakaway points $\to$ Calibrate gain $K$ at dominant pole using magnitude formula.
* Bode Plot Construction $\to$ Convert $G(j\omega)$ to standard time-constant form $K(1+j\omega\tau) \to$ Draw straight-line asymptotic magnitude slopes ($\pm 20\text{ dB/dec}$) $\to$ Plot phase curve $\to$ Extract $\omega_{gc}$ ($0\text{ dB}$ crossing) and $\omega_{pc}$ ($-180^\circ$ crossing) $\to$ Compute $\text{PM}$ and $\text{GM}$.
* Nyquist Mapping $\to$ Map Nyquist contour $s = j\omega$ ($\omega: 0^+ \to +\infty$) onto complex plane $\to$ Complete mirror image ($\omega: -\infty \to 0^-$) $\to$ Count clockwise encirclements $N$ of $(-1, 0) \to$ Verify $Z = N + P = 0$.
* Cascade Compensation $\to$ Use Lead Compensator ($\alpha < 1$) to inject positive phase $\phi_{\text{max}} = \arcsin\left(\frac{1-\alpha}{1+\alpha}\right)$ at $\omega_m = 1/(T\sqrt{\alpha})$ to satisfy transient overshoot/damping; Use Lag Compensator ($\beta > 1$) to boost low-frequency DC gain without destabilizing phase crossover.

### 2. Top Recommended Resources
* **The Classical Bible:** *Modern Control Engineering* (Katsuhiko Ogata, Pearson 5th ed. Chapters 6, 7, 8).
* **The Comprehensive Authority:** *Control Systems Engineering* (Norman S. Nise, Wiley 7th ed. Chapters 8, 10, 11).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you apply Evans angle and magnitude criteria to construct the root locus for an open-loop plant?
- [ ] Can you determine the centroid $\sigma_a$ and asymptote angles $\theta_a$ for a system with $n$ poles and $m$ zeros?
- [ ] Can you read Gain Crossover ($\omega_{gc}$), Phase Crossover ($\omega_{pc}$), Gain Margin ($\text{GM}$), and Phase Margin ($\text{PM}$) from a Bode diagram?
- [ ] Can you apply the Nyquist criterion $Z = N + P$ to evaluate closed-loop stability for open-loop unstable plants?
- [ ] Can you size a Phase-Lead compensator to achieve a specified Phase Margin ($\text{PM}$)?
