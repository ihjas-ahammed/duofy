# Duofy Reusable Lesson Format: Rolling Bearings (L10 Fatigue Life & Load Ratings)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Bearing_Design_and_Lubrication`  
**Lesson Format Type:** `rolling_element_bearings_l10_life_and_dynamic_load_ratings`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through anti-friction rolling bearing mechanics, subsurface contact fatigue flaking, and catalog life prediction models in mechanical machine design (ISO 281; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 11; Robert L. Norton Chapter 14): master the **Basic Rating Life ($\mathbf{L_{10}}$)** defined as the life in millions of revolutions that $90\%$ of a group of identical bearings will complete or exceed before the first evidence of fatigue spalling:
$$\mathbf{L_{10} = \left(\frac{C}{P}\right)^p \ [\text{Million Revolutions}] \quad \Longleftrightarrow \quad \mathbf{L_{10h} = \frac{10^6}{60 N} \left(\frac{C}{P}\right)^p \ [\text{Operating Hours}]}}$$
where $C$ is the Dynamic Basic Load Rating, $P$ is the Equivalent Dynamic Radial Load, and the life exponent is **$\mathbf{p = 3}$ for Ball Bearings** (elliptical point contact) and **$\mathbf{p = \frac{10}{3} \approx 3.333}$ for Roller Bearings** (rectangular line contact); master the **Equivalent Dynamic Load Formulation**:
$$\mathbf{P = X \cdot V \cdot F_r + Y \cdot F_a}$$
where $V = 1.0$ for inner ring rotation and $V = 1.2$ for outer ring rotation, and calculate the **Catalog Capacity Sizing Formula ($\mathbf{C_{\text{req}} = P (L_{10})^{1/p}}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $L_{10}$ Life Equation ($L_{10} = (C/P)^p$), Ball ($p=3$) vs Roller ($p=10/3$) & Equivalent Load Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Catalog Selection for a Deep-Groove Ball Bearing Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bearing Characteristic / Rating Parameter & Technical Statistical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Life Exponent p in the L10 Life Equation L10 = (C/P)^p for Ball Bearings Is Exactly ___ (3 / Three) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Machinery Problem: Calculating the L10h Operating Life of an Electric Motor Ball Bearing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Rolling Bearings & $L_{10}$ (Budynas 2020; ISO 281):
   - **$L_{10}$ Rating Life Formulations:**
     $$\mathbf{L_{10} = \left(\frac{C}{P}\right)^p \ [\text{Million Revs}] \quad \Big| \quad L_{10h} = \frac{10^6}{60 N} \left(\frac{C}{P}\right)^p \ [\text{Hours}]}$$
   - **Life Exponent Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Bearing Element Type} & \textbf{Contact Geometry} & \textbf{Life Exponent } p & \textbf{Load Distribution} \\
     \hline
     \mathbf{\text{Ball Bearings}} & \text{Point Contact (Elliptical Hertz)} & \mathbf{p = 3.0} & \text{High speed, moderate radial/thrust} \\
     \mathbf{\text{Roller Bearings}} & \text{Line Contact (Rectangular Hertz)} & \mathbf{p = \frac{10}{3} \approx 3.333} & \mathbf{\text{Heavy shock \\& severe radial loads}} \\
     \hline
     \end{array}$$
   - **Equivalent Load Invariant:** $\mathbf{P = X V F_r + Y F_a}$ (combines radial and axial thrust loads into a single statistically equivalent radial load!).
2. **Slide 2 (`ordering`):** Provide 5 steps of bearing selection: (1) determine shaft rotational speed $N$ (RPM) and target design lifespan $L_h$ (e.g. $20,000\text{ hours}$), (2) calculate total revolution rating $L_{10} = \frac{60 N L_h}{10^6}$ million revolutions, (3) resolve applied radial force $F_r$ and axial thrust $F_a$ into equivalent dynamic load $P = X V F_r + Y F_a$, (4) compute required basic dynamic load rating $C_{\text{req}} = P (L_{10})^{1/p}$ ($p=3$ for ball), (5) select a standard deep-groove or angular contact bearing from catalog tables whose rating $C \ge C_{\text{req}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts ($L_{10}$ Rating Life, Basic Dynamic Rating $C$, Equivalent Load $P$, Roller Exponent $p=10/3$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 3 (or Three). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $L_{10h}$ operating life: A deep-groove ball bearing ($p = 3$) has a dynamic load rating $C = 24.0\text{ kN}$. It operates at $N = 1500\text{ RPM}$ under a steady equivalent radial load $P = 6.0\text{ kN}$. What is the rated $L_{10h}$ fatigue life of the bearing in operating hours? ($L_{10} = \left(\frac{C}{P}\right)^3 = \left(\frac{24.0\text{ kN}}{6.0\text{ kN}}\right)^3 = (4)^3 = \mathbf{64.0\text{ million revolutions}}$; $L_{10h} = \frac{10^6 \times L_{10}}{60 \times N} = \frac{10^6 \times 64}{60 \times 1500} = \frac{64,000,000}{90,000} \approx \mathbf{711.11\text{ hours}}$ (or $\approx 711\text{ hours}$)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rolling_element_bearings_l10_life_and_dynamic_load_ratings",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Rolling Bearing L10 Fatigue Life \\& Dynamic Rating (Shigley \\& ISO 281)**\n• **Master L10 Rating Life Formulations:**\n$$\n\\mathbf{L_{10} = \\left(\\frac{C}{P}\\right)^p \\ [\\text{Million Revolutions}] \\quad \\Longleftrightarrow \\quad \\mathbf{L_{10h} = \\frac{10^6}{60 N} \\left(\\frac{C}{P}\\right)^p \\ [\\text{Operating Hours}]}}\n$$\n• **The Life Exponent Matrix:**\n$$\n\\begin{array}{|l|l|c|l|}\n\\hline\n\\textbf{Bearing Element} & \\textbf{Hertz Contact Mode} & \\textbf{Exponent } p & \\textbf{Typical Application} \\\\\n\\hline\n\\mathbf{\\text{Ball Bearings}} & \\text{Point Contact (Elliptical)} & \\mathbf{p = 3.0} & \\text{High speed, low-to-medium loads} \\\\\n\\mathbf{\\text{Roller Bearings}} & \\text{Line Contact (Rectangular)} & \\mathbf{p = \\frac{10}{3} \\approx 3.333} & \\text{Heavy shock \\& industrial gearboxes} \\\\\n\\hline\n\\end{array}\n$$\n• **Equivalent Dynamic Load Formulation:**\n$$\n\\mathbf{P = X \\cdot V \\cdot F_r + Y \\cdot F_a \\quad (V = 1.0 \\text{ for inner ring rotation, } V = 1.2 \\text{ for outer ring rotation})}\n$$\n• **The Statistical Invariant:** $L_{10}$ represents the operating duration that **90\\% of identical bearings will survive** without subsurface fatigue flaking!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to select a catalog rolling-element bearing for a specified machine operating lifespan.",
      "orderItems": [
        "Record the shaft rotational speed N (RPM) and desired machine design operating life in hours (L_10h)",
        "Compute the total required life in millions of revolutions: L_10 = (60 * N * L_10h) / 10^6",
        "Determine the radial force Fr and axial thrust Fa to evaluate equivalent dynamic load P = X*V*Fr + Y*Fa",
        "Calculate the required basic dynamic load rating: C_req = P * (L_10)^(1/p) where p = 3 for ball bearings",
        "Select a standard catalog bearing whose rated dynamic capacity C exceeds the required threshold (C >= C_req)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Rolling Bearing Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Basic Dynamic Load Rating (C)", "right": "Radial load that a group of identical bearings can endure for exactly 1 million revolutions with 90% reliability" },
        { "left": "L10 Rating Life", "right": "Operating life exceeded by 90% of a bearing population before initial material fatigue spalling" },
        { "left": "Ball Bearing Life Exponent (p = 3)", "right": "Exponent derived from point-contact subsurface shear stress fatigue under cyclic rolling" },
        { "left": "Roller Bearing Exponent (p = 10/3)", "right": "Exponent derived from line-contact Hertzian stress field fatigue across cylindrical rollers" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The life exponent p in the L10 fatigue life equation L10 = (C/P)^p for ball bearings is exactly ___.",
      "blankAnswer": "3",
      "blankDistractors": ["2", "4", "10/3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A deep-groove ball bearing (p = 3) has dynamic load rating C = 24.0 kN. It operates at N = 1500 RPM under a steady equivalent radial load P = 6.0 kN. What is the rated L10h fatigue life of the bearing in operating hours?",
      "options": [
        { "text": "L10h = 711.1 hours (L10 = (24/6)^3 = 64 million revs, and L10h = 10^6 * 64 / (60 * 1500) = 711.1 hours)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the ISO / Shigley bearing life formula (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 11). 1. **Calculate Life in Millions of Revolutions ($L_{10}$):** $$L_{10} = \\left(\\frac{C}{P}\\right)^p = \\left(\\frac{24.0\\text{ kN}}{6.0\\text{ kN}}\\right)^3 = (4.0)^3 = \\mathbf{64.0\\text{ million revolutions}}$$ 2. **Convert to Operating Hours ($L_{10h}$):** $$L_{10h} = \\frac{10^6 \\times L_{10}}{60 \\times N} = \\frac{10^6 \\times 64.0}{60 \\times 1500\\text{ RPM}} = \\frac{64,000,000}{90,000} \\approx \\mathbf{711.11\\text{ hours} \\approx 711.1\\text{ hours}}$$ 3. **Engineering Takeaway:** Because life scales with the **cube of the load ratio ($C/P$)^3**, doubling the applied load ($6\\text{ kN} \\to 12\\text{ kN}$) cuts bearing operating life by **an enormous factor of 8 ($711\\text{ hrs} \\to 89\\text{ hrs}$)**!" },
        { "text": "L10h = 177.8 hours", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L10h = 2844.4 hours", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L10h = 1000.0 hours", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
