# Duofy Reusable Lesson Format: Free Radical Polymerization and the Mayo Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Polymer_and_Materials_Chemistry / Polymerization_Mechanisms`  
**Lesson Format Type:** `free_radical_polymerization_and_mayo_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the kinetics, steady-state rate laws, chain transfer mechanisms, and molecular weight control in Free Radical Polymerization (FRP): formulate the elementary steps (**Initiation** $R_i = 2 f k_d [I]$, **Propagation** $R_p = k_p [M][M^\bullet]$, and **Bimolecular Termination** by combination $k_{tc}$ vs disproportionation $k_{td}$ with $R_t = 2 k_t [M^\bullet]^2$), derive the overall steady-state rate of polymerization ($R_p = k_p [M] \sqrt{\frac{f k_d [I]}{k_t}}$), formulate the **Mayo-Walling Equation ($\frac{1}{\bar{X}_n} = \frac{1}{\bar{X}_{n,0}} + C_S \frac{[S]}{[M]} + C_M + C_I \frac{[I]}{[M]}$)**, and extract the **Chain Transfer Constant ($C_S = k_{tr,S}/k_p$)** from linear Mayo plots to control polymer chain length and prevent gel effects (Trommsdorff-Norrish effect).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FRP Kinetics & Mayo Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Free Radical Polymerization Steady-State Rate Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Radical Polymerization Reagent / Step & Kinetic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Chain Transfer Constant Symbol Definition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mayo Equation Chain Transfer Constant Extraction from Slope Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Free Radical Polymerization Kinetics & The Mayo Equation:
   - **Elementary Kinetic Steps:**
     1. **Initiation:** $I \xrightarrow{k_d} 2 R^\bullet \ (\text{efficiency } f), \quad R_i = 2 f k_d [I]$.
     2. **Propagation:** $M_n^\bullet + M \xrightarrow{k_p} M_{n+1}^\bullet, \quad R_p = k_p [M][M^\bullet]$.
     3. **Termination:** $M_n^\bullet + M_m^\bullet \xrightarrow{k_t} \text{Dead Polymer}, \quad R_t = 2 k_t [M^\bullet]^2$.
   - **Steady-State Approximation on Radicals ($R_i = R_t$):**
     $$[M^\bullet] = \sqrt{\frac{f k_d [I]}{k_t}} \implies R_p = k_p [M] \sqrt{\frac{f k_d [I]}{k_t}} \quad (\text{Order: } 1.0 \text{ in } [M], \ 0.5 \text{ in } [I]).$$
   - **The Mayo-Walling Equation (Frank Mayo, 1943):**
     $$\frac{1}{\bar{X}_n} = \frac{1}{\bar{X}_{n,0}} + C_S \frac{[S]}{[M]}$$
     where:
     - $\bar{X}_{n,0}$ is the degree of polymerization in the absence of chain transfer agent/solvent.
     - $C_S = \frac{k_{tr,S}}{k_p}$ is the **Chain Transfer Constant to Solvent/Agent** ($S$).
     - Plotting $\frac{1}{\bar{X}_n}$ vs $\frac{[S]}{[M]}$ yields a straight line with **$\text{Slope} = C_S$** and **$\text{Y-Intercept} = \frac{1}{\bar{X}_{n,0}}$**.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the steady-state rate of free radical polymerization: (1) write the rate of radical initiation $R_i = 2 f k_d [I]$ where $f$ is initiator efficiency, (2) write the rate of bimolecular termination $R_t = 2 k_t [M^\bullet]^2$, (3) invoke the steady-state hypothesis setting the rate of radical initiation equal to the rate of radical termination ($R_i = R_t$), (4) solve algebraically for the steady-state concentration of growing macroradicals: $[M^\bullet] = \sqrt{\frac{f k_d [I]}{k_t}}$, (5) substitute $[M^\bullet]$ into the propagation rate law $R_p = k_p [M][M^\bullet]$ to obtain the classic rate law $R_p = k_p [M] \left(\frac{f k_d [I]}{k_t}\right)^{1/2}$!
3. **Slide 3 (`matching`):** Pair 4 radical polymerization species (AIBN initiator, Dodecyl mercaptan chain transfer agent, Hydroquinone inhibitor, Carbon tetrachloride telogen) with their kinetic functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the ratio of the chain transfer rate constant to the propagation rate constant is termed the chain transfer constant, denoted Cs. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on extracting $C_S$ from a Mayo plot: A polymer chemist polymerizes styrene in the presence of carbon tetrabromide ($\text{CBr}_4$) as a chain transfer agent. A linear Mayo plot of $1/\bar{X}_n$ vs $[\text{CBr}_4]/[\text{Styrene}]$ yields a slope of $2.20$. What does this slope represent? (The slope equals the **Chain Transfer Constant $C_S = k_{tr,S}/k_p = 2.20$**, meaning that a growing polystyrene radical transfers its radical to $\text{CBr}_4$ by abstracting a bromine atom $2.2\times$ faster than it propagates by adding another styrene monomer, rapidly capping chains and lowering molecular weight).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "free_radical_polymerization_and_mayo_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Free Radical Polymerization and the Mayo Equation**\n• **Elementary Steps & Steady-State Rate:**\n  - **Initiation:** $R_i = 2 f k_d [I]$\n  - **Propagation:** $R_p = k_p [M][M^\\bullet]$\n  - **Termination:** $R_t = 2 k_t [M^\\bullet]^2$\n  - **Steady-State ($R_i = R_t$):**\n$$\nR_p = k_p [M] \\sqrt{\\frac{f k_d [I]}{k_t}} \\qquad (1^{\\text{st}}\\text{-Order in } [M], \\ 0.5\\text{-Order in } [I])\n$$\n• **The Mayo Equation (Chain Transfer to Solvent/Agent):**\n$$\n\\frac{1}{\\bar{X}_n} = \\frac{1}{\\bar{X}_{n,0}} + C_S \\frac{[S]}{[M]}\n$$\n  - $C_S = \\frac{k_{tr,S}}{k_p}$ (Chain Transfer Constant).\n  - **Linear Plot ($1/\\bar{X}_n$ vs $[S]/[M]$):** $\\text{Slope} = C_S, \\quad \\text{Intercept} = 1/\\bar{X}_{n,0}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the derivation steps for the steady-state rate of free radical polymerization.",
      "orderItems": [
        "Formulate the rate of primary radical generation from initiator decomposition: R_i = 2 * f * k_d * [I]",
        "Formulate the rate of bimolecular radical termination by combination and disproportionation: R_t = 2 * k_t * [M•]²",
        "Apply the steady-state approximation setting the rate of initiation equal to the rate of termination: R_i = R_t",
        "Solve algebraically for the steady-state propagating radical concentration: [M•] = sqrt(f * k_d * [I] / k_t)",
        "Substitute [M•] into the propagation rate law R_p = k_p * [M] * [M•] to yield: R_p = k_p * [M] * sqrt(f * k_d * [I] / k_t)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each chemical agent in free radical polymerization to its kinetic role.",
      "matchPairs": [
        { "left": "AIBN (Azobisisobutyronitrile)", "right": "Thermal radical initiator (decomposes with loss of N2 gas to generate isobutyronitrile radicals)" },
        { "left": "Alkyl Mercaptans (R-SH / Thiols)", "right": "Potent chain transfer agents (high C_S ~ 1-10; caps growing chains by H-abstraction)" },
        { "left": "Hydroquinone / TEMPO", "right": "Radical scavengers / inhibitors (quenches radicals during induction period)" },
        { "left": "Trommsdorff-Norrish Gel Effect", "right": "Autoacceleration of rate at high conversion due to viscosity suppressing termination (k_t drops)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In polymer kinetics, the ratio of the chain transfer rate constant to the propagation rate constant (k_tr,S / k_p) is called the chain transfer ___ (C_S).",
      "blankAnswer": "constant",
      "blankDistractors": ["order", "fraction", "entropy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a free radical polymerization of styrene, adding carbon tetrabromide (CBr4) yields a linear Mayo plot of (1 / X_n) versus [CBr4]/[Styrene] with a slope of 2.20. What does this slope physically represent?",
      "options": [
        { "text": "The Chain Transfer Constant C_S = k_tr,S / k_p = 2.20; this means that a growing polystyrene radical undergoes chain transfer to CBr4 by abstracting a bromine atom 2.2 times FASTER than it adds another styrene monomer, strongly limiting polymer chain length", "isCorrect": true, "explanation": "Correct! By the Mayo equation 1/X_n = 1/X_n,0 + C_S * ([S]/[M]), the slope of the line is exactly equal to the chain transfer constant C_S = k_tr,S / k_p. A value of C_S = 2.20 indicates very efficient chain transfer (higher than 1.0), meaning radical transfer to the solvent/agent outpaces monomer propagation, making CBr4 an effective molecular weight regulator." },
        { "text": "The activation energy of initiation in kJ/mol", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The density of polystyrene", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The total conversion of monomer to polymer", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
