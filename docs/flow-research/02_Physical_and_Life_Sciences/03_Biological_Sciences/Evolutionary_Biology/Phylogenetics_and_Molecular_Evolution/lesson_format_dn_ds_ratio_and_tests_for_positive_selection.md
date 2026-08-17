# Duofy Reusable Lesson Format: dN/dS Ratio and Tests for Positive Selection

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Phylogenetics_and_Molecular_Evolution`  
**Lesson Format Type:** `dn_ds_ratio_and_tests_for_positive_selection`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid computational and conceptual mastery of statistical tests for natural selection in protein-coding DNA sequences (Masatoshi Nei & Takashi Gojobori 1986; Ziheng Yang, PAML codon models; John McDonald & Martin Kreitman 1991): define **$d_N$ (rate of non-synonymous substitutions per non-synonymous site)** and **$d_S$ (rate of synonymous substitutions per synonymous site)**, evaluate the evolutionary selection parameter ($\mathbf{\omega = d_N/d_S}$), interpret **Purifying / Negative Selection ($\omega < 1$)**, **Neutral Drift ($\omega = 1$)**, and **Positive Darwinian Selection ($\omega > 1$)**, contrast whole-gene averages with site-specific codon models, analyze the **McDonald-Kreitman (MK) Test** comparing polymorphism ($P_N, P_S$) vs divergence ($D_N, D_S$), and interact with live codon alignment selection simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $d_N/d_S$ Ratio & McDonald-Kreitman Test Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Selection Category & $\omega = d_N/d_S$ Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Viral Surface Antigen Positive Selection $\omega > 1$ Mechanism Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Silent Synonymous Substitution Rate Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive $d_N/d_S$ Codon Selection Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dn_ds_ratio_and_tests_for_positive_selection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the dN/dS ratio (omega), and how is it used to detect positive Darwinian selection versus purifying selection in protein-coding genes?",
      "blankAnswer": "The dN/dS ratio (omega = K_a/K_s; Nei & Gojobori 1986) compares the rate of non-synonymous substitutions per non-synonymous site (d_N; which alters the amino acid) to the rate of synonymous substitutions per synonymous site (d_S; silent mutations that serve as a neutral baseline): (1) dN/dS < 1 (omega < 1): PURIFYING (NEGATIVE) SELECTION. Natural selection actively purges non-synonymous mutations that disrupt protein structure/function (>95% of all functional genes, e.g. Histones omega ~ 0.001, Actin omega ~ 0.01). (2) dN/dS = 1 (omega = 1): NEUTRAL EVOLUTION. Non-synonymous and synonymous mutations accumulate at equal rates (e.g. non-functional pseudogenes). (3) dN/dS > 1 (omega > 1): POSITIVE (DIVERSIFYING) SELECTION. Natural selection actively favors amino acid innovations that provide an adaptive fitness advantage (e.g. influenza virus hemagglutinin antigenic epitopes escaping host antibodies, MHC class I/II antigen-binding grooves, snake venom conotoxins, reproductive gamete-recognition proteins)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each omega (dN/dS) value range to its evolutionary selection regime.",
      "matchPairs": [
        { "left": "omega (dN/dS) < 1.0 (e.g. omega = 0.05)", "right": "Purifying / Negative Selection (strong functional constraint purging deleterious amino acid changes)" },
        { "left": "omega (dN/dS) = 1.0", "right": "Neutral Evolution / Genetic Drift (amino acid changes have zero effect on fitness, e.g. pseudogenes)" },
        { "left": "omega (dN/dS) > 1.0 (e.g. omega = 3.2)", "right": "Positive / Diversifying Darwinian Selection (adaptive amino acid innovations actively promoted)" },
        { "left": "McDonald-Kreitman (MK) Test", "right": "Compares non-synonymous/synonymous ratios between polymorphism (within species) and divergence (between species)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When researchers sequence the hemagglutinin (HA) surface glycoprotein gene of influenza A virus across global epidemics, why do specific codons in the globular head domain exhibit a dN/dS ratio significantly greater than 1 (omega = 3.5)?",
      "options": [
        { "text": "They are undergoing POSITIVE DARWINIAN SELECTION driven by host immune pressure; non-synonymous mutations in antibody-binding epitopes allow viral variants to escape neutralizing antibodies, conferring a strong selective survival advantage that outpaces synonymous mutations", "isCorrect": true, "explanation": "Correct! A dN/dS ratio greater than 1 is the gold standard statistical signature of positive selection. In the antigenic epitopes of influenza hemagglutinin, host immune antibodies neutralize existing viral strains. Any non-synonymous mutation that alters the epitope structure while retaining receptor-binding function allows the virus to evade host immune memory. Consequently, novel amino acid substitutions are actively favored and fixed by natural selection at a rate higher than the neutral synonymous mutation baseline." },
        { "text": "Because the virus has stopped using DNA polymerases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because synonymous mutations are poisonous to influenza", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the gene is a completely dead pseudogene", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In molecular evolutionary rate calculations, the rate of silent synonymous substitutions per synonymous site is denoted as ___.",
      "blankAnswer": "ds",
      "blankDistractors": ["dn", "ka", "omega"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive dN/dS Selection Analyzer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Molecular Evolution dN/dS Selection Engine</h3><p>Gene Target: MHC Class I Antigen-Binding Domain (Exon 2)</p><button id=\"dndsBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate dN, dS, and Omega (PAML Codon Model)</button><div id=\"dndsOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('dndsBtn').onclick=()=>{document.getElementById('dndsOut').innerText='PAML Maximum Likelihood Results: (1) Non-synonymous rate dN = 0.284 substitutions/site. (2) Synonymous rate dS = 0.071 substitutions/site. (3) Omega = dN/dS = 4.00 (p < 0.0001). Conclusion: Robust positive Darwinian selection detected! Epitope residues diversifying to bind novel pathogen peptides!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
