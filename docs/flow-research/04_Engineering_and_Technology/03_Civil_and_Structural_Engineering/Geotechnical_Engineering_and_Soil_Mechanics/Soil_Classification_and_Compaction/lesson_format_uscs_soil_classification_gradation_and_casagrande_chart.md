# Duofy Reusable Lesson Format: USCS Classification (Gradation & Casagrande Chart)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Soil_Classification_and_Compaction`  
**Lesson Format Type:** `uscs_soil_classification_gradation_and_casagrande_chart`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Unified Soil Classification System (USCS ASTM D2487), sieve analysis grain-size distribution curves, effective size ($D_{10}$), uniformity coefficient ($C_u = D_{60}/D_{10}$), coefficient of curvature ($C_c = D_{30}^2 / (D_{60} D_{10})$), coarse-grained criteria for Gravels ($GW, GP, GM, GC$) vs Sands ($SW, SP, SM, SC$), Atterberg liquid limit ($LL$), plastic limit ($PL$), Plasticity Index ($PI = LL - PL$), and Arthur Casagrande's **Plasticity Chart A-Line Equation ($PI = 0.73(LL - 20)$)** separating inorganic clays from silts (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapters 2, 4, 5; ASTM D2487): formulate the **Gradation Shape Coefficients**:
$$\mathbf{C_u = \frac{D_{60}}{D_{10}} \quad \Big| \quad \mathbf{C_c = \frac{D_{30}^2}{D_{60} \cdot D_{10}}}}$$
$$\mathbf{\text{Well-Graded Gravel } (GW): \ C_u \ge 4.0 \quad \text{and} \quad 1.0 \le C_c \le 3.0}$$
$$\mathbf{\text{Well-Graded Sand } (SW): \ C_u \ge 6.0 \quad \text{and} \quad 1.0 \le C_c \le 3.0}$$
derive the **Casagrande Plasticity Chart A-Line & U-Line Equations**:
$$\mathbf{PI_{\text{A-Line}} = 0.73 \left( LL - 20 \right) \quad \Big| \quad PI_{\text{U-Line}} = 0.90 \left( LL - 8 \right) \quad (\text{Upper empirical limit})}$$
$$\mathbf{LL < 50 \implies \text{Low Plasticity } (L) \quad \Big| \quad LL \ge 50 \implies \text{High Plasticity } (H)}$$
$$\mathbf{\text{Above A-Line } (PI > PI_{\text{A-Line}}): \mathbf{\text{Inorganic Clay } (CL \text{ or } CH)} \quad \Big| \quad \text{Below A-Line } (PI < PI_{\text{A-Line}}): \mathbf{\text{Inorganic Silt } (ML \text{ or } MH)}}$$
(proving that mechanical behavior is dictated by particle interlock in coarse soils and electro-chemical diffuse double-layer plasticity in fine soils).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gradation ($C_u, C_c$), $SW/GW$ Rules & Casagrande A-Line ($PI = 0.73(LL - 20)$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Classify a Soil Sample Using USCS Sieve and Atterberg Data Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | USCS Two-Letter Group Symbol / Parameter & Technical Geotechnical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | On the Casagrande Plasticity Chart, Fine-Grained Soils Plotting Above the A-Line ($PI = 0.73(LL - 20)$) Are Classified as ___ (Clays / Inorganic Clays) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Geotechnical Problem: Classifying a Clay Sample with LL = 55% and PL = 22% on the Casagrande Chart Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State USCS Classification & Casagrande Chart (Das 2018; ASTM D2487):
   - **Gradation & Plasticity Formulations:**
     $$\mathbf{C_u = \frac{D_{60}}{D_{10}} \quad \Big| \quad C_c = \frac{D_{30}^2}{D_{60} D_{10}} \quad \Big| \quad PI = LL - PL \quad \Big| \quad PI_{\text{A-Line}} = 0.73(LL - 20)}$$
   - **Fine-Grained Classification Matrix (Casagrande Chart):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Position on Chart} & \textbf{Liquid Limit } LL & \textbf{Group Symbol} & \textbf{Soil Description} \\
     \hline
     \mathbf{\text{Above A-Line}} & LL < 50\% & \mathbf{CL} & \mathbf{\text{Lean / Low-Plasticity Inorganic Clay}} \\
     \mathbf{\text{Above A-Line}} & \mathbf{LL \ge 50\%} & \mathbf{CH} & \mathbf{\text{Fat / High-Plasticity Inorganic Clay}} \\
     \mathbf{\text{Below A-Line}} & LL < 50\% & \mathbf{ML} & \mathbf{\text{Low-Plasticity Inorganic Silt}} \\
     \mathbf{\text{Below A-Line}} & \mathbf{LL \ge 50\%} & \mathbf{MH} & \mathbf{\text{Elastic / High-Plasticity Silt}} \\
     \hline
     \end{array}$$
   - **The Dual Symbol Invariant:** Soils with $4 \le PI \le 7$ and plotting in the hatched zone near the A-Line receive the **dual classification $CL-ML$ (Silty Clay)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of USCS classification: (1) determine % passing No. 200 sieve ($0.075\text{ mm}$); if $< 50\% \implies$ Coarse-Grained, if $\ge 50\% \implies$ Fine-Grained, (2) for coarse soils, evaluate % gravel retained on No. 4 sieve ($4.75\text{ mm}$) to choose Gravel ($G$) vs Sand ($S$), (3) compute gradation coefficients $C_u = D_{60}/D_{10}$ and $C_c = D_{30}^2/(D_{60} D_{10})$ to check for Well-Graded ($W$) vs Poorly-Graded ($P$), (4) for fine soils, calculate Plasticity Index $PI = LL - PL$, (5) calculate A-Line threshold $PI_{\text{A-Line}} = 0.73(LL - 20)$ and classify as $CL, CH, ML,$ or $MH$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Uniformity Coefficient $C_u$, Coefficient of Curvature $C_c$, Casagrande A-Line, Liquid Limit Threshold $LL = 50\%$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Clays (or Inorganic Clays). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on classifying fine soil: A fine-grained soil has $75\%$ passing the No. 200 sieve. Laboratory Atterberg tests yield Liquid Limit $LL = 55\%$ and Plastic Limit $PL = 22\%$. What is the Plasticity Index $PI$, the A-Line value, and the exact USCS classification group symbol? ($PI = LL - PL = 55\% - 22\% = \mathbf{33\%}$; $PI_{\text{A-Line}} = 0.73(LL - 20) = 0.73(55 - 20) = 0.73(35) = \mathbf{25.55\%}$; Since $PI = 33\% > 25.55\%$ (plots above the A-Line) and $LL = 55\% \ge 50\%$ (high plasticity), the soil is classified as **$\mathbf{CH}$ (High-Plasticity Fat Clay)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "uscs_soil_classification_gradation_and_casagrande_chart",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: USCS Classification \\& Casagrande Plasticity (Arthur Casagrande)**\n• **Gradation Shape Coefficients (Coarse Soils):**\n$$\n\\mathbf{C_u = \\frac{D_{60}}{D_{10}} \\quad \\Big| \\quad \\mathbf{C_c = \\frac{D_{30}^2}{D_{60} \\cdot D_{10}}}}\n$$\n  - **Well-Graded Sand ($SW$):** $C_u \\ge 6.0$ and $1.0 \\le C_c \\le 3.0$;\n  - **Well-Graded Gravel ($GW$):** $C_u \\ge 4.0$ and $1.0 \\le C_c \\le 3.0$;\n• **Casagrande Plasticity Chart A-Line (Fine Soils):**\n$$\n\\mathbf{PI = LL - PL \\quad \\Big| \\quad \\mathbf{PI_{\\text{A-Line}} = 0.73 \\left( LL - 20 \\right)}}\n$$\n  - **Above A-Line ($PI > PI_{\\text{A-Line}}$):** Inorganic Clay ($\\mathbf{CL}$ if $LL < 50$, $\\mathbf{CH}$ if $LL \\ge 50$);\n  - **Below A-Line ($PI < PI_{\\text{A-Line}}$):** Inorganic Silt ($\\mathbf{ML}$ if $LL < 50$, $\\mathbf{MH}$ if $LL \\ge 50$);\n• **The Plasticity Invariant:** The A-Line empirically separates cohesive clay minerals from non-cohesive silts; soils with $LL \\ge 50\\%$ exhibit **high compressibility and swelling potential**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to classify an unknown soil sample per the Unified Soil Classification System (USCS ASTM D2487).",
      "orderItems": [
        "Determine the percentage of soil passing the No. 200 sieve (0.075 mm) to separate coarse-grained (< 50%) from fine-grained (\u2265 50%)",
        "For coarse soils, evaluate the coarse fraction passing the No. 4 sieve (4.75 mm) to identify Gravel (G) versus Sand (S)",
        "Calculate the gradation parameters: Cu = D60/D10 and Cc = D30^2 / (D60*D10) to designate Well-Graded (W) or Poorly-Graded (P)",
        "For fine-grained soils, perform Atterberg limit tests to calculate the Plasticity Index: PI = LL - PL",
        "Plot the coordinates (LL, PI) on the Casagrande Plasticity Chart relative to the A-Line: PI = 0.73*(LL - 20) to assign group symbol (CL, CH, ML, MH)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each USCS Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Uniformity Coefficient (Cu)", "right": "Cu = D60 / D10, measuring the particle size range spread across the grain distribution curve" },
        { "left": "Coefficient of Curvature (Cc)", "right": "Cc = D30^2 / (D60*D10), evaluating the shape smoothness between D60 and D10 (1 \u2264 Cc \u2264 3 for well-graded)" },
        { "left": "Casagrande A-Line", "right": "PI = 0.73*(LL - 20), empirical boundary line separating inorganic clays from inorganic silts" },
        { "left": "High Plasticity Limit (LL \u2265 50%)", "right": "Threshold designating high compressibility fat clays (CH) and elastic silts (MH)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "On the Casagrande Plasticity Chart, fine-grained soils plotting above the A-Line equation PI = 0.73*(LL - 20) are classified as ___.",
      "blankAnswer": "clays",
      "blankDistractors": ["silts", "gravels", "peats"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A fine-grained soil (75% passing No. 200 sieve) has Liquid Limit LL = 55% and Plastic Limit PL = 22%. What is the Plasticity Index PI, the A-Line threshold value, and the exact USCS classification group symbol?",
      "options": [
        { "text": "PI = 33%, PI_A-Line = 25.55%, and Group Symbol = CH (Fat Clay) (PI = 55 - 22 = 33%; PI_A-Line = 0.73 * (55 - 20) = 0.73 * 35 = 25.55%; since PI = 33% > 25.55% (above A-Line) and LL = 55% \u2265 50% (high plasticity), the soil is CH)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Unified Soil Classification System and Casagrande Plasticity Chart (Braja M. Das *Principles of Geotechnical Engineering* Chapter 5; ASTM D2487). 1. **Determine Primary Soil Fraction:** - $\%$ passing No. 200 sieve ($0.075\\text{ mm}$) $= 75\\% \\ge 50\\%$. - Therefore, the soil is **Fine-Grained**! 2. **Calculate Plasticity Index ($PI$):** $$PI = LL - PL = 55\\% - 22\\% = \\mathbf{33.0\\%}$$ 3. **Calculate the Casagrande A-Line Threshold Value:** $$PI_{\\text{A-Line}} = 0.73 \\times (LL - 20) = 0.73 \\times (55 - 20) = 0.73 \\times 35 = \\mathbf{25.55\\%}$$ 4. **Evaluate Position on Plasticity Chart:** - Compare actual $PI$ to $PI_{\\text{A-Line}}$: $$PI = 33.0\\% > PI_{\\text{A-Line}} = 25.55\\%$$ - Because $PI$ plots **strictly ABOVE the A-Line**, the soil behaves as an **Inorganic Clay ($C$)**. 5. **Evaluate Plasticity / Compressibility Level:** - Check Liquid Limit: $$LL = 55\\% \\ge 50\\%$$ - Because $LL \\ge 50\\%$, the soil is of **High Plasticity / High Compressibility ($H$)**. 6. **Combine Letter Symbols:** - Prefix: $C$ (Clay); Suffix: $H$ (High Plasticity). - **Final USCS Classification Group Symbol:** **$\mathbf{CH}$ (Inorganic Fat Clay)**! Flawless geotechnical soil classification!" },
        { "text": "PI = 33%, PI_A-Line = 25.55%, and Group Symbol = MH (Elastic Silt)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "PI = 33%, PI_A-Line = 25.55%, and Group Symbol = CL (Lean Clay)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "PI = 77%, PI_A-Line = 40.15%, and Group Symbol = CH", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
