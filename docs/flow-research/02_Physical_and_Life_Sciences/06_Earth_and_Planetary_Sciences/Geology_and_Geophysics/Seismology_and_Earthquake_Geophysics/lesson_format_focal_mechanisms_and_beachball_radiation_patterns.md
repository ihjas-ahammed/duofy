# Duofy Reusable Lesson Format: Focal Mechanisms and Beachball Radiation Patterns

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Seismology_and_Earthquake_Geophysics`  
**Lesson Format Type:** `focal_mechanisms_and_beachball_radiation_patterns`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the elastodynamic double-couple point-source model, stereographic projections, and visual interpretation of earthquake focal mechanisms ("beachball diagrams") (Keiiti Aki & Paul G. Richards; Hiroo Kanamori): analyze the **Double-Couple Equivalent Force System** generating a 4-quadrant P-wave first-motion radiation pattern, master the **Lower-Hemisphere Stereographic Projection** displaying **Compressional Quadrants (Upward first arrival $\implies$ Shaded/Dark lobes)** and **Dilatational Quadrants (Downward first arrival $\implies$ White lobes)** separated by two orthogonal **Nodal Planes** (one being the true fault plane and the other the auxiliary plane), recognize the 3 archetypal fault beachballs (**Strike-Slip [cross of 4 equal quadrants]**, **Normal [tensional: white center flanked by dark margins]**, and **Thrust/Reverse [compressional: dark center flanked by white margins]**), and determine the orientations of the **Pressure (P) Axis** and **Tension (T) Axis**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Double-Couple Radiation & Lower-Hemisphere Stereonet Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Seismogram First-Motion to Beachball Plotting Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beachball Pattern / Stress Axis & Tectonic Fault Geometry Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Polarized P-Wave First Arrival Motion Represented by Shaded Lobes Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Differentiating True Fault Plane from Auxiliary Plane Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Focal Mechanisms & Beachball Radiation Patterns (Aki & Richards):
   - **The Double-Couple Point Source Model:**
     - Pure shear slip along a planar fault is mathematically equivalent to two orthogonal force couples with zero net torque.
     - Generates a **quadrantal radiation pattern** of P-wave first motions:
       - **Compressional (+):** P-wave particle motion pushes away from focus $\implies$ **Upward seismogram arrival $\implies$ SHADED / DARK QUADRANT**.
       - **Dilatational (-):** P-wave particle motion pulls toward focus $\implies$ **Downward seismogram arrival $\implies$ WHITE QUADRANT**.
   - **The 3 Archetypal Fault Beachballs (Lower Hemisphere):**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Fault Type} & \textbf{Tectonic Regime} & \textbf{P and T Axes Orientation} & \textbf{Beachball Appearance} \\
     \hline
     \textbf{Strike-Slip} & \text{Horizontal Shear} & \text{P and T axes both horizontal} & \mathbf{\text{Checkerboard / 4 equal quadrants intersecting in a cross}} \\
     \textbf{Normal Fault} & \text{Horizontal Extension} & \mathbf{\text{P-axis vertical, T-axis horizontal}} & \mathbf{\text{White center flanked by dark outer rims ('Cat's Eye')}} \\
     \textbf{Thrust / Reverse} & \text{Horizontal Compression} & \mathbf{\text{P-axis horizontal, T-axis vertical}} & \mathbf{\text{Dark center flanked by white outer lobes ('Dark Bullseye')}} \\
     \hline
     \end{array}$$
   - **Nodal Planes:** The two orthogonal planes separating compressional from dilatational quadrants. One plane is the **true fault plane**; the other is the **auxiliary plane**.
2. **Slide 2 (`ordering`):** Provide 5 steps to construct an earthquake focal mechanism: (1) an earthquake occurs, radiating high-frequency P-waves in all 3D directions from the hypocenter, (2) a global network of seismometers records the vertical first-motion polarity (upward compression vs downward dilatation), (3) each recording station's ray path is mapped as an azimuth and takeoff angle onto a lower-hemisphere stereographic projection grid, (4) two mutually perpendicular great circles (nodal planes) are drawn to partition all compressional points from dilatational points, (5) the compressional quadrants are shaded dark and the dilatational quadrants left white to produce the final focal mechanism beachball diagram!
3. **Slide 3 (`matching`):** Pair 4 focal mechanism patterns (Dark Center Beachball, White Center Beachball, 4-Quadrant Cross Beachball, P-Axis) with their tectonic and fault interpretations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in standard lower-hemisphere focal mechanism beachballs, the shaded dark quadrants represent regions of initial P-wave compression. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on resolving the fault plane ambiguity of focal mechanisms: A focal mechanism beachball shows two orthogonal nodal planes dipping at 45 degrees. How do geophysicists determine which of the two nodal planes is the actual physical fault plane that ruptured, and which is the fictitious auxiliary plane? (By **combining the focal mechanism with external geological and geophysical data**, such as the **spatial distribution and alignment of aftershock hypocenters, surface rupture traces, or regional tectonic stress trends**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "focal_mechanisms_and_beachball_radiation_patterns",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Focal Mechanisms & Beachball Radiation Patterns**\n• **The Double-Couple Radiation Model:**\n  - **Compressional (+):** Particle motion away from focus $\\implies$ **Upward pulse $\\implies$ SHADED / DARK Lobe**.\n  - **Dilatational (-):** Particle motion toward focus $\\implies$ **Downward pulse $\\implies$ WHITE Lobe**.\n• **The 3 Archetypal Beachball Geometries (Lower Hemisphere):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Fault Mechanism} & \\textbf{Stress Axes} & \\textbf{Beachball Appearance} \\\\\n\\hline\n\\textbf{Strike-Slip} & \\text{P \& T horizontal} & \\mathbf{\\text{Checkerboard (4 equal quadrants cross)}} \\\\\n\\textbf{Normal Fault} & \\mathbf{\\text{T-axis horizontal (Extension)}} & \\mathbf{\\text{WHITE Center (Dark margins)}} \\\\\n\\textbf{Thrust / Reverse} & \\mathbf{\\text{P-axis horizontal (Compression)}} & \\mathbf{\\text{DARK Center (White margins)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Nodal Plane Ambiguity:** Seismology yields **two orthogonal planes** (1 True Fault Plane + 1 Auxiliary Plane); resolved using **aftershock alignments**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct an earthquake focal mechanism beachball diagram.",
      "orderItems": [
        "An earthquake rupture radiates compressional and dilatational P-wave first motions into the surrounding Earth volume",
        "Seismograph stations around the globe record the initial vertical arrival as either an upward (compression) or downward (dilatation) motion",
        "Plot each station's ray takeoff angle and azimuth onto a 2D lower-hemisphere stereographic projection grid",
        "Fit two mutually orthogonal great circles (nodal planes) that cleanly separate the compressional data points from dilatational points",
        "Shade the compressional quadrants dark and leave dilatational quadrants white to display the completed focal beachball"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each focal mechanism beachball feature to its precise kinematic meaning.",
      "matchPairs": [
        { "left": "Dark Center Beachball (Thrust/Reverse)", "right": "Compressional tectonic regime with horizontal P-axis characteristic of subduction megathrusts" },
        { "left": "White Center Beachball (Normal Fault)", "right": "Extensional tectonic regime with horizontal T-axis characteristic of mid-ocean rifts" },
        { "left": "4-Quadrant Cross Beachball (Strike-Slip)", "right": "Horizontal shear regime with vertical fault planes characteristic of the San Andreas Fault" },
        { "left": "Nodal Planes", "right": "Two mutually orthogonal planes separating compression from dilatation, one of which is the true fault" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "On standard seismological lower-hemisphere focal mechanism beachballs, the shaded dark lobes represent regions of initial P-wave ___.",
      "blankAnswer": "compression",
      "blankDistractors": ["dilatation", "tension", "attenuation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A newly calculated focal mechanism for an offshore earthquake shows two intersecting nodal planes: Plane A strikes north-south and dips 30° east, while Plane B strikes north-south and dips 60° west. Why can seismology alone not tell which plane is the real fault?",
      "options": [
        { "text": "Because the double-couple mathematical representation of a shear dislocation is completely symmetric, meaning slip on Plane A generates the EXACT same radiated wave pattern as conjugate slip on Plane B; distinguishing the true fault plane requires independent evidence such as the spatial linear alignment of aftershock hypocenters or surface seafloor ruptures", "isCorrect": true, "explanation": "Correct! In theoretical elastodynamics, an earthquake fault dislocation is represented as a 'double-couple' of forces (two perpendicular force pairs with opposing torques that cancel out to maintain zero net angular momentum). Because a double-couple force system is completely symmetric with respect to its two orthogonal nodal planes, the elastodynamic wave equation produces identical P-wave and S-wave radiation patterns whether the slip occurred on Plane A (with Plane B as the auxiliary plane) or on Plane B (with Plane A as the auxiliary plane). This mathematical ambiguity means a beachball alone cannot tell you which plane slipped. To resolve the ambiguity, geophysicists plot the 3D spatial distribution of hundreds of aftershock hypocenters—the aftershocks will delineate and illuminate the true physical fault plane in 3D space." },
        { "text": "Because seismographs only work during daytime", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because earthquakes erase the history of the rocks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because both planes always slip simultaneously in opposite directions", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
