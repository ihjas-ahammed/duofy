# Duofy Reusable Lesson Format: Bacterial Pathogenesis (Type III Secretion and Exotoxins)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Bacteriology_and_Virology / Bacterial_Structure_Genetics_and_Pathogenesis`  
**Lesson Format Type:** `bacterial_pathogenesis_type_iii_secretion_and_exotoxins`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular virulence nanomachines, enzymatic toxins, and immunopathological subversion strategies of pathogenic bacteria (Robert Koch; Paul Ehrlich; Stanley Falkow): analyze the **Type III Secretion System (T3SS / Injectisome)** used by Gram-negative pathogens (*Salmonella, Shigella, Yersinia, Pseudomonas*) to directly translocate effector proteins into the host cytosol, contrast **A-B Binary Exotoxins** (**A catalytic subunit + B receptor-binding subunit**) across major clinical paradigms (**Diphtheria toxin & Pseudomonas Exotoxin A** ADP-ribosylating EF-2, **Cholera toxin** ADP-ribosylating $G_{\alpha s}$, **Tetanus and Botulinum neurotoxins** cleaving SNARE proteins to cause spastic vs flaccid paralysis), and evaluate **Superantigens (TSST-1)** triggering uncontrolled cytokine storms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | T3SS Injectisome, A-B Toxins, & Superantigens Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Tetanus Neurotoxin Retrograde Transport and Spasm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bacterial Toxin / Effector & Cellular Target Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Two-Subunit Exotoxin Active Catalytic Moiety Letter Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Staphylococcal Toxic Shock Syndrome TSST-1 Superantigen Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bacterial Pathogenesis & Virulence Factors:
   - **Type III Secretion System (T3SS / The Injectisome):**
     - Contact-dependent macromolecular syringe spanning inner membrane, periplasm, outer membrane, and host plasma membrane.
     - Injects bacterial effector proteins directly into eukaryotic cytoplasm (e.g. *Yersinia* Yops paralyze macrophages; *Salmonella* Sips/Sops trigger membrane ruffling and macropinocytosis).
   - **A-B Exotoxin Superfamily:**
     - **B Subunit (Binding):** Docks specifically onto host cell surface receptors (e.g. gangliosides), triggering receptor-mediated endocytosis.
     - **A Subunit (Activity):** Cleaves / modifies host targets:
       $$\begin{array}{|l|l|l|}
       \hline
       \textbf{Toxin} & \textbf{Microorganism} & \textbf{Molecular Mechanism \& Clinical Output} \\
       \hline
       \textbf{Diphtheria Toxin} & \textit{Corynebacterium diphtheriae} & \text{ADP-ribosylates } \mathbf{\text{EF-2}} \implies \text{Halts protein synthesis (pseudomembrane)} \\
       \textbf{Cholera Toxin} & \textit{Vibrio cholerae} & \text{ADP-ribosylates } \mathbf{G_{\alpha s}} \implies \text{High cAMP } \to \text{CFTR opens } \implies \text{Rice-water diarrhea} \\
       \textbf{Tetanus Toxin (TeNT)} & \textit{Clostridium tetani} & \text{Cleaves } \mathbf{\text{Synaptobrevin (VAMP)}} \text{ in Renshaw cells } \implies \mathbf{\text{Spastic Paralysis}} \\
       \textbf{Botulinum Toxin (BoNT)} & \textit{Clostridium botulinum} & \text{Cleaves } \mathbf{\text{SNAP-25 / Syntaxin}} \text{ at NMJ } \implies \mathbf{\text{Flaccid Paralysis}} \\
       \hline
       \end{array}$$
   - **Superantigens (e.g. TSST-1 in Staphylococcal Toxic Shock):**
     - Binds simultaneously to **outer surface of MHC Class II** and the **V$\beta$ domain of TCR** without antigen processing.
     - Hyper-activates up to $20\%$ of naive T cells $\implies$ Massive release of **$\text{IFN-}\gamma, \text{IL-2}, \text{TNF-}\alpha$** causing shock and multi-organ failure.
2. **Slide 2 (`ordering`):** Provide 5 steps of Tetanus toxin pathogenesis: (1) *Clostridium tetani* spores germinate in an anaerobic puncture wound and secrete tetanus toxin (tetanospasmin), (2) the B subunit binds gangliosides on the motor neuron axon terminal and is internalized by endocytosis, (3) the toxin undergoes retrograde axonal transport along the motor nerve to the cell body in the spinal cord, (4) the toxin translocates into inhibitory interneurons (Renshaw cells), (5) the A subunit (zinc metalloprotease) cleaves synaptobrevin (VAMP), preventing the exocytosis of inhibitory neurotransmitters GABA and glycine, causing uninhibited motor firing and spastic paralysis (tetanic spasm)!
3. **Slide 3 (`matching`):** Pair 4 bacterial toxins (Diphtheria Toxin, Botulinum Toxin, Cholera Toxin, Staphylococcal TSST-1) with their exact biochemical mechanisms.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in two-component A-B exotoxins, the subunit possessing catalytic enzymatic activity is the A subunit. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the superantigen mechanism of TSST-1: How does Toxic Shock Syndrome Toxin-1 (TSST-1) produced by *Staphylococcus aureus* trigger massive hypotension, fever, and multi-organ failure in patients? (TSST-1 functions as a **superantigen that cross-links MHC Class II molecules directly to the variable beta ($V\beta$) domain of T-cell receptors on T-helper cells outside the peptide-binding cleft**, non-specifically activating up to $20\%$ of all peripheral T-cells and causing an overwhelming, life-threatening **cytokine storm** of TNF-$\alpha$, IL-1, and IL-2).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bacterial_pathogenesis_type_iii_secretion_and_exotoxins",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bacterial Pathogenesis (T3SS, A-B Toxins, and Superantigens)**\n• **Type III Secretion System (T3SS):**\n  - 'Molecular Syringe' injecting bacterial effectors directly into host cytoplasm (*Salmonella, Yersinia, Pseudomonas*).\n• **A-B Binary Exotoxins:**\n  - **B Subunit:** Binds host receptor $\\implies$ Endocytosis.\n  - **A Subunit:** Catalytic activity:\n    - **Diphtheria Toxin:** ADP-ribosylates **Elongation Factor 2 (EF-2)** $\\implies$ Halts protein synthesis.\n    - **Cholera Toxin:** ADP-ribosylates **$G_{\\alpha s}$** $\\implies$ High cAMP $\\to$ Watery diarrhea.\n    - **Tetanus Toxin:** Cleaves **Synaptobrevin** in inhibitory neurons $\\implies$ **Spastic Paralysis**.\n    - **Botulinum Toxin:** Cleaves **SNAP-25** at NMJ $\\implies$ **Flaccid Paralysis**.\n• **Superantigens (TSST-1):**\n  - Cross-links **MHC Class II** directly to **TCR $V\\beta$** $\\implies$ Activates $20\\%$ of all T cells $\\implies$ Catastrophic **Cytokine Storm**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential pathological events of Tetanus toxin intoxication leading to spastic paralysis.",
      "orderItems": [
        "Clostridium tetani spores germinate in an anaerobic deep wound and produce the A-B neurotoxin tetanospasmin",
        "The B subunit binds ganglioside receptors on peripheral motor neuron axon terminals, entering via endocytosis",
        "The neurotoxin travels via retrograde axonal transport to the spinal cord motor neuron cell bodies",
        "The toxin migrates trans-synaptically into inhibitory interneurons (Renshaw cells)",
        "The A subunit zinc endopeptidase cleaves synaptobrevin (VAMP), blocking GABA/glycine release to cause spastic paralysis"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each bacterial toxin to its precise molecular target.",
      "matchPairs": [
        { "left": "Diphtheria Toxin (C. diphtheriae)", "right": "Inactivates Elongation Factor 2 (EF-2) via ADP-ribosylation to halt host protein synthesis" },
        { "left": "Botulinum Neurotoxin (C. botulinum)", "right": "Cleaves SNAP-25 / Syntaxin SNARE proteins at neuromuscular junctions to block acetylcholine release (flaccid paralysis)" },
        { "left": "Tetanus Toxin (C. tetani)", "right": "Cleaves Synaptobrevin (VAMP) in spinal inhibitory interneurons to block glycine release (spastic paralysis)" },
        { "left": "Staphylococcal TSST-1 Superantigen", "right": "Cross-links MHC Class II to TCR V-beta chain outside the antigen cleft, activating polyclonal T cells" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In binary A-B bacterial exotoxins, the component possessing the enzymatic catalytic activity is the ___ subunit.",
      "blankAnswer": "a",
      "blankDistractors": ["b", "c", "d"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Toxic Shock Syndrome Toxin-1 (TSST-1) produced by Staphylococcus aureus cause an explosive systemic cytokine storm and refractory septic shock in humans?",
      "options": [
        { "text": "TSST-1 acts as a SUPERANTIGEN that simultaneously binds to the outside of MHC Class II molecules and the variable V-beta region of T-cell receptors without requiring conventional antigen processing, non-specifically activating up to 20% of all circulating T cells to dump massive quantities of TNF-alpha, IL-1, and IL-2 into the blood", "isCorrect": true, "explanation": "Correct! Normally, conventional peptide antigens presented on MHC Class II activate fewer than 0.01% of all T-cell clones (those with specific TCR complementarity). Superantigens like TSST-1 bypass this specificity by physically clamping the invariant side of MHC Class II to specific V-beta segments of the TCR. This activates up to 20% of the entire peripheral T-cell population simultaneously, unleashing a massive, dysregulated surge of pro-inflammatory cytokines (cytokine storm) that causes profound vasodilatory shock, capillary leak, and multiple organ failure." },
        { "text": "Because TSST-1 converts all red blood cells into nitrogen gas", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it hydrolyzes all ATP molecules inside mitochondria instantly", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it directly melts blood vessels into lipid oil", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
