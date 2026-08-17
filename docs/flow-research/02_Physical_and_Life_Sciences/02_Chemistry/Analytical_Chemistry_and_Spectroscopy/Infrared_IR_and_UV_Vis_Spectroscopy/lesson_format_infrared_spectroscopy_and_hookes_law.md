# Duofy Reusable Lesson Format: Infrared Spectroscopy and Hooke's Law

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Infrared_IR_and_UV_Vis_Spectroscopy`  
**Lesson Format Type:** `infrared_spectroscopy_and_hookes_law`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the harmonic oscillator mechanics and physical principles of Infrared (IR) spectroscopy: formulate **Hooke's Law for Vibrational Frequency ($\tilde{\nu} = \frac{1}{2\pi c}\sqrt{\frac{k}{\mu}}$)**, calculate the **Reduced Mass ($\mu = \frac{m_1 m_2}{m_1 + m_2}$)**, analyze the effect of **Bond Order / Spring Stiffness ($k_{\text{single}} \approx 500\text{ N/m} < k_{\text{double}} \approx 1000\text{ N/m} < k_{\text{triple}} \approx 1500\text{ N/m}$)**, analyze **Isotopic Substitution Shifts (e.g. $\text{C}-\text{H}$ vs $\text{C}-\text{D}$)**, and evaluate the fundamental **Dipole Selection Rule ($\frac{d\mu}{dq} \ne 0$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vibrational Harmonic Oscillator & Hooke's Law Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Hooke's Law Wavenumber Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Chemical Bond Type & Typical Stretching Frequency Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Symmetrical Homonuclear Diatomic IR Inactivity Reason Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Deuterium Isotopic Substitution Wavenumber Shift Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Mechanical Theory of Molecular Vibrations:
   - **Hooke's Law Harmonic Oscillator (Classical to Quantum):**
     $$\tilde{\nu} = \frac{\nu}{c} = \frac{1}{2\pi c} \sqrt{\frac{k}{\mu}} \qquad (\text{Wavenumber in } \text{cm}^{-1})$$
     - **Bond Force Constant ($k$):** Proportional to bond strength:
       $$k_{\text{single}} \approx 5 \times 10^5\text{ dyn/cm } (500\text{ N/m}), \quad k_{\text{double}} \approx 10 \times 10^5\text{ dyn/cm}, \quad k_{\text{triple}} \approx 15 \times 10^5\text{ dyn/cm}$$
     - **Reduced Mass ($\mu$):**
       $$\mu = \frac{m_1 m_2}{m_1 + m_2} = \frac{M_1 M_2}{(M_1 + M_2) N_A}$$
   - **The IR Selection Rule:** A molecular vibration is IR-active **ONLY if it causes a net change in molecular dipole moment** ($\frac{d\mu_{\text{dipole}}}{dq} \ne 0$).
     - Homonuclear diatomics ($\text{N}_2, \text{O}_2, \text{Cl}_2$) have $\Delta\mu = 0 \implies$ completely IR inactive!
     - Asymmetric stretches in $\text{CO}_2$ ($\leftarrow \text{O}=\text{C}=\text{O} \rightarrow$) produce dipole changes $\implies$ strongly IR active at $2350\text{ cm}^{-1}$!
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the wavenumber formula from classical mechanics: (1) write Newton's second law for a two-body spring oscillator: $\mu \frac{d^2 x}{dt^2} = -k x$, (2) solve the differential equation to obtain harmonic angular frequency: $\omega = \sqrt{\frac{k}{\mu}}$, (3) convert angular frequency to cyclical frequency $\nu = \frac{\omega}{2\pi} = \frac{1}{2\pi}\sqrt{\frac{k}{\mu}}$, (4) divide by the speed of light $c$ to define wavenumber: $\tilde{\nu} \equiv \frac{\nu}{c} = \frac{1}{2\pi c}\sqrt{\frac{k}{\mu}}$, (5) substitute numerical atomic masses in grams to express $\tilde{\nu}$ directly in standard laboratory units of $\text{cm}^{-1}$!
3. **Slide 3 (`matching`):** Pair 4 chemical bonds ($\text{C}-\text{C}$ single bond, $\text{C}=\text{C}$ double bond, $\text{C}\equiv\text{C}$ triple bond, $\text{C}-\text{H}$ bond) with their typical stretching frequencies ($1200\text{ cm}^{-1}$, $1650\text{ cm}^{-1}$, $2200\text{ cm}^{-1}$, $3000\text{ cm}^{-1}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that for a molecular vibration to absorb infrared radiation, the motion must produce a change in the molecular ___ moment. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on isotopic substitution: A standard carbon-hydrogen bond ($\text{C}-\text{H}$) exhibits a stretching vibration at $\tilde{\nu} \approx 3000\text{ cm}^{-1}$. When hydrogen ($^1\text{H}$) is replaced by deuterium ($^2\text{D}$ or $\text{D}$), by what approximate factor does the stretching wavenumber $\tilde{\nu}_{\text{C}-\text{D}}$ decrease? (By approximately $\sqrt{2} \approx 1.41$, shifting the vibration down to $\tilde{\nu}_{\text{C}-\text{D}} \approx \frac{3000}{\sqrt{2}} \approx 2130-2200\text{ cm}^{-1}$; because deuterium has double the mass of protium, the reduced mass $\mu \approx m_{\text{H}}$ doubles ($\mu_{\text{C}-\text{D}} \approx 2\mu_{\text{C}-\text{H}}$), reducing frequency by $1/\sqrt{2}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "infrared_spectroscopy_and_hookes_law",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Infrared Spectroscopy and Hooke's Law**\n• **Vibrational Harmonic Frequency:**\n$$\n\\tilde{\\nu} = \\frac{1}{2\\pi c} \\sqrt{\\frac{k}{\\mu}} \\qquad (\\text{Wavenumber in } \\text{cm}^{-1})\n$$\n• **Force Constant ($k$) & Reduced Mass ($\\mu$):**\n$$\nk_{\\text{single}} < k_{\\text{double}} < k_{\\text{triple}}, \\qquad \\mu = \\frac{m_1 m_2}{m_1 + m_2}\n$$\n  - **Stronger Bond $\\implies$ Higher Frequency** (Triple bond $\\sim 2200\\text{ cm}^{-1}$ vs Single bond $\\sim 1200\\text{ cm}^{-1}$).\n  - **Lighter Atom $\\implies$ Higher Frequency** ($\\text{C}-\\text{H} \\sim 3000\\text{ cm}^{-1}$ vs $\\text{C}-\\text{C} \\sim 1200\\text{ cm}^{-1}$).\n• **The Infrared Selection Rule:** Vibration must generate a **dynamic change in dipole moment** ($\\frac{d\\mu_{\\text{dipole}}}{dq} \\ne 0$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the harmonic oscillator steps deriving the vibrational wavenumber formula nu_bar = (1 / 2 pi c) * sqrt(k / mu).",
      "orderItems": [
        "Formulate Newton's second law for a vibrating diatomic spring with reduced mass: mu * (d²x/dt²) = -k * x",
        "Solve the differential equation to find natural harmonic angular frequency: omega = sqrt(k / mu)",
        "Convert angular frequency to cyclical frequency in Hertz: nu = omega / (2 * pi) = (1 / 2 pi) * sqrt(k / mu)",
        "Divide frequency by the speed of light c to express frequency in units of inverse length (wavenumber): nu_bar = nu / c",
        "Arrive at Hooke's spectroscopic relation: nu_bar = (1 / [2 * pi * c]) * sqrt(k / mu) in cm^-1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each chemical bond type to its characteristic infrared stretching frequency range.",
      "matchPairs": [
        { "left": "C-H Stretching (Light Hydrogen Atom)", "right": "2850 - 3300 cm^-1 (high frequency due to very small reduced mass)" },
        { "left": "C≡C / C≡N Triple Bonds (k ≈ 1500 N/m)", "right": "2100 - 2260 cm^-1 (stiff triple bond region)" },
        { "left": "C=O / C=C Double Bonds (k ≈ 1000 N/m)", "right": "1600 - 1780 cm^-1 (strong diagnostic carbonyl region)" },
        { "left": "C-C / C-O Single Bonds (k ≈ 500 N/m)", "right": "1000 - 1300 cm^-1 (fingerprint region)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A molecular vibration cannot absorb infrared radiation unless the displacement produces a dynamic change in the molecular ___ moment.",
      "blankAnswer": "dipole",
      "blankDistractors": ["quadrupole", "magnetic", "mass"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A C-H stretching vibration appears at ~3000 cm^-1. When hydrogen is isotopically replaced with deuterium (C-D), where does the new stretching band appear?",
      "options": [
        { "text": "Shifts DOWN to ~2150 - 2200 cm^-1; because deuterium (mass 2) doubles the reduced mass (mu_CD ≈ 2 * mu_CH), the frequency drops by a factor of 1/√2 ≈ 0.707 (3000 / 1.414 ≈ 2120 cm^-1)", "isCorrect": true, "explanation": "Correct! Since bond force constant k is purely electronic and identical for isotopes, nu_bar ∝ 1/sqrt(mu). Replacing H (mass 1) with D (mass 2) doubles the reduced mass from ~0.923 amu to ~1.714 amu (ratio ≈ 1.86, sqrt ≈ 1.36), shifting the C-D stretch from ~3000 cm^-1 down to ~2200 cm^-1." },
        { "text": "Shifts UP to 6000 cm^-1", "isCorrect": false, "explanation": "Incorrect: Heavier atoms lower the vibrational frequency." },
        { "text": "Remains unchanged at 3000 cm^-1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Disappears completely from the spectrum", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
