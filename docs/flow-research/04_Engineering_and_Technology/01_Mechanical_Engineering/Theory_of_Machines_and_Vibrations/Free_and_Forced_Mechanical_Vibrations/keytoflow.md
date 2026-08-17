# Key to Flow: Free & Forced Mechanical Vibrations (SDOF, Resonance, & Transmissibility)

**Subject Area:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Free_and_Forced_Mechanical_Vibrations`

---

## 📌 Core Concept & Mental Model
**Single Degree of Freedom (SDOF) Equation of Motion ($m \ddot{x} + c \dot{x} + k x = F(t)$), Natural Frequency ($\omega_n = \sqrt{k/m}$), Critical Damping Coefficient ($c_c = 2 \sqrt{k m} = 2 m \omega_n$), Damping Ratio Regimes ($\zeta = \frac{c}{c_c} < 1$ Underdamped, $\zeta = 1$ Critically Damped, $\zeta > 1$ Overdamped), Damped Natural Frequency ($\omega_d = \omega_n \sqrt{1 - \zeta^2}$), Logarithmic Decrement ($\delta = \ln(x_1/x_2) = \frac{2\pi\zeta}{\sqrt{1 - \zeta^2}} \approx 2\pi\zeta$), Harmonically Forced Steady-State Response, Frequency Ratio ($r = \frac{\omega}{\omega_n}$), Dynamic Magnification Factor ($MF = \frac{1}{\sqrt{(1 - r^2)^2 + (2\zeta r)^2}}$), Phase Angle ($\tan\phi = \frac{2\zeta r}{1 - r^2}$), Resonance Peak ($MF_{\text{res}} = \frac{1}{2\zeta}$ at $r=1, \phi = 90^\circ$), Vibration Isolation & Transmissibility ($TR = \sqrt{\frac{1 + (2\zeta r)^2}{(1 - r^2)^2 + (2\zeta r)^2}} < 1 \iff r > \sqrt{2}$), and Critical Whirling Speed of Rotating Shafts ($\omega_{\text{cr}} = \omega_n$)** govern mechanical vibrations and structural dynamics (Singiresu S. Rao *Mechanical Vibrations* 6th ed.; Leonard Meirovitch *Fundamentals of Vibrations*; William T. Thomson *Theory of Vibration with Applications* 5th ed.):
* **1. SDOF Free Vibration & Damping Regimes:**
  $$\mathbf{m \ddot{x} + c \dot{x} + k x = 0 \Longleftrightarrow \mathbf{\ddot{x} + 2\zeta\omega_n \dot{x} + \omega_n^2 x = 0} \quad \left(\omega_n = \sqrt{\frac{k}{m}}, \ \zeta = \frac{c}{2 m \omega_n}\right)}$$
  $$\begin{array}{|l|l|l|l|}
  \hline
  \textbf{Damping Regime} & \textbf{Damping Ratio } \zeta & \textbf{Time Response } x(t) & \textbf{Dynamic Behavior} \\
  \hline
  \mathbf{\text{Underdamped}} & \mathbf{\zeta < 1} & \mathbf{x(t) = X_0 e^{-\zeta\omega_n t} \cos(\omega_d t - \phi)} & \mathbf{\text{Oscillates at } \omega_d = \omega_n \sqrt{1 - \zeta^2}} \\
  \mathbf{\text{Critically Damped}} & \mathbf{\zeta = 1} & \mathbf{x(t) = (C_1 + C_2 t) e^{-\omega_n t}} & \mathbf{\text{Fastest return to zero WITHOUT oscillation}} \\
  \mathbf{\text{Overdamped}} & \mathbf{\zeta > 1} & x(t) = C_1 e^{s_1 t} + C_2 e^{s_2 t} & \text{Sluggish non-oscillatory exponential return} \\
  \hline
  \end{array}$$
* **2. Logarithmic Decrement & Damping Estimation:**
  $$\mathbf{\delta = \ln\left(\frac{x_n}{x_{n+1}}\right) = \frac{1}{k}\ln\left(\frac{x_n}{x_{n+k}}\right) = \frac{2\pi\zeta}{\sqrt{1 - \zeta^2}} \approx 2\pi\zeta \quad (\text{For } \zeta \le 0.20)}$$
* **3. Harmonically Forced Vibration & Dynamic Magnification:**
  $$\mathbf{X = \frac{F_0 / k}{\sqrt{(1 - r^2)^2 + (2\zeta r)^2}} = X_{\text{static}} \cdot MF \quad \left(r = \frac{\omega}{\omega_n}\right) \quad \Big| \quad \tan\phi = \frac{2\zeta r}{1 - r^2}}$$
  - **Resonance Peak:** At $r = 1$, **$\mathbf{\phi = 90^\circ}$** (input force leads displacement by $90^\circ$ and is in phase with velocity $\dot{x}$, pumping maximum energy into the system), and $\mathbf{MF = \frac{1}{2\zeta}}$!
* **4. Vibration Isolation & Transmissibility Condition ($TR < 1$):**
  $$\mathbf{TR = \frac{F_{\text{transmitted}}}{F_{\text{excitation}}} = \sqrt{\frac{1 + (2\zeta r)^2}{(1 - r^2)^2 + (2\zeta r)^2}} \quad \Big| \quad \mathbf{\text{Vibration Isolation Exists } \Longleftrightarrow \mathbf{r = \frac{\omega}{\omega_n} > \sqrt{2}}}}$$
  - If $r < \sqrt{2}$, transmitted force is magnified ($TR > 1$). Vibration mounts must be designed with low natural frequency ($\omega_n < \frac{\omega}{\sqrt{2}}$) so that $r > \sqrt{2}$!
* **5. Whirling of Rotating Shafts (Jeffcott Rotor):**
  $$\mathbf{r_{\text{shaft}} = \frac{e \cdot r^2}{\sqrt{(1 - r^2)^2 + (2\zeta r)^2}} \implies \mathbf{\text{Critical Whirling Speed: } \omega_{\text{critical}} = \omega_n = \sqrt{\frac{k}{m}}}}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Vibration Analysis Problem-Solving Spectrum
* SDOF Free Motion $\to$ Find $m, k \to \omega_n = \sqrt{k/m} \to$ Find $c \to \zeta = c/(2m\omega_n) \to$ Select under/critical/over.
* Damping from Decay $\to$ Measure peak amplitudes $x_1, x_{1+n} \to \delta = \frac{1}{n}\ln(x_1/x_{1+n}) \to \zeta = \frac{\delta}{\sqrt{4\pi^2 + \delta^2}}$.
* Harmonic Forcing $\to$ Calculate frequency ratio $r = \omega/\omega_n \to MF = 1/\sqrt{(1-r^2)^2 + (2\zeta r)^2} \to X = (F_0/k) \cdot MF$.
* Isolation Mount Design $\to$ Given machine speed $\omega \to$ Require $TR \le TR_{\text{target}} \to$ Solve required $r > \sqrt{2} \to$ Size spring stiffness $k$.
* Whirling Check $\to$ Ensure operating speed $N$ avoids $\pm 20\%$ of critical shaft speed $N_{\text{cr}}$.

### 2. Top Recommended Resources
* **The Mechanical Vibrations Standard:** *Mechanical Vibrations* (Singiresu S. Rao, Pearson 6th ed.).
* **The Structural Dynamics Classic:** *Theory of Vibration with Applications* (William T. Thomson, Marie Dillon Dahleh, Pearson 5th ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you calculate natural frequency $\omega_n$, critical damping $c_c$, and damped frequency $\omega_d$?
- [ ] Can you determine damping ratio $\zeta$ from an experimental logarithmic decay trace ($\delta = 2\pi\zeta$)?
- [ ] Can you calculate steady-state amplitude $X$ and phase lag $\phi$ under harmonic force excitation?
- [ ] Can you design an isolation pad ensuring $r = \omega/\omega_n > \sqrt{2}$ to achieve $TR < 0.10$ ($90\%$ isolation)?
- [ ] Can you calculate the critical whirling speed $\omega_{\text{cr}} = \omega_n$ of a rotating turbine shaft?
