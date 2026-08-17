# Duofy Reusable Lesson Format: Buoyancy & Stability (Archimedes & Metacentric Height)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Fluid_Statics_and_Bernoulli_Equation`  
**Lesson Format Type:** `buoyancy_archimedes_principle_and_metacentric_stability`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Archimedes' buoyancy law, centers of buoyancy, and rotational metacentric stability in floating ships and submerged submarines (Archimedes of Syracuse 250 BC; Frank M. White *Fluid Mechanics* Chapter 2; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 2): master **Archimedes' Principle ($\mathbf{F_B = \rho_{\text{fluid}} g V_{\text{displaced}}}$)**, locate the **Center of Buoyancy ($B$)** (the geometric centroid of the displaced liquid volume), contrast stability of **Fully Submerged Bodies** (stable if and only if Center of Gravity $G$ is strictly below Center of Buoyancy $B$: $z_G < z_B$) vs **Floating Bodies with Free Waterplanes**, derive the **Metacentric Height ($\mathbf{GM}$)** equation:
$$\mathbf{GM = MB - BG = \frac{I_{\text{waterplane}}}{V_{\text{displaced}}} - BG}$$
where $I_{\text{waterplane}} = \frac{L b^3}{12}$ is the area moment of inertia of the waterline cross-section about the longitudinal tilting axis, and analyze the **Stability Triad**: (1) $\mathbf{GM > 0}$ (**Stable Equilibrium**, Righting Restoring Moment $\tau = W \cdot GM \sin\theta$), (2) $\mathbf{GM = 0}$ (**Neutral Equilibrium**), and (3) $\mathbf{GM < 0}$ (**Unstable Equilibrium**, Overturning Moment leading to capsizing).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Archimedes' Law ($F_B = \rho g V_{\text{disp}}$) & Metacentric Height Formula ($GM = \frac{I}{V_{\text{disp}}} - BG$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Metacentric Height and Stability of a Floating Barge Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Floating Stability Parameter / Characteristic Point & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Floating Vessel Is in Stable Rotational Equilibrium If Its Metacenter M Lies Strictly ___ Its Center of Gravity G (Above / Higher) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Naval Architecture Problem: Calculating the Metacentric Height GM of a Rectangular Pontoon Barge Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Buoyancy & Metacenter (White 2016; Munson 2016):
   - **Floating Stability Formulations:**
     $$\mathbf{F_B = \rho_f g V_{\text{disp}} \quad \Big| \quad GM = MB - BG = \frac{I_{\text{waterplane}}}{V_{\text{disp}}} - BG}$$
   - **Stability Criterion Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Vessel Regime} & \textbf{Point Relationship} & \textbf{Metacentric Height } GM & \textbf{Equilibrium Dynamic Mode} \\
     \hline
     \mathbf{\text{Stable Vessel}} & \mathbf{M \text{ is ABOVE } G} & \mathbf{GM > 0} & \mathbf{\text{Generates positive righting moment (Uprighting)}} \\
     \mathbf{\text{Neutral Equilibrium}} & M \text{ coincides with } G & GM = 0 & \text{Remains at tilted angle without restoring torque} \\
     \mathbf{\text{Unstable (Capsizing)}} & \mathbf{M \text{ is BELOW } G} & \mathbf{GM < 0} & \mathbf{\text{Generates overturning moment (Capsizes!)}} \\
     \hline
     \end{array}$$
   - **The Weak Axis Tilt Rule:** When a rectangular barge of length $L$ and beam width $b$ tilts, $I_{\text{waterplane}} = \frac{L b^3}{12}$ (using the **smaller dimension $b$ cubed** for rolling stability, which is the most vulnerable tilting mode!).
2. **Slide 2 (`ordering`):** Provide 5 steps of floating stability analysis: (1) determine draft depth $d$ from vertical equilibrium $W_{\text{barge}} = \rho_w g V_{\text{disp}}$, (2) locate Center of Buoyancy $B$ at vertical midpoint of submerged draft ($z_B = d/2$) and locate Center of Gravity $G$ ($z_G$), (3) calculate vertical separation distance $BG = z_G - z_B$, (4) compute waterplane moment of inertia $I = \frac{L b^3}{12}$ and determine metacentric radius $MB = \frac{I}{V_{\text{disp}}}$, (5) compute metacentric height $GM = MB - BG$; confirm stability if $GM > 0$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Metacenter $M$, Center of Buoyancy $B$, Center of Gravity $G$, Metacentric Radius $MB = I/V_{\text{disp}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Above (or Higher). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $GM$: A rectangular pontoon barge of length $L = 10\text{ m}$, width $b = 4.0\text{ m}$, and height $H = 3.0\text{ m}$ has a total mass of $M = 40,000\text{ kg}$ floating in freshwater ($\rho = 1000\text{ kg/m}^3$). Its center of gravity $G$ is at mid-height ($z_G = 1.5\text{ m}$ from the bottom). What is the metacentric height $GM$ of the barge? (Displaced volume $V_{\text{disp}} = \frac{M}{\rho} = \frac{40,000}{1000} = 40\text{ m}^3$; Submerged draft depth $d = \frac{V_{\text{disp}}}{L \cdot b} = \frac{40}{10 \times 4} = 1.0\text{ m}$; Center of buoyancy $z_B = \frac{d}{2} = 0.5\text{ m}$; Distance $BG = z_G - z_B = 1.5 - 0.5 = 1.0\text{ m}$; Waterplane inertia $I = \frac{L b^3}{12} = \frac{10 \times (4)^3}{12} = \frac{640}{12} = 53.333\text{ m}^4$; $MB = \frac{I}{V_{\text{disp}}} = \frac{53.333}{40} = 1.333\text{ m}$; $GM = MB - BG = 1.333 - 1.0 = \mathbf{+0.333\text{ m}}$ (Stable!)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "buoyancy_archimedes_principle_and_metacentric_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Archimedes' Buoyancy \\& Metacentric Stability (Frank M. White)**\n• **Buoyancy \\& Metacentric Height Formulations:**\n$$\n\\mathbf{F_B = \\rho_{\\text{fluid}} g V_{\\text{disp}} \\quad \\Big| \\quad GM = MB - BG = \\frac{I_{\\text{waterplane}}}{V_{\\text{disp}}} - BG}\n$$\n• **Floating Vessel Stability Spectrum:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Vessel Condition} & \\textbf{Point Geometry} & \\textbf{Metacentric Height } GM & \\textbf{Dynamic Equilibrium Mode} \\\\\n\\hline\n\\mathbf{\\text{Stable Vessel}} & \\mathbf{M \\text{ is ABOVE } G} & \\mathbf{GM > 0} & \\mathbf{\\text{Generates positive righting moment (Restoring)}} \\\\\n\\mathbf{\\text{Neutral Vessel}} & M \\text{ coincides with } G & GM = 0 & \\text{Zero righting torque; stays at tilted angle} \\\\\n\\mathbf{\\text{Unstable Vessel}} & \\mathbf{M \\text{ is BELOW } G} & \\mathbf{GM < 0} & \\mathbf{\\text{Generates overturning moment (Capsizes!)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Submerged vs Floating Invariant:** A fully submerged submarine is stable if and only if $\\mathbf{z_G < z_B}$ (G below B); a surface ship can be stable even with G above B as long as $\\mathbf{GM > 0}$ due to waterline inertia $I$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the rotational rolling stability and Metacentric Height (GM) of a floating marine vessel.",
      "orderItems": [
        "Determine the submerged draft depth d from vertical equilibrium (Weight = Buoyant Force = rho * g * V_disp)",
        "Locate the vertical position of the Center of Buoyancy B (z_B = d / 2 for a box barge) and Center of Gravity G",
        "Calculate the distance between center of gravity and center of buoyancy: BG = z_G - z_B",
        "Compute the moment of inertia of the waterline cross-section I_waterplane = L * b^3 / 12 and evaluate MB = I / V_disp",
        "Calculate the Metacentric Height GM = MB - BG and confirm rotational stability (GM > 0)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Marine Hydrodynamic Stability Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Center of Buoyancy (B)", "right": "Geometric centroid of the submerged displaced volume where buoyant force acts vertically" },
        { "left": "Metacenter (M)", "right": "Intersection point of the vertical buoyant force line of action with the ship centerline upon tilt" },
        { "left": "Metacentric Height (GM)", "right": "GM = MB - BG, the primary quantitative measure of initial static rolling stability" },
        { "left": "Righting Moment (\u03c4)", "right": "\u03c4 = Weight * GM * sin(\u03b8), the restoring torque returning a heeled ship to upright position" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A floating marine vessel is in stable rotational equilibrium if its metacenter M lies strictly ___ its center of gravity G.",
      "blankAnswer": "above",
      "blankDistractors": ["below", "alongside", "behind"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular pontoon barge of length L = 10 m, beam width b = 4.0 m, and height H = 3.0 m has total mass M = 40,000 kg floating in freshwater (rho = 1000 kg/m^3). Its Center of Gravity G is at mid-height (z_G = 1.5 m from the base). What is the Metacentric Height GM of the barge?",
      "options": [
        { "text": "GM = +0.333 m (Stable, because Metacenter M is 0.333 m above Center of Gravity G)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using naval hydrostatics (Frank M. White *Fluid Mechanics* Chapter 2). 1. **Displaced Volume ($V_{\\text{disp}}$) and Draft ($d$):** - Total mass $= 40,000\\text{ kg}$. - Displaced Volume: $V_{\\text{disp}} = \\frac{M}{\\rho} = \\frac{40,000\\text{ kg}}{1000\\text{ kg/m}^3} = \\mathbf{40.0\\text{ m}^3}$. - Draft depth: $d = \\frac{V_{\\text{disp}}}{L \\cdot b} = \\frac{40.0\\text{ m}^3}{(10\\text{ m})(4.0\\text{ m})} = \\mathbf{1.0\\text{ m}}$. 2. **Vertical Coordinates of $B$ and $G$:** - Center of Buoyancy (centroid of submerged box): $z_B = \\frac{d}{2} = \\frac{1.0\\text{ m}}{2} = \\mathbf{0.5\\text{ m}}$ from bottom. - Center of Gravity: $z_G = \\mathbf{1.5\\text{ m}}$ from bottom. - Separation distance: $BG = z_G - z_B = 1.5 - 0.5 = \\mathbf{1.0\\text{ m}}$. 3. **Metacentric Radius ($MB$):** - Waterplane Area Moment of Inertia (about weak rolling axis): $$I_{\\text{waterplane}} = \\frac{L b^3}{12} = \\frac{(10\\text{ m})(4.0\\text{ m})^3}{12} = \\frac{10 \\times 64}{12} = \\frac{640}{12} = \\mathbf{53.333\\text{ m}^4}$$ - $MB = \\frac{I}{V_{\\text{disp}}} = \\frac{53.333\\text{ m}^4}{40.0\\text{ m}^3} = \\mathbf{1.333\\text{ m}}$. 4. **Metacentric Height ($GM$):** $$GM = MB - BG = 1.333\\text{ m} - 1.0\\text{ m} = \\mathbf{+0.333\\text{ m}}$$ - Since $GM > 0$, the vessel is **100% STABLE** against rolling and will self-right after being heeled by wind or waves!" },
        { "text": "GM = -0.333 m (Unstable, the barge will capsize)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "GM = +1.333 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "GM = 0.000 m (Neutral equilibrium)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
