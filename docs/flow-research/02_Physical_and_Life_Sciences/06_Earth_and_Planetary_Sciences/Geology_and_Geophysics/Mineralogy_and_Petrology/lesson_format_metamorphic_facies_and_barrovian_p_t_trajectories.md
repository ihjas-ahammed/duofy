# Duofy Reusable Lesson Format: Metamorphic Facies and Barrovian P-T Trajectories

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Mineralogy_and_Petrology`  
**Lesson Format Type:** `metamorphic_facies_and_barrovian_p_t_trajectories`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid petrological, thermodynamic, and geotectonic mastery of metamorphic rock transformations in Pressure-Temperature ($\text{P-T}$) space (George Barrow 1893; Pentti Eskola 1915): master the classic **Pelitic Barrovian Regional Sequence** (**Shale $\to$ Slate $\to$ Phyllite $\to$ Schist $\to$ Gneiss $\to$ Migmatite** with diagnostic index minerals: **Chlorite $\to$ Biotite $\to$ Garnet [Almandine] $\to$ Staurolite $\to$ Kyanite $\to$ Sillimanite**), map the 7 fundamental **Metamorphic Facies** in $\text{P-T}$ space (**Zeolite, Greenschist, Amphibolite, Granulite, Hornfels [contact metamorphism], Blueschist [High P, Low T in subduction zones with diagnostic blue Glaucophane], and Eclogite [Mantle subduction $>1.5\text{ GPa}$ with Omphacite + Pyrope]**), and interact with live metamorphic $\text{P-T}$ facies trajectory simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Barrovian Zones & P-T Metamorphic Facies Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Barrovian Index Mineral / Facies & Geothermal Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Blueschist Facies High-Pressure Low-Temperature Subduction Zone Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Highest-Temperature Index Mineral in Barrovian Sequence Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Metamorphic P-T Facies Trajectory Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "metamorphic_facies_and_barrovian_p_t_trajectories",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the Barrovian metamorphic index zones and how do Metamorphic Facies map onto P-T space?",
      "blankAnswer": "Metamorphic petrology decodes crustal pressure-temperature histories (George Barrow 1893; Pentti Eskola 1915): (1) THE PELITIC BARROVIAN SEQUENCE (Increasing Grade): Protolith Shale -> Slate (slaty cleavage) -> Phyllite (silky sheen) -> Schist (coarse foliation) -> Gneiss (compositional banding) -> Migmatite (partial melting/anatexis). (2) BARROVIAN INDEX MINERALS (Low -> High T): Chlorite -> Biotite -> Garnet (Almandine) -> Staurolite -> Kyanite -> Sillimanite (highest temperature Al2SiO5 polymorph). (3) METAMORPHIC FACIES IN P-T SPACE: (a) Contact Metamorphism: Hornfels Facies (High T, Low P; shallow magma intrusions). (b) Regional Orogenic Metamorphism: Zeolite -> Greenschist (Chlorite/Epidote/Actinolite) -> Amphibolite (Hornblende/Plagioclase) -> Granulite (Pyroxene/Anhydrous). (c) Subduction Zone Metamorphism: BLUESCHIST FACIES: Characterized by HIGH PRESSURE, LOW TEMPERATURE (cold oceanic lithosphere plunged rapidly into deep subduction before heating up), containing diagnostic blue sodic amphibole GLAUCOPHANE and Lawsonite! ECLOGITE FACIES: Ultra-high pressure (>1.5 GPa) mantle-depth metamorphism containing green omphacite pyroxene and red pyrope garnet!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each metamorphic facies/zone to its defining mineral assemblage and P-T setting.",
      "matchPairs": [
        { "left": "Blueschist Facies", "right": "High Pressure, Low Temperature in subduction zones; diagnostic blue sodic amphibole Glaucophane" },
        { "left": "Greenschist Facies", "right": "Moderate P-T regional orogenic metamorphism dominated by chlorite, epidote, and actinolite" },
        { "left": "Hornfels Facies", "right": "High Temperature, Low Pressure contact aureoles adjacent to igneous plutons lacking foliation" },
        { "left": "Eclogite Facies", "right": "Ultra-high pressure (>1.5 GPa) deep subduction assemblage composed of omphacite pyroxene and pyrope garnet" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the Blueschist metamorphic facies (characterized by the blue sodic amphibole Glaucophane) uniquely formed in subduction zone environments rather than in normal continental collision zones?",
      "options": [
        { "text": "Subduction zones feature a unique 'HIGH PRESSURE, LOW TEMPERATURE' geothermal gradient; the cold, dense oceanic lithosphere plunges rapidly into the high-pressure mantle much faster than conductive heat from the surrounding mantle can warm it, stabilizing high-pressure low-temperature minerals like glaucophane and lawsonite", "isCorrect": true, "explanation": "Correct! Most regional metamorphic settings exhibit typical or elevated geothermal gradients (25 to 40 °C/km), passing through Greenschist -> Amphibolite -> Granulite facies as depth and temperature increase together. In contrast, at subduction zones, cold, water-saturated oceanic crust and trench sediments are dragged down at rates of centimeters per year into regions of immense lithostatic pressure (0.6 to 1.5+ GPa, depths of 20 to 50 km). Because rock is a poor conductor of heat, the descending slab remains relatively cold (200 to 450 °C) despite reaching immense pressures. This creates an abnormally low geothermal gradient (~10 °C/km). This unique high-P, low-T environment is the only thermodynamic regime in Earth's crust capable of stabilizing the diagnostic blue sodic amphibole Glaucophane, Lawsonite, and Jadeite—the hallmark of Blueschist facies." },
        { "text": "Because subduction zones contain huge pools of blue dye in the mantle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because glaucophane only crystallizes in the presence of sunlight", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because continental collision zones have zero pressure", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the classic Barrovian regional metamorphic sequence for pelitic rocks, the highest-temperature Al2SiO5 index mineral to appear before partial melting is ___.",
      "blankAnswer": "sillimanite",
      "blankDistractors": ["kyanite", "andalusite", "staurolite"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Metamorphic P-T Facies Trajectory Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Metamorphic P-T Facies & Tectonic Trajectory Engine</h3><p>Select Tectonic Regime:</p><button id=\"subBtn\" style=\"padding:8px 14px; margin:4px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Subduction Zone (Rapid Sinking Slab)</button><button id=\"oroBtn\" style=\"padding:8px 14px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Orogenic Mountain Belt (Continental Collision)</button><button id=\"conBtn\" style=\"padding:8px 14px; margin:4px; background:#f59e0b; color:white; border:none; border-radius:6px; cursor:pointer;\">Contact Aureole (Magma Chamber Intrusion)</button><div id=\"metaOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select a tectonic setting above...</div><script>document.getElementById('subBtn').onclick=()=>{document.getElementById('metaOut').innerText='P-T Trajectory: HIGH PRESSURE, LOW TEMPERATURE -> Facies: BLUESCHIST (Glaucophane + Lawsonite) -> Transitions at >1.5 GPa to ECLOGITE (Omphacite + Pyrope Garnet)!';}; document.getElementById('oroBtn').onclick=()=>{document.getElementById('metaOut').innerText='P-T Trajectory: MODERATE P, MODERATE-HIGH T (Barrovian Sequence) -> Facies: Zeolite -> Greenschist -> Amphibolite -> Granulite -> Migmatite (Anatexis)!';}; document.getElementById('conBtn').onclick=()=>{document.getElementById('metaOut').innerText='P-T Trajectory: HIGH TEMPERATURE, LOW PRESSURE -> Facies: HORNFELS / SANIDINITE -> Pyrometamorphism without tectonic foliation!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
