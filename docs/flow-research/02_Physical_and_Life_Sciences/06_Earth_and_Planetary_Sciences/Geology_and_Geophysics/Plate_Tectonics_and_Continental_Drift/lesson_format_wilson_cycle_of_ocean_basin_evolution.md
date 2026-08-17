# Duofy Reusable Lesson Format: The Wilson Cycle of Ocean Basin Evolution

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Plate_Tectonics_and_Continental_Drift`  
**Lesson Format Type:** `wilson_cycle_of_ocean_basin_evolution`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid global tectonic, paleogeographic, and cyclic mastery of supercontinent dispersal and ocean basin life cycles (J. Tuzo Wilson 1966, *Did the Atlantic Close and then Re-Open?*): master the 6 chronological stages of the **Wilson Cycle** (**1. Embryonic Rifting** [East African Rift; mantle plume thermal doming $\to$ grabens], **2. Juvenile Proto-Ocean** [Red Sea / Gulf of California; initial oceanic crust $\to$ narrow seaway], **3. Mature Ocean Basin** [Atlantic Ocean; broad seafloor spreading with passive continental margins], **4. Declining Ocean Basin** [Pacific Ocean; subduction initiation $\to$ trench/arc systems contracting the basin], **5. Terminal Narrowing** [Mediterranean Sea; progressive continental collision], and **6. Suturing / Relict Scar** [Himalayas / Indus-Yarlung Suture; orogenic collision, obduction of ophiolites, and supercontinent assembly]), and interact with live Wilson cycle ocean basin evolutionary simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 6 Stages of the Wilson Cycle Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Wilson Cycle Stage & Modern Earth Basin Example Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Red Sea vs Atlantic Ocean Wilson Cycle Evolutionary Stage Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Remnant Fragment of Ancient Oceanic Crust Obducted in Sutures Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Wilson Cycle Supercontinent & Ocean Basin Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "wilson_cycle_of_ocean_basin_evolution",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Wilson Cycle and what are the 6 stages in the life cycle of an ocean basin?",
      "blankAnswer": "The Wilson Cycle (J. Tuzo Wilson 1966) describes the periodic opening, expansion, contraction, and complete closure of ocean basins over 300 to 500 million years: (1) STAGE 1: EMBRYONIC (Continental Rifting): Mantle upwelling causes thermal doming, crustal extension, and normal-fault graben formation (Modern example: East African Rift Valley). (2) STAGE 2: JUVENILE (Proto-Ocean): Rifting breaks the continent completely; basaltic seafloor spreading forms a narrow, linear marine basin (Modern example: Red Sea, Gulf of California). (3) STAGE 3: MATURE (Broad Ocean): Continued symmetric seafloor spreading widens the ocean, flanked by sediment-covered, tectonically quiet passive continental margins without subduction (Modern example: Atlantic Ocean). (4) STAGE 4: DECLINING (Subduction Initiation): Oceanic lithosphere ages, densifies, and initiates subduction along plate boundaries; trenches and island arcs consume seafloor faster than ridges create it, contracting the basin (Modern example: Pacific Ocean). (5) STAGE 5: TERMINAL (Narrowing & Early Collision): Continued subduction narrows the ocean into a constricted, shallow sea as opposing continents approach (Modern example: Mediterranean Sea). (6) STAGE 6: SUTURING / RELICT SCAR (Continental Collision & Orogeny): Complete closure of the ocean basin; buoyant continents collide, thrusting up massive mountain belts and trapping fragments of ancient oceanic crust (OPHIOLITES) along the collision suture line (Modern example: The Himalayas / Indus-Yarlung Suture)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Wilson Cycle stage to its modern geographic analogue.",
      "matchPairs": [
        { "left": "Embryonic Stage (Continental Rifting)", "right": "East African Rift Valley (active continental crustal thinning and graben volcanism)" },
        { "left": "Juvenile Stage (Early Seafloor Spreading)", "right": "Red Sea (narrow proto-ocean basin with newly formed central basaltic rift)" },
        { "left": "Mature Stage (Broad Ocean with Passive Margins)", "right": "Atlantic Ocean (wide oceanic basin flanked by stable, non-subducting continental margins)" },
        { "left": "Suturing Stage (Orogenic Continental Collision)", "right": "Himalayas (complete ocean closure marked by ophiolites along the Indus Suture)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the modern Pacific Ocean classified as being in the 'Declining' stage of the Wilson Cycle, while the Atlantic Ocean is classified as 'Mature'?",
      "options": [
        { "text": "The Pacific Ocean is surrounded almost entirely by active subduction zones (the 'Ring of Fire') that consume oceanic lithosphere at a faster rate than the East Pacific Rise can generate it, progressively contracting the basin; whereas the Atlantic Ocean has almost no subduction zones, allowing seafloor spreading to continuously expand its width", "isCorrect": true, "explanation": "Correct! In the Wilson Cycle, an ocean's evolutionary stage is determined by the balance between crust creation at mid-ocean ridges and crust destruction at subduction zones. The Atlantic Ocean is in the 'Mature' stage because it has a central mid-ocean ridge but virtually no subduction zones on its margins (the coasts of the Americas, Europe, and Africa are stable passive margins); consequently, the Atlantic is actively growing wider by 2 to 4 cm every year. In contrast, the Pacific Ocean is in the 'Declining' stage because its margins are ringed by mature, aggressive subduction zones (the Ring of Fire: Mariana, Tonga, Kuril, Japan, Aleutian, Cascadia, and Peru-Chile trenches). These subduction zones consume ancient oceanic crust at rates of up to 10 to 16 cm/year, outpacing the creation rate of the East Pacific Rise and causing the Pacific Ocean basin to steadily shrink over geological time." },
        { "text": "Because the Pacific Ocean is running out of saltwater", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Atlantic Ocean was created 100 years ago by humans", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Pacific Ocean has no mid-ocean ridges anywhere", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A fossilized sliver of ancient oceanic lithosphere (ultramafic mantle, gabbro, sheeted dikes, pillow basalt) thrust onto a continent during terminal collision is called an ___.",
      "blankAnswer": "ophiolite",
      "blankDistractors": ["arkose", "granite", "evaporite"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Wilson Cycle Ocean Basin Evolutionary Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>The Wilson Supercontinent Cycle Engine</h3><p>Select Wilson Cycle Stage:</p><button id=\"w1Btn\" style=\"padding:6px 12px; margin:3px; background:#2563eb; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Embryonic (E. Africa)</button><button id=\"w2Btn\" style=\"padding:6px 12px; margin:3px; background:#0891b2; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Juvenile (Red Sea)</button><button id=\"w3Btn\" style=\"padding:6px 12px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">3. Mature (Atlantic)</button><button id=\"w4Btn\" style=\"padding:6px 12px; margin:3px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">4. Declining (Pacific)</button><button id=\"w6Btn\" style=\"padding:6px 12px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">6. Suturing (Himalayas)</button><div id=\"wilsonOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select a stage above...</div><script>document.getElementById('w1Btn').onclick=()=>{document.getElementById('wilsonOut').innerText='Stage 1: Continental Rifting -> Mantle plume doming -> Normal faults & rift valley (East African Rift)!';}; document.getElementById('w2Btn').onclick=()=>{document.getElementById('wilsonOut').innerText='Stage 2: Juvenile Seafloor Spreading -> Linear marine proto-ocean -> Basaltic crust forms (Red Sea)!';}; document.getElementById('w3Btn').onclick=()=>{document.getElementById('wilsonOut').innerText='Stage 3: Mature Ocean -> Broad symmetric spreading + passive continental margins without subduction (Atlantic)!';}; document.getElementById('w4Btn').onclick=()=>{document.getElementById('wilsonOut').innerText='Stage 4: Declining Basin -> Subduction initiation along Ring of Fire -> Seafloor destruction exceeds creation (Pacific)!';}; document.getElementById('w6Btn').onclick=()=>{document.getElementById('wilsonOut').innerText='Stage 6: Continental Suturing -> Complete ocean closure -> Mountain orogeny & Ophiolite obduction (Himalayas)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
