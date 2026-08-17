# Duofy Reusable Lesson Format: Plate Stability (Bryan Buckling & Critical Stress Scaling)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Aircraft_Structures_and_Materials / Thin_Walled_Structures_and_Buckling`  
**Lesson Format Type:** `bryan_plate_buckling_and_critical_stress_scaling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the elastic stability of thin flat aircraft skin panels and spar webs under in-plane compressive and shear loads, G. H. Bryan's 1891 classical **Plate Buckling Formulation**, plate bending flexural rigidity ($D = \frac{E t^3}{12(1-\nu^2)}$), plate aspect ratio ($a/b$), boundary condition buckling coefficient ($K_c$), the $(t/b)^2$ quadratic thickness scaling law, and the transition from column buckling to 2D plate stability (T. H. G. Megson *Aircraft Structures for Engineering Students* 6th ed. Chapter 20; David J. Peery *Aircraft Structures* Chapter 8; G. H. Bryan 1891): formulate the **Bryan Critical Plate Buckling Stress Master Formulation**:
$$\mathbf{\sigma_{\text{cr}} = K_c \frac{\pi^2 E}{12 (1 - \nu^2)} \left( \frac{t}{b} \right)^2 = K_c \frac{\pi^2 D}{b^2 \cdot t} \quad \left[\frac{\text{N}}{\text{mm}^2} = \text{MPa}\right]}$$
where:
1. **$\sigma_{\text{cr}}$:** Critical compressive stress at which the skin panel elastically buckles (wrinkles);
2. **$E, \nu$:** Young's modulus ($\text{MPa}$) and Poisson's ratio ($\nu \approx 0.33$ for aluminum alloys);
3. **$t$:** Skin panel thickness ($\text{mm}$);
4. **$b$:** Loaded panel width (transverse distance between adjacent longitudinal stringers);
5. **$a$:** Panel length (longitudinal distance between transverse rib frames);
6. **$K_c$:** Dimensionless compressive buckling coefficient:
   - **All 4 Edges Simply Supported ($a/b \ge 1$ integer):** $\mathbf{K_c = 4.00}$;
   - **All 4 Edges Clamped/Fixed ($a/b \ge 1$):** $\mathbf{K_c = 6.97 \approx 7.00}$;
   - **One Edge Free, Three Edges Supported (Flange Outstand):** $\mathbf{K_c \approx 0.425}$;
(proving that reducing stringer pitch $b$ by $50\%$ increases the critical skin buckling stress by **$400\%$**, demonstrating why aircraft wing skins are densely reinforced with closely spaced longitudinal stringers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bryan Plate Buckling ($\sigma_{\text{cr}} = K_c \frac{\pi^2 E}{12(1-\nu^2)}(\frac{t}{b})^2$), $K_c=4.0$ & Flexural Rigidity ($D$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Plate Slenderness Ratio, Buckling Coefficient, and Critical Buckling Stress Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Plate Buckling Parameter / Boundary Condition & Technical Structural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Bryan's Plate Buckling Equation, the Critical Elastic Compressive Buckling Stress Scales Directly with the ___ of the Thickness-to-Width Ratio $(t/b)^2$ (Square / Second Power) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Aircraft Skin Stability Problem: Computing Critical Buckling Stress for an Aluminum Upper Wing Skin Panel Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bryan Plate Buckling Mechanics (Bryan 1891; Megson 2017; Peery 1982):
   - **Stability Formulations:**
     $$\mathbf{\sigma_{\text{cr}} = K_c \frac{\pi^2 E}{12(1-\nu^2)}\left(\frac{t}{b}\right)^2 \quad \Big| \quad D = \frac{Et^3}{12(1-\nu^2)} \quad \Big| \quad K_c(a/b \ge 1) = \left(m \frac{b}{a} + \frac{1}{m} \frac{a}{b}\right)^2 \ge 4.00}$$
   - **Boundary Conditions & $K_c$ Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Plate Edge Support Conditions} & \textbf{Buckling Mode } m & \textbf{Buckling Coefficient } K_c & \textbf{Airframe Structural Context} \\
     \hline
     \mathbf{\text{Simply Supported (All 4 Edges)}} & \mathbf{m = 1, 2, 3 \dots} & \mathbf{K_c = 4.00} & \mathbf{\text{Conservative baseline for skin panels between stringers}} \\
     \mathbf{\text{Clamped / Fixed (All 4 Edges)}} & \text{High Constraint} & \mathbf{K_c \approx 6.97} & \text{Heavily riveted/bonded integral stiffened skins} \\
     \text{Flange Outstand (1 Free, 3 Pinned)} & \text{Free Edge Torsion} & \mathbf{K_c \approx 0.425} & \text{Spar cap outstands, Z-stringer flanges} \\
     \hline
     \end{array}$$
   - **The Quadratic Thickness Invariant:** The critical buckling stress scales as **$\sigma_{\text{cr}} \propto (t/b)^2$**; doubling the skin thickness $t$ increases elastic buckling resistance by **$400\%$**, while doubling the stringer spacing $b$ drops buckling resistance to **$25\%$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Bryan buckling analysis: (1) determine panel width $b$ between stringers, length $a$ between ribs, and skin thickness $t$, (2) extract material properties: Young's modulus $E$ and Poisson's ratio $\nu$, (3) evaluate plate aspect ratio $a/b$ and select compressive buckling coefficient $K_c$ (e.g. $K_c = 4.0$ for simply supported), (4) calculate plate flexural stiffness factor: $\frac{\pi^2 E}{12(1-\nu^2)}$, (5) multiply by $(t/b)^2$ and $K_c$ to obtain critical compressive buckling stress $\sigma_{\text{cr}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bryan Buckling Equation, Buckling Coefficient $K_c = 4.0$, Flexural Rigidity $D$, Stringer Spacing $b$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Square (or Second Power). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Bryan critical buckling stress: An upper wing skin panel made of 2024-T3 aluminum alloy has $E = 70.0\text{ GPa} = 70,000.0\text{ MPa}$, Poisson's ratio $\nu = 0.30$ ($1 - \nu^2 = 1 - 0.09 = 0.91$), thickness $t = 2.0\text{ mm}$, and width between stringers $b = 100.0\text{ mm}$ ($t/b = 2.0/100.0 = 0.020 \implies (t/b)^2 = 0.00040 = 4.0 \times 10^{-4}$). The panel is simply supported on all four edges ($K_c = 4.00$).
   - Plate constant:
     $\frac{\pi^2 E}{12(1-\nu^2)} = \frac{\pi^2 \times 70,000.0}{12 \times 0.91} = \frac{690,872.3}{10.92} = \mathbf{63,266.69\text{ MPa}}$;
   - Critical buckling stress $\sigma_{\text{cr}}$:
     $\sigma_{\text{cr}} = K_c \times 63,266.69 \times (t/b)^2 = 4.00 \times 63,266.69 \times 0.00040 = 4.00 \times 25.3067 = \mathbf{101.23\text{ MPa} \approx 101.2\text{ MPa}}$;
   - What is the critical elastic compressive buckling stress $\sigma_{\text{cr}}$? ($\sigma_{\text{cr}} = \mathbf{101.2\text{ MPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bryan_plate_buckling_and_critical_stress_scaling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Thin Plate Buckling \\& Bryan Equation (G. H. Bryan 1891)**\n• **Bryan Critical Plate Buckling Stress Master Formulation:**\n$$\n\\mathbf{\\sigma_{\\text{cr}} = K_c \\frac{\\pi^2 E}{12 (1 - \\nu^2)} \\left( \\frac{t}{b} \\right)^2 = K_c \\frac{\\pi^2 D}{b^2 \\cdot t} \\quad [\\text{MPa}]}\n$$\n  - **$\\sigma_{\\text{cr}}$:** Critical compressive stress at onset of skin wrinkling;\n  - **$E, \\nu$:** Young's modulus and Poisson's ratio ($\\nu \\approx 0.30$ for aluminum);\n  - **$t$:** Skin panel thickness ($\\text{mm}$);\n  - **$b$:** Transverse width between longitudinal stringers ($\\text{mm}$);\n  - **$K_c$:** Compressive buckling coefficient ($\\mathbf{K_c = 4.00}$ for all 4 edges simply supported);\n• **Plate Flexural Rigidity Formulation ($D$):**\n$$\n\\mathbf{D = \\frac{E t^3}{12 (1 - \\nu^2)} \\quad [\\text{N}\\cdot\\text{mm}]}\n$$\n• **The Quadratic Thickness Invariant:** Critical buckling stress scales **strictly with $(t/b)^2$**; reducing stringer pitch $b$ by half increases skin buckling resistance by **$400\\%$**, explaining why airframes utilize dense arrays of longitudinal stringers!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the critical elastic compressive buckling stress of an aircraft skin panel.",
      "orderItems": [
        "Determine the panel geometric dimensions: thickness t, stringer spacing b, and rib spacing a",
        "Extract the material elastic properties: Young's modulus E and Poisson's ratio \u03bd",
        "Compute the plate aspect ratio a/b and select the appropriate boundary constraint coefficient Kc (e.g. Kc = 4.0)",
        "Calculate the material plate constant: M = [\u03c0^2 * E] / [12 * (1 - \u03bd^2)]",
        "Calculate the critical compressive buckling stress: \u03c3_cr = Kc * M * (t / b)^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Plate Buckling Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bryan Buckling Equation", "right": "\u03c3_cr = Kc * [\u03c0^2*E / 12(1-\u03bd^2)] * (t/b)^2, exact elastic stability formula for thin compressed sheets" },
        { "left": "Buckling Coefficient (Kc = 4.0)", "right": "Theoretical minimum stability factor for a long rectangular plate simply supported on all four edges" },
        { "left": "Plate Rigidity (D)", "right": "D = E*t^3 / [12*(1-\u03bd^2)], 2D flexural resistance taking into account Poisson lateral restraint" },
        { "left": "Stringer Spacing (b)", "right": "Transverse distance between parallel stiffeners defining the effective width in the (t/b)^2 term" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Bryan's plate buckling equation, the critical elastic compressive buckling stress scales directly with the ___ of the thickness-to-width ratio (t/b)^2.",
      "blankAnswer": "square",
      "blankDistractors": ["cube", "square root", "fourth power"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An aluminum skin panel (E = 70,000 MPa, \u03bd = 0.30 \u2192 1-\u03bd^2 = 0.91) has thickness t = 2.0 mm and stringer spacing b = 100.0 mm (t/b = 0.020 \u2192 (t/b)^2 = 0.00040). For simply supported edges, Kc = 4.00. The plate constant is \u03c0^2 * 70,000 / (12 * 0.91) = 63,267 MPa. What is the critical elastic compressive buckling stress \u03c3_cr?",
      "options": [
        { "text": "\u03c3_cr = 101.2 MPa (\u03c3_cr = 4.00 * 63,266.7 MPa * 0.00040 = 101.23 MPa \u2248 101.2 MPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using G. H. Bryan's thin plate buckling formulation (T. H. G. Megson *Aircraft Structures for Engineering Students* Chapter 20; David J. Peery *Aircraft Structures* Chapter 8). 1. **Identify Panel Geometric \\& Material Properties:** - Panel thickness: $t = 2.0\\text{ mm}$. - Stringer spacing (panel width): $b = 100.0\\text{ mm}$. - Thickness-to-width ratio: $$\\frac{t}{b} = \\frac{2.0\\text{ mm}}{100.0\\text{ mm}} = 0.0200 \\implies \\left( \\frac{t}{b} \\right)^2 = (0.0200)^2 = \\mathbf{0.000400 = 4.0 \\times 10^{-4}}$$ - Young's modulus: $E = 70,000.0\\text{ MPa}$. - Poisson's ratio: $\\nu = 0.30 \\implies 1 - \\nu^2 = 1 - (0.30)^2 = 1 - 0.09 = \\mathbf{0.910}$. - Compressive buckling coefficient: $K_c = 4.00$. 2. **Calculate Elastic Plate Constant ($M$):** $$M = \\frac{\\pi^2 E}{12 (1 - \\nu^2)} = \\frac{\\pi^2 \\times 70,000.0\\text{ MPa}}{12 \\times 0.910} = \\frac{690,872.3}{10.920} = \\mathbf{63,266.695\\text{ MPa}}$$ 3. **Calculate Critical Compressive Buckling Stress ($\\sigma_{\\text{cr}}$):** $$\\sigma_{\\text{cr}} = K_c \\cdot M \\cdot \\left( \\frac{t}{b} \\right)^2$$ $$\\sigma_{\\text{cr}} = 4.00 \\times 63,266.695\\text{ MPa} \\times 0.000400$$ $$\\sigma_{\\text{cr}} = 253,066.78 \\times 0.000400 = \\mathbf{101.227\\text{ MPa} \\approx 101.2\\text{ MPa}}$$ Flawless Bryan thin plate critical buckling stress derivation!" },
        { "text": "\u03c3_cr = 25.3 MPa (Forgot factor of Kc = 4.00)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3_cr = 50.6 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3_cr = 202.5 MPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
