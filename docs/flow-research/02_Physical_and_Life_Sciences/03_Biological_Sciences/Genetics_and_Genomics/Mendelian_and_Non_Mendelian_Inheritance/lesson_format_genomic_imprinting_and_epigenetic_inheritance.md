# Duofy Reusable Lesson Format: Genomic Imprinting and Epigenetic Inheritance

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Mendelian_and_Non_Mendelian_Inheritance`  
**Lesson Format Type:** `genomic_imprinting_and_epigenetic_inheritance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid molecular, medical, and evolutionary mastery of parent-of-origin non-Mendelian epigenetic gene regulation (Davor Solter & Azim Surani 1984; David Haig's Kinship Theory of Imprinting): analyze **Genomic Imprinting** as an epigenetic process where allele expression is monoallelically restricted depending on whether it was inherited from the mother or father via **DNA Methylation of Imprinting Control Regions (ICRs)** and chromatin remodeling, contrast the reciprocal neurogenetic disorders caused by microdeletions at **Chromosome 15q11-q13** (**Prader-Willi Syndrome [PWS]** via loss of paternally expressed genes *SNRPN/snoRNAs* vs **Angelman Syndrome [AS]** via loss of the maternally expressed E3 ubiquitin ligase *UBE3A*), and interact with live genomic imprinting and methylation cycle simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Genomic Imprinting & Prader-Willi / Angelman Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Epigenetic Mechanism / Syndrome & Genetic Cause Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Chromosome 15q11-q13 Parental Deletion Outcome Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Primary Chemical Covalent DNA Epigenetic Mark Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Genomic Imprinting Methylation Life Cycle Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "genomic_imprinting_and_epigenetic_inheritance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Genomic Imprinting, and how does a 15q11-q13 deletion produce either Prader-Willi Syndrome or Angelman Syndrome depending on parental origin?",
      "blankAnswer": "Genomic Imprinting is an epigenetic phenomenon where certain genes are expressed in a parent-of-origin-specific monoallelic manner (Surani & Solter, 1984). Imprints are established during gametogenesis via DNA methylation at Imprinting Control Regions (ICRs) and resist post-fertilization reprogramming. Chromosome 15q11-q13 contains a cluster of imprinted genes: (1) PRADER-WILLI SYNDROME (PWS): Caused by loss of PATERNALLY expressed genes (SNRPN, NDN, snoRNAs). The maternal copy is normally methylated/silenced; if the father's 15q11-q13 region is deleted (or in maternal uniparental disomy UPD15), the child has zero active copies, developing hyperphagia, morbid obesity, hypotonia, and cognitive disability. (2) ANGELMAN SYNDROME (AS): Caused by loss of the MATERNALLY expressed UBE3A ubiquitin ligase. The paternal UBE3A copy is normally silenced by an antisense transcript (UBE3A-ATS) in neurons; if the mother's 15q11-q13 region is deleted (or paternal UPD15), the child has zero active UBE3A in the brain, developing severe ataxia, lack of speech, intellectual disability, and frequent unprovoked laughter ('Happy Puppet')."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each epigenetic / imprinting syndrome to its precise genetic defect.",
      "matchPairs": [
        { "left": "Prader-Willi Syndrome (PWS)", "right": "Deletion of paternal 15q11-q13 (or maternal UPD15), resulting in complete loss of paternal SNRPN/snoRNAs" },
        { "left": "Angelman Syndrome (AS)", "right": "Deletion of maternal 15q11-q13 (or paternal UPD15), resulting in complete loss of maternal brain-specific UBE3A" },
        { "left": "Beckwith-Wiedemann Syndrome (11p15)", "right": "Overexpression of paternal IGF2 (overgrowth syndrome with macroglossia and Wilms tumor risk)" },
        { "left": "Kinship (Conflict) Theory of Imprinting", "right": "Paternal genes favor larger offspring growth (extracting maternal resources); maternal genes conserve resources" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A child is born with severe intellectual disability, speech impairment, ataxia, and a characteristic happy demeanor with inappropriate laughter. Genetic testing reveals a microdeletion on chromosome 15q11-q13. From which parent was this deleted chromosome inherited?",
      "options": [
        { "text": "THE MOTHER (Angelman Syndrome); because the critical brain-specific gene UBE3A is normally expressed exclusively from the MATERNAL chromosome 15 (the paternal copy being silenced in neurons by antisense RNA), so maternal deletion leaves the child with zero functional UBE3A enzyme in the brain", "isCorrect": true, "explanation": "Correct! In neurons of the central nervous system, the paternal UBE3A allele is silenced by a long non-coding antisense transcript (UBE3A-ATS), leaving only the maternal UBE3A allele active. When a child inherits a 15q11-q13 deletion from the mother, the sole functional copy of UBE3A is lost, resulting in Angelman syndrome. Conversely, if the deletion is inherited from the father, the maternally silenced genes (SNRPN/snoRNAs) are lost, resulting in Prader-Willi syndrome." },
        { "text": "The father (producing Prader-Willi syndrome)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both parents simultaneously (tetraploidy)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Inherited strictly through mitochondrial DNA", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The primary covalent chemical modification of cytosine bases in DNA that establishes and maintains genomic imprints is DNA ___.",
      "blankAnswer": "methylation",
      "blankDistractors": ["acetylation", "phosphorylation", "ubiquitination"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Genomic Imprinting Lifecycle Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Genomic Imprinting & Germline Methylation Engine</h3><p>Locus: Chromosome 15q11-q13 | Gametogenesis Cycle</p><button id=\"impBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Simulate Germline Reset & Imprint Establishment</button><div id=\"impOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('impBtn').onclick=()=>{document.getElementById('impOut').innerText='Epigenetic Cycle: (1) Primordial Germ Cells: Existing somatic imprints erased completely. (2) Spermatogenesis: Paternal imprint established (SNRPN unmethylated, H19 methylated). (3) Oogenesis: Maternal imprint established (SNRPN methylated/silenced, UBE3A unmethylated). (4) Embryogenesis: Imprints maintained during global cleavage-stage demethylation!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
