# Duofy Reusable Lesson Format: Bowen's Reaction Series and Igneous Differentiation

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Mineralogy_and_Petrology`  
**Lesson Format Type:** `bowens_reaction_series_and_igneous_differentiation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic crystallization sequence, magmatic differentiation, and rock classification of igneous systems (Norman L. Bowen 1928, *The Evolution of the Igneous Rocks*): master the **Discontinuous Branch** of mafic minerals (high-temperature isolated **Olivine [$\approx 1400^\circ\text{C}$] $\to$ Pyroxene $\to$ Amphibole $\to$ Biotite Mica** reacting sequentially with the silicate melt), the **Continuous Branch** of plagioclase feldspars (**Calcium-rich Anorthite $\to$ Sodium-rich Albite** via coupled substitution $\text{Ca}^{2+}\text{Al}^{3+} \rightleftharpoons \text{Na}^+\text{Si}^{4+}$), and the **Residual Low-Temperature Eutectic Melt ($600-750^\circ\text{C}$)** (**K-Feldspar [Orthoclase] $\to$ Muscovite Mica $\to$ Quartz**), and connect mineral assemblages to igneous rock textures and compositions (**Ultramafic/Peridotite $\to$ Mafic/Gabbro/Basalt $\to$ Intermediate/Diorite/Andesite $\to$ Felsic/Granite/Rhyolite**).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bowen's Reaction Series & Magmatic Fractionation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Discontinuous Branch Cooling Crystallization Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Igneous Rock Composition / Texture & Mineral Assemblage Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | First High-Temperature Mineral to Crystallize in Discontinuous Branch Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Magmatic Incompatibility of High-Temperature Olivine and Free Quartz Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bowen's Reaction Series (Norman L. Bowen 1928):
   - **The Two Parallel Crystallization Branches:**
     $$\begin{array}{|c|c|}
     \hline
     \mathbf{\text{Discontinuous Branch (Mafic Iron-Magnesium)}} & \mathbf{\text{Continuous Branch (Felsic Plagioclase)}} \\
     \hline
     \mathbf{\text{Olivine } (\approx 1400^\circ\text{C}, \text{Nesosilicate})} & \mathbf{\text{Ca-Rich Plagioclase (Anorthite } \text{CaAl}_2\text{Si}_2\text{O}_8)} \\
     \downarrow & \downarrow \\
     \mathbf{\text{Pyroxene } (\text{Augite}, \text{Single Chain})} & \text{Intermediate (Bytownite, Labradorite, Andesine)} \\
     \downarrow & \downarrow \\
     \mathbf{\text{Amphibole } (\text{Hornblende}, \text{Double Chain})} & \downarrow \\
     \downarrow & \mathbf{\text{Na-Rich Plagioclase (Albite } \text{NaAlSi}_3\text{O}_8)} \\
     \mathbf{\text{Biotite Mica } (\text{Sheet Silicate})} & \\
     \hline
     \multicolumn{2}{|c|}{\mathbf{\text{Residual Low-Temperature Melt } (600-750^\circ\text{C})}} \\
     \multicolumn{2}{|c|}{\mathbf{\text{Potassium Feldspar (Orthoclase)} \longrightarrow \text{Muscovite Mica} \longrightarrow \text{Quartz } (\text{SiO}_2)}} \\
     \hline
     \end{array}$$
   - **Igneous Rock Classification:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Composition} & \textbf{Dominant Minerals} & \textbf{Intrusive (Plutonic)} & \textbf{Extrusive (Volcanic)} \\
     \hline
     \textbf{Ultramafic} & \text{Olivine, Pyroxene} & \textbf{Peridotite} & \textbf{Komatiite} \\
     \textbf{Mafic} & \text{Pyroxene, Ca-Plagioclase} & \textbf{Gabbro} & \textbf{Basalt} \\
     \textbf{Intermediate} & \text{Amphibole, Na-Ca Plagioclase} & \textbf{Diorite} & \textbf{Andesite} \\
     \textbf{Felsic} & \text{Quartz, K-Feldspar, Muscovite} & \textbf{Granite} & \textbf{Rhyolite} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of mineral crystallization along the discontinuous branch of Bowen's reaction series as a basaltic magma cools: (1) at high temperatures around 1400°C, isolated magnesium-rich olivine crystals nucleate and precipitate from the melt, (2) as the temperature drops, olivine reacts with the surrounding silica-rich melt to form single-chain pyroxene (augite), (3) with further cooling, pyroxene reacts with the liquid to form double-chain amphibole (hornblende), (4) continued cooling converts amphibole into hydrous sheet-silicate biotite mica, (5) the remaining silica- and potassium-rich residual melt solidifies at low temperatures into potassium feldspar, muscovite, and pure quartz!
3. **Slide 3 (`matching`):** Pair 4 igneous rocks (Basalt, Granite, Peridotite, Diorite) with their textural and mineral compositions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the highest temperature mineral to crystallize first in the discontinuous branch of Bowen's reaction series is olivine. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the thermodynamic incompatibility of minerals in Bowen's reaction series: Why are high-temperature magnesium-rich Olivine and primary igneous Quartz ($\text{SiO}_2$) almost never found coexisting in thermodynamic equilibrium within the same igneous rock? (Because **Olivine is a silica-undersaturated mineral; if free silica ($\text{SiO}_2$) is present in the magma, it spontaneously reacts with olivine via the reaction $\text{Mg}_2\text{SiO}_4 + \text{SiO}_2 \to 2\text{MgSiO}_3$ to form Pyroxene (Enstatite)**, consuming either all the olivine or all the free silica).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bowens_reaction_series_and_igneous_differentiation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bowen's Reaction Series & Magmatic Fractionation (1928)**\n• **The Discontinuous Branch (Mafic):**\n$$\n\\mathbf{\\text{Olivine } (1400^\\circ\\text{C}) \\longrightarrow \\text{Pyroxene} \\longrightarrow \\text{Amphibole} \\longrightarrow \\text{Biotite Mica}}\n$$\n• **The Continuous Branch (Felsic Plagioclase Solid Solution):**\n$$\n\\mathbf{\\text{Ca-Plagioclase (Anorthite)} \\longrightarrow \\text{Na-Plagioclase (Albite)}}\n$$\n• **Residual Low-Temperature Crystallization ($600\\text{--}750^\\circ\\text{C}$):**\n$$\n\\mathbf{\\text{K-Feldspar (Orthoclase)} \\longrightarrow \\text{Muscovite Mica} \\longrightarrow \\text{Quartz } (\\text{SiO}_2)}\n$$\n• **Rock Chemistry Matrix:**\n  - **Ultramafic:** Peridotite (Plutonic) | **Mafic:** Gabbro / Basalt\n  - **Intermediate:** Diorite / Andesite | **Felsic:** Granite / Rhyolite"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the minerals of the discontinuous branch from highest crystallization temperature to lowest.",
      "orderItems": [
        "Olivine (highest temperature ~1400°C; isolated nesosilicate tetrahedra crystallizing from mafic melt)",
        "Pyroxene (augite/enstatite; single-chain inosilicate formed as melt reacts with early olivine)",
        "Amphibole (hornblende; hydrous double-chain inosilicate crystallizing at intermediate temperatures)",
        "Biotite (black sheet-silicate mica incorporating potassium, iron, and structural hydroxyl groups)",
        "Quartz (lowest temperature ~600-700°C; 3D framework tectosilicate forming from final silica-saturated melt)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each igneous rock type to its defining petrological characteristics.",
      "matchPairs": [
        { "left": "Basalt", "right": "Extrusive, fine-grained (aphanitic) mafic rock dominated by Ca-rich plagioclase and pyroxene" },
        { "left": "Granite", "right": "Intrusive, coarse-grained (phaneritic) felsic rock dominated by quartz, K-feldspar, and muscovite/biotite" },
        { "left": "Peridotite", "right": "Intrusive ultramafic mantle rock composed almost entirely of olivine and pyroxene" },
        { "left": "Andesite", "right": "Extrusive volcanic intermediate rock characteristic of continental subduction arc stratovolcanoes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The earliest, highest-temperature mineral to crystallize from a cooling basaltic magma along the discontinuous branch of Bowen's series is ___.",
      "blankAnswer": "olivine",
      "blankDistractors": ["quartz", "biotite", "hornblende"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why are magnesium-rich Olivine and primary igneous Quartz almost never found coexisting in thermodynamic equilibrium within the same natural igneous rock?",
      "options": [
        { "text": "Olivine is a silica-undersaturated mineral; if free excess silica (SiO2) is present in the magma, it spontaneously reacts with olivine via the chemical reaction Mg2SiO4 + SiO2 -> 2 MgSiO3 to form Pyroxene (Enstatite), completely consuming either all the olivine or all the free silica", "isCorrect": true, "explanation": "Correct! In chemical thermodynamics and igneous petrology, minerals are classified based on their silica saturation. Quartz is pure silica (SiO2), whereas forsterite olivine (Mg2SiO4) is silica-deficient (having a low Si:O ratio of 1:4). If an igneous melt contains enough silica to precipitate quartz, that free silica will vigorously react with any olivine present via the peritectic reaction: Mg2SiO4 (Olivine) + SiO2 (Melt) -> 2 MgSiO3 (Pyroxene). Because of this reaction, olivine and quartz are chemically incompatible. A rock containing excess silica will contain pyroxene and quartz (e.g. Granite), while a rock deficient in silica will contain olivine and pyroxene (e.g. Basalt or Peridotite), but never primary quartz and olivine together." },
        { "text": "Because quartz melts at a higher temperature than the core of the sun", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because olivine only forms in outer space", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because quartz dissolves olivine using strong sulfuric acid", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
