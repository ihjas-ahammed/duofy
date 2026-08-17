# Duofy Reusable Lesson Format: McLafferty Rearrangement and Alpha-Cleavage

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Mass_Spectrometry`  
**Lesson Format Type:** `mclafferty_rearrangement_and_alpha_cleavage`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the core unimolecular gas-phase fragmentation mechanisms of organic radical cations: formulate **$\alpha$-Cleavage** driven by radical/charge sites on heteroatoms (alcohols, ethers, amines, carbonyls) forming resonance-stabilized **Oxocarbenium / Iminium Ions**, formulate the **McLafferty Rearrangement (Fred McLafferty, 1956)** in carbonyl compounds via a **6-Membered Cyclic Transition State with a $\gamma$-Hydrogen**, calculate expected fragment ion masses (e.g. $m/z = 58$ for methyl ketones, $m/z = 74$ for methyl esters), and evaluate the **Stevenson-Audier Rule** for charge retention on the fragment with the lowest ionization energy.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Alpha-Cleavage & McLafferty Rearrangement Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step McLafferty 6-Membered Transition State Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fragmentation Type & Diagnostic Mass Peak Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | McLafferty Rearrangement Required Hydrogen Position Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | 2-Hexanone McLafferty Fragment Ion m/z Identification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Organic Mass Spectrometry Fragmentation Chemistry:
   - **$\alpha$-Cleavage (Radical Site Initiation):**
     - Homolytic cleavage of the $\text{C}-\text{C}$ bond alpha ($\alpha$) to a heteroatom ($\text{O}, \text{N}, \text{S}$):
       $$\text{R}-\text{CH}_2-\overset{+\bullet}{\text{O}}\text{H} \longrightarrow \text{R}^\bullet + \text{H}_2\text{C}=\overset{+}{\text{O}}\text{H} \quad (m/z = 31 \text{ for primary alcohols})$$
       $$\text{R}-\text{CH}_2-\overset{+\bullet}{\text{N}}\text{H}_2 \longrightarrow \text{R}^\bullet + \text{H}_2\text{C}=\overset{+}{\text{N}}\text{H}_2 \quad (m/z = 30 \text{ for primary amines})$$
     - Preferentially expels the **largest alkyl radical** (most stable radical leaves!).
   - **The McLafferty Rearrangement (1956):**
     - **Structural Requirement:** Carbonyl compound (ketone, aldehyde, ester, acid) possessing at least one **hydrogen atom on the $\gamma$-carbon** ($\gamma$-H).
     - **Mechanism:** Passes through a 6-membered cyclic transition state: $\gamma$-H transfers intramolecularly to the radical carbonyl oxygen, followed by $\text{C}_\alpha-\text{C}_\beta$ bond cleavage.
     - **Products:** Neutral alkene (loss of mass, e.g. $\text{C}_2\text{H}_4 = -28$, $\text{C}_3\text{H}_6 = -42$) $+$ **Resonance-stabilized enol radical cation** ($m/z = 58$ for methyl ketones, $m/z = 74$ for methyl esters, $m/z = 44$ for aliphatic aldehydes).
2. **Slide 2 (`ordering`):** Provide 5 steps of the McLafferty rearrangement mechanism: (1) ionization creates a radical cation at the carbonyl oxygen: $[\text{R}-\text{CH}(\gamma\text{H})-\text{CH}_2(\beta)-\text{CH}_2(\alpha)-\text{C}(=\text{O}^{+\bullet})-\text{CH}_3]$, (2) flexible aliphatic carbon chain folds into a 6-membered cyclic chair-like transition state, (3) radical oxygen atom abstracts the hydrogen atom from the $\gamma$-carbon, (4) simultaneous homolytic fission of the carbon-carbon bond between $\text{C}_\alpha$ and $\text{C}_\beta$, (5) expulsion of neutral uncharged alkene ($\text{R}-\text{CH}=\text{CH}_2$) leaves an enol radical cation ($[\text{CH}_2=\text{C}(\text{OH})-\text{CH}_3]^{+\bullet}$ at $m/z = 58$)!
3. **Slide 3 (`matching`):** Pair 4 characteristic mass spec fragments ($m/z = 31$, $m/z = 43$, $m/z = 58$, $m/z = 91$) with their chemical identity ($\text{H}_2\text{C}=\text{OH}^+$ oxocarbenium from primary alcohol, $\text{CH}_3\text{CO}^+$ acylium ion, Acetone enol radical cation from McLafferty of methyl ketone, Tropylium ion $\text{C}_7\text{H}_7^+$ from benzyl compounds).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the McLafferty rearrangement strictly requires a hydrogen atom attached to the gamma carbon (third carbon from carbonyl). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing the McLafferty fragment for 2-hexanone: 2-Hexanone ($\text{CH}_3-\text{CO}-\text{CH}_2-\text{CH}_2-\text{CH}_2-\text{CH}_3$, MW = 100 g/mol) undergoes a McLafferty rearrangement in the mass spectrometer. What is the $m/z$ of the resulting charged fragment ion, and what neutral molecule is expelled? ($m/z = 58$ and neutral propene ($\text{C}_3\text{H}_6$, mass 42); transferring the $\gamma$-H from $\text{C}_5$ to oxygen and cleaving the $\text{C}_\alpha-\text{C}_\beta$ bond between $\text{C}_3$ and $\text{C}_4$ expels propene ($\text{CH}_2=\text{CH}-\text{CH}_3$, 42 Da), leaving the acetone enol ion $[\text{H}_2\text{C}=\text{C}(\text{OH})-\text{CH}_3]^{+\bullet}$ at $m/z = 100 - 42 = 58$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mclafferty_rearrangement_and_alpha_cleavage",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Alpha-Cleavage and the McLafferty Rearrangement**\n• **Alpha-Cleavage (Heteroatom-Driven):**\n$$\\text{R}-\\text{CH}_2-\\overset{+\\bullet}{\\text{O}}\\text{H} \\longrightarrow \\text{R}^\\bullet + \\text{H}_2\\text{C}=\\overset{+}{\\text{O}}\\text{H} \\quad (m/z = 31 \\text{ for primary alcohols})$$\n  *(Preferentially cleaves the largest alkyl group to release the most stable radical!).*\n• **The McLafferty Rearrangement (1956):**\n  - **Structural Requirement:** Carbonyl group with a hydrogen on the **$\\gamma$-carbon** (3 carbons away).\n  - **6-Membered Cyclic Transition State:** $\\gamma$-H transfers to carbonyl oxygen, followed by $\\text{C}_\\alpha - \\text{C}_\\beta$ cleavage.\n  - **Diagnostic Enol Radical Cation Peaks:**\n    - **Methyl Ketones:** $m/z = 58$\n    - **Methyl Esters:** $m/z = 74$\n    - **Aliphatic Aldehydes:** $m/z = 44$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the unimolecular mechanism steps of the McLafferty Rearrangement.",
      "orderItems": [
        "Generate a radical cation at the carbonyl oxygen via 70 eV electron ionization: [R-CH(gamma-H)-CH_2(beta)-CH_2(alpha)-C(=O+•)-R']",
        "Conformational rotation folds the alkyl chain into a 6-membered quasi-ring transition state",
        "The radical oxygen atom abstracts the hydrogen atom from the gamma carbon",
        "Homolytic cleavage breaks the carbon-carbon sigma bond between the alpha and beta carbons",
        "Expel a neutral uncharged alkene molecule while detecting the resonance-stabilized enol radical cation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each diagnostic mass spec fragment peak to its ion structure.",
      "matchPairs": [
        { "left": "Peak at m/z = 58", "right": "Acetone enol radical cation [CH_2=C(OH)-CH_3]+• (McLafferty of methyl ketones)" },
        { "left": "Peak at m/z = 91", "right": "Tropylium cation C_7H_7+ (resonance-stabilized aromatic ion from alkylbenzenes)" },
        { "left": "Peak at m/z = 43", "right": "Acylium cation CH_3-C≡O+ (alpha-cleavage of methyl ketones)" },
        { "left": "Peak at m/z = 31", "right": "Oxocarbenium ion H_2C=OH+ (alpha-cleavage of primary alcohols)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The McLafferty rearrangement in mass spectrometry strictly requires an intramolecular hydrogen atom located at the ___ carbon position.",
      "blankAnswer": "gamma",
      "blankDistractors": ["alpha", "beta", "delta"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "2-Hexanone (CH_3-CO-CH_2-CH_2-CH_2-CH_3, MW = 100) undergoes a McLafferty rearrangement in the mass spectrometer. What is the m/z of the detected fragment ion and the identity of the expelled neutral molecule?",
      "options": [
        { "text": "m/z = 58; the gamma-hydrogen on C5 transfers to oxygen and the C3-C4 bond cleaves, expelling a neutral propene molecule (C3H6, 42 Da) to leave [CH2=C(OH)CH3]+• (100 - 42 = 58)", "isCorrect": true, "explanation": "Correct! In 2-hexanone, C1 is methyl, C2 is carbonyl, C3 is alpha, C4 is beta, and C5 is gamma. Transfer of H from C5 with simultaneous C3-C4 cleavage eliminates propene (MW 42). The detected radical cation is the acetone enol ion at m/z = 58." },
        { "text": "m/z = 43 (neutral loss of pentyl radical)", "isCorrect": false, "explanation": "Incorrect: That is simple alpha-cleavage, not McLafferty rearrangement." },
        { "text": "m/z = 85 (neutral loss of methyl)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "m/z = 18", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
