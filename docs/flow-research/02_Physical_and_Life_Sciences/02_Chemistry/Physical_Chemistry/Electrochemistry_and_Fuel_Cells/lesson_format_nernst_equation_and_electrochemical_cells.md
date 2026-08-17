# Duofy Reusable Lesson Format: Nernst Equation and Electrochemical Cells

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Electrochemistry_and_Fuel_Cells`  
**Lesson Format Type:** `nernst_equation_and_electrochemical_cells`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic foundation and quantitative calculations of galvanic and concentration cells: derive the **Nernst Equation ($E_{\text{cell}} = E^\circ_{\text{cell}} - \frac{RT}{nF}\ln Q$)** from the fundamental Gibbs free energy relation ($\Delta G = -n F E_{\text{cell}}$), apply the $298.15\text{ K}$ simplified form ($E = E^\circ - \frac{0.05916\text{ V}}{n}\log_{10} Q$), evaluate standard electrode potentials against the **Standard Hydrogen Electrode (SHE, $0.000\text{ V}$)**, calculate equilibrium constants ($K_{\text{eq}} = 10^{\frac{n E^\circ}{0.05916\text{ V}}}$), and analyze concentration cells ($\text{EMF}$ driven purely by concentration gradients, $E^\circ = 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nernst Equation & Cell Thermodynamics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Daniell Galvanic Cell EMF Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Electrochemical Cell Type & Operating Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Universal Faraday Electrochemical Constant Unit Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Standard Daniell Cell Concentration Shift EMF Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Electrochemical Thermodynamics & The Nernst Equation (Walther Nernst, 1889):
   - **Thermodynamic Link:**
     $$\Delta G = -n F E_{\text{cell}}, \qquad \Delta G^\circ = -n F E^\circ_{\text{cell}}$$
     where $n$ is the number of moles of electrons transferred and $F = 96485.3\text{ C/mol}$ is Faraday's constant.
   - **The Nernst Equation:**
     $$E_{\text{cell}} = E^\circ_{\text{cell}} - \frac{RT}{nF} \ln Q = E^\circ_{\text{cell}} - \frac{2.3026 RT}{nF} \log_{10} Q$$
     - At $T = 298.15\text{ K}$ ($25^\circ\text{C}$):
       $$E_{\text{cell}} = E^\circ_{\text{cell}} - \frac{0.05916\text{ V}}{n} \log_{10} Q$$
   - **Equilibrium State ($E_{\text{cell}} = 0, \ Q = K_{\text{eq}}$):**
     $$\log_{10} K_{\text{eq}} = \frac{n E^\circ_{\text{cell}}}{0.05916\text{ V}}$$
   - **Concentration Cells ($E^\circ_{\text{cell}} = 0$):**
     $$E_{\text{cell}} = -\frac{0.05916\text{ V}}{n} \log_{10}\left(\frac{[M^{n+}]_{\text{dilute}}}{[M^{n+}]_{\text{concentrated}}}\right) = \frac{0.05916\text{ V}}{n} \log_{10}\left(\frac{[M^{n+}]_{\text{conc}}}{[M^{n+}]_{\text{dil}}}\right) > 0$$
2. **Slide 2 (`ordering`):** Provide 5 steps calculating the cell potential of a Daniell cell ($\text{Zn}(s) + \text{Cu}^{2+}(aq) \to \text{Zn}^{2+}(aq) + \text{Cu}(s)$) with $[\text{Zn}^{2+}] = 0.001\text{ M}$ and $[\text{Cu}^{2+}] = 1.0\text{ M}$ at $298\text{ K}$: (1) write standard reduction potentials: $E^\circ(\text{Cu}^{2+}/\text{Cu}) = +0.34\text{ V}$ and $E^\circ(\text{Zn}^{2+}/\text{Zn}) = -0.76\text{ V}$, (2) calculate standard cell potential: $E^\circ_{\text{cell}} = E^\circ_{\text{cathode}} - E^\circ_{\text{anode}} = +0.34 - (-0.76) = +1.10\text{ V}$, (3) determine electrons transferred $n = 2$ and write reaction quotient: $Q = \frac{[\text{Zn}^{2+}]}{[\text{Cu}^{2+}]} = \frac{0.001}{1.0} = 10^{-3}$, (4) apply Nernst equation: $E_{\text{cell}} = 1.10\text{ V} - \frac{0.05916}{2} \log_{10}(10^{-3}) = 1.10 - (0.02958)(-3)$, (5) evaluate sum to obtain the enhanced potential: $E_{\text{cell}} = 1.10 + 0.0887 = 1.19\text{ V}$!
3. **Slide 3 (`matching`):** Pair 4 electrochemical cell configurations (Galvanic Daniell Cell, Electrolytic Chlor-Alkali Cell, Concentration Cell, Dead Discharged Battery) with their thermodynamic characteristics ($E_{\text{cell}} > 0 \implies \Delta G < 0$ spontaneous power generation, $E_{\text{applied}} > E_{\text{cell}} \implies \Delta G > 0$ forced non-spontaneous synthesis, $E^\circ = 0$ with $\text{EMF}$ driven purely by entropy of mixing, $E_{\text{cell}} = 0$ with $Q = K_{\text{eq}}$ and $\Delta G = 0$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Faraday's constant represents the electric charge per mole of electrons, measured in coulombs per mole. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on concentration effect on Nernst potential: In a Daniell cell ($\text{Zn} + \text{Cu}^{2+} \to \text{Zn}^{2+} + \text{Cu}, E^\circ = 1.10\text{ V}$), what happens to the cell potential $E_{\text{cell}}$ if the concentration of zinc ions $[\text{Zn}^{2+}]$ is increased tenfold while $[\text{Cu}^{2+}]$ is held constant? (The cell potential **DECREASES by $\approx 0.0296\text{ V}$ ($29.6\text{ mV}$)**; because $\Delta E = -\frac{0.05916\text{ V}}{2}\log_{10}(10) = -0.02958\text{ V}$, increasing the product concentration pushes the reaction quotient $Q$ closer to equilibrium).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nernst_equation_and_electrochemical_cells",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Nernst Equation and Electrochemical Cells**\n• **Thermodynamics of Electromotive Force (EMF):**\n$$\n\\Delta G = -n F E_{\\text{cell}}, \\qquad \\Delta G^\\circ = -n F E^\\circ_{\\text{cell}}\n$$\n  - $F = 96485.3\\text{ C/mol}$ (Faraday's Constant).\n• **The Nernst Equation:**\n$$\nE_{\\text{cell}} = E^\\circ_{\\text{cell}} - \\frac{RT}{nF} \\ln Q = E^\\circ_{\\text{cell}} - \\frac{0.05916\\text{ V}}{n} \\log_{10} Q \\quad (\\text{at } 298.15\\text{ K})\n$$\n• **Chemical Equilibrium ($E_{\\text{cell}} = 0, \\ Q = K_{\\text{eq}}$):**\n$$\n\\log_{10} K_{\\text{eq}} = \\frac{n E^\\circ_{\\text{cell}}}{0.05916\\text{ V}} \\implies K_{\\text{eq}} = 10^{\\frac{n E^\\circ}{0.05916}}\n$$\n• **Concentration Cells ($E^\\circ = 0$):**\n$$\nE_{\\text{cell}} = \\frac{0.05916\\text{ V}}{n} \\log_{10}\\left( \\frac{[M^{n+}]_{\\text{conc}}}{[M^{n+}]_{\\text{dil}}} \\right) > 0\n$$\n  *(Voltage driven purely by entropy of ion dilution!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps calculating the non-standard EMF of a Daniell cell with [Zn²⁺] = 10⁻³ M and [Cu²⁺] = 1.0 M at 298 K.",
      "orderItems": [
        "Identify standard reduction potentials: E°(Cu²⁺/Cu) = +0.34 V (cathode) and E°(Zn²⁺/Zn) = -0.76 V (anode)",
        "Calculate the standard cell potential: E°_cell = E°_cathode - E°_anode = +0.34 - (-0.76) = +1.10 V",
        "Formulate the reaction quotient Q = [Zn²⁺]/[Cu²⁺] = 10⁻³/1.0 = 10⁻³ and identify n = 2 electrons transferred",
        "Apply the Nernst equation at 298 K: E_cell = 1.10 - (0.05916 / 2) * log10(10⁻³)",
        "Evaluate the algebraic product (-0.02958 * -3 = +0.0887 V) to find E_cell = 1.10 + 0.0887 = 1.189 V"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each electrochemical cell category to its thermodynamic property.",
      "matchPairs": [
        { "left": "Galvanic / Voltaic Cell", "right": "E_cell > 0, Delta G < 0 (spontaneous chemical reaction generates electrical work)" },
        { "left": "Electrolytic Cell", "right": "E_applied > E_cell, Delta G > 0 (external electrical energy forces non-spontaneous reaction)" },
        { "left": "Concentration Cell", "right": "E° = 0; voltage generated strictly by concentration gradient (entropy of dilution)" },
        { "left": "Completely Discharged Battery", "right": "E_cell = 0, Q = K_eq, Delta G = 0 (electrochemical system reached thermodynamic dead state)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Faraday's constant represents the total electric charge carried by one mole of electrons, equal to approximately 96,485 ___ per mole.",
      "blankAnswer": "coulombs",
      "blankDistractors": ["amperes", "volts", "joules"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a standard Daniell cell (Zn + Cu²⁺ -> Zn²⁺ + Cu, E° = 1.10 V, n = 2), what is the quantitative effect on the cell voltage if the zinc ion concentration [Zn²⁺] is increased tenfold at 298 K?",
      "options": [
        { "text": "The cell voltage DECREASES by 0.0296 V (29.6 mV); because Zn²⁺ is a product, increasing its concentration increases Q, and by the Nernst equation Delta E = -(0.05916 / 2) * log10(10) = -0.02958 V", "isCorrect": true, "explanation": "Correct! In the Nernst equation E = E° - (0.05916/n) * log10([Zn²⁺]/[Cu²⁺]), increasing the numerator [Zn²⁺] by a factor of 10 increases log10(Q) by +1. For a 2-electron process (n=2), this shifts the potential by -(0.05916/2) * 1 = -0.02958 V (-29.6 mV)." },
        { "text": "The cell voltage increases by 1.10 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The cell voltage drops to 0.00 V immediately", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The cell voltage is unaffected because zinc is a solid", "isCorrect": false, "explanation": "Incorrect: Zn²⁺ is aqueous in the reaction quotient." }
      ]
    }
  ]
}
```
