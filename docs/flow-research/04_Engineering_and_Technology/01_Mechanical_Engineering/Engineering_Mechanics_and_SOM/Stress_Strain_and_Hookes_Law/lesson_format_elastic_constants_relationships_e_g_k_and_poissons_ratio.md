# Duofy Reusable Lesson Format: Elastic Constants (E, G, K, and Poisson's Ratio)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Stress_Strain_and_Hookes_Law`  
**Lesson Format Type:** `elastic_constants_relationships_e_g_k_and_poissons_ratio`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through multi-axial elasticity, volumetric dilatation, Poisson contraction, and the mathematical unification of isotropic elastic constants (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 2; James M. Gere & Barry J. Goodno *Mechanics of Materials* Chapter 7): master **Poisson's Ratio ($\mathbf{\nu = -\frac{\epsilon_{\text{lateral}}}{\epsilon_{\text{longitudinal}}}}$)**, master **Generalized 3D Hooke's Law for Isotropic Materials** ($\mathbf{\epsilon_x = \frac{1}{E}[\sigma_x - \nu(\sigma_y + \sigma_z)]}$), master **Volumetric Strain (Dilatation $\mathbf{e = \frac{\Delta V}{V} = \epsilon_x + \epsilon_y + \epsilon_z = \frac{\sigma_x + \sigma_y + \sigma_z}{3K}}$)**, and master the **4 Fundamental Elastic Constants Interrelationships**:
$$\mathbf{E = 2G(1 + \nu) = 3K(1 - 2\nu) = \frac{9KG}{3K + G} \quad \Big| \quad \nu = \frac{3K - 2G}{6K + 2G}}$$
proving why only **two elastic constants are independent** for any homogeneous isotropic material, and analyzing theoretical bounds ($0 \le \nu \le 0.5$, where $\nu = 0.5$ represents incompressible materials with infinite Bulk Modulus $K \to \infty$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 4 Elastic Constants Interrelationships Formula Matrix ($E, G, K, \nu$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Derivation and Calculation of G and K Given E and $\nu$ Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Elastic Constant / Multi-Axial Strain Parameter & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Negative Ratio of Transverse Lateral Strain to Axial Longitudinal Strain Is ___ Ratio (Poisson's) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Elasticity Problem: Calculating Shear Modulus G and Bulk Modulus K for Structural Steel Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Elastic Constants (Beer & Johnston 2020; Gere & Goodno 2018):
   - **Elastic Constants Unification Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Elastic Constant} & \textbf{Symbol} & \textbf{Physical Meaning} & \textbf{Governing Relationship} \\
     \hline
     \mathbf{\text{Young's Modulus}} & \mathbf{E} & \text{Tensile / Compressive Stiffness} & \mathbf{E = 2G(1+\nu) = 3K(1-2\nu)} \\
     \mathbf{\text{Shear Modulus (Rigidity)}} & \mathbf{G} & \text{Resistance to Shear Angular Distortion} & \mathbf{G = \frac{E}{2(1+\nu)}} \\
     \mathbf{\text{Bulk Modulus}} & \mathbf{K} & \text{Resistance to Uniform Hydrostatic Compression} & \mathbf{K = \frac{E}{3(1-2\nu)}} \\
     \mathbf{\text{Poisson's Ratio}} & \mathbf{\nu} & \text{Lateral Contraction vs Axial Strain} & \mathbf{\nu = \frac{3K - 2G}{6K + 2G} \ (0 \le \nu \le 0.5)} \\
     \hline
     \end{array}$$
   - **The Incompressibility Invariant:** If $\nu = 0.5 \implies (1 - 2\nu) = 0 \implies K \to \infty$ (Volume change $\frac{\Delta V}{V} = 0$, completely incompressible!).
2. **Slide 2 (`ordering`):** Provide 5 steps of calculating $G$ and $K$: (1) obtain experimentally measured Young's modulus $E$ and Poisson's ratio $\nu$, (2) apply formula $G = \frac{E}{2(1+\nu)}$ to compute the Shear Modulus, (3) apply formula $K = \frac{E}{3(1-2\nu)}$ to compute the Bulk Modulus, (4) evaluate volumetric strain under hydrostatic pressure $p$ via $e = \frac{\Delta V}{V} = -\frac{p}{K}$, (5) verify consistency using the composite relation $E = \frac{9KG}{3K+G}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Young's Modulus $E$, Shear Modulus $G$, Bulk Modulus $K$, Poisson's Ratio $\nu$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Poisson's. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing $G$ and $K$: A structural titanium alloy has a Modulus of Elasticity $E = 120\text{ GPa}$ and a Poisson's ratio $\nu = 0.25$. What are its Shear Modulus $G$ and Bulk Modulus $K$? ($G = \frac{E}{2(1+\nu)} = \frac{120}{2(1 + 0.25)} = \frac{120}{2.5} = \mathbf{48\text{ GPa}}$; $K = \frac{E}{3(1 - 2\nu)} = \frac{120}{3(1 - 2(0.25))} = \frac{120}{3(0.5)} = \frac{120}{1.5} = \mathbf{80\text{ GPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "elastic_constants_relationships_e_g_k_and_poissons_ratio",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Isotropic Elastic Constants Unification (Beer \\& Johnston)**\n• **The 4 Elastic Constants Formulation Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Elastic Property} & \\textbf{Symbol} & \\textbf{Physical Significance} & \\textbf{Mathematical Relationship} \\\\\n\\hline\n\\mathbf{\\text{Young's Modulus}} & \\mathbf{E} & \\text{Axial tensile/compressive stiffness} & \\mathbf{E = 2G(1+\\nu) = 3K(1-2\\nu)} \\\\\n\\mathbf{\\text{Shear Modulus (Rigidity)}} & \\mathbf{G} & \\text{Resistance to angular shear distortion} & \\mathbf{G = \\frac{E}{2(1+\\nu)}} \\\\\n\\mathbf{\\text{Bulk Modulus}} & \\mathbf{K} & \\text{Resistance to uniform hydrostatic pressure} & \\mathbf{K = \\frac{E}{3(1-2\\nu)}} \\\\\n\\mathbf{\\text{Poisson's Ratio}} & \\mathbf{\\nu} & \\text{Transverse contraction / Longitudinal strain} & \\mathbf{\\nu = \\frac{3K - 2G}{6K + 2G}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Two-Constant Theorem:** For any homogeneous isotropic linear elastic solid, **EXACTLY TWO elastic constants are independent**; all others can be mathematically derived!\n• **The Incompressibility Boundary:** When $\\mathbf{\\nu = 0.5}$, $(1 - 2\\nu) = 0 \\implies \\mathbf{K \\to \\infty}$ (zero volumetric change under pressure)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to compute the Shear Modulus G, Bulk Modulus K, and Volumetric Strain e for a material given E and nu.",
      "orderItems": [
        "Obtain the experimentally measured Young's Modulus E and Poisson's ratio nu from a standard tensile test",
        "Compute the Shear Modulus (Modulus of Rigidity) using the relationship G = E / (2 * (1 + nu))",
        "Compute the Bulk Modulus using the hydrostatic relationship K = E / (3 * (1 - 2 * nu))",
        "Calculate the volumetric dilatation under triaxial stress using e = delta V / V = (sigma_x + sigma_y + sigma_z) / (3 * K)",
        "Verify internal consistency across all four constants using the unified master relation: E = (9 * K * G) / (3 * K + G)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Elastic Constant to its exact Mechanical Definition.",
      "matchPairs": [
        { "left": "Poisson's Ratio (\u03bd)", "right": "Negative ratio of lateral transverse strain to axial longitudinal strain (-epsilon_lat / epsilon_long)" },
        { "left": "Bulk Modulus (K)", "right": "Ratio of uniform hydrostatic pressure to volumetric dilatation (p / (delta V / V))" },
        { "left": "Shear Modulus (G)", "right": "Ratio of shear stress to angular shear strain (tau / gamma) governing shaft torsion" },
        { "left": "Volumetric Strain (e)", "right": "Fractional volume change equal to the sum of normal strains (epsilon_x + epsilon_y + epsilon_z)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ratio of transverse lateral strain to longitudinal axial strain in an axially loaded bar is ___'s ratio.",
      "blankAnswer": "Poisson",
      "blankDistractors": ["Young", "Hooke", "Mohr"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A structural titanium alloy has a Modulus of Elasticity E = 120 GPa and a Poisson's ratio \u03bd = 0.25. What are its Shear Modulus G and Bulk Modulus K?",
      "options": [
        { "text": "G = 48 GPa and K = 80 GPa", "isCorrect": true, "explanation": "Correct! Let's solve using the fundamental elasticity relationships (Beer & Johnston *Mechanics of Materials* Chapter 2). 1. **Shear Modulus $G$:** $$G = \\frac{E}{2(1 + \\nu)} = \\frac{120\\text{ GPa}}{2(1 + 0.25)} = \\frac{120}{2(1.25)} = \\frac{120}{2.5} = \\mathbf{48\\text{ GPa}}$$ 2. **Bulk Modulus $K$:** $$K = \\frac{E}{3(1 - 2\\nu)} = \\frac{120\\text{ GPa}}{3(1 - 2(0.25))} = \\frac{120}{3(1 - 0.50)} = \\frac{120}{3(0.50)} = \\frac{120}{1.5} = \\mathbf{80\\text{ GPa}}$$ 3. **Consistency Check ($E = \\frac{9KG}{3K + G}$):** $$E = \\frac{9(80)(48)}{3(80) + 48} = \\frac{34560}{240 + 48} = \\frac{34560}{288} = 120\\text{ GPa}$$ Everything matches with absolute mathematical precision!" },
        { "text": "G = 60 GPa and K = 60 GPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "G = 30 GPa and K = 150 GPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "G = 96 GPa and K = 120 GPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
