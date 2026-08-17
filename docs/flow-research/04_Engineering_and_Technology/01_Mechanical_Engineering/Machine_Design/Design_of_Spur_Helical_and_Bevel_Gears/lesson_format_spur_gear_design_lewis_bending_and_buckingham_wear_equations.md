# Duofy Reusable Lesson Format: Spur Gear Sizing (Lewis Bending & Buckingham Wear)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Spur_Helical_and_Bevel_Gears`  
**Lesson Format Type:** `spur_gear_design_lewis_bending_and_buckingham_wear_equations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through spur gear mechanical stress analysis, cantilever tooth beam modeling, and surface durability sizing against contact fatigue pitting (Wilfred Lewis 1892; Earle Buckingham 1949; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 14; ANSI/AGMA 2001-D04): master the **Lewis Beam Bending Strength Equation**:
$$\mathbf{\sigma_b = \frac{W_t}{b \cdot m \cdot Y} \cdot K_v \le \sigma_{\text{allow}} = \frac{S_t}{S_F} \implies \mathbf{F_{\text{beam}} = S_t \cdot b \cdot m \cdot Y}}$$
where $W_t = \frac{2 T}{d}$ is the transmitted tangential tooth force, $b = (9 - 12) m$ is the active face width, $m$ is the module, $Y$ is the dimensionless Lewis Form Factor ($Y = \pi y$), and $K_v$ is the dynamic velocity factor; prove the **Pinion Bending Weakness Invariant** (when pinion and gear are made of the same material, the **pinion is ALWAYS weaker in bending because $T_{\text{pinion}} < T_{\text{gear}} \implies Y_{\text{pinion}} < Y_{\text{gear}}$**, making the pinion the critical design member); master **Buckingham's Wear Load Capacity**:
$$\mathbf{F_w = d_1 \cdot b \cdot Q \cdot K \quad \left(Q = \frac{2 T_2}{T_1 + T_2}, \ K = \frac{\sigma_{es}^2 \sin\phi}{1.4}\left(\frac{1}{E_1} + \frac{1}{E_2}\right)\right)}$$
and enforce the **Dynamic Durability Condition ($\mathbf{F_w \ge F_{\text{dynamic}}}$)** to prevent Hertzian micro-pitting fatigue.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lewis Beam Bending Equation ($F_b = S_t b m Y$) & Buckingham Wear ($F_w = d_1 b Q K$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Gear Module (m) for Bending Strength and Surface Wear Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Gear Failure Mechanism / Design Parameter & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | When Pinion and Gear Are Manufactured from the Same Steel Material, the Weaker Component in Tooth Bending Is the ___ (Pinion) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Power Transmission Problem: Sizing the Module of a Heavy-Duty Spur Pinion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Spur Gear Design (Budynas 2020; Lewis 1892; Buckingham 1949):
   - **Lewis Bending Strength Formulation:**
     $$\mathbf{\sigma_b = \frac{W_t}{b \cdot m \cdot Y} \le \frac{S_t}{S_F} \implies \mathbf{F_b = \sigma_{\text{allow}} \cdot b \cdot m \cdot Y \quad (b \approx 10 m)}}$$
   - **Buckingham Wear Formulation:**
     $$\mathbf{F_w = d_1 \cdot b \cdot Q \cdot K \quad \Big| \quad Q = \frac{2 T_2}{T_1 + T_2} \quad \Big| \quad K \approx 0.16 \left(\frac{\text{BHN}}{100}\right)^2}$$
   - **The Pinion Weakness Invariant:** In any meshing pair of identical material, the pinion has fewer teeth, narrower tooth flanks, and smaller form factor ($Y_1 < Y_2$), making **the Pinion ALWAYS weaker in bending than the gear**!
2. **Slide 2 (`ordering`):** Provide 5 steps of spur gear design: (1) determine transmitted power $P$, pinion speed $N_1$, gear ratio $i$, and select tooth counts ($T_1 \ge 18, T_2 = i T_1$), (2) identify the weaker member by comparing the product $\sigma_{\text{allow}} Y$ for pinion and gear, (3) calculate transmitted tangential tooth load $W_t = \frac{2 T_1}{m T_1} = \frac{2 T_1}{d_1}$, (4) apply the Lewis bending equation with face width $b = 10 m$ to solve for required module $m$, (5) compute Buckingham wear strength $F_w = d_1 b Q K$ and check that $F_w \ge F_{\text{dynamic}}$ to ensure infinite surface pitting life!
3. **Slide 3 (`matching`):** Pair 4 concepts (Lewis Bending Equation, Lewis Form Factor $Y$, Buckingham Wear Load $F_w$, Ratio Factor $Q$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pinion. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating module: A motor drives a spur gear transmission delivering torque $T_1 = 150\text{ N}\cdot\text{m}$ to a pinion of $T_1 = 20$ teeth. The Lewis form factor is $Y = 0.320$, the allowable bending stress is $\sigma_{\text{allow}} = 120\text{ MPa} = 120 \times 10^6\text{ N/m}^2$, and the face width is set to $b = 10 m$. Using the Lewis equation ($W_t = \frac{2 T_1}{m T_1} = \sigma_{\text{allow}} b m Y$), what is the minimum required module $m$? ($W_t = \frac{2(150)}{m (20)} = \frac{15}{m}$; Equating: $\frac{15}{m} = \sigma_{\text{allow}} (10 m) m Y = 120 \times 10^6 \times 10 \times m^2 \times 0.320 = 384 \times 10^6 m^2 \implies 15 = 384 \times 10^6 m^3 \implies m^3 = \frac{15}{384 \times 10^6} \approx 3.90625 \times 10^{-8}\text{ m}^3 \implies m = (3.90625 \times 10^{-8})^{1/3} \approx 0.003393\text{ m} = \mathbf{3.39\text{ mm}}$ (Standardized to $m = 4.0\text{ mm}$)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "spur_gear_design_lewis_bending_and_buckingham_wear_equations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Spur Gear Sizing \\& Dual Strength Criteria (Lewis \\& Buckingham)**\n• **Lewis Tooth Cantilever Beam Bending Formulation:**\n$$\n\\mathbf{\\sigma_b = \\frac{W_t}{b \\cdot m \\cdot Y} \\le \\sigma_{\\text{allow}} \\implies \\mathbf{F_{\\text{beam}} = \\sigma_{\\text{allow}} \\cdot b \\cdot m \\cdot Y \\quad (W_t = 2T / d)}}\n$$\n• **Buckingham Wear Load Capacity Formulation (Pitting Resistance):**\n$$\n\\mathbf{F_w = d_1 \\cdot b \\cdot Q \\cdot K \\quad \\Big| \\quad Q = \\frac{2 T_2}{T_1 + T_2} \\quad \\Big| \\quad K = \\frac{\\sigma_{es}^2 \\sin\\phi}{1.4}\\left(\\frac{1}{E_1} + \\frac{1}{E_2}\\right)}\n$$\n• **The Design Safety Invariants:**\n  - **Bending Strength:** $\\mathbf{F_{\\text{beam}} \\ge F_{\\text{dynamic}}}$ (Prevents catastrophic tooth breakage at root);\n  - **Surface Durability:** $\\mathbf{F_w \\ge F_{\\text{dynamic}}}$ (Prevents Hertzian contact fatigue pitting)!\n• **The Pinion Weakness Invariant:** When pinion and gear share the same steel alloy, the **Pinion is ALWAYS weaker in bending ($Y_{\\text{pinion}} < Y_{\\text{gear}}$)** due to thinner root geometry $\\implies$ **Always design for pinion bending!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a spur gear pair for bending strength and verify surface wear durability.",
      "orderItems": [
        "Select tooth numbers for pinion (T1 >= 18) and gear (T2 = i * T1) to establish the speed reduction ratio",
        "Identify the weaker member by comparing the strength factor (\u03c3_allow * Y) for both pinion and gear",
        "Express the transmitted tangential force W_t = 2 * T1 / (m * T1) in terms of the unknown module m",
        "Apply the Lewis bending formula with standard face width b = 10*m to solve for minimum required module m",
        "Calculate Buckingham wear capacity F_w = d1 * b * Q * K and verify that F_w exceeds the dynamic operating load F_d"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Spur Gear Design Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Lewis Form Factor (Y)", "right": "Dimensionless geometric factor accounting for tooth profile thickness and root stress concentration" },
        { "left": "Face Width (b)", "right": "Axial width of gear teeth, empirically standardized to b = (9 to 12) * module" },
        { "left": "Ratio Factor (Q)", "right": "Q = 2*T2 / (T1 + T2), accounting for relative curvature between mating cylindrical pitch surfaces" },
        { "left": "Load Stress Factor (K)", "right": "Material contact fatigue metric scaling with the square of surface Brinell hardness (BHN^2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When a pinion and gear are manufactured from the exact same steel alloy, the weaker component in tooth bending is the ___.",
      "blankAnswer": "pinion",
      "blankDistractors": ["gear", "rack", "annulus"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A pinion transmitting torque T1 = 150 N·m has T1 = 20 teeth. The Lewis form factor is Y = 0.320, allowable bending stress is \u03c3_allow = 120 MPa, and face width is b = 10*m. Using the Lewis bending equation, what is the minimum required module m?",
      "options": [
        { "text": "m = 3.39 mm (Calculated from m^3 = 15 / (384*10^6) = 3.906*10^-8 m^3, standardized to standard module m = 4.0 mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Lewis beam bending equation (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 14). 1. **Tangential Transmitted Tooth Load ($W_t$):** $$W_t = \\frac{2 T_1}{d_1} = \\frac{2 T_1}{m T_1} = \\frac{2(150\\text{ N}\\cdot\\text{m})}{m (20)} = \\frac{15}{m}\\text{ N}$$ 2. **Apply the Lewis Bending Equation ($b = 10 m$):** $$W_t = \\sigma_{\\text{allow}} \\cdot b \\cdot m \\cdot Y$$ $$\\frac{15}{m} = (120 \\times 10^6\\text{ N/m}^2) \\cdot (10 m) \\cdot m \\cdot (0.320)$$ $$\\frac{15}{m} = (384 \\times 10^6) m^2$$ 3. **Solve for Module ($m$):** $$m^3 = \\frac{15}{384 \\times 10^6} = 3.90625 \\times 10^{-8}\\text{ m}^3$$ $$m = \\left( 3.90625 \\times 10^{-8} \\right)^{1/3} \\approx \\mathbf{0.003393\\text{ m} \\approx 3.39\\text{ mm}}$$ 4. **Standard Metric Selection:** In mechanical design practice, an engineer standardizes this to **$m = 4.0\\text{ mm}$**!" },
        { "text": "m = 2.0 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "m = 6.0 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "m = 1.2 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
