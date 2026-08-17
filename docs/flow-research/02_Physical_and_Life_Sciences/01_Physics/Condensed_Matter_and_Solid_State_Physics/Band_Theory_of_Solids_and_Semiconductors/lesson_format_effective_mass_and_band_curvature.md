# Duofy Reusable Lesson Format: Effective Mass and Band Curvature

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Band_Theory_of_Solids_and_Semiconductors`  
**Lesson Format Type:** `effective_mass_and_band_curvature`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through electron and hole wavepacket dynamics in crystals: formulate **Group Velocity ($v_g = \frac{1}{\hbar}\frac{dE}{dk}$)**, derive the **Effective Mass Tensor $m^* = \hbar^2 \left(\frac{d^2 E}{dk^2}\right)^{-1}$**, evaluate acceleration under external electric fields ($a = \frac{q E_{\text{field}}}{m^*}$), contrast **Electron Quasiparticles** at conduction band minima vs **Hole Quasiparticles** ($m_h^* > 0, q = +e$) at valence band maxima, and classify **Direct Band Gaps (GaAs)** vs **Indirect Band Gaps (Si, Ge)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Effective Mass & Band Curvature Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Effective Mass Derivation from Wavepacket Acceleration | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Semiconductor Type & Band Gap Alignment Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Valence Band Hole Charge Sign Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Direct vs Indirect Band Gap Optoelectronic Efficiency Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the dynamics of a Bloch wavepacket under external electric field $\mathcal{E}$:
   - **Group Velocity:** $v_g \equiv \frac{d\omega}{dk} = \frac{1}{\hbar}\frac{dE}{dk}$.
   - **Crystal Momentum Rate:** $\hbar \frac{dk}{dt} = F_{\text{ext}} = q \mathcal{E}$.
   - **Wavepacket Acceleration:** $a \equiv \frac{dv_g}{dt} = \frac{1}{\hbar}\frac{d}{dt}\left(\frac{dE}{dk}\right) = \frac{1}{\hbar}\frac{d^2 E}{dk^2} \frac{dk}{dt} = \frac{1}{\hbar^2}\frac{d^2 E}{dk^2} F_{\text{ext}}$.
   - **The Effective Mass Formula:**
     $$m^* \equiv \hbar^2 \left( \frac{d^2 E}{dk^2} \right)^{-1} \implies F_{\text{ext}} = m^* a$$
   - **Conduction Band Minimum:** $\frac{d^2 E}{dk^2} > 0 \implies m_e^* > 0$ (positive electron mass).
   - **Valence Band Maximum:** $\frac{d^2 E}{dk^2} < 0 \implies$ mapped to positive **Hole Quasiparticles** ($m_h^* = -m^* > 0$, charge $q_h = +e$).
2. **Slide 2 (`concept_pieces`):** Deconstruct calculation of effective mass for tight-binding band $E(k) = E_0 - 2t\cos(ka)$: (1) compute first derivative (group velocity): $\frac{dE}{dk} = 2 t a \sin(ka) \implies v_g = \frac{2ta}{\hbar}\sin(ka)$, (2) compute second derivative (curvature): $\frac{d^2 E}{dk^2} = 2 t a^2 \cos(ka)$, (3) evaluate at band bottom ($k = 0$): $\frac{d^2 E}{dk^2} = 2 t a^2$, (4) calculate electron effective mass at band bottom: $m_e^* = \frac{\hbar^2}{2 t a^2} > 0$, (5) evaluate at band top ($k = \pi/a$): $\frac{d^2 E}{dk^2} = -2 t a^2 \implies m^* = -\frac{\hbar^2}{2ta^2} \implies m_h^* = +\frac{\hbar^2}{2ta^2}$ (positive hole mass)!
3. **Slide 3 (`matching`):** Pair 4 semiconductors (Gallium Arsenide (GaAs), Silicon (Si), Graphene (Dirac cones), Germanium (Ge)) with their band structure types (Direct Gap at $\Gamma$-point, Indirect Gap between $\Gamma$ and $X$-valley, Linear Gapless Dirac dispersion $E = \pm \hbar v_F k$, Indirect Gap with $L$-valley minimum).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a hole in the valence band acts as a quasiparticle with positive electric charge +e. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why direct band gap semiconductors (like GaAs) are used for LEDs and laser diodes while indirect band gap semiconductors (like Silicon) are extremely poor light emitters: (In a DIRECT band gap, the conduction band minimum and valence band maximum align at the SAME crystal momentum ($k = 0$), allowing direct vertical radiative electron-hole recombination with high photon emission efficiency; in an INDIRECT band gap, recombination requires emitting/absorbing a PHONON (lattice vibration) to conserve momentum, making radiative recombination orders of magnitude slower and less probable).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "effective_mass_and_band_curvature",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Effective Mass and Band Curvature**\n• **Bloch Electron Wavepacket Dynamics:**\n  - **Group Velocity:** $v_g = \\frac{1}{\\hbar} \\frac{dE}{dk}$.\n  - **Force Law:** $\\hbar \\frac{dk}{dt} = F_{\\text{ext}} = q \\mathcal{E}$.\n• **The Effective Mass Definition:**\n$$\nm^* \\equiv \\hbar^2 \\left( \\frac{d^2 E}{dk^2} \\right)^{-1} \\implies a = \\frac{F_{\\text{ext}}}{m^*}\n$$\n• **Band Curvature & Quasiparticles:**\n  - **Band Bottom (Conduction Band):** $\\frac{d^2 E}{dk^2} > 0 \\implies m_e^* > 0$ (Free-like Electron).\n  - **Band Top (Valence Band):** $\\frac{d^2 E}{dk^2} < 0 \\implies$ An empty state behaves as a positive **Hole Quasiparticle** ($q = +e, \\, m_h^* = -m^* > 0$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Tight-Binding Dispersion):** Consider 1D band $E(k) = E_0 - 2t \\cos(ka)$.\n• **Step 2 (First Derivative / Velocity):** $\\frac{dE}{dk} = 2ta \\sin(ka) \\implies v_g = \\frac{2ta}{\\hbar}\\sin(ka)$.\n• **Step 3 (Second Derivative / Curvature):** $\\frac{d^2 E}{dk^2} = 2ta^2 \\cos(ka)$.\n• **Step 4 (Band Bottom at $k = 0$):** $\\frac{d^2 E}{dk^2} = +2ta^2 \\implies m_e^* = \\frac{\\hbar^2}{2ta^2} > 0$ (positive electron mass).\n• **Step 5 (Band Top at $k = \\pi/a$):** $\\frac{d^2 E}{dk^2} = -2ta^2 \\implies m_h^* = +\\frac{\\hbar^2}{2ta^2}$ (positive hole mass!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each semiconductor material to its band gap structure.",
      "matchPairs": [
        { "left": "Gallium Arsenide (GaAs)", "right": "Direct Band Gap (E_g = 1.42 eV at k = 0; efficient LED/laser emitter)" },
        { "left": "Silicon (Si)", "right": "Indirect Band Gap (E_g = 1.12 eV; requires phonon absorption for optical transitions)" },
        { "left": "Pristine Monolayer Graphene", "right": "Zero Band Gap Semimetal with linear Dirac cone dispersion E = +/- hbar v_F k" },
        { "left": "Gallium Nitride (GaN)", "right": "Wide Direct Band Gap (E_g = 3.4 eV; blue/UV LEDs and power electronics)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An empty electronic state near the top of the valence band acts as a quasiparticle called a hole with a ___ electric charge +e.",
      "blankAnswer": "positive",
      "blankDistractors": ["negative", "neutral", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why are direct band gap semiconductors (like GaAs) used for LEDs and laser diodes, while indirect band gap silicon is extremely inefficient for light emission?",
      "options": [
        { "text": "In direct band gap materials, the conduction band minimum and valence band maximum align at the SAME crystal momentum k = 0, allowing rapid direct photon emission without needing phonon lattice vibrations to conserve momentum", "isCorrect": true, "explanation": "Correct! Photons carry almost negligible momentum compared to electrons. In a direct band gap, an electron recombines directly with a hole vertically in k-space. In an indirect band gap, a phonon must be absorbed or emitted to conserve crystal momentum, making radiative transitions orders of magnitude slower." },
        { "text": "Because silicon absorbs all visible light permanently", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because GaAs has zero resistance", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because silicon has no valence electrons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
