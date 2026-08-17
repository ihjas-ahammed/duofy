# Duofy Reusable Lesson Format: The Complement System (Activation Pathways and MAC Lysis)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Innate_and_Adaptive_Immune_Responses`  
**Lesson Format Type:** `complement_system_activation_pathways_and_mac_lysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the biochemical zymogen cascade, convertase stoichiometries, and lytic effector mechanisms of the complement system (Jules Bordet, Nobel Prize in Physiology or Medicine 1919; Paul Ehrlich): contrast the 3 initiation arms (**1. Classical Pathway: C1qrs binding IgM/IgG immune complexes** $\to$ **$\text{C4b2a}$ C3 convertase**; **2. Lectin Pathway: MBL/MASP binding mannose** $\to$ **$\text{C4b2a}$ C3 convertase**; **3. Alternative Pathway: Spontaneous C3 tickover** $\to$ **$\text{C3bBb}$ C3 convertase**), master the 3 major biological effector functions (**C3b Opsonization**, **C3a/C5a Anaphylatoxin inflammation/chemotaxis**, and **C5b-9 Membrane Attack Complex [MAC] osmotic lysis**), and analyze regulatory checkpoints (**CD59 Protectin, DAF/CD55**) and deficiencies (Paroxysmal Nocturnal Hemoglobinuria [PNH], *Neisseria* susceptibility with terminal MAC defects).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 3 Complement Initiation Pathways & Convertases Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Classical Pathway Activation to C5b-9 MAC Assembly Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Complement Fragment / Regulator & Effector Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Most Potent Complement Anaphylatoxin and Neutrophil Chemoattractant Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Terminal Complement C5-C9 Deficiency and Neisseria Meningitidis Susceptibility Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Complement System (1919 Nobel Prize):
   - **The 3 Activation Pathways & Convertases:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Pathway} & \textbf{Initiating Trigger} & \textbf{C3 Convertase} & \textbf{C5 Convertase} \\
     \hline
     \textbf{Classical} & \text{Ag-Ab complexes (IgM } \ge 1 \text{ or IgG } \ge 2\text{) } \to \mathbf{\text{C1qrs}} & \mathbf{C4b2a} & \mathbf{C4b2a3b} \\
     \textbf{Lectin} & \text{Mannose-Binding Lectin (MBL) / Ficolins } \to \mathbf{\text{MASP-1/2}} & \mathbf{C4b2a} & \mathbf{C4b2a3b} \\
     \textbf{Alternative} & \text{Spontaneous C3 tickover } (\text{H}_2\text{O}) + \text{Factor B/D} & \mathbf{C3bBb} & \mathbf{C3b_2Bb} \\
     \hline
     \end{array}$$
   - **The 3 Biological Effector Outputs:**
     1. **Opsonization:** **C3b** covalently coats microbial surfaces $\implies$ recognized by Complement Receptor 1 (CR1) on macrophages and neutrophils for phagocytosis.
     2. **Inflammation & Anaphylatoxins:** **C3a and C5a** (C5a is the most potent) trigger mast cell histamine release, vascular permeability, and act as chemoattractants for neutrophils.
     3. **Direct Lysis (Membrane Attack Complex - MAC):**
        - C5 convertase cleaves $\text{C5} \to \text{C5a} + \mathbf{\text{C5b}}$.
        - $\mathbf{\text{C5b} + \text{C6} + \text{C7} + \text{C8} + 10-16\times \text{C9}} \implies \mathbf{\text{C5b-9 (MAC)}}$.
        - Forms a $10\text{-nm}$ hollow cylindrical pore in the microbial outer membrane $\implies$ massive water influx $\implies$ **Osmotic Lysis**!
   - **Host Protection:** **CD55 (DAF)** accelerates convertase decay; **CD59 (Protectin)** binds C8/C9 to block MAC assembly on human cells.
2. **Slide 2 (`ordering`):** Provide 5 steps of the classical complement cascade leading to MAC formation: (1) multiple IgG or a single pentameric IgM bind antigens on a bacterial surface, exposing their Fc C1q-binding sites, (2) C1q binds the antibody Fc regions, activating the associated serine proteases C1r and C1s, (3) C1s cleaves C4 and C2 to form the active C4b2a complex (Classical C3 Convertase), (4) C4b2a cleaves thousands of C3 molecules into C3a and C3b; a C3b fragment joins the complex to form C4b2a3b (C5 Convertase), (5) C5 convertase cleaves C5 to release C5b, which sequentially recruits C6, C7, C8, and multiple C9 monomers to punch a lytic C5b-9 MAC pore into the bacterial membrane!
3. **Slide 3 (`matching`):** Pair 4 complement components (C3b, C5a, C5b-9 MAC Complex, CD59 / Protectin) with their specific immunological functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the most potent complement anaphylatoxin and neutrophil chemoattractant is C5a. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on terminal complement deficiency: Patients with an inherited homozygous deficiency in terminal complement components (C5, C6, C7, C8, or C9) are specifically and recurrently susceptible to severe, life-threatening infections caused by which bacterial genus? (*Neisseria* species [such as *Neisseria meningitidis* and *Neisseria gonorrhoeae*], because **their thin Gram-negative cell envelopes are uniquely susceptible to and reliant on direct bactericidal killing by the Membrane Attack Complex [C5b-9]**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "complement_system_activation_pathways_and_mac_lysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Complement System (1919 Nobel)**\n• **The 3 Initiation Arms & Convertases:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Pathway} & \\textbf{Trigger} & \\textbf{C3 Convertase} & \\textbf{C5 Convertase} \\\\\n\\hline\n\\textbf{Classical} & \\text{IgM / IgG + C1qrs} & \\mathbf{C4b2a} & \\mathbf{C4b2a3b} \\\\\n\\textbf{Lectin} & \\text{MBL / MASP + Mannose} & \\mathbf{C4b2a} & \\mathbf{C4b2a3b} \\\\\n\\textbf{Alternative} & \\text{C3 tickover + Factor B/D} & \\mathbf{C3bBb} & \\mathbf{C3b_2Bb} \\\\\n\\hline\n\\end{array}\n$$\n• **The 3 Biological Effector Arms:**\n  1. **Opsonization:** **C3b** tags microbes for CR1-mediated macrophage phagocytosis.\n  2. **Anaphylatoxins:** **C3a & C5a** (C5a = most potent) drive vascular leak & neutrophil chemotaxis.\n  3. **Direct Lysis (MAC):** $\\mathbf{\\text{C5b} + \\text{C6} + \\text{C7} + \\text{C8} + 16\\times \\mathbf{\\text{C9}}} \\implies \\mathbf{\\text{C5b-9 Pore}} \\implies$ **Osmotic Lysis**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential enzymatic steps of the classical complement cascade to MAC pore assembly.",
      "orderItems": [
        "Antibodies (IgM pentamer or IgG clusters) bind bacterial surface antigens, docking the C1qrs complex",
        "Activated C1s serine protease cleaves circulating C4 and C2 to assemble the C4b2a C3 convertase",
        "C4b2a cleaves abundant C3 into soluble C3a anaphylatoxin and membrane-bound C3b opsonin",
        "A C3b subunit binds C4b2a to construct the C4b2a3b C5 convertase, which cleaves C5 to generate C5b",
        "C5b sequentially binds C6, C7, C8, and polymerizes 10-16 C9 molecules into the transmembrane C5b-9 MAC pore"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each complement component to its specific biological activity.",
      "matchPairs": [
        { "left": "C3b Complement Fragment", "right": "Premier opsonin that covalently tags microbial surfaces for phagocytosis by CR1-bearing macrophages" },
        { "left": "C5a Anaphylatoxin", "right": "Potent chemoattractant that recruits neutrophils and triggers mast cell histamine degranulation" },
        { "left": "C5b-9 Membrane Attack Complex (MAC)", "right": "Hollow cylindrical transmembrane pore that drives osmotic fluid influx and bacterial cell lysis" },
        { "left": "CD59 (Protectin)", "right": "Host membrane GPI-anchored regulator that blocks C9 polymerization to prevent self-cell lysis" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The most potent complement anaphylatoxin and neutrophil chemoattractant generated during cascade activation is C___a.",
      "blankAnswer": "5",
      "blankDistractors": ["3", "4", "2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A patient with an inherited deficiency in complement component C7 presents with recurrent, severe disseminated bacterial meningitis. Which bacterial genus is this patient specifically unable to clear?",
      "options": [
        { "text": "NEISSERIA (e.g. Neisseria meningitidis and Neisseria gonorrhoeae); because Neisseria has a thin Gram-negative cell wall that is exceptionally vulnerable to direct osmotic killing by the Membrane Attack Complex (C5b-9), making terminal complement activity essential for its defense", "isCorrect": true, "explanation": "Correct! While most Gram-positive and heavily encapsulated bacteria are cleared primarily through C3b opsonization and phagocytosis, the genus Neisseria (including Neisseria meningitidis and Neisseria gonorrhoeae) is uniquely dependent on direct bactericidal killing via the Membrane Attack Complex (MAC; C5b-9). Individuals with congenital deficiencies in the terminal complement pathway (C5, C6, C7, C8, or C9) have normal opsonization and phagocytosis, but cannot assemble the MAC pore. Consequently, they experience a 1,000- to 10,000-fold increased risk of recurrent invasive Neisserial infections." },
        { "text": "Streptococcus pneumoniae", "isCorrect": false, "explanation": "Incorrect: S. pneumoniae is cleared by C3b opsonization/phagocytosis." },
        { "text": "Mycobacterium tuberculosis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Candida albicans", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
