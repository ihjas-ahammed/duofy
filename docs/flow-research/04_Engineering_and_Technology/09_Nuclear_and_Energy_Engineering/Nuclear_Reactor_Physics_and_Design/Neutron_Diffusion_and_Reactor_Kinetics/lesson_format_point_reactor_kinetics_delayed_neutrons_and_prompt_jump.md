# Duofy Reusable Lesson Format: Reactor Kinetics (Delayed Neutrons & Prompt Jump)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Nuclear_Reactor_Physics_and_Design / Neutron_Diffusion_and_Reactor_Kinetics`  
**Lesson Format Type:** `point_reactor_kinetics_delayed_neutrons_and_prompt_jump`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the dynamic time-dependent behavior of nuclear reactors, the coupled **Point Reactor Kinetics Equations (PRKE)**, the physical role of delayed neutron precursors ($\text{Br-87}, \text{I-137}$, total delayed fraction $\beta = \sum \beta_i \approx 0.0065$), prompt neutron generation time ($\Lambda = l / k \approx 10^{-4}\text{ s}$), the derivation of the **Prompt Jump Approximation** for step reactivity insertions ($\rho < \beta$), the fast prompt adjustment phase ($n_{\text{jump}} = n_0 \frac{\beta}{\beta - \rho}$ occurring in $< 10^{-3}\text{ s}$), and subsequent slow precursor-driven asymptotic power growth (John R. Lamarsh, Anthony J. Baratta *Introduction to Nuclear Engineering* 4th ed. Chapter 7; James J. Duderstadt, Louis J. Hamilton *Nuclear Reactor Analysis* Chapter 9; Elmer E. Lewis *Fundamentals of Nuclear Reactor Physics* Chapter 7): formulate the **Point Reactor Kinetics Differential System Master Formulation**:
$$\mathbf{\frac{dn(t)}{dt} = \frac{\rho(t) - \beta}{\Lambda} n(t) + \sum_{i=1}^6 \lambda_i C_i(t) \quad \Big| \quad \mathbf{\frac{dC_i(t)}{dt} = \frac{\beta_i}{\Lambda} n(t) - \lambda_i C_i(t)}}$$
where:
1. **$n(t)$:** Neutron density / instantaneous core thermal power ($\text{MWth}$);
2. **$C_i(t)$:** Concentration of delayed neutron precursor group $i$;
3. **$\beta_i, \lambda_i$:** Delayed neutron fraction and decay constant for group $i$ ($\beta = \sum \beta_i \approx 0.0065$, average decay constant $\lambda \approx 0.08\text{ s}^{-1}$);
4. **$\Lambda$:** Prompt neutron generation time ($\approx 10^{-4}\text{ s}$ in thermal reactors);
derive the **Prompt Jump Analytical Formulation ($n_{\text{jump}}$)**:
$$\mathbf{n_{\text{jump}} = n(0^+) = n_0 \cdot \left[ \frac{\beta}{\beta - \rho} \right] = n_0 \cdot \left[ \frac{1}{1 - \$} \right] \quad (\text{for } 0 < \rho < \beta)}$$
derive the **Complete Prompt-Jump Power Profile ($P(t)$)**:
$$\mathbf{P(t) = P_0 \cdot \left[ \frac{\beta}{\beta - \rho} \right] \cdot \exp\left( \frac{\lambda \rho}{\beta - \rho} \cdot t \right)}$$
(proving that after a positive reactivity step insertion, reactor power immediately jumps to $n_{\text{jump}}$ within milliseconds before continuing on a gentle exponential climb governed by delayed precursor half-lives).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PRKE Coupled Equations, Delayed Precursor Groups ($\beta_i, \lambda_i$) & Prompt Jump ($n_1 = n_0 \frac{\beta}{\beta-\rho}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Prompt Jump Magnitude and Power Evolution Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Reactor Kinetics Parameter / Precursor Entity & Technical Neutronic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Following a Positive Step Reactivity Insertion Less than $\beta$, the Instantaneous Jump in Reactor Power Before Delayed Precursor Concentrations Can Change Is Termed the Prompt ___ (Jump / Prompt Jump) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Nuclear Transient Problem: Computing Prompt Jump Power Level Following a Control Rod Withdrawal Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Point Reactor Kinetics & Delayed Neutrons Mechanics (Lamarsh 2018; Duderstadt 1976):
   - **Kinetics Formulations:**
     $$\mathbf{\dot{n} = \frac{\rho - \beta}{\Lambda} n + \lambda C \quad \Big| \quad \dot{C} = \frac{\beta}{\Lambda} n - \lambda C \quad \Big| \quad n_{\text{jump}} = n_0 \frac{\beta}{\beta - \rho} = \frac{n_0}{1 - \$}}$$
   - **The Delayed Neutron Lifetime Invariant:**
     - Pure prompt neutron lifetime: $\Lambda \approx 10^{-4}\text{ s}$ (power doubles in $0.05\text{ s}$ without delayed neutrons);
     - Effective weighted lifetime with delayed neutrons: $\bar{l} = \Lambda + \sum \frac{\beta_i}{\lambda_i} \approx \mathbf{0.1\text{ seconds}}$, extending control response times to several minutes!
2. **Slide 2 (`ordering`):** Provide 5 steps of prompt jump transient calculation: (1) record initial steady-state reactor power $P_0$ and delayed neutron fraction $\beta$, (2) determine step reactivity insertion $\rho$ from control rod withdrawal, (3) verify delayed critical condition $0 < \rho < \beta$ ($\$ < 1.00$), (4) evaluate prompt jump scaling multiplier: $M_{\text{jump}} = \beta / (\beta - \rho)$, (5) multiply initial power to obtain immediate post-jump power level: $P_{\text{jump}} = P_0 \cdot [\beta / (\beta - \rho)]$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Prompt Neutrons, Delayed Neutrons, Prompt Jump, Precursor Group Decay Constant $\lambda_i$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Jump (or Prompt Jump). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating prompt jump power: A nuclear power reactor operating at steady initial thermal power $P_0 = 1000.0\text{ MWth}$ experiences a positive step reactivity insertion of $\rho = +0.00130$ ($+130\text{ pcm}$) due to a control rod step withdrawal. The core delayed neutron fraction is $\beta = 0.00650$ ($\$ = 0.00130 / 0.00650 = \mathbf{0.20\ \$}$).
   - Prompt jump multiplier:
     $M_{\text{jump}} = \frac{\beta}{\beta - \rho} = \frac{0.00650}{0.00650 - 0.00130} = \frac{0.00650}{0.00520} = \mathbf{1.2500}$;
   - Immediate prompt jump power level:
     $P_{\text{jump}} = P_0 \times M_{\text{jump}} = 1000.0\text{ MWth} \times 1.2500 = \mathbf{1250.0\text{ MWth} = 1250\text{ MWth}}$;
   - What is the instantaneous reactor thermal power immediately following the prompt jump? ($P_{\text{jump}} = \mathbf{1250\text{ MWth}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "point_reactor_kinetics_delayed_neutrons_and_prompt_jump",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Point Reactor Kinetics \\& Prompt Jump (James J. Duderstadt)**\n• **Point Reactor Kinetics Coupled System (PRKE):**\n$$\n\\mathbf{\\frac{dn(t)}{dt} = \\frac{\\rho(t) - \\beta}{\\Lambda} n(t) + \\sum_{i=1}^6 \\lambda_i C_i(t) \\quad \\Big| \\quad \\frac{dC_i(t)}{dt} = \\frac{\\beta_i}{\\Lambda} n(t) - \\lambda_i C_i(t)}\n$$\n  - **$\\beta = \\sum \\beta_i \\approx 0.0065$:** Total delayed neutron fraction (U-235);\n  - **$\\Lambda \\approx 10^{-4}\\text{ s}$:** Prompt neutron generation time;\n  - **$C_i(t), \\lambda_i$:** Concentration and radioactive decay constant of precursor group $i$;\n• **Prompt Jump Approximation Master Formulation ($n_{\\text{jump}}$):**\n$$\n\\mathbf{n_{\\text{jump}} = n(0^+) = n_0 \\cdot \\left[ \\frac{\\beta}{\\beta - \\rho} \\right] = n_0 \\cdot \\left[ \\frac{1}{1 - \\$} \\right] \\quad (\\text{for } 0 < \\rho < \\beta)}\n$$\n• **The Precursor Inertia Invariant:** Delayed neutron precursor concentrations $C_i$ **cannot change instantaneously** ($C(0^+) = C_0$); therefore, prompt neutrons instantly adjust within milliseconds to balance $\\dot{n} \\approx 0$, creating the Prompt Jump before delayed precursors begin their slow exponential growth!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the prompt jump magnitude and time-dependent power trajectory after a step reactivity insertion.",
      "orderItems": [
        "Record initial steady-state core thermal power P0 and effective delayed neutron fraction \u03b2",
        "Determine the inserted step reactivity \u03c1 from the control rod calibration curve",
        "Verify that reactivity is sub-prompt-critical: 0 < \u03c1 < \u03b2 ($ < 1.00 $)",
        "Calculate the prompt jump amplification factor: M_jump = \u03b2 / (\u03b2 - \u03c1) = 1 / (1 - $)",
        "Multiply initial power by the prompt jump factor to obtain post-jump power: P_jump = P0 * [ \u03b2 / (\u03b2 - \u03c1) ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reactor Kinetics Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Delayed Neutrons (\u03b2)", "right": "Neutrons emitted seconds after fission via precursor beta decay enabling stable human reactor control" },
        { "left": "Prompt Jump (n_jump)", "right": "Instantaneous power jump P0*[\u03b2/(\u03b2-\u03c1)] occurring within milliseconds of a step reactivity insertion" },
        { "left": "Prompt Generation Time (\u039b)", "right": "\u2248 10^-4 s in thermal reactors, average time from birth of a prompt neutron to inducing subsequent fission" },
        { "left": "Precursor Groups (Ci)", "right": "Six standard delayed fission product families (e.g. Br-87, I-137) decaying with half-lives up to 55 seconds" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Following a positive step reactivity insertion less than \u03b2, the instantaneous jump in reactor power before delayed precursor concentrations can change is termed the prompt ___.",
      "blankAnswer": "jump",
      "blankDistractors": ["drop", "period", "decay"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A nuclear reactor operating at P0 = 1000.0 MWth experiences a step reactivity insertion of \u03c1 = +0.00130 (+130 pcm). The delayed neutron fraction is \u03b2 = 0.00650 ($ = 0.00130 / 0.00650 = 0.20 $). \u03b2 - \u03c1 = 0.00650 - 0.00130 = 0.00520. M_jump = 0.00650 / 0.00520 = 1.2500. P_jump = 1000.0 * 1.2500 = 1250.0 MWth. What is the immediate power level following the prompt jump?",
      "options": [
        { "text": "P_jump = 1250 MWth (P_jump = P0 * [ \u03b2 / (\u03b2 - \u03c1) ] = 1000.0 MWth * [ 0.00650 / 0.00520 ] = 1000.0 * 1.250 = 1250.0 MWth)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Point Reactor Kinetics prompt jump approximation (James J. Duderstadt & Louis J. Hamilton *Nuclear Reactor Analysis* Chapter 9; John R. Lamarsh *Introduction to Nuclear Engineering* Chapter 7). 1. **Identify Operating Parameters \\& Reactivity Insertion:** - Initial steady thermal power: $P_0 = 1000.0\\text{ MWth}$. - Step reactivity insertion: $\\rho = +0.00130 = +130\\text{ pcm}$. - Delayed neutron fraction: $\\beta = 0.00650$. - Reactivity in dollars: $$\\$ = \\frac{\\rho}{\\beta} = \\frac{0.00130}{0.00650} = \\mathbf{+0.20\\ \\$}$$ 2. **Calculate Prompt Jump Denominator:** $$\\beta - \\rho = 0.00650 - 0.00130 = \\mathbf{0.00520}$$ 3. **Evaluate Prompt Jump Amplification Factor ($M_{\\text{jump}}$):** $$M_{\\text{jump}} = \\frac{\\beta}{\\beta - \\rho} = \\frac{0.00650}{0.00520} = \\mathbf{1.2500}$$ - Alternatively via dollar units: $$M_{\\text{jump}} = \\frac{1}{1 - \\$} = \\frac{1}{1 - 0.20} = \\frac{1}{0.80} = \\mathbf{1.2500}$$ 4. **Calculate Post-Jump Power Level ($P_{\\text{jump}}$):** $$P_{\\text{jump}} = P_0 \\times M_{\\text{jump}} = 1000.0\\text{ MWth} \\times 1.2500 = \\mathbf{1250.0\\text{ MWth} = 1250\\text{ MWth}}$$ - Within $\\sim 1\\text{ ms}$, core thermal power steps from $1000\\text{ MWth} \\to 1250\\text{ MWth}$, after which it ascends smoothly on the stable delayed period! Flawless nuclear prompt jump derivation!" },
        { "text": "P_jump = 1130 MWth (Added pcm directly to power)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_jump = 2000 MWth", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_jump = 1000 MWth (Assumed power cannot change without delayed precursor buildup)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
