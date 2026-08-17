# Duofy Reusable Lesson Format: Fiber Optics and Numerical Aperture

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Optics_and_Photonics / Lasers_Fiber_Optics_and_Nonlinear_Optics`  
**Lesson Format Type:** `fiber_optics_and_numerical_aperture`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through optical waveguide principles: formulate **Total Internal Reflection (TIR)** at the core-cladding interface ($n_{\text{core}} > n_{\text{clad}}$), derive the **Numerical Aperture ($\text{NA} \equiv \sqrt{n_{\text{core}}^2 - n_{\text{clad}}^2} = n_0 \sin\theta_{\text{acc}}$)** and maximum acceptance angle $\theta_{\text{acc}}$, define the **Normalized Frequency ($V$-Number)** $V \equiv \frac{2\pi a}{\lambda}\text{NA}$, prove the **Single-Mode Cutoff Condition ($V < 2.4048$)**, and analyze optical fiber dispersion (modal, chromatic, and waveguide dispersion).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Optical Fiber Waveguide & Numerical Aperture Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Numerical Aperture Trigonometric Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fiber Characteristic & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Step-Index Single-Mode V-Number Cutoff Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Single-Mode vs Multi-Mode Modal Dispersion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Dielectric Waveguide Theory (Charles Kao, Nobel Prize 2009):
   - **Total Internal Reflection Condition:** Requires $n_{\text{core}} > n_{\text{clad}}$ and angle of incidence $\phi \ge \phi_c = \arcsin(n_{\text{clad}}/n_{\text{core}})$.
   - **The Numerical Aperture (NA) & Acceptance Angle:**
     $$\text{NA} \equiv \sin\theta_{\text{acc}} = \sqrt{n_{\text{core}}^2 - n_{\text{clad}}^2} \approx n_{\text{core}} \sqrt{2\Delta}, \qquad \Delta \equiv \frac{n_{\text{core}} - n_{\text{clad}}}{n_{\text{core}}}$$
   - **Normalized Frequency ($V$-Number for Core Radius $a$):**
     $$V \equiv \frac{2\pi a}{\lambda} \text{NA} = \frac{2\pi a}{\lambda} \sqrt{n_{\text{core}}^2 - n_{\text{clad}}^2}$$
   - **Single-Mode Step-Index Fiber Condition:**
     $$V < 2.4048 \quad (\text{First zero of Bessel function } J_0(u))$$
     *(Supports ONLY the fundamental $\text{LP}_{01} / \text{HE}_{11}$ mode; completely eliminates intermodal dispersion!).*
   - **Number of Guided Modes in Multimode Step-Index Fiber:** $M \approx \frac{V^2}{2}$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Numerical Aperture formula: (1) apply Snell's Law at the flat fiber air-core entrance face: $n_0 \sin\theta_{\text{acc}} = n_{\text{core}} \sin\theta_r$, (2) recognize right-angled geometry inside core: angle of incidence at cladding is $\phi = 90^\circ - \theta_r$, (3) express sine in terms of cosine: $\sin\theta_r = \cos\phi = \sqrt{1 - \sin^2\phi}$, (4) apply critical angle condition for TIR at cladding: $\sin\phi_c = \frac{n_{\text{clad}}}{n_{\text{core}}}$, (5) substitute $\sin\phi_c$ into entrance equation: $n_0 \sin\theta_{\text{acc}} = n_{\text{core}} \sqrt{1 - (n_{\text{clad}}/n_{\text{core}})^2} = \sqrt{n_{\text{core}}^2 - n_{\text{clad}}^2} \equiv \text{NA}$!
3. **Slide 3 (`matching`):** Pair 4 fiber waveguide parameters ($\text{NA}$, $V$-number, Single-mode condition, Multimode mode count $M$) with their mathematical formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a step-index optical fiber operates in the single-mode regime when its $V$-number is less than 2.405 (or 2.4048). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the primary transmission advantage of Single-Mode Fiber (SMF) over Multi-Mode Fiber (MMF) for long-haul telecommunications: Why is single-mode fiber used for transoceanic internet cables instead of multimode fiber? (Because single-mode fiber guides only a single spatial mode, COMPLETELY ELIMINATING intermodal dispersion (pulse broadening caused by different geometric ray paths arriving at different times), enabling tens of Gigabits/second data rates over hundreds of kilometers without distortion).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fiber_optics_and_numerical_aperture",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fiber Optics and Numerical Aperture**\n• **Total Internal Reflection (TIR):** Requires $n_{\\text{core}} > n_{\\text{clad}}$.\n• **Numerical Aperture (NA) and Acceptance Angle:**\n$$\n\\text{NA} \\equiv \\sin\\theta_{\\text{acc}} = \\sqrt{n_{\\text{core}}^2 - n_{\\text{clad}}^2}\n$$\n• **Normalized Frequency ($V$-Number for Core Radius $a$):**\n$$\nV \\equiv \\frac{2\\pi a}{\\lambda} \\text{NA} = \\frac{2\\pi a}{\\lambda} \\sqrt{n_{\\text{core}}^2 - n_{\\text{clad}}^2}\n$$\n• **Single-Mode Step-Index Cutoff Condition:**\n$$\nV < 2.4048\n$$\n  *(Supports only the fundamental $\\text{LP}_{01}$ mode, completely eliminating intermodal dispersion!).*\n• **Multimode Fiber Guided Modes:** $M \\approx \\frac{V^2}{2}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the Snell's Law steps deriving the fiber Numerical Aperture NA = sqrt(n_core^2 - n_clad^2).",
      "orderItems": [
        "Apply Snell's Law at the air-to-core fiber front entrance: n_0 * sin(theta_acc) = n_core * sin(theta_r)",
        "Use right-triangle geometry inside the core to relate refraction angle theta_r to core-cladding incidence angle: phi = 90° - theta_r",
        "Express sine of refraction angle in terms of incidence angle: sin(theta_r) = cos(phi) = sqrt(1 - sin^2(phi))",
        "Set incidence angle to the critical angle for total internal reflection at cladding: sin(phi_c) = n_clad / n_core",
        "Substitute sin(phi_c) to obtain NA = n_0 * sin(theta_acc) = n_core * sqrt(1 - [n_clad/n_core]^2) = sqrt(n_core^2 - n_clad^2)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each optical fiber specification to its formula.",
      "matchPairs": [
        { "left": "Numerical Aperture (NA)", "right": "NA = sqrt(n_core^2 - n_clad^2) = sin(theta_acc)" },
        { "left": "Normalized Frequency V-Number", "right": "V = (2 pi a / lambda) * NA" },
        { "left": "Single-Mode Cutoff Condition", "right": "V < 2.4048 (first root of Bessel J_0)" },
        { "left": "Multimode Fiber Mode Capacity", "right": "M ≈ V^2 / 2 (approximate number of guided spatial modes)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A step-index optical fiber operates strictly as a single-mode waveguide when its normalized frequency V-number is less than ___ (round to 2 decimal places).",
      "blankAnswer": "2.40",
      "blankDistractors": ["1.00", "3.14", "4.81"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is Single-Mode Fiber (SMF) universally preferred over Multi-Mode Fiber (MMF) for long-distance optical internet communication?",
      "options": [
        { "text": "SMF completely ELIMINATES INTERMODAL DISPERSION (the pulse broadening caused by different ray modes traveling along different paths at different speeds), allowing light pulses to travel hundreds of kilometers at Terabit data rates without overlapping", "isCorrect": true, "explanation": "Correct! In multimode fiber, different modes travel along different path lengths, causing severe intermodal pulse spreading (modal dispersion) that limits bandwidth over distance. Single-mode fiber guides only a single fundamental spatial mode (LP01), completely eliminating this dispersion mechanism." },
        { "text": "Because single-mode fiber is made of solid gold", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because multimode fiber cannot transmit red light", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because single-mode fiber does not require total internal reflection", "isCorrect": false, "explanation": "Incorrect: Both rely on TIR." }
      ]
    }
  ]
}
```
