# Duofy Reusable Lesson Format: Carbon-13 NMR and DEPT Spectral Editing

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Nuclear_Magnetic_Resonance_NMR_Spectroscopy`  
**Lesson Format Type:** `carbon_13_nmr_and_dept_spectral_editing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through $^{13}\text{C}$ chemical shift analysis and multi-pulse polarization transfer: interpret **Broadband $^1\text{H}$-Decoupled $^{13}\text{C}$-NMR Spectra** ($0-220\text{ ppm}$), map characteristic functional group regions (carbonyls $\text{C}=\text{O}$ $160-220\text{ ppm}$, aromatics/alkenes $100-160\text{ ppm}$, $\text{C}-\text{O}/\text{C}-\text{N}$ $50-85\text{ ppm}$, aliphatics $0-50\text{ ppm}$), and master **DEPT Spectral Editing (Distortionless Enhancement by Polarization Transfer)**: DEPT-45 ($\text{CH}_3, \text{CH}_2, \text{CH}$ all UP), DEPT-90 (ONLY $\text{CH}$ UP), and **DEPT-135 ($\text{CH}_3$ and $\text{CH}$ UP, $\text{CH}_2$ DOWN, Quaternary $\text{C}_{\text{quat}}$ ABSENT)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Carbon-13 Chemical Shifts & DEPT Editing Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Carbon-Type Classification Workflow Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | DEPT-135 Phase Signal & Carbon Environment Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Inverted Negative Peak Carbon Subunit in DEPT-135 Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Ketone/Ester Carbonyl Quaternary Carbon DEPT-135 Absence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State $^{13}\text{C}$-NMR & DEPT Spectral Editing:
   - **$^{13}\text{C}$ Chemical Shift Map ($0 - 220\text{ ppm}$):**
     - **Carbonyls ($\text{C}=\text{O}$):** Aldehydes & Ketones ($190 - 220\text{ ppm}$), Esters & Carboxylic Acids ($160 - 185\text{ ppm}$).
     - **$s p^2$ Carbons:** Aromatic and Alkene carbons ($100 - 160\text{ ppm}$).
     - **Heteroatom-Bonded $s p^3$ Carbons ($\text{C}-\text{O}, \text{C}-\text{N}, \text{C}-\text{X}$):** $50 - 85\text{ ppm}$.
     - **Aliphatic $s p^3$ Carbons ($\text{C}-\text{C}$):** $0 - 50\text{ ppm}$.
   - **DEPT Spectral Editing Rules:**
     - **Standard $^{13}\text{C}$ (Broadband Decoupled):** Shows ALL carbons ($\text{CH}_3, \text{CH}_2, \text{CH}, \text{C}_{\text{quat}}$).
     - **DEPT-45:** Shows all protonated carbons ($\text{CH}_3, \text{CH}_2, \text{CH}$ all point **UP (+)**).
     - **DEPT-90:** Shows **ONLY methine ($\text{CH}$)** carbons (points **UP (+)**).
     - **DEPT-135:**
       - $\text{CH}_3$ (Methyl) $\longrightarrow$ **UP (+)**
       - $\text{CH}_2$ (Methylene) $\longrightarrow$ **DOWN / INVERTED (-)**
       - $\text{CH}$ (Methine) $\longrightarrow$ **UP (+)**
       - $\text{C}_{\text{quat}}$ (Quaternary Carbon) $\longrightarrow$ **COMPLETELY ABSENT (No signal!)**
2. **Slide 2 (`ordering`):** Provide 5 steps classifying all carbon types in an unknown compound using $^{13}\text{C}$ and DEPT: (1) count total peak count in broadband decoupled $^{13}\text{C}$ spectrum to find total unique carbons, (2) compare $^{13}\text{C}$ with DEPT-135; identify peaks present in $^{13}\text{C}$ but absent in DEPT-135 as quaternary carbons ($\text{C}_{\text{quat}}$, e.g. $\text{C}=\text{O}$ or $t$-butyl quaternary carbon), (3) inspect inverted negative peaks in DEPT-135; identify all as methylene carbons ($\text{CH}_2$), (4) cross-check positive peaks in DEPT-135 against DEPT-90; peaks present in DEPT-90 are methine carbons ($\text{CH}$), (5) remaining positive peaks in DEPT-135 absent in DEPT-90 are methyl carbons ($\text{CH}_3$)!
3. **Slide 3 (`matching`):** Pair 4 carbon types ($\text{CH}_3$, $\text{CH}_2$, $\text{CH}$, $\text{C}_{\text{quat}}$) with their DEPT-135 signal behaviors (Positive UP peak (absent in DEPT-90), Negative INVERTED DOWN peak, Positive UP peak (present in DEPT-90), Zero signal / absent).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a DEPT-135 spectrum, methylene groups (CH2) appear as inverted negative peaks pointing downwards. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on quaternary carbon identification in DEPT: A compound exhibits 5 peaks in its $^{13}\text{C}$ spectrum at $\delta = 205, 135, 128, 45,$ and $30\text{ ppm}$. In the DEPT-135 spectrum, peaks appear at $\delta = 128\text{ (UP)}$, $45\text{ (DOWN)}$, and $30\text{ (UP)}$. The peaks at $\delta = 205$ and $135\text{ ppm}$ are COMPLETELY MISSING in DEPT-135. What is the structural classification of these two missing carbons? (They are **Quaternary Carbons ($\text{C}_{\text{quat}}$)** with zero directly attached hydrogens, representing a ketone carbonyl ($\text{C}=\text{O}$ at $205\text{ ppm}$) and a fully substituted aromatic/alkene carbon at $135\text{ ppm}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "carbon_13_nmr_and_dept_spectral_editing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Carbon-13 NMR and DEPT Spectral Editing**\n• **$^{13}\\text{C}$ Chemical Shift Map ($0 - 220\\text{ ppm}$):**\n  - **Carbonyls ($\\text{C}=\\text{O}$):** $160 - 220\\text{ ppm}$ (Ketones $200-220$, Esters $160-185$).\n  - **Aromatics & Alkenes:** $100 - 160\\text{ ppm}$.\n  - **$\\text{C}-\\text{O} / \\text{C}-\\text{N}$:** $50 - 85\\text{ ppm}$.\n  - **Aliphatics ($\\text{C}-\\text{C}$):** $0 - 50\\text{ ppm}$.\n• **DEPT-135 Spectral Editing Matrix:**\n  - **$\\text{CH}_3$ (Methyl):** Positive signal (Points **UP (+)**, absent in DEPT-90).\n  - **$\\text{CH}_2$ (Methylene):** Negative signal (Points **DOWN / INVERTED (-)**).\n  - **$\\text{CH}$ (Methine):** Positive signal (Points **UP (+)**, present in DEPT-90).\n  - **$\\text{C}_{\\text{quat}}$ (Quaternary):** **ABSENT (Zero signal)** in all DEPT experiments!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the systematic DEPT spectral interpretation steps to classify all carbon types.",
      "orderItems": [
        "Count the total number of resonances in the broadband decoupled 13C spectrum to establish unique carbon count",
        "Identify quaternary carbons (C_quat) as all peaks present in 13C but COMPLETELY ABSENT in DEPT-135",
        "Assign all inverted negative downward-pointing peaks in DEPT-135 as methylene carbons (-CH_2-)",
        "Check DEPT-90 spectrum to uniquely confirm all methine carbons (-CH-)",
        "Assign remaining positive upward-pointing peaks in DEPT-135 (absent in DEPT-90) as methyl carbons (-CH_3)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each carbon group to its exact signal phase in a DEPT-135 spectrum.",
      "matchPairs": [
        { "left": "Methylene Carbon (-CH_2-)", "right": "Inverted NEGATIVE peak pointing DOWN (-)" },
        { "left": "Methyl Carbon (-CH_3)", "right": "Positive peak pointing UP (+) [absent in DEPT-90]" },
        { "left": "Methine Carbon (-CH-)", "right": "Positive peak pointing UP (+) [present in DEPT-90]" },
        { "left": "Quaternary Carbon (C_quat)", "right": "ABSENT (produces zero signal in all DEPT experiments)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a DEPT-135 NMR spectrum, methylene carbon subunits (-CH2-) uniquely appear as inverted ___ peaks pointing below the baseline.",
      "blankAnswer": "negative",
      "blankDistractors": ["positive", "doublet", "triplet"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A compound displays a peak at delta = 210 ppm in its 13C spectrum, but this peak is COMPLETELY MISSING in DEPT-45, DEPT-90, and DEPT-135. What is the identity of this carbon?",
      "options": [
        { "text": "A QUATERNARY CARBONYL CARBON (e.g. ketone C=O); because it has ZERO directly attached protons, it cannot undergo polarization transfer from 1H, making it invisible in all DEPT spectra", "isCorrect": true, "explanation": "Correct! DEPT relies on polarization transfer from protons directly bonded to 13C (1J_CH coupling). Quaternary carbons (like ketone C=O, ester C=O, or tertiary alkyl carbons with no attached H) have no direct C-H bonds, so polarization transfer cannot occur and they produce zero signal in all DEPT experiments." },
        { "text": "A methyl group (-CH3)", "isCorrect": false, "explanation": "Incorrect: Methyl appears as an upright peak in DEPT-135." },
        { "text": "A methylene group (-CH2-)", "isCorrect": false, "explanation": "Incorrect: Methylene appears as an inverted peak." },
        { "text": "The NMR solvent (CDCl3)", "isCorrect": false, "explanation": "Incorrect: CDCl3 appears at 77.0 ppm as a 1:1:1 triplet." }
      ]
    }
  ]
}
```
