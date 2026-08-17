# Duofy Reusable Lesson Format: Peptide Bond Planarity and the Ramachandran Plot

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Structural_Biology / Protein_Structure_Primary_to_Quaternary`  
**Lesson Format Type:** `peptide_bond_planarity_and_the_ramachandran_plot`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum resonance, stereochemistry, and conformational conformational dihedral angles of the polypeptide backbone (Linus Pauling & Robert Corey 1951; G.N. Ramachandran 1963): analyze the **$40\%$ partial double-bond character** of the planar peptide bond restricting rotation around $\omega$ ($180^\circ$ for trans), define the two backbone degrees of freedom (**Phi [$\phi$] around $N\text{--}C_\alpha$** and **Psi [$\psi$] around $C_\alpha\text{--}C(=\text{O})$**), master the 4 quadrants of the **Ramachandran Plot** (**Upper-Left: $\beta$-Sheets** [$\phi \approx -120^\circ, \psi \approx +135^\circ$] and collagen; **Lower-Left: Right-Handed $\alpha$-Helices** [$\phi \approx -60^\circ, \psi \approx -45^\circ$]; **Upper-Right: Left-Handed $\alpha$-Helices** [$\phi \approx +60^\circ, \psi \approx +45^\circ$]), and contrast the conformational flexibility of **Glycine** (no side-chain steric clash) with **Proline** (rigid pyrrolidine ring locking $\phi \approx -65^\circ$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Planar Peptide Bond Resonance & Ramachandran Dihedral Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Polypeptide Backbone Atomic Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Ramachandran Quadrant & Allowed Secondary Structure Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Amino Acid with Broadest Allowed Ramachandran Conformational Space Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Proline Pyrrolidine Ring Steric Constraint on Phi Dihedral Angle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Peptide Bond Stereochemistry & The Ramachandran Plot (1951/1963):
   - **The Planar Peptide Bond (Linus Pauling):**
     - Resonance between carbonyl double bond and nitrogen lone pair gives the $C\text{--}N$ bond **$40\%$ partial double-bond character** (length $1.32\text{ \AA}$ vs single $1.47\text{ \AA}$).
     - The 6 atoms of the peptide unit ($C_{\alpha 1}\text{, C(=O), N(H), } C_{\alpha 2}$) are coplanar; rotation is restricted ($\omega = 180^\circ$ for trans).
   - **The Backbone Dihedral Angles:**
     - **Phi ($\phi$):** Torsion angle around the $\mathbf{N\text{--}C_\alpha}$ bond.
     - **Psi ($\psi$):** Torsion angle around the $\mathbf{C_\alpha\text{--}C(=\text{O})}$ bond.
   - **The Ramachandran Plot Map (G.N. Ramachandran, 1963):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Ramachandran Region} & \mathbf{\phi\text{ Angle}} & \mathbf{\psi\text{ Angle}} & \textbf{Secondary Structure Motif} \\
     \hline
     \textbf{Upper-Left Quadrant} & -140^\circ \text{ to } -100^\circ & +120^\circ \text{ to } +160^\circ & \mathbf{\beta\text{-Sheets}} \text{ (Parallel \& Antiparallel), Collagen} \\
     \textbf{Lower-Left Quadrant} & -80^\circ \text{ to } -40^\circ & -60^\circ \text{ to } -30^\circ & \mathbf{\text{Right-Handed }\alpha\text{-Helices}} \ (\phi \approx -57^\circ, \psi \approx -47^\circ) \\
     \textbf{Upper-Right Quadrant} & +40^\circ \text{ to } +80^\circ & +30^\circ \text{ to } +70^\circ & \mathbf{\text{Left-Handed }\alpha\text{-Helices}} \ (\text{mostly Glycine}) \\
     \textbf{Forbidden Zones} & \text{Various} & \text{Various} & \text{Steric atomic clashes between carbonyl O and side chain} \\
     \hline
     \end{array}$$
   - **Special Amino Acids:**
     - **Glycine ($R=\text{H}$):** Lacks a $C_\beta$ carbon $\implies$ no steric clashing $\implies$ allowed across all 4 quadrants!
     - **Proline:** Cyclic pyrrolidine ring links $C_\delta$ back to main-chain nitrogen $\implies$ locks $\phi$ at $\mathbf{-65^\circ \pm 15^\circ}$, acting as an $\alpha$-helix breaker.
2. **Slide 2 (`ordering`):** Provide 5 steps traversing the repeating backbone atoms of a polypeptide chain: (1) start at the N-terminal alpha-amino nitrogen (N), (2) rotate around the phi (phi) bond into the central tetrahedral alpha-carbon (C-alpha) bearing the amino acid side chain, (3) rotate around the psi (psi) bond into the sp2 carbonyl carbon (C=O), (4) traverse the planar, non-rotatable peptide bond (omega = 180 degrees) into the next amide nitrogen (N), (5) repeat the cycle across the next C-alpha and carbonyl carbon toward the free C-terminal carboxylate!
3. **Slide 3 (`matching`):** Pair 4 Ramachandran conformational zones (Upper-Left Quadrant, Lower-Left Quadrant, Upper-Right Quadrant, Proline Constrained Region) with their secondary structural motifs.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the achiral amino acid possessing the broadest allowed region on the Ramachandran plot due to the absence of a beta-carbon is glycine. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the stereochemical rigidity of Proline in protein folding: Why is Proline unique among all 20 standard proteinogenic amino acids in having its phi ($\phi$) dihedral angle restricted strictly to approximately $-65^\circ$ on the Ramachandran plot? (Because Proline's **cyclic pyrrolidine side chain is covalently bonded directly to its own backbone alpha-amino nitrogen atom**, forming a rigid five-membered ring that mechanically locks rotation around the $N\text{--}C_\alpha$ bond).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "peptide_bond_planarity_and_the_ramachandran_plot",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Peptide Bond Planarity & The Ramachandran Plot (1951/1963)**\n• **Resonance & Planarity (Pauling):**\n  - $C\\text{--}N$ has **$40\\%$ partial double-bond character** $\\implies$ 6 atoms ($C_{\\alpha 1}\\text{, C, O, N, H, } C_{\\alpha 2}$) are coplanar; $\\omega = 180^\\circ$ (trans).\n• **The Backbone Torsion Angles:**\n  - **Phi ($\\\\phi$):** Rotation around the $\\mathbf{N\\text{--}C_\\alpha}$ single bond.\n  - **Psi ($\\\\psi$):** Rotation around the $\\mathbf{C_\\alpha\\text{--}C(=O)}$ single bond.\n• **The Ramachandran Plot (G.N. Ramachandran, 1963):**\n$$\n\\begin{array}{|l|c|c|l|}\n\\hline\n\\textbf{Quadrant} & \\mathbf{\\phi} & \\mathbf{\\psi} & \\textbf{Favored Conformation} \\\\\n\\hline\n\\textbf{Upper-Left} & -120^\\circ & +135^\\circ & \\mathbf{\\beta\\text{-Sheets}} \\text{ (Parallel / Antiparallel), Collagen} \\\\\n\\textbf{Lower-Left} & -60^\\circ & -45^\\circ & \\mathbf{\\text{Right-Handed }\\alpha\\text{-Helices}} \\\\\n\\textbf{Upper-Right} & +60^\\circ & +45^\\circ & \\mathbf{\\text{Left-Handed }\\alpha\\text{-Helices}} \\text{ (Rare; Glycine only)} \\\\\n\\hline\n\\end{array}\n$$\n• **Exceptions:** **Glycine** (no $C_\\beta$) fits all quadrants; **Proline** (cyclic ring) locked at $\\phi \\approx -65^\\circ$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential atoms and dihedral rotation angles along a polypeptide backbone.",
      "orderItems": [
        "Commence at the amide nitrogen (N) atom of the peptide backbone",
        "Rotate around the Phi (phi) dihedral angle to reach the central alpha-carbon (C-alpha)",
        "Rotate around the Psi (psi) dihedral angle to reach the carbonyl carbon (C=O)",
        "Traverse the rigid, planar peptide bond (Omega = 180 degrees) to reach the next nitrogen atom",
        "Arrive at the subsequent residue C-alpha atom, repeating the structural backbone rhythm"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Ramachandran plot region to its corresponding secondary structure.",
      "matchPairs": [
        { "left": "Upper-Left Quadrant (phi negative, psi positive)", "right": "Extended beta-sheet strands (both parallel and antiparallel) and polyproline II/collagen helices" },
        { "left": "Lower-Left Quadrant (phi negative, psi negative)", "right": "Right-handed alpha-helices with 3.6 residues per turn and i to i+4 hydrogen bonding" },
        { "left": "Upper-Right Quadrant (phi positive, psi positive)", "right": "Left-handed alpha-helices, populated almost exclusively by glycine residues" },
        { "left": "Disallowed / White Regions", "right": "Conformational space forbidden due to steric clashes between van der Waals electron clouds" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The only standard amino acid possessing an achiral side chain and the widest allowed conformational territory on a Ramachandran plot is ___.",
      "blankAnswer": "glycine",
      "blankDistractors": ["alanine", "proline", "valine"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the amino acid Proline unique among all 20 proteinogenic amino acids in having its phi (phi) dihedral angle locked strictly to approximately -65 degrees on the Ramachandran plot?",
      "options": [
        { "text": "Proline's non-polar aliphatic side chain loops back and covalently bonds to its own backbone alpha-amino nitrogen atom, creating a rigid five-membered pyrrolidine ring that physically prevents free rotation around the N-C_alpha bond", "isCorrect": true, "explanation": "Correct! Proline is technically an imino acid because its cyclic side chain (a 3-carbon aliphatic chain) forms a covalent bond with the main-chain nitrogen atom, forming a rigid five-membered pyrrolidine ring. Because the N-C_alpha single bond is incorporated into this five-membered ring, rotation around the phi angle is severely constrained and mechanically locked to approximately -65 degrees (+/- 15 degrees). This rigid conformation prevents Proline from adopting the standard geometry required for alpha-helices (where it acts as a classic 'helix breaker' due to lack of an amide hydrogen for H-bonding) while making it ideal for sharp turns (beta-turns) on protein surfaces." },
        { "text": "Because Proline contains a sulfur atom that forms a disulfide bond with itself", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Proline is always charged positively at neutral pH", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Proline lacks a carboxyl group", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
