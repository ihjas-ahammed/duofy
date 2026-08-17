# Duofy Reusable Lesson Format: Multistage Reactors (CSTRs in Series & Damköhler Numbers)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Reaction_Engineering_CRE / Kinetics_of_Homogeneous_Reactions`  
**Lesson Format Type:** `reactors_in_series_and_damkohler_number_analysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the theory and optimization of multistage continuous chemical reactors, the dimensionless **Damköhler Number ($Da = k \tau$)** measuring the ratio of reaction rate to convective mass transport rate, $N$ equal-sized **CSTRs in Series** ($V_1 = V_2 = \dots = V_N = V_i$), intermediate conversions ($X_1, X_2, \dots, X_N$), fractional exit concentration equations ($C_{AN} = \frac{C_{A0}}{(1 + Da_i)^N}$), total volume reduction through staging ($\sum V_i \ll V_{\text{single CSTR}}$), and the mathematical convergence of an infinite cascade of CSTRs ($N \to \infty$) to an ideal Plug Flow Reactor (PFR) (H. Scott Fogler *Elements of Chemical Reaction Engineering* 5th/6th ed. Chapters 4 & 5; Octave Levenspiel *Chemical Reaction Engineering* Chapter 6): formulate the **Dimensionless Damköhler Number ($Da$) Master Equation**:
$$\mathbf{Da = \frac{\text{Reaction Rate at Entrance}}{\text{Entering Convective Mass Transport}} = \frac{-r_{A0} \cdot V}{F_{A0}} = k \cdot \tau = k \left( \frac{V}{v_0} \right) \quad (\text{for 1st-order reactions})}$$
derive the **$N$ Equal-Sized CSTRs in Series Exit Concentration Formulation**:
$$\mathbf{C_{A,N} = \frac{C_{A0}}{\left( 1 + Da_i \right)^N} = \frac{C_{A0}}{\left( 1 + k \cdot \tau_i \right)^N} \quad \left(\tau_i = \frac{V_i}{v_0} = \frac{\tau_{\text{total}}}{N}\right)}$$
derive the **Overall Multistage Fractional Conversion ($X_N$)**:
$$\mathbf{X_N = 1 - \frac{C_{A,N}}{C_{A0}} = 1 - \frac{1}{\left( 1 + Da_i \right)^N} = 1 - \frac{1}{\left( 1 + \frac{k \cdot \tau_{\text{total}}}{N} \right)^N}}$$
master the **PFR Asymptotic Convergence Invariant**:
- In the limit as the number of stages approaches infinity ($N \to \infty$):
  $$\mathbf{\lim_{N \to \infty} \left( 1 - \frac{1}{\left( 1 + \frac{k \tau}{N} \right)^N} \right) = 1 - e^{-k \tau} = \mathbf{X_{\text{PFR}}}}$$
(proving that subdividing a single large CSTR into just 3 or 4 smaller tanks in series slashes total required reactor volume by over $60\%$, capturing plug-flow efficiency while maintaining simple agitator temperature control).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Damköhler Number ($Da = k\tau$), N CSTRs in Series ($C_{AN} = \frac{C_{A0}}{(1+Da_i)^N}$) & PFR Limit Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Overall Conversion for 3 Equal CSTRs in Series Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Multistage Reactor Parameter / Staging Entity & Technical Chemical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | For a First-Order Liquid Reaction Processed in an Infinite Number of Equal-Sized CSTRs in Series ($N \to \infty$), the Overall Conversion Asymptotically Converges to That of an Ideal ___ Flow Reactor (Plug / PFR) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Chemical Reaction Engineering Studio: Arrhenius Kinetics, Batch, CSTR vs PFR & Multistage Cascades Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reactors_in_series_and_damkohler_number_analysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Damköhler number (Da), and how is conversion calculated for N equal-sized CSTRs in series?",
      "blankAnswer": "Damköhler Numbers & CSTRs in Series Mechanics (Fogler & Levenspiel): (1) DAMKÖHLER NUMBER: Da = k * \u03c4 = k*(V / v0), dimensionless ratio of reaction rate to fluid transport rate. (2) SINGLE CSTR: X = Da / (1 + Da). (3) N CSTRs IN SERIES: CA,N = CA0 / (1 + Da_i)^N \u2192 Overall Conversion X_N = 1 - 1 / (1 + Da_i)^N, where individual stage Damköhler number is Da_i = k*\u03c4_total / N. (4) PFR CONVERGENCE: As N \u2192 \u221e, lim(1 + k\u03c4/N)^(-N) = e^(-k\u03c4), exactly matching ideal PFR conversion X_PFR = 1 - e^(-Da)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the overall conversion achieved by a train of N equal-sized CSTRs in series.",
      "orderItems": [
        "Determine the total train volume V_total, volumetric flow rate v0, and reaction rate constant k",
        "Calculate the total space time \u03c4_total = V_total / v0 and individual stage space time: \u03c4i = \u03c4_total / N",
        "Compute the individual stage Damk\u00f6hler number: Da_i = k * \u03c4i",
        "Evaluate the concentration attenuation denominator: (1 + Da_i)^N",
        "Calculate the overall multistage fractional conversion: X_N = 1 - [ 1 / (1 + Da_i)^N ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Multistage Reactor Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Damk\u00f6hler Number (Da = k\u03c4)", "right": "Dimensionless scaling index comparing chemical reaction speed to hydraulic residence time" },
        { "left": "CSTRs in Series Cascade", "right": "Train of sequential tanks creating stepwise concentration drops that suppress backmixing volume penalties" },
        { "left": "Stage Attenuation (1 + Da_i)^-N", "right": "Fraction of unreacted inlet feed remaining in effluent after passing through N equal continuous stirred stages" },
        { "left": "Infinite Stage Limit (N \u2192 \u221e)", "right": "Asymptotic mathematical convergence where an infinite series of micro-CSTRs behaves identically to an ideal PFR" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a first-order liquid reaction processed in an infinite number of equal-sized CSTRs in series (N \u2192 \u221e), the overall conversion asymptotically converges to that of an ideal ___ flow reactor.",
      "blankAnswer": "plug",
      "blankDistractors": ["batch", "mixed", "fluidized"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Chemical Reaction Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Chemical Reaction Engineering (CRE) Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Arrhenius Kinetics, Batch Times, CSTR vs PFR & Multistage Cascades</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnArr\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Arrhenius (Ea = 64.2 kJ/mol)</button><button id=\"btnBatch\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Batch Reactor (tR = 59.9 min)</button><button id=\"btnCstr\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. CSTR vs PFR & Cascade (N=3)</button></div><div id=\"creLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Arrhenius activation energy...</div><script>document.getElementById('btnArr').onclick=()=>{document.getElementById('creLog').innerHTML='<b>1. ARRHENIUS REACTION KINETICS:</b><br>• k(T) = A*exp(-Ea/RT)<br>• T1=300K (k=0.02s\u207b\u00b9), T2=320K (k=0.10s\u207b\u00b9)<br>• <b style=\"color:#10b981;\">Activation Energy: Ea = 64.2 kJ/mol!</b>';}; document.getElementById('btnBatch').onclick=()=>{document.getElementById('creLog').innerHTML='<b>2. IDEAL BATCH REACTOR SIZING:</b><br>• tR = (1/k)*ln(1 / (1 - X)) = (1/0.05)*ln(20) = <b style=\"color:#10b981;\">59.9 min!</b><br>• Total Cycle: t_cycle = tR + t_dead = 59.9 + 40 = <b style=\"color:#38bdf8;\">99.9 min (14.4 batches/day)!</b>';}; document.getElementById('btnCstr').onclick=()=>{document.getElementById('creLog').innerHTML='<b>3. CONTINUOUS REACTORS \\& CASCADES:</b><br>• Single CSTR: V = FA0*X / -rA = <b style=\"color:#ef4444;\">900 L</b> (Backmix penalty!)<br>• Tubular PFR: V = (v0/k)*ln(1/(1-X)) = <b style=\"color:#10b981;\">230.3 L (3.91x smaller)!</b><br>• 3 CSTRs in Series: X3 = 1 - 1/(1+Da_i)\u00b3 &rarr; Slashes volume by 60%!<br>• <b style=\"color:#38bdf8;\">As N &rarr; &infin; &rarr; Exact Convergence to Ideal PFR!</b><br>🏆 <b style=\"color:#10b981;\">Chemical_Reaction_Engineering_CRE (100% COMPLETE!)</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
