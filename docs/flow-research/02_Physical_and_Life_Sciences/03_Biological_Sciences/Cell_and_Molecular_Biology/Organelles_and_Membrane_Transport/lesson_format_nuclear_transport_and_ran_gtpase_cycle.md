# Duofy Reusable Lesson Format: Nuclear Transport and the Ran-GTPase Cycle

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Organelles_and_Membrane_Transport`  
**Lesson Format Type:** `nuclear_transport_and_ran_gtpase_cycle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the spatial thermodynamics and molecular mechanics of nucleocytoplasmic transport across the Nuclear Pore Complex (NPC): formulate the structure of the **Nuclear Pore Complex (NPC)** lined with disordered hydrophobic **FG-Nucleoporins (Phenylalanine-Glycine repeats)**, contrast **Nuclear Localization Signals (NLS, basic)** recognized by **Importin-$\alpha/\beta$** with **Nuclear Export Signals (NES, leucine-rich)** recognized by **Exportin / CRM1**, and analyze how the spatial compartmentalization of **Ran-GEF (RCC1, chromatin-bound in nucleus)** and **Ran-GAP (cytoplasmic)** establishes a steep **Ran-GTP / Ran-GDP Gradient** that acts as the thermodynamic engine enforcing strict unidirectionality of nuclear import and export.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nuclear Pore Complex & Ran-GTP Gradient Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Nuclear Protein Import Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Nuclear Transport Factor & Compartmental Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Chromatin-Bound Nuclear Guanine Nucleotide Exchange Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Ran-GTP Gradient Disruption Transport Failure Consequence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Nuclear Transport & The Ran-GTPase Gradient:
   - **The Nuclear Pore Complex (NPC):**
     - $120\text{ MDa}$ octagonal basket containing $\approx 30$ distinct nucleoporins (Nups).
     - Central channel filled with flexible, disordered **FG-repeat nucleoporins (Phenylalanine-Glycine)** that form a hydrophobic permeability barrier (molecules $>40\text{ kDa}$ require transport receptors).
   - **The Ran-GTPase Compartmental Asymmetry (The Directional Engine):**
     - **In the Nucleus:** Chromatin-bound **Ran-GEF (RCC1)** maintains a very high concentration of **Ran-GTP**.
     - **In the Cytoplasm:** Cytosolic **Ran-GAP** stimulates GTP hydrolysis, keeping cytoplasmic Ran exclusively in the **Ran-GDP** state.
   - **Nuclear Import Mechanics (Importin-$\alpha/\beta$):**
     $$\text{Cargo-NLS} + \text{Importin} \xrightarrow{\text{Cytosol}} [\text{Cargo}\cdot\text{Importin}] \xrightarrow{\text{NPC Translocation}} \text{Nucleus}$$
     $$\text{In Nucleus: } [\text{Cargo}\cdot\text{Importin}] + \mathbf{Ran\text{-}GTP} \longrightarrow [\text{Importin}\cdot\mathbf{Ran\text{-}GTP}] + \mathbf{Cargo\ Released!}$$
   - **Nuclear Export Mechanics (Exportin / CRM1):**
     - In Nucleus: $\text{Cargo-NES} + \text{Exportin} + \mathbf{Ran\text{-}GTP}$ form a cooperative trimeric export complex.
     - In Cytosol: **Ran-GAP** triggers GTP hydrolysis $\to \mathbf{Ran\text{-}GDP}$, dissociating the complex and releasing cargo into the cytoplasm!
2. **Slide 2 (`ordering`):** Provide 5 steps of the nuclear protein import cycle: (1) an NLS-bearing cargo protein is recognized in the cytoplasm by the Importin-$\alpha/\beta$ receptor heterodimer, (2) the Importin-cargo complex interacts transiently with hydrophobic FG-repeats to diffuse across the central channel of the Nuclear Pore Complex, (3) inside the nucleus, high concentrations of Ran-GTP bind directly to Importin-$\beta$, (4) Ran-GTP binding triggers an allosteric conformational change that forces Importin to release the NLS-cargo into the nucleoplasm, (5) the Importin-$\beta\cdot\text{Ran-GTP}$ complex is exported back to the cytoplasm, where Ran-GAP stimulates GTP hydrolysis to Ran-GDP, releasing free Importin-$\beta$ for the next round!
3. **Slide 3 (`matching`):** Pair 4 nuclear transport machinery elements (Nuclear Pore FG-Repeats, Ran-GEF / RCC1 in nucleus, Ran-GAP in cytoplasm, Exportin CRM1) with their functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the chromatin-bound nuclear exchange factor that charges Ran with GTP is Ran-GEF (or RCC1). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on disrupting the Ran-GTP gradient: If a cell is engineered to express Ran-GAP inside the nucleus or treated with a mutant Ran unable to bind GTP, what happens to classical nuclear protein import? (Nuclear import stalls and fails completely because **without nuclear Ran-GTP, Importin cannot bind Ran-GTP to release its NLS-cargo inside the nucleus**, and empty Importin molecules cannot be recycled back to the cytoplasm).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nuclear_transport_and_ran_gtpase_cycle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Nuclear Transport and the Ran-GTPase Cycle**\n• **The Nuclear Pore Complex (NPC):**\n  - Lined with flexible, unstructured **FG-Nucleoporins** (Phenylalanine-Glycine repeats).\n  - Small molecules ($<40\\text{ kDa}$) diffuse freely; large proteins require **Karyopherins (Importins/Exportins)**.\n• **The Spatial Ran Gradient (The Thermodynamic Engine):**\n  - **Nucleus:** High **Ran-GTP** (maintained by chromatin-tethered **Ran-GEF / RCC1**).\n  - **Cytoplasm:** High **Ran-GDP** (maintained by cytosolic **Ran-GAP**).\n• **Import vs. Export Mechanics:**\n  - **Nuclear Import:** Importin captures **Cargo-NLS** in cytoplasm $\\to$ Translocates through NPC $\\to$ Nuclear **Ran-GTP binds Importin**, forcing **Cargo Release** in nucleus.\n  - **Nuclear Export:** Exportin binds **Cargo-NES + Ran-GTP** in nucleus $\\to$ Enters cytoplasm $\\to$ **Ran-GAP hydrolyzes GTP**, triggering **Cargo Release** in cytoplasm!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of NLS-cargo protein import into the eukaryotic nucleus.",
      "orderItems": [
        "Cytosolic Importin-alpha/beta heterodimer binds the basic Nuclear Localization Signal (NLS) on the cargo protein",
        "The Importin-cargo complex navigates through the Nuclear Pore Complex via transient interactions with FG-repeats",
        "Upon entering the nucleoplasm, high-concentration Ran-GTP binds directly to Importin-beta",
        "Ran-GTP binding induces an allosteric conformational shift that releases the NLS-cargo into the nucleus",
        "The Importin-beta.Ran-GTP complex is recycled to the cytosol where Ran-GAP triggers GTP hydrolysis, releasing free Importin"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each nuclear transport machinery component to its cellular role.",
      "matchPairs": [
        { "left": "FG-Nucleoporins in NPC Central Channel", "right": "Hydrophobic barrier that transiently binds karyopherin transport receptors during translocation" },
        { "left": "Ran-GEF (RCC1, Chromatin-Bound)", "right": "Exchanges GDP for GTP on Ran exclusively inside the nucleus to maintain high nuclear Ran-GTP" },
        { "left": "Ran-GAP (Cytosolic GTPase Activating Protein)", "right": "Stimulates Ran GTP hydrolysis exclusively in cytoplasm, ensuring all cytosolic Ran is Ran-GDP" },
        { "left": "Exportin-1 (CRM1)", "right": "Receptor that cooperatively binds leucine-rich NES cargo only in the presence of nuclear Ran-GTP" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The chromatin-tethered guanine nucleotide exchange factor that charges Ran with GTP inside the nucleus is named Ran-___ (or RCC1).",
      "blankAnswer": "gef",
      "blankDistractors": ["gap", "gdi", "gtp"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens to nuclear protein import if a cell is depleted of nuclear Ran-GTP (e.g. by mutating or displacing the nuclear exchange factor RCC1)?",
      "options": [
        { "text": "Nuclear import arrests completely; without high nuclear Ran-GTP, Importin cannot be dissociated from its cargo upon reaching the nucleus, preventing cargo release in the nucleoplasm and trapping Importin inside the nucleus so it cannot recycle", "isCorrect": true, "explanation": "Correct! Nuclear Ran-GTP is the molecular key that discharges cargo inside the nucleus. When Importin-cargo arrives in the nucleus, Ran-GTP binds with high affinity to Importin-beta, causing a structural change that ejects the NLS-cargo. Furthermore, the Importin-beta.Ran-GTP complex is the required species for recycling back to the cytoplasm. Without nuclear Ran-GTP, cargo is never released into the nucleus and the import receptors cannot return to the cytosol, stalling all nuclear import." },
        { "text": "Nuclear pores expand to 10 micrometers and dissolve the nuclear envelope", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The cell immediately undergoes meiosis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "All genomic DNA is exported into the extracellular medium", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
