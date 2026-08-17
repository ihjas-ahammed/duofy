# Duofy Reusable Lesson Format: Closed Tubes (Bredt-Batho Torsion & Shear Flow)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Aircraft_Structures_and_Materials / Thin_Walled_Structures_and_Buckling`  
**Lesson Format Type:** `bredt_batho_torsion_and_closed_tube_shear_flow`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural mechanics of thin-walled closed aerospace tubes and wing torque boxes subjected to pure torsional moments ($T$), Rudolf Bredt and C. Batho's 1896 **First Torsion Formula** establishing constant circulating shear flow ($q = \tau \cdot t = \frac{T}{2 A_m}$ in $\text{N/mm}$), the definition of **Enclosed Median Area ($A_m$)**, maximum shear stress in variable thickness skins ($\tau_{\text{max}} = q / t_{\text{min}}$), the **Bredt-Batho Second Torsion Formula** for torsional rate of twist ($\frac{d\phi}{dz} = \frac{T}{4 A_m^2 G} \oint \frac{ds}{t}$), and the equivalent **Torsional Constant ($J = \frac{4 A_m^2}{\oint \frac{ds}{t}}$)** (T. H. G. Megson *Aircraft Structures for Engineering Students* 6th ed. Chapter 18; David J. Peery *Aircraft Structures* Chapter 7; Rudolf Bredt 1896): formulate the **Bredt-Batho First Torsion Master Formulation**:
$$\mathbf{q = \tau \cdot t = \frac{T}{2 A_m} \Longleftrightarrow \mathbf{\tau(s) = \frac{T}{2 A_m \cdot t(s)} \quad \left[\frac{\text{N}}{\text{mm}^2}\right]}}$$
where:
1. **$q$:** Circulating shear flow in $\text{N/mm}$, strictly constant around the entire single-cell closed perimeter;
2. **$T$:** Applied torsional torque ($\text{N}\cdot\text{mm}$);
3. **$A_m$:** Cross-sectional area enclosed by the median line of the thin walls ($\text{mm}^2$);
4. **$t(s)$:** Local wall skin thickness ($\text{mm}$);
formulate the **Bredt-Batho Second Torsion Rate of Twist Formulation ($\theta = \frac{d\phi}{dz}$)**:
$$\mathbf{\frac{d\phi}{dz} = \frac{q}{2 A_m G} \oint \frac{ds}{t} = \frac{T}{4 A_m^2 G} \oint \frac{ds}{t} \quad \left[\frac{\text{rad}}{\text{mm}}\right] \Longleftrightarrow \mathbf{J = \frac{4 A_m^2}{\oint \frac{ds}{t}}}}$$
where:
1. **$G$:** Shear modulus of elasticity ($\text{MPa} = \text{N/mm}^2$);
2. **$\oint \frac{ds}{t} = \sum_{i=1}^n \frac{s_i}{t_i}$:** Closed contour line integral of perimeter segment lengths divided by their respective thicknesses;
(proving why aircraft wing boxes and fuselages must form continuous closed cells: closing an open C-channel with a thin web boosts torsional stiffness $J$ by over **3 orders of magnitude ($1000\times$)**).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bredt-Batho Formula ($q = \frac{T}{2 A_m}$), Skin Shear ($\tau = \frac{q}{t}$) & Rate of Twist ($\frac{d\phi}{dz} = \frac{T}{4 A_m^2 G}\oint \frac{ds}{t}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Shear Flow, Skin Shear Stresses, and Angle of Twist of a Wing Torque Box Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Closed Tube Torsion Parameter / Geometric Entity & Technical Aerospace Mechanics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Thin-Walled Closed Single-Cell Aerospace Wing Box Subjected to Pure Torque, the Shear Flow $q = \tau \cdot t$ Around the Closed Perimeter Is Strictly ___ (Constant / Uniform / Invariant) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Airframe Structural Problem: Computing Shear Flow, Skin Shear Stress, and Rate of Twist for a Rectangular Wing Box Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bredt-Batho Closed Tube Torsion Mechanics (Bredt 1896; Megson 2017; Peery 1982):
   - **Torsion Formulations:**
     $$\mathbf{q = \frac{T}{2 A_m} \quad \Big| \quad \tau_{\text{max}} = \frac{q}{t_{\text{min}}} = \frac{T}{2 A_m t_{\text{min}}} \quad \Big| \quad \frac{d\phi}{dz} = \frac{T}{4 A_m^2 G} \oint \frac{ds}{t} \quad \Big| \quad J = \frac{4 A_m^2}{\oint \frac{ds}{t}}}$$
   - **Torsional Resistance Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Cross-Section Geometry} & \textbf{Torsional Constant } J & \textbf{Torsional Stiffness} & \textbf{Aerospace Structural Application} \\
     \hline
     \mathbf{\text{Closed Box Beam (Wing D-nose)}} & \mathbf{J = \frac{4 A_m^2}{\oint \frac{ds}{t}} \ (\propto A_m^2)} & \mathbf{\text{Extremely High } (\approx 10^7\text{ mm}^4)} & \mathbf{\text{Primary wing torque box, fuselage skin}} \\
     \mathbf{\text{Open Slit Tube / C-Channel}} & \mathbf{J = \frac{1}{3} \sum s_i t_i^3 \ (\propto t^3)} & \mathbf{\text{Extremely Low } (\approx 10^3\text{ mm}^4)} & \text{Secondary fairings, stringers under axial load} \\
     \hline
     \end{array}$$
   - **The Constant Shear Flow Invariant:** In any single-cell closed tube under pure torque, longitudinal shear equilibrium **strictly requires that $q = \tau \cdot t$ remains constant throughout the entire perimeter**; where skin is thinner, shear stress $\tau = q/t$ rises proportionately!
2. **Slide 2 (`ordering`):** Provide 5 steps of Bredt-Batho torsion calculation: (1) calculate the enclosed median area $A_m$ bounded by the centerlines of the box walls, (2) compute the constant circulating shear flow: $q = \frac{T}{2 A_m}$, (3) divide shear flow by individual wall thicknesses to find local shear stresses: $\tau_i = q / t_i$, (4) evaluate the contour line integral: $\oint \frac{ds}{t} = \sum \frac{s_i}{t_i}$, (5) compute torsional rate of twist: $\frac{d\phi}{dz} = \frac{q}{2 A_m G} \oint \frac{ds}{t}$ and multiply by length $L$ to obtain total twist angle $\phi$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bredt-Batho First Formula $q = \frac{T}{2 A_m}$, Enclosed Median Area $A_m$, Rate of Twist $\frac{d\phi}{dz}$, Torsional Constant $J$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Constant (or Uniform / Invariant). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating shear flow, stress, and twist: An aluminum wing box has a rectangular cross-section with width $b = 400.0\text{ mm}$ and depth $h = 200.0\text{ mm}$ (Enclosed median area $A_m = 400.0 \times 200.0 = \mathbf{80,000.0\text{ mm}^2}$). Top and bottom skins have thickness $t_{\text{skin}} = 2.0\text{ mm}$ ($s = 400.0\text{ mm}$ each), and front and rear vertical spar webs have thickness $t_{\text{spar}} = 4.0\text{ mm}$ ($s = 200.0\text{ mm}$ each). A torque $T = 16.0\text{ kN}\cdot\text{m} = \mathbf{16.0 \times 10^6\text{ N}\cdot\text{mm}}$ is applied. Aluminum shear modulus $G = 26.0\text{ GPa} = 26,000.0\text{ MPa}$.
   - Constant shear flow: $q = \frac{T}{2 A_m} = \frac{16.0 \times 10^6\text{ N}\cdot\text{mm}}{2 \times 80,000.0\text{ mm}^2} = \frac{16.0 \times 10^6}{160,000.0} = \mathbf{100.0\text{ N/mm}}$;
   - Maximum shear stress (in thinner $2.0\text{ mm}$ skin): $\tau_{\text{skin}} = \frac{q}{t_{\text{skin}}} = \frac{100.0\text{ N/mm}}{2.0\text{ mm}} = \mathbf{50.0\text{ MPa}}$;
   - Contour integral $\oint \frac{ds}{t}$:
     $\oint \frac{ds}{t} = 2 \left( \frac{400.0}{2.0} \right) + 2 \left( \frac{200.0}{4.0} \right) = 2(200.0) + 2(50.0) = 400.0 + 100.0 = \mathbf{500.0}$;
   - Rate of twist $\frac{d\phi}{dz}$:
     $\frac{d\phi}{dz} = \frac{q}{2 A_m G} \oint \frac{ds}{t} = \frac{100.0}{2 \times 80,000.0 \times 26,000.0} \times 500.0 = \frac{50,000.0}{4.16 \times 10^9} = \mathbf{1.2019 \times 10^{-5}\text{ rad/mm} = 1.202 \times 10^{-2}\text{ rad/m} \approx 0.689^\circ\text{/m}}$;
   - What is the shear flow $q$ and the maximum shear stress $\tau_{\text{max}}$ in the skin? ($q = \mathbf{100.0\text{ N/mm}}$ and $\tau_{\text{max}} = \mathbf{50.0\text{ MPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bredt_batho_torsion_and_closed_tube_shear_flow",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Closed Tube Torsion \\& Bredt-Batho Formulas (Rudolf Bredt 1896)**\n• **Bredt-Batho First Torsion Formulation (Shear Flow $q$):**\n$$\n\\mathbf{q = \\tau \\cdot t = \\frac{T}{2 A_m} \\Longleftrightarrow \\tau(s) = \\frac{T}{2 A_m \\cdot t(s)} \\quad \\left[\\frac{\\text{N}}{\\text{mm}^2}\\right]}\n$$\n  - **$q$:** Constant circulating shear flow around the closed perimeter ($\\text{N/mm}$);\n  - **$T$:** Applied torsional torque ($\\text{N}\\cdot\\text{mm}$);\n  - **$A_m$:** Cross-sectional area enclosed by the wall median centerline ($\\text{mm}^2$);\n  - **$t(s)$:** Local wall thickness ($\\text{mm}$);\n• **Bredt-Batho Second Torsion Formulation (Rate of Twist $\\frac{d\\phi}{dz}$):**\n$$\n\\mathbf{\\frac{d\\phi}{dz} = \\frac{T}{4 A_m^2 G} \\oint \\frac{ds}{t} = \\frac{q}{2 A_m G} \\sum_{i=1}^n \\frac{s_i}{t_i} \\quad \\left[\\frac{\\text{rad}}{\\text{mm}}\\right] \\Longleftrightarrow J = \\frac{4 A_m^2}{\\oint \\frac{ds}{t}}}\n$$\n• **The Constant Shear Flow Invariant:** In any single-cell closed tube under pure torque, longitudinal shear equilibrium **strictly dictates that shear flow $q$ is uniform throughout the entire perimeter**; where skin is thinner ($t_{\\text{min}}$), shear stress $\\tau = q/t$ reaches its absolute maximum!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the shear flow, skin shear stresses, and rate of twist for a closed single-cell aircraft wing box.",
      "orderItems": [
        "Calculate the enclosed median area Am defined by the centerline perimeter of the thin-walled wing box",
        "Calculate the constant circulating shear flow from Bredt-Batho's first equation: q = T / (2 * Am)",
        "Determine local shear stresses in each panel by dividing shear flow by wall thickness: \u03c4_i = q / t_i",
        "Evaluate the closed contour integral: \u222e (ds / t) = \u2211 (s_i / t_i) for all wall segments",
        "Compute the torsional rate of twist: d\u03c6/dz = [ q / (2 * Am * G) ] * \u222e (ds / t) and determine overall wing twist"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Closed Section Torsion Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bredt-Batho First Formula", "right": "q = T / (2*Am), fundamental equilibrium law equating torque to twice the enclosed area times shear flow" },
        { "left": "Enclosed Median Area (Am)", "right": "Geometric cross-sectional area bounded by the centerline of the thin exterior structural walls" },
        { "left": "Rate of Twist (d\u03c6/dz)", "right": "d\u03c6/dz = [T / (4*Am^2*G)] * \u222e(ds/t), angular rotation per unit span length under applied torque" },
        { "left": "Torsional Constant (J)", "right": "J = 4*Am^2 / \u222e(ds/t), geometric resistance factor to torsional twisting for thin closed tubes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a thin-walled closed single-cell aerospace wing box subjected to pure torque, the shear flow q = \u03c4 * t around the closed perimeter is strictly ___.",
      "blankAnswer": "constant",
      "blankDistractors": ["variable", "zero", "exponential"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular wing box has width b = 400.0 mm and depth h = 200.0 mm (Am = 400 * 200 = 80,000 mm^2). Top/bottom skins are t_skin = 2.0 mm (s = 400 mm), and vertical spar webs are t_spar = 4.0 mm (s = 200 mm). A torque of T = 16.0 kN*m = 1.60 \u00d7 10^7 N*mm is applied. What is the constant shear flow q and the maximum shear stress \u03c4_max in the 2.0 mm skin?",
      "options": [
        { "text": "q = 100.0 N/mm and \u03c4_max = 50.0 MPa (q = 1.60 \u00d7 10^7 / (2 * 80,000) = 100.0 N/mm; \u03c4_max = 100.0 N/mm / 2.0 mm = 50.0 MPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Bredt-Batho closed-tube torsion theory (T. H. G. Megson *Aircraft Structures for Engineering Students* Chapter 18). 1. **Identify Wing Box Geometry \\& Applied Torque:** - Width: $b = 400.0\\text{ mm}$. - Depth: $h = 200.0\\text{ mm}$. - Enclosed median area: $$A_m = b \\times h = 400.0\\text{ mm} \\times 200.0\\text{ mm} = \\mathbf{80,000.0\\text{ mm}^2}$$ - Applied torque: $$T = 16.0\\text{ kN}\\cdot\\text{m} = 16.0 \\times 10^3\\text{ N} \\times 10^3\\text{ mm} = \\mathbf{1.60 \\times 10^7\\text{ N}\\cdot\\text{mm}}$$ 2. **Calculate Constant Shear Flow ($q$):** - Bredt-Batho's First Formula: $$q = \\frac{T}{2 A_m} = \\frac{1.60 \\times 10^7\\text{ N}\\cdot\\text{mm}}{2 \\times 80,000.0\\text{ mm}^2} = \\frac{1.60 \\times 10^7}{160,000.0} = \\mathbf{100.0\\text{ N/mm}}$$ 3. **Calculate Maximum Shear Stress ($\\tau_{\\text{max}}$):** - Upper/lower skin panels: $t_{\\text{skin}} = 2.0\\text{ mm}$. - Vertical spar webs: $t_{\\text{spar}} = 4.0\\text{ mm}$. - Shear stress in skin: $$\\tau_{\\text{skin}} = \\frac{q}{t_{\\text{skin}}} = \\frac{100.0\\text{ N/mm}}{2.0\\text{ mm}} = \\mathbf{50.0\\text{ MPa}}$$ - Shear stress in spar webs: $$\\tau_{\\text{spar}} = \\frac{q}{t_{\\text{spar}}} = \\frac{100.0\\text{ N/mm}}{4.0\\text{ mm}} = 25.0\\text{ MPa}$$ - Maximum shear stress occurs in the thinner skin panels: $$\\tau_{\\text{max}} = \\mathbf{50.0\\text{ MPa}}$$ Flawless Bredt-Batho shear flow and maximum skin stress derivation!" },
        { "text": "q = 200.0 N/mm and \u03c4_max = 100.0 MPa (Forgot factor of 2 in denominator)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "q = 100.0 N/mm and \u03c4_max = 25.0 MPa (Reported spar web stress instead of maximum skin stress)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "q = 50.0 N/mm and \u03c4_max = 25.0 MPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
