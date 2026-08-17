# Duofy Reusable Lesson Format: Silicate Mineral Classification and Tetrahedral Polymerization

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Mineralogy_and_Petrology`  
**Lesson Format Type:** `silicate_mineral_classification_and_tetrahedral_polymerization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the crystal chemistry, coordination geometry, and structural hierarchy of Earth's crustal minerals (William Lawrence Bragg 1930; Linus Pauling's Rules): analyze the fundamental **Silica Tetrahedron ($[\text{SiO}_4]^{4-}$)**, master the 6 major silicate subclasses defined by the degree of corner-sharing bridging oxygen atoms and $\text{Si:O}$ ratio (**Nesosilicates** [isolated, $\text{Si:O} = 1:4$, e.g. Olivine $(\text{Mg,Fe})_2\text{SiO}_4$, Garnet]; **Sorosilicates** [pairs, $\text{Si:O} = 2:7$, Epidote]; **Cyclosilicates** [rings, $\text{Si:O} = 1:3$, Beryl]; **Inosilicates** [single chain, $\text{Si:O} = 1:3$, Pyroxenes Augite; double chain, $\text{Si:O} = 4:11$, Amphiboles Hornblende]; **Phyllosilicates** [2D sheets, $\text{Si:O} = 2:5$, Micas Biotite/Muscovite, Clays]; and **Tectosilicates** [3D framework sharing all 4 oxygens, $\text{Si:O} = 1:2$, Quartz $\text{SiO}_2$, Feldspars]), and calculate electrical charge balancing with cations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Silicate Crystal Chemistry & Polymerization Hierarchy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Degree of Silica Tetrahedral Polymerization Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Silicate Subclass & Classic Mineral Example Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Fundamental Anionic Building Block of All Silicates Chemical Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cleavage Angle Distinction Between Single-Chain Pyroxene and Double-Chain Amphibole Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Silicate Crystal Chemistry & Classification (W.L. Bragg 1930):
   - **The Basic Building Block:**
     - The **Silica Tetrahedron ($[\text{SiO}_4]^{4-}$)**: One small central $\text{Si}^{4+}$ cation surrounded by four larger $\text{O}^{2-}$ anions in tetrahedral coordination ($sp^3$, bond length $\approx 1.62\text{ \AA}$).
   - **The 6 Silicate Structural Subclasses:**
     $$\begin{array}{|l|l|c|c|l|}
     \hline
     \textbf{Subclass} & \textbf{Polymerization Architecture} & \textbf{Shared Oxygens} & \mathbf{\text{Si:O Ratio}} & \textbf{Representative Minerals} \\
     \hline
     \textbf{Nesosilicates} & \text{Isolated } [\text{SiO}_4]^{4-} \text{ tetrahedra} & 0 & 1:4 & \text{Olivine, Garnet, Zircon, Topaz} \\
     \textbf{Sorosilicates} & \text{Paired } [\text{Si}_2\text{O}_7]^{6-} \text{ tetrahedra} & 1 & 2:7 & \text{Epidote, Lawsonite, Hemimorphite} \\
     \textbf{Cyclosilicates} & \text{Closed rings (3, 4, 6 units)} & 2 & 1:3 & \text{Beryl } (\text{Be}_3\text{Al}_2\text{Si}_6\text{O}_{18})\text{, Tourmaline} \\
     \textbf{Inosilicates (Single)} & \text{1D single chains } [\text{Si}_2\text{O}_6]^{4-} & 2 & 1:3 & \textbf{Pyroxenes} \ (\text{Augite, Diopside, Enstatite}) \\
     \textbf{Inosilicates (Double)} & \text{1D double chains } [\text{Si}_8\text{O}_{22}]^{12-} & 2 \text{ and } 3 & 4:11 & \textbf{Amphiboles} \ (\text{Hornblende, Actinolite, Tremolite}) \\
     \textbf{Phyllosilicates} & \text{2D sheets } [\text{Si}_4\text{O}_{10}]^{4-} & 3 & 2:5 & \textbf{Micas} \ (\text{Biotite, Muscovite})\text{, Talc, Clays} \\
     \textbf{Tectosilicates} & \text{3D framework (all oxygens shared)} & 4 & 1:2 & \textbf{Quartz } (\text{SiO}_2)\text{, Plagioclase, K-Feldspar} \\
     \hline
     \end{array}$$
   - **Pyroxene vs Amphibole Cleavage Angle:**
     - Pyroxenes (single chains): Cleavage planes intersect at nearly **$90^\circ$ ($87^\circ / 93^\circ$)**.
     - Amphiboles (double chains): Wider structural ribbons produce cleavage planes intersecting at **$60^\circ / 120^\circ$ ($56^\circ / 124^\circ$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps arranging silicate classes in order of increasing tetrahedral oxygen sharing and polymerization: (1) Nesosilicates with isolated tetrahedra sharing 0 bridging oxygen atoms (Si:O = 1:4), (2) Inosilicates single chains sharing 2 bridging oxygen atoms per tetrahedron (Si:O = 1:3), (3) Inosilicates double chains sharing alternately 2 and 3 bridging oxygen atoms (Si:O = 4:11), (4) Phyllosilicates 2D planar sheets sharing 3 bridging oxygen atoms (Si:O = 2:5), (5) Tectosilicates 3D infinite framework sharing all 4 bridging oxygen atoms (Si:O = 1:2)!
3. **Slide 3 (`matching`):** Pair 4 silicate mineral families (Olivine, Augite Pyroxene, Muscovite Mica, Quartz) with their crystal structure subclasses.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the fundamental anionic building block of all silicate minerals consists of an isolated silica tetrahedron containing 1 silicon and 4 oxygen atoms with the formula sio4. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on distinguishing pyroxenes from amphiboles in hand samples: In metamorphic and igneous petrology, how do geologists definitively distinguish single-chain pyroxenes from double-chain amphiboles under hand lens examination? (Pyroxenes have single tetrahedral chains producing **two perpendicular cleavage planes intersecting at approximately 90 degrees ($87^\circ / 93^\circ$)**, whereas amphiboles have wide double chains producing **two diamond-shaped cleavage planes intersecting at approximately 60 degrees and 120 degrees ($56^\circ / 124^\circ$)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "silicate_mineral_classification_and_tetrahedral_polymerization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Silicate Mineral Classification & Crystal Chemistry**\n• **The Fundamental Unit:** The **Silica Tetrahedron ($[\\text{SiO}_4]^{4-}$)** ($sp^3$ central $\\text{Si}^{4+}$ bounded to $4\\ \\text{O}^{2-}$ anions).\n• **The 6 Silicate Subclasses (Increasing Polymerization):**\n$$\n\\begin{array}{|l|c|c|l|}\n\\hline\n\\textbf{Silicate Class} & \\textbf{Shared Oxygens} & \\mathbf{\\text{Si:O Ratio}} & \\textbf{Classic Minerals} \\\\\n\\hline\n\\textbf{Nesosilicates (Isolated)} & 0 & 1:4 & \\text{Olivine, Garnet, Zircon} \\\\\n\\textbf{Sorosilicates (Pairs)} & 1 & 2:7 & \\text{Epidote, Lawsonite} \\\\\n\\textbf{Cyclosilicates (Rings)} & 2 & 1:3 & \\text{Beryl (Emerald), Tourmaline} \\\\\n\\textbf{Inosilicates (Single Chain)} & 2 & 1:3 & \\mathbf{\\text{Pyroxenes (Augite)}} \\ [90^\\circ \\text{ Cleavage}] \\\\\n\\textbf{Inosilicates (Double Chain)} & 2\\text{ and }3 & 4:11 & \\mathbf{\\text{Amphiboles (Hornblende)}} \\ [60^\\circ/120^\\circ \\text{ Cleavage}] \\\\\n\\textbf{Phyllosilicates (Sheets)} & 3 & 2:5 & \\mathbf{\\text{Micas (Biotite/Muscovite)}, \\text{Clays}} \\\\\n\\textbf{Tectosilicates (3D Framework)} & 4 & 1:2 & \\mathbf{\\text{Quartz } (\\text{SiO}_2), \\text{Feldspars}} \\\\\n\\hline\n\\end{array}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the silicate structural subclasses from lowest to highest degree of tetrahedral oxygen sharing.",
      "orderItems": [
        "Nesosilicates (isolated tetrahedra sharing 0 bridging oxygens; Si:O ratio = 1:4; e.g. Olivine)",
        "Inosilicates Single Chain (linear chains sharing 2 bridging oxygens; Si:O ratio = 1:3; e.g. Pyroxenes)",
        "Inosilicates Double Chain (interconnected chains sharing 2 and 3 oxygens; Si:O ratio = 4:11; e.g. Amphiboles)",
        "Phyllosilicates (infinite 2D sheets sharing 3 bridging oxygens; Si:O ratio = 2:5; e.g. Micas and Clays)",
        "Tectosilicates (complete 3D framework sharing all 4 bridging oxygens; Si:O ratio = 1:2; e.g. Quartz and Feldspar)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each silicate mineral to its precise structural classification.",
      "matchPairs": [
        { "left": "Olivine ((Mg,Fe)2SiO4)", "right": "Nesosilicate consisting of completely isolated [SiO4]4- tetrahedra bonded by Mg2+ and Fe2+ cations" },
        { "left": "Augite Pyroxene", "right": "Single-chain inosilicate featuring 2 shared oxygens and diagnostic ~90-degree cleavage angles" },
        { "left": "Muscovite Mica", "right": "Phyllosilicate composed of continuous 2D tetrahedral sheets exhibiting perfect basal cleavage" },
        { "left": "Quartz (SiO2)", "right": "Tectosilicate with a fully linked 3D framework where 100% of oxygen vertices are shared" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fundamental anionic building block of all silicate minerals consists of an isolated silica tetrahedron with the chemical formula ___.",
      "blankAnswer": "sio4",
      "blankDistractors": ["sio2", "si2o7", "sio3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How do geologists use cleavage angles under a hand lens to definitively differentiate single-chain pyroxenes from double-chain amphiboles in rock specimens?",
      "options": [
        { "text": "Single-chain pyroxenes possess two intersecting cleavage planes at nearly right angles (~90 degrees: 87° and 93°), whereas wider double-chain amphiboles exhibit cleavage planes that intersect at diagnostic diamond-like angles of 56° and 124° (~60° and ~120°)", "isCorrect": true, "explanation": "Correct! Cleavage in chain silicates is dictated by the underlying geometry of the silica tetrahedral chains and the intervening metal cation polyhedra (the 'I-beam' structural model). In pyroxenes, the repeating single-chain units are narrow, forcing planes of structural weakness to cut through the crystal lattice at approximately right angles (87 degrees and 93 degrees). In amphiboles, two single chains are cross-linked side-by-side into wide double chains, broadening the I-beam cross-section. Consequently, planes of weakness in amphiboles shear along the diagonal margins of the wider double chains, creating distinctive diamond-shaped prismatic cleavage planes that intersect at 56 degrees and 124 degrees (approximately 60 degrees and 120 degrees)." },
        { "text": "Pyroxenes have no cleavage and fracture like glass", "isCorrect": false, "explanation": "Incorrect: Quartz has no cleavage; pyroxenes have excellent cleavage." },
        { "text": "Amphiboles always dissolve in cold water while pyroxenes float", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pyroxenes are strictly magnetic while amphiboles glow in the dark", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
