# Duofy Reusable Lesson Format: X-Ray Diffraction (Bragg's Law & Scherrer Crystallite Size)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Nanomaterials_and_Characterization / SEM_TEM_XRD_Characterization`  
**Lesson Format Type:** `braggs_law_and_scherrer_crystallite_size_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the crystallographic physics of X-ray powder diffraction (XRD), constructive wave interference across periodic lattice planes, **Bragg's Law ($n\lambda = 2d_{hkl}\sin\theta$)**, calculation of cubic interplanar spacing ($d_{hkl} = \frac{a}{\sqrt{h^2+k^2+l^2}}$) and lattice parameter $a$, line broadening mechanisms in nanomaterials, and Paul Scherrer's 1918 **Scherrer Equation ($\tau = \frac{K\lambda}{\beta \cos\theta}$)** for nanoscale crystallite domain size (B. D. Cullity, S. R. Stock *Elements of X-Ray Diffraction* 3rd ed. Chapters 3 & 5; William D. Callister Jr. *Materials Science and Engineering* 10th ed. Chapter 3; Paul Scherrer 1918): formulate the **Bragg's Law & Scherrer Nanocrystallite Master Formulations**:
$$\mathbf{n \lambda = 2 d_{hkl} \sin\theta \Longleftrightarrow \mathbf{d_{hkl} = \frac{\lambda}{2 \sin\theta} \quad (n = 1 \text{ first-order})}}$$
where for a cubic crystal with lattice parameter $a$ and Miller indices $(hkl)$:
$$\mathbf{a = d_{hkl} \sqrt{h^2 + k^2 + l^2} = \frac{\lambda \sqrt{h^2 + k^2 + l^2}}{2 \sin\theta} \quad [\text{nm} \text{ or } \text{Å}]}$$
derive the **Scherrer Peak Broadening Crystallite Size Equation ($\tau$)**:
$$\mathbf{\tau = \frac{K \cdot \lambda}{\beta_{\text{sample}} \cdot \cos\theta} \quad [\text{nanometers}]}$$
where:
1. **$\tau$:** Volume-weighted mean crystallite domain diameter ($\text{nm}$);
2. **$K$:** Dimensionless crystallite shape factor ($K \approx 0.90 - 0.94$, standard $K = 0.94$ for spherical domains);
3. **$\lambda$:** X-ray source wavelength ($\lambda = 0.15418\text{ nm} = 1.5418\text{ Å}$ for $\text{Cu } K_\alpha$);
4. **$\theta$:** Bragg angle (half of the detector angle $2\theta$);
5. **$\beta_{\text{sample}}$:** Pure sample Full Width at Half Maximum ($\text{FWHM}$) in radians, corrected for instrumental broadening:
   $$\mathbf{\beta_{\text{sample}} = \sqrt{\beta_{\text{measured}}^2 - \beta_{\text{instrumental}}^2} \quad [\text{radians}]}$$
(proving that diffraction peak broadening scales inversely with nanocrystallite domain size $\tau \propto 1/\beta$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bragg's Law ($n\lambda = 2d\sin\theta$), Cubic $a = d\sqrt{h^2+k^2+l^2}$ & Scherrer Equation ($\tau = \frac{K\lambda}{\beta\cos\theta}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Interplanar Spacing, Lattice Parameter, and Nanocrystallite Size from XRD Peaks Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | X-Ray Diffraction Construct / Peak Parameter & Technical Crystallographic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In X-Ray Diffraction Analysis, the Scherrer Equation Quantifies How Nanoscale Crystallite Size Is Inversely Proportional to the Diffraction Peak Full-Width at Half-___ $\beta$ (Maximum / FWHM) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Nanomaterial Characterization Problem: Computing Interplanar Spacing d111 and Crystallite Size for Gold Nanoparticles Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State XRD & Scherrer Crystallographic Mechanics (Cullity 2001; Callister 2020):
   - **Crystallographic Formulations:**
     $$\mathbf{n\lambda = 2 d \sin\theta \quad \Big| \quad d_{hkl} = \frac{a}{\sqrt{h^2+k^2+l^2}} \quad \Big| \quad \tau = \frac{K\lambda}{\beta_{\text{rad}} \cos\theta} \quad \Big| \quad \beta = \beta_{\text{deg}} \times \frac{\pi}{180}}$$
   - **FCC vs BCC Systematic Extinction Rules:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Crystal Lattice} & \textbf{Allowed Reflection Rule } (hkl) & \textbf{First Four Allowed Peaks} \\
     \hline
     \mathbf{\text{FCC (Face-Centered Cubic)}} & \mathbf{h, k, l \text{ all even OR all odd}} & \mathbf{(111), (200), (220), (311)} \\
     \mathbf{\text{BCC (Body-Centered Cubic)}} & \mathbf{h + k + l = \text{even integer}} & \mathbf{(110), (200), (211), (220)} \\
     \hline
     \end{array}$$
   - **The Peak Broadening Invariant:** Perfect macroscopic single crystals produce razor-sharp peaks; when crystal domain size drops below $100\text{ nm}$, incomplete destructive interference widens the diffraction peak into a bell curve whose **FWHM width ($\beta$) is inversely proportional to nanocrystal diameter ($\tau$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of XRD peak analysis: (1) record XRD pattern and locate $2\theta$ diffraction peak position and FWHM breadth in degrees, (2) convert $2\theta$ to Bragg angle $\theta$ (in degrees and radians) and convert FWHM breadth to radians: $\beta = \beta_{\text{deg}} \times (\pi / 180)$, (3) calculate interplanar spacing using Bragg's law: $d_{hkl} = \lambda / (2\sin\theta)$, (4) calculate cubic lattice parameter: $a = d_{hkl} \sqrt{h^2 + k^2 + l^2}$, (5) evaluate average nanocrystallite domain diameter using the Scherrer equation: $\tau = (K \lambda) / (\beta \cos\theta)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bragg's Law, Scherrer Equation, Full Width at Half Maximum FWHM, Cu K-alpha Source) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Maximum (or FWHM). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $d_{111}$ and crystallite size $\tau$ for Gold (Au) nanoparticles: An XRD scan of gold nanoparticles using $\text{Cu } K_\alpha$ radiation ($\lambda = 0.15418\text{ nm}$) exhibits a prominent $(111)$ peak at $2\theta = 38.20^\circ$ ($\theta = 19.10^\circ \implies \sin(19.10^\circ) = \mathbf{0.32722}, \ \cos(19.10^\circ) = \mathbf{0.94495}$). The measured peak FWHM is $\beta = 0.600^\circ = 0.600 \times \frac{\pi}{180} = \mathbf{0.010472\text{ radians}}$. Shape factor is $K = 0.94$.
   - Interplanar spacing $d_{111}$:
     $d_{111} = \frac{\lambda}{2 \sin\theta} = \frac{0.15418\text{ nm}}{2 \times 0.32722} = \frac{0.15418}{0.65444} = \mathbf{0.23559\text{ nm} \approx 0.236\text{ nm} = 2.36\text{ Å}}$;
   - Nanocrystallite size $\tau$:
     $\tau = \frac{K \lambda}{\beta \cos\theta} = \frac{0.94 \times 0.15418\text{ nm}}{0.010472\text{ rad} \times 0.94495} = \frac{0.144929}{0.0098955} = \mathbf{14.646\text{ nm} \approx 14.6\text{ nm}}$;
   - What are the interplanar spacing $d_{111}$ and mean crystallite size $\tau$? ($d_{111} = \mathbf{0.236\text{ nm}}$ and $\tau = \mathbf{14.6\text{ nm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "braggs_law_and_scherrer_crystallite_size_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: X-Ray Diffraction \\& Scherrer Broadening (B. D. Cullity)**\n• **Bragg's Law of Diffraction Master Formulation:**\n$$\n\\mathbf{n \\lambda = 2 d_{hkl} \\sin\\theta \\Longleftrightarrow d_{hkl} = \\frac{\\lambda}{2 \\sin\\theta} \\quad (\\text{for } n = 1)}\n$$\n  - **$\\lambda = 0.15418\\text{ nm}$:** $\\text{Cu } K_\\alpha$ X-ray wavelength;\n  - **$\\theta = \\frac{2\\theta}{2}$:** Bragg diffraction angle;\n  - **$d_{hkl} = \\frac{a}{\\sqrt{h^2 + k^2 + l^2}}$:** Cubic interplanar atomic spacing;\n• **Scherrer Equation for Nanocrystallite Domain Size ($\\tau$):**\n$$\n\\mathbf{\\tau = \\frac{K \\cdot \\lambda}{\\beta \\cdot \\cos\\theta} \\quad [\\text{nanometers}]}\n$$\n  - **$K \\approx 0.94$:** Dimensionless crystallite shape factor;\n  - **$\\beta = \\beta_{\\text{deg}} \\times \\frac{\\pi}{180}$:** Peak Full Width at Half Maximum (FWHM in radians);\n• **The Peak Broadening Invariant:** In nanostructured materials ($\\tau < 100\\text{ nm}$), diffraction peaks broaden into bell curves whose **width $\\beta$ is inversely proportional to nanocrystallite diameter $\\tau$** due to incomplete destructive interference!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine interplanar spacing, cubic lattice parameter, and crystallite domain size from an XRD diffraction peak.",
      "orderItems": [
        "Extract the diffraction peak position 2\u03b8 and Full Width at Half Maximum \u03b2_deg from the experimental XRD diffractogram",
        "Calculate the Bragg angle \u03b8 = (2\u03b8) / 2 in degrees and convert peak broadening to radians: \u03b2_rad = \u03b2_deg * (\u03c0 / 180)",
        "Apply Bragg's Law to calculate the interplanar atomic d-spacing: d_hkl = \u03bb / (2 * sin\u03b8)",
        "Calculate the cubic lattice constant: a = d_hkl * \u221a(h^2 + k^2 + l^2) for the indexed Miller reflection",
        "Apply the Scherrer Equation to compute the mean volume-weighted nanocrystallite size: \u03c4 = (K * \u03bb) / (\u03b2_rad * cos\u03b8)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each XRD Crystallographic Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bragg's Law", "right": "\u03bb = 2*d*sin\u03b8, constructive interference condition where scattered X-ray path difference equals integer wavelengths" },
        { "left": "Scherrer Equation", "right": "\u03c4 = (K*\u03bb)/(\u03b2*cos\u03b8), analytical formula linking peak diffraction broadening to nanoscale crystallite grain diameter" },
        { "left": "FWHM Broadening (\u03b2)", "right": "Full width of diffraction peak at half maximum intensity measuring finite crystal size and microstrain" },
        { "left": "Cu K\u03b1 Radiation (\u03bb = 0.15418 nm)", "right": "Standard laboratory X-ray characteristic emission generated by copper target electron bombardment" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In X-ray diffraction analysis, the Scherrer equation quantifies how nanoscale crystallite size is inversely proportional to the diffraction peak full-width at half-___ \u03b2.",
      "blankAnswer": "maximum",
      "blankDistractors": ["minimum", "average", "height"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An XRD scan of gold nanoparticles (\u03bb = 0.15418 nm) shows a (111) peak at 2\u03b8 = 38.20\u00b0 (\u03b8 = 19.10\u00b0 \u2192 sin 19.1\u00b0 = 0.3272, cos 19.1\u00b0 = 0.9450). d111 = 0.15418 / (2 * 0.3272) = 0.2356 nm (2.36 \u00c5). The peak FWHM is \u03b2 = 0.600\u00b0 = 0.01047 rad. With shape factor K = 0.94, \u03c4 = (0.94 * 0.15418) / (0.01047 * 0.9450) = 0.1449 / 0.009895 = 14.64 nm. What are the d-spacing d111 and crystallite size \u03c4?",
      "options": [
        { "text": "d111 = 0.236 nm and \u03c4 = 14.6 nm (d111 = 0.15418 / (2 * 0.32722) = 0.2356 nm; \u03c4 = 0.14493 / 0.009895 = 14.65 nm \u2248 14.6 nm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Bragg's law and the Scherrer equation (B. D. Cullity & S. R. Stock *Elements of X-Ray Diffraction* Chapter 3; Paul Scherrer 1918). 1. **Calculate Bragg Angle \\& Trigonometric Values:** - Measured detector peak position: $2\\theta = 38.20^\\circ$. - Bragg angle: $$\\theta = \\frac{2\\theta}{2} = \\frac{38.20^\\circ}{2} = \\mathbf{19.10^\\circ}$$ $$\\sin(19.10^\\circ) = \\mathbf{0.327218} \\quad \\Big| \\quad \\cos(19.10^\\circ) = \\mathbf{0.944951}$$ 2. **Calculate (111) Interplanar Spacing ($d_{111}$ via Bragg's Law):** - X-ray wavelength: $\\lambda = 0.15418\\text{ nm}$. $$d_{111} = \\frac{\\lambda}{2 \\sin\\theta} = \\frac{0.15418\\text{ nm}}{2 \\times 0.327218} = \\frac{0.15418}{0.654436} = \\mathbf{0.23559\\text{ nm} = 2.3559\\text{ Å} \\approx 0.236\\text{ nm}}$$ 3. **Convert FWHM to Radians:** - Peak FWHM: $\\beta = 0.600^\\circ$. $$\\beta_{\\text{rad}} = 0.600^\\circ \\times \\frac{\\pi}{180^\\circ} = \\mathbf{0.010472\\text{ radians}}$$ 4. **Calculate Nanocrystallite Size ($\\tau$ via Scherrer Equation):** - Shape factor: $K = 0.94$. $$\\tau = \\frac{K \\cdot \\lambda}{\\beta_{\\text{rad}} \\cdot \\cos\\theta} = \\frac{0.94 \\times 0.15418\\text{ nm}}{0.010472\\text{ rad} \\times 0.944951}$$ $$\\tau = \\frac{0.1449292}{0.0098955} = \\mathbf{14.6459\\text{ nm} \\approx 14.6\\text{ nm}}$$ Flawless Bragg's law and Scherrer nanocrystallite size derivation!" },
        { "text": "d111 = 0.471 nm and \u03c4 = 14.6 nm (Forgot factor of 2 in Bragg's law denominator)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d111 = 0.236 nm and \u03c4 = 0.25 nm (Used degrees directly without converting \u03b2 to radians)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d111 = 1.54 nm and \u03c4 = 146.0 nm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
