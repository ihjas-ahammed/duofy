# Duofy Reusable Lesson Format: Euler-Bernoulli Theory (Pure Bending and Flexure Formula)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Bending_Moments_and_Shear_Force`  
**Lesson Format Type:** `euler_bernoulli_beam_bending_theory_and_flexure_formula`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the kinematics of pure bending, normal flexural stress distribution, and section modulus optimization in structural beams (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 4; James M. Gere & Barry J. Goodno *Mechanics of Materials* Chapter 5): master the core assumptions of **Euler-Bernoulli Beam Theory** (*\"Plane sections perpendicular to the longitudinal axis remain plane and perpendicular after bending\"*, small deformations, linear elastic isotropic material), master the **Bending Strain Distribution ($\mathbf{\epsilon_x = -\frac{y}{\rho}}$)**, derive the unified **Euler-Bernoulli Beam Equation**:
$$\mathbf{\frac{M}{I} = \frac{\sigma}{y} = \frac{E}{R} \implies \sigma(y) = \frac{M y}{I}}$$
master the **Neutral Axis (NA)** (the geometric line where longitudinal strain and normal bending stress are identically zero, $\sigma = 0$, which must pass through the cross-section **Centroid** $\bar{y}$ for pure bending), master the **Section Modulus ($\mathbf{Z = \frac{I}{y_{\text{max}}}} \implies \mathbf{\sigma_{\text{max}} = \frac{M}{Z}}$)**, and compute moments of inertia ($I$) for rectangular, circular, and symmetric I-beam cross-sections.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler-Bernoulli Equation Formulation ($\frac{M}{I} = \frac{\sigma}{y} = \frac{E}{R}$) & Neutral Axis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of a Beam to Prevent Bending Failure Under a Given Moment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pure Bending Parameter / Geometric Section Property & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Geometric Axis in a Beam's Cross-Section Where the Normal Bending Stress Is Identically Zero Is the ___ Axis (Neutral) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Problem: Calculating the Maximum Bending Stress in a Rectangular Beam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Euler-Bernoulli Theory (Beer & Johnston 2020; Gere & Goodno 2018):
   - **The Euler-Bernoulli Master Equation:**
     $$\mathbf{\frac{M}{I} = \frac{\sigma}{y} = \frac{E}{\rho} \implies \mathbf{\sigma(y) = \frac{M y}{I} = \frac{M}{Z}} \quad \left(Z = \frac{I}{y_{\text{max}}}\right)}$$
   - **Cross-Sectional Geometries & Section Moduli Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Cross-Section Shape} & \textbf{Moment of Inertia } I & \textbf{Extreme Fiber } y_{\text{max}} & \textbf{Section Modulus } Z \\
     \hline
     \mathbf{\text{Solid Rectangle } (b \times h)} & \mathbf{I = \frac{b h^3}{12}} & y_{\text{max}} = \frac{h}{2} & \mathbf{Z = \frac{b h^2}{6}} \\
     \mathbf{\text{Solid Circle } (d)} & \mathbf{I = \frac{\pi d^4}{64}} & y_{\text{max}} = \frac{d}{2} & \mathbf{Z = \frac{\pi d^3}{32}} \\
     \mathbf{\text{Hollow Tube } (D, d)} & I = \frac{\pi (D^4 - d^4)}{64} & y_{\text{max}} = \frac{D}{2} & Z = \frac{\pi (D^4 - d^4)}{32 D} \\
     \hline
     \end{array}$$
   - **The Neutral Axis Invariant:** The Neutral Axis (NA) **ALWAYS passes through the centroid** of the cross-section in pure bending!
2. **Slide 2 (`ordering`):** Provide 5 steps of designing a beam for bending: (1) determine maximum applied bending moment $M_{\text{max}}$ from the BMD, (2) look up the material's allowable bending stress $\sigma_{\text{allowable}}$, (3) calculate the required minimum section modulus $Z_{\text{req}} = \frac{M_{\text{max}}}{\sigma_{\text{allowable}}}$, (4) select a standard cross-section profile (e.g. W-shape I-beam or rectangular timber) with $Z_{\text{actual}} \ge Z_{\text{req}}$, (5) verify that extreme fiber stresses $\sigma_{\text{top}}$ (compression) and $\sigma_{\text{bottom}}$ (tension) remain safely below allowable limits!
3. **Slide 3 (`matching`):** Pair 4 concepts (Neutral Axis, Section Modulus $Z$, Flexural Rigidity $EI$, Radius of Curvature $\rho$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Neutral. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating maximum bending stress: A rectangular timber beam of width $b = 100\text{ mm} = 0.1\text{ m}$ and height $h = 200\text{ mm} = 0.2\text{ m}$ is subjected to a maximum sagging bending moment of $M = 16\text{ kN}\cdot\text{m} = 16 \times 10^3\text{ N}\cdot\text{m}$. What is the maximum tensile normal bending stress $\sigma_{\text{max}}$ developed in the extreme bottom fiber of the beam? ($Z = \frac{b h^2}{6} = \frac{(0.1)(0.2)^2}{6} = \frac{0.1 \times 0.04}{6} = \frac{0.004}{6} = \frac{4}{6000}\text{ m}^3 = \frac{1}{1500}\text{ m}^3$; $\sigma_{\text{max}} = \frac{M}{Z} = \frac{16 \times 10^3}{\frac{1}{1500}} = (16 \times 10^3) \times 1500 = 24 \times 10^6\text{ Pa} = \mathbf{24\text{ MPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "euler_bernoulli_beam_bending_theory_and_flexure_formula",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Euler-Bernoulli Pure Bending Theory \\& Flexure Formula (Beer \\& Johnston)**\n• **The Unified Beam Equation:**\n$$\n\\mathbf{\\frac{M}{I} = \\frac{\\sigma}{y} = \\frac{E}{\\rho} \\implies \\mathbf{\\sigma(y) = \\frac{M y}{I} = \\frac{M}{Z}} \\quad \\left(Z = \\frac{I}{y_{\\text{max}}}\\right)}\n$$\n• **Cross-Sectional Geometries \\& Section Modulus Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Cross-Section Profile} & \\textbf{Second Moment of Area } I & \\textbf{Extreme Distance } y_{\\text{max}} & \\textbf{Section Modulus } Z \\\\\n\\hline\n\\mathbf{\\text{Solid Rectangle } (b \\times h)} & \\mathbf{I = \\frac{b h^3}{12}} & y_{\\text{max}} = \\frac{h}{2} & \\mathbf{Z = \\frac{b h^2}{6}} \\\\\n\\mathbf{\\text{Solid Circle } (d)} & \\mathbf{I = \\frac{\\pi d^4}{64}} & y_{\\text{max}} = \\frac{d}{2} & \\mathbf{Z = \\frac{\\pi d^3}{32}} \\\\\n\\mathbf{\\text{Standard I-Beam}} & \\text{Flanges dominate } I & y_{\\text{max}} = \\frac{d_{\\text{total}}}{2} & \\text{Maximum } Z \\text{ per unit weight!} \\\\\n\\hline\n\\end{array}\n$$\n• **The Neutral Axis Invariant:** The Neutral Axis (NA) **passes directly through the centroid** of the cross-section, where bending strain and normal stress are **identically zero ($\\mathbf{\\sigma = 0}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a structural beam against flexural bending failure.",
      "orderItems": [
        "Construct the Bending Moment Diagram (BMD) to locate the maximum absolute bending moment M_max",
        "Obtain the allowable normal bending stress (sigma_allow) for the chosen engineering material",
        "Calculate the required minimum section modulus using the relationship Z_req = M_max / sigma_allow",
        "Select a standard structural cross-section (e.g. wide-flange I-beam or rectangular section) with Z_actual >= Z_req",
        "Verify that extreme outer fiber stresses (sigma = M * y_max / I) satisfy allowable tension and compression design limits"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Pure Bending Property to its exact Physical Meaning.",
      "matchPairs": [
        { "left": "Neutral Axis (NA)", "right": "Centroidal plane in a bending beam where normal longitudinal strain and stress are identically zero" },
        { "left": "Section Modulus (Z)", "right": "Geometric cross-sectional property (I / y_max) measuring a beam's resistance to flexural bending" },
        { "left": "Flexural Rigidity (EI)", "right": "Product of Young's Modulus and Moment of Inertia measuring resistance to beam curvature (1 / rho)" },
        { "left": "Euler-Bernoulli Hypothesis", "right": "Assumption that plane sections perpendicular to the longitudinal axis remain plane and perpendicular after bending" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The line in a beam cross-section where normal bending stress is identically zero is the ___ axis.",
      "blankAnswer": "neutral",
      "blankDistractors": ["centroidal", "principal", "shear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular timber beam has width b = 100 mm and depth h = 200 mm. It is subjected to a maximum bending moment M = 16 kN·m. What is the maximum normal bending stress developed in the extreme outer fibers of the beam?",
      "options": [
        { "text": "sigma_max = 24 MPa", "isCorrect": true, "explanation": "Correct! Let's solve using the Flexure Formula and Section Modulus (Beer & Johnston *Mechanics of Materials* Chapter 4). 1. **Section Modulus $Z$ for a Rectangle ($b \\times h$):** $$Z = \\frac{b h^2}{6} = \\frac{(0.10\\text{ m})(0.20\\text{ m})^2}{6} = \\frac{(0.10)(0.04)}{6} = \\frac{0.004}{6} = \\frac{1}{1500}\\text{ m}^3$$ 2. **Maximum Flexural Bending Stress ($\\sigma_{\\text{max}}$):** $$\\sigma_{\\text{max}} = \\frac{M}{Z} = \\frac{16 \\times 10^3\\text{ N}\\cdot\\text{m}}{\\frac{1}{1500}\\text{ m}^3} = (16 \\times 10^3) \\times 1500 = 24,000,000\\text{ Pa} = \\mathbf{24\\text{ MPa}}$$ 3. **Stress Distribution:** - Top extreme fiber ($y = +100\\text{ mm}$): $\\sigma = -24\\text{ MPa}$ (Compression). - Neutral Axis ($y = 0\\text{ mm}$): $\\sigma = 0\\text{ MPa}$. - Bottom extreme fiber ($y = -100\\text{ mm}$): $\\sigma = +24\\text{ MPa}$ (Tension)!" },
        { "text": "sigma_max = 12 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "sigma_max = 48 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "sigma_max = 8 MPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
