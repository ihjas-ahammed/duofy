# Duofy Reusable Lesson Format: BOD Kinetics (First-Order Organic Decay & Ultimate Demand)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Wastewater_Treatment_and_Sewage`  
**Lesson Format Type:** `bod_kinetics_and_first_order_organic_decay`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the biochemistry and mathematical modeling of **Biochemical Oxygen Demand (BOD)**, the measurement of biodegradable organic matter in municipal sewage, first-order aerobic microbial decomposition kinetics ($\frac{dL}{dt} = -k L$), the relationship between remaining organic oxygen equivalent ($L_t$) and exerted oxygen demand ($y(t) = \text{BOD}_t$), the definition of **Ultimate BOD ($L_0$ or $\text{BOD}_u$)**, the standard $5\text{-day}$ incubation test ($\text{BOD}_5$ at $20^\circ\text{C}$), Arrhenius temperature correction coefficients ($\theta_T = 1.047$), and nitrogenous vs carbonaceous oxygen demand (CBOD vs NBOD) (Metcalf & Eddy *Wastewater Engineering* 5th ed. Chapter 2; Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 11): formulate the **First-Order BOD Exertion Master Equations**:
$$\mathbf{L_t = L_0 \cdot e^{-k t} = L_0 \cdot 10^{-K t} \quad \left(k = 2.303 \cdot K\right)}$$
$$\mathbf{y(t) = \text{BOD}_t = L_0 - L_t = L_0 \left( 1 - e^{-k t} \right)}$$
where:
1. **$L_0 = \text{BOD}_u$:** Total ultimate carbonaceous biochemical oxygen demand ($\text{mg/L}$);
2. **$y(t) = \text{BOD}_t$:** Cumulative oxygen consumed by bacteria up to time $t$ ($\text{mg/L}$);
3. **$k$:** Base-$e$ first-order reaction rate constant in $\text{day}^{-1}$ ($k_{20} \approx 0.23\text{ day}^{-1}$ for domestic sewage);
derive the **Standard 5-Day BOD Relation ($\text{BOD}_5$)**:
$$\mathbf{\text{BOD}_5 = L_0 \left( 1 - e^{-5 k} \right) \Longleftrightarrow \mathbf{L_0 = \frac{\text{BOD}_5}{1 - e^{-5 k}}}}$$
derive the **Temperature Correction Equation ($k_T$)**:
$$\mathbf{k_T = k_{20} \cdot \theta^{(T - 20)} \quad (\theta = 1.047 \text{ for } 20^\circ\text{C} \le T \le 30^\circ\text{C}, \ \theta = 1.135 \text{ for } 4^\circ\text{C} \le T < 20^\circ\text{C})}$$
(proving that $\text{BOD}_5$ measures approximately $68\%$ of total ultimate demand $L_0$ in standard domestic wastewater).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | BOD Decay Kinetics ($y(t) = L_0(1-e^{-kt})$), $L_0 = \frac{\text{BOD}_5}{1-e^{-5k}}$ & $k_T = k_{20}(1.047)^{T-20}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Ultimate BOD and 7-Day BOD from 5-Day Lab Data Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | BOD Kinetic Parameter / Stage & Technical Environmental Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In First-Order BOD Kinetics, the Total Ultimate Oxygen Demand $L_0$ Equals $\text{BOD}_5$ Divided by the Quantity $(1 - e^{\text{___}})$ (-5k / -5*k) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Wastewater Engineering Problem: Computing Ultimate BOD L_0 and 10-Day BOD Exertion for Municipal Sewage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State BOD Kinetics & Decay Formulations (Phelps 1909; Metcalf & Eddy 2014; Davis 2020):
   - **Kinetic & Exertion Formulations:**
     $$\mathbf{y(t) = L_0(1 - e^{-kt}) \quad \Big| \quad L_0 = \frac{\text{BOD}_5}{1 - e^{-5k}} \quad \Big| \quad k_T = k_{20}(1.047)^{T-20} \quad \Big| \quad \text{NBOD: } \text{NH}_4^+ + 2\text{O}_2 \to \text{NO}_3^- + 2\text{H}^+ + \text{H}_2\text{O}}$$
   - **BOD Parameters Comparison Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{BOD Parameter} & \textbf{Symbol} & \textbf{Environmental Significance} \\
     \hline
     \mathbf{\text{5-Day Standard BOD}} & \mathbf{\text{BOD}_5} & \text{Regulatory discharge standard; captures } \approx 68\% \text{ of ultimate load} \\
     \mathbf{\text{Ultimate Carbonaceous BOD}} & \mathbf{L_0 = \text{BOD}_u} & \text{Total organic carbonaceous oxygen requirement over } \infty \text{ days} \\
     \mathbf{\text{Decay Rate Constant}} & \mathbf{k} & \text{Speed of bacterial breakdown; } k_{20} \approx 0.23\text{ day}^{-1} \text{ (base } e) \\
     \mathbf{\text{Nitrogenous BOD (NBOD)}} & \text{NBOD} & \text{Exerted after day 8-10 by autotrophic nitrifiers converting ammonia} \\
     \hline
     \end{array}$$
   - **The Mass Conservation Invariant:** At any time $t$, the sum of exerted BOD and remaining unoxidized BOD **strictly equals total ultimate demand: $y(t) + L_t = L_0$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of BOD analysis: (1) obtain measured laboratory 5-day BOD ($\text{BOD}_5$) at $20^\circ\text{C}$, (2) extract or calculate first-order reaction rate constant $k_{20}$, (3) adjust rate constant for field stream temperature: $k_T = k_{20}(1.047)^{T-20}$, (4) compute ultimate carbonaceous BOD: $L_0 = \text{BOD}_5 / (1 - e^{-5 k})$, (5) evaluate cumulative exerted oxygen demand at any future travel time $t$: $y(t) = L_0 (1 - e^{-k t})$!
3. **Slide 3 (`matching`):** Pair 4 concepts (5-Day BOD, Ultimate BOD $L_0$, Temperature Coefficient $\theta = 1.047$, Nitrogenous BOD) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of -5k (or -5*k). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating ultimate BOD: A municipal sewage sample has a measured $\text{BOD}_5 = 200.0\text{ mg/L}$ at $20^\circ\text{C}$. The first-order biodegradation rate constant is $k = 0.230\text{ day}^{-1}$. Given $e^{-5(0.230)} = e^{-1.15} = 0.3166$.
   - Ultimate BOD: $L_0 = \frac{\text{BOD}_5}{1 - e^{-5 k}} = \frac{200.0}{1 - 0.3166} = \frac{200.0}{0.6834} = \mathbf{292.65\text{ mg/L} \approx 292.7\text{ mg/L}}$;
   - Exerted 10-day BOD ($t = 10\text{ days}$):
     - $e^{-10(0.230)} = e^{-2.30} = 0.10026$;
     - $y(10) = L_0 (1 - e^{-10 k}) = 292.65 \times (1 - 0.10026) = 292.65 \times 0.89974 = \mathbf{263.31\text{ mg/L} \approx 263.3\text{ mg/L}}$;
   - What is the Ultimate BOD $L_0$ and the 10-day BOD demand? ($L_0 = \mathbf{292.7\text{ mg/L}}$ and $\text{BOD}_{10} = \mathbf{263.3\text{ mg/L}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bod_kinetics_and_first_order_organic_decay",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Biochemical Oxygen Demand Kinetics (Earle Phelps \\& Streeter)**\n• **First-Order BOD Exertion Master Equations:**\n$$\n\\mathbf{y(t) = \\text{BOD}_t = L_0 \\left( 1 - e^{-k t} \\right) \\quad \\Big| \\quad \\mathbf{L_t = L_0 \\cdot e^{-k t}}}\n$$\n  - **$L_0 = \\text{BOD}_u$:** Total ultimate carbonaceous biochemical oxygen demand ($\\text{mg/L}$);\n  - **$y(t)$:** Cumulative oxygen consumed up to incubation time $t$ ($\\text{mg/L}$);\n  - **$k$:** First-order rate constant ($\\text{day}^{-1}$);\n• **Standard 5-Day BOD Formulation ($\\text{BOD}_5$):**\n$$\n\\mathbf{L_0 = \\frac{\\text{BOD}_5}{1 - e^{-5 k}} \\Longleftrightarrow \\mathbf{\\text{BOD}_5 = L_0 \\left( 1 - e^{-5 k} \\right)}}\n$$\n• **Arrhenius Temperature Correction:** $\\mathbf{k_T = k_{20} \\cdot (1.047)^{T - 20}}$\n• **The Organic Invariant:** At any time $t$, total oxygen demand is strictly conserved: **$y(t) + L_t = L_0$**; as bacteria oxidize waste, exerted BOD rises while remaining organic load exponentially decays to zero!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the ultimate BOD and long-term oxygen exertion for a municipal wastewater discharge.",
      "orderItems": [
        "Measure the 5-day Biochemical Oxygen Demand (BOD5) from standard laboratory bottle dilution testing at 20\u00b0C",
        "Obtain or calibrate the first-order biodegradation rate constant k20 (typically 0.23 day^-1 for domestic sewage)",
        "Adjust the reaction rate constant for field stream temperature: kT = k20 * (1.047)^(T - 20)",
        "Calculate the ultimate carbonaceous biochemical oxygen demand: L0 = BOD5 / (1 - e^(-5*k))",
        "Evaluate cumulative exerted oxygen demand at any future river travel time t: y(t) = L0 * (1 - e^(-k*t))"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each BOD Kinetic Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "5-Day BOD (BOD5)", "right": "Standard regulatory metric representing oxygen consumed during 5 days of incubation at 20\u00b0C (\u2248 68% of L0)" },
        { "left": "Ultimate BOD (L0)", "right": "Total theoretical oxygen required for complete aerobic biological oxidation of all carbonaceous organic matter" },
        { "left": "Temperature Factor (\u03b8 = 1.047)", "right": "Arrhenius kinetic coefficient scaling bacterial metabolic digestion rates with temperature" },
        { "left": "Nitrogenous Demand (NBOD)", "right": "Secondary oxygen exertion caused by nitrifying bacteria oxidizing ammonia (NH4+) to nitrate (NO3-)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In first-order BOD kinetics, the total ultimate oxygen demand L0 equals BOD5 divided by the quantity (1 - e^___).",
      "blankAnswer": "-5k",
      "blankDistractors": ["-k", "-10k", "+5k"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A wastewater sample has BOD5 = 200.0 mg/L at 20\u00b0C with k = 0.230 day^-1 (e^(-5*0.230) = e^(-1.15) = 0.3166 \u2192 1 - e^-5k = 0.6834). What is the ultimate carbonaceous BOD L0 and the 10-day exerted demand BOD10 (e^(-10*0.230) = 0.1003)?",
      "options": [
        { "text": "L0 = 292.7 mg/L and BOD10 = 263.3 mg/L (L0 = 200.0 / 0.6834 = 292.65 mg/L; BOD10 = 292.65 * (1 - 0.1003) = 292.65 * 0.8997 = 263.30 mg/L)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using first-order BOD kinetics (Metcalf & Eddy *Wastewater Engineering* Chapter 2; Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 11). 1. **Identify Laboratory Inputs:** - 5-day measured demand: $\\text{BOD}_5 = 200.0\\text{ mg/L}$. - First-order rate constant: $k = 0.230\\text{ day}^{-1}$. 2. **Calculate Ultimate Carbonaceous BOD ($L_0$):** - Exponent for 5 days: $$-5 \\cdot k = -5 \\times 0.230 = \\mathbf{-1.150}$$ - Decay factor: $$e^{-1.150} = \\mathbf{0.316637}$$ - Exertion fraction at Day 5: $$1 - e^{-5 k} = 1 - 0.316637 = \\mathbf{0.683363}$$ - Total ultimate demand: $$L_0 = \\frac{\\text{BOD}_5}{1 - e^{-5 k}} = \\frac{200.0\\text{ mg/L}}{0.683363} = \\mathbf{292.67\\text{ mg/L} \\approx 292.7\\text{ mg/L}}$$ 3. **Calculate 10-Day Exerted BOD ($y(10) = \\text{BOD}_{10}$):** - Exponent for 10 days: $$-10 \\cdot k = -10 \\times 0.230 = \\mathbf{-2.300}$$ - Remaining organic fraction: $$e^{-2.300} = \\mathbf{0.100259}$$ - Exerted fraction at Day 10: $$1 - e^{-10 k} = 1 - 0.100259 = \\mathbf{0.899741}$$ - Cumulative oxygen demand: $$\\text{BOD}_{10} = L_0 \\left( 1 - e^{-10 k} \\right) = 292.67\\text{ mg/L} \\times 0.899741 = \\mathbf{263.33\\text{ mg/L} \\approx 263.3\\text{ mg/L}}$$ Flawless first-order BOD exertion and ultimate demand derivation!" },
        { "text": "L0 = 200.0 mg/L and BOD10 = 180.0 mg/L", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L0 = 292.7 mg/L and BOD10 = 292.7 mg/L (Assumed complete 100% exertion)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L0 = 400.0 mg/L and BOD10 = 350.0 mg/L", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
