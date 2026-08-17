# Duofy Reusable Lesson Format: Functional Group Identification and FTIR

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Infrared_IR_and_UV_Vis_Spectroscopy`  
**Lesson Format Type:** `functional_group_identification_and_ftir`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through organic functional group diagnosis from Infrared (IR) spectra and the operational principles of Fourier Transform Infrared (FTIR) instrumentation: diagnose diagnostic absorption bands ($-\text{OH}$ broad $3200-3600\text{ cm}^{-1}$, carboxylic acid $-\text{COOH}$ ultra-broad $2500-3300\text{ cm}^{-1}$, primary vs secondary amine $-\text{NH}_2 / -\text{NH}$, alkyne $s p\ \text{C}-\text{H}$ $3300\text{ cm}^{-1}$ sharp vs alkene $s p^2\ \text{C}-\text{H} > 3000\text{ cm}^{-1}$ vs alkane $s p^3\ \text{C}-\text{H} < 3000\text{ cm}^{-1}$), analyze carbonyl ($\text{C}=\text{O}$) frequency modulations (ester $1735\text{ cm}^{-1}$, aldehyde/ketone $1715\text{ cm}^{-1}$, conjugated enone $1685\text{ cm}^{-1}$, amide $1660\text{ cm}^{-1}$), and evaluate **FTIR Interferometer Mechanics (Michelson Interferometer, Interferogram, Fellgett / Jacquinot advantages)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | IR Diagnostic Map & Carbonyl Shift Theory Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step FTIR Optical Pathway from Source to Spectrum Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Carbonyl Functional Group & Characteristic IR Peak Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Alkane sp3 C-H Stretch Benchmark Wavenumber Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Carbonyl Conjugation and Resonance Frequency Lowering Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Systematic IR Interpretation & Carbonyl Electronics:
   - **Diagnostic Zone Boundaries:**
     - **Broad Alcoholic $-\text{OH}$:** $3200 - 3600\text{ cm}^{-1}$ (U-shaped, hydrogen bonded).
     - **Carboxylic Acid $-\text{COOH}$:** Extremely broad $2500 - 3300\text{ cm}^{-1}$ (engulfs $s p^3\ \text{C}-\text{H}$ baseline).
     - **$s p\ \text{C}-\text{H}$ ($3300\text{ cm}^{-1}$, sharp)** vs **$s p^2\ \text{C}-\text{H}$ ($3010-3100\text{ cm}^{-1}$)** vs **$s p^3\ \text{C}-\text{H}$ ($2850-2960\text{ cm}^{-1}$)**.
   - **The Carbonyl Hierarchy ($\text{C}=\text{O}$ Stretches):**
     $$\text{Acid Chloride } (1800\text{ cm}^{-1}) > \text{Ester } (1735\text{ cm}^{-1}) > \text{Aldehyde/Ketone } (1715\text{ cm}^{-1}) > \text{Amide } (1660\text{ cm}^{-1})$$
     - **Conjugation Effect:** Conjugating a $\text{C}=\text{O}$ with an adjacent alkene or aromatic ring ($\alpha,\beta$-unsaturated) lowers the frequency by $\sim 20 - 40\text{ cm}^{-1}$ due to resonance delocalization weakening the double bond order ($\text{C}=\text{O} \leftrightarrow \text{C}^+-\text{O}^-$).
   - **FTIR Instrumentation:** Michelson interferometer records time-domain *interferogram* with moving mirror, transformed via Fast Fourier Transform ($\text{FFT}$) to frequency spectrum (Fellgett multiplex advantage + Jacquinot throughput advantage).
2. **Slide 2 (`ordering`):** Provide 5 steps of the FTIR optical path: (1) broad infrared beam emitted by ceramic Globar source, (2) beam enters Michelson interferometer and is split 50/50 by beamsplitter into fixed and moving mirror paths, (3) recombined beam creates an optical interference pattern (interferogram) with time-varying path difference $\delta$, (4) interferogram passes through the chemical sample, absorbing specific resonant vibrational frequencies, (5) detector records transmitted intensity vs mirror position, and computer performs Fast Fourier Transform (FFT) to generate the absorbance spectrum!
3. **Slide 3 (`matching`):** Pair 4 carbonyl compounds (Acid Chloride, Aliphatic Ester, Aliphatic Ketone, Primary Amide) with their characteristic stretching wavenumbers ($1800\text{ cm}^{-1}$, $1735\text{ cm}^{-1}$, $1715\text{ cm}^{-1}$, $1660\text{ cm}^{-1}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the boundary between saturated $s p^3\ \text{C}-\text{H}$ stretches and unsaturated $s p^2\ \text{C}-\text{H}$ stretches lies at 3000 cm^-1. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical cause of carbonyl frequency shifts: Why does cyclohex-2-enone ($\alpha,\beta$-unsaturated ketone, $\tilde{\nu} = 1685\text{ cm}^{-1}$) absorb at a significantly LOWER wavenumber than cyclohexanone (saturated ketone, $\tilde{\nu} = 1715\text{ cm}^{-1}$)? (Because $\pi$-conjugation allows resonance delocalization ($\text{C}=\text{C}-\text{C}=\text{O} \leftrightarrow \text{C}^+-\text{C}=\text{C}-\text{O}^-$), giving the $\text{C}=\text{O}$ bond partial single-bond character, which lowers its force constant $k$ and reduces the vibrational stretching frequency).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "functional_group_identification_and_ftir",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Functional Group Identification and FTIR Spectroscopy**\n• **Hydrogen-Stretching Zone ($4000 - 2500\\text{ cm}^{-1}$):**\n  - **Alcohol $-\\text{OH}$:** Broad U-shaped band at $3200 - 3600\\text{ cm}^{-1}$.\n  - **Carboxylic Acid $-\\text{COOH}$:** Ultra-broad engulfing smear at $2500 - 3300\\text{ cm}^{-1}$.\n  - **$\\text{C}-\\text{H}$ Hybridization:** $sp$ ($3300\\text{ cm}^{-1}$ sharp) $> sp^2$ ($> 3000\\text{ cm}^{-1}$) $> sp^3$ ($< 3000\\text{ cm}^{-1}$).\n• **Carbonyl Hierarchy ($\\text{C}=\\text{O}$ at $1800 - 1650\\text{ cm}^{-1}$):**\n$$\n\\text{Acid Chloride } (1800) > \\text{Ester } (1735) > \\text{Ketone } (1715) > \\text{Amide } (1660\\text{ cm}^{-1})\n$$\n  - **Conjugation:** Drops $\\text{C}=\\text{O}$ frequency by $20 - 40\\text{ cm}^{-1}$ via resonance single-bond character.\n• **FTIR Interferometry:** Replaces dispersing prisms with a Michelson interferometer and Fast Fourier Transform (FFT)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the optical beam path steps in a Fourier Transform Infrared (FTIR) spectrometer.",
      "orderItems": [
        "Emit broadband continuous infrared radiation from an electrically heated ceramic Globar source",
        "Split the infrared beam into two perpendicular paths using a KBr beamsplitter (fixed mirror vs moving mirror)",
        "Recombine reflected beams to generate an optical time-domain interference wave (Interferogram)",
        "Pass the modulated interferogram beam through the chemical sample chamber where vibrational absorption occurs",
        "Record raw signal at DTGS detector and execute Fast Fourier Transform (FFT) algorithm to produce the transmittance spectrum"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each carbonyl functional group to its characteristic IR absorption wavenumber.",
      "matchPairs": [
        { "left": "Acid Chloride (Strong Inductive Withdrawal)", "right": "~1800 cm^-1 (highest frequency carbonyl due to electronegative chlorine)" },
        { "left": "Aliphatic Ester (Ester Carbonyl)", "right": "~1735 - 1750 cm^-1" },
        { "left": "Saturated Ketone / Aldehyde", "right": "~1715 cm^-1 (standard benchmark carbonyl)" },
        { "left": "Primary Amide (Strong Nitrogen Resonance)", "right": "~1650 - 1680 cm^-1 (lowest frequency carbonyl + twin N-H stretch at 3300)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an IR spectrum, absorption peaks appearing strictly to the right of ___ cm^-1 correspond to saturated sp3 C-H stretches.",
      "blankAnswer": "3000",
      "blankDistractors": ["1700", "2200", "4000"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does an alpha,beta-unsaturated ketone (like cyclohex-2-enone at 1685 cm^-1) absorb at a LOWER wavenumber than a saturated ketone (at 1715 cm^-1)?",
      "options": [
        { "text": "Resonance delocalization between the C=C alkene and C=O carbonyl (C=C-C=O <-> C⁺-C=C-O⁻) weakens the C=O double bond, giving it partial single-bond character which lowers its force constant k and drops the vibrational frequency", "isCorrect": true, "explanation": "Correct! Conjugation allows pi-electron overlap across four atoms. The resonance contributor with a single C-O bond and formal charges reduces the effective double-bond character (force constant k drops from ~1000 N/m), shifting the absorption ~30 cm^-1 to lower energy (red shift)." },
        { "text": "Because the molecule is heavier", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because oxygen leaves the molecule", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the temperature drops", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
