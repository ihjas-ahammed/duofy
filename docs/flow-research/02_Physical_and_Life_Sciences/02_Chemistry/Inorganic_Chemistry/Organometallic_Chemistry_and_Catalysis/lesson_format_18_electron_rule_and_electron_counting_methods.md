# Duofy Reusable Lesson Format: 18-Electron Rule and Electron Counting Methods

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Organometallic_Chemistry_and_Catalysis`  
**Lesson Format Type:** `18_electron_rule_and_electron_counting_methods`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the valence electron accounting and stability rules of transition metal organometallics: master both the **Neutral (Covalent) Method** and the **Ionic (EAN) Method** for electron counting, classify ligand electron donations (1-electron X-type like alkyls/halides, 2-electron L-type like $\text{CO}/\text{PR}_3$, multi-hapto $\text{LX}_n$ like $\eta^5\text{-Cp}$ 5e/6e and $\eta^3\text{-allyl}$ 3e/4e), verify the **18-Electron Rule**, evaluate the **16-Electron Square Planar $d^8$ Exception** ($\text{Rh}^{\text{I}}, \text{Ir}^{\text{I}}, \text{Pd}^{\text{II}}, \text{Pt}^{\text{II}}$, Vaska's complex), and calculate metal-metal bond orders in polynuclear carbonyl clusters.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 18-Electron Rule & Neutral vs Ionic Counting Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Ferrocene 18-Electron Verification Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Organometallic Ligand & Electron Contribution Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Stable Square Planar d8 Complex Electron Count Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Vaska's Complex 16-Electron Valence and Oxidation State Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 18-Electron Rule & Counting Methodologies:
   - **The 18-Electron Rule (Irving Langmuir 1921, N.V. Sidgwick 1927):**
     - Transition metal valence shells reach noble-gas stability when filled with 18 electrons (9 valence orbitals: five $(n-1)d$, one $ns$, three $np$).
   - **The Two Dual Accounting Systems:**
     - **Neutral (Covalent) Method:** All ligands treated as neutral. Metal contributes Group Number ($G$) of valence electrons:
       $$\text{Electrons} = G_{\text{metal}} + \sum e_{\text{neutral ligand}} - (\text{Charge of complex})$$
     - **Ionic Method:** Ligands cleaved with full octet charges. Metal assigned formal oxidation state ($m$) and $d^{G-m}$ electrons:
       $$\text{Electrons} = d\text{-count} + \sum e_{\text{ionic ligand}}$$
   - **Ligand Classification Matrix:**
     - **X-Type (1e neutral / 2e ionic):** $-\text{CH}_3, -\text{H}, -\text{Cl}, -\text{OR}$.
     - **L-Type (2e neutral / 2e ionic):** $\text{CO}, \text{PR}_3, \text{NH}_3, \eta^2\text{-alkene}$.
     - **$\text{L}_2\text{X}$-Type / $\eta^5\text{-Cp}$ (5e neutral / 6e ionic):** Cyclopentadienyl anion ($\text{Cp}^-$).
     - **$\text{LX}$-Type / $\eta^3\text{-allyl}$ (3e neutral / 4e ionic):** Allyl group.
   - **The 16-Electron Exception:** $d^8$ square-planar complexes of $\text{Rh}^{\text{I}}, \text{Ir}^{\text{I}}, \text{Pd}^{\text{II}}, \text{Pt}^{\text{II}}$ (e.g. Vaska's complex $[\text{IrCl}(\text{CO})(\text{PPh}_3)_2]$).
2. **Slide 2 (`ordering`):** Provide 5 steps counting electrons in Ferrocene $[\text{Fe}(\eta^5\text{-C}_5\text{H}_5)_2]$ by both methods: (1) look up Iron in the periodic table (Group 8 metal), (2) apply Neutral Method: Fe contributes 8 electrons; two neutral $\eta^5\text{-Cp}$ radicals contribute $2 \times 5 = 10$ electrons, (3) sum neutral method total: $8 + 10 = 18$ electrons, (4) apply Ionic Method: two $\text{Cp}^-$ anions impart a $+2$ oxidation state to Iron ($\text{Fe}^{\text{II}}$, $d^6$); two $\text{Cp}^-$ donate $2 \times 6 = 12$ electrons, (5) sum ionic method total: $6 + 12 = 18$ electrons, confirming that ferrocene is a remarkably stable 18-electron sandwich compound!
3. **Slide 3 (`matching`):** Pair 4 ligands ($\text{CO}$ carbonyl, $\eta^5\text{-Cp}$ cyclopentadienyl, $\text{CH}_3$ methyl alkyl, $\eta^3\text{-allyl}$) with their neutral-method electron contributions (2 electrons, 5 electrons, 1 electron, 3 electrons).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that square planar d8 complexes like Vaska's complex are stable with 16 valence electrons. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Vaska's complex electron count and oxidation state: For Vaska's complex, $[\text{IrCl}(\text{CO})(\text{PPh}_3)_2]$, what is the formal oxidation state of Iridium, the $d^n$ count, and the total valence electron count? ($\text{Ir}^{\text{I}}$ ($d^8$) with **16 valence electrons**; Iridium is Group 9; $\text{Cl}^-$ is $-1$, while $\text{CO}$ and two $\text{PPh}_3$ are neutral ($0$), giving $\text{Ir}^{\text{I}}$ ($d^8$); in neutral counting: $9\ (\text{Ir}) + 1\ (\text{Cl}) + 2\ (\text{CO}) + 2(2)\ (\text{PPh}_3) = 16\text{ electrons}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "18_electron_rule_and_electron_counting_methods",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The 18-Electron Rule and Electron Counting Methods**\n• **The 18-Electron Principle:** Transition metal complexes achieve closed-shell thermodynamic stability when valence electrons = 18 ($(n-1)d^{10} ns^2 np^6$).\n• **Neutral (Covalent) vs. Ionic Accounting:**\n  - **Neutral Method:** Metal contributes Group Number ($G$); ligands contribute neutral radical count:\n    $$\\text{Total } e^- = G_{\\text{metal}} + \\sum e_{\\text{neutral ligand}} - \\text{Charge}$$\n  - **Ionic Method:** Metal has oxidation state $m$ ($d^{G-m}$ electrons); ligands donate closed-shell lone pairs:\n    $$\\text{Total } e^- = d\\text{-count} + \\sum e_{\\text{ionic ligand}}$$\n• **Key Ligand Contributions (Neutral / Ionic):**\n  - **CO, PR$_3$, Alkene:** 2e / 2e (L-type).\n  - **H, Alkyl, Halide (Cl, Br):** 1e / 2e (X-type).\n  - **$\\eta^5$-Cp (Cyclopentadienyl):** 5e / 6e ($\text{L}_2\text{X}$-type).\n  - **$\\eta^3$-Allyl:** 3e / 4e ($\text{LX}$-type).\n• **16-Electron Exception:** $d^8$ square-planar complexes (Rh(I), Ir(I), Pd(II), Pt(II)) are stable at 16e⁻."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps verifying that Ferrocene, [Fe(eta^5-Cp)2], satisfies the 18-electron rule.",
      "orderItems": [
        "Identify Iron as a Group 8 transition metal in the periodic table",
        "Neutral Method: Iron atom contributes 8 valence electrons (G = 8)",
        "Two neutral eta^5-cyclopentadienyl (Cp) ring ligands donate 5 electrons each (2 * 5 = 10 e⁻)",
        "Sum neutral contributions to obtain total valence count: 8 + 10 = 18 valence electrons",
        "Ionic Method Cross-Check: Fe(II) is d6, and two Cp- anions donate 6 e⁻ each: 6 + 12 = 18 electrons"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each organometallic ligand to its electron contribution in the Neutral (Covalent) counting model.",
      "matchPairs": [
        { "left": "Carbonyl (CO) / Phosphine (PPh_3)", "right": "2-electron donor (L-type neutral Lewis base)" },
        { "left": "Alkyl (-CH_3) / Hydride (-H)", "right": "1-electron donor (X-type neutral radical)" },
        { "left": "Cyclopentadienyl (eta^5-Cp)", "right": "5-electron donor (L_2X-type aromatic ring)" },
        { "left": "eta^3-Allyl Radical", "right": "3-electron donor (LX-type delocalized pi-system)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Square planar d8 complexes such as Vaska's complex and Wilkinson's catalyst are stable with ___ valence electrons.",
      "blankAnswer": "16",
      "blankDistractors": ["18", "14", "12"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For Vaska's complex, trans-[Ir(CO)Cl(PPh3)2], what is the formal oxidation state of Iridium and the total valence electron count?",
      "options": [
        { "text": "Ir(I) with 16 valence electrons (Group 9 Ir + 1 e⁻ from Cl + 2 e⁻ from CO + 2*2 e⁻ from two PPh3 = 16 e⁻; Ir(I) is d8, square planar)", "isCorrect": true, "explanation": "Correct! Iridium is in Group 9. Chloride is a 1e donor (neutral method) or -1 charge (ionic method), while CO and two PPh3 are neutral 2e donors. The oxidation state of Ir is +1 (d8 configuration). Total electron count = 9 (Ir) + 1 (Cl) + 2 (CO) + 4 (2*PPh3) = 16 electrons. As a d8 square-planar complex, it is exceptionally stable at 16 electrons." },
        { "text": "Ir(III) with 18 valence electrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ir(0) with 14 valence electrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ir(II) with 17 valence electrons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
