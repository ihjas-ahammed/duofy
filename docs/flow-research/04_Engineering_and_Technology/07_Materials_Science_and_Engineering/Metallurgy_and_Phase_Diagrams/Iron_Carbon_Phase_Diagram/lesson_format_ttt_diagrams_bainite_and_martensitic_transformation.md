# Duofy Reusable Lesson Format: Kinetics & TTT (Bainite & Diffusionless Martensite)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Metallurgy_and_Phase_Diagrams / Iron_Carbon_Phase_Diagram`  
**Lesson Format Type:** `ttt_diagrams_bainite_and_martensitic_transformation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the non-equilibrium phase transformations of steel, the construction and interpretation of **Isothermal Time-Temperature-Transformation (TTT / C-Curve)** diagrams, the competitive kinetics of carbon diffusion, the formation of coarse pearlite ($650 - 727^\circ\text{C}$), fine pearlite ($550 - 650^\circ\text{C}$), upper and lower **Bainite** ($250 - 550^\circ\text{C}$), the critical cooling rate ($CCR$) to avoid the pearlite/bainite "nose", the **Diffusionless Athermal Martensitic Transformation** (FCC Austenite $\to$ Body-Centered Tetragonal BCT Martensite), Martensite Start ($M_s$) and Martensite Finish ($M_f$) temperatures, and the extreme hardness and brittleness of as-quenched martensite (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapter 10; Donald R. Askeland *The Science and Engineering of Materials* 7th ed. Chapter 11): formulate the **Avrami Kinetic Equation for Isothermal Phase Transformations**:
$$\mathbf{y(t) = 1 - \exp\left( -k \cdot t^n \right) \quad (\text{Fraction Transformed vs Time})}$$
master the **Martensite Transformation Hardness vs Carbon Content Empirical Relation**:
$$\mathbf{\text{Hardness}_{\text{Martensite}} \approx 30 + 50 \cdot (\text{wt}\%\text{ C}) \quad [\text{HRC}] \quad (\text{Max } \approx 65\text{ HRC at } 0.80\%\text{ C})}$$
master the **Microstructural Hardness & Ductility Hierarchy**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Microconstituent} & \textbf{Transformation Temp / Mechanism} & \textbf{Hardness Range} & \textbf{Key Mechanical Characteristics} \\
\hline
\mathbf{\text{Spheroidite}} & \text{Prolonged holding at } 700^\circ\text{C} & \approx 90\text{ HRB} & \mathbf{\text{Maximum ductility, machinability}} \\
\text{Coarse Pearlite} & 650 - 727^\circ\text{C} \ (\text{Slow diffusion}) & \approx 15 - 20\text{ HRC} & Moderate strength, high ductility \\
\mathbf{\text{Fine Pearlite}} & \mathbf{550 - 650^\circ\text{C} \ (\text{Rapid diffusion})} & \mathbf{\approx 25 - 30\text{ HRC}} & \mathbf{\text{High yield strength, good toughness}} \\
\mathbf{\text{Bainite (Lower)}} & \mathbf{250 - 400^\circ\text{C} \ (\text{Fine carbide needles})} & \mathbf{\approx 40 - 50\text{ HRC}} & \mathbf{\text{Exceptional combination of strength \& toughness}} \\
\mathbf{\text{Martensite (BCT)}} & \mathbf{< 220^\circ\text{C} \ (\text{Diffusionless shear})} & \mathbf{\approx 60 - 65\text{ HRC}} & \mathbf{\text{Extremely hard, highly brittle, strained lattice}} \\
\hline
\end{array}$$
(proving that rapid water quenching suppresses carbon diffusion, trapping carbon in a strained BCT lattice to produce martensite).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TTT Diagrams, C-Curve Nose, Bainite vs Martensite ($M_s, M_f$) & BCT Crystal Lattice Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace an Isothermal Heat Treatment Path on a TTT Curve to Predict Final Microstructure Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Steel Transformation Product / Kinetic Boundary & Technical Metallurgical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Formation of Martensite from Austenite Is a Diffusion-___ Athermal Transformation That Occurs via an Instantaneous Collective Shear of Iron Atoms into a Body-Centered Tetragonal Lattice (Less / Free / Diffusionless) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Physical Metallurgy Problem: Predicting Microstructural Phase Percentages from a Multi-Step TTT Cooling Profile Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TTT Kinetics & Non-Equilibrium Metallurgy (Callister 2020; Askeland 2016):
   - **Kinetic Formulations:**
     $$\mathbf{y(t) = 1 - e^{-k t^n} \quad \Big| \quad \text{FCC }\gamma \xrightarrow{\text{Athermal Shear}} \text{BCT Martensite} \quad \Big| \quad M_s \approx 220^\circ\text{C}, M_f \approx 100^\circ\text{C}}$$
   - **Transformation Regimes Matrix (Eutectoid 1080 Steel):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Thermal Trajectory} & \textbf{Temperature Range} & \textbf{Resulting Phase} & \textbf{Kinetics Driving Force} \\
     \hline
     \mathbf{\text{Hold above Nose}} & \mathbf{550 - 727^\circ\text{C}} & \mathbf{\text{Pearlite (\alpha + Fe}_3\text{C)}} & \text{High diffusion, moderate undercooling} \\
     \mathbf{\text{Hold below Nose}} & \mathbf{250 - 550^\circ\text{C}} & \mathbf{\text{Bainite (Acicular)}} & \text{Low diffusion, strong chemical driving force} \\
     \mathbf{\text{Rapid Quench below } M_s} & \mathbf{< 220^\circ\text{C}} & \mathbf{\text{Martensite (BCT)}} & \mathbf{\text{Diffusionless instantaneous shear transformation}} \\
     \hline
     \end{array}$$
   - **The Athermal Invariant:** Martensite transformation is **strictly temperature-dependent, not time-dependent**; holding steel at a temperature between $M_s$ and $M_f$ does not increase the martensite fraction over time—further transformation requires continuous cooling to lower temperatures!
2. **Slide 2 (`ordering`):** Provide 5 steps of TTT diagram isothermal analysis: (1) start in homogeneous austenite field at $800^\circ\text{C}$, (2) quench rapidly in $<1\text{ second}$ to $350^\circ\text{C}$ (avoiding the pearlite nose), (3) hold isothermally at $350^\circ\text{C}$ for $100\text{ seconds}$ until $50\%$ of austenite transforms to bainite, (4) quench rapidly to room temperature ($25^\circ\text{C}$) below $M_f$, (5) conclude that remaining $50\%$ untransformed austenite converts instantaneously into martensite, yielding a final microstructure of $50\%$ Bainite and $50\%$ Martensite!
3. **Slide 3 (`matching`):** Pair 4 concepts (TTT Diagram Nose, Body-Centered Tetragonal BCT, Martensite Start $M_s$, Bainite Microstructure) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Less (or Free / Diffusionless). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on TTT multi-step trajectory: A eutectoid steel ($0.76\text{ wt}\%\text{ C}$) is heated to $800^\circ\text{C}$ for complete austenitization. It undergoes the following three-step cooling cycle on a TTT diagram:
   - **Step 1:** Rapidly quenched in $0.5\text{ s}$ to $600^\circ\text{C}$ and held for $4\text{ seconds}$ ($50\%$ transformation curve to pearlite is reached);
   - **Step 2:** Rapidly quenched in $0.5\text{ s}$ from $600^\circ\text{C}$ to $350^\circ\text{C}$ and held for $1000\text{ seconds}$ (the $100\%$ transformation curve for bainite is crossed);
   - **Step 3:** Quenched to room temperature ($20^\circ\text{C}$);
   - What is the final room-temperature microstructure of the steel? ($50\%$ Fine Pearlite and $50\%$ Bainite).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ttt_diagrams_bainite_and_martensitic_transformation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Steel Transformation Kinetics \\& TTT Curves (Callister)**\n• **Time-Temperature-Transformation (TTT) Phase Kinetics:**\n$$\n\\mathbf{y(t) = 1 - \\exp\\left( -k \\cdot t^n \\right) \\quad (\\text{Avrami Equation for Isothermal Kinetics})}\n$$\n• **Non-Equilibrium Transformation Microconstituents:**\n  - **Pearlite ($550 - 727^\\circ\\text{C}$):** Diffusion-controlled lamellar $\\alpha + \\text{Fe}_3\\text{C}$;\n  - **Bainite ($250 - 550^\\circ\\text{C}$):** Fine needle-like non-lamellar aggregate of ferrite and cementite particles;\n  - **Martensite ($< M_s \\approx 220^\\circ\\text{C}$):** Diffusionless athermal shear transformation from FCC $\\gamma$ to Body-Centered Tetragonal (BCT) lattice supersaturated with carbon ($\\approx 65\\text{ HRC}$);\n• **The Athermal Invariant:** Martensite formation is **strictly athermal (temperature-dependent, not time-dependent)**; the fraction of martensite formed depends solely on the lowest temperature reached below $M_s$, completely independent of holding duration!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to track the microstructural evolution of a eutectoid steel subjected to a multi-stage isothermal heat treatment.",
      "orderItems": [
        "Austenitize steel at 800\u00b0C to achieve a 100% homogeneous Face-Centered Cubic (FCC) \u03b3-austenite grain structure",
        "Quench rapidly in less than 1 second to an intermediate isothermal holding temperature below the TTT nose (e.g. 350\u00b0C)",
        "Hold isothermally at 350\u00b0C to allow carbon diffusion to nucleate and grow acicular bainite platelets",
        "Monitor transformation time against the 50% and 100% Avrami transformation boundary curves",
        "Quench rapidly below the Martensite Finish temperature (Mf < 100\u00b0C) to convert any remaining austenite into hard BCT martensite"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Steel Transformation Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "TTT Diagram Nose (\u2248 550\u00b0C)", "right": "Critical kinetic point of fastest transformation where high thermodynamic undercooling balances decreasing atomic diffusivity" },
        { "left": "BCT Martensite", "right": "Body-Centered Tetragonal interstitial supersaturated solid solution formed by instantaneous diffusionless crystal shear" },
        { "left": "Bainite", "right": "Acicular microconstituent formed between 250\u00b0C and 550\u00b0C combining high yield strength with exceptional impact toughness" },
        { "left": "Martensite Start (Ms)", "right": "Temperature (\u2248 220\u00b0C) below which austenite begins instantaneous athermal transformation to martensite" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The formation of martensite from austenite is a diffusion-___ athermal transformation that occurs via an instantaneous collective shear of iron atoms into a Body-Centered Tetragonal lattice.",
      "blankAnswer": "less",
      "blankDistractors": ["driven", "controlled", "enhanced"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 1080 eutectoid steel is austenitized at 800\u00b0C. It is rapidly quenched to 600\u00b0C and held for 4 seconds (reaching the 50% pearlite line, transforming half the austenite into fine pearlite). It is then rapidly cooled to 350\u00b0C and held for 1000 seconds (crossing the 100% bainite line), then quenched to room temperature. What is the final room-temperature microstructure?",
      "options": [
        { "text": "50% Fine Pearlite and 50% Bainite (50% transformed to pearlite at 600\u00b0C; the remaining 50% austenite transformed to bainite at 350\u00b0C)", "isCorrect": true, "explanation": "Correct! Let's trace the multi-step isothermal transformation on the eutectoid TTT diagram (William D. Callister Jr. *Materials Science and Engineering: An Introduction* Chapter 10; Donald R. Askeland *The Science and Engineering of Materials* Chapter 11). 1. **Initial State:** - Austenitization at $800^\\circ\\text{C}$ creates $100\\% \\gamma\\text{-austenite}$. 2. **Step 1 ($600^\\circ\\text{C}$ for $4\\text{ s}$):** - The steel is quenched rapidly to $600^\\circ\\text{C}$ without touching the nose. - At $600^\\circ\\text{C}$, after $4\\text{ seconds}$, the path intersects the $50\\%$ transformation curve for Pearlite. - Therefore, **$50\\%$ of the austenite transforms into Fine Pearlite**, leaving **$50\\%$ untransformed austenite**. 3. **Step 2 ($350^\\circ\\text{C}$ for $1000\\text{ s}$):** - The sample is rapidly cooled from $600^\\circ\\text{C}$ to $350^\\circ\\text{C}$. The existing $50\\%$ pearlite is completely stable and does not change. - The remaining $50\\%$ austenite is held at $350^\\circ\\text{C}$ for $1000\\text{ seconds}$. - Since $1000\\text{ seconds}$ exceeds the $100\\%$ completion time on the bainite curve ($\approx 200\\text{ s}$), **all remaining $50\\%$ austenite transforms into Bainite**. 4. **Step 3 (Quench to Room Temp):** - Since zero austenite remains, no martensite can form during final quenching. - Final Microstructure: **$50\\%$ Fine Pearlite and $50\\%$ Bainite**! Flawless TTT transformation path analysis!" },
        { "text": "100% Martensite (Assumed final quench converts everything to martensite)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "50% Fine Pearlite, 25% Bainite, 25% Martensite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "100% Pearlite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
