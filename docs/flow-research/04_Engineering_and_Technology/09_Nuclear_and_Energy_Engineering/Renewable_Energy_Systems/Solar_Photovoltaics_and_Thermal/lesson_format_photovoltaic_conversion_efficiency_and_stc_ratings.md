# Duofy Reusable Lesson Format: Solar PV Efficiency (STC Rating & Energy Yield)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Renewable_Energy_Systems / Solar_Photovoltaics_and_Thermal`  
**Lesson Format Type:** `photovoltaic_conversion_efficiency_and_stc_ratings`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the power conversion efficiency of photovoltaic solar modules under international **Standard Test Conditions (STC: Irradiance $G = 1000\text{ W/m}^2$, Cell Temperature $T_{\text{cell}} = 25^\circ\text{C}$, Solar Spectrum Air Mass $AM = 1.5G$)**, calculation of module aperture area ($A_c$), input solar radiant power ($P_{\text{in}} = G \cdot A_c$), electrical power conversion efficiency ($\eta_{\text{pv}} = \frac{P_{\text{mp}}}{P_{\text{in}}} \times 100\%$), Nominal Module Operating Temperature (NMOT / NOCT), cell temperature thermal derating ($\gamma_{P_{\text{mp}}} \approx -0.35\%/^\circ\text{C}$), and daily energy yield ($E_{\text{daily}} = P_{\text{stc}} \cdot \text{PSH} \cdot \text{PR}$) (John A. Duffie, William A. Beckman *Solar Engineering of Thermal Processes, Photovoltaics and Wind* 5th ed. Chapter 23; Martin A. Green *Solar Cells* Chapter 5): formulate the **Photovoltaic Conversion Efficiency Master Formulation at STC**:
$$\mathbf{\eta_{\text{pv}} = \frac{P_{\text{mp}}}{P_{\text{in}}} \times 100\% = \frac{P_{\text{mp}}}{G \cdot A_c} \times 100\% = \frac{V_{\text{oc}} \cdot I_{\text{sc}} \cdot FF}{G \cdot A_c} \times 100\%}$$
where:
1. **$P_{\text{mp}}$:** Peak electrical power output at STC ($\text{Watts}$);
2. **$G$:** Incident solar irradiance ($1000\text{ W/m}^2$ at STC);
3. **$A_c$:** Gross frontal surface area of the PV module in square meters ($\text{m}^2$);
4. **$P_{\text{in}} = G \cdot A_c$:** Total incident solar radiant flux hitting the module ($\text{Watts}$);
derive the **Temperature-Derated Operating Power Equation ($P_{\text{actual}}$)**:
$$\mathbf{P_{\text{actual}} = P_{\text{stc}} \cdot \left[ 1 + \gamma \cdot \left( T_{\text{cell}} - 25^\circ\text{C} \right) \right] \quad (\gamma \approx -0.0035\text{ to } -0.0040\text{ /}^\circ\text{C})}$$
master the **Commercial Photovoltaic Technology Comparison Matrix**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{PV Technology} & \textbf{Commercial Module Efficiency } \eta_{\text{pv}} & \textbf{Temp Coeff } \gamma & \textbf{Primary Market Application} \\
\hline
\mathbf{\text{Monocrystalline Silicon (Mono-Si)}} & \mathbf{20.0\% - 23.5\%} & \mathbf{-0.35\%/^\circ\text{C}} & \mathbf{\text{High-efficiency residential \& commercial rooftops}} \\
\text{Polycrystalline Silicon (Poly-Si)} & 16.5\% - 18.5\% & -0.40\%/^\circ\text{C} & Utility-scale solar ground mounts \\
\mathbf{\text{TOPCon / HJT (Heterojunction)}} & \mathbf{22.5\% - 25.0\%} & \mathbf{-0.26\%/^\circ\text{C}} & \mathbf{\text{Next-gen premium high-temperature solar panels}} \\
\text{Cadmium Telluride (CdTe Thin-Film)} & 17.0\% - 19.0\% & -0.28\%/^\circ\text{C} & Hot desert utility-scale solar farms \\
\text{Perovskite-Silicon Tandem (Lab/Pilot)} & 28.0\% - 33.5\% & -0.20\%/^\circ\text{C} & Ultra-high efficiency tandem modules \\
\hline
\end{array}$$
(proving that multiplying module area by standard $1000\text{ W/m}^2$ irradiance establishes the denominator for rating peak wattage and efficiency in international solar certifications).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Standard Test Conditions (STC: $1000\text{ W/m}^2, 25^\circ\text{C}, AM1.5$), $\eta_{\text{pv}} = \frac{P_{\text{mp}}}{G \cdot A_c}$ & Temperature Derating Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Module Area, Incident Solar Power, STC Efficiency, and Derated Hot Power Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Solar PV Rating Construct / Testing Condition & Technical Energy Engineering Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The International Testing Standard Defining Solar PV Module Nameplate Ratings at $1000\text{ W/m}^2$ Irradiance, $25^\circ\text{C}$ Cell Temperature, and $AM1.5$ Spectrum Is Abbreviated as ___ (STC / Standard Test Conditions) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Renewable Energy Problem: Computing Module Area, Incident Solar Flux, and STC Efficiency for a 400 W Panel Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Solar PV STC Efficiency & Temperature Derating Mechanics (Duffie & Beckman 2020):
   - **Efficiency Formulations:**
     $$\mathbf{\eta_{\text{pv}} = \frac{P_{\text{mp}}}{G \cdot A_c} \times 100\% \quad \Big| \quad P_{\text{in}} = G \cdot A_c \quad \Big| \quad P(T) = P_{\text{stc}} [1 + \gamma (T_{\text{cell}} - 25)]}$$
   - **The STC Standard Definition Invariant:**
     - Solar Irradiance: $G = 1000\text{ W/m}^2$ ($1\text{ Sun}$);
     - Cell Junction Temperature: $T_{\text{cell}} = 25^\circ\text{C}$;
     - Spectral Distribution: Air Mass $AM = 1.5G$ (global tilted solar spectrum)!
2. **Slide 2 (`ordering`):** Provide 5 steps of PV module efficiency calculation: (1) measure module physical dimensions to calculate frontal surface aperture area $A_c = \text{length} \times \text{width}$, (2) calculate total incident solar radiant power at STC: $P_{\text{in}} = 1000\text{ W/m}^2 \times A_c$, (3) measure peak electrical output at maximum power point: $P_{\text{mp}}$, (4) evaluate STC conversion efficiency: $\eta_{\text{pv}} = (P_{\text{mp}} / P_{\text{in}}) \times 100\%$, (5) apply negative temperature coefficient $\gamma$ to compute real-world operating power at field rooftop cell temperature ($T_{\text{cell}} \approx 55^\circ\text{C}$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Standard Test Conditions STC, Air Mass 1.5 Spectrum, Temperature Coefficient $\gamma$, Module Aperture Area $A_c$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of STC (or Standard Test Conditions). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating solar module area and STC efficiency: A high-efficiency monocrystalline PV module has physical dimensions of $2.000\text{ m}$ length by $1.000\text{ m}$ width ($A_c = 2.000 \times 1.000 = \mathbf{2.000\text{ m}^2}$). At STC ($G = 1000\text{ W/m}^2$), its nameplate peak power output is $P_{\text{mp}} = 430.0\text{ W}$.
   - Incident solar power:
     $P_{\text{in}} = G \cdot A_c = 1000.0\text{ W/m}^2 \times 2.000\text{ m}^2 = \mathbf{2000.0\text{ W}}$;
   - Photovoltaic conversion efficiency:
     $\eta_{\text{pv}} = \frac{P_{\text{mp}}}{P_{\text{in}}} \times 100\% = \frac{430.0\text{ W}}{2000.0\text{ W}} \times 100\% = \mathbf{0.2150 \times 100\% = 21.50\% \approx 21.5\%}$;
   - What are the total incident solar power $P_{\text{in}}$ and the STC module efficiency $\eta_{\text{pv}}$? ($P_{\text{in}} = \mathbf{2000\text{ W}}$ and $\eta_{\text{pv}} = \mathbf{21.5\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "photovoltaic_conversion_efficiency_and_stc_ratings",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Photovoltaic STC Efficiency \\& Ratings (Duffie \\& Beckman)**\n• **Photovoltaic Power Conversion Efficiency Master Formulation:**\n$$\n\\mathbf{\\eta_{\\text{pv}} = \\frac{P_{\\text{mp}}}{P_{\\text{in}}} \\times 100\\% = \\frac{P_{\\text{mp}}}{G \\cdot A_c} \\times 100\\% = \\frac{V_{\\text{oc}} \\cdot I_{\\text{sc}} \\cdot FF}{G \\cdot A_c} \\times 100\\%}\n$$\n  - **$P_{\\text{mp}}$:** Peak electrical power at Maximum Power Point ($\\text{Watts}$);\n  - **$G = 1000\\text{ W/m}^2$:** Incident solar irradiance under Standard Test Conditions (STC);\n  - **$A_c = L \\times W$:** Gross module frontal aperture area ($\\text{m}^2$);\n  - **$P_{\\text{in}} = G \\cdot A_c$:** Total incident solar radiant flux ($\\text{Watts}$);\n• **Thermal Power Derating Formulation:**\n$$\n\\mathbf{P_{\\text{actual}} = P_{\\text{stc}} \\cdot \\left[ 1 + \\gamma \\cdot \\left( T_{\\text{cell}} - 25^\\circ\\text{C} \\right) \\right] \\quad (\\gamma \\approx -0.35\\%/^\\circ\\text{C} \\text{ for Mono-Si})}\n$$\n• **The STC Triad Invariant:** Nameplate specifications ($P_{\\text{mp}}, \\eta_{\\text{pv}}$) are certified strictly at **$G = 1000\\text{ W/m}^2$, cell junction $T_{\\text{cell}} = 25^\\circ\\text{C}$, and $AM = 1.5G$ spectral distribution**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the incident solar radiant flux, STC conversion efficiency, and field operating power of a PV panel.",
      "orderItems": [
        "Multiply physical module length by width to compute total frontal aperture area: Ac = L * W (m^2)",
        "Calculate total incident solar radiant power under STC irradiance: Pin = 1000 W/m^2 * Ac",
        "Extract rated maximum electrical power output Pmp at the Maximum Power Point from flash-test I-V data",
        "Evaluate the photovoltaic conversion efficiency: \u03b7_pv = (Pmp / Pin) * 100%",
        "Apply the negative temperature coefficient \u03b3 to calculate real-world derated power under elevated operating temperatures"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Solar PV Rating Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Standard Test Conditions (STC)", "right": "Universal rating benchmark: G = 1000 W/m^2, Tcell = 25\u00b0C, and Air Mass AM = 1.5G solar spectrum" },
        { "left": "Module Conversion Efficiency (\u03b7pv)", "right": "Percentage of incident solar optical radiant energy converted directly into usable DC electrical power" },
        { "left": "Temperature Coefficient (\u03b3)", "right": "Rate of maximum power degradation per degree Celsius increase in cell temperature (typically -0.35%/K)" },
        { "left": "Peak Sun Hours (PSH)", "right": "Equivalent hours per day of 1000 W/m^2 standard solar irradiance used for sizing daily solar energy harvest" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The international testing standard defining solar PV module nameplate ratings at 1000 W/m^2 irradiance, 25\u00b0C cell temperature, and AM1.5 spectrum is abbreviated as ___.",
      "blankAnswer": "STC",
      "blankDistractors": ["NOCT", "NMOT", "MPP"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A monocrystalline solar module measures 2.000 m by 1.000 m (Ac = 2.000 m^2). Under STC irradiance (G = 1000 W/m^2), Pin = 1000 * 2.000 = 2000.0 W. The module produces peak maximum power Pmp = 430.0 W. \u03b7_pv = (430.0 / 2000.0) * 100% = 0.2150 * 100% = 21.50%. What are the incident solar power Pin and the module efficiency \u03b7_pv?",
      "options": [
        { "text": "Pin = 2000 W and \u03b7_pv = 21.5% (Pin = 1000 W/m^2 * 2.00 m^2 = 2000 W; \u03b7_pv = 430.0 W / 2000.0 W * 100% = 21.50%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the solar PV module efficiency formulations (John A. Duffie & William A. Beckman *Solar Engineering of Thermal Processes, Photovoltaics and Wind* Chapter 23). 1. **Calculate Gross Module Aperture Area ($A_c$):** - Module length: $L = 2.000\\text{ m}$. - Module width: $W = 1.000\\text{ m}$. $$A_c = L \\times W = 2.000\\text{ m} \\times 1.000\\text{ m} = \\mathbf{2.000\\text{ m}^2}$$ 2. **Calculate Incident Solar Radiant Power ($P_{\\text{in}}$ at STC):** - Standard Test Condition irradiance: $G = 1000.0\\text{ W/m}^2$. $$P_{\\text{in}} = G \\cdot A_c = 1000.0\\text{ W/m}^2 \\times 2.000\\text{ m}^2 = \\mathbf{2000.0\\text{ W} = 2000\\text{ W}}$$ 3. **Calculate Module Conversion Efficiency ($\\eta_{\\text{pv}}$):** - Peak nameplate electrical power: $P_{\\text{mp}} = 430.0\\text{ W}$. $$\\eta_{\\text{pv}} = \\frac{P_{\\text{mp}}}{P_{\\text{in}}} \\times 100\\% = \\frac{430.0\\text{ W}}{2000.0\\text{ W}} \\times 100\\% = 0.21500 \\times 100\\% = \\mathbf{21.50\\% \\approx 21.5\\%}$$ - This $21.5\\%$ efficiency represents modern commercial N-type monocrystalline silicon technology! Flawless solar PV STC efficiency derivation!" },
        { "text": "Pin = 1000 W and \u03b7_pv = 43.0% (Divided by unit area instead of total module area 2.0 m^2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pin = 2000 W and \u03b7_pv = 15.0%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pin = 430 W and \u03b7_pv = 100.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
