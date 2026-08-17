# Key to Flow: Signals & Systems Foundations (Classifications, LTI Properties, & Convolution)

**Subject Area:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Continuous_and_Discrete_Time_Signals`

---

## 📌 Core Concept & Mental Model
**Continuous-Time $x(t)$ & Discrete-Time $x[n]$ Signal Classifications, Energy ($E = \int_{-\infty}^\infty |x(t)|^2 dt < \infty \implies P = 0$) vs Power Signals ($P = \lim_{T\to\infty} \frac{1}{2T}\int_{-T}^T |x(t)|^2 dt < \infty \implies E = \infty$), Even/Odd Symmetry Decomposition ($x_e(t) = \frac{x(t)+x(-t)}{2}, \ x_o(t) = \frac{x(t)-x(-t)}{2}$), Singularity Functions (Unit Step $u(t)$, Dirac Delta $\delta(t)$, Sifting Property $\int_{-\infty}^\infty x(t)\delta(t-t_0)dt = x(t_0)$, Scaling $\delta(at) = \frac{1}{|a|}\delta(t)$), Six Fundamental System Properties (Linearity $T\{ax_1+bx_2\} = ay_1+by_2$, Time-Invariance $T\{x(t-t_0)\} = y(t-t_0)$, Causality $h(t) = 0$ for $t < 0$, BIBO Stability $\int_{-\infty}^\infty |h(t)|dt < \infty$, Memoryless $h(t) = K\delta(t)$, and Invertibility), and Linear Time-Invariant (LTI) Convolution Dynamics ($y(t) = x(t) * h(t) = \int_{-\infty}^\infty x(\tau) h(t - \tau) d\tau$ and $y[n] = \sum_{k} x[k] h[n - k]$)** govern modern communication theory, control engineering, and digital signal processing (Alan V. Oppenheim, Alan S. Willsky, S. Hamid Nawab *Signals and Systems* 2nd ed. Chapters 1 & 2; Simon Haykin, Barry Van Veen *Signals and Systems* 2nd ed. Chapters 1 & 2; B.P. Lathi *Linear Systems and Signals* 3rd ed.):
* **1. Signal Classifications & Symmetry Decomposition:**
  $$\mathbf{x(t) = x_e(t) + x_o(t) \quad \Big| \quad x_e(t) = \frac{x(t) + x(-t)}{2} \quad \Big| \quad x_o(t) = \frac{x(t) - x(-t)}{2}}$$
  $$\mathbf{\text{Energy Signal: } 0 < E < \infty \implies P = 0 \quad \Big| \quad \text{Power Signal: } 0 < P < \infty \implies E = \infty}$$
* **2. The Sifting & Scaling Properties of Dirac Delta ($\delta(t)$):**
  $$\mathbf{\int_{-\infty}^\infty x(t) \delta(t - t_0) \, dt = x(t_0) \quad \Big| \quad \mathbf{\delta(at) = \frac{1}{|a|} \delta(t)} \quad \Big| \quad \delta(t) = \frac{du(t)}{dt}}$$
* **3. The Six Fundamental System Properties for LTI Networks:**
  $$\begin{array}{|l|l|l|}
  \hline
  \textbf{System Property} & \textbf{General System Definition} & \textbf{LTI Impulse Response Condition } h(t) \\
  \hline
  \mathbf{\text{Linearity}} & T\{a x_1 + b x_2\} = a y_1 + b y_2 & \text{Always satisfied by convolution } y = x * h \\
  \mathbf{\text{Time-Invariance}} & T\{x(t - t_0)\} = y(t - t_0) & \text{Impulse response is stationary } h(t, \tau) = h(t - \tau) \\
  \mathbf{\text{Causality}} & y(t) \text{ depends only on } x(\tau \le t) & \mathbf{h(t) = 0 \text{ for all } t < 0 \ (h[n] = 0 \text{ for } n < 0)} \\
  \mathbf{\text{BIBO Stability}} & |x(t)| \le M_x \implies |y(t)| \le M_y & \mathbf{\int_{-\infty}^\infty |h(t)| dt < \infty \ \left(\sum_{n=-\infty}^\infty |h[n]| < \infty\right)} \\
  \mathbf{\text{Memoryless}} & y(t) \text{ depends only on } x(t) & \mathbf{h(t) = K \delta(t) \ (h[n] = K \delta[n])} \\
  \mathbf{\text{Invertibility}} & x_1(t) \ne x_2(t) \implies y_1(t) \ne y_2(t) & h(t) * h_{\text{inv}}(t) = \delta(t) \\
  \hline
  \end{array}$$
* **4. Continuous & Discrete Convolution:**
  $$\mathbf{y(t) = x(t) * h(t) = \int_{-\infty}^\infty x(\tau) h(t - \tau) \, d\tau \quad \Big| \quad \mathbf{y[n] = x[n] * h[n] = \sum_{k=-\infty}^\infty x[k] h[n - k]}}$$
  - **The Sliding Window Invariant:** Convolution is a **sliding weighted average** where $h(t-\tau)$ represents the system's fading memory window sliding across the input stream $x(\tau)$!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Signals & Systems Problem-Solving Spectrum
* Signal Categorization $\to$ Check periodic condition $x(t+T_0) = x(t) \to$ Evaluate energy $E$ and average power $P \to$ Decompose into even $x_e$ and odd $x_o$ parts.
* Impulse Sifting $\to$ Isolate delta argument $\delta(t - t_0) = 0 \implies t = t_0 \to$ Sample integrand at $t_0$.
* System Testing $\to$ Test Linearity (Superposition), Time-Invariance (Shift-Commutation), Causality ($h(t<0)=0$), and Stability ($\int |h| dt < \infty$).
* Convolution Sizing $\to$ Flip impulse response $h(-\tau) \to$ Shift by $t \to$ Identify piecewise overlap intervals $\to$ Integrate $x(\tau) h(t-\tau) d\tau$.

### 2. Top Recommended Resources
* **The Definitive Standard:** *Signals and Systems* (Alan V. Oppenheim, Alan S. Willsky, S. Hamid Nawab, Pearson 2nd ed. Chapters 1 & 2).
* **The Intuitive Classic:** *Linear Systems and Signals* (B.P. Lathi, Oxford University Press 3rd ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you classify signals as Energy signals ($0 < E < \infty, P = 0$) or Power signals ($0 < P < \infty, E = \infty$)?
- [ ] Can you evaluate integrals containing scaled and shifted Dirac delta functions $\delta(at - b)$?
- [ ] Can you prove whether an arbitrary system operator $y(t) = T\{x(t)\}$ is linear, time-invariant, causal, and BIBO stable?
- [ ] Can you perform continuous-time graphical convolution $y(t) = x(t) * h(t)$ across piece-wise intervals?
- [ ] Can you perform discrete-time convolution $y[n] = x[n] * h[n]$ using the tabular / array method?
