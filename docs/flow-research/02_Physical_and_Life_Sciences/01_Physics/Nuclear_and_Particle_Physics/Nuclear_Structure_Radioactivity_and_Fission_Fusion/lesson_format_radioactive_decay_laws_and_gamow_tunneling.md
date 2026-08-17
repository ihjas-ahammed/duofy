# Duofy Reusable Lesson Format: Radioactive Decay Laws and Gamow Tunneling

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Nuclear_Structure_Radioactivity_and_Fission_Fusion`  
**Lesson Format Type:** `radioactive_decay_laws_and_gamow_tunneling`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through radioactive decay kinetics and quantum tunneling: formulate the **Radioactive Decay Law ($N(t) = N_0 e^{-\lambda t}$)**, compute **Half-Life ($T_{1/2} = \frac{\ln 2}{\lambda}$)** and activity $A = \lambda N$ in Becquerels / Curies, solve the **Bateman Equations for Radioactive Decay Series** (secular and transient equilibrium), explain **Gamow's Quantum Tunneling Theory of Alpha Decay (George Gamow, 1928)**, and derive the **Geiger-Nuttall Law ($\ln T_{1/2} \propto \frac{Z}{\sqrt{Q_\alpha}} + \text{const}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Decay Kinetics & Gamow Alpha Tunneling Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Gamow WKB Barrier Transmission Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Decay Mode & Nuclear Emission Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Half-Life Formula Natural Log Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Geiger-Nuttall Law Exponential Half-Life Sensitivity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Radioactive Decay Kinetics and Gamow Theory:
   - **Decay Law:** $N(t) = N_0 e^{-\lambda t}$, where $\lambda = \frac{1}{\tau} = \frac{\ln 2}{T_{1/2}}$.
   - **Activity:** $A(t) = \lambda N(t) = A_0 e^{-\lambda t}$ ($1\text{ Bq} = 1\text{ decay/s}$, $1\text{ Ci} = 3.7 \times 10^{10}\text{ Bq}$).
   - **Secular Equilibrium (Long-lived parent $\lambda_1 \ll \lambda_2$):** $A_2(t) \to A_1$.
   - **Gamow Theory of Alpha Decay (George Gamow, Ronald Gurney, Edward Condon, 1928):**
     An $\alpha$-particle ($^{4}\text{He}^{2+}$) with kinetic energy $Q_\alpha \approx 4-9\text{ MeV}$ is trapped behind a Coulomb barrier of height $V_C = \frac{2(Z-2)e^2}{4\pi\epsilon_0 R} \approx 25-30\text{ MeV}$.
     - **Decay Constant:** $\lambda = \nu_0 P_{\text{tunnel}} = \left(\frac{v_\alpha}{2R}\right) e^{-2 G}$.
     - **Gamow Factor $G$ (WKB Approximation):**
       $$G = \frac{\sqrt{2m_\alpha}}{\hbar} \int_R^{r_{\text{out}}} \sqrt{\frac{2(Z-2)e^2}{4\pi\epsilon_0 r} - Q_\alpha} \, dr \implies \ln \lambda = C_1 - C_2 \frac{Z}{\sqrt{Q_\alpha}}$$
     *(The Geiger-Nuttall Law: small changes in $Q_\alpha$ cause 24 orders of magnitude change in $T_{1/2}$!).*
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Gamow alpha decay tunneling factor: (1) express WKB tunneling exponent: $G = \frac{1}{\hbar}\int_R^{b} \sqrt{2m_\alpha(V(r) - Q_\alpha)} dr$ where $V(r) = \frac{2 Z' e^2}{4\pi\epsilon_0 r}$, (2) identify outer turning point: $b = \frac{2 Z' e^2}{4\pi\epsilon_0 Q_\alpha}$, (3) substitute variable $r = b \cos^2\theta$: $G = \frac{\sqrt{2m_\alpha Q_\alpha}}{\hbar} b \int_0^{\arccos(\sqrt{R/b})} 2\sin^2\theta d\theta$, (4) evaluate integral in thin-barrier limit ($R \ll b$): $\int_0^{\pi/2} 2\sin^2\theta d\theta = \frac{\pi}{2}$, (5) substitute $b$ to find Gamow factor: $G = \frac{\pi e^2 Z'}{\hbar} \sqrt{\frac{2m_\alpha}{Q_\alpha}} \propto \frac{Z}{\sqrt{Q_\alpha}}$!
3. **Slide 3 (`matching`):** Pair 4 nuclear decay modes ($\alpha$-decay, $\beta^-$-decay, $\beta^+$-decay, $\gamma$-decay) with their particle transformations and emitted particles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that half-life relates to decay constant as T_{1/2} = ln(2) / lambda. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Geiger-Nuttall Law: Why does a modest factor-of-2 increase in alpha particle energy $Q_\alpha$ (from 4 MeV in $^{238}\text{U}$ to 8.8 MeV in $^{212}\text{Po}$) shorten the half-life by over TWENTY ORDERS OF MAGNITUDE (from 4.5 billion years to 0.3 microseconds)? (Because the quantum tunneling transmission probability $P = e^{-2G}$ depends EXPONENTIALLY on the inverse square root of energy ($G \propto 1/\sqrt{Q_\alpha}$); a factor-of-2 increase in $Q_\alpha$ drastically shrinks both the barrier height and width, amplifying transmission exponentially).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "radioactive_decay_laws_and_gamow_tunneling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Radioactive Decay Laws and Gamow Alpha Tunneling**\n• **Radioactive Decay Kinetics:**\n$$\nN(t) = N_0 e^{-\\lambda t}, \\qquad T_{1/2} = \\frac{\\ln 2}{\\lambda} \\approx \\frac{0.693}{\\lambda}, \\qquad A(t) = \\lambda N(t)\n$$\n• **Gamow Theory of Alpha Decay (1928):**\n  Alpha particles ($Q_\\alpha \\approx 4-9\\text{ MeV}$) escape by **quantum mechanical tunneling** through the higher Coulomb barrier ($V_C \\sim 30\\text{ MeV}$).\n• **The Geiger-Nuttall Law:**\n$$\n\\lambda = \\nu_0 e^{-2G} \\implies \\ln T_{1/2} = A + B \\frac{Z}{\\sqrt{Q_\\alpha}}\n$$\n  *(A tiny increase in $Q_\\alpha$ drastically increases tunneling probability, shrinking half-life from billions of years to microseconds!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the WKB quantum tunneling steps deriving the Gamow factor G proportional to Z / sqrt(Q_alpha).",
      "orderItems": [
        "Set up WKB barrier penetration integral: G = (1 / hbar) * int_R^b sqrt( 2 m_alpha [ (2 Z' e^2 / (4 pi eps_0 r)) - Q_alpha ] ) dr",
        "Determine the classical turning point radius b where potential energy matches alpha energy: V(b) = Q_alpha",
        "Perform trigonometric substitution r = b * cos^2(theta) to eliminate square root singularities",
        "Evaluate the definite integral in the nuclear limit R << b to obtain the dominant factor pi/2",
        "Substitute turning point b to conclude Gamow factor G = (pi e^2 Z' / hbar) * sqrt(2 m_alpha / Q_alpha) proportional to Z / sqrt(Q_alpha)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each radioactive decay mode to its fundamental nuclear transformation.",
      "matchPairs": [
        { "left": "Alpha Decay (alpha)", "right": "Emission of 4He nucleus (2 protons, 2 neutrons) via quantum barrier tunneling" },
        { "left": "Beta-Minus Decay (beta-)", "right": "Neutron converts to proton: n -> p + e- + anti-nu_e (mediated by W- boson)" },
        { "left": "Beta-Plus Decay (beta+)", "right": "Proton converts to neutron: p -> n + e+ + nu_e (positron emission)" },
        { "left": "Gamma De-excitation (gamma)", "right": "Electromagnetic photon emission between excited nuclear quantum states without changing Z or A" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The relationship between radioactive half-life T_{1/2} and decay constant lambda is T_{1/2} = ln(___) / lambda.",
      "blankAnswer": "2",
      "blankDistractors": ["10", "e", "pi"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does a small change in alpha particle energy Q_alpha (from 4 MeV in U-238 to 8.8 MeV in Po-212) decrease the half-life by over TWENTY-FOUR ORDERS OF MAGNITUDE?",
      "options": [
        { "text": "Because the quantum tunneling probability through the Coulomb barrier P = exp(-2G) depends EXPONENTIALLY on 1/sqrt(Q_alpha); higher energy alpha particles see a significantly thinner and lower barrier, amplifying transmission probability exponentially", "isCorrect": true, "explanation": "Correct! In Gamow theory, tunneling transmission scales as P = exp(-C * Z / sqrt(Q_alpha)). Because energy is in the denominator of the negative exponent, increasing Q_alpha by a factor of 2 causes an exponential surge in transmission by 10^24." },
        { "text": "Because Po-212 has no neutrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because U-238 decays by fission instead", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the speed of light changes inside heavy nuclei", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
