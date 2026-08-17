# Duofy Reusable Lesson Format: Viral Vectors in Gene Therapy (AAV vs Lentivirus)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Bacteriology_and_Virology / Viral_Replication_Vectors_and_Antivirals`  
**Lesson Format Type:** `viral_vectors_in_gene_therapy_aav_vs_lentivirus`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular engineering, capsid pseudotyping, payload capacities, and safety profiles of viral gene delivery vectors in modern genetic medicine: contrast non-integrating **Adeno-Associated Virus (AAV)** (small parvovirus capsid with Inverted Terminal Repeats [**ITRs**], $4.7\text{ kb}$ packaging capacity, non-pathogenic, persisting as **stable nuclear episomes** in post-mitotic tissues like neurons, retina, and hepatocytes; e.g. Luxturna, Zolgensma) with integrating **Lentiviral Vectors (LV)** (pseudotyped with VSV-G, $8-10\text{ kb}$ payload capacity, **permanent stable chromosomal integration** in dividing hematopoietic stem cells and T cells for CAR-T cell immunotherapy), and evaluate the risks of **Insertional Mutagenesis / Oncogenesis** vs episomal dilution in rapidly dividing tissues.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | AAV vs Lentivirus Viral Vector Architectures Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Recombinant AAV Gene Delivery and Episome Formation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Viral Vector Platform & Clinical Engineering Parameter Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Flanking Cis-Acting DNA Elements on Recombinant AAV Genomes Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Vector Selection Dividing Cells vs Post-Mitotic Neurons Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Viral Vectors for Clinical Gene Therapy:
   - **Vector Platform Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Vector Platform} & \textbf{Genome / Envelope} & \textbf{Packaging Capacity} & \textbf{Integration Status} & \textbf{Prime Clinical Target} \\
     \hline
     \textbf{AAV (rAAV)} & \text{ssDNA, Non-enveloped} & \mathbf{\approx 4.7\text{ kb}} & \mathbf{\text{Episomal (Non-integrating)}} & \text{Post-mitotic: CNS, Retina, Liver} \\
     \textbf{Lentivirus (LV)} & \text{ssRNA, Enveloped (VSV-G)} & \mathbf{\approx 8-10\text{ kb}} & \mathbf{\text{Chromosomal Integration}} & \text{Dividing cells: CAR-T, HSCs} \\
     \textbf{Adenovirus (AdV)} & \text{dsDNA, Non-enveloped} & \approx 36\text{ kb} & \text{Episomal (Transient, high immune)} & \text{Vaccines, Oncolytic therapy} \\
     \hline
     \end{array}$$
   - **rAAV Molecular Architecture:**
     - All viral coding genes (*rep* and *cap*) are removed and supplied *in trans*.
     - The therapeutic transgene cassette is flanked strictly by **Inverted Terminal Repeats (ITRs)** ($145\text{ bp}$ T-shaped hairpins serving as replication origins and packaging signals).
     - Inside host nucleus, single-stranded genomes form circular/concatemeric **Episomes**; expression is lifelong in non-dividing neurons, but diluted during cell divisions.
   - **Lentivirus Molecular Architecture:**
     - Deconstructed 3rd-generation split-packaging system: (1) Transfer vector with $\psi$ packaging signal and disabled Self-Inactivating (SIN) LTRs, (2) Packaging plasmid (*gag/pol*), (3) Rev plasmid, (4) Envelope plasmid (VSV-G for broad tropism).
     - Integrates permanently into host chromosome, passed to all daughter cells!
2. **Slide 2 (`ordering`):** Provide 5 steps of recombinant AAV (rAAV) gene delivery: (1) engineered rAAV capsids bind cell surface glycan receptors on target cells (e.g. neurons) and are internalized via clathrin-mediated endocytosis, (2) the virus escapes from the endosome into the cytosol and docks at the nuclear pore complex, (3) the single-stranded DNA genome is uncoupled from the capsid and enters the nucleus, (4) host DNA polymerases synthesize the complementary second strand using the hairpin ITR as a primer (or double-stranded self-complementary scAAV uncoils), (5) the viral DNA circularizes into stable, high-molecular-weight episomal concatemers that drive long-term therapeutic transgene transcription without disrupting host chromosomes!
3. **Slide 3 (`matching`):** Pair 4 viral vector features (rAAV Packaging Limit $4.7\text{ kb}$, AAV Inverted Terminal Repeats ITRs, Lentivirus Chromosomal Integration, VSV-G Pseudotyping) with their functional descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the 145-bp hairpin sequences flanking recombinant AAV genomes are Inverted Terminal Repeats (abbreviated ITR). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on vector selection in gene therapy: A clinical team is designing a gene therapy protocol to permanently cure Severe Combined Immunodeficiency (SCID) by modifying patient Hematopoietic Stem Cells (HSCs), which will undergo thousands of cell divisions to regenerate the entire immune system. Why must they use a Lentiviral vector rather than an AAV vector? (Because HSCs divide rapidly, and **AAV persists as a non-integrating episome that is progressively diluted and lost during successive cell divisions**, whereas **Lentiviruses permanently integrate into the host chromosomal DNA**, ensuring the therapeutic gene is duplicated and inherited by every daughter immune cell).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "viral_vectors_in_gene_therapy_aav_vs_lentivirus",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Viral Vectors in Gene Therapy (AAV vs. Lentivirus)**\n• **Recombinant AAV (rAAV):**\n  - **Genome:** Single-stranded DNA flanked by **Inverted Terminal Repeats (ITRs)**.\n  - **Packaging Limit:** $\\mathbf{\\approx 4.7\\text{ kb}}$.\n  - **Fate:** Forms **stable, non-integrating nuclear episomes**.\n  - **Best Targets:** Quiescent, post-mitotic tissues (Retina, CNS neurons, Skeletal muscle, Liver).\n• **Lentiviral Vectors (LV):**\n  - **Genome:** RNA reverse-transcribed to DNA; pseudotyped with VSV-G envelope.\n  - **Packaging Limit:** $\\mathbf{\\approx 8\\text{--}10\\text{ kb}}$.\n  - **Fate:** **Permanent chromosomal integration** via viral Integrase.\n  - **Best Targets:** Rapidly dividing cell populations (Hematopoietic stem cells, CAR-T immunotherapy)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of recombinant AAV (rAAV) intracellular delivery and episome formation.",
      "orderItems": [
        "Recombinant AAV capsids bind cell surface glycan receptors and enter via receptor-mediated endocytosis",
        "The virion escapes endosomal acidification and translocates across the cytoplasm to dock at the nuclear pore",
        "The single-stranded viral DNA genome is injected into the nucleus, shedding the external protein capsid",
        "Host DNA polymerases synthesize the complementary second strand using the self-priming 3' ITR hairpin",
        "The double-stranded genomes circularize and form stable concatemeric episomes driving lifelong transgene expression"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each viral vector platform to its defining pharmacological parameter.",
      "matchPairs": [
        { "left": "Adeno-Associated Virus (rAAV)", "right": "Non-integrating episomal vector with ~4.7 kb payload capacity ideal for post-mitotic neurons and retina" },
        { "left": "Lentiviral Vector (LV)", "right": "Integrating retroviral vector with ~8-10 kb capacity allowing stable inheritance in dividing T cells and stem cells" },
        { "left": "Inverted Terminal Repeats (ITRs)", "right": "Only viral cis-elements retained in rAAV, forming hairpins that serve as replication origins and packaging signals" },
        { "left": "VSV-G Envelope Pseudotyping", "right": "Replaces native viral envelope with vesicular stomatitis virus G protein to grant broad cell tropism and high stability" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In recombinant AAV vector design, the only viral sequences retained flanking the therapeutic transgene are the 145-bp inverted ___ repeats (ITRs).",
      "blankAnswer": "terminal",
      "blankDistractors": ["promoter", "enhancer", "polyadenylation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is a Lentiviral vector strictly preferred over an AAV vector for engineering autologous Hematopoietic Stem Cells (HSCs) to treat genetic blood disorders like Sickle Cell Disease or SCID?",
      "options": [
        { "text": "HSCs are rapidly dividing stem cells; because AAV remains as a non-integrating episome, the therapeutic gene would be diluted out and lost after a few rounds of division, whereas Lentivirus integrates stably into the host chromosome, ensuring lifelong transmission to all progeny blood cells", "isCorrect": true, "explanation": "Correct! Recombinant AAV does not integrate into host chromosomes; it persists as an episome (a free circular minichromosome in the nucleus). While this provides permanent expression in non-dividing post-mitotic cells (like neurons or retinal cells), in dividing cells like hematopoietic stem cells, episomes are not replicated along with host chromosomes and are rapidly diluted to zero during cell division. Lentiviral vectors utilize viral Integrase to permanently stitch the therapeutic transgene directly into host chromosomal DNA, ensuring that every single daughter cell, erythrocyte, and lymphocyte inherited from that stem cell retains the corrected gene." },
        { "text": "Because AAV only infects bacteria and cannot enter human stem cells", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Lentiviruses destroy all white blood cells", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AAV has an unlimited 50-kb payload size", "isCorrect": false, "explanation": "Incorrect: AAV is limited to ~4.7 kb." }
      ]
    }
  ]
}
```
