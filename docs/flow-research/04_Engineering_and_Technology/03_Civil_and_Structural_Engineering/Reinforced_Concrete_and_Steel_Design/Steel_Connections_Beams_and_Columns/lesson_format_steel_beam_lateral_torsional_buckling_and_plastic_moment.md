# Duofy Reusable Lesson Format: Steel Beams (Lateral-Torsional Buckling & Plastic Moment)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Steel_Connections_Beams_and_Columns`  
**Lesson Format Type:** `steel_beam_lateral_torsional_buckling_and_plastic_moment`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the flexural design of structural steel I-beams and wide-flange girders per AISC 360-16 Chapter F, plastic section modulus ($Z_x$), plastic moment capacity ($M_p = F_y Z_x$), unbraced length of the compression flange ($L_b$), limiting lengths ($L_p, L_r$), Lateral-Torsional Buckling ($\text{LTB}$) regimes (Plastic Yielding, Inelastic LTB, Elastic LTB), and the moment gradient modifier factor ($C_b$) (William T. Segui *Steel Design* 6th ed. Chapter 5; AISC 360-16 Section F2): formulate the **Plastic Moment Capacity ($M_p$)**:
$$\mathbf{M_p = F_y Z_x \quad (\text{Shape Factor } \xi = Z_x / S_x \approx 1.10 - 1.15 \text{ for W-Shapes})}$$
derive the **Three AISC Lateral-Torsional Buckling Regimes**:
1. **Zone 1: Plastic Yielding ($\mathbf{L_b \le L_p = 1.76 r_y \sqrt{\frac{E}{F_y}}}$):**
   - Full plastic hinge develops across the entire cross-section:
     $$\mathbf{M_n = M_p = F_y Z_x}$$
2. **Zone 2: Inelastic Lateral-Torsional Buckling ($\mathbf{L_p < L_b \le L_r}$):**
   - Compression flange yields partially and buckles laterally with twisting:
     $$\mathbf{M_n = C_b \left[ M_p - \left( M_p - 0.7 F_y S_x \right) \left( \frac{L_b - L_p}{L_r - L_p} \right) \right] \le M_p}$$
3. **Zone 3: Elastic Lateral-Torsional Buckling ($\mathbf{L_b > L_r}$):**
   - Beam buckles elastically prior to reaching yield stress ($M_n = F_{cr} S_x \le M_p$);
derive the **Design Moment Capacity ($\phi_b M_n$)**:
$$\mathbf{\phi_b M_n \ge M_u \quad (\text{Flexural Resistance Factor } \phi_b = 0.90)}$$
(proving how continuous floor slab attachment enforces $L_b = 0$, guaranteeing that steel floor beams achieve their maximum plastic capacity $M_p$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Plastic Moment ($M_p = F_y Z_x$), 3 LTB Zones ($L_p, L_r$), $C_b$ Factor & $\phi_b = 0.90$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Design Flexural Strength \phi_b Mn of a Steel Beam Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beam Flexural Zone / Parameter & Technical Structural Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | When the Unbraced Length $L_b$ Is Less Than or Equal to $L_p$, the Nominal Flexural Strength Equals the Full ___ Moment $M_p$ (Plastic) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Bridge Girder Problem: Calculating Inelastic LTB Nominal Moment Capacity M_n for a W-Shape Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Steel Beam Flexure & LTB (Segui 2018; AISC 360-16):
   - **Beam Flexural Capacity Formulations:**
     $$\mathbf{M_p = F_y Z_x \quad \Big| \quad L_p = 1.76 r_y \sqrt{\frac{E}{F_y}} \quad \Big| \quad M_n = C_b \left[ M_p - (M_p - 0.7 F_y S_x)\frac{L_b - L_p}{L_r - L_p} \right] \le M_p \quad \Big| \quad \phi_b = 0.90}$$
   - **AISC Beam LTB Zones Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Flexural Zone} & \textbf{Unbraced Length } L_b & \textbf{Nominal Capacity } M_n & \textbf{Physical Failure Mode} \\
     \hline
     \mathbf{\text{Zone 1 (Plastic)}} & \mathbf{L_b \le L_p} & \mathbf{M_n = M_p = F_y Z_x} & \mathbf{\text{Full plastic hinge formation (no buckling)}} \\
     \mathbf{\text{Zone 2 (Inelastic LTB)}} & \mathbf{L_p < L_b \le L_r} & \mathbf{M_n = C_b [M_p - \Delta M \frac{L_b-L_p}{L_r-L_p}] \le M_p} & \mathbf{\text{Flange yielding + lateral twisting buckling}} \\
     \mathbf{\text{Zone 3 (Elastic LTB)}} & L_b > L_r & M_n = F_{cr} S_x \le M_p & \text{Pure elastic torsional instability} \\
     \hline
     \end{array}$$
   - **The $C_b$ Upper Cap Invariant:** The moment gradient modifier $C_b$ accounts for non-uniform bending moments, but the calculated nominal strength $M_n$ **can NEVER exceed the plastic moment $M_p$ ($M_n \le M_p$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of beam flexural design: (1) extract steel shape properties ($Z_x, S_x, r_y, L_p, L_r$), (2) compute plastic moment capacity $M_p = F_y Z_x$, (3) compare compression flange unbraced length $L_b$ against $L_p$ and $L_r$, (4) compute moment gradient factor $C_b$ and evaluate nominal moment $M_n$ for the appropriate zone, (5) apply $\phi_b = 0.90$ to verify $\phi_b M_n \ge M_u$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Zone 1 Plastic Moment $F_y Z_x$, Zone 2 Inelastic LTB, Moment Gradient Factor $C_b$, Plastic Section Modulus $Z_x$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Plastic. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Inelastic LTB capacity: A W18x50 steel beam ($F_y = 50\text{ ksi} \approx 345\text{ MPa}$) has plastic section modulus $Z_x = 101\text{ in}^3$ and elastic modulus $S_x = 88.9\text{ in}^3$. Limiting lengths are $L_p = 5.80\text{ ft}$ and $L_r = 17.0\text{ ft}$. The beam has unbraced length $L_b = 11.4\text{ ft}$ (Zone 2) with uniform moment ($C_b = 1.0$). Plastic moment $M_p = 50 \times 101 / 12 = 420.83\text{ ft-kips}$. Residual limit $0.7 F_y S_x = 0.7 \times 50 \times 88.9 / 12 = 259.29\text{ ft-kips}$. What is the nominal flexural capacity $M_n$ and design capacity $\phi_b M_n$ ($\phi_b = 0.90$)? (Linear interpolation factor $= \frac{L_b - L_p}{L_r - L_p} = \frac{11.4 - 5.80}{17.0 - 5.80} = \frac{5.60}{11.20} = \mathbf{0.50}$; $M_n = 420.83 - (420.83 - 259.29) \times (0.50) = 420.83 - (161.54) \times 0.50 = 420.83 - 80.77 = \mathbf{340.06\text{ ft-kips} \approx 340.1\text{ ft-kips}}$; $\phi_b M_n = 0.90 \times 340.06 = \mathbf{306.05\text{ ft-kips} \approx 306.1\text{ ft-kips}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "steel_beam_lateral_torsional_buckling_and_plastic_moment",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Steel Beam Flexure \\& Lateral-Torsional Buckling (AISC 360-16)**\n• **Plastic Moment Capacity Formulation:**\n$$\n\\mathbf{M_p = F_y Z_x \\quad (Z_x = \\text{Plastic Section Modulus})}\n$$\n• **The 3 AISC Lateral-Torsional Buckling (LTB) Zones:**\n  - **Zone 1: Plastic Yielding ($\\mathbf{L_b \\le L_p}$):**\n$$\n\\mathbf{M_n = M_p = F_y Z_x \\quad \\left(L_p = 1.76 r_y \\sqrt{\\frac{E}{F_y}}\\right)}\n$$\n  - **Zone 2: Inelastic LTB ($\\mathbf{L_p < L_b \\le L_r}$):**\n$$\n\\mathbf{M_n = C_b \\left[ M_p - \\left( M_p - 0.7 F_y S_x \\right) \\left( \\frac{L_b - L_p}{L_r - L_p} \\right) \\right] \\le M_p}\n$$\n  - **Zone 3: Elastic LTB ($\\mathbf{L_b > L_r}$):** $M_n = F_{cr} S_x \\le M_p$;\n• **Design Flexural Strength:** $\\mathbf{\\phi_b M_n = 0.90 M_n \\ge M_u}$\n• **The Continuous Bracing Invariant:** Attaching a concrete floor slab directly to the top compression flange enforces **$L_b = 0 \\le L_p$**, completely eliminating LTB and guaranteeing full plastic moment capacity $M_p$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the nominal and design flexural capacity of a structural steel I-beam per AISC 360-16.",
      "orderItems": [
        "Extract cross-sectional properties (Zx, Sx, ry, Lp, Lr) from the AISC Steel Construction Manual for the chosen W-shape",
        "Calculate the full plastic moment capacity: Mp = Fy * Zx",
        "Compare the unbraced length of the compression flange (Lb) against the limiting lengths Lp and Lr",
        "Determine the moment gradient factor Cb based on the shape of the bending moment diagram between brace points",
        "Calculate nominal flexural strength Mn for the active LTB zone (capped at Mp) and apply \u03c6b = 0.90 to obtain \u03c6bMn"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Beam Flexural Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Zone 1 (Lb \u2264 Lp)", "right": "Plastic plateau where the section develops a full plastic hinge (Mn = Mp = Fy*Zx) with zero buckling" },
        { "left": "Zone 2 (Lp < Lb \u2264 Lr)", "right": "Inelastic LTB zone where capacity decreases linearly as unbraced compression flange length increases" },
        { "left": "Moment Gradient Factor (Cb)", "right": "Multiplier accounting for non-uniform bending moments that increases LTB resistance (Cb = 1.0 for uniform moment)" },
        { "left": "Plastic Section Modulus (Zx)", "right": "First moment of area about equal-area plastic neutral axis governing full cross-section yielding" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When the unbraced length Lb of a steel beam is less than or equal to Lp, the nominal flexural strength equals the full ___ moment Mp.",
      "blankAnswer": "plastic",
      "blankDistractors": ["elastic", "residual", "buckling"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A W18x50 beam (Fy = 50 ksi, Zx = 101 in^3, Sx = 88.9 in^3, Lp = 5.80 ft, Lr = 17.0 ft) has unbraced length Lb = 11.4 ft (Zone 2) and uniform moment (Cb = 1.0). Plastic moment is Mp = 420.8 ft-kips and 0.7*Fy*Sx = 259.3 ft-kips. What is the nominal capacity Mn and design capacity \u03c6b Mn (\u03c6b = 0.90)?",
      "options": [
        { "text": "Mn = 340.1 ft-kips and \u03c6b Mn = 306.1 ft-kips (Interpolation factor = (11.4 - 5.8) / (17.0 - 5.8) = 5.6 / 11.2 = 0.50; Mn = 420.8 - (420.8 - 259.3)*0.50 = 420.8 - 80.75 = 340.05 ft-kips; \u03c6b Mn = 0.90 * 340.05 = 306.05 ft-kips)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using AISC 360-16 Chapter F Lateral-Torsional Buckling formulas (William T. Segui *Steel Design* Chapter 5). 1. **Identify the Active LTB Zone:** - Limiting lengths: $L_p = 5.80\\text{ ft}, \\quad L_r = 17.0\\text{ ft}$. - Actual unbraced length: $L_b = 11.40\\text{ ft}$. - Since $L_p = 5.80 < L_b = 11.40 \\le L_r = 17.0$, the beam operates in **Zone 2: Inelastic Lateral-Torsional Buckling**! 2. **Calculate the Linear Interpolation Length Ratio:** $$\\frac{L_b - L_p}{L_r - L_p} = \\frac{11.40\\text{ ft} - 5.80\\text{ ft}}{17.00\\text{ ft} - 5.80\\text{ ft}} = \\frac{5.60\\text{ ft}}{11.20\\text{ ft}} = \\mathbf{0.5000}$$ 3. **Calculate Nominal Moment Capacity ($M_n$):** - Moment capacity difference: $$M_p - 0.7 F_y S_x = 420.83\\text{ ft-kips} - 259.29\\text{ ft-kips} = \\mathbf{161.54\\text{ ft-kips}}$$ - Inelastic LTB formula (with $C_b = 1.0$): $$M_n = C_b \\left[ M_p - (M_p - 0.7 F_y S_x) \\left(\\frac{L_b - L_p}{L_r - L_p}\\right) \\right]$$ $$M_n = 1.0 \\times [420.83 - 161.54 \\times 0.5000] = 420.83 - 80.77 = \\mathbf{340.06\\text{ ft-kips} \\approx 340.1\\text{ ft-kips}}$$ - Verify upper cap: $M_n = 340.1 \\le M_p = 420.8\\text{ ft-kips}$ (Valid!). 4. **Calculate Design Flexural Capacity ($\\phi_b M_n$):** $$\\phi_b M_n = 0.90 \\times 340.06\\text{ ft-kips} = \\mathbf{306.05\\text{ ft-kips} \\approx 306.1\\text{ ft-kips}}$$ Flawless AISC steel beam LTB analysis!" },
        { "text": "Mn = 420.8 ft-kips and \u03c6b Mn = 378.7 ft-kips (Ignored LTB)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Mn = 259.3 ft-kips and \u03c6b Mn = 233.4 ft-kips", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Mn = 340.1 ft-kips and \u03c6b Mn = 340.1 ft-kips (Forgot \u03c6b factor)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
