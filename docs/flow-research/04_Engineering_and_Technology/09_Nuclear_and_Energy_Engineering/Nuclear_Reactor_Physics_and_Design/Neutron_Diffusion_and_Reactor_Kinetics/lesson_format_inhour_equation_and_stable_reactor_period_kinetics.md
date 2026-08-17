# Duofy Reusable Lesson Format: Reactor Period (The Inhour Equation & Power Transients)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Nuclear_Reactor_Physics_and_Design / Neutron_Diffusion_and_Reactor_Kinetics`  
**Lesson Format Type:** `inhour_equation_and_stable_reactor_period_kinetics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the mathematical relationship between core reactivity ($\rho$) and the exponential time rate of power change, the historical **Inhour Equation ($\rho = \frac{\Lambda}{T} + \sum_{i=1}^6 \frac{\beta_i}{1 + \lambda_i T}$)** linking reactivity directly to the **Stable Reactor Period ($T$)**, the asymptotic single-group simplified reactor period formula ($T \approx \frac{\beta - \rho}{\lambda \rho}$ for $0 < \rho < \beta$), the definition of the inhour unit ($1\text{ inhour}$ = reactivity for an asymptotic period $T = 3600\text{ seconds}$), doubling time ($t_{\text{double}} = T \ln 2$), and reactor power doubling calculations (John R. Lamarsh, Anthony J. Baratta *Introduction to Nuclear Engineering* 4th ed. Chapter 7; James J. Duderstadt, Louis J. Hamilton *Nuclear Reactor Analysis* Chapter 9; Elmer E. Lewis *Fundamentals of Nuclear Reactor Physics* Chapter 7): formulate the **General Inhour Equation Master Formulation**:
$$\mathbf{\rho = \frac{\Lambda}{T} + \sum_{i=1}^6 \frac{\beta_i}{1 + \lambda_i T} \Longleftrightarrow \mathbf{\rho \approx \frac{\Lambda}{T} + \frac{\beta}{1 + \lambda T} \quad (\text{1-Group Delayed Precursor Model})}}$$
where for small positive step reactivities ($0 < \rho < \beta$):
$$\mathbf{T \approx \frac{\beta - \rho}{\lambda \cdot \rho} \quad [\text{seconds}] \quad \Big| \quad \mathbf{P(t) = P(0^+) \cdot \exp\left( \frac{t}{T} \right) = n_{\text{jump}} \cdot e^{t / T}}}$$
where:
1. **$T$:** Stable asymptotic reactor period in seconds (time required for core thermal power to increase by a factor of $e \approx 2.718$);
2. **$P(0^+) = P_0 \frac{\beta}{\beta - \rho}$:** Post-prompt-jump base power level;
3. **$\beta \approx 0.0065$:** Total delayed neutron fraction (U-235);
4. **$\lambda \approx 0.080\text{ s}^{-1}$:** Weighted average decay constant of the 6 precursor groups ($\bar{\tau} = 1/\lambda \approx 12.5\text{ s}$);
derive the **Core Thermal Power Doubling Time ($t_{\text{double}}$)**:
$$\mathbf{t_{\text{double}} = T \cdot \ln(2) \approx 0.69315 \cdot T \quad [\text{seconds}]}$$
master the **Reactor Period & Power Dynamics Operational Matrix**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Core Reactivity Condition} & \textbf{Reactor Period } T & \textbf{Power Trajectory } P(t) & \textbf{Control Room Operations Interpretation} \\
\hline
\mathbf{\text{Critical } (\rho = 0)} & \mathbf{T = \infty} & \mathbf{P(t) = P_0 \ (\text{Constant})} & \mathbf{\text{Steady electrical grid generation (100\% base load)}} \\
\mathbf{\text{Delayed Supercritical } (0 < \rho < \beta)} & \mathbf{T > 0 \ (10\text{ s} - 200\text{ s})} & \mathbf{P(t) \propto e^{+t/T} \ (\text{Rising})} & \mathbf{\text{Controlled power ascent; operator monitors period meter}} \\
\mathbf{\text{Subcritical } (\rho < 0)} & \mathbf{T < 0 \ (\text{Negative Period})} & \mathbf{P(t) \propto e^{-t/|T|} \ (\text{Dropping})} & \mathbf{\text{Normal shutdown or post-trip cooldown}} \\
\mathbf{\text{Prompt Critical } (\rho \ge \beta)} & \mathbf{T \approx \frac{\Lambda}{\rho - \beta} \approx 10^{-4}\text{ s}} & \mathbf{P(t) \propto e^{10^4 t} \ (\text{Runaway})} & \mathbf{\text{Accidental runaway; requires instant Doppler shutoff}} \\
\hline
\end{array}$$
(proving that operating with positive periods $T \ge 20 - 50\text{ s}$ guarantees safe, stable reactor startup and ascension), and interact with live One-group diffusion solver, Six-factor criticality calculator, Point reactor kinetics & prompt jump tracer, and Inhour reactor period & doubling time simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inhour Equation ($\rho = \frac{\Lambda}{T} + \sum \frac{\beta_i}{1+\lambda_i T}$), Stable Period ($T = \frac{\beta-\rho}{\lambda\rho}$) & Doubling Time Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Reactivity, Stable Reactor Period T, and Doubling Time Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Inhour Kinetics Parameter / Period Metric & Technical Nuclear Operation Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Nuclear Reactor Control, the Time Required for Core Thermal Power to Increase by a Factor of $e \approx 2.718$ Is Defined as the Stable Reactor ___ (Period / Reactor Period) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Nuclear Reactor Physics Studio: 1-Group Diffusion, Six-Factor Criticality, PRKE & Inhour Period Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "inhour_equation_and_stable_reactor_period_kinetics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Inhour equation in reactor physics, and how does it determine the stable reactor period T and power doubling time?",
      "blankAnswer": "Inhour Kinetics \\& Stable Period (Lamarsh 2018; Duderstadt 1976): (1) INHOUR EQUATION: \u03c1 = \u039b/T + \u2211[\u03b2i / (1 + \u03bb_i*T)]. It defines the exact mathematical mapping between inserted reactivity \u03c1 and asymptotic reactor period T. (2) STABLE PERIOD APPROXIMATION: For delayed critical reactivity (0 < \u03c1 < \u03b2), T \u2248 (\u03b2 - \u03c1) / (\u03bb * \u03c1), where \u03bb \u2248 0.08 s^-1. (3) POWER ASCENT: P(t) = P_jump * exp(t / T). (4) DOUBLING TIME: t_double = T * ln(2) \u2248 0.693*T, governing safe rate-of-power ascent during reactor startups!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the stable reactor period T and compute core thermal power after a step reactivity insertion.",
      "orderItems": [
        "Record inserted positive reactivity \u03c1 (e.g. +0.0013), delayed fraction \u03b2 = 0.0065, and average decay constant \u03bb = 0.08 s^-1",
        "Calculate the immediate prompt jump power level: P_jump = P0 * [ \u03b2 / (\u03b2 - \u03c1) ]",
        "Apply the asymptotic Inhour equation to calculate the stable reactor period: T = (\u03b2 - \u03c1) / (\u03bb * \u03c1)",
        "Calculate the reactor doubling time: t_double = T * ln(2)",
        "Evaluate exponential power growth at elapsed time t: P(t) = P_jump * exp(t / T)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reactor Period Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Inhour Equation", "right": "\u03c1 = \u039b/T + \u2211[\u03b2i / (1 + \u03bbi*T)], characteristic equation relating core reactivity to exponential growth period" },
        { "left": "Stable Reactor Period (T)", "right": "Time required for core neutron flux and thermal power to increase by a factor of e \u2248 2.718" },
        { "left": "Power Doubling Time (tdouble)", "right": "tdouble = T*ln(2) \u2248 0.693*T, elapsed duration for reactor fission power to double" },
        { "left": "Average Precursor Decay (\u03bb \u2248 0.08 s^-1)", "right": "Effective 1-group delayed precursor decay constant corresponding to a mean life of \u2248 12.5 seconds" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In nuclear reactor control, the time required for core thermal power to increase by a factor of e \u2248 2.718 is defined as the stable reactor ___.",
      "blankAnswer": "period",
      "blankDistractors": ["time", "flux", "burnup"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Nuclear Reactor Physics & Kinetics Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Nuclear Reactor Physics & Kinetics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">1-Group Diffusion (L=2.7cm), Six-Factor Keff, Prompt Jump & Inhour T</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnDiff\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Diffusion (L = 2.70 cm)</button><button id=\"btnKeff\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Six-Factor (keff=1.0055, $=+0.84)</button><button id=\"btnKin\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. PRKE Prompt Jump (1250 MWth) & T</button></div><div id=\"nucLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate one-group neutron diffusion...</div><script>document.getElementById('btnDiff').onclick=()=>{document.getElementById('nucLog').innerHTML='<b>1. ONE-GROUP NEUTRON DIFFUSION:</b><br>• Light Water: D = 0.160 cm, \\u03a3a = 0.022 cm^-1<br>• Diffusion Area: L\u00b2 = D / \\u03a3a = 7.27 cm\u00b2 &rarr; <b style=\"color:#10b981;\">L = 2.70 cm!</b><br>• <b style=\"color:#38bdf8;\">Compact migration enables high-density commercial PWR pressure vessels!</b>';}; document.getElementById('btnKeff').onclick=()=>{document.getElementById('nucLog').innerHTML='<b>2. SIX-FACTOR CRITICALITY \\& REACTIVITY:</b><br>• keff = k\\u221e * P_FNL * P_TNL = 1.08 * 0.95 * 0.98 = <b style=\"color:#10b981;\">1.0055!</b><br>• Reactivity: \\u03c1 = +545 pcm &rarr; <b style=\"color:#38bdf8;\">\\$ = +0.84 \\$ (Delayed Supercritical)!</b><br>• Safe operation strictly requires \\$ < 1.00 \\$!';}; document.getElementById('btnKin').onclick=()=>{document.getElementById('nucLog').innerHTML='<b>3. PRKE PROMPT JUMP \\& STABLE PERIOD:</b><br>• P0 = 1000 MWth with \\u03c1 = +130 pcm (\\$ = 0.20):<br>• Prompt Jump: P_jump = 1000 * [\\u03b2 / (\\u03b2 - \\u03c1)] = <b style=\"color:#10b981;\">1250 MWth!</b><br>• Stable Period: T = (\\u03b2 - \\u03c1) / (\\u03bb*\\u03c1) = 0.0052 / (0.08*0.0013) = <b style=\"color:#38bdf8;\">50.0 seconds!</b><br>• Doubling Time: t_double = 50 * ln(2) = 34.66 s<br>🏆 <b style=\"color:#10b981;\">Nuclear_Reactor_Physics_and_Design 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
