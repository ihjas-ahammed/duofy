# Duofy Reusable Lesson Format: Heterocyclic Reactivity (Pyrrole vs. Pyridine)

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Heterocyclic_Compounds_and_Biomolecules`  
**Lesson Format Type:** `heterocyclic_reactivity_pyrrole_vs_pyridine`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the electronic dichotomy and regioselectivity of aromatic heterocycles: contrast **5-Membered $\pi$-Excessive Heterocycles (Pyrrole, Furan, Thiophene)** with **6-Membered $\pi$-Deficient Heterocycles (Pyridine)**, analyze **Electrophilic Aromatic Substitution (EAS)** regiochemistry (Pyrrole selectively attacks at **C2 / $\alpha$** with 3 resonance forms including stable iminium, vs Pyridine selectively attacking sluggishly at **C3 / $\beta$** to avoid putting positive charge on electronegative N), and explain why pyrrole is non-basic ($\text{p}K_a \approx -3.8$) while pyridine is basic ($\text{p}K_a \approx 5.25$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pi-Excessive vs Pi-Deficient Heterocycle EAS Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Pyrrole C2 vs C3 EAS Resonance Comparison Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Heterocycle & Electronic / Reactivity Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Pyrrole Electrophilic Substitution Preferred Carbon Position Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Pyridine EAS Reluctance and Meta-Substitution Electronic Origin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Heterocyclic Aromatic Reactivity:
   - **$\pi$-Excessive Heterocycles (Pyrrole, Furan, Thiophene):**
     - $6\pi$ electrons delocalized over 5 ring atoms ($1.2\pi\ e^-/\text{atom}$).
     - The nitrogen/heteroatom lone pair is part of the aromatic sextet $\implies$ Pyrrole is non-basic ($\text{p}K_a \approx -3.8$; protonation destroys aromaticity!).
     - **EAS Regiochemistry:** Reacts with extreme speed, selectively at the **C2 ($\alpha$) position** (3 resonance forms for carbocation intermediate vs only 2 for C3 attack).
   - **$\pi$-Deficient Heterocycles (Pyridine):**
     - $6\pi$ electrons over 6 ring atoms with electronegative N inductively pulling electrons away ($< 1.0\pi\ e^-/\text{C-atom}$).
     - The nitrogen lone pair resides in an $s p^2$ orbital orthogonal to the $\pi$-system $\implies$ Pyridine is basic ($\text{p}K_a \approx 5.25$).
     - **EAS Regiochemistry:** Extremely sluggish ($>300^\circ\text{C}$); selectively occurs at the **C3 ($\beta$) position** (attack at C2/C4 produces an especially unstable high-energy resonance contributor with a sextet positive charge on electronegative nitrogen: $\text{C}=\overset{+}{\text{N}}$ with open shell).
2. **Slide 2 (`ordering`):** Provide 5 steps comparing the EAS mechanism of pyrrole at C2 vs C3: (1) electrophile ($\text{E}^+$) attacks pyrrole at the C2 ($\alpha$) position, (2) form the resonance-stabilized $\sigma$-complex intermediate, (3) draw the 3 resonance structures for C2 attack (including the major octet-complete iminium ion with positive charge on nitrogen), (4) note that C3 attack yields only 2 resonance structures without the third delocalized contributor, (5) deprotonation of the C2 intermediate restores the $6\pi$ aromatic sextet to yield the 2-substituted pyrrole product!
3. **Slide 3 (`matching`):** Pair 4 heterocycles (Pyrrole, Pyridine, Furan, Thiophene) with their key electronic and reactivity characteristics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that electrophilic aromatic substitution of pyrrole occurs preferentially at carbon-2 (the alpha position). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the electronic origin of pyridine EAS regiochemistry: Why does Electrophilic Aromatic Substitution (EAS) of pyridine occur selectively at C3 ($\beta$) rather than C2 ($\alpha$) or C4 ($\gamma$)? (Because electrophilic attack at C2 or C4 produces a resonance contributor with an **extremely unstable sextet positive charge on the electronegative nitrogen atom** ($\text{C}=\overset{+}{\text{N}}$ with 6 valence electrons), whereas C3 attack delocalizes the positive charge exclusively over the carbon atoms, avoiding the high-energy nitrogen cation contributor).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "heterocyclic_reactivity_pyrrole_vs_pyridine",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Heterocyclic Reactivity (Pyrrole vs. Pyridine)**\n• **Five-Membered $\\pi$-Excessive Rings (Pyrrole, Furan, Thiophene):**\n  - $6\\pi$ electrons over 5 atoms ($1.2\\pi\\ e^-/\\text{atom}$; electron-rich).\n  - Heteroatom lone pair is in the aromatic sextet $\\implies$ **Non-basic** ($\\text{p}K_a \\approx -3.8$).\n  - **EAS Preference:** Highly reactive; occurs selectively at **C2 ($\\alpha$)** (3 resonance forms vs 2 for C3).\n• **Six-Membered $\\pi$-Deficient Rings (Pyridine):**\n  - $6\\pi$ electrons over 6 atoms; electronegative N withdraws density.\n  - Nitrogen lone pair is in an $sp^2$ hybrid orbital outside the ring $\\implies$ **Basic** ($\\text{p}K_a \\approx 5.25$).\n  - **EAS Preference:** Highly unreactive; occurs exclusively at **C3 ($\\beta$)** (avoids placing sextet positive charge on electronegative nitrogen!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the mechanistic steps of Electrophilic Aromatic Substitution (EAS) on pyrrole at the C2 position.",
      "orderItems": [
        "The electron-rich pi system of pyrrole attacks an electrophile E+ at the C2 (alpha) position",
        "Generate the cationic sigma-complex (arenium ion) intermediate with positive charge delocalized",
        "Draw the three valid resonance structures for C2 attack, including the stable iminium contributor",
        "Observe that C3 attack produces only two resonance structures, making C2 attack kinetically favored",
        "A weak base removes the proton from C2 to eliminate positive charge and restore aromaticity"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each aromatic heterocycle to its electronic classification and EAS behavior.",
      "matchPairs": [
        { "left": "Pyrrole (5-Membered N-Heterocycle)", "right": "pi-Excessive; non-basic (lone pair in pi system); undergoes rapid EAS at C2" },
        { "left": "Pyridine (6-Membered N-Heterocycle)", "right": "pi-Deficient; basic (sp2 lone pair available); sluggish EAS occurs selectively at C3" },
        { "left": "Thiophene (5-Membered S-Heterocycle)", "right": "pi-Excessive; highest aromatic stability among 5-membered rings due to sulfur 3p-2p overlap" },
        { "left": "Furan (5-Membered O-Heterocycle)", "right": "pi-Excessive; least aromatic 5-membered ring, sensitive to acid-catalyzed ring opening" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Electrophilic aromatic substitution of pyrrole occurs with high regioselectivity at carbon-___ (the alpha position).",
      "blankAnswer": "2",
      "blankDistractors": ["3", "4", "5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does electrophilic aromatic substitution on pyridine occur selectively at the C3 (meta) position rather than at C2 (ortho) or C4 (para)?",
      "options": [
        { "text": "Electrophilic attack at C2 or C4 generates a resonance contributor with a formal positive charge on the highly electronegative nitrogen atom (an incomplete octet sextet N⁺), which is energetically disastrous; C3 attack avoids this contributor completely", "isCorrect": true, "explanation": "Correct! When an electrophile attacks pyridine at C2 or C4, one of the three resonance structures of the sigma complex places a positive charge with only 6 valence electrons directly on the electronegative nitrogen atom. Because this high-energy state severely increases the activation barrier, EAS bypasses C2/C4 and occurs solely at C3 (where the positive charge is delocalized exclusively over the carbon atoms)." },
        { "text": "Because C3 is the only carbon attached to nitrogen", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pyridine undergoes EAS faster than benzene", "isCorrect": false, "explanation": "Incorrect: Pyridine is million-fold slower than benzene." },
        { "text": "Because C2 and C4 carbons do not have p-orbitals", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
