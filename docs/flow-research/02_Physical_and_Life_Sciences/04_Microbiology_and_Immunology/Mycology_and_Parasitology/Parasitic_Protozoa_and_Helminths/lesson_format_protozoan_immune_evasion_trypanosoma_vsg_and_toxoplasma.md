# Duofy Reusable Lesson Format: Protozoan Immune Evasion (Trypanosoma VSG and Toxoplasma)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Mycology_and_Parasitology / Parasitic_Protozoa_and_Helminths`  
**Lesson Format Type:** `protozoan_immune_evasion_trypanosoma_vsg_and_toxoplasma`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the sophisticated molecular immune subversion, genetic switching, and intracellular parasitism strategies of pathogenic protozoa (George Cross; Piet Borst): analyze the **Variant Surface Glycoprotein (VSG) Antigenic Variation in *Trypanosoma brucei*** (dense homodimeric coat shielding invariant membrane proteins, periodic homologous recombination switching from $>1,000$ silent telomeric/internal *VSG* pseudogenes into the active *Expression Site [ES]*, driving cyclical waves of parasitemia in African Sleeping Sickness), contrast with the intracellular lifestyle of **$\textit{Toxoplasma gondii}$** (secreting rhoptry kinases **ROP18 / ROP16** and dense granule **GRA** effectors to form a **Non-Fusogenic Parasitophorous Vacuole [PV]** that completely avoids lysosomal fusion in nucleated cells), and master **$\textit{Trypanosoma cruzi}$** phagolysosomal escape via **Tc-TOX pore-forming protein**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | VSG Antigenic Variation & Toxoplasma Intracellular Evasion Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Trypanosoma Brucei VSG Repertoire Switching Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Protozoan Parasite & Specific Immune Evasion Strategy Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Trypanosoma African Sleeping Sickness Dense Glycoprotein Coat Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Trypanosoma Brucei Undulating Waves of Parasitemia Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Protozoan Immune Evasion Paradigms:
   - **1. Antigenic Variation in *Trypanosoma brucei* (African Trypanosomiasis):**
     - Surface covered by $\approx 10^7$ molecules of a single **Variant Surface Glycoprotein (VSG)** homodimer forming a dense physical barrier ($15\text{-nm}$ thick) that prevents complement/antibodies from reaching invariant membrane transporters.
     - **The Genetic Archive:** Genome harbors $>1,000-2,000$ silent *VSG* genes.
     - **Switching Mechanism:** Only one *VSG* is transcribed from an active **Bloodstream Expression Site (BES)** at a telomere. By gene conversion or telomeric exchange, a silent *VSG* replaces the active gene $\implies$ Renders existing host antibody waves useless!
   - **2. Intracellular Stealth of *Toxoplasma gondii*:**
     - Actively invades any nucleated cell using apical organelles (**Micronemes $\to$ Rhoptries $\to$ Dense Granules**).
     - Constructs a specialized **Parasitophorous Vacuole Membrane (PVM)** lacking host transmembrane markers $\implies$ **Completely prevents fusion with host lysosomes**!
     - Secretes **ROP18 and ROP5 kinases** that phosphorylate and inactivate host Immunity-Related GTPases (IRGs), preventing vacuole rupture.
   - **3. Phagosomal Escape of *Trypanosoma cruzi* (Chagas Disease):**
     - Internalized by macrophages into a phagolysosome $\to$ Acidic pH activates **Tc-TOX (pore-forming protein)** $\to$ Lyses phagosomal membrane $\implies$ Escapes into cytoplasm to replicate as amastigotes!
2. **Slide 2 (`ordering`):** Provide 5 steps of *Trypanosoma brucei* antigenic variation during host infection: (1) trypanosomes with Coat A multiply in the bloodstream, eliciting a strong host IgM and IgG antibody response against VSG-A, (2) anti-VSG-A antibodies and complement lyse 99.9% of the parasite population, causing a sharp drop in blood parasitemia, (3) a rare spontaneous gene conversion event replaces VSG-A in the expression site with a silent VSG-B gene, (4) the antigenically distinct VSG-B trypanosomes are completely uninhibited by existing anti-VSG-A antibodies and proliferate exponentially, (5) a new peak of parasitemia develops until the host mounts a new antibody response against VSG-B, repeating the undulating wave cycle!
3. **Slide 3 (`matching`):** Pair 4 protozoan evasion mechanisms (Trypanosoma brucei VSG Switching, Toxoplasma gondii Parasitophorous Vacuole, Trypanosoma cruzi Tc-TOX Lysis, Leishmania Lipophosphoglycan) with their molecular actions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the protective surface coat of Trypanosoma brucei that undergoes periodic antigenic variation is Variant Surface Glycoprotein (abbreviated VSG). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the cyclical clinical course of African Trypanosomiasis (Sleeping Sickness): Why does a patient infected with *Trypanosoma brucei* experience characteristic cyclical, undulating waves of high fever and parasitemia that recur every 7 to 10 days for months? (Each fever peak corresponds to **clonal expansion of parasites expressing a dominant VSG coat; the host produces neutralizing antibodies that clear that clone, but rare parasites switch to a novel VSG from their silent genomic archive**, allowing them to escape immunity and expand as the next parasitemic wave).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "protozoan_immune_evasion_trypanosoma_vsg_and_toxoplasma",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Protozoan Immune Evasion Paradigms**\n• **1. Antigenic Variation (*Trypanosoma brucei*):**\n  - Dense surface coat of **Variant Surface Glycoprotein (VSG)** ($10^7$ copies).\n  - **The Genetic Reserve:** $>1,000$ silent *VSG* genes in genome.\n  - **Gene Conversion:** A silent *VSG* recombines into the active **Bloodstream Expression Site (BES)** $\\implies$ Switches coat identity $\\implies$ Escapes neutralizing host antibody waves!\n• **2. The Non-Fusogenic Vacuole (*Toxoplasma gondii*):**\n  - Constructs a **Parasitophorous Vacuole Membrane (PVM)** lacking host markers $\\implies$ **Completely blocks lysosomal fusion**!\n  - Secretes **ROP18/ROP5 kinases** to inactivate host immunity GTPases.\n• **3. Phagosomal Escape (*Trypanosoma cruzi*):**\n  - Secretes **Tc-TOX** at low pH $\\implies$ Punches holes in phagosome $\\implies$ Replicates freely in host cytoplasm!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps driving cyclical waves of parasitemia in African Trypanosomiasis.",
      "orderItems": [
        "A population of Trypanosoma brucei expressing Coat VSG-1 proliferates exponentially in human blood",
        "The host adaptive immune system generates high-titer neutralizing antibodies against VSG-1, clearing 99.9% of parasites",
        "A rare spontaneous gene conversion event swaps a silent VSG-2 gene into the active telomeric expression site",
        "The antigenically distinct VSG-2 parasites proliferate uninhibited by the circulating anti-VSG-1 antibodies",
        "Blood parasitemia spikes into a new peak of fever until the host mounts a new wave of anti-VSG-2 antibodies"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each protozoan parasite to its precise molecular immune evasion mechanism.",
      "matchPairs": [
        { "left": "Trypanosoma brucei", "right": "Periodically switches its Variant Surface Glycoprotein (VSG) coat via homologous recombination" },
        { "left": "Toxoplasma gondii", "right": "Forms a non-fusogenic parasitophorous vacuole that completely avoids host lysosomal fusion" },
        { "left": "Trypanosoma cruzi", "right": "Secretes Tc-TOX pore-forming protein at acidic pH to lyse the phagosome and escape into host cytoplasm" },
        { "left": "Giardia duodenalis", "right": "Adheres tightly to enterocyte microvilli via a rigid ventral suction disc without tissue invasion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The dense surface coat of Trypanosoma brucei that periodically undergoes gene conversion to escape host immunity is the Variant ___ Glycoprotein (VSG).",
      "blankAnswer": "surface",
      "blankDistractors": ["secretory", "nuclear", "cytosolic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is it virtually impossible for the human immune system to naturally clear an infection of Trypanosoma brucei (African Sleeping Sickness) without drug therapy?",
      "options": [
        { "text": "The parasite genome contains over 1,000 silent VSG genes; every time the host mounts an antibody response that wipes out 99% of parasites, rare organisms switch to a novel VSG coat, driving endless undulating waves of parasitemia that exhaust the immune system", "isCorrect": true, "explanation": "Correct! Trypanosoma brucei has evolved one of the most sophisticated antigenic variation mechanisms known in biology. Its genome contains a massive library of over a thousand silent VSG genes and pseudogenes. Only one VSG is transcribed at any given time from a specialized telomeric Expression Site (ES). As the host mounts high-affinity IgG and IgM antibodies against the dominant VSG (e.g. VSG-1), parasitemia drops drastically. However, at a spontaneous rate of ~1 in 10,000 cell divisions, a silent VSG (e.g. VSG-2) is copied into the active expression site. The VSG-2 parasites are completely invisible to the host's anti-VSG-1 antibodies and multiply to form the next parasitemic wave. This cat-and-mouse cycle continues indefinitely, causing progressive neurological deterioration (sleeping sickness) and death." },
        { "text": "Because Trypanosoma brucei converts all human white blood cells into red blood cells", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the parasite produces toxic cyanide gas inside blood vessels", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because human antibodies are too small to touch protozoan parasites", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
