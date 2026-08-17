# Duofy Reusable Lesson Format: Orthogonal Protecting Groups and Cleavage Tactics

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Organic_Synthesis_and_Retrosynthesis`  
**Lesson Format Type:** `orthogonal_protecting_groups_and_cleavage_tactics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the tactical installation and selective deprotection of orthogonal protecting groups in complex multi-step organic synthesis and solid-phase peptide synthesis: master **Alcohol Protecting Groups** (Silyl ethers: TBS/TBDMS removed by $\text{F}^- / \text{TBAF}$; Benzyl Bn removed by catalytic hydrogenolysis $\text{H}_2, \text{Pd/C}$; PMB removed by DDQ oxidation; THP removed by aqueous acid), master **Amine Protecting Groups** (Boc removed by strong acid $\text{TFA}$; Fmoc removed by base $20\%$ piperidine; Cbz removed by $\text{H}_2, \text{Pd/C}$), evaluate **Orthogonality Sets**, and design selective sequential deprotection sequences.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Protecting Group Orthogonality & Cleavage Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Multi-Functional Tripeptide Selective Deprotection Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Protecting Group & Specific Cleavage Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Silyl Ether TBS Deprotection Fluoride Reagent Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Orthogonal Deprotection of Boc vs Fmoc in Peptide Synthesis Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Orthogonal Protecting Groups & Cleavage Chemistry:
   - **The Concept of Orthogonality:**
     - Two protecting groups are **orthogonal** if one can be completely removed under specific conditions that leave the other entirely unaffected (and vice versa).
   - **Alcohol Protecting Groups ($-\text{OH}$):**
     - **TBS / TBDMS ($-\text{SiMe}_2(t\text{-Bu})$):** Stable to base, Grignards, and mild acid; **cleaved selectively by Fluoride ($\text{TBAF}$, forming strong $\text{Si}-\text{F}$ bond: $565\text{ kJ/mol}$)**.
     - **Benzyl (Bn, $-\text{CH}_2\text{Ph}$):** Stable to acid, base, oxidants, and fluorides; **cleaved by Hydrogenolysis ($\text{H}_2, \text{Pd/C}$)**.
     - **PMB ($p$-methoxybenzyl):** Cleaved by mild single-electron oxidation ($\text{DDQ} / \text{H}_2\text{O}$ or $\text{CAN}$).
     - **THP (Tetrahydropyranyl):** Acetal; cleaved by mild aqueous acid ($\text{PPTS} / \text{EtOH}$ or $\text{HCl}$).
   - **Amine Protecting Groups ($-\text{NH}_2$):**
     - **Boc ($t$-butyloxycarbonyl):** **Acid-labile** (cleaved by $50\%\ \text{TFA}/\text{CH}_2\text{Cl}_2$ or $\text{HCl}$ via stable $t$-butyl carbocation); stable to base and hydrogenation.
     - **Fmoc (9-fluorenylmethoxycarbonyl):** **Base-labile** (cleaved by $20\%$ piperidine via E1cb deprotonation of acidic C9 fluorenyl proton); stable to strong acids!
     - **Cbz / Z (Benzyloxycarbonyl):** **Hydrogenolysis-labile** ($\text{H}_2, \text{Pd/C}$).
2. **Slide 2 (`ordering`):** Provide 5 steps in the selective sequential deprotection of a tri-functional molecule bearing an Fmoc-protected amine, a TBS-protected primary alcohol, and a Benzyl-protected phenol: (1) treat molecule with $20\%$ piperidine in DMF to remove Fmoc by base-induced E1cb elimination without affecting TBS or Benzyl, (2) couple the free amine with an activated carboxylic acid, (3) treat the intermediate with tetrabutylammonium fluoride (TBAF) in THF to selectively deprotect the TBS silyl ether via fluoride-silicon coordination, (4) oxidize the liberated primary alcohol to a carboxylic acid, (5) perform catalytic hydrogenolysis ($\text{H}_2, 10\%\ \text{Pd/C}$) to cleanly cleave the benzyl ether and furnish the final target!
3. **Slide 3 (`matching`):** Pair 4 protecting groups (TBS ether, Fmoc carbamate, Boc carbamate, Benzyl ether) with their exclusive deprotection reagents ($\text{TBAF} / \text{THF}$, $20\%$ Piperidine, $\text{TFA} / \text{CH}_2\text{Cl}_2$, $\text{H}_2 / \text{Pd-C}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that tetrabutylammonium fluoride (abbreviated TBAF) is the standard reagent used to cleave silyl protecting groups like TBS. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Boc vs Fmoc solid-phase peptide synthesis (SPPS): Why has the Fmoc/tBu orthogonal strategy largely replaced the older Boc/Bn strategy in modern solid-phase peptide synthesis? (Because Fmoc deprotection uses **mild base ($20\%$ piperidine)** to unmask the N-terminus during each coupling cycle, reserving acid ($\text{TFA}$) only for the final global cleavage of side-chain $t\text{-Bu}$ groups and resin release, completely avoiding the dangerous, highly corrosive liquid hydrofluoric acid ($\text{HF}$) required to cleave Boc/Bn systems).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "orthogonal_protecting_groups_and_cleavage_tactics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Orthogonal Protecting Groups and Cleavage Tactics**\n• **Orthogonality Defined:** Selective deprotection of one protecting group without altering any other protecting group on the scaffold.\n• **Alcohol ($-\\text{OH}$) Protection Suite:**\n  - **TBS / TBDMS (Silyl Ether):** Cleaved by **Fluoride ions (TBAF)** (drives $\\text{Si}-\\text{F}$ bond formation, $565\\text{ kJ/mol}$).\n  - **Benzyl (Bn):** Cleaved by **Hydrogenolysis ($\\text{H}_2, \\text{Pd/C}$)**.\n  - **PMB ($p$-Methoxybenzyl):** Cleaved by **Oxidation (DDQ / CAN)**.\n  - **THP (Acetal):** Cleaved by **Mild Acid (PPTS / MeOH)**.\n• **Amine ($-\\text{NH}_2$) Protection Suite:**\n  - **Boc (Acid-Labile):** Cleaved by **$50\\%\\ \\text{TFA} / \\text{CH}_2\\text{Cl}_2$** (stable to base and $\\text{H}_2$).\n  - **Fmoc (Base-Labile):** Cleaved by **$20\\%\\ \\text{Piperidine}$** via E1cb (stable to strong acid!).\n  - **Cbz (Hydrogenolysis-Labile):** Cleaved by **$\\text{H}_2, \\text{Pd/C}$**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the selective deprotection steps for a molecule bearing Fmoc-amine, TBS-alcohol, and Benzyl-ether groups.",
      "orderItems": [
        "Treat the tri-protected molecule with 20% piperidine in DMF to selectively deprotect the Fmoc-amine via E1cb elimination",
        "Couple the liberated primary amine with an amino acid building block using standard peptide coupling reagents",
        "Add tetrabutylammonium fluoride (TBAF) in THF to selectively cleave the TBS silyl ether via thermodynamic Si-F affinity",
        "Oxidize the newly unmasked primary alcohol to an aldehyde or carboxylic acid using Dess-Martin periodinane",
        "Subject the compound to catalytic hydrogenolysis (H_2, 10% Pd/C) to cleave the benzyl ether and yield the pure final product"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each protecting group to its exclusive deprotection reagent.",
      "matchPairs": [
        { "left": "TBS / TBDMS Silyl Ether", "right": "TBAF (tetrabutylammonium fluoride in THF; fluoride cleavage)" },
        { "left": "Fmoc Carbamate", "right": "20% Piperidine in DMF (mild secondary amine base cleavage)" },
        { "left": "Boc Carbamate", "right": "Trifluoroacetic acid (TFA in CH_2Cl_2; strong acid cleavage)" },
        { "left": "Benzyl (Bn) Ether", "right": "H_2 gas over 10% Pd/C catalyst (catalytic hydrogenolysis)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Tetrabutylammonium fluoride, commonly abbreviated as ___, is the standard reagent for selectively cleaving silyl ether protecting groups.",
      "blankAnswer": "tbaf",
      "blankDistractors": ["tfa", "ddq", "dmso"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Fmoc/tBu orthogonal strategy widely preferred over the older Boc/Bn strategy in Solid-Phase Peptide Synthesis (SPPS)?",
      "options": [
        { "text": "Fmoc deprotection requires only mild organic base (20% piperidine) during repetitive N-terminal unmasking cycles, allowing mild TFA for the final side-chain cleavage, completely eliminating the need for hazardous, toxic liquid hydrofluoric acid (HF) required by Boc/Bn", "isCorrect": true, "explanation": "Correct! In the Boc/Bn strategy, repetitive Boc deprotection requires TFA, so side-chain deprotection and peptide cleavage from the resin requires superacidic, dangerous liquid HF. The Fmoc/tBu strategy is truly orthogonal: base (piperidine) removes Fmoc at each elongation step, and mild acid (TFA) performs the final global deprotection, providing safer, higher-yielding peptide synthesis." },
        { "text": "Because Boc decomposes spontaneously in air", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because piperidine is a strong oxidizing agent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Fmoc peptides are magnetic", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
