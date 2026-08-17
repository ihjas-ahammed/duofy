# Duofy Reusable Lesson Format: Geographic Modes of Speciation (Allopatric vs Sympatric)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Speciation_and_Macroevolution`  
**Lesson Format Type:** `geographic_modes_of_speciation_allopatric_vs_sympatric`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the spatial geography, gene flow barriers, and ecological divergence mechanisms of speciation (Ernst Mayr 1942, Jerry Coyne & Allen Orr 2004, John Bush 1969): contrast **Allopatric Speciation** (**Vicariance** via geographic barriers like mountain ranges or the Isthmus of Panama vs **Peripatric Founder Isolation**) with **Parapatric Speciation** (clinal divergence along environmental gradients) and **Sympatric Speciation** (divergence without spatial isolation via **Plant Polyploidy [Autopolyploidy vs Allopolyploidy]**, **Ecological Host-Switching [Rhagoletis pomonella]**, and **Sexual Selection / Micro-Niche Specialization** in African crater lake cichlids).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Geographic Modes of Speciation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Isthmus of Panama Vicariant Speciation Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Speciation Mode & Biological Mechanism / Paradigm Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Speciation Mode Occurring Without Any Geographic Barrier Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Sympatric Speciation via Host-Shift in Apple Maggot Fly Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Geographic Modes of Speciation:
   - **The Spatial Spectrum of Speciation (Mayr 1942; Coyne & Orr 2004):**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Speciation Mode} & \textbf{Geographic Condition} & \textbf{Primary Driving Force} \\
     \hline
     \textbf{Allopatric (Vicariance)} & \text{Complete physical barrier splits range} & \text{Independent mutation, drift, selection} \\
     \textbf{Allopatric (Peripatric)} & \text{Small peripheral founder isolate} & \text{Founder effect drift + strong selection} \\
     \textbf{Parapatric} & \text{Continuous range with environmental gradient} & \text{Divergent selection across ecotone / hybrid zone} \\
     \textbf{Sympatric} & \mathbf{\text{Zero geographic isolation (complete overlap)}} & \text{Polyploidy, Host shifts, Disruptive selection} \\
     \hline
     \end{array}$$
   - **Classic Case Studies:**
     - **Vicariance:** The emergence of the Isthmus of Panama ($3\text{ Ma}$) severed the marine connection between Pacific and Atlantic, creating distinct sister-species pairs in snapping shrimp (*Alpheus*).
     - **Sympatric Polyploidy:** Instantaneous reproductive isolation in plants (e.g. diploid $2n \times 2n \to 4n$ tetraploid cannot backcross with $2n$ parents, forming sterile $3n$ triploids).
     - **Sympatric Ecological Host Shift:** *Rhagoletis pomonella* shifting from native hawthorn to introduced domestic apples, producing allochronic (temporal) and behavioral mating isolation in sympatry.
2. **Slide 2 (`ordering`):** Provide 5 steps of allopatric speciation via vicariance in snapping shrimp: (1) an ancestral panmictic population of snapping shrimp inhabits a continuous shallow seaway between North and South America, (2) tectonic uplift of the Isthmus of Panama ($3\text{ Ma}$) creates a physical land bridge, completely halting gene flow between Pacific and Caribbean populations, (3) isolated populations independently accumulate unique genetic mutations, undergo genetic drift, and adapt to different ocean temperatures and food profiles, (4) Dobzhansky-Muller genetic incompatibilities and behavioral courtship differences evolve as pleiotropic byproducts of divergent evolution, (5) when modern Pacific and Caribbean sister species are brought together in an aquarium, they fail to recognize each other's courtship displays and produce infertile hybrids, demonstrating complete speciation!
3. **Slide 3 (`matching`):** Pair 4 speciation categories (Allopatric Vicariance, Peripatric Founder Speciation, Sympatric Polyploidy, Sympatric Host-Shift) with their biological examples.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that speciation occurring within the same geographical range without any physical barrier is termed sympatric speciation. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sympatric speciation in the apple maggot fly (*Rhagoletis pomonella*): In North America, the native hawthorn fly *Rhagoletis pomonella* began infesting introduced domestic apples 160 years ago. Today, hawthorn and apple fly races live in the same orchards but do not interbreed. What mechanisms drive their ongoing sympatric speciation? (They exhibit **behavioral host-odor preference** [flies mate exclusively on their natal fruit] combined with **temporal allochrony** [apples ripen 3–4 weeks earlier than hawthorns, shifting adult emergence times and preventing mating overlap]).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "geographic_modes_of_speciation_allopatric_vs_sympatric",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Geographic Modes of Speciation**\n• **The Spatial Spectrum:**\n  - **1. Allopatric Speciation (Vicariance & Peripatric):**\n    - Complete physical barrier (mountain, river, isthmus) halts gene flow $\\implies$ Divergent selection and drift accumulate reproductive isolation.\n  - **2. Parapatric Speciation:**\n    - Continuous range across an environmental ecotone; divergent selection overcomes weak gene flow at hybrid zones.\n  - **3. Sympatric Speciation (Zero Physical Separation):**\n    - Reproductive isolation evolves within a single interbreeding population via:\n      - **Polyploidy in Plants:** Instantaneous genetic isolation ($2n \\to 4n$).\n      - **Host-Shifting:** Habitat/temporal allochrony (e.g. *Rhagoletis* apple maggot flies).\n      - **Disruptive Sexual Selection:** Color morph preference in African cichlids."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the stages of allopatric speciation by vicariance in Isthmus of Panama snapping shrimp (Alpheus).",
      "orderItems": [
        "A single ancestral marine population of snapping shrimp breeds freely across the open Central American seaway",
        "Geological uplift of the Isthmus of Panama creates an impenetrable terrestrial land bridge, severing gene flow",
        "The newly isolated Pacific and Caribbean populations accumulate independent mutations and experience divergent selection",
        "Genetic incompatibilities and courtship display divergence evolve independently in both oceans over 3 million years",
        "When modern Pacific and Caribbean sister species are reunited in an aquarium, they fail to mate, confirming complete speciation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each mode of speciation to its classic biological example.",
      "matchPairs": [
        { "left": "Allopatric Speciation by Vicariance", "right": "Snapping shrimp sister species separated on Pacific vs Caribbean sides of the Isthmus of Panama" },
        { "left": "Peripatric Speciation (Founder Effect)", "right": "Hawaiian Drosophila species diversifying after single gravid females colonize new volcanic islands" },
        { "left": "Sympatric Speciation via Polyploidy", "right": "Instantaneous speciation in flowering plants (e.g. hexaploid bread wheat Triticum aestivum)" },
        { "left": "Sympatric Speciation via Host-Shift", "right": "Rhagoletis pomonella flies dividing into apple-feeding and hawthorn-feeding races in the same orchard" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mode of speciation occurring within a single continuous geographic area with zero physical barriers to gene flow is called ___ speciation.",
      "blankAnswer": "sympatric",
      "blankDistractors": ["allopatric", "parapatric", "peripatric"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How did the apple maggot fly Rhagoletis pomonella evolve into two genetically distinct, non-interbreeding host races in North American orchards without any geographic barrier?",
      "options": [
        { "text": "Through BEHAVIORAL HOST FIDELITY (mating exclusively on their natal host fruit) and TEMPORAL ALLOCHRONY (apples ripen 3-4 weeks earlier than native hawthorn fruit, shifting adult emergence and mating windows so the two races never encounter each other)", "isCorrect": true, "explanation": "Correct! Sympatric speciation in Rhagoletis pomonella is the textbook example of ecological speciation. Flies exhibit strong olfactory preference for their natal fruit and mate exclusively on the fruit surface. Because domestic apples fruit nearly a month earlier than native hawthorns, apple-race flies emerge earlier in the season. This combination of host fidelity and temporal isolation drastically reduces gene flow, driving sympatric divergence." },
        { "text": "Because apple trees produce a poison that mutates all flies into mosquitoes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hawthorn flies were physically transported to Antarctica", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all apple flies became polyploid plants", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
