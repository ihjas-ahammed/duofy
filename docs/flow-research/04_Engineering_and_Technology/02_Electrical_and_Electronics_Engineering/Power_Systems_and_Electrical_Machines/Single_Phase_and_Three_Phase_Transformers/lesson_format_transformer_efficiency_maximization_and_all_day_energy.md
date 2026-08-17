# Duofy Reusable Lesson Format: Energy Efficiency (Loss Optimization & All-Day Metric)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Single_Phase_and_Three_Phase_Transformers`  
**Lesson Format Type:** `transformer_efficiency_maximization_and_all_day_energy`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through power transformer loss components (constant iron core losses $P_{\text{core}} = P_h + P_e$ vs variable winding copper losses $P_{cu} = x^2 P_{cu,\text{fl}}$), the mathematical derivation of maximum efficiency loading, power factor impact on efficiency, and the 24-hour All-Day Energy Efficiency ($\eta_{\text{all-day}}$) metric used for municipal distribution network design (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2; A. E. Fitzgerald *Electric Machinery* Chapter 2): formulate the **General Real-Time Power Efficiency Equation**:
$$\mathbf{\eta = \frac{P_{\text{out}}}{P_{\text{in}}} = \frac{P_{\text{out}}}{P_{\text{out}} + P_{\text{loss}}} = \frac{x S_{\text{rated}} \cos\theta}{x S_{\text{rated}} \cos\theta + P_{\text{core}} + x^2 P_{cu,\text{fl}}}}$$
where $x = \frac{S_{\text{actual}}}{S_{\text{rated}}} = \frac{I_2}{I_{2,\text{fl}}}$ is the per-unit fraction of rated full load; derive the **Maximum Efficiency Condition**:
$$\mathbf{\frac{d\eta}{dx} = 0 \Longleftrightarrow x^2 P_{cu,\text{fl}} = P_{\text{core}} \implies \mathbf{x_{\text{max }\eta} = \sqrt{\frac{P_{\text{core}}}{P_{cu,\text{fl}}}}}}$$
(proving that maximum efficiency occurs at that exact load level where **variable copper winding loss equals constant iron core loss**); derive the **24-Hour All-Day Energy Efficiency**:
$$\mathbf{\eta_{\text{all-day}} = \frac{E_{\text{out,24h}}}{E_{\text{in,24h}}} = \frac{\sum_{k=1}^M (P_{\text{out},k} \times t_k)}{\sum_{k=1}^M (P_{\text{out},k} \times t_k) + (P_{\text{core}} \times 24\text{ h}) + \sum_{k=1}^M (x_k^2 P_{cu,\text{fl}} \times t_k)}}$$
(analyzing why distribution transformers are intentionally engineered with very low core losses $P_{\text{core}} \ll P_{cu,\text{fl}}$ to maximize all-day energy efficiency during long 24/7 idle or light-load periods).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Real Efficiency ($\eta = \frac{x S \cos\theta}{x S \cos\theta + P_{\text{core}} + x^2 P_{cu}}$), Max Loading ($x = \sqrt{\frac{P_{\text{core}}}{P_{cu}}}$) & All-Day Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Full-Load Efficiency and All-Day Energy Efficiency Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Transformer Loss Mechanism / Efficiency Construct & Technical Operational Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Power Transformers, Maximum Efficiency Occurs at the Exact Load Level Where Variable Copper Losses Equal Constant ___ Losses (Core / Iron) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Power Engineering Problem: Calculating Load Fraction for Maximum Efficiency and \eta_max for a 100 kVA Transformer Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Transformer Efficiency & All-Day Energy (Chapman 2012; Fitzgerald 2013):
   - **Efficiency & All-Day Formulations:**
     $$\mathbf{\eta = \frac{x S_n \cos\theta}{x S_n \cos\theta + P_{\text{core}} + x^2 P_{cu,\text{fl}}} \quad \Big| \quad \mathbf{x_{\text{max }\eta} = \sqrt{\frac{P_{\text{core}}}{P_{cu,\text{fl}}}}} \quad \Big| \quad \eta_{\text{all-day}} = \frac{E_{\text{out}}}{E_{\text{out}} + 24 P_{\text{core}} + E_{cu}}}$$
   - **Power vs Distribution Transformer Design Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Transformer Type} & \textbf{Loading Profile} & \textbf{Loss Design Ratio } P_{\text{core}} / P_{cu,\text{fl}} & \textbf{Max Efficiency Point } x_{\text{max }\eta} \\
     \hline
     \mathbf{\text{Power Transformer}} & \text{Operates continuously near 100\% load} & P_{\text{core}} \approx P_{cu,\text{fl}} & \mathbf{x \approx 0.90 - 1.00 \ (\text{Full Load})} \\
     \mathbf{\text{Distribution Transformer}} & \text{Varies widely (light night load)} & \mathbf{P_{\text{core}} \ll P_{cu,\text{fl}} \ (1:3 \text{ to } 1:4)} & \mathbf{x \approx 0.50 - 0.70 \ (\text{Average Load})} \\
     \hline
     \end{array}$$
   - **The All-Day Core Loss Invariant:** Core loss occurs continuously **24 hours a day** ($24 \times P_{\text{core}}$) regardless of load, while copper loss is consumed only when load current flows ($x^2 P_{cu,\text{fl}} \times t$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of All-Day Energy Efficiency calculation: (1) record constant core loss $P_{\text{core}}$ (kW) and full-load copper loss $P_{cu,\text{fl}}$ (kW), (2) calculate total daily energy output: $E_{\text{out}} = \sum x_k S_n \cos\theta_k t_k$ (kWh), (3) compute 24-hour total iron loss energy: $E_{\text{core}} = P_{\text{core}} \times 24\text{ h}$ (kWh), (4) compute daily total copper loss energy: $E_{cu} = \sum x_k^2 P_{cu,\text{fl}} t_k$ (kWh), (5) evaluate all-day efficiency: $\eta_{\text{all-day}} = \frac{E_{\text{out}}}{E_{\text{out}} + E_{\text{core}} + E_{cu}} \times 100\%$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Max Efficiency Condition $x = \sqrt{P_c/P_{cu}}$, Core Loss Energy $24 \cdot P_{\text{core}}$, Copper Loss $x^2 P_{cu,\text{fl}}$, Power Factor Impact) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Core (or Iron). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on finding load fraction for maximum efficiency: A $100\text{ kVA}$ single-phase power transformer has constant core loss $P_{\text{core}} = 1000\text{ W} = 1.0\text{ kW}$ and full-load copper loss $P_{cu,\text{fl}} = 1600\text{ W} = 1.6\text{ kW}$. What fraction $x$ of full load produces maximum efficiency, what is the kVA output at this optimal operating point, and what is the maximum efficiency $\eta_{\text{max}}$ at unity power factor? ($x_{\text{max }\eta} = \sqrt{\frac{P_{\text{core}}}{P_{cu,\text{fl}}}} = \sqrt{\frac{1000}{1600}} = \sqrt{0.625} = \mathbf{0.79057 \approx 0.791\text{ (or } 79.1\%\text{ full load)}}$; Optimal kVA $= 0.79057 \times 100\text{ kVA} = \mathbf{79.06\text{ kVA}}$; At max efficiency, copper loss $=$ core loss $= 1000\text{ W} \implies P_{\text{loss}} = 2 \times 1000\text{ W} = 2000\text{ W} = 2.0\text{ kW}$; $P_{\text{out}} = 79.057\text{ kW}$; $\eta_{\text{max}} = \frac{79.057}{79.057 + 2.000} \times 100\% = \frac{79.057}{81.057} \times 100\% = \mathbf{97.53\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transformer_efficiency_maximization_and_all_day_energy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Transformer Efficiency \\& Loss Optimization (Stephen Chapman)**\n• **General Operating Power Efficiency Formulation:**\n$$\n\\mathbf{\\eta = \\frac{x S_{\\text{rated}} \\cos\\theta}{x S_{\\text{rated}} \\cos\\theta + P_{\\text{core}} + x^2 P_{cu,\\text{fl}}} \\quad (x = \\text{Load Fraction } = I_2 / I_{2,\\text{fl}})}\n$$\n• **Maximum Efficiency Loading Condition ($x_{\\text{max }\\eta}$):**\n$$\n\\mathbf{\\frac{d\\eta}{dx} = 0 \\implies x^2 P_{cu,\\text{fl}} = P_{\\text{core}} \\implies \\mathbf{x_{\\text{max }\\eta} = \\sqrt{\\frac{P_{\\text{core}}}{P_{cu,\\text{fl}}}}}}\n$$\n• **24-Hour All-Day Energy Efficiency (Distribution Systems):**\n$$\n\\mathbf{\\eta_{\\text{all-day}} = \\frac{E_{\\text{out,24h}}}{E_{\\text{out,24h}} + 24 \\cdot P_{\\text{core}} + \\sum_{k=1}^M x_k^2 P_{cu,\\text{fl}} t_k}}\n$$\n• **The Continuous Core Loss Invariant:** Core loss $P_{\\text{core}}$ is energized continuously **24 hours a day** ($24 \\cdot P_{\\text{core}}$), whereas copper loss occurs only when current is delivered, explaining why distribution units prioritize ultra-low core losses!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to compute the 24-hour All-Day Energy Efficiency of a distribution transformer from a daily load profile.",
      "orderItems": [
        "Record the constant core iron loss P_core (kW) and full-load series copper loss P_cu,fl (kW)",
        "Calculate the active electrical energy delivered to the load for each daily time interval: E_out,k = x_k * S_n * cos(\u03b8_k) * t_k",
        "Sum all load energy intervals to obtain total 24-hour useful energy output: E_out,24h = \u2211 E_out,k",
        "Compute the constant 24-hour core loss energy (E_core = 24 * P_core) and sum interval copper losses (E_cu = \u2211 x_k^2 * P_cu,fl * t_k)",
        "Calculate overall All-Day Energy Efficiency: \u03b7_all-day = [E_out,24h / (E_out,24h + E_core + E_cu)] * 100%"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Energy Loss Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Maximum Efficiency Condition", "right": "x = \u221a(Pcore / Pcu,fl), exact load fraction where variable copper loss equals constant core loss" },
        { "left": "Core Iron Loss (Pcore)", "right": "Constant loss composed of magnetic hysteresis and eddy currents energized 24 hours per day" },
        { "left": "Winding Copper Loss (Pcu)", "right": "x^2 * Pcu,fl, I^2*R ohmic loss scaling quadratically with the load fraction x" },
        { "left": "Distribution Transformer Optimization", "right": "Designed with Pcore << Pcu,fl so peak efficiency coincides with 50-70% average daily loading" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In power transformers, maximum efficiency occurs at the exact load level where variable copper losses equal constant ___ losses.",
      "blankAnswer": "core",
      "blankDistractors": ["stray", "dielectric", "mechanical"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 100 kVA single-phase power transformer has constant core loss Pcore = 1000 W (1.0 kW) and full-load copper loss Pcu,fl = 1600 W (1.6 kW). What fraction x of full load produces maximum efficiency, and what is \u03b7_max at unity power factor?",
      "options": [
        { "text": "x = 0.791 (79.1% load / 79.06 kVA) and \u03b7_max = 97.53% (x = \u221a(1000/1600) = \u221a0.625 = 0.79057; Pout = 79.057 kW; Ploss = 2 * 1000 W = 2.0 kW; \u03b7_max = 79.057 / (79.057 + 2.0) * 100% = 97.53%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using transformer efficiency optimization formulas (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2). 1. **Calculate Optimal Loading Fraction ($x_{\\text{max }\\eta}$):** $$x_{\\text{max }\\eta} = \\sqrt{\\frac{P_{\\text{core}}}{P_{cu,\\text{fl}}}} = \\sqrt{\\frac{1000\\text{ W}}{1600\\text{ W}}} = \\sqrt{0.625} = \\mathbf{0.79057 \\approx 0.791\\text{ (or } 79.1\\%\\text{ of rated load)}}$$ 2. **Calculate Optimal Output Power ($P_{\\text{out}}$ at $\\cos\\theta = 1.0$):** $$P_{\\text{out}} = x \\times S_{\\text{rated}} \\times \\cos\\theta = 0.79057 \\times 100\\text{ kVA} \\times 1.0 = \\mathbf{79.057\\text{ kW}}$$ 3. **Calculate Total Losses at Maximum Efficiency Point:** - At maximum efficiency, variable copper losses strictly equal constant core losses: $$P_{cu} = x^2 P_{cu,\\text{fl}} = (0.79057)^2 \\times 1600\\text{ W} = (0.625) \\times 1600\\text{ W} = 1000\\text{ W} = P_{\\text{core}}$$ - Total Loss: $$P_{\\text{loss}} = P_{\\text{core}} + P_{cu} = 1000\\text{ W} + 1000\\text{ W} = 2000\\text{ W} = \\mathbf{2.000\\text{ kW}}$$ 4. **Calculate Maximum Efficiency ($\\eta_{\\text{max}}$):** $$\\eta_{\\text{max}} = \\frac{P_{\\text{out}}}{P_{\\text{out}} + P_{\\text{loss}}} \\times 100\\% = \\frac{79.057\\text{ kW}}{79.057\\text{ kW} + 2.000\\text{ kW}} \\times 100\\% = \\frac{79.057}{81.057} \\times 100\\% = \\mathbf{97.5328\\% \\approx 97.53\\%}$$ Flawless transformer efficiency maximization!" },
        { "text": "x = 1.000 (100% load) and \u03b7_max = 97.47%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "x = 0.625 (62.5% load) and \u03b7_max = 96.88%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "x = 0.791 and \u03b7_max = 95.20%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
