# Duofy Reusable Lesson Format: Helical Gear Design (Formative Teeth & 3D Force Vectors)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Spur_Helical_and_Bevel_Gears`  
**Lesson Format Type:** `helical_gear_design_formative_teeth_and_3d_force_components`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through helical tooth geometry, transverse vs normal module planes, virtual/formative tooth counts, and 3D force vector decomposition in high-speed power transmissions (Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 13 & 14; Robert L. Norton Chapter 11): master the geometric relations between **Transverse Plane ($t$)** and **Normal Plane ($n$)** through **Helix Angle ($\mathbf{\psi}$)**:
$$\mathbf{m_n = m_t \cos\psi \quad \Big| \quad p_n = p_t \cos\psi \quad \Big| \quad \tan\phi_n = \tan\phi_t \cos\psi}$$
derive the **Virtual / Formative Number of Teeth ($\mathbf{T_v}$)** (representing the equivalent spur gear tooth count on the normal ellipse of curvature, used to look up the Lewis form factor $Y$):
$$\mathbf{T_v = \frac{T}{\cos^3\psi}}$$
master the **Three Orthogonal 3D Tooth Force Components**:
1. **Tangential Force ($\mathbf{W_t = \frac{2 T}{d}}$)** (transmits torque);
2. **Radial Force ($\mathbf{W_r = W_t \tan\phi_t = \frac{W_t \tan\phi_n}{\cos\psi}}$)** (separates shafts radially);
3. **Axial Thrust Force ($\mathbf{W_a = W_t \tan\psi}$)** (pushes shaft axially into bearings);
and analyze why **Double Helical (Herringbone) Gears** with opposite helix angles cancel axial thrust ($W_a - W_a = 0$) while preserving whisper-quiet gradual multi-tooth engagement.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Helical Plane Relations ($m_n = m_t \cos\psi$), Formative Teeth ($T_v = \frac{T}{\cos^3\psi}$) & 3D Force Vectors Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Decomposition of 3D Forces (Tangential, Radial, Axial) on a Helical Gear Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Helical Gear Plane / Force Component & Technical Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Virtual Equivalent Number of Teeth Used to Size Helical Tooth Bending Strength on the Normal Plane Is the ___ Number of Teeth (Formative / Virtual) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Powertrain Problem: Calculating the Axial Thrust Force and Radial Separating Force on a Helical Pinion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Helical Gear Design (Budynas 2020; Norton 2013):
   - **Helical Plane Conversion Formulations:**
     $$\mathbf{m_n = m_t \cos\psi \quad \Big| \quad \tan\phi_n = \tan\phi_t \cos\psi \quad \Big| \quad T_v = \frac{T}{\cos^3\psi}}$$
   - **3D Force Vector Decomposition Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Force Component} & \textbf{Symbol} & \textbf{Governing Equation} & \textbf{Bearing Load Imposed} \\
     \hline
     \mathbf{\text{Tangential (Driving)}} & \mathbf{W_t} & \mathbf{W_t = \frac{2 T}{d}} & \text{Transmits power torque } P = W_t V \\
     \mathbf{\text{Radial (Separating)}} & \mathbf{W_r} & \mathbf{W_r = W_t \tan\phi_t = \frac{W_t \tan\phi_n}{\cos\psi}} & \text{Radial bearing reactions} \\
     \mathbf{\text{Axial (Thrust)}} & \mathbf{W_a} & \mathbf{W_a = W_t \tan\psi} & \mathbf{\text{Requires dedicated thrust bearings!}} \\
     \mathbf{\text{Total Normal Force}} & \mathbf{W_n} & \mathbf{W_n = \frac{W_t}{\cos\phi_n \cos\psi}} & \text{Total tooth flank contact force} \\
     \hline
     \end{array}$$
   - **The Herringbone Invariant:** Double helical gears place left-hand and right-hand teeth on the same gear face, canceling opposing axial thrust forces ($\mathbf{W_a - W_a = 0}$) completely!
2. **Slide 2 (`ordering`):** Provide 5 steps of helical gear force analysis: (1) determine transmitted torque $T$ and pitch diameter $d = m_t T$ in the transverse plane, (2) compute tangential driving force $W_t = \frac{2 T}{d}$, (3) calculate transverse pressure angle $\phi_t = \tan^{-1}\left(\frac{\tan\phi_n}{\cos\psi}\right)$ from standard normal pressure angle $\phi_n = 20^\circ$, (4) compute radial separating force $W_r = W_t \tan\phi_t$ and axial thrust force $W_a = W_t \tan\psi$, (5) combine bearing radial and axial thrust reactions to select appropriate tapered roller or deep-groove ball bearings!
3. **Slide 3 (`matching`):** Pair 4 concepts (Formative Teeth $T_v$, Axial Thrust Force $W_a$, Radial Force $W_r$, Herringbone Gear) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Formative (or Virtual). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating 3D helical forces: A helical pinion with pitch diameter $d = 100\text{ mm}$ transmits a torque $T = 300\text{ N}\cdot\text{m}$. The helix angle is $\psi = 30^\circ$ and the normal pressure angle is $\phi_n = 20^\circ$. What is the transmitted tangential force $W_t$ and the axial thrust force $W_a$ acting on the pinion shaft? ($W_t = \frac{2 T}{d} = \frac{2(300\text{ N}\cdot\text{m})}{0.100\text{ m}} = \mathbf{6000\text{ N} = 6.0\text{ kN}}$; $W_a = W_t \tan\psi = (6000\text{ N}) \tan(30^\circ) = 6000 \times 0.57735 \approx \mathbf{3464.1\text{ N} \approx 3.46\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "helical_gear_design_formative_teeth_and_3d_force_components",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Helical Gear Kinematics \\& 3D Force Vectors (Shigley \\& Norton)**\n• **Transverse vs Normal Plane Conversions (Helix Angle $\\mathbf{\\psi}$):**\n$$\n\\mathbf{m_n = m_t \\cos\\psi \\quad \\Big| \\quad \\tan\\phi_n = \\tan\\phi_t \\cos\\psi \\quad \\Big| \\quad \\mathbf{T_v = \\frac{T}{\\cos^3\\psi} \\text{ (Formative Teeth)}}}\n$$\n• **3D Resultant Force Vector Decomposition:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Force Vector} & \\textbf{Symbol} & \\textbf{Governing Formulation} & \\textbf{Physical Action} \\\\\n\\hline\n\\mathbf{\\text{Tangential (Driving)}} & \\mathbf{W_t} & \\mathbf{W_t = \\frac{2 T}{d}} & \\text{Transmits rotational shaft power} \\\\\n\\mathbf{\\text{Radial (Separating)}} & \\mathbf{W_r} & \\mathbf{W_r = W_t \\tan\\phi_t = \\frac{W_t \\tan\\phi_n}{\\cos\\psi}} & \\text{Pushes mating shafts apart} \\\\\n\\mathbf{\\text{Axial (Thrust)}} & \\mathbf{W_a} & \\mathbf{W_a = W_t \\tan\\psi} & \\mathbf{\\text{Generates longitudinal shaft thrust!}} \\\\\n\\mathbf{\\text{Total Resultant Normal}} & \\mathbf{W_n} & \\mathbf{W_n = \\frac{W_t}{\\cos\\phi_n \\cos\\psi}} & \\text{Normal compressive load on tooth flank} \\\\\n\\hline\n\\end{array}\n$$\n• **The Herringbone Invariant:** Double helical gears pair left-hand and right-hand teeth on a single wheel, **canceling opposing axial thrust ($W_a - W_a = 0$)** without needing thrust bearings!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform 3D force resolution on a power-transmitting helical gear.",
      "orderItems": [
        "Calculate the transverse pitch diameter d = m_t * T and compute transmitted torque T = Power / omega",
        "Compute the tangential driving force acting at the pitch circle: W_t = 2 * T / d",
        "Determine the transverse pressure angle using tan(phi_t) = tan(phi_n) / cos(psi)",
        "Calculate the radial separating force W_r = W_t * tan(phi_t) and axial thrust force W_a = W_t * tan(psi)",
        "Combine tangential, radial, and axial loads to compute resultant bearing reactions and select shaft thrust bearings"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Helical Gear Kinematic Term to its exact Mathematical Expression.",
      "matchPairs": [
        { "left": "Formative Number of Teeth (Tv)", "right": "Tv = T / cos^3(\u03c8), the equivalent spur tooth count on the normal osculating ellipse of curvature" },
        { "left": "Axial Thrust Force (Wa)", "right": "Wa = Wt * tan(\u03c8), the axial reaction force that must be absorbed by thrust bearings" },
        { "left": "Normal Module (mn)", "right": "mn = mt * cos(\u03c8), the standardized cutter module measured perpendicular to the tooth helix" },
        { "left": "Radial Separating Force (Wr)", "right": "Wr = Wt * tan(\u03c6t), the force pushing the two gear shafts apart along the center line" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The virtual equivalent number of teeth used to evaluate helical tooth bending strength on the normal plane is the ___ number of teeth.",
      "blankAnswer": "formative",
      "blankDistractors": ["transverse", "tangential", "axial"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A helical gear of pitch diameter d = 100 mm transmits torque T = 300 N·m. The helix angle is \u03c8 = 30° and the normal pressure angle is \u03c6n = 20°. What is the transmitted tangential force W_t and the axial thrust force W_a acting on the gear shaft?",
      "options": [
        { "text": "W_t = 6000 N (6.0 kN) and W_a = 3464.1 N (3.46 kN, calculated from W_a = 6000 * tan(30°))", "isCorrect": true, "explanation": "Correct! Let's solve systematically using 3D helical gear force resolution (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 13). 1. **Calculate Tangential Force ($W_t$):** $$W_t = \\frac{2 T}{d} = \\frac{2(300\\text{ N}\\cdot\\text{m})}{0.100\\text{ m}} = \\mathbf{6000\\text{ N} = 6.0\\text{ kN}}$$ 2. **Calculate Axial Thrust Force ($W_a$):** $$W_a = W_t \\tan\\psi = (6000\\text{ N}) \\tan(30^\\circ) = 6000 \\times 0.577350 \\approx \\mathbf{3464.10\\text{ N} \\approx 3.464\\text{ kN}}$$ 3. **Calculate Radial Separating Force ($W_r$) for completeness:** - $\\tan\\phi_t = \\frac{\\tan\\phi_n}{\\cos\\psi} = \\frac{\\tan(20^\\circ)}{\\cos(30^\\circ)} = \\frac{0.36397}{0.86603} \\approx 0.42027 \\implies \\phi_t \\approx 22.8^\\circ$. - $W_r = W_t \\tan\\phi_t = (6000\\text{ N})(0.42027) = \\mathbf{2521.6\\text{ N}}$. 4. **Engineering Significance:** The massive $3.46\\text{ kN}$ axial thrust requires an engineer to specify **tapered roller bearings or angular contact ball bearings** on the shaft to prevent axial displacement!" },
        { "text": "W_t = 3000 N and W_a = 1732.1 N", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_t = 6000 N and W_a = 0 N (Zero thrust)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_t = 12000 N and W_a = 6928.2 N", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
