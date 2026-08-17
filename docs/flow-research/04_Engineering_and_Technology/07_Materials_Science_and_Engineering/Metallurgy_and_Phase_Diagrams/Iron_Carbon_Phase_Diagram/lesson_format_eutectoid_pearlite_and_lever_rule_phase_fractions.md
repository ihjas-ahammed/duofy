# Duofy Reusable Lesson Format: Steel Equilibrium (Eutectoid Pearlite & Lever Rule Fractions)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Metallurgy_and_Phase_Diagrams / Iron_Carbon_Phase_Diagram`  
**Lesson Format Type:** `eutectoid_pearlite_and_lever_rule_phase_fractions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical metallurgy of the **Iron-Iron Carbide ($\text{Fe-Fe}_3\text{C}$)** phase diagram, the crystal structures of $\alpha$-ferrite (BCC, maximum $0.022\text{ wt}\%\text{ C}$), $\gamma$-austenite (FCC, up to $2.14\text{ wt}\%\text{ C}$), and stoichiometric cementite ($\text{Fe}_3\text{C}$, $6.70\text{ wt}\%\text{ C}$), the **Eutectoid Invariant Reaction at $727^\circ\text{C}$ and $0.76\text{ wt}\%\text{ C}$** ($\gamma \rightleftharpoons \alpha + \text{Fe}_3\text{C}$ forming lamellar **Pearlite**), and quantitative phase mass fraction calculations using the horizontal **Lever Rule** (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapter 9; Donald R. Askeland *The Science and Engineering of Materials* 7th ed. Chapter 10): formulate the **Eutectoid Transformation & Lever Rule Master Formulations**:
$$\mathbf{\gamma\text{-Austenite } (0.76\text{ wt}\%\text{ C}) \overset{727^\circ\text{C}}{\rightleftharpoons} \alpha\text{-Ferrite } (0.022\text{ wt}\%\text{ C}) + \text{Fe}_3\text{C } (6.70\text{ wt}\%\text{ C}) \quad [\text{Pearlite}]}$$
for any steel alloy with carbon weight fraction $C_0$ at room temperature / sub-eutectoid equilibrium ($T < 727^\circ\text{C}$):
$$\mathbf{W_\alpha = \frac{C_{\text{Fe}_3\text{C}} - C_0}{C_{\text{Fe}_3\text{C}} - C_\alpha} = \frac{6.70 - C_0}{6.70 - 0.022} = \frac{6.70 - C_0}{6.678}}$$
$$\mathbf{W_{\text{Fe}_3\text{C}} = \frac{C_0 - C_\alpha}{C_{\text{Fe}_3\text{C}} - C_\alpha} = \frac{C_0 - 0.022}{6.70 - 0.022} = \frac{C_0 - 0.022}{6.678}}$$
where:
1. **$W_\alpha$:** Mass fraction of soft, ductile $\alpha$-ferrite phase;
2. **$W_{\text{Fe}_3\text{C}}$:** Mass fraction of hard, brittle cementite phase;
3. **$C_0$:** Overall alloy nominal carbon content in weight percent ($\text{wt}\%\text{ C}$);
4. **$W_\alpha + W_{\text{Fe}_3\text{C}} = 1.000$;**
for the exact eutectoid steel ($C_0 = 0.76\text{ wt}\%\text{ C}$):
$$\mathbf{W_\alpha = \frac{6.70 - 0.76}{6.678} = \mathbf{0.8895 = 89.0\%} \quad \Big| \quad \mathbf{W_{\text{Fe}_3\text{C}} = \frac{0.76 - 0.022}{6.678} = \mathbf{0.1105 = 11.0\%}}}$$
(proving that eutectoid pearlite is composed of $89\%$ ductile ferrite matrix interleaved with $11\%$ reinforcing cementite plates).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Eutectoid Reaction ($\gamma \rightleftharpoons \alpha + \text{Fe}_3\text{C}$ at $727^\circ\text{C}$), Pearlite Lamellae & Lever Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Phase Mass Fractions of Ferrite and Cementite for an Alloy Steel Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Iron-Carbon Phase / Invariant Microconstituent & Technical Metallurgical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Iron-Iron Carbide Equilibrium System, the Invariant Transformation at 727°C Where Single Solid Austenite Transforms into Alternating Lamellae of Ferrite and Cementite Is Termed the ___ Reaction (Eutectoid / Eutectoid Transformation) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Physical Metallurgy Problem: Computing Mass Fractions of Ferrite and Cementite in a 1045 Plain Carbon Steel Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fe-Fe3C Equilibrium Mechanics (Callister 2020; Askeland 2016):
   - **Phase Formulations:**
     $$\mathbf{\gamma(0.76\%) \overset{727^\circ\text{C}}{\rightleftharpoons} \alpha(0.022\%) + \text{Fe}_3\text{C}(6.70\%) \quad \Big| \quad W_\alpha = \frac{6.70 - C_0}{6.678} \quad \Big| \quad W_{\text{Fe}_3\text{C}} = \frac{C_0 - 0.022}{6.678}}$$
   - **Key Phases Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Iron-Carbon Phase} & \textbf{Crystal Lattice} & \textbf{Max Carbon Solubility} & \textbf{Mechanical Nature} & \textbf{Microstructural Appearance} \\
     \hline
     \mathbf{\alpha\text{-Ferrite}} & \mathbf{\text{BCC}} & \mathbf{0.022\text{ wt}\%\text{ at } 727^\circ\text{C}} & \text{Soft, ductile, magnetic} & Light equiaxed grains \\
     \mathbf{\gamma\text{-Austenite}} & \mathbf{\text{FCC}} & \mathbf{2.14\text{ wt}\%\text{ at } 1147^\circ\text{C}} & \text{Non-magnetic, ductile} & High-temperature parent phase \\
     \mathbf{\text{Cementite (Fe}_3\text{C)}} & \text{Orthorhombic} & \mathbf{6.70\text{ wt}\%\text{ C (Fixed)}} & \mathbf{\text{Extremely hard, brittle}} & Intermetallic reinforcement \\
     \mathbf{\text{Pearlite}} & \mathbf{\alpha + \text{Fe}_3\text{C}} & 0.76\text{ wt}\%\text{ C} & Balanced strength \& ductility & Alternating parallel lamellae \\
     \hline
     \end{array}$$
   - **The Opposite Arm Invariant:** When applying the lever rule inside a two-phase field, always use the **length of the opposite tie-line segment** divided by the total tie-line span!
2. **Slide 2 (`ordering`):** Provide 5 steps of lever rule calculation: (1) locate overall alloy carbon content $C_0$ (e.g. $0.45\text{ wt}\%\text{ C}$) on the $\text{Fe-Fe}_3\text{C}$ phase diagram, (2) construct a horizontal tie-line across the two-phase field ($\alpha + \text{Fe}_3\text{C}$) at the target temperature below $727^\circ\text{C}$, (3) read boundary compositions: $C_\alpha = 0.022\text{ wt}\%\text{ C}$ and $C_{\text{Fe}_3\text{C}} = 6.70\text{ wt}\%\text{ C}$, (4) calculate ferrite mass fraction using opposite arm: $W_\alpha = (6.70 - C_0) / (6.70 - 0.022)$, (5) calculate cementite mass fraction: $W_{\text{Fe}_3\text{C}} = (C_0 - 0.022) / (6.70 - 0.022)$ and verify $W_\alpha + W_{\text{Fe}_3\text{C}} = 1.000$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Eutectoid Reaction, $\alpha$-Ferrite BCC, Cementite $\text{Fe}_3\text{C}$, Pearlite Lamellae) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Eutectoid (or Eutectoid Transformation). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating phase fractions for AISI 1045 steel: An AISI 1045 medium carbon steel ($C_0 = 0.45\text{ wt}\%\text{ C}$) is cooled slowly to room temperature in thermodynamic equilibrium. The equilibrium phases are $\alpha$-ferrite ($C_\alpha = 0.022\text{ wt}\%\text{ C}$) and cementite $\text{Fe}_3\text{C}$ ($C_{\text{Fe}_3\text{C}} = 6.70\text{ wt}\%\text{ C}$). Tie-line length is $6.70 - 0.022 = \mathbf{6.678}$.
   - Mass fraction of $\alpha$-ferrite:
     $W_\alpha = \frac{6.70 - 0.45}{6.678} = \frac{6.250}{6.678} = \mathbf{0.9359 = 93.59\% \approx 93.6\%}$;
   - Mass fraction of cementite:
     $W_{\text{Fe}_3\text{C}} = \frac{0.45 - 0.022}{6.678} = \frac{0.428}{6.678} = \mathbf{0.0641 = 6.41\% \approx 6.4\%}$;
   - Check: $W_\alpha + W_{\text{Fe}_3\text{C}} = 0.9359 + 0.0641 = 1.0000$;
   - What are the total equilibrium mass fractions of $\alpha$-ferrite and cementite? ($W_\alpha = \mathbf{93.6\%}$ and $W_{\text{Fe}_3\text{C}} = \mathbf{6.4\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "eutectoid_pearlite_and_lever_rule_phase_fractions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Iron-Carbon Eutectoid \\& Lever Rule (William D. Callister Jr.)**\n• **Eutectoid Invariant Reaction Master Formulation:**\n$$\n\\mathbf{\\gamma\\text{-Austenite } (0.76\\text{ wt}\\%\\text{ C}) \\overset{727^\\circ\\text{C}}{\\rightleftharpoons} \\alpha\\text{-Ferrite } (0.022\\text{ wt}\\%\\text{ C}) + \\text{Fe}_3\\text{C } (6.70\\text{ wt}\\%\\text{ C}) \\quad [\\text{Pearlite}]}\n$$\n• **The Lever Rule for Phase Mass Fractions ($W_\\alpha, W_{\\text{Fe}_3\\text{C}}$):**\n$$\n\\mathbf{W_\\alpha = \\frac{C_{\\text{Fe}_3\\text{C}} - C_0}{C_{\\text{Fe}_3\\text{C}} - C_\\alpha} = \\frac{6.70 - C_0}{6.678}} \\quad \\Big| \\quad \\mathbf{W_{\\text{Fe}_3\\text{C}} = \\frac{C_0 - C_\\alpha}{C_{\\text{Fe}_3\\text{C}} - C_\\alpha} = \\frac{C_0 - 0.022}{6.678}}\n$$\n  - **$W_\\alpha$:** Mass fraction of ductile $\\alpha$-ferrite (BCC);\n  - **$W_{\\text{Fe}_3\\text{C}}$:** Mass fraction of hard, brittle cementite ($\\text{Fe}_3\\text{C}$);\n  - **$C_0$:** Overall alloy nominal carbon composition ($\\text{wt}\\%\\text{ C}$);\n• **The Opposite Arm Invariant:** To calculate the mass fraction of the phase on the left ($W_\\alpha$), always divide the **opposite right lever arm ($6.70 - C_0$)** by the total tie-line length ($6.678$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the equilibrium phase mass fractions of ferrite and cementite in a plain carbon steel.",
      "orderItems": [
        "Locate the overall alloy carbon composition C0 on the horizontal axis of the Fe-Fe3C phase diagram",
        "Construct a horizontal tie-line across the two-phase \u03b1 + Fe3C field at temperature below 727\u00b0C",
        "Read the terminal phase compositions: C_\u03b1 = 0.022 wt% C (ferrite boundary) and C_Fe3C = 6.70 wt% C (cementite boundary)",
        "Calculate the total tie-line length: L_total = C_Fe3C - C_\u03b1 = 6.70 - 0.022 = 6.678 wt% C",
        "Apply the opposite-arm lever rule: W_\u03b1 = (6.70 - C0) / 6.678 and W_Fe3C = (C0 - 0.022) / 6.678 and verify \u2211 W = 1.0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Iron-Carbon Phase Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "\u03b1-Ferrite (BCC)", "right": "Body-Centered Cubic phase with very low maximum carbon solubility (0.022 wt% at 727\u00b0C), soft and ductile" },
        { "left": "\u03b3-Austenite (FCC)", "right": "Face-Centered Cubic phase with high interstitial carbon solubility (up to 2.14 wt% at 1147\u00b0C)" },
        { "left": "Cementite (Fe3C)", "right": "Hard, brittle intermetallic stoichiometric compound containing exactly 6.70 wt% carbon" },
        { "left": "Pearlite", "right": "Eutectoid lamellar microconstituent consisting of alternating plates of \u03b1-ferrite (89%) and Fe3C (11%)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the iron-iron carbide equilibrium system, the invariant transformation at 727\u00b0C where single solid austenite transforms into alternating lamellae of ferrite and cementite is termed the ___ reaction.",
      "blankAnswer": "eutectoid",
      "blankDistractors": ["eutectic", "peritectic", "monotectic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An AISI 1045 steel (C0 = 0.45 wt% C) is slowly cooled to room temperature. Boundary compositions are C_\u03b1 = 0.022 wt% C and C_Fe3C = 6.70 wt% C (tie-line length = 6.70 - 0.022 = 6.678). W_\u03b1 = (6.70 - 0.45) / 6.678 = 6.250 / 6.678 = 0.9359. W_Fe3C = (0.45 - 0.022) / 6.678 = 0.428 / 6.678 = 0.0641. What are the total equilibrium mass fractions of \u03b1-ferrite and cementite?",
      "options": [
        { "text": "W_\u03b1 = 93.6% and W_Fe3C = 6.4% (W_\u03b1 = 6.250 / 6.678 = 93.59% \u2248 93.6%; W_Fe3C = 0.428 / 6.678 = 6.41% \u2248 6.4%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Lever Rule on the Fe-Fe3C phase diagram (William D. Callister Jr. *Materials Science and Engineering: An Introduction* Chapter 9; Donald R. Askeland *The Science and Engineering of Materials* Chapter 10). 1. **Identify Alloy Composition \\& Tie-Line Phase Boundaries:** - Alloy nominal carbon content: $C_0 = 0.45\\text{ wt}\\%\\text{ C}$. - Equilibrium phases at room temperature: $\\alpha$-ferrite and cementite ($\\text{Fe}_3\\text{C}$). - Ferrite boundary carbon concentration: $C_\\alpha = 0.022\\text{ wt}\\%\\text{ C}$. - Cementite stoichiometric carbon concentration: $C_{\\text{Fe}_3\\text{C}} = 6.70\\text{ wt}\\%\\text{ C}$. 2. **Calculate Total Tie-Line Length:** $$L_{\\text{total}} = C_{\\text{Fe}_3\\text{C}} - C_\\alpha = 6.70 - 0.022 = \\mathbf{6.678\\text{ wt}\\%\\text{ C}}$$ 3. **Calculate Ferrite Mass Fraction ($W_\\alpha$ using opposite right arm):** $$W_\\alpha = \\frac{C_{\\text{Fe}_3\\text{C}} - C_0}{C_{\\text{Fe}_3\\text{C}} - C_\\alpha} = \\frac{6.70 - 0.45}{6.678} = \\frac{6.250}{6.678} = \\mathbf{0.93591 = 93.59\\% \\approx 93.6\\%}$$ 4. **Calculate Cementite Mass Fraction ($W_{\\text{Fe}_3\\text{C}}$ using opposite left arm):** $$W_{\\text{Fe}_3\\text{C}} = \\frac{C_0 - C_\\alpha}{C_{\\text{Fe}_3\\text{C}} - C_\\alpha} = \\frac{0.45 - 0.022}{6.678} = \\frac{0.428}{6.678} = \\mathbf{0.06409 = 6.41\\% \\approx 6.4\\%}$$ - Check mass balance: $$W_\\alpha + W_{\\text{Fe}_3\\text{C}} = 0.93591 + 0.06409 = \\mathbf{1.00000 = 100.0\\%}$$ Flawless Lever Rule phase mass fraction derivation!" },
        { "text": "W_\u03b1 = 6.4% and W_Fe3C = 93.6% (Inverted the opposite arm lever rule fractions)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_\u03b1 = 55.0% and W_Fe3C = 45.0%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_\u03b1 = 89.0% and W_Fe3C = 11.0% (Assumed exact eutectoid 0.76% composition)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
