# Duofy Reusable Lesson Format: Thermal Dimorphism and Endemic Mycoses

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Mycology_and_Parasitology / Fungal_Pathogens`  
**Lesson Format Type:** `thermal_dimorphism_and_endemic_mycoses`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular adaptations, geographic epidemiology, microscopic histopathologies, and clinical features of the major thermally dimorphic endemic fungi (Chester Emmons; K.J. Kwon-Chung): master the fundamental principle of thermal dimorphism (**"Mold in the Cold [$25^\circ\text{C}$] $\to$ Yeast in the Beast [$37^\circ\text{C}$]"**), contrast the 4 classical systemic dimorphic pathogens (**1. *Histoplasma capsulatum*:** Mississippi/Ohio River valleys, bird/bat guano, tiny intracellular yeasts inside macrophages; **2. *Blastomyces dermatitidis*:** Great Lakes and Eastern US, large yeasts with distinctive **Broad-Based Budding**; **3. *Coccidioides immitis/posadasii*:** San Joaquin Valley and Southwestern US deserts, thick-walled **Spherules packed with Endospores** [Valley Fever]; **4. *Paracoccidioides brasiliensis*:** Latin America, large yeasts with multiple peripheral buds resembling a **"Captain's Wheel"**), and evaluate clinical diagnostics and antifungal treatment with Itraconazole or Amphotericin B.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Thermal Dimorphism & Endemic Fungi Overview Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Coccidioides Inhalation, Spherule Maturation, and Endospore Rupture Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Endemic Fungal Species & Characteristic Microscopic Morphology Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Blastomyces Characteristic Yeast Budding Base Adjective Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Histoplasma Capsulatum Intracellular Macrophage Sequestration Pathology Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Thermal Dimorphism & The 4 Endemic Mycoses:
   - **The Dimorphic Paradigm:**
     - **Environmental Soil / In Vitro ($25^\circ\text{C}$):** Exists as a filamentous **Mold (Hyphae)** bearing infectious conidia / arthroconidia.
     - **Host Tissue In Vivo ($37^\circ\text{C}$):** Transforms into a **Yeast (or Spherule)**, altering cell wall glucans ($\alpha$-glucans) to evade macrophage destruction.
   - **The 4 Major Systemic Endemic Mycoses:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Fungal Pathogen} & \textbf{Geographic Endemicity} & \textbf{Tissue Form at } 37^\circ\text{C} & \textbf{Classic Microscopic Hallmark} \\
     \hline
     \textbf{Histoplasma capsulatum} & \text{Mississippi / Ohio River Valleys} & \text{Tiny oval yeasts (} 2-4\ \mu\text{m)} & \mathbf{\text{Intracellular inside macrophages}} \text{ (bird/bat guano)} \\
     \textbf{Blastomyces dermatitidis} & \text{Great Lakes, Ohio River, East US} & \text{Large round yeasts (} 8-15\ \mu\text{m)} & \mathbf{\text{Broad-based budding}} \text{ (same width as mother cell)} \\
     \textbf{Coccidioides immitis} & \text{Southwestern US (San Joaquin Valley)} & \mathbf{\text{Large Spherules}} \ (20-100\ \mu\text{m}) & \mathbf{\text{Filled with dozens of round endospores}} \\
     \textbf{Paracoccidioides brasiliensis} & \text{Latin America (Brazil, Colombia)} & \text{Large yeast with multiple buds} & \mathbf{\text{"Captain's wheel" / "Mickey Mouse head"}} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of *Coccidioides immitis* pathogenesis: (1) environmental disturbances (earthquakes or dust storms in the desert) aerosolize infectious barrel-shaped arthroconidia from dry soil, (2) a human host inhales the microscopic arthroconidia deep into the pulmonary alveoli, (3) at body temperature (37°C), the arthroconidium swells dramatically to form a giant thick-walled multinucleated spherule (20-100 micrometers), (4) internal nuclear division and progressive cleavage package the spherule with hundreds of round endospores, (5) the mature spherule ruptures, discharging hundreds of endospores into surrounding lung tissue to form new spherules or disseminate systemically (Valley Fever)!
3. **Slide 3 (`matching`):** Pair 4 endemic fungi (Histoplasma, Blastomyces, Coccidioides, Paracoccidioides) with their microscopic tissue hallmarks (Intracellular Macrophage Yeasts, Broad-Based Budding Yeasts, Endospore-Filled Spherules, Captain's Wheel Multiple-Budding Yeasts).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the microscopic morphological appearance of Blastomyces dermatitidis in tissue is yeast with broad-based budding. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on *Histoplasma capsulatum* clinical presentation: A cave explorer develops fever, cough, and hepatosplenomegaly after exploring a bat-inhabited cavern in Ohio. A bone marrow biopsy reveals numerous tiny oval organisms inside the cytoplasm of macrophages. What fungal pathogen is responsible, and what environmental reservoir is classic for this organism? (*Histoplasma capsulatum*, which thrives in soil enriched with **nitrogen from bird and bat guano in the Ohio and Mississippi River Valleys**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "thermal_dimorphism_and_endemic_mycoses",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Thermal Dimorphism & Endemic Mycoses**\n• **The Golden Rule:** **'Mold in the Cold ($25^\\circ\\text{C}$), Yeast in the Beast ($37^\\circ\\text{C}$)'**.\n• **The 4 Classic Systemic Endemic Fungi:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Pathogen} & \\textbf{Endemic Region} & \\textbf{Host Morphology } (37^\\circ\\text{C}) & \\textbf{Microscopic Hallmark} \\\\\n\\hline\n\\textbf{Histoplasma} & \\text{Mississippi/Ohio Rivers} & \\text{Tiny oval yeasts } (2\\text{--}4\\ \\mu\\text{m}) & \\mathbf{\\text{Intracellular in macrophages}} \\\\\n\\textbf{Blastomyces} & \\text{Great Lakes, Eastern US} & \\text{Large round yeasts } (8\\text{--}15\\ \\mu\\text{m}) & \\mathbf{\\text{Broad-based budding}} \\\\\n\\textbf{Coccidioides} & \\text{Southwestern US deserts} & \\mathbf{\\text{Giant Spherules}} \\ (20\\text{--}100\\ \\mu\\text{m}) & \\mathbf{\\text{Packed with endospores}} \\\\\n\\textbf{Paracoccidioides} & \\text{Latin America} & \\text{Large multiple-budded yeast} & \\mathbf{\\text{Captain's wheel pattern}} \\\\\n\\hline\n\\end{array}\n$$\n• **Transmission:** Inhalation of environmental aerosolized conidia; zero person-to-person spread!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Coccidioides immitis infection and parasitic spherule cycle.",
      "orderItems": [
        "Aerosolized arthroconidia from dry desert soil are inhaled into the host's pulmonary alveoli",
        "At body temperature (37°C), the inhaled arthroconidium enlarges into a spherical multinucleated structure",
        "The organism develops into a giant, thick-walled spherule measuring 20 to 100 micrometers in diameter",
        "Repeated internal cleavage packages hundreds of microscopic uninucleated endospores inside the spherule",
        "The mature spherule ruptures, discharging endospores into the tissue to nucleate new spherules (Valley Fever)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each endemic dimorphic fungus to its diagnostic microscopic appearance in tissue.",
      "matchPairs": [
        { "left": "Histoplasma capsulatum", "right": "Tiny oval yeast cells clustered intracellularly inside the cytoplasm of host macrophages" },
        { "left": "Blastomyces dermatitidis", "right": "Large, thick-walled spherical yeast exhibiting broad-based single budding with double contours" },
        { "left": "Coccidioides immitis", "right": "Giant thick-walled spherules filled with numerous small round endospores in desert valley fever" },
        { "left": "Paracoccidioides brasiliensis", "right": "Large central mother yeast surrounded by multiple radiating daughter buds resembling a ship's captain's wheel" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In tissue biopsies, Blastomyces dermatitidis is microscopically identified by large, double-contoured yeasts exhibiting ___-based budding.",
      "blankAnswer": "broad",
      "blankDistractors": ["narrow", "filamentous", "multiple"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 35-year-old spelunker presents with fever, dry cough, and granulomatous lung lesions after exploring bat-inhabited caves along the Ohio River valley. Tissue biopsy reveals numerous tiny (2-4 µm) intracellular yeast cells packed inside macrophages. What is the diagnosis?",
      "options": [
        { "text": "HISTOPLASMOSIS (Histoplasma capsulatum); an endemic dimorphic fungus whose spores contaminate soils enriched with bird and bat droppings (guano) throughout the Ohio and Mississippi River valleys", "isCorrect": true, "explanation": "Correct! Histoplasma capsulatum is an endemic dimorphic fungus highly prevalent in the Ohio and Mississippi River valleys. It grows as a mold in soil containing high concentrations of nitrogen from bird or bat guano (frequently encountered by cave spelunkers or demolition workers). Inhaled microconidia transform at 37°C into tiny oval yeasts (2-4 µm) that are phagocytosed by alveolar macrophages. Instead of being killed, Histoplasma yeasts survive and multiply within the phagolysosome by raising vacuolar pH, resulting in macrophages filled with intracellular yeast cells." },
        { "text": "Aspergilloma", "isCorrect": false, "explanation": "Incorrect: Aspergillus forms branching hyphae, not intracellular yeasts." },
        { "text": "Cryptococcal Meningitis", "isCorrect": false, "explanation": "Incorrect: Cryptococcus has a massive extracellular capsule." },
        { "text": "Toxoplasmosis", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
