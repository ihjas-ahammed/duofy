# Duofy Reusable Lesson Format: Geodynamic Driving Forces (Slab Pull and Ridge Push)

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Plate_Tectonics_and_Continental_Drift`  
**Lesson Format Type:** `geodynamic_driving_forces_slab_pull_and_ridge_push`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantitative geodynamics, gravitational potential energy gradients, and mantle thermodynamics that drive lithospheric plate motions (Donald L. Turcotte & Gerald Schubert; Dan Forsyth & Seiya Uyeda 1975): master the dominant geodynamic mechanism **Slab Pull ($F_{\text{SP}}$)** (responsible for $\approx 90\%$ of net torque on fast-moving plates: conductive lithospheric cooling $\propto \sqrt{t}$ creating negative buoyancy, amplified by the high-pressure metamorphic phase transition of basalt/gabbro $\to$ ultra-dense **Eclogite [$\rho \approx 3.5-3.6\text{ g/cm}^3$]** acting as a sinking gravitational anchor), evaluate **Ridge Push ($F_{\text{RP}}$)** (gravitational sliding force of buoyant, elevated young oceanic lithosphere down the bathymetric topographic slope of mid-ocean ridges toward deep abyssal plains), and contrast with **Mantle Drag / Basal Traction**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Geodynamic Force Balance: Slab Pull vs Ridge Push Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Oceanic Lithosphere Aging to Eclogite Sinking Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Geodynamic Force / Factor & Physical Driving Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Dominant Single Driving Force of Global Plate Motion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Metamorphic Eclogite Phase Transition Density Surge in Subducting Slabs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Geodynamic Driving Forces of Plate Tectonics (Forsyth & Uyeda 1975):
   - **The Geodynamic Force Balance Equation:**
     $$\mathbf{\sum \mathbf{F}_{\text{driving}} = \mathbf{F}_{\text{SP}} + \mathbf{F}_{\text{RP}} + \mathbf{F}_{\text{BT}} = \mathbf{F}_{\text{resisting}}}$$
   - **1. Slab Pull ($\mathbf{F}_{\text{SP}} \approx 90\%$ of Net Driving Force):**
     - As oceanic lithosphere moves away from the ridge, it cools conductively ($y_{\text{lith}} \approx 2.3\sqrt{\kappa t}$) and thickens $\implies$ Density exceeds underlying asthenosphere ($\rho_{\text{lith}} \approx 3.35\text{ g/cm}^3 > \rho_{\text{asth}} \approx 3.25\text{ g/cm}^3$).
     - At subduction zones, high pressure induces the **Basalt-to-Eclogite Metamorphic Phase Transition ($\rho_{\text{eclogite}} \approx 3.55\text{ g/cm}^3$)** $\implies$ Imparting massive **negative buoyancy** that drags the trailing plate into the mantle like a heavy sinking anchor!
   - **2. Ridge Push ($\mathbf{F}_{\text{RP}} \approx 10\%$):**
     - Mid-ocean ridges stand $\approx 2.5-3.0\text{ km}$ above the surrounding ocean floor ($5-6\text{ km}$ depth).
     - The lateral pressure gradient and gravitational sliding of elevated, buoyant lithosphere downslope exerts a horizontal push:
       $$\mathbf{F}_{\text{RP}} = g \rho_m \alpha (T_m - T_0) \kappa t \quad (\approx 2-3 \times 10^{12}\text{ N/m})$$
   - **3. Basal Traction ($\mathbf{F}_{\text{BT}}$):** Viscous shear coupling between convective mantle flow and plate base.
2. **Slide 2 (`ordering`):** Provide 5 steps of the oceanic lithosphere life cycle driving slab pull: (1) young basaltic crust forms at the mid-ocean ridge with low density and high thermal buoyancy, (2) as the plate moves away over tens of millions of years, conductive heat loss causes thermal contraction and thickening of the lithospheric mantle, (3) the density of the cold oceanic plate eventually surpasses the density of the underlying hot asthenosphere, (4) the negative buoyancy causes the leading edge of the plate to bend and sink into a subduction zone, (5) deep within the mantle, increasing pressure converts basalt into ultra-dense eclogite, exerting an immense gravitational slab pull that rapidly drags the entire trailing plate!
3. **Slide 3 (`matching`):** Pair 4 geodynamic driving/resisting forces (Slab Pull, Ridge Push, Basal Traction, Slab Resistance) with their physical mechanisms.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the quantitatively dominant gravitational force driving global tectonic plate velocity is slab pull. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the metamorphic boost to Slab Pull: What crucial petrological transformation occurs inside a subducting oceanic slab at depths beyond 40-60 km that dramatically intensifies the gravitational slab pull force? (The **basaltic oceanic crust undergoes high-pressure metamorphism into Eclogite** (composed of dense omphacite pyroxene and pyrope garnet), which increases the rock density from $\sim 3.0\text{ g/cm}^3$ to $\sim 3.55\text{ g/cm}^3$, creating a massive density contrast with the surrounding mantle that accelerates slab sinking).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "geodynamic_driving_forces_slab_pull_and_ridge_push",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Geodynamic Driving Forces (Forsyth & Uyeda 1975)**\n• **1. Slab Pull ($\\mathbf{F}_{\\text{SP}} \\approx 90\\%$ of Driving Force):**\n  - Conductive cooling ($y \\propto \\sqrt{t}$) causes oceanic lithosphere to become denser than asthenosphere ($\\rho_{\\text{lith}} > \\rho_{\\text{asth}}$).\n  - **The Eclogite Engine:** At depth, basalt/gabbro transforms into **ultra-dense Eclogite ($\\rho \\approx 3.55\\text{ g/cm}^3$)** $\\implies$ Negative buoyancy drags the entire plate into the mantle like a heavy sinking anchor!\n• **2. Ridge Push ($\\mathbf{F}_{\\text{RP}} \\approx 10\\%$):**\n  - Gravitational sliding of elevated mid-ocean ridge lithosphere ($2.5\\text{ km}$ depth) down bathymetric slopes toward abyssal plains ($5\\text{--}6\\text{ km}$ depth).\n• **Global Velocity Correlation:** Plates attached to long subducting slabs (e.g. Pacific, Nazca, Cocos) move up to **$5\\text{--}10\\times$ faster** than plates without slabs (e.g. Eurasian, African)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential thermal and petrological steps that generate gravitational Slab Pull in an oceanic plate.",
      "orderItems": [
        "Fresh oceanic lithosphere forms at a mid-ocean ridge, possessing high thermal buoyancy and thin mantle lithosphere",
        "Over 50-100 million years, conductive heat loss to seawater causes thermal contraction, thickening, and densification",
        "The bulk density of the cold oceanic lithosphere surpasses the density of the underlying hot asthenosphere",
        "Gravitational instability causes the dense oceanic slab to bend and plunge into the asthenosphere at a subduction zone",
        "High-pressure metamorphism converts basaltic crust into ultra-dense Eclogite, generating immense negative buoyancy that pulls the plate"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each geodynamic force to its physical mechanism in plate tectonics.",
      "matchPairs": [
        { "left": "Slab Pull (F_SP)", "right": "Dominant driving force (~90%) caused by negative buoyancy of cold, dense subducting lithosphere" },
        { "left": "Ridge Push (F_RP)", "right": "Gravitational sliding force generated by elevated topographic bathymetry of mid-ocean ridges" },
        { "left": "Basal Traction / Mantle Drag", "right": "Viscous shear stress exerted along the lithosphere-asthenosphere boundary by convective mantle flow" },
        { "left": "Eclogite Metamorphic Transition", "right": "Densification of subducted basaltic crust (to ~3.55 g/cm³) amplifying slab negative buoyancy" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In quantitative geodynamics, the single dominant gravitational force driving over 85 to 90 percent of tectonic plate motion is slab ___.",
      "blankAnswer": "pull",
      "blankDistractors": ["push", "drag", "suction"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why do tectonic plates attached to extensive subduction zones (such as the Pacific, Nazca, and Cocos plates) move significantly faster (6 to 16 cm/year) across Earth's surface than plates with minimal or no subducting edges (such as the North American, Eurasian, and African plates, which move at only 1 to 3 cm/year)?",
      "options": [
        { "text": "Slab Pull is the primary engine of plate tectonics, generating immense gravitational torque proportional to the length and depth of the dense subducting slab sinking into the mantle, whereas Ridge Push and mantle convection currents alone provide far weaker forces to continental-dominated plates lacking slabs", "isCorrect": true, "explanation": "Correct! In 1975, geophysicists Dan Forsyth and Seiya Uyeda performed a landmark statistical torque balance analysis comparing all the theoretical forces acting on Earth's tectonic plates (slab pull, ridge push, continental drag, basal shear, etc.). They discovered an overwhelming mathematical correlation: the velocity of a tectonic plate is directly proportional to the percentage of its perimeter occupied by subducting slabs. Plates with long subducting boundaries (the Pacific, Nazca, Cocos, and Indian plates) are actively dragged by the massive negative buoyancy of their sinking cold slabs (augmented by the dense eclogite phase transition), racing across the globe at 6 to 16 cm/year. In contrast, plates without subducting slabs (such as the Eurasian and African plates) rely almost entirely on relatively weak ridge push and basal traction, drifting slowly at only 1 to 3 cm/year." },
        { "text": "Because the Pacific Ocean is made of lighter water that allows plates to slide like ice skates", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because fast plates have gigantic rocket engines on their margins", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because earthquakes push plates with rocket-like shockwaves", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
