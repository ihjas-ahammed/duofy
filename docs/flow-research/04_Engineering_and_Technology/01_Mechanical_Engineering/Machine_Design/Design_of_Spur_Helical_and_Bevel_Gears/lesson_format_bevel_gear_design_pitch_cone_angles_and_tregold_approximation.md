# Duofy Reusable Lesson Format: Bevel Gear Design (Pitch Cones & Tredgold's Approximation)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Spur_Helical_and_Bevel_Gears`  
**Lesson Format Type:** `bevel_gear_design_pitch_cone_angles_and_tregold_approximation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through intersecting shaft power transmissions, conical pitch surfaces, pitch cone angles, and Tredgold's virtual spur approximation in mechanical machine design (Thomas Tredgold 1822; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 13 & 15; Robert L. Norton Chapter 12; V.B. Bhandari Chapter 18): master the **Pitch Cone Angles for $90^\circ$ Intersecting Shafts**:
$$\mathbf{\tan\gamma_1 = \frac{T_1}{T_2} = \frac{1}{i} \quad \Big| \quad \tan\gamma_2 = \frac{T_2}{T_1} = i \quad \left(\gamma_1 + \gamma_2 = 90^\circ\right)}$$
master **Cone Distance ($\mathbf{R = \frac{d_1}{2 \sin\gamma_1} = \frac{d_2}{2 \sin\gamma_2}}$)**, master **Tredgold's Back Cone Approximation** (which maps the conical spherical involute tooth profile onto a planar back-cone to define the **Formative Number of Teeth $\mathbf{T_{v1} = \frac{T_1}{\cos\gamma_1}}$** for Lewis form factor lookups), and derive the **3D Force Components on a Straight Bevel Pinion**:
$$\mathbf{W_t = \frac{2 T_1}{d_m} \quad \Big| \quad \mathbf{W_r = W_t \tan\phi \cos\gamma_1} \quad \Big| \quad \mathbf{W_a = W_t \tan\phi \sin\gamma_1}}$$
where mean pitch diameter is $\mathbf{d_m = d_1 - b \sin\gamma_1}$ (with face width limited to $\mathbf{b \le \frac{R}{3}}$ to avoid tooth edge pinching).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bevel Gear Pitch Cone Angles ($\tan\gamma_1 = \frac{T_1}{T_2}$), Cone Distance ($R$) & Tredgold's Formative Teeth Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Pitch Cones, Formative Teeth, and 3D Forces on a Bevel Gear Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bevel Gear Conical Entity / 3D Force Vector & Technical Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Classical Virtual Approximation That Projects Bevel Gear Teeth onto a Back Cone Is ___ Approximation (Tredgold's / Tredgold) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Intersecting Shaft Machine Design Problem: Calculating the Pitch Cone Angle and Formative Teeth for a Bevel Pinion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bevel Gear Design (Budynas 2020; Tredgold 1822; Bhandari 2017):
   - **Bevel Conical Formulations ($90^\circ$ Shaft Angle):**
     $$\mathbf{\tan\gamma_1 = \frac{T_1}{T_2} = \frac{1}{i} \quad \Big| \quad R = \frac{d_1}{2 \sin\gamma_1} \quad \Big| \quad T_{v1} = \frac{T_1}{\cos\gamma_1} \quad \Big| \quad d_m = d_1 - b \sin\gamma_1}$$
   - **Bevel 3D Force Decomposition Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Force Component} & \textbf{Pinion Formula } (\gamma_1) & \textbf{Gear Formula } (\gamma_2) \\
     \hline
     \mathbf{\text{Tangential Force}} & \mathbf{W_t = \frac{2 T_1}{d_{m1}}} & W_t = \frac{2 T_2}{d_{m2}} \text{ (Equal \\& Opposite)} \\
     \mathbf{\text{Radial Force}} & \mathbf{W_{r1} = W_t \tan\phi \cos\gamma_1} & W_{r2} = W_t \tan\phi \cos\gamma_2 = W_{a1} \\
     \mathbf{\text{Axial Thrust Force}} & \mathbf{W_{a1} = W_t \tan\phi \sin\gamma_1} & W_{a2} = W_t \tan\phi \sin\gamma_2 = W_{r1} \\
     \hline
     \end{array}$$
   - **The Action-Reaction Invariant:** The axial thrust on the pinion **is exactly equal to the radial separating force on the gear ($W_{a1} = W_{r2}$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of bevel gear design: (1) determine speed ratio $i = T_2/T_1$ and calculate pitch cone angles $\gamma_1 = \tan^{-1}(1/i), \gamma_2 = 90^\circ - \gamma_1$, (2) compute pitch diameters $d_1 = m T_1, d_2 = m T_2$ and cone distance $R = \frac{d_1}{2\sin\gamma_1}$, (3) calculate formative teeth $T_{v1} = \frac{T_1}{\cos\gamma_1}$ and select face width $b \le R/3$, (4) compute mean pitch diameter $d_m = d_1 - b \sin\gamma_1$ and tangential force $W_t = \frac{2 T}{d_m}$, (5) resolve radial $W_r = W_t \tan\phi \cos\gamma_1$ and axial thrust $W_a = W_t \tan\phi \sin\gamma_1$ loads on shaft bearings!
3. **Slide 3 (`matching`):** Pair 4 concepts (Pitch Cone Angle $\gamma$, Cone Distance $R$, Tredgold's Formative Teeth $T_v$, Face Width Limit $b \le R/3$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Tredgold's (or Tredgold). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating pitch cone angle and formative teeth: A straight bevel gear set connects two perpendicular shafts ($90^\circ$ shaft angle) with a 3:1 reduction ratio ($i = 3.0$). The pinion has $T_1 = 20$ teeth. What is the pitch cone angle $\gamma_1$ of the pinion and its Tredgold formative virtual tooth count $T_{v1}$? ($\tan\gamma_1 = \frac{T_1}{T_2} = \frac{1}{3} = 0.33333 \implies \gamma_1 = \tan^{-1}(0.33333) = \mathbf{18.43^\circ} \approx \mathbf{18.4^\circ}$; $\cos(18.4349^\circ) \approx 0.94868$; $T_{v1} = \frac{T_1}{\cos\gamma_1} = \frac{20}{0.94868} \approx \mathbf{21.08 \approx 21.1\text{ teeth}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bevel_gear_design_pitch_cone_angles_and_tregold_approximation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bevel Gear Pitch Cones \\& Tredgold's Approximation (Shigley \\& Tredgold)**\n• **Pitch Cone Angles for $90^\\circ$ Intersecting Shafts:**\n$$\n\\mathbf{\\tan\\gamma_1 = \\frac{T_1}{T_2} = \\frac{1}{i} \\quad \\Big| \\quad \\tan\\gamma_2 = \\frac{T_2}{T_1} = i \\quad \\left(\\gamma_1 + \\gamma_2 = 90^\\circ\\right)}\n$$\n• **Cone Distance \\& Tredgold's Virtual Formative Teeth:**\n$$\n\\mathbf{R = \\frac{d_1}{2 \\sin\\gamma_1} \\quad \\Big| \\quad \\mathbf{T_{v1} = \\frac{T_1}{\\cos\\gamma_1}} \\quad \\Big| \\quad d_m = d_1 - b \\sin\\gamma_1 \\quad \\left(b \\le \\frac{R}{3}\\right)}\n$$\n• **3D Force Vector Resolution on Bevel Pinion:**\n$$\n\\mathbf{W_t = \\frac{2 T_1}{d_m} \\quad \\Big| \\quad W_r = W_t \\tan\\phi \\cos\\gamma_1 \\quad \\Big| \\quad W_a = W_t \\tan\\phi \\sin\\gamma_1}\n$$\n• **The Action-Reaction Invariant:** The axial thrust on the bevel pinion is **identically equal to the radial separating force on the mating gear ($W_{a1} = W_{r2}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a straight bevel gear pair for 90° intersecting power shafts.",
      "orderItems": [
        "Calculate the pitch cone angles gamma1 = atan(T1 / T2) and gamma2 = 90° - gamma1 from the tooth counts",
        "Compute the pitch diameters d1 = m*T1, d2 = m*T2, and evaluate the outer cone distance R = d1 / (2 * sin(gamma1))",
        "Determine the Tredgold virtual formative tooth numbers: Tv1 = T1 / cos(gamma1) and Tv2 = T2 / cos(gamma2)",
        "Select active face width b <= R / 3 and compute the mean pitch diameter: dm = d1 - b * sin(gamma1)",
        "Calculate the mean tangential force W_t = 2*T1 / dm and resolve radial (Wr = Wt*tan(phi)*cos(gamma1)) and axial thrust (Wa = Wt*tan(phi)*sin(gamma1)) loads"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Bevel Gear Geometry Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Pitch Cone Angle (\u03b31)", "right": "tan(\u03b31) = T1 / T2, defining the half-apex angle of the rolling pitch cone for 90° shaft intersections" },
        { "left": "Tredgold's Approximation", "right": "Tv = T / cos(\u03b3), mapping spherical conical tooth profiles onto a planar back-cone spur gear" },
        { "left": "Outer Cone Distance (R)", "right": "R = d1 / (2 * sin(\u03b31)), the slant height from the pitch circle to the intersecting cone apex" },
        { "left": "Face Width Limit (b <= R / 3)", "right": "Geometric constraint preventing disproportionate tooth thinning and load pinching at the toe" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The classical virtual approximation that projects bevel gear teeth onto a back-cone is ___ approximation.",
      "blankAnswer": "Tredgold's",
      "blankDistractors": ["Lewis's", "Buckingham's", "ASME's"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A straight bevel gear set connects two perpendicular shafts (90° intersection) with a 3:1 speed reduction ratio (i = 3.0). The pinion has T1 = 20 teeth. What is the pitch cone angle \u03b31 of the pinion and its Tredgold formative tooth number Tv1?",
      "options": [
        { "text": "\u03b31 = 18.43° and Tv1 = 21.1 teeth (Calculated from tan(\u03b31) = 1/3 and Tv1 = 20 / cos(18.43°) = 21.08)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using bevel gear pitch cone geometry (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 13). 1. **Calculate Pitch Cone Angle of Pinion ($\\gamma_1$):** - Shaft angle $\\Sigma = 90^\\circ$. - Gear ratio $i = \\frac{T_2}{T_1} = 3.0 \\implies T_2 = 3 \\times 20 = 60\\text{ teeth}$. - $$\\tan\\gamma_1 = \\frac{T_1}{T_2} = \\frac{20}{60} = \\frac{1}{3} \\approx 0.333333$$ - $$\\gamma_1 = \\tan^{-1}(0.333333) \\approx \\mathbf{18.4349^\\circ \\approx 18.43^\\circ}$$ 2. **Calculate Tredgold Formative Number of Teeth ($T_{v1}$):** - $$\\cos\\gamma_1 = \\cos(18.4349^\\circ) = \\frac{3}{\\sqrt{1^2 + 3^2}} = \\frac{3}{\\sqrt{10}} = \\frac{3}{3.162278} \\approx \\mathbf{0.948683}$$ - $$T_{v1} = \\frac{T_1}{\\cos\\gamma_1} = \\frac{20}{0.948683} \\approx \\mathbf{21.082 \\approx 21.1\\text{ teeth}}$$ 3. **Physical Significance:** The pinion tooth profile behaves in bending like a $21.1$-tooth spur gear, which gives a higher Lewis form factor ($Y$) and higher bending capacity than the raw $20$-tooth count!" },
        { "text": "\u03b31 = 45.00° and Tv1 = 28.3 teeth (Miter gears)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b31 = 71.57° and Tv1 = 63.2 teeth (The gear cone angle)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b31 = 30.00° and Tv1 = 40.0 teeth", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
