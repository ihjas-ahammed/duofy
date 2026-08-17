# Duofy Reusable Lesson Format: TCRE and Remaining Carbon Budgets

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Carbon_Cycle_and_Global_Warming`  
**Lesson Format Type:** `tcre_and_remaining_carbon_budgets`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative, policy-relevant, and Earth-system mastery of cumulative carbon emissions and carbon budget accounting (Damon Matthews 2009; Myles Allen 2009; Joeri Rogelj; IPCC AR6 2021): master the **Transient Climate Response to Cumulative Carbon Emissions (TCRE)** formulating the remarkable, near-perfect empirical linearity between cumulative global carbon emissions ($E_{\text{cum}}$ in $\text{GtCO}_2$) and global mean surface warming ($\Delta T \approx \text{TCRE} \times E_{\text{cum}}$, where $\text{TCRE} \approx 0.45^\circ\text{C} \pm 0.1^\circ\text{C} \text{ per } 1000\text{ GtCO}_2$), calculate **Remaining Carbon Budgets** for the $1.5^\circ\text{C}$ and $2.0^\circ\text{C}$ Paris Agreement climate targets, evaluate the **Zero Emissions Commitment (ZEC)**, and interact with live cumulative carbon budget and global warming simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TCRE Linear Scaling & Remaining Carbon Budget Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Carbon Budget Metric / Concept & Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Quantitative Warming per 1000 GtCO2 Emitted Under TCRE Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Numerical Value of TCRE Warming in Degrees Celsius per 1000 GtCO2 Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Cumulative Carbon Budget & Temperature Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tcre_and_remaining_carbon_budgets",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the TCRE (Transient Climate Response to Cumulative Emissions) and how is a Remaining Carbon Budget calculated?",
      "blankAnswer": "Climate physics and cumulative carbon budgets (Matthews 2009; Allen 2009; IPCC AR6): (1) THE TCRE THEOREM: Earth System Models reveal a remarkably robust, near-linear relationship between cumulative total anthropogenic CO2 emitted since 1850 and global mean surface temperature rise: Delta T(t) ≈ TCRE × E_cum. (2) THE TCRE CONSTANT: TCRE is estimated at approximately 0.45°C (likely range 0.27°C to 0.63°C) of global warming per 1,000 GtCO2 (or 1.65°C per 1,000 GtC) of cumulative emissions! This linearity arises because two opposing non-linearities nearly perfectly cancel: (a) ocean carbon uptake saturation (which increases the airborne fraction over time), and (b) logarithmic radiative forcing of CO2 (which decreases per-molecule heating efficiency). (3) REMAINING CARBON BUDGET: To limit warming to 1.5°C (with a 50% probability), starting from 2020, humanity's total remaining cumulative emissions budget is approximately 500 GtCO2. At current global emission rates of ~40 GtCO2/year, the 1.5°C carbon budget will be completely exhausted in approximately 10 to 12 years without rapid decarbonization! (4) ZERO EMISSIONS COMMITMENT (ZEC): When net-zero CO2 emissions are reached, global surface warming is projected to stabilize almost immediately (ZEC ≈ 0°C)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each carbon budget term to its exact scientific definition.",
      "matchPairs": [
        { "left": "TCRE (~0.45°C / 1000 GtCO2)", "right": "Transient Climate Response to Cumulative Emissions quantifying warming per unit cumulative carbon" },
        { "left": "Remaining Carbon Budget", "right": "Maximum amount of cumulative net CO2 humanity can emit to stay below a specific temperature threshold" },
        { "left": "Zero Emissions Commitment (ZEC)", "right": "Projected additional global warming that occurs after net anthropogenic CO2 emissions drop to zero" },
        { "left": "Net-Zero CO2 Target", "right": "State where global anthropogenic CO2 emissions are completely balanced by anthropogenic CO2 removals" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does global mean surface warming exhibit a near-perfect linear proportionality with CUMULATIVE total carbon emissions over centuries, even though CO2 radiative forcing is fundamentally non-linear (logarithmic)?",
      "options": [
        { "text": "Two opposing nonlinear physical mechanisms almost exactly cancel each other out: as cumulative emissions grow, the ocean's chemical buffer capacity weakens (increasing the airborne fraction), which precisely counterbalances the diminishing logarithmic radiative efficiency of higher atmospheric CO2 concentrations", "isCorrect": true, "explanation": "Correct! In climate physics, radiative forcing alone is sub-linear—the formula Delta F = 5.35*ln(C/C0) dictates that each additional ton of CO2 traps slightly less heat than the previous ton due to optical saturation. However, the carbon cycle itself is super-linear—as cumulative carbon builds up, the ocean's carbonate buffer capacity becomes depleted (Revelle buffer factor increases) and ocean stratification intensifies, causing the ocean to absorb a smaller percentage of future emissions (the airborne fraction AF rises). Remarkably, extensive numerical experiments with Earth System Models (Matthews et al. 2009; Allen et al. 2009) proved that the ocean carbon sink saturation and the logarithmic radiative forcing cancel each other out almost perfectly. As a result, warming scales linearly with cumulative emissions: every 1,000 GtCO2 emitted causes roughly +0.45°C of warming regardless of the timing of emissions." },
        { "text": "Because all greenhouse gases disappear from Earth after exactly one year", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the sun gets hotter whenever humans burn coal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because cumulative emissions are measured with a linear wooden ruler", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under the IPCC AR6 assessment, the central estimate for the TCRE constant is approximately ___ degrees Celsius of warming per 1,000 GtCO2 emitted.",
      "blankAnswer": "0.45",
      "blankDistractors": ["4.5", "0.01", "10.0"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Cumulative Carbon Budget & Temperature Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>TCRE & Remaining Carbon Budget Engine</h3><p>Baseline: $2400\\text{ GtCO}_2$ emitted since 1850 $\\implies +1.2^\\circ\\text{C}$ Warming</p><button id=\"b15Btn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">1.5°C Budget (+500 GtCO2 Limit)</button><button id=\"b20Btn\" style=\"padding:8px 16px; margin:4px; background:#f59e0b; color:white; border:none; border-radius:6px; cursor:pointer;\">2.0°C Budget (+1150 GtCO2 Limit)</button><button id=\"bauBtn\" style=\"padding:8px 16px; margin:4px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Business as Usual (+3000 GtCO2 Scenario)</button><div id=\"tcreOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an emissions scenario above...</div><script>document.getElementById('b15Btn').onclick=()=>{document.getElementById('tcreOut').innerText='1.5°C Pathway: +500 GtCO2 budget -> Net-Zero by 2050 -> Peak Warming: 1.5°C (TCRE = 0.45°C/1000 GtCO2)! High climate stability!';}; document.getElementById('b20Btn').onclick=()=>{document.getElementById('tcreOut').innerText='2.0°C Pathway: +1150 GtCO2 budget -> Net-Zero by 2070 -> Peak Warming: 1.95°C -> High sea level rise commitment!';}; document.getElementById('bauBtn').onclick=()=>{document.getElementById('tcreOut').innerText='Unmitigated Scenario: +3000 GtCO2 -> Total: 5400 GtCO2 -> Global Warming: +2.6°C to +3.5°C! CATASTROPHIC TIPPING POINTS!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
