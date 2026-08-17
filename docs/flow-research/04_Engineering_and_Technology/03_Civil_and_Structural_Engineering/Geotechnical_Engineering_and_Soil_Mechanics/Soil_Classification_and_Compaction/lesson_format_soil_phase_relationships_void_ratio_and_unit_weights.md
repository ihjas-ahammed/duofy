# Duofy Reusable Lesson Format: Soil Phase Mechanics (Void Ratio, Saturation & Unit Weights)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Soil_Classification_and_Compaction`  
**Lesson Format Type:** `soil_phase_relationships_void_ratio_and_unit_weights`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the three-phase geotechnical soil model (solid soil grains, pore water, pore air), phase volumes and weights, the fundamental phase identity ($S \cdot e = w \cdot G_s$), porosity ($n = \frac{e}{1+e}$), dry unit weight ($\gamma_d$), saturated unit weight ($\gamma_{\text{sat}}$), moist total unit weight ($\gamma$), and submerged effective unit weight ($\gamma' = \gamma_{\text{sat}} - \gamma_w$) (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapter 3; Karl Terzaghi *Soil Mechanics in Engineering Practice* Chapter 1): formulate the **Master Soil Phase Identity**:
$$\mathbf{S \cdot e = w \cdot G_s}$$
where:
1. **$S$:** Degree of saturation ($0 \le S \le 1.0$ or $0\% \le S \le 100\%$);
2. **$e$:** Void ratio ($e = \frac{V_v}{V_s}$);
3. **$w$:** Moisture / water content ($w = \frac{W_w}{W_s}$);
4. **$G_s$:** Specific gravity of soil solids ($G_s = \frac{\rho_s}{\rho_w} \approx 2.65 - 2.75$ for mineral soils);
derive the **Unit Weight Formulations**:
$$\mathbf{\gamma = \frac{(G_s + S \cdot e) \cdot \gamma_w}{1 + e} \quad \Big| \quad \mathbf{\gamma_d = \frac{G_s \cdot \gamma_w}{1 + e} = \frac{\gamma}{1 + w}} \quad \Big| \quad \mathbf{\gamma_{\text{sat}} = \frac{(G_s + e) \cdot \gamma_w}{1 + e}} \quad \Big| \quad \mathbf{\gamma' = \frac{(G_s - 1) \cdot \gamma_w}{1 + e}}}$$
(proving that setting solid volume $V_s = 1.0$ allows all gravimetric and volumetric soil parameters to be solved through straightforward algebraic substitutions).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Phase Model ($S e = w G_s$), $\gamma_d = \frac{G_s \gamma_w}{1+e} = \frac{\gamma}{1+w}$, $\gamma_{\text{sat}}$ & $\gamma'$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Void Ratio, Saturated Unit Weight, and Dry Unit Weight Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Geotechnical Phase Parameter / Property & Technical Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Geotechnical Soil Mechanics, the Fundamental Invariant Relating Saturation S, Void Ratio e, Water Content w, and Specific Gravity Gs Is S * e = w * ___ (Gs / Specific Gravity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Soil Mechanics Problem: Calculating Void Ratio e, Dry Density \gamma_d, and Saturated Density \gamma_sat for a Silt Sample Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Soil Phase Mechanics (Das 2018; Terzaghi 1996):
   - **Phase Equations & Unit Weight Formulations:**
     $$\mathbf{S \cdot e = w \cdot G_s \quad \Big| \quad \gamma_d = \frac{G_s \gamma_w}{1 + e} = \frac{\gamma}{1 + w} \quad \Big| \quad \gamma_{\text{sat}} = \frac{(G_s + e)\gamma_w}{1 + e} \quad \Big| \quad \gamma' = \frac{(G_s - 1)\gamma_w}{1 + e} \quad \Big| \quad n = \frac{e}{1+e}}$$
   - **Phase State Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Soil State} & \textbf{Degree of Saturation } S & \textbf{Unit Weight Formula} & \textbf{Pore Space Composition} \\
     \hline
     \mathbf{\text{Completely Dry Soil}} & S = 0 & \mathbf{\gamma_d = \frac{G_s \gamma_w}{1 + e}} & \text{Pores contain 100\% air, 0\% water} \\
     \mathbf{\text{Partially Saturated Soil}} & 0 < S < 1.0 & \mathbf{\gamma = \frac{(G_s + S e)\gamma_w}{1 + e}} & \text{Three-phase mix of solids, water, air} \\
     \mathbf{\text{Fully Saturated Soil}} & \mathbf{S = 1.0 \ (100\%)} & \mathbf{\gamma_{\text{sat}} = \frac{(G_s + e)\gamma_w}{1 + e}} & \mathbf{\text{All voids completely filled with water }} (e = w G_s) \\
     \mathbf{\text{Submerged Below Water Table}} & S = 1.0 & \mathbf{\gamma' = \gamma_{\text{sat}} - \gamma_w} & \text{Buoyant effective unit weight after pore pressure} \\
     \hline
     \end{array}$$
   - **The Golden Phase Invariant:** The identity **$S \cdot e = w \cdot G_s$** is mathematically exact across all soils, allowing any missing fourth parameter to be instantly calculated if the other three are known!
2. **Slide 2 (`ordering`):** Provide 5 steps of phase calculation: (1) record measured soil test data: moisture content $w$, total unit weight $\gamma$, and specific gravity $G_s$, (2) calculate dry unit weight using moisture content: $\gamma_d = \gamma / (1 + w)$, (3) solve void ratio from dry unit weight: $e = \frac{G_s \gamma_w}{\gamma_d} - 1$, (4) compute degree of saturation: $S = \frac{w G_s}{e}$, (5) compute fully saturated unit weight $\gamma_{\text{sat}} = \frac{(G_s + e)\gamma_w}{1 + e}$ and buoyant unit weight $\gamma' = \gamma_{\text{sat}} - \gamma_w$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Void Ratio $e = V_v/V_s$, Porosity $n = e/(1+e)$, Degree of Saturation $S$, Effective Unit Weight $\gamma' = \gamma_{\text{sat}} - \gamma_w$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Gs (or Specific Gravity). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving soil phase relationships: An undisturbed soil sample has moisture content $w = 20\% = 0.20$, total moist unit weight $\gamma = 19.20\text{ kN/m}^3$, and specific gravity $G_s = 2.70$ (take $\gamma_w = 9.81\text{ kN/m}^3$). What is the dry unit weight $\gamma_d$, the void ratio $e$, and the saturated unit weight $\gamma_{\text{sat}}$? ($\gamma_d = \frac{\gamma}{1 + w} = \frac{19.20\text{ kN/m}^3}{1 + 0.20} = \frac{19.20}{1.20} = \mathbf{16.00\text{ kN/m}^3}$; $e = \frac{G_s \gamma_w}{\gamma_d} - 1 = \frac{2.70 \times 9.81}{16.00} - 1 = \frac{26.487}{16.00} - 1 = 1.6554 - 1 = \mathbf{0.6554 \approx 0.655}$; $\gamma_{\text{sat}} = \frac{(G_s + e)\gamma_w}{1 + e} = \frac{(2.70 + 0.6554) \times 9.81}{1 + 0.6554} = \frac{3.3554 \times 9.81}{1.6554} = \frac{32.9165}{1.6554} = \mathbf{19.88\text{ kN/m}^3}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "soil_phase_relationships_void_ratio_and_unit_weights",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Soil Phase Relationships \\& Unit Weights (Braja M. Das)**\n• **The Master Phase Invariant Formulation:**\n$$\n\\mathbf{S \\cdot e = w \\cdot G_s}\n$$\n  - **$S$:** Degree of saturation ($0 \\le S \\le 1.0$ or $0\\% \\le S \\le 100\\%$);\n  - **$e$:** Void ratio ($e = V_v / V_s$);\n  - **$w$:** Water / moisture content ($w = W_w / W_s$);\n  - **$G_s$:** Specific gravity of soil solids ($\\approx 2.65 - 2.75$);\n• **Unit Weight Formulations ($\\gamma_w = 9.81\\text{ kN/m}^3$):**\n$$\n\\mathbf{\\gamma = \\frac{(G_s + S e)\\gamma_w}{1 + e} \\quad \\Big| \\quad \\mathbf{\\gamma_d = \\frac{G_s \\gamma_w}{1 + e} = \\frac{\\gamma}{1 + w}} \\quad \\Big| \\quad \\mathbf{\\gamma_{\\text{sat}} = \\frac{(G_s + e)\\gamma_w}{1 + e}} \\quad \\Big| \\quad \\mathbf{\\gamma' = \\gamma_{\\text{sat}} - \\gamma_w}}\n$$\n• **Porosity Relationship:** $\\mathbf{n = \\frac{e}{1 + e} \\Longleftrightarrow e = \\frac{n}{1 - n}}$\n• **The Saturation Invariant:** When soil is fully saturated ($S = 1.0$), all void space is occupied by water, simplifying the phase equation to **$e = w \\cdot G_s$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve void ratio, dry unit weight, and saturated unit weight from laboratory soil test data.",
      "orderItems": [
        "Record measured laboratory values: total moist unit weight (\u03b3), water content (w), and specific gravity (Gs)",
        "Calculate the dry unit weight using moisture content: \u03b3d = \u03b3 / (1 + w)",
        "Determine the soil void ratio: e = (Gs * \u03b3w / \u03b3d) - 1",
        "Compute the in-situ degree of saturation: S = (w * Gs) / e",
        "Calculate the fully saturated unit weight: \u03b3sat = ((Gs + e) * \u03b3w) / (1 + e) and buoyant unit weight \u03b3' = \u03b3sat - \u03b3w"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Geotechnical Phase Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Void Ratio (e)", "right": "e = Vv / Vs, ratio of the volume of voids to the volume of solid soil mineral grains" },
        { "left": "Porosity (n)", "right": "n = Vv / V = e / (1+e), fraction of total soil volume occupied by void space" },
        { "left": "Degree of Saturation (S)", "right": "S = Vw / Vv = (w*Gs) / e, percentage of void space filled with pore water" },
        { "left": "Buoyant Unit Weight (\u03b3')", "right": "\u03b3' = \u03b3sat - \u03b3w = ((Gs - 1)*\u03b3w) / (1 + e), effective submerged unit weight" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In geotechnical soil mechanics, the fundamental invariant relating saturation S, void ratio e, water content w, and specific gravity Gs is S * e = w * ___.",
      "blankAnswer": "Gs",
      "blankDistractors": ["\u03b3w", "n", "e"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An undisturbed soil sample has moisture content w = 20% (0.20), total unit weight \u03b3 = 19.20 kN/m^3, and specific gravity Gs = 2.70 (\u03b3w = 9.81 kN/m^3). What is the dry unit weight \u03b3d, the void ratio e, and the saturated unit weight \u03b3sat?",
      "options": [
        { "text": "\u03b3d = 16.00 kN/m^3, e = 0.655, and \u03b3sat = 19.88 kN/m^3 (\u03b3d = 19.20 / (1 + 0.20) = 16.00 kN/m^3; e = (2.70 * 9.81 / 16.00) - 1 = 1.6554 - 1 = 0.655; \u03b3sat = (2.70 + 0.6554)*9.81 / (1 + 0.6554) = 19.88 kN/m^3)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using geotechnical phase relationships (Braja M. Das *Principles of Geotechnical Engineering* Chapter 3). 1. **Calculate Dry Unit Weight ($\\gamma_d$):** $$\\gamma_d = \\frac{\\gamma}{1 + w} = \\frac{19.20\\text{ kN/m}^3}{1 + 0.20} = \\frac{19.20}{1.20} = \\mathbf{16.00\\text{ kN/m}^3}$$ 2. **Calculate Void Ratio ($e$):** - From formula $\\gamma_d = \\frac{G_s \\gamma_w}{1 + e}$: $$1 + e = \\frac{G_s \\gamma_w}{\\gamma_d} = \\frac{2.70 \\times 9.81\\text{ kN/m}^3}{16.00\\text{ kN/m}^3} = \\frac{26.487}{16.00} = 1.6554375$$ $$e = 1.6554375 - 1 = \\mathbf{0.6554375 \\approx 0.655}$$ 3. **Calculate Degree of Saturation ($S$):** $$S = \\frac{w \\cdot G_s}{e} = \\frac{0.20 \\times 2.70}{0.6554375} = \\frac{0.540}{0.6554375} = \\mathbf{0.8239 = 82.4\\%}$$ 4. **Calculate Saturated Unit Weight ($\\gamma_{\\text{sat}}$):** $$\\gamma_{\\text{sat}} = \\frac{(G_s + e)\\gamma_w}{1 + e} = \\frac{(2.70 + 0.6554375) \\times 9.81\\text{ kN/m}^3}{1 + 0.6554375}$$ $$\\gamma_{\\text{sat}} = \\frac{3.3554375 \\times 9.81}{1.6554375} = \\frac{32.91684}{1.6554375} = \\mathbf{19.884\\text{ kN/m}^3 \\approx 19.88\\text{ kN/m}^3}$$ Flawless geotechnical phase relationship derivation!" },
        { "text": "\u03b3d = 19.20 kN/m^3, e = 0.500, and \u03b3sat = 21.00 kN/m^3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b3d = 16.00 kN/m^3, e = 0.850, and \u03b3sat = 18.50 kN/m^3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b3d = 15.36 kN/m^3, e = 0.725, and \u03b3sat = 19.88 kN/m^3", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
