# Duofy Reusable Lesson Format: Chemical Shift, Shielding, and Magnetic Anisotropy

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Nuclear_Magnetic_Resonance_NMR_Spectroscopy`  
**Lesson Format Type:** `chemical_shift_shielding_and_magnetic_anisotropy`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the electronic foundations of nuclear resonance: formulate the **Larmor Precession Condition ($\omega_0 = \gamma B_{\text{local}} = \gamma B_0 (1 - \sigma)$)**, define the **Parts Per Million Chemical Shift Scale ($\delta \equiv \frac{\nu_{\text{sample}} - \nu_{\text{TMS}}}{\nu_{\text{spectrometer}}}\times 10^6$)**, distinguish between **Shielding (Upfield, small $\delta$)** and **Deshielding (Downfield, large $\delta$)**, evaluate **Diamagnetic Anisotropy** in $\pi$-systems (aromatic ring current deshielding $\delta \approx 7-8\text{ ppm}$, aldehyde $\delta \approx 9.5-10\text{ ppm}$, terminal alkyne anomalous shielding $\delta \approx 2-3\text{ ppm}$), and map characteristic $^1\text{H}$-NMR chemical shift regions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nuclear Shielding & Chemical Shift Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proton Chemical Shift Downfield Assignment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Proton Functional Group & Typical Chemical Shift Range Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Universal NMR Zero Reference Standard Compound Abbreviation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Terminal Alkyne Magnetic Anisotropy vs Alkene Shielding Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Nuclear Magnetic Shielding & Chemical Shifts:
   - **Local Effective Magnetic Field:**
     $$B_{\text{local}} = B_0 (1 - \sigma) \implies \nu = \frac{\gamma B_0 (1 - \sigma)}{2\pi}$$
     where $\sigma$ is the diamagnetic shielding constant.
   - **The Field-Independent Chemical Shift ($\delta$ in ppm):**
     $$\delta \equiv \frac{\nu_{\text{sample}} - \nu_{\text{TMS}}}{\nu_{\text{spectrometer}}} \times 10^6 \qquad (\text{Tetramethylsilane TMS } = 0.00\text{ ppm})$$
   - **Shielding vs Deshielding:**
     - **Shielded (Upfield $\delta \to 0$):** High local electron density opposes $B_0$.
     - **Deshielded (Downfield $\delta \to 12$):** Electronegative atoms pull electrons away, exposing nucleus to full $B_0$.
   - **Magnetic Anisotropy ($\pi$-Electron Systems):**
     - **Benzene Ring Current:** Induced circulation of $6\pi$ electrons creates an opposing internal field and a reinforcing external field, strongly **deshielding** aromatic protons ($\delta = 7.0 - 8.5\text{ ppm}$).
     - **Aldehyde $\text{C}(=\text{O})\mathbf{H}$:** $\delta = 9.0 - 10.0\text{ ppm}$ (anisotropy $+$ strong inductive withdrawal).
     - **Carboxylic Acid $-\text{COO}\mathbf{H}$:** $\delta = 10.5 - 13.0\text{ ppm}$ (extreme hydrogen bonding).
2. **Slide 2 (`ordering`):** Provide 5 steps ordering protons from most shielded (lowest $\delta$, furthest upfield) to most deshielded (highest $\delta$, furthest downfield): (1) Tetramethylsilane (TMS reference, $\delta = 0.0\text{ ppm}$), (2) Aliphatic methyl proton in ethane ($\text{CH}_3-\text{CH}_3$, $\delta \approx 0.9\text{ ppm}$), (3) Methoxy ether proton ($\text{CH}_3-\text{O}-\text{R}$, inductive oxygen pull, $\delta \approx 3.3\text{ ppm}$), (4) Benzene ring aromatic proton ($\text{C}_6\text{H}_6$, ring current anisotropy, $\delta \approx 7.27\text{ ppm}$), (5) Carboxylic acid proton in acetic acid ($\text{CH}_3\text{COOH}$, extreme deshielding, $\delta \approx 11.5\text{ ppm}$)!
3. **Slide 3 (`matching`):** Pair 4 proton types (Aliphatic methyl $\text{R}-\text{CH}_3$, Ester/Ether methoxy $-\text{O}-\text{CH}_3$, Aromatic ring $\text{Ar}-\mathbf{H}$, Aldehydic $-\text{CHO}$) with their chemical shift ranges ($0.8 - 1.2\text{ ppm}$, $3.3 - 4.0\text{ ppm}$, $6.5 - 8.5\text{ ppm}$, $9.0 - 10.0\text{ ppm}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the standard universal reference compound assigned a chemical shift of delta = 0.0 ppm in 1H and 13C NMR is tetramethylsilane (TMS). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the anomalous chemical shift of terminal alkynes: Why does an acetylenic proton in a terminal alkyne ($\text{R}-\text{C}\equiv\text{C}-\mathbf{H}$, $\delta \approx 2.0-2.5\text{ ppm}$) resonate at a significantly MORE SHIELDED (lower ppm) position than an alkene proton ($\text{R}_2\text{C}=\text{CH}_2$, $\delta \approx 4.5-6.5\text{ ppm}$), despite $s p$-carbon being more electronegative than $s p^2$-carbon? (Because of **diamagnetic anisotropy**: when the linear $\text{C}\equiv\text{C}$ axis aligns with $B_0$, the cylindrical cloud of $4\pi$ electrons circulates around the bond axis, inducing a localized magnetic field that directly **opposes** $B_0$ along the cylinder axis where the terminal proton sits, strongly shielding it).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "chemical_shift_shielding_and_magnetic_anisotropy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Chemical Shift, Shielding, and Magnetic Anisotropy**\n• **Resonance Condition:** $\\nu = \\frac{\\gamma B_0 (1 - \\sigma)}{2\\pi}$ (where $\\sigma$ is local electron shielding).\n• **The Chemical Shift Scale (ppm):**\n$$\n\\delta \\equiv \\frac{\\nu_{\\text{sample}} - \\nu_{\\text{TMS}}}{\\nu_{\\text{spectrometer}}} \\times 10^6 \\qquad (\\text{TMS reference } \\delta = 0.00\\text{ ppm})\n$$\n• **Shielding vs Deshielding:**\n  - **High Electron Density $\\implies$ Shielded (Upfield, low $\\delta$).**\n  - **Electronegative Induction $\\implies$ Deshielded (Downfield, high $\\delta$).**\n• **Magnetic Anisotropy in $\\pi$-Systems:**\n  - **Benzene Ring Current:** $6\\pi$ circulation strongly **deshields** aromatic protons ($\\delta \\approx 7.0 - 8.5\\text{ ppm}$).\n  - **Aldehyde $\\text{C}(=\\text{O})\\mathbf{H}$:** Deshielded to $\\delta \\approx 9.0 - 10.0\\text{ ppm}$.\n  - **Carboxylic Acid $-\\text{COO}\\mathbf{H}$:** $\\delta \\approx 10.5 - 13.0\\text{ ppm}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order these protons from most shielded (lowest ppm, furthest upfield) to most deshielded (highest ppm, furthest downfield).",
      "orderItems": [
        "Tetramethylsilane (TMS calibration standard with delta = 0.00 ppm)",
        "Aliphatic methyl proton in ethane CH_3-CH_3 (delta ≈ 0.9 ppm)",
        "Methoxy ether proton in CH_3-O-R (delta ≈ 3.3 ppm, inductive withdrawal)",
        "Benzene aromatic ring proton in C_6H_6 (delta ≈ 7.27 ppm, ring current anisotropy)",
        "Carboxylic acid proton in acetic acid CH_3-COOH (delta ≈ 11.5 ppm, extreme hydrogen bonding)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each proton environment to its characteristic 1H-NMR chemical shift range.",
      "matchPairs": [
        { "left": "Aliphatic Alkyl Protons (-CH_3, -CH_2-)", "right": "0.8 - 1.5 ppm (shielded sp3 carbon region)" },
        { "left": "Heteroatom-Adjacent Protons (-O-CH_3, -N-CH_3)", "right": "3.0 - 4.5 ppm (deshielded by electronegative O or N)" },
        { "left": "Aromatic Ring Protons (Ar-H)", "right": "6.5 - 8.5 ppm (deshielded by diamagnetic ring current)" },
        { "left": "Aldehyde Proton (-CHO)", "right": "9.0 - 10.0 ppm (anisotropy of carbonyl + strong inductive withdrawal)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The universally accepted internal chemical shift reference compound defined as 0.00 ppm in 1H-NMR is tetramethylsilane, abbreviated as ___.",
      "blankAnswer": "tms",
      "blankDistractors": ["dmso", "cdcl3", "hplc"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does an acetylenic proton in a terminal alkyne (R-C≡C-H at delta ≈ 2.0-2.5 ppm) resonate at a significantly lower chemical shift (more shielded) than an alkene proton (R2C=CH2 at delta ≈ 4.5-6.5 ppm)?",
      "options": [
        { "text": "Magnetic Anisotropy of the triple bond: The cylindrical cloud of 4 pi electrons circulates around the C≡C axis when aligned with B_0, generating an induced magnetic field that directly OPPOSES the external field along the bond axis where the acetylenic proton sits, strongly shielding it", "isCorrect": true, "explanation": "Correct! Unlike alkenes (where the proton lies in the deshielding zone of the planar pi system), the terminal alkyne proton lies directly along the cylinder axis of the triple bond. The circulating pi electrons create an induced magnetic field pointing against B_0 at the proton's position, providing strong diamagnetic shielding." },
        { "text": "Because alkynes are less electronegative than alkanes", "isCorrect": false, "explanation": "Incorrect: sp-hybridized carbons are MORE electronegative." },
        { "text": "Because alkyne protons are replaced by nitrogen", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because triple bonds do not possess electrons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
