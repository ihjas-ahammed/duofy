# Duofy Reusable Lesson Format: Steel Microstructures (Hypo/Hypereutectoid & Proeutectoid Phases)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Metallurgy_and_Phase_Diagrams / Iron_Carbon_Phase_Diagram`  
**Lesson Format Type:** `hypo_hypereutectoid_steels_and_proeutectoid_microstructures`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the microstructural evolution of steels cooled slowly under equilibrium conditions, the distinction between **Hypoeutectoid Steels ($C_0 < 0.76\text{ wt}\%\text{ C}$)** and **Hypereutectoid Steels ($C_0 > 0.76\text{ wt}\%\text{ C}$)**, the nucleation and growth of **Proeutectoid $\alpha$-Ferrite ($\alpha'$)** along prior austenite grain boundaries when crossing $A_3$, the nucleation of brittle **Proeutectoid Cementite ($\text{Fe}_3\text{C}'$)** when crossing $A_{\text{cm}}$, the subsequent isothermal transformation of remaining austenite into **Eutectoid Pearlite** at $A_1 = 727^\circ\text{C}$, and quantitative calculation of microconstituent mass fractions (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapter 9; Donald R. Askeland *The Science and Engineering of Materials* 7th ed. Chapter 10): formulate the **Hypoeutectoid Microconstituent Master Formulations ($C_0 < 0.76\text{ wt}\%\text{ C}$)**:
$$\mathbf{W_{\alpha'} = \frac{0.76 - C_0}{0.76 - 0.022} = \frac{0.76 - C_0}{0.738} \quad \Big| \quad \mathbf{W_{\text{pearlite}} = \frac{C_0 - 0.022}{0.76 - 0.022} = \frac{C_0 - 0.022}{0.738}}}$$
where:
1. **$W_{\alpha'}$:** Mass fraction of primary proeutectoid $\alpha$-ferrite microconstituent;
2. **$W_{\text{pearlite}}$:** Mass fraction of eutectoid pearlite microconstituent;
3. **$W_{\alpha'} + W_{\text{pearlite}} = 1.000$;**
formulate the **Hypereutectoid Microconstituent Master Formulations ($0.76 < C_0 < 2.14\text{ wt}\%\text{ C}$)**:
$$\mathbf{W_{\text{Fe}_3\text{C}'} = \frac{C_0 - 0.76}{6.70 - 0.76} = \frac{C_0 - 0.76}{5.94} \quad \Big| \quad \mathbf{W_{\text{pearlite}} = \frac{6.70 - C_0}{6.70 - 0.76} = \frac{6.70 - C_0}{5.94}}}$$
where:
1. **$W_{\text{Fe}_3\text{C}'}$:** Mass fraction of continuous proeutectoid cementite grain boundary network;
2. **$W_{\text{pearlite}}$:** Mass fraction of pearlite colonies;
(proving that total phase fractions $W_{\alpha,\text{total}}, W_{\text{Fe}_3\text{C},\text{total}}$ differ fundamentally from microconstituent fractions $W_{\alpha'}, W_{\text{pearlite}}$ because pearlite itself contains $89\%\text{ }\alpha$ and $11\%\text{ Fe}_3\text{C}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hypo vs Hypereutectoid Steels, Proeutectoid Phases ($\alpha'$ vs $\text{Fe}_3\text{C}'$) & Pearlite Colony Fractions Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Proeutectoid Ferrite and Total Pearlite Microconstituent Fractions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Steel Microconstituent / Critical Temperature Line & Technical Metallurgical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Hypoeutectoid Steel ($C_0 < 0.76\text{ wt}\%\text{ C}$), the Phase That Forms Above the 727°C Eutectoid Temperature Along Prior Austenite Grain Boundaries Is Termed ___-Eutectoid Ferrite (Pro / Proeutectoid) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Physical Metallurgy Problem: Computing Proeutectoid Ferrite and Pearlite Microconstituent Fractions in 1030 Steel Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hypo/Hypereutectoid Steel Metallurgy (Callister 2020; Askeland 2016):
   - **Microconstituent Formulations:**
     $$\mathbf{W_{\alpha'} = \frac{0.76 - C_0}{0.738} \quad \Big| \quad W_{\text{pearlite}} = \frac{C_0 - 0.022}{0.738} \quad \Big| \quad W_{\text{Fe}_3\text{C}'} = \frac{C_0 - 0.76}{5.94} \quad \Big| \quad W_\alpha = W_{\alpha'} + W_{\alpha,\text{pearlite}}}$$
   - **Steel Classification Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Steel Alloy Class} & \textbf{Carbon Range } C_0 & \textbf{Proeutectoid Phase} & \textbf{Final Equilibrium Microstructure} \\
     \hline
     \mathbf{\text{Hypoeutectoid Steel}} & \mathbf{0.022 - 0.76\text{ wt}\%\text{ C}} & \mathbf{\text{Proeutectoid }\alpha\text{-Ferrite (\alpha')}} & \mathbf{\text{Proeutectoid }\alpha + \text{Pearlite Colonies}} \\
     \mathbf{\text{Eutectoid Steel}} & \mathbf{0.76\text{ wt}\%\text{ C}} & \text{None (Direct congruent transformation)} & \mathbf{100\%\text{ Pearlite Lamellae}} \\
     \mathbf{\text{Hypereutectoid Steel}} & \mathbf{0.76 - 2.14\text{ wt}\%\text{ C}} & \mathbf{\text{Proeutectoid Cementite (Fe}_3\text{C}')} & \mathbf{\text{Grain Boundary Cementite Network} + \text{Pearlite}} \\
     \text{Cast Iron} & > 2.14\text{ wt}\%\text{ C} & \text{Eutectic Ledeburite / Graphite} & Flake/nodular graphite in pearlite/ferrite \\
     \hline
     \end{array}$$
   - **The Microconstituent vs Phase Invariant:** Microconstituent fraction $W_{\text{pearlite}} = \frac{C_0 - 0.022}{0.738}$ represents the **volume of the laminated composite colonies**, which contains both eutectoid $\alpha$ ($89\%$) and eutectoid $\text{Fe}_3\text{C}$ ($11\%$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of microconstituent calculation: (1) check if steel is hypoeutectoid ($C_0 < 0.76\%\text{ C}$) or hypereutectoid ($C_0 > 0.76\%\text{ C}$), (2) construct tie-line from $0.022\text{ wt}\%\text{ C}$ to $0.76\text{ wt}\%\text{ C}$ at temperature just above $727^\circ\text{C}$ ($A_1$), (3) calculate proeutectoid ferrite fraction: $W_{\alpha'} = (0.76 - C_0) / (0.76 - 0.022)$, (4) calculate eutectoid pearlite fraction: $W_{\text{pearlite}} = (C_0 - 0.022) / (0.76 - 0.022)$, (5) verify $W_{\alpha'} + W_{\text{pearlite}} = 1.000$ and check consistency against total phase fractions!
3. **Slide 3 (`matching`):** Pair 4 concepts (Hypoeutectoid Steel, Proeutectoid Cementite Network, $A_3$ Temperature Line, $A_{\text{cm}}$ Temperature Line) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pro (or Proeutectoid). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating proeutectoid and pearlite fractions for AISI 1030 steel: An AISI 1030 hypoeutectoid steel ($C_0 = 0.30\text{ wt}\%\text{ C}$) is cooled slowly across the eutectoid temperature ($A_1 = 727^\circ\text{C}$). The tie-line length between ferrite ($0.022\%\text{ C}$) and eutectoid austenite ($0.76\%\text{ C}$) is $0.76 - 0.022 = \mathbf{0.738}$.
   - Proeutectoid ferrite microconstituent fraction:
     $W_{\alpha'} = \frac{0.76 - 0.30}{0.738} = \frac{0.460}{0.738} = \mathbf{0.6233 = 62.33\% \approx 62.3\%}$;
   - Pearlite microconstituent fraction:
     $W_{\text{pearlite}} = \frac{0.30 - 0.022}{0.738} = \frac{0.278}{0.738} = \mathbf{0.3767 = 37.67\% \approx 37.7\%}$;
   - Check: $W_{\alpha'} + W_{\text{pearlite}} = 0.6233 + 0.3767 = 1.0000$;
   - What are the microconstituent mass fractions of proeutectoid ferrite $W_{\alpha'}$ and pearlite $W_{\text{pearlite}}$? ($W_{\alpha'} = \mathbf{62.3\%}$ and $W_{\text{pearlite}} = \mathbf{37.7\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hypo_hypereutectoid_steels_and_proeutectoid_microstructures",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hypoeutectoid \\& Hypereutectoid Steel Microstructures (Callister)**\n• **Hypoeutectoid Microconstituent Fractions ($C_0 < 0.76\\text{ wt}\\%\\text{ C}$):**\n$$\n\\mathbf{W_{\\alpha'} = \\frac{0.76 - C_0}{0.76 - 0.022} = \\frac{0.76 - C_0}{0.738}} \\quad \\Big| \\quad \\mathbf{W_{\\text{pearlite}} = \\frac{C_0 - 0.022}{0.76 - 0.022} = \\frac{C_0 - 0.022}{0.738}}\n$$\n  - **$W_{\\alpha'}$:** Primary proeutectoid $\\alpha$-ferrite forming along austenite grain boundaries above $727^\\circ\\text{C}$;\n  - **$W_{\\text{pearlite}}$:** Eutectoid lamellar pearlite colonies formed at $727^\\circ\\text{C}$;\n• **Hypereutectoid Microconstituent Fractions ($0.76 < C_0 < 2.14\\text{ wt}\\%\\text{ C}$):**\n$$\n\\mathbf{W_{\\text{Fe}_3\\text{C}'} = \\frac{C_0 - 0.76}{6.70 - 0.76} = \\frac{C_0 - 0.76}{5.94}} \\quad \\Big| \\quad \\mathbf{W_{\\text{pearlite}} = \\frac{6.70 - C_0}{5.94}}\n$$\n• **The Microconstituent Invariant:** Microconstituent fraction $W_{\\text{pearlite}}$ represents the **total mass fraction of laminated colonies**, whereas total ferrite phase $W_\\alpha = W_{\\alpha'} + W_{\\alpha,\\text{pearlite}}$ accounts for both proeutectoid and eutectoid ferrite crystals!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the proeutectoid and pearlite microconstituent fractions for a hypoeutectoid steel.",
      "orderItems": [
        "Confirm that the nominal alloy composition is hypoeutectoid: C0 < 0.76 wt% C",
        "Construct a horizontal tie-line between ferrite (C_\u03b1 = 0.022 wt% C) and eutectoid austenite (C_\u03b3 = 0.76 wt% C) just above 727\u00b0C",
        "Calculate the proeutectoid tie-line span: L = 0.76 - 0.022 = 0.738 wt% C",
        "Apply the lever rule to calculate the proeutectoid ferrite microconstituent fraction: W_\u03b1' = (0.76 - C0) / 0.738",
        "Calculate the eutectoid pearlite fraction: W_pearlite = (C0 - 0.022) / 0.738 and verify W_\u03b1' + W_pearlite = 1.0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Steel Microstructure Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Proeutectoid Ferrite (\u03b1')", "right": "Primary \u03b1 phase nucleating along prior austenite grain boundaries between A3 and 727\u00b0C in hypoeutectoid steels" },
        { "left": "Proeutectoid Cementite (Fe3C')", "right": "Brittle grain-boundary intermetallic network precipitating between A_cm and 727\u00b0C in hypereutectoid steels" },
        { "left": "A3 Temperature Line", "right": "Upper critical temperature boundary marking the onset of \u03b1-ferrite precipitation from homogeneous austenite" },
        { "left": "A1 Temperature Line (727\u00b0C)", "right": "Lower critical temperature line where all remaining austenite undergoes invariant eutectoid transformation" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a hypoeutectoid steel (C0 < 0.76 wt% C), the phase that forms above the 727\u00b0C eutectoid temperature along prior austenite grain boundaries is termed ___-eutectoid ferrite.",
      "blankAnswer": "pro",
      "blankDistractors": ["post", "anti", "hyper"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An AISI 1030 hypoeutectoid plain carbon steel (C0 = 0.30 wt% C) is slowly cooled to room temperature. Tie-line bounds are C_\u03b1 = 0.022 wt% C and C_\u03b3 = 0.76 wt% C (span = 0.76 - 0.022 = 0.738). W_\u03b1' = (0.76 - 0.30) / 0.738 = 0.460 / 0.738 = 0.6233. W_pearlite = (0.30 - 0.022) / 0.738 = 0.278 / 0.738 = 0.3767. What are the microconstituent mass fractions of proeutectoid ferrite W_\u03b1' and pearlite W_pearlite?",
      "options": [
        { "text": "W_\u03b1' = 62.3% and W_pearlite = 37.7% (W_\u03b1' = 0.460 / 0.738 = 62.33% \u2248 62.3%; W_pearlite = 0.278 / 0.738 = 37.67% \u2248 37.7%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the microconstituent lever rule for hypoeutectoid steels (William D. Callister Jr. *Materials Science and Engineering: An Introduction* Chapter 9; Donald R. Askeland *The Science and Engineering of Materials* Chapter 10). 1. **Identify Alloy Class \\& Critical Compositions:** - Nominal carbon composition: $C_0 = 0.30\\text{ wt}\\%\\text{ C}$. - Since $C_0 = 0.30\\% < 0.76\\%$, the steel is **hypoeutectoid**. - Ferrite solubility limit: $C_\\alpha = 0.022\\text{ wt}\\%\\text{ C}$. - Eutectoid austenite composition: $C_\\gamma = 0.76\\text{ wt}\\%\\text{ C}$. 2. **Calculate Proeutectoid Tie-Line Span:** $$L_{\\text{hypo}} = C_\\gamma - C_\\alpha = 0.76 - 0.022 = \\mathbf{0.738\\text{ wt}\\%\\text{ C}}$$ 3. **Calculate Proeutectoid Ferrite Microconstituent Fraction ($W_{\\alpha'}$):** $$W_{\\alpha'} = \\frac{C_\\gamma - C_0}{C_\\gamma - C_\\alpha} = \\frac{0.76 - 0.30}{0.738} = \\frac{0.460}{0.738} = \\mathbf{0.62331 = 62.33\\% \\approx 62.3\\%}$$ 4. **Calculate Eutectoid Pearlite Microconstituent Fraction ($W_{\\text{pearlite}}$):** $$W_{\\text{pearlite}} = \\frac{C_0 - C_\\alpha}{C_\\gamma - C_\\alpha} = \\frac{0.30 - 0.022}{0.738} = \\frac{0.278}{0.738} = \\mathbf{0.37669 = 37.67\\% \\approx 37.7\\%}$$ - Verify microconstituent summation: $$W_{\\alpha'} + W_{\\text{pearlite}} = 0.62331 + 0.37669 = \\mathbf{1.00000 = 100.0\\%}$$ Flawless proeutectoid ferrite and pearlite microconstituent derivation!" },
        { "text": "W_\u03b1' = 37.7% and W_pearlite = 62.3% (Inverted the proeutectoid lever arm)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_\u03b1' = 93.6% and W_pearlite = 6.4% (Calculated total phase fractions instead of microconstituents)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_\u03b1' = 50.0% and W_pearlite = 50.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
