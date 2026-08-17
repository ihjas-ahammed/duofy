# Duofy Reusable Lesson Format: Cosmic Microwave Background and Acoustic Peaks

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Astrophysics_and_Relativity / Cosmology_Big_Bang_and_Dark_Energy`  
**Lesson Format Type:** `cosmic_microwave_background_and_acoustic_peaks`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze the **Cosmic Microwave Background (CMB)**: understand **Recombination & Photon Decoupling** ($z \approx 1100, T \approx 3000\text{ K} \to T_0 = 2.7255\text{ K}$), evaluate the **Blackbody Spectrum** (COBE FIRAS perfection), dissect **Baryon Acoustic Oscillations (BAO)** in the primordial plasma, and decode the cosmological parameters embedded in the angular power spectrum $C_\ell$ acoustic peaks.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CMB Physics & Acoustic Oscillations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Multipole Expansion C_ell Breakdown Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | CMB Acoustic Peak Index & Cosmological Parameter Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical CMB Present Blackbody Temperature Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | First Acoustic Peak Position and Spatial Flatness Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the origin of the Cosmic Microwave Background (Arno Penzias & Robert Wilson 1965, Robert Dicke, Jim Peebles):
   - **Recombination & Decoupling ($z \approx 1100, t \sim 380,000\text{ yr}$):** Temperature cooled below $3000\text{ K}$, allowing electrons and protons to form neutral hydrogen ($p + e^- \to H + \gamma$). The universe became transparent, releasing the **Surface of Last Scattering**.
   - **Present Spectrum:** A near-perfect blackbody with $T_0 = 2.7255 \pm 0.0006\text{ K}$ (COBE FIRAS).
   - **Anisotropies & Acoustic Peaks:** Temperature fluctuations $\frac{\Delta T}{T} \sim 10^{-5}$ are expanded in spherical harmonics: $\Delta T(\theta, \phi) = \sum_{\ell, m} a_{\ell m} Y_{\ell m}(\theta, \phi)$, with Angular Power Spectrum $C_\ell = \langle |a_{\ell m}|^2 \rangle$.
2. **Slide 2 (`concept_pieces`):** Deconstruct acoustic oscillations in the pre-recombination plasma: (1) primordial dark matter gravitational potential wells pull baryonic matter inward via gravity (compression), (2) radiation pressure of trapped photons resists and pushes matter back outward (rarefaction), (3) this creates acoustic standing sound waves in the plasma with sound speed $c_s = c / \sqrt{3(1 + 3\rho_b / 4\rho_\gamma)}$, (4) at decoupling ($z \approx 1100$), the sound waves are suddenly "frozen" in place, (5) modes caught at maximum compression or rarefaction appear as discrete **Acoustic Peaks** at characteristic multipoles $\ell \approx 220, 540, 800, \dots$!
3. **Slide 3 (`matching`):** Pair 4 CMB acoustic peaks/features (First Peak $\ell \approx 220$, Second-to-First Peak Ratio, Third Peak Amplitude, Sachs-Wolfe Plateau $\ell < 20$) with their physical determinants ($\Omega_k = 0$ Spatial Flatness, Baryon Density $\Omega_b$, Cold Dark Matter Density $\Omega_{\text{CDM}}$, Primordial Gravitational Potential Fluctuations).
4. **Slide 4 (`numerical`):** Ask student: What is the present average temperature of the Cosmic Microwave Background radiation in Kelvin (rounded to two decimal places)? (numeric answer: 2.73).
5. **Slide 5 (`quiz`):** Quiz on how the 1st acoustic peak multipole $\ell \approx 220$ proves the universe is spatially FLAT: (The sound horizon $r_s \approx 150\text{ Mpc}$ at decoupling acts as a standard ruler; in a flat universe ($k = 0$), photons travel along straight Euclidean geodesics, subtending an angular scale of exactly $\theta \approx 1^\circ$, which corresponds to multipole $\ell \approx 180^\circ / 1^\circ \approx 200 - 220$. If closed, $\ell < 200$; if open, $\ell > 200$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cosmic_microwave_background_and_acoustic_peaks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Cosmic Microwave Background and Acoustic Peaks**\n• **Recombination & Decoupling ($z \\approx 1100, \\, t \\sim 380,000\\text{ yr}$):**\n  Plasma cooled below $3000\\text{ K}$, allowing electrons and protons to form neutral hydrogen ($p + e^- \\to \\text{H}$). Photons decoupled, forming the **Surface of Last Scattering**.\n• **The Blackbody Spectrum:** Perfect Planckian blackbody at current temperature:\n$$\nT_0 = 2.7255 \\pm 0.0006\\text{ K}\n$$\n• **CMB Angular Power Spectrum $C_\\ell$:** Temperature fluctuations $\\frac{\\Delta T}{T} \\sim 10^{-5}$ expanded in spherical harmonics:\n$$\n\\Delta T(\\theta, \\phi) = \\sum_{\\ell=0}^\\infty \\sum_{m=-\\ell}^\\ell a_{\\ell m} Y_{\\ell m}(\\theta, \\phi), \\qquad C_\\ell = \\langle |a_{\\ell m}|^2 \\rangle\n$$\n• **Acoustic Peaks:** Sound waves in the photon-baryon plasma frozen at decoupling!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Gravitational Infall):** Primordial quantum fluctuations create potential wells; baryons fall inward under gravity.\n• **Step 2 (Radiation Pressure Rebound):** Trapped photons exert radiation pressure, resisting collapse and rebounding outward.\n• **Step 3 (Acoustic Standing Waves):** Oscillating compressions and rarefactions propagate at sound speed $c_s \\approx c/\\sqrt{3}$.\n• **Step 4 (Freezing at Recombination):** Neutral hydrogen forms, freeing photons; oscillation phases are permanently imprinted on the sky.\n• **Step 5 (Peak Formation):** Maximum compression modes create harmonic peaks in the power spectrum $C_\\ell$ at $\\ell \\approx 220, 540, 800, \\dots$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CMB power spectrum feature to the cosmological parameter it constrains.",
      "matchPairs": [
        { "left": "1st Peak Location (l ~ 220)", "right": "Spatial Curvature Omega_k = 0 (proves universe is geometrically FLAT)" },
        { "left": "2nd Peak Suppression / Height", "right": "Baryon Density Omega_b (higher baryon load deepens compression peaks relative to rarefaction)" },
        { "left": "3rd Peak Height", "right": "Cold Dark Matter Density Omega_{CDM} (provides non-rebounding gravitational potential wells)" },
        { "left": "Low-l Sachs-Wolfe Plateau (l < 20)", "right": "Primordial primordial scalar fluctuation amplitude and spectral index n_s" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the measured blackbody temperature of the Cosmic Microwave Background today in Kelvin (round to 2 decimal places)?",
      "numericAnswer": 2.73,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the first CMB acoustic peak occurring at multipole l ≈ 220 (angular size θ ≈ 1°) definitively prove that our universe is spatially FLAT (k = 0)?",
      "options": [
        { "text": "The acoustic sound horizon r_s ≈ 150 Mpc acts as a KNOWN STANDARD RULER; in a flat Euclidean geometry, light rays travel along straight lines subtending exactly 1° on the sky (l ≈ 180°/1° ≈ 200-220)", "isCorrect": true, "explanation": "Correct! If the universe had positive spatial curvature (closed/spherical), gravitational lensing from positive curvature would make the angle appear larger (shifting the peak to smaller l < 200). Observations tightly constrain Omega_k = 0.0007 +/- 0.0019 (flat!)." },
        { "text": "Because the CMB is 2.73 K", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the universe is infinite in time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because photons have mass", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
