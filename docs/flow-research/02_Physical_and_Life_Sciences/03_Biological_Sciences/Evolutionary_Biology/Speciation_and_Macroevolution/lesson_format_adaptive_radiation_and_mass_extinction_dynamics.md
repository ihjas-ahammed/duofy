# Duofy Reusable Lesson Format: Adaptive Radiation and Mass Extinction Dynamics

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Speciation_and_Macroevolution`  
**Lesson Format Type:** `adaptive_radiation_and_mass_extinction_dynamics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid macroevolutionary, ecological, and paleobiological mastery of macroevolutionary bursts and global biospheric turnover (George Gaylord Simpson 1944; David Raup & Jack Sepkoski 1982; Peter Ward): analyze **Adaptive Radiation** driven by **Ecological Opportunity** (island colonization, extinction of incumbents) or **Key Morphological Innovations** (e.g. pharyngeal jaws in cichlid fish, angiosperm floral structures, avian flight feathers), map the **"Big Five" Phanerozoic Mass Extinction Events** (End-Ordovician [445 Ma], Late Devonian [375 Ma], **End-Permian "Great Dying" [252 Ma; 96% marine extinction, Siberian Traps flood basalts]**, End-Triassic [201 Ma], and **End-Cretaceous K-Pg [66 Ma; Chicxulub asteroid impact wiping out non-avian dinosaurs and triggering the mammalian radiation]**), and interact with live mass extinction and recovery simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Adaptive Radiation & Mass Extinctions Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Mass Extinction Event & Primary Geological Cause Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | K-Pg Asteroid Impact and Mammalian Adaptive Radiation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Most Catastrophic Phanerozoic Mass Extinction Geological Period Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Mass Extinction & Post-Extinction Adaptive Radiation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "adaptive_radiation_and_mass_extinction_dynamics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What triggers an Adaptive Radiation, and what are the 'Big Five' mass extinction events in Earth history?",
      "blankAnswer": "Adaptive Radiation is the rapid diversification of a single ancestral lineage into an array of ecologically diverse species occupying distinct ecological niches (George Gaylord Simpson, 1944). It is triggered by two main catalysts: (1) Ecological Opportunity: Colonizing competitor-free archipelagoes (e.g. Hawaiian honeycreepers, Darwin's finches, East African rift lake cichlids) or post-extinction ecological vacuum. (2) Key Evolutionary Innovations: Novel phenotypic traits that unlock new adaptive zones (e.g. bird flight, pharyngeal jaws in teleost fish, insect wings). Mass Extinctions: Geologically abrupt biosphere collapses wiping out >75% of global species (Raup & Sepkoski, 1982). The 'Big Five': (1) End-Ordovician (~445 Ma; glaciation and sea level drop). (2) Late Devonian (~375 Ma; ocean anoxia). (3) End-Permian 'The Great Dying' (~252 Ma; Siberian Traps volcanism, runaway warming, oceanic acidification/anoxia; wiped out 96% of marine and 70% of terrestrial species). (4) End-Triassic (~201 Ma; CAMP flood basalts). (5) End-Cretaceous K-Pg (~66 Ma; Chicxulub asteroid impact + Deccan Traps volcanism; eradicated non-avian dinosaurs and ammonites, opening ecological space for the explosive Cenozoic Adaptive Radiation of Mammals)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each geological mass extinction event to its primary driver and evolutionary impact.",
      "matchPairs": [
        { "left": "End-Permian Extinction (252 Ma, 'Great Dying')", "right": "Siberian Traps massive flood basalt volcanism causing global warming, ocean anoxia, and 96% marine extinction" },
        { "left": "End-Cretaceous K-Pg Extinction (66 Ma)", "right": "10-km Chicxulub asteroid impact wiping out non-avian dinosaurs and unleashing the Cenozoic Mammalian Radiation" },
        { "left": "End-Ordovician Extinction (445 Ma)", "right": "Rapid Gondwana glaciation and falling sea levels decimating early marine invertebrate biodiversity" },
        { "left": "Ecological Opportunity (Adaptive Radiation)", "right": "Colonization of isolated volcanic archipelagos with abundant empty ecological niches" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why did mammals, which existed as small nocturnal insectivores throughout the 140-million-year Mesozoic Era, experience an explosive, massive adaptive radiation into whales, bats, ungulates, and primates specifically during the early Cenozoic Era (66-50 Ma)?",
      "options": [
        { "text": "The K-Pg mass extinction wiped out the dominant non-avian dinosaurs, creating an unprecedented ECOLOGICAL VACUUM with vacant terrestrial, aerial, and marine ecological niches that surviving mammalian lineages rapidly radiated into", "isCorrect": true, "explanation": "Correct! Mammals coexisted with dinosaurs for over 140 million years, but their diversification was ecologically suppressed by established dinosaurian competitors and predators. When the Chicxulub asteroid impact wiped out all non-avian dinosaurs at the Cretaceous-Paleogene (K-Pg) boundary, it cleared the global ecological stage. The surviving small mammals experienced tremendous ecological opportunity, undergoing one of the fastest adaptive radiations in Earth history to fill large herbivore, apex carnivore, marine, and aerial niches." },
        { "text": "Because mammals suddenly evolved four extra hearts", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all plants turned into cheese", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the gravity of the Earth dropped by 90%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The most catastrophic mass extinction in Earth history, which occurred approximately 252 million years ago and wiped out over 90% of marine species, was the End-___ extinction.",
      "blankAnswer": "permian",
      "blankDistractors": ["cretaceous", "jurassic", "triassic"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Mass Extinction & Radiation Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Phanerozoic Biosphere Turnover Simulator</h3><p>Event: End-Cretaceous (K-Pg, $66\\text{ Ma}$) Asteroid Impact</p><button id=\"extBtn\" style=\"padding:8px 20px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Trigger Chicxulub Impact & Track Mammalian Recovery</button><div id=\"extOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('extBtn').onclick=()=>{document.getElementById('extOut').innerText='Biospheric Timeline: (1) t = 0: 10-km bolide impact at Chicxulub -> Wildfires, impact winter, photosynthesis collapses. Non-avian dinosaurs extinct. (2) t + 500 kyr: Fern spike & recovery of small generalist mammals. (3) t + 10 Myr (Eocene): Massive Adaptive Radiation! Ungulates, Cetaceans (Whales), Primates, Bats occupy empty ecological zones!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
