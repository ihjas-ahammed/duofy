# Duofy Reusable Lesson Format: Journal Bearings (Hydrodynamics, Sommerfeld, & Film Thickness)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Bearing_Design_and_Lubrication`  
**Lesson Format Type:** `hydrodynamic_journal_bearings_sommerfeld_number_and_film_thickness`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through hydrodynamic fluid film generation, Reynolds 2D lubrication theory, and the dimensionless Sommerfeld number in sliding journal bearing design (Osborne Reynolds 1886; Arnold Sommerfeld 1904; Albert A. Raimondi & John Boyd 1958; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 12): master the **Hydrodynamic Wedge Action** (where a rotating shaft dragging viscous oil into a converging clearance gap generates high fluid pressures that float the journal without solid contact), master the **Dimensionless Sommerfeld Number ($\mathbf{S}$)**:
$$\mathbf{S = \left(\frac{R}{c}\right)^2 \frac{\mu N'}{P} = \left(\frac{D}{C_d}\right)^2 \frac{\mu N'}{P}}$$
where $R$ is journal radius, $c = R_{\text{bearing}} - R_{\text{journal}}$ is radial clearance, $\mu$ is dynamic viscosity ($\text{Pa}\cdot\text{s}$), $N'$ is rotational speed in **rev/s**, and $P = \frac{W}{L D}$ is projected unit bearing load ($\text{N/m}^2$); master the **Eccentricity Ratio ($\mathbf{\epsilon = \frac{e}{c}}$)** and calculate the **Minimum Oil Film Thickness ($\mathbf{h_0}$)**:
$$\mathbf{h_0 = c(1 - \epsilon) \ge 0.005\text{ mm} \quad \Big| \quad \mathbf{h_0 > 5(R_{a,\text{journal}} + R_{a,\text{bearing}})}}$$
(proving why minimum film thickness must exceed the combined surface roughness asperities to guarantee zero metal-to-metal wear).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sommerfeld Number ($S = (R/c)^2 \frac{\mu N'}{P}$) & Minimum Film Thickness ($h_0 = c(1-\epsilon)$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Sommerfeld Number and Oil Film Thickness for a Turbine Journal Bearing Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydrodynamic Journal Variable / Dimensionless Group & Technical Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Primary Dimensionless Number Governed by Geometry, Viscosity, Speed, and Load in Journal Bearing Design Is the ___ Number (Sommerfeld) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Tribological Design Problem: Calculating the Sommerfeld Number S for a High-Speed Steam Turbine Journal Bearing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Journal Bearings & Sommerfeld (Budynas 2020; Sommerfeld 1904; Raimondi-Boyd 1958):
   - **Sommerfeld Number Formulation:**
     $$\mathbf{S = \left(\frac{R}{c}\right)^2 \frac{\mu N'}{P} \quad \left(P = \frac{W}{L D}, \ N' = \frac{N_{\text{RPM}}}{60}\right)}$$
   - **Hydrodynamic Film Formulations:**
     $$\mathbf{h_0 = c (1 - \epsilon) \quad \Big| \quad \epsilon = \frac{e}{c} \quad (0 \le \epsilon < 1) \quad \Big| \quad \frac{h_0}{c} = 1 - \epsilon}$$
   - **Full Film Lubrication Criterion:**
     $$\mathbf{h_0 \ge 5(R_{a1} + R_{a2}) \approx 0.005\text{ mm} \ (5\text{ }\mu\text{m})}$$
   - **The Wedge Action Invariant:** Hydrodynamic pressure generation requires **1. Relative surface motion ($N' > 0$)**, **2. Viscous fluid ($\mu > 0$)**, and **3. A geometrically converging channel ($c > 0, e > 0$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of journal bearing analysis: (1) calculate projected bearing pressure $P = \frac{W}{L D}$ and convert shaft speed to rev/s ($N' = N/60$), (2) determine dynamic oil viscosity $\mu$ at operating bulk temperature, (3) calculate the dimensionless Sommerfeld number $S = (R/c)^2 \frac{\mu N'}{P}$, (4) use Raimondi-Boyd charts or analytical approximations to find the minimum film thickness ratio $h_0/c = 1 - \epsilon$, (5) compute absolute minimum film thickness $h_0 = c(1-\epsilon)$ and verify that $h_0$ safely clears the combined surface roughness threshold!
3. **Slide 3 (`matching`):** Pair 4 concepts (Sommerfeld Number $S$, Eccentricity Ratio $\epsilon$, Minimum Film Thickness $h_0$, Projected Pressure $P = W/LD$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Sommerfeld. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Sommerfeld number: A hydrodynamic journal bearing has journal diameter $D = 100\text{ mm}$ ($R = 50\text{ mm}$), bearing length $L = 100\text{ mm}$, and radial clearance $c = 0.05\text{ mm} = 50\text{ }\mu\text{m}$ (giving clearance ratio $R/c = 1000$). The bearing supports a radial load $W = 10,000\text{ N}$ at speed $N = 1800\text{ RPM}$ ($N' = 30\text{ rev/s}$) using lubricating oil of viscosity $\mu = 0.020\text{ Pa}\cdot\text{s}$. What is the Sommerfeld number $S$ of the bearing? ($P = \frac{W}{L D} = \frac{10,000\text{ N}}{(0.100\text{ m})(0.100\text{ m})} = \frac{10,000}{0.010} = 1.0 \times 10^6\text{ Pa} = 1.0\text{ MPa}$; $S = \left(\frac{R}{c}\right)^2 \frac{\mu N'}{P} = (1000)^2 \frac{(0.020\text{ Pa}\cdot\text{s})(30\text{ rev/s})}{1.0 \times 10^6\text{ Pa}} = (10^6) \frac{0.60}{10^6} = \mathbf{0.60}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hydrodynamic_journal_bearings_sommerfeld_number_and_film_thickness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hydrodynamic Journal Bearings \\& Sommerfeld Number (Arnold Sommerfeld)**\n• **The Master Dimensionless Sommerfeld Number Formulation:**\n$$\n\\mathbf{S = \\left(\\frac{R}{c}\\right)^2 \\frac{\\mu N'}{P} \\quad \\left(P = \\frac{W}{L D} = \\frac{W}{2 R L}, \\ N' = \\frac{N_{\\text{RPM}}}{60}\\right)}\n$$\n• **Hydrodynamic Film Geometry Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Film Parameter} & \\textbf{Symbol \\& Formulation} & \\textbf{Physical Definition} \\\\\n\\hline\n\\mathbf{\\text{Radial Clearance}} & \\mathbf{c = R_{\\text{bearing}} - R_{\\text{journal}}} & \\text{Total radial gap available for lubricant flow} \\\\\n\\mathbf{\\text{Eccentricity Ratio}} & \\mathbf{\\epsilon = e / c \\quad (0 \\le \\epsilon < 1)} & \\text{Normalized shaft displacement from center} \\\\\n\\mathbf{\\text{Min Film Thickness}} & \\mathbf{h_0 = c (1 - \\epsilon)} & \\mathbf{\\text{Thinnest fluid gap supporting hydrodynamic load}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Hydrodynamic Fluid Film Invariant:** Zero metal-to-metal contact is maintained as long as $\\mathbf{h_0 \\ge 5(R_{a1} + R_{a2}) \\approx 0.005\\text{ mm}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the hydrodynamic operating state and minimum film thickness of a journal bearing.",
      "orderItems": [
        "Compute the projected unit bearing pressure: P = W / (L * D) and convert shaft speed to rev/s (N' = N_RPM / 60)",
        "Determine the dynamic lubricant viscosity mu at the anticipated steady-state oil operating temperature",
        "Calculate the dimensionless Sommerfeld number: S = (R / c)^2 * (mu * N' / P)",
        "Use the Raimondi-Boyd charts to find the minimum film thickness ratio: h0 / c = 1 - epsilon",
        "Compute absolute minimum film thickness h0 = c*(1 - epsilon) and verify that h0 exceeds surface roughness limits"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hydrodynamic Journal Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Sommerfeld Number (S)", "right": "S = (R/c)^2 * (\u03bc*N' / P), the primary dimensionless design index governing journal performance" },
        { "left": "Minimum Film Thickness (h0)", "right": "h0 = c*(1 - \u03b5), the critical clearance preventing asperity contact and metal-to-metal wear" },
        { "left": "Eccentricity Ratio (\u03b5)", "right": "\u03b5 = e / c, measuring how far the shaft center is displaced toward the bearing wall under load" },
        { "left": "Projected Bearing Pressure (P)", "right": "P = W / (L * D), the average unit compressive pressure across the projected bearing area" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The primary dimensionless characteristic number in hydrodynamic journal bearing design is the ___ number.",
      "blankAnswer": "Sommerfeld",
      "blankDistractors": ["Reynolds", "Nusselt", "Prandtl"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A journal bearing has journal radius R = 50 mm, bearing length L = 100 mm, and radial clearance c = 0.05 mm (R/c = 1000). The bearing carries a radial load W = 10,000 N at shaft speed N = 1800 RPM (N' = 30 rev/s) with lubricating oil viscosity \u03bc = 0.020 Pa·s. What is the Sommerfeld number S of the bearing?",
      "options": [
        { "text": "S = 0.60 (Projected pressure P = 1.0 MPa, and S = (1000)^2 * (0.020 * 30) / 10^6 = 0.60)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Sommerfeld number equation (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 12). 1. **Calculate Projected Bearing Area and Unit Pressure ($P$):** - Diameter $D = 2 R = 2(50\\text{ mm}) = 100\\text{ mm} = 0.100\\text{ m}$. - Length $L = 100\\text{ mm} = 0.100\\text{ m}$. - Projected Pressure: $$P = \\frac{W}{L \\cdot D} = \\frac{10,000\\text{ N}}{(0.100\\text{ m})(0.100\\text{ m})} = \\frac{10,000\\text{ N}}{0.010\\text{ m}^2} = 1.0 \\times 10^6\\text{ Pa} = \\mathbf{1.0\\text{ MPa}}$$ 2. **Calculate Rotational Speed in Rev/s ($N'$):** $$N' = \\frac{1800\\text{ RPM}}{60} = \\mathbf{30\\text{ rev/s}}$$ 3. **Calculate Clearance Ratio ($\frac{R}{c}$):** $$\\frac{R}{c} = \\frac{50\\text{ mm}}{0.05\\text{ mm}} = \\mathbf{1000}$$ 4. **Evaluate the Sommerfeld Number ($S$):** $$S = \\left(\\frac{R}{c}\\right)^2 \\frac{\\mu N'}{P} = (1000)^2 \\frac{(0.020\\text{ Pa}\\cdot\\text{s})(30\\text{ rev/s})}{1.0 \\times 10^6\\text{ Pa}} = (10^6) \\frac{0.60}{10^6} = \\mathbf{0.60}$$ 5. **Physical Significance:** $S = 0.60$ is a classic design operating point located well within the stable full-fluid-film hydrodynamic lubrication regime!" },
        { "text": "S = 0.30", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "S = 1.20", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "S = 6.00", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
