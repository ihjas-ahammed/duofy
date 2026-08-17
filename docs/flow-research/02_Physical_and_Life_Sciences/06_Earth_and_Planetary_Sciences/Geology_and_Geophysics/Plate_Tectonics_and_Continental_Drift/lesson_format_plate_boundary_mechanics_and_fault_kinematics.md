# Duofy Reusable Lesson Format: Plate Boundary Mechanics and Fault Kinematics

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Plate_Tectonics_and_Continental_Drift`  
**Lesson Format Type:** `plate_boundary_mechanics_and_fault_kinematics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanical stress regimes, kinematic fault displacements, and volcanic-seismic signatures of the 3 major tectonic plate boundary classes (J. Tuzo Wilson 1965; Dan McKenzie & Robert Parker 1967): contrast **Divergent Boundaries** (tensional stress, **normal faulting**, continental rifting [East African Rift] $\to$ mid-ocean ridges [Mid-Atlantic Ridge] with shallow basaltic decompression melting), **Convergent Boundaries** (compressional stress, **reverse / megathrust faulting**, subduction zones [Oceanic-Continental: Cascadia/Andes; Oceanic-Oceanic: Marianas/Aleutians; Wadati-Benioff deep seismic zones; flux-melting arc volcanism] vs Continental-Continental Collisions [Himalayas: crustal thickening with zero volcanism]), and **Transform Boundaries** (shear stress, horizontal **strike-slip faulting**, e.g. San Andreas Fault, oceanic fracture zones offsetting ridge segments without creating or destroying lithosphere).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Plate Boundary Classes, Fault Regimes, & Volcanism Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Subduction Zone Arc Magmatism Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boundary Type / Example & Fault Kinematics / Volcanic State Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Dominant Stress Regime at Divergent Plate Boundaries Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Lack of Volcanism in Continental-Continental Collisions Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Plate Boundary Mechanics & Kinematics (Wilson 1965):
   - **The 3 Fundamental Boundary Classes:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Boundary Class} & \textbf{Stress Regime} & \textbf{Dominant Faults} & \textbf{Volcanic Mechanism} & \textbf{Classic Examples} \\
     \hline
     \textbf{Divergent} & \text{Tension } (\sigma_1 \text{ vertical}) & \mathbf{\text{Normal faults}} & \text{Decompression melting of peridotite} & \text{Mid-Atlantic Ridge, East Africa} \\
     \textbf{Convergent (Subduction)} & \text{Compression } (\sigma_1 \text{ horizontal}) & \mathbf{\text{Megathrust / Reverse}} & \mathbf{\text{Flux melting}} \ (\text{slab } \text{H}_2\text{O} \text{ lowers solidus}) & \text{Cascadia, Andes, Marianas} \\
     \textbf{Convergent (Collision)} & \text{Compression } (\sigma_1 \text{ horizontal}) & \mathbf{\text{Thrust faults / nappes}} & \mathbf{\text{NONE}} \ (\text{no subducting oceanic crust}) & \textbf{Himalayas (Tibetan Plateau)} \\
     \textbf{Transform} & \text{Shear } (\sigma_1, \sigma_3 \text{ horizontal}) & \mathbf{\text{Strike-slip faults}} & \mathbf{\text{NONE}} \ (\text{conservative boundary}) & \textbf{San Andreas Fault, Alpine Fault} \\
     \hline
     \end{array}$$
   - **Wadati-Benioff Zone:** Dipping planar zone of deep-focus earthquakes ($0-700\text{ km}$) tracing the brittle interior of subducting oceanic lithosphere.
2. **Slide 2 (`ordering`):** Provide 5 steps of the subduction-zone arc magmatism cascade: (1) dense oceanic lithosphere descends into the mantle along a subduction zone beneath an overriding plate, (2) increasing temperature and pressure drive metamorphic dehydration of hydrous minerals in the subducting slab, releasing supercritical H2O fluids, (3) water fluids ascend into the hot overlying mantle wedge, drastically lowering the solidus melting temperature of peridotite (flux melting), (4) buoyant basaltic/andesitic partial melt rises through the crust, undergoing fractional crystallization and crustal assimilation, (5) magma feeds surface volcanic arcs (e.g. Mount St. Helens, Mount Fuji), building explosive composite stratovolcanoes!
3. **Slide 3 (`matching`):** Pair 4 plate boundaries (Mid-Atlantic Ridge, Cascadia Subduction Zone, San Andreas Fault, Himalayan Orogen) with their stress regimes and volcanic traits.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the dominant mechanical stress regime operating at divergent plate boundaries is tension. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why continental-continental collisions (like the Himalayas) produce massive mountains and intense earthquakes but zero volcanic arc activity: Why are active volcanoes absent in the Himalayan mountain range despite intense ongoing tectonic convergence? (Because **both the Indian and Eurasian continental plates are composed of thick, buoyant, low-density granitic crust ($\rho \approx 2.7\text{ g/cm}^3$) that cannot subduct deep into the denser mantle**; without a subducting oceanic slab releasing water, **flux melting in the mantle wedge cannot occur**, eliminating the source of arc volcanism).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "plate_boundary_mechanics_and_fault_kinematics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Plate Boundary Mechanics & Kinematics (1965)**\n• **1. Divergent (Tensional Stress):**\n  - **Normal faulting** + **Decompression melting** of mantle peridotite $\\implies$ Mid-Atlantic Ridge, East African Rift.\n• **2. Convergent (Compressional Stress):**\n  - **Subduction (O-C or O-O):** **Megathrust faults** + **Flux melting** (slab $\\text{H}_2\\text{O}$ lowers mantle solidus) $\\implies$ Volcanic arcs (Cascadia, Andes, Marianas) + **Wadati-Benioff deep seismic zones** ($0\\text{--}700\\text{ km}$).\n  - **Continental Collision (C-C):** Extreme **crustal thickening & thrusting** $\\implies$ Himalayas (Alps) with **ZERO volcanism**!\n• **3. Transform (Shear Stress):**\n  - **Strike-slip faulting** $\\implies$ San Andreas Fault (conservative boundary; no creation/destruction of lithosphere)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential geodynamic steps that generate explosive volcanic arcs at subduction zones.",
      "orderItems": [
        "Hydrated, dense oceanic lithosphere is forced beneath an overriding plate into the asthenosphere",
        "Rising pressure and temperature trigger dehydration reactions, expelling supercritical water from the subducting slab",
        "Aqueous fluids infiltrate the overlying mantle wedge, dramatically lowering the melting temperature of peridotite (flux melting)",
        "Partial melts rise through the lithosphere, differentiating from mafic to intermediate/felsic magmas via crustal assimilation",
        "Volatile-rich magma erupts explosively at the surface, constructing chains of stratovolcanoes parallel to the trench"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each tectonic plate boundary to its specific kinematic and volcanic signature.",
      "matchPairs": [
        { "left": "Mid-Atlantic Ridge (Divergent)", "right": "Tensional normal faulting with basaltic decompression melting creating new oceanic crust" },
        { "left": "Cascadia Subduction Zone (Convergent O-C)", "right": "Compressional megathrust faulting with flux-melted andesitic stratovolcanoes and deep Benioff seismicity" },
        { "left": "San Andreas Fault (Transform)", "right": "Horizontal right-lateral strike-slip shearing with shallow earthquakes and complete absence of volcanism" },
        { "left": "Himalayan Orogeny (Convergent C-C)", "right": "Intense compressional crustal shortening and thrusting with colossal mountains and zero active volcanism" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The primary mechanical stress regime driving crustal extension and normal faulting at divergent plate boundaries is ___.",
      "blankAnswer": "tension",
      "blankDistractors": ["compression", "shear", "torsion"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the collision of India and Eurasia in the Himalayas characterized by extreme mountain uplift and massive earthquakes, yet completely lacks active volcanic arc eruptions?",
      "options": [
        { "text": "Both continental plates are composed of buoyant, low-density felsic/granitic crust (~2.7 g/cm³) that resists subduction into the denser mantle; without a descending water-saturated oceanic slab to dehydrate and induce flux melting in the mantle wedge, no volcanic magma is generated", "isCorrect": true, "explanation": "Correct! Volcanism at convergent boundaries is not caused by friction or heat of collision; it is caused specifically by 'flux melting'—where a descending, hydrated oceanic slab sinks into the hot asthenosphere and dehydrates, releasing water into the overlying mantle wedge to lower the melting point of peridotite. In continental-continental collisions (like the ongoing collision between India and Eurasia), the intervening Neo-Tethys oceanic lithosphere has already completely subducted. Both remaining colliding plates consist of thick, highly buoyant continental crust (density ~2.7 g/cm³, far lighter than the mantle's ~3.3 g/cm³). Because continental crust is too buoyant to subduct deep into the mantle, it crumples, buckles, and stacks along massive thrust faults to produce colossal crustal thickening (doubling crustal thickness to ~70 km under the Tibetan Plateau). In the absence of a subducting oceanic slab releasing water into a mantle wedge, flux melting cannot occur, resulting in total absence of arc volcanism." },
        { "text": "Because the Himalayas are too cold for lava to stay liquid", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because continental collisions only occur on waterless planets", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because earthquake vibrations shake out all the magma before it can erupt", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
