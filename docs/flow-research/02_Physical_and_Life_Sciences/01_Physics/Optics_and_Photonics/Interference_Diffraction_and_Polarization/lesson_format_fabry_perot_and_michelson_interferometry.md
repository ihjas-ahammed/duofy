# Duofy Reusable Lesson Format: Fabry-Pérot and Michelson Interferometry

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Optics_and_Photonics / Interference_Diffraction_and_Polarization`  
**Lesson Format Type:** `fabry_perot_and_michelson_interferometry`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through high-precision optical interferometers: compare **Two-Beam (Michelson)** with **Multiple-Beam (Fabry-Pérot)** interferometry, formulate the **Airy Transmission Function for Fabry-Pérot Cavities ($T(\delta) = \frac{1}{1 + F\sin^2(\delta/2)}$ where $F = \frac{4R}{(1-R)^2}$)**, calculate the **Free Spectral Range ($\Delta\nu_{\text{FSR}} = \frac{c}{2nL}$)** and **Cavity Finesse ($\mathcal{F} = \frac{\pi\sqrt{R}}{1-R} = \frac{\Delta\nu_{\text{FSR}}}{\delta\nu}$)**, and evaluate laser cavity resonances and gravitational wave detection (LIGO).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fabry-Pérot & Michelson Interferometers Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Multi-Beam Geometric Series Summation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Interferometer Cavity Parameter & Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Michelson Mirror Displacement Path Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High Mirror Reflectance Cavity Finesse and Linewidth Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Multi-Beam Resonant Interferometry (Charles Fabry & Alfred Pérot, 1899):
   - **Cavity Parameters (Length $L$, mirror reflectance $R$, medium index $n$):**
     - Round-trip Phase Shift: $\delta = \frac{4\pi n L}{\lambda} \cos\theta$.
     - **The Airy Transmission Function:**
       $$T(\delta) \equiv \frac{I_t}{I_i} = \frac{1}{1 + F \sin^2(\delta/2)}, \qquad F \equiv \frac{4R}{(1 - R)^2} \quad (\text{Coefficient of Finesse})$$
     - **Resonance Condition:** $\delta = 2\pi m \implies 2 n L \cos\theta = m \lambda$ ($T = 1$, 100% transmission!).
     - **Free Spectral Range (FSR):** $\Delta\nu_{\text{FSR}} = \frac{c}{2 n L}$.
     - **Cavity Finesse ($\mathcal{F}$):**
       $$\mathcal{F} \equiv \frac{\pi \sqrt{R}}{1 - R} = \frac{\Delta\nu_{\text{FSR}}}{\delta\nu}$$
       where $\delta\nu$ is the full width at half maximum (FWHM) resonance linewidth.
   - **Michelson Interferometer (Albert Michelson, 1881):** Two-beam split with beam splitter; moving mirror by $\Delta d$ produces optical path change $\Delta = 2\Delta d$, counting $N = \frac{2\Delta d}{\lambda}$ fringes.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Airy transmission formula from infinite geometric series: (1) write transmitted electric field as sum of infinite successive reflections: $E_t = E_i \tau \tau' e^{i\delta/2} [1 + r^2 e^{i\delta} + r^4 e^{i2\delta} + \dots]$, (2) substitute mirror intensity coefficients $T = \tau\tau'$ and $R = r^2$: $E_t = E_i \frac{T e^{i\delta/2}}{1 - R e^{i\delta}}$, (3) calculate transmitted intensity: $I_t = |E_t|^2 = I_i \frac{T^2}{|1 - R e^{i\delta}|^2}$, (4) expand denominator using Euler's identity: $|1 - R(\cos\delta + i\sin\delta)|^2 = (1 - R)^2 + 4R\sin^2(\delta/2)$, (5) divide by $(1-R)^2$ and substitute $T = 1 - R$ to yield $T(\delta) = \frac{1}{1 + \frac{4R}{(1-R)^2}\sin^2(\delta/2)}$!
3. **Slide 3 (`matching`):** Pair 4 cavity quantities (Free Spectral Range $\Delta\nu_{\text{FSR}}$, Cavity Finesse $\mathcal{F}$, Resonance Linewidth $\delta\nu$, Michelson Path Difference) with their mathematical formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a Michelson interferometer, shifting a mirror by distance d introduces a round-trip optical path difference of 2 * d. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the effect of high mirror reflectance $R \to 1$ on a Fabry-Pérot cavity: What happens to the cavity finesse $\mathcal{F}$ and transmission peaks when mirror reflectance increases from $R = 0.90$ to $R = 0.99$? (The finesse increases tenfold from $\mathcal{F} \approx 30$ to $\mathcal{F} \approx 312$, making the transmission resonance peaks drastically NARROWER (smaller $\delta\nu$), providing ultra-high spectroscopic resolving power and frequency stability).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fabry_perot_and_michelson_interferometry",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fabry-Pérot and Michelson Interferometers**\n• **The Fabry-Pérot Etalon / Cavity (1899):**\n  - **Airy Transmission Function:**\n$$\n\\frac{I_t}{I_i} = \\frac{1}{1 + F \\sin^2(\\delta/2)}, \\qquad F \\equiv \\frac{4R}{(1 - R)^2}\n$$\n  - **Free Spectral Range (FSR):** $\\Delta\\nu_{\\text{FSR}} = \\frac{c}{2 n L}$ (frequency spacing between adjacent resonances).\n  - **Cavity Finesse $\\mathcal{F}$:**\n$$\n\\mathcal{F} \\equiv \\frac{\\pi \\sqrt{R}}{1 - R} = \\frac{\\Delta\\nu_{\\text{FSR}}}{\\delta\\nu}\n$$\n• **Michelson Interferometer (1881):** Two-beam interference with beam splitter; mirror motion $\\Delta d$ creates path change $\\Delta = 2\\Delta d$, counting $N = \\frac{2\\Delta d}{\\lambda}$ fringes."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the infinite geometric series steps deriving the Fabry-Pérot Airy transmission formula.",
      "orderItems": [
        "Sum infinite transmitted partial waves: E_t = E_i * T * exp(i delta/2) * [ 1 + R exp(i delta) + R^2 exp(i 2 delta) + ... ]",
        "Evaluate the infinite geometric series sum: E_t = E_i * T * exp(i delta/2) / [ 1 - R exp(i delta) ]",
        "Compute transmitted intensity by multiplying by complex conjugate: I_t = I_i * T^2 / |1 - R exp(i delta)|^2",
        "Expand the squared modulus in the denominator using Euler's formula: (1 - R)^2 + 4 R sin^2(delta / 2)",
        "Substitute lossless relation T = 1 - R to obtain the Airy formula: I_t / I_i = 1 / [ 1 + (4R / (1-R)^2) * sin^2(delta/2) ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each interferometer parameter to its formula.",
      "matchPairs": [
        { "left": "Free Spectral Range Delta(nu)_FSR", "right": "c / (2 * n * L) (spacing between adjacent cavity transmission peaks)" },
        { "left": "Cavity Finesse F", "right": "pi * sqrt(R) / (1 - R) = Delta(nu)_FSR / delta(nu)" },
        { "left": "Cavity Resonance Linewidth delta(nu)", "right": "delta(nu) = Delta(nu)_FSR / F (full width at half maximum)" },
        { "left": "Michelson Path Difference", "right": "Delta = 2 * (L_1 - L_2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Michelson interferometer, moving a mirror by distance d alters the optical path length by a factor of ___ * d.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "4", "0.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the physical effect of increasing mirror reflectance from R = 0.90 to R = 0.99 in a Fabry-Pérot laser cavity?",
      "options": [
        { "text": "Cavity finesse F surges by a factor of ~10 (from 30 to ~312), compressing the transmission peaks into extremely NARROW, ultra-sharp resonance spikes (linewidth delta_nu drops tenfold)", "isCorrect": true, "explanation": "Correct! Finesse scales as pi*sqrt(R)/(1-R). As R approaches 1, the denominator (1-R) vanishes, causing finesse to diverge and narrowing transmission linewidth delta_nu into razor-sharp frequency filters." },
        { "text": "Light is completely blocked from passing through the cavity", "isCorrect": false, "explanation": "Incorrect: At resonance, transmission remains 100% (T = 1)." },
        { "text": "Free Spectral Range becomes zero", "isCorrect": false, "explanation": "Incorrect: FSR depends only on cavity length L." },
        { "text": "The speed of light inside the cavity doubles", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
