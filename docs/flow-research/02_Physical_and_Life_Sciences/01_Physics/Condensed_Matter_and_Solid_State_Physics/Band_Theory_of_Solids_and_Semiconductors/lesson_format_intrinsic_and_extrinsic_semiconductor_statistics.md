# Duofy Reusable Lesson Format: Intrinsic and Extrinsic Semiconductor Statistics

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Band_Theory_of_Solids_and_Semiconductors`  
**Lesson Format Type:** `intrinsic_and_extrinsic_semiconductor_statistics`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through carrier statistics in semiconductors: formulate **Fermi-Dirac Statistics**, compute density of states $N_c, N_v$, derive carrier concentrations $n = N_c e^{-(E_c - E_F)/k_B T}$ and $p = N_v e^{-(E_F - E_v)/k_B T}$, evaluate the **Law of Mass Action ($n p = n_i^2$)**, analyze **Extrinsic Doping** (n-type donors $N_D$, p-type acceptors $N_A$), and track Fermi level shift $E_F(T)$ from freeze-out to extrinsic saturation and intrinsic regimes.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Semiconductor Statistics & Law of Mass Action Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Intrinsic Carrier Concentration Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Dopant / Regime & Fermi Level Position Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Majority Carrier in n-type Semiconductor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Law of Mass Action Invariance Under Doping Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fermi-Dirac distribution: $f(E) = \frac{1}{1 + e^{(E - E_F)/k_B T}}$. In non-degenerate semiconductors ($E_c - E_F \gg k_B T$):
   - **Electron Density:** $n = N_c e^{-(E_c - E_F)/k_B T}$, where $N_c = 2\left(\frac{2\pi m_e^* k_B T}{h^2}\right)^{3/2}$ is effective density of states in conduction band.
   - **Hole Density:** $p = N_v e^{-(E_F - E_v)/k_B T}$, where $N_v = 2\left(\frac{2\pi m_h^* k_B T}{h^2}\right)^{3/2}$.
   - **The Law of Mass Action (Fundamental Equilibrium Theorem):**
     $$n \cdot p = n_i^2 = N_c N_v e^{-E_g / k_B T}$$
     *(The product $n \cdot p$ is strictly constant at thermal equilibrium, entirely independent of doping concentrations $N_D, N_A$!).*
   - **Intrinsic Fermi Level:** $E_i = \frac{E_c + E_v}{2} + \frac{3}{4}k_B T \ln\left(\frac{m_h^*}{m_e^*}\right) \approx \text{Mid-gap}$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $n \cdot p = n_i^2$: (1) write Boltzmann approximation for electron concentration: $n = N_c e^{-(E_c - E_F)/k_B T}$, (2) write Boltzmann approximation for hole concentration: $p = N_v e^{-(E_F - E_v)/k_B T}$, (3) multiply the two concentrations: $n \cdot p = N_c N_v e^{-(E_c - E_F)/k_B T} e^{-(E_F - E_v)/k_B T}$, (4) combine exponents to observe that the Fermi energy $E_F$ cancels out completely: $-(E_c - E_F + E_F - E_v)/k_B T = -(E_c - E_v)/k_B T = -E_g / k_B T$, (5) conclude: $n \cdot p = N_c N_v e^{-E_g / k_B T} \equiv n_i^2$!
3. **Slide 3 (`matching`):** Pair 4 doping states (Intrinsic Semiconductor, n-type Doped ($N_D \gg N_A$), p-type Doped ($N_A \gg N_D$), Heavily Doped Degenerate n+) with their Fermi level positions ($E_F \approx \text{Mid-gap}$, $E_F$ near conduction band $E_c$, $E_F$ near valence band $E_v$, $E_F$ pushed inside conduction band $E > E_c$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in an n-type semiconductor doped with donor atoms, electrons are the majority carriers. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Law of Mass Action: If a silicon wafer at $300\text{ K}$ ($n_i = 1.5 \times 10^{10}\text{ cm}^{-3}$) is doped with phosphorus donors to $N_D = 10^{16}\text{ cm}^{-3}$, what is the minority hole concentration $p$? ($n \approx N_D = 10^{16}\text{ cm}^{-3} \implies p = \frac{n_i^2}{n} = \frac{(1.5 \times 10^{10})^2}{10^{16}} = \frac{2.25 \times 10^{20}}{10^{16}} = 2.25 \times 10^4\text{ cm}^{-3}$, demonstrating how donor doping suppresses hole concentration by 6 orders of magnitude via recombination).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "intrinsic_and_extrinsic_semiconductor_statistics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Semiconductor Statistics and the Law of Mass Action**\n• **Thermal Equilibrium Carrier Densities:**\n$$\nn = N_c e^{-(E_c - E_F)/k_B T}, \\qquad p = N_v e^{-(E_F - E_v)/k_B T}\n$$\n• **The Law of Mass Action (Independent of Doping!):**\n$$\nn \\cdot p = n_i^2 = N_c N_v e^{-E_g / k_B T}\n$$\n• **Extrinsic Doping Control:**\n  - **n-type (Donors $N_D$, e.g. Phosphorus):** $n \\approx N_D \\implies p = \\frac{n_i^2}{N_D}$ ($E_F$ shifts toward $E_c$).\n  - **p-type (Acceptors $N_A$, e.g. Boron):** $p \\approx N_A \\implies n = \\frac{n_i^2}{N_A}$ ($E_F$ shifts toward $E_v$).\n• **Intrinsic Carrier Concentration ($n = p = n_i$):** $n_i \\approx 1.5 \\times 10^{10}\\text{ cm}^{-3}$ for Silicon at $300\\text{ K}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the algebraic steps proving the Law of Mass Action n * p = n_i^2.",
      "orderItems": [
        "Write thermal equilibrium electron concentration: n = N_c * exp(-(E_c - E_F) / (k_B T))",
        "Write thermal equilibrium hole concentration: p = N_v * exp(-(E_F - E_v) / (k_B T))",
        "Multiply the two carrier concentrations: n * p = N_c * N_v * exp( [-(E_c - E_F) - (E_F - E_v)] / (k_B T) )",
        "Simplify the exponent: observe that +E_F and -E_F cancel identically, leaving -(E_c - E_v) = -E_g",
        "Obtain the doping-independent result: n * p = N_c * N_v * exp(-E_g / (k_B T)) = n_i^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each semiconductor doping condition to its Fermi level position.",
      "matchPairs": [
        { "left": "Intrinsic Silicon (pure)", "right": "E_F is located near the middle of the band gap (mid-gap)" },
        { "left": "n-type Silicon (Phosphorus doped)", "right": "E_F shifts upward close to the conduction band edge E_c" },
        { "left": "p-type Silicon (Boron doped)", "right": "E_F shifts downward close to the valence band edge E_v" },
        { "left": "Degenerate n+ Semiconductor", "right": "E_F is pushed above E_c into the conduction band (metallic behavior)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an n-type semiconductor doped with donor impurities, ___ are the majority charge carriers.",
      "blankAnswer": "electrons",
      "blankDistractors": ["holes", "photons", "phonons"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If a silicon wafer at 300 K (with n_i = 1.5 × 10^10 cm⁻³) is doped with N_D = 10^16 cm⁻³ donor atoms, what is the minority hole concentration p in thermal equilibrium?",
      "options": [
        { "text": "p = n_i^2 / N_D = (1.5 × 10^10)^2 / 10^16 = 2.25 × 10^4 cm⁻³; donor electrons increase recombination, suppressing hole density by 6 orders of magnitude", "isCorrect": true, "explanation": "Correct! By the Law of Mass Action, n * p = n_i^2 is strictly preserved. When n ≈ N_D = 10^16 cm^-3, p is suppressed to 2.25 × 10^4 cm^-3." },
        { "text": "p = 10^16 cm⁻³", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "p = 1.5 × 10^10 cm⁻³", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "p = 0 cm⁻³", "isCorrect": false, "explanation": "Incorrect: Thermal generation always maintains a non-zero minority population." }
      ]
    }
  ]
}
```
