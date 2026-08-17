# Duofy Reusable Lesson Format: Cladistics, Synapomorphies, and Monophyly

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Phylogenetics_and_Molecular_Evolution`  
**Lesson Format Type:** `cladistics_synapomorphies_and_monophyly`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the foundational principles of phylogenetic systematics and cladistics (Willi Hennig, 1966): rigorously classify taxonomic groupings into **Monophyletic (Clades: common ancestor + ALL descendants)**, **Paraphyletic (ancestor + SOME but not all descendants)**, and **Polyphyletic (convergent taxa excluding common ancestor)**, distinguish character states based on evolutionary polarity (**Synapomorphy: shared derived character state defining a clade**, **Symplesiomorphy: shared primitive ancestral state uninformative for grouping**, and **Autapomorphy: unique derived state on a single branch**), and analyze classic systematic reclassifications (e.g. why "Reptilia" is paraphyletic unless it includes Aves/birds; why "Pisces" is paraphyletic unless it includes Tetrapoda).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cladistics & Hennigian Systematics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Cladistic Character Matrix Polarization Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Phylogenetic Group / Character State & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Shared Derived Character State Hennigian Term Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Paraphyly of Traditional Class Reptilia and Avian Inclusion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Cladistics & Hennigian Phylogenetic Systematics (Willi Hennig, 1966):
   - **The 3 Types of Taxonomic Groups:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Group Type} & \textbf{Definition} & \textbf{Classic Biological Example} \\
     \hline
     \textbf{Monophyletic (Clade)} & \text{Common ancestor } + \mathbf{\text{ALL descendants}} & \text{Mammalia, Aves, Archosauria} \\
     \textbf{Paraphyletic} & \text{Common ancestor } + \mathbf{\text{SOME descendants (excludes a clade)}} & \text{Traditional "Reptilia" (excludes Birds)} \\
     \textbf{Polyphyletic} & \text{Convergent grouping } \mathbf{\text{excluding common ancestor}} & \text{"Warm-blooded animals" (Homeotherms)} \\
     \hline
     \end{array}$$
   - **Hennigian Character State Classification:**
     1. **Synapomorphy:** **Shared derived trait** that evolved in the most recent common ancestor and is shared by all descendant members of the clade (e.g. mammary glands in mammals; feathers in birds). **Only synapomorphies define monophyletic clades!**
     2. **Symplesiomorphy:** **Shared primitive (ancestral) trait** retained from a deeper ancestor (e.g. ectothermy in lizards/snakes; five digits in primates). Cannot be used to unite a derived subgroup!
     3. **Autapomorphy:** Derived trait unique to a single terminal taxon (uninformative for grouping, but identifies that species).
     4. **Homoplasy:** Convergent trait evolved independently in multiple lineages (e.g. wings in birds and bats).
2. **Slide 2 (`ordering`):** Provide 5 steps constructing a cladogram using outgroup comparison: (1) select an ingroup of interest and an appropriate outgroup (a close relative that diverged prior to the common ancestor of the ingroup), (2) build a character matrix scoring morphological or molecular traits across all taxa, (3) polarize each character: the character state present in the outgroup is scored as ancestral (plesiomorphic = 0), while alternate states are scored as derived (apomorphic = 1), (4) identify shared derived character states (synapomorphies) that unite two or more ingroup taxa to the exclusion of others, (5) arrange the taxa into nested monophyletic clades organized strictly by shared synapomorphies to build the most parsimonious cladogram!
3. **Slide 3 (`matching`):** Pair 4 cladistic terms (Monophyletic Clade, Paraphyletic Group, Synapomorphy, Symplesiomorphy) with their phylogenetic definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in cladistic systematics, a shared derived character state that defines a monophyletic clade is a synapomorphy. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the paraphyly of traditional class "Reptilia": In Linnaean taxonomy, class "Reptilia" included lizards, snakes, turtles, and crocodiles, but excluded birds (class Aves). Why do modern phylogenetic cladists reject this traditional definition of Reptilia? (Because crocodiles share a more recent common ancestor with **birds (Aves) than they do with lizards or turtles**; therefore, excluding birds creates a **paraphyletic group** that fails to contain all descendants of the common reptile ancestor, requiring birds to be classified as living avian dinosaurs within the monophyletic clade Sauropsida/Reptilia).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cladistics_synapomorphies_and_monophyly",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cladistics, Synapomorphies, and Monophyly (Hennig 1966)**\n• **The 3 Group Topologies:**\n  - **Monophyletic (Clade):** A common ancestor and **ALL of its descendants** (e.g. Mammalia, Archosauria).\n  - **Paraphyletic:** A common ancestor and **SOME (but not all)** descendants (e.g. traditional 'Reptilia' excluding birds; 'Pisces' excluding tetrapods).\n  - **Polyphyletic:** Grouping formed by convergent homoplasy **without including the common ancestor** (e.g. 'Warm-blooded homeotherms').\n• **Character State Polarity:**\n  - **Synapomorphy:** **Shared Derived** character state $\\implies$ The *only* evidence uniting monophyletic clades (e.g. hair and mammary glands in mammals).\n  - **Symplesiomorphy:** Shared Ancestral state (e.g. cold-bloodedness; uninformative for grouping).\n  - **Autapomorphy:** Unique derived state restricted to a single taxon."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of cladistic character polarization and tree construction using outgroup analysis.",
      "orderItems": [
        "Select the ingroup taxa to be analyzed and choose a designated outgroup that diverged prior to the ingroup ancestor",
        "Assemble a discrete character-state data matrix scoring morphological or molecular traits for all taxa",
        "Polarize characters: designate character states found in the outgroup as ancestral (plesiomorphic) and alternate states as derived (apomorphic)",
        "Identify shared derived character states (synapomorphies) present in subsets of ingroup taxa",
        "Construct nested monophyletic clades supported strictly by shared synapomorphies to produce the most parsimonious cladogram"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each phylogenetic term to its exact cladistic definition.",
      "matchPairs": [
        { "left": "Monophyletic Clade", "right": "A taxonomic group comprising an ancestor and ALL of its evolutionary descendants" },
        { "left": "Paraphyletic Group", "right": "A group comprising an ancestor and only some of its descendants, unnaturally excluding a subgroup" },
        { "left": "Synapomorphy", "right": "A shared derived character state that evolved in an immediate ancestor and defines a monophyletic clade" },
        { "left": "Symplesiomorphy", "right": "A shared primitive ancestral character state retained from a more distant evolutionary ancestor" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Hennigian phylogenetic systematics, a shared derived character state that provides valid evidence for a monophyletic clade is called a ___.",
      "blankAnswer": "synapomorphy",
      "blankDistractors": ["symplesiomorphy", "autapomorphy", "homoplasy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the traditional Linnaean class 'Reptilia' (which included lizards, snakes, turtles, and crocodilians, but excluded birds) classified as PARAPHYLETIC in modern evolutionary biology?",
      "options": [
        { "text": "Crocodilians share a much more recent common ancestor with BIRDS (clade Archosauria) than they do with lizards or snakes; therefore, excluding birds leaves out a legitimate descendant lineage of the ancestral reptile, making 'Reptilia' paraphyletic", "isCorrect": true, "explanation": "Correct! In phylogenetic systematics, any valid taxonomic group must be monophyletic (containing an ancestor and all its descendants). Crocodiles and birds form the monophyletic clade Archosauria. If one defines 'Reptilia' to include crocodiles but exclude birds, one is artificially cutting off the avian branch of the archosaur family tree. To make Reptilia monophyletic, modern systematists include birds as living feathered dinosaurs within the clade Sauropsida/Reptilia." },
        { "text": "Because all reptiles are actually amphibians", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because birds evolved directly from mammals", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because turtles have no DNA", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
