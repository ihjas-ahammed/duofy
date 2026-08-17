# Duofy Reusable Lesson Format: Antiviral Pharmacology (NRTIs, PIs, and Neuraminidase Inhibitors)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Bacteriology_and_Virology / Viral_Replication_Vectors_and_Antivirals`  
**Lesson Format Type:** `antiviral_pharmacology_nrtis_pis_and_neuraminidase_inhibitors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular mechanisms of action, chemical structures, and clinical pharmacology of modern antiviral therapeutics (Gertrude Elion, Nobel Prize in Physiology or Medicine 1988): master **Nucleoside/Nucleotide Reverse Transcriptase Inhibitors (NRTIs: Zidovudine/AZT, Tenofovir, Emtricitabine)** acting as prodrug chain terminators lacking a $3'\text{-OH}$ group, contrast with **Non-Nucleoside RTIs (NNRTIs: Efavirenz)** allosteric pocket binding, analyze **Protease Inhibitors (PIs: Darunavir, Ritonavir; Paxlovid Nirmatrelvir)** blocking viral polyprotein cleavage to generate defective immature capsids, evaluate **Integrase Strand Transfer Inhibitors (INSTIs: Dolutegravir)** chelating catalytic $\text{Mg}^{2+}$, and analyze **Neuraminidase Inhibitors (Oseltamivir/Tamiflu, Zanamivir)** preventing influenza virion release from host sialic acid.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Antiviral Drug Targets & Life Cycle Interruption Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Intracellular NRTI Triphosphorylation and Chain Termination Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Antiviral Drug Class & Specific Mechanism of Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Essential Hydroxyl Group Lacking in NRTI Chain Terminators Number Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Oseltamivir Influenza Sialic Acid Cleavage Blockade Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Antiviral Pharmacology Mechanisms of Action:
   - **1. Reverse Transcriptase Inhibitors (RTIs):**
     - **NRTIs (e.g. AZT, Tenofovir, Lamivudine, Emtricitabine):** Synthetic nucleoside analogs. Phosphorylated by cellular kinases into active triphosphate form. Lack a **$3'\text{-OH}$ group** on the ribose ring; incorporated by HIV Reverse Transcriptase into growing viral DNA $\implies$ **Obligate Chain Termination** (cannot form $3'\to 5'$ phosphodiester bond).
     - **NNRTIs (e.g. Efavirenz, Nevirapine):** Hydrophobic small molecules that bind an allosteric pocket adjacent to the RT active site, inducing a conformational lock that inhibits polymerase activity non-competitively.
   - **2. Integrase Inhibitors (INSTIs, e.g. Dolutegravir, Bictegravir, Raltegravir):**
     - Bind HIV Integrase and chelate catalytic divalent magnesium ($\text{Mg}^{2+}$) ions, preventing the strand transfer reaction that splices viral cDNA into the host chromosome.
   - **3. Viral Protease Inhibitors (PIs, e.g. Darunavir, Atazanavir; Nirmatrelvir for SARS-CoV-2):**
     - Competitive peptidomimetic transition-state inhibitors that bind the catalytic pocket of viral aspartyl or cysteine proteases.
     - Block cleavage of the *Gag-Pol* polyprotein $\implies$ Budded virions fail to mature and remain non-infectious!
   - **4. Neuraminidase Inhibitors (e.g. Oseltamivir/Tamiflu, Zanamivir):**
     - Sialic acid transition-state analogs that inhibit Influenza virus neuraminidase (NA).
     - Sialic acid remains uncleaved on host cell surface $\implies$ Newly replicated influenza virions remain physically clumped and tethered to the infected host cell, aborting viral spread!
2. **Slide 2 (`ordering`):** Provide 5 steps of the NRTI mechanism of action (e.g. Zidovudine / AZT): (1) the uncharged nucleoside analog AZT diffuses across the human host cell membrane into the cytoplasm, (2) host cellular kinases sequentially phosphorylate AZT to AZT-monophosphate, AZT-diphosphate, and active AZT-triphosphate, (3) HIV Reverse Transcriptase recognizes AZT-triphosphate and incorporates it into the nascent cDNA strand in place of natural dTTP, (4) because AZT possesses a 3'-azido group instead of a 3'-hydroxyl (-OH) group, the next incoming nucleotide cannot form a 3'-to-5' phosphodiester bond, (5) DNA synthesis is abruptly and irreversibly terminated, preventing the formation of full-length viral cDNA and blocking HIV replication!
3. **Slide 3 (`matching`):** Pair 4 antiviral drug classes (NRTIs, INSTIs, Protease Inhibitors, Neuraminidase Inhibitors) with their molecular targets and pharmacological effects.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that NRTIs cause chain termination because they lack a 3' hydroxyl group on their ribose ring. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the pharmacological mechanism of Oseltamivir (Tamiflu): How does Oseltamivir inhibit the spread of Influenza A and B viruses in infected respiratory tract tissues? (Oseltamivir is a **competitive inhibitor of viral Neuraminidase, preventing the enzymatic cleavage of terminal sialic acid residues from host cell surface glycoproteins**, leaving newly budded progeny virions permanently trapped and clumped on the surface of the infected host cell).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "antiviral_pharmacology_nrtis_pis_and_neuraminidase_inhibitors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Antiviral Pharmacology Mechanisms**\n• **1. NRTIs (Nucleoside RT Inhibitors - e.g. AZT, Tenofovir):**\n  - Nucleoside analogs lacking a **$3'\\text{-OH}$ group**.\n  - Phosphorylated by host kinases $\\to$ Incorporated by HIV Reverse Transcriptase $\\implies$ **Obligate Chain Termination**!\n• **2. NNRTIs (e.g. Efavirenz):** Allosteric non-competitive inhibition of Reverse Transcriptase.\n• **3. INSTIs (Integrase Inhibitors - e.g. Dolutegravir):**\n  - Chelate catalytic $\\text{Mg}^{2+}$ ions in Integrase $\\implies$ Blocks proviral DNA chromosomal insertion.\n• **4. Protease Inhibitors (PIs - e.g. Darunavir, Paxlovid Nirmatrelvir):**\n  - Inhibit viral polyprotein cleavage $\\implies$ Generates **immature, non-infectious virions**.\n• **5. Neuraminidase Inhibitors (e.g. Oseltamivir / Tamiflu):**\n  - Inhibit Influenza Neuraminidase $\\implies$ **Traps budding virions on host sialic acid**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of NRTI antiretroviral action (AZT / Zidovudine).",
      "orderItems": [
        "The uncharged nucleoside analog AZT enters the human host cell via passive diffusion across the plasma membrane",
        "Host cellular kinases phosphorylate AZT in three successive steps to generate active AZT-triphosphate (AZT-TP)",
        "HIV Reverse Transcriptase mistakes AZT-TP for natural dTTP and incorporates it into the growing viral cDNA chain",
        "Because AZT carries an azido (-N3) group instead of a 3'-OH group, no subsequent phosphodiester bond can form",
        "Viral reverse transcription suffers obligate chain termination, aborting viral replication"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each antiviral drug class to its specific pharmacological mechanism.",
      "matchPairs": [
        { "left": "NRTIs (e.g. Tenofovir, Emtricitabine)", "right": "Competitive substrate analogs lacking a 3'-OH group that cause premature viral cDNA chain termination" },
        { "left": "INSTIs (e.g. Dolutegravir, Bictegravir)", "right": "Chelates divalent magnesium ions in the catalytic core of Integrase to block proviral DNA insertion" },
        { "left": "Protease Inhibitors (e.g. Darunavir, Nirmatrelvir)", "right": "Peptidomimetic inhibitors blocking polyprotein processing, producing immature defective virions" },
        { "left": "Neuraminidase Inhibitors (e.g. Oseltamivir)", "right": "Sialic acid analogs blocking enzymatic release of newly budded influenza virions from host membranes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Nucleoside Reverse Transcriptase Inhibitors (NRTIs) act as obligate chain terminators because their chemical structure lacks a ___-prime hydroxyl (-OH) group.",
      "blankAnswer": "3",
      "blankDistractors": ["5", "2", "1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the exact molecular mechanism by which Oseltamivir (Tamiflu) halts the spread of Influenza A and B viruses in the respiratory tract?",
      "options": [
        { "text": "It competitively inhibits viral Neuraminidase, preventing the cleavage of terminal sialic acid residues on host cell surface receptors and leaving newly budded influenza virions physically tethered and clumped to the infected host cell", "isCorrect": true, "explanation": "Correct! When new influenza virus particles bud from an infected host cell, their surface hemagglutinin (HA) proteins remain bound to sialic acid sugars on the host cell membrane. Viral Neuraminidase (NA) is the essential 'molecular scissors' that cleaves sialic acid to free the progeny virions. Oseltamivir is a transition-state analog that binds and competitively inhibits Neuraminidase. Without functional NA activity, new viruses cannot detach and remain permanently trapped on the surface of the dying host cell, halting the spread of infection to neighboring cells." },
        { "text": "It destroys the human immune system", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It blocks viral RNA polymerase in the mitochondria", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It converts influenza into a harmless bacterium", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
