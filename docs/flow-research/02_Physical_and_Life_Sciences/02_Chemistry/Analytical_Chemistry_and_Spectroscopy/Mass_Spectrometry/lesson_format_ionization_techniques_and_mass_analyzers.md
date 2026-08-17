# Duofy Reusable Lesson Format: Ionization Techniques and Mass Analyzers

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Mass_Spectrometry`  
**Lesson Format Type:** `ionization_techniques_and_mass_analyzers`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical mechanisms of molecular ionization and mass-to-charge ($m/z$) separation: compare **Hard Ionization (Electron Ionization EI at 70 eV)** with **Soft Ionization (Electrospray Ionization ESI, Chemical Ionization CI, MALDI)**, formulate **ESI Multi-Charging Equations ($z = \frac{m_2 - 1}{m_1 - m_2}$)** for large proteins, analyze **Mass Analyzers (Time-of-Flight TOF, Quadrupole Q, Orbitrap, FT-ICR)**, and derive the **Time-of-Flight Equation ($t = L\sqrt{\frac{m}{2 z e V}}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ionization Methods & TOF Physics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Time-of-Flight Flight Time Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mass Spectrometer Component & Operational Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Standard Electron Ionization Filament Energy Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Electrospray Multi-Charge Calculation and Intact Protein Detection Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Ionization Chemistry and Mass Analyzer Physics:
   - **Hard vs Soft Ionization Methods:**
     - **Electron Ionization (EI, 70 eV):** $\text{M} + e^- \to \text{M}^{+\bullet} + 2e^-$ (Excess internal energy induces reproducible fragmentation for NIST library matching).
     - **Electrospray Ionization (ESI, John Fenn Nobel 2002):** Liquid aerosol under high voltage ($3-5\text{ kV}$) creates **multiply charged droplets**, producing intact $[\text{M}+z\text{H}]^{z+}$ ions (Analyzes 100 kDa proteins on standard $m/z \le 2000$ quadrupoles!).
     - **MALDI (Koichi Tanaka Nobel 2002):** UV laser pulse desorbs analyte co-crystallized with organic matrix (predominantly singly charged $[\text{M}+\text{H}]^+$).
   - **Time-of-Flight (TOF) Mass Analyzer:**
     $$q V_{\text{acc}} = \frac{1}{2} m v^2 \implies v = \sqrt{\frac{2 z e V_{\text{acc}}}{m}} \implies t_{\text{flight}} = \frac{L}{v} = L \sqrt{\frac{m}{2 z e V_{\text{acc}}}}$$
     *(Lighter ions travel faster and hit the detector earlier!).*
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Time-of-Flight equation: (1) accelerate gas-phase ion of mass $m$ and charge $q = ze$ across potential difference $V_{\text{acc}}$, (2) equate electrostatic potential energy to kinetic energy: $z e V_{\text{acc}} = \frac{1}{2} m v^2$, (3) solve for ion velocity: $v = \sqrt{\frac{2 z e V_{\text{acc}}}{m}}$, (4) express time of flight $t$ to traverse field-free drift tube of length $L$: $t = \frac{L}{v} = \frac{L}{\sqrt{2 z e V_{\text{acc}} / m}}$, (5) group terms to conclude $t = L \sqrt{\frac{m}{2 z e V_{\text{acc}}}} \propto \sqrt{m/z}$!
3. **Slide 3 (`matching`):** Pair 4 ionization sources (EI, ESI, MALDI, CI) with their primary analytical applications.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that standard Electron Ionization (EI) sources operate at an electron kinetic energy of 70 eV. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing intact protein molecular mass from adjacent ESI multi-charge peaks: An unknown protein gives two adjacent peaks in an ESI mass spectrum at $m/z = 1001.0$ ($m_1$, with charge $z+1$) and $m/z = 1251.0$ ($m_2$, with charge $z$). What is the true molecular mass $M$ of the intact protein? ($M = 5000\text{ Da}$; charge state $z = \frac{m_1 - 1}{m_2 - m_1} = \frac{1001 - 1}{1251 - 1001} = \frac{1000}{250} = 4$. Then $M = z \times m_2 - z \times 1.008 = 4 \times 1251 - 4 = 5004 - 4 = 5000\text{ Da}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ionization_techniques_and_mass_analyzers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Ionization Techniques and Mass Analyzers**\n• **Hard vs Soft Ionization:**\n  - **Electron Ionization (EI, 70 eV):** $\\text{M} + e^- \\to \\text{M}^{+\\bullet} + 2e^-$ (Extensive diagnostic fragmentation).\n  - **Electrospray Ionization (ESI):** Generates **multiply charged** $[\text{M}+z\\text{H}]^{z+}$ ions in liquid stream (allows mega-Dalton proteins on benchtop analyzers!).\n  - **MALDI:** Laser desorption from matrix yields **singly charged** $[\text{M}+\\text{H}]^+$.\n• **Time-of-Flight (TOF) Physics:**\n$$\nz e V_{\\text{acc}} = \\frac{1}{2} m v^2 \\implies t_{\\text{flight}} = L \\sqrt{\\frac{m}{2 z e V_{\\text{acc}}}} \\propto \\sqrt{m/z}\n$$\n  *(Ions with smaller $m/z$ travel faster and strike the microchannel plate detector earlier!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the physical mechanics steps deriving the Time-of-Flight relationship t ∝ sqrt(m/z).",
      "orderItems": [
        "Accelerate an ion of mass m and charge q = z*e through an electrostatic potential difference V_acc",
        "Set electrical potential energy equal to final kinetic energy: z * e * V_acc = (1/2) * m * v^2",
        "Solve for the exit velocity of the ion entering the field-free drift region: v = sqrt(2 * z * e * V_acc / m)",
        "Write the flight time t required to traverse a drift tube of fixed length L: t = L / v",
        "Substitute velocity to establish the fundamental TOF equation: t = L * sqrt(m / [2 * z * e * V_acc])"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ionization technique to its operational feature.",
      "matchPairs": [
        { "left": "Electron Ionization (EI)", "right": "Hard 70 eV electron beam; generates molecular radical cation M+• and extensive structural fragments" },
        { "left": "Electrospray Ionization (ESI)", "right": "Soft atmospheric pressure ionization; produces multiply charged [M+zH]^z+ ions for large biomolecules" },
        { "left": "MALDI", "right": "Soft pulsed UV laser desorption from solid matrix; produces singly charged [M+H]+ ions" },
        { "left": "Chemical Ionization (CI)", "right": "Soft gas-phase proton transfer from ionized methane (CH_5+) yielding intact [M+H]+" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Standard organic Electron Ionization (EI) mass spectrometry operates using an electron beam kinetic energy of ___ eV.",
      "blankAnswer": "70",
      "blankDistractors": ["10", "100", "25"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An intact protein gives two adjacent peaks in an ESI mass spectrum at m/z = 1001.0 (charge z+1) and m/z = 1251.0 (charge z). What is the true molecular mass of the protein?",
      "options": [
        { "text": "5000 Da; charge state is z = (1001 - 1) / (1251 - 1001) = 1000 / 250 = +4, giving true neutral mass M = 4 * 1251.0 - 4 * 1.008 ≈ 5000 Da", "isCorrect": true, "explanation": "Correct! In ESI, adjacent peaks differ by one proton (charge Delta z = 1). Let m1 = (M + (z+1))/ (z+1) = 1001.0 and m2 = (M + z)/z = 1251.0. Solving for z gives z = (1001 - 1) / (1251 - 1001) = 4. The molecular mass is M = 4*(1251) - 4 = 5000 Da." },
        { "text": "2252 Da (simple sum)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1251 Da", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "10,000 Da", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
