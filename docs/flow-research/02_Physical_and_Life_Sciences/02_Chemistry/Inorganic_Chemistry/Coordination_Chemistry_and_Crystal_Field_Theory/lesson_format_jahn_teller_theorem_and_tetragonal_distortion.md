# Duofy Reusable Lesson Format: Jahn-Teller Theorem and Tetragonal Distortion

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Coordination_Chemistry_and_Crystal_Field_Theory`  
**Lesson Format Type:** `jahn_teller_theorem_and_tetragonal_distortion`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural distortions of electronically degenerate coordination complexes: state the **Jahn-Teller Theorem (Hermann Jahn & Edward Teller, 1937)**, differentiate between **Strong Jahn-Teller Distortions** (asymmetric electron occupancy in the directly bonding/antibonding $e_g$ set: $d^9$ $\text{Cu}^{\text{II}}$, high-spin $d^4$ $\text{Cr}^{\text{II}}/\text{Mn}^{\text{III}}$, low-spin $d^7$ $\text{Co}^{\text{II}}$) and **Weak Distortions** (asymmetry in non-pointing $t_{2g}$ set: $d^1, d^2$, high-spin $d^6, d^7$), analyze **Tetragonal Elongation ($z$-out distortion)** vs **Tetragonal Compression ($z$-in)**, and trace the split $d$-orbital hierarchy ($d_{x^2-y^2} \gg d_{xy} > d_{z^2} > d_{xz}, d_{yz}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Jahn-Teller Theorem & Tetragonal Elongation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step d9 Octahedral to Tetragonal Distortion Splitting Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Electron Configuration & Jahn-Teller Magnitude Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Strong Jahn-Teller Distortion Orbital Subshell Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cu(II) Hexaaqua Axial vs Equatorial Bond Length Asymmetry Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Jahn-Teller Theorem & Tetragonal Distortion:
   - **The Jahn-Teller Theorem (1937):**
     > *"Any non-linear molecular system in an electronically degenerate ground state is unstable and will undergo geometrical distortion that lowers its symmetry, removes the degeneracy, and lowers the overall electronic energy."*
   - **Strong vs Weak Jahn-Teller Distortion:**
     - **Strong Distortions ($e_g$ Asymmetry):** Because $e_g$ ($d_{z^2}, d_{x^2-y^2}$) orbitals point directly along metal-ligand axes, unequal electron filling produces massive steric/electronic imbalance:
       - $d^9$ ($\text{Cu}^{\text{II}}$: $t_{2g}^6 e_g^3 \implies (d_{z^2})^2 (d_{x^2-y^2})^1$).
       - High-Spin $d^4$ ($\text{Cr}^{\text{II}}, \text{Mn}^{\text{III}}$: $t_{2g}^3 e_g^1$).
       - Low-Spin $d^7$ ($\text{Co}^{\text{II}}, \text{Ni}^{\text{III}}$: $t_{2g}^6 e_g^1$).
     - **Weak Distortions ($t_{2g}$ Asymmetry):** Orbitals point between axes $\implies$ minor effect ($d^1, d^2$, high-spin $d^6, d^7$).
     - **Zero Distortion (Non-Degenerate):** $d^3$ ($t_{2g}^3$), High-Spin $d^5$ ($t_{2g}^3 e_g^2$), Low-Spin $d^6$ ($t_{2g}^6$), $d^8$ ($t_{2g}^6 e_g^2$), $d^{10}$ ($t_{2g}^6 e_g^4$).
   - **Tetragonal Elongation ($z$-Out):**
     - Elongating the two axial ligands along the $z$-axis lowers repulsion with $d_{z^2}$, stabilizing $d_{z^2}$ and $d_{xz}, d_{yz}$.
     - The two paired electrons occupy the stabilized $d_{z^2}$, and the single unpaired electron occupies the higher $d_{x^2-y^2}$, yielding net electronic energy stabilization!
2. **Slide 2 (`ordering`):** Provide 5 steps showing how octahedral $[\text{Cu}(\text{H}_2\text{O})_6]^{2+}$ undergoes Jahn-Teller elongation: (1) start in regular octahedral $O_h$ symmetry where $\text{Cu}^{\text{II}}$ ($d^9$) has configuration $t_{2g}^6 e_g^3$, (2) recognize the electronic degeneracy in the $e_g$ set: $(d_{z^2})^2(d_{x^2-y^2})^1$ or $(d_{z^2})^1(d_{x^2-y^2})^2$, (3) stretch the two axial water ligands along the $z$-axis ($z$-out distortion), (4) lowering axial electrostatic repulsion causes $d_{z^2}$ to drop in energy by $\delta_1$ and $d_{x^2-y^2}$ to rise by $\delta_1$, (5) place the two paired electrons in lower $d_{z^2}$ and single electron in $d_{x^2-y^2}$, removing degeneracy and lowering total energy by $\delta_1$!
3. **Slide 3 (`matching`):** Pair 4 coordination complexes ($[\text{Cu}(\text{H}_2\text{O})_6]^{2+}$ ($d^9$), $[\text{Cr}(\text{H}_2\text{O})_6]^{3+}$ ($d^3$), $[\text{Ti}(\text{H}_2\text{O})_6]^{3+}$ ($d^1$), High-spin $[\text{Mn}(\text{H}_2\text{O})_6]^{3+}$ ($d^4$)) with their Jahn-Teller distortion behavior (Strong tetragonal distortion, Zero distortion / regular octahedral, Weak distortion, Strong tetragonal distortion).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that strong Jahn-Teller distortions occur specifically when there is degenerate electron occupancy in the e_g orbital set. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical manifestation of Jahn-Teller distortion in $[\text{Cu}(\text{H}_2\text{O})_6]^{2+}$: What does single-crystal X-ray diffraction reveal about the bond lengths in octahedral copper(II) hexaaqua complexes? (It reveals **4 short equatorial $\text{Cu}-\text{O}$ bonds ($\sim 1.96\text{ Å}$) and 2 significantly longer axial $\text{Cu}-\text{O}$ bonds ($\sim 2.30\text{ Å}$)** due to strong Jahn-Teller tetragonal elongation).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "jahn_teller_theorem_and_tetragonal_distortion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Jahn-Teller Theorem and Tetragonal Distortion**\n• **The Jahn-Teller Theorem (1937):**\n$$\n\\text{Non-linear molecule in degenerate state} \\longrightarrow \\text{Spontaneous geometric distortion}\n$$\n• **Strong vs Weak Distortion:**\n  - **Strong Distortion ($e_g$ Asymmetry):** Orbitals point directly at ligands $\\implies$\n    - $d^9$ ($\\text{Cu}^{\\text{II}}$: $t_{2g}^6 e_g^3$)\n    - High-Spin $d^4$ ($\\text{Cr}^{\\text{II}}, \\text{Mn}^{\\text{III}}$: $t_{2g}^3 e_g^1$)\n    - Low-Spin $d^7$ ($\\text{Co}^{\\text{II}}$: $t_{2g}^6 e_g^1$)\n  - **Weak Distortion ($t_{2g}$ Asymmetry):** $d^1, d^2$, High-spin $d^6, d^7$.\n  - **Zero Distortion (Symmetric):** $d^3, d^5\\text{ (HS)}, d^6\\text{ (LS)}, d^8, d^{10}$.\n• **Tetragonal Elongation ($z$-Out):** Stretching the 2 axial ligands lowers $d_{z^2}$ and $d_{xz}/d_{yz}$, putting electron pairs in lower energy states and lifting degeneracy."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of Jahn-Teller tetragonal elongation in octahedral [Cu(H2O)6]2+ (d9).",
      "orderItems": [
        "State the ideal octahedral electron configuration for Cu(II): t_2g^6 e_g^3",
        "Identify orbital degeneracy in the e_g subshell: either (d_z²)^2(d_x²-y²)^1 or (d_z²)^1(d_x²-y²)^2",
        "Elongate the two trans axial water ligands outward along the z-axis (tetragonal distortion)",
        "Decreased axial ligand repulsion drops the d_z² orbital energy by delta_1 while raising d_x²-y² by delta_1",
        "Place the 2 paired electrons into the lowered d_z² orbital to net a total electronic stabilization energy of -delta_1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each transition metal complex to its Jahn-Teller distortion status.",
      "matchPairs": [
        { "left": "[Cu(H2O)6]2+ (Cu2+, d9)", "right": "Strong Jahn-Teller distortion (e_g³ asymmetric occupancy; 2 long axial bonds, 4 short equatorial)" },
        { "left": "[Cr(H2O)6]3+ (Cr3+, d3)", "right": "Zero distortion (symmetrically half-filled t_2g³ e_g⁰; perfect octahedral geometry)" },
        { "left": "High-spin [Mn(H2O)6]3+ (Mn3+, d4)", "right": "Strong Jahn-Teller distortion (e_g¹ asymmetric occupancy)" },
        { "left": "[Ti(H2O)6]3+ (Ti3+, d1)", "right": "Weak Jahn-Teller distortion (t_2g¹ asymmetric occupancy pointing between ligands)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Strong Jahn-Teller distortions occur specifically when there is an electronically degenerate configuration in the ___ orbital subshell.",
      "blankAnswer": "eg",
      "blankDistractors": ["t2g", "4s", "4p"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What geometric bond length pattern does X-ray crystallography reveal for the copper-oxygen bonds in octahedral [Cu(H2O)6]2+?",
      "options": [
        { "text": "4 short equatorial Cu-O bonds (~1.96 Å) and 2 significantly LONGER axial Cu-O bonds (~2.30 Å), caused by Jahn-Teller tetragonal elongation along the z-axis", "isCorrect": true, "explanation": "Correct! Jahn-Teller elongation moves the two axial ligands outward along the z-axis to lower the energy of the doubly-occupied d_z^2 orbital. This produces 4 short in-plane equatorial bonds and 2 elongated axial bonds, which is the classic experimental signature of Cu(II) complexes." },
        { "text": "6 perfectly identical bond lengths of 2.05 Å", "isCorrect": false, "explanation": "Incorrect: That would only occur if there were no Jahn-Teller distortion." },
        { "text": "2 short equatorial and 4 long axial bonds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Zero bonds (the complex dissociates immediately)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
