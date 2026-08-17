# Duofy Reusable Lesson Format: Minor Losses (Fittings, Valves, & Hydraulic Diameter)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Laminar_and_Turbulent_Pipe_Flow`  
**Lesson Format Type:** `minor_losses_in_piping_systems_and_hydraulic_diameter`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through localized head losses in pipe components, flow separation eddies, equivalent length methods, and non-circular duct geometries in hydraulic engineering (Frank M. White *Fluid Mechanics* Chapter 6; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 8): master **Minor Head Loss Formulations ($\mathbf{h_m = K_L \frac{V^2}{2g}}$)** where $K_L$ is the minor loss coefficient, analyze classic piping components: **1. Pipe Entrances** (Sharp-edged $K_L = 0.50$, Re-entrant Borda $K_L = 0.80$, Well-rounded $K_L = 0.04$), **2. Pipe Exits** ($K_L = 1.0$ for all geometries as kinetic velocity head is completely dissipated in the reservoir), **3. Sudden Expansions & Contractions** (Borda-Carnot expansion loss $\mathbf{h_m = \frac{(V_1 - V_2)^2}{2g} = \left(1 - \frac{A_1}{A_2}\right)^2 \frac{V_1^2}{2g}}$), **4. Equivalent Length Formulation ($\mathbf{L_{\text{eq}} = \frac{K_L D}{f}}$)**, and master the **Hydraulic Diameter Concept ($\mathbf{D_h = \frac{4 A_c}{P_{\text{wetted}}}}$)** for rectangular HVAC ducts ($a \times b \implies D_h = \frac{2ab}{a+b}$) and concentric annular channels ($D_o, D_i \implies D_h = D_o - D_i$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Minor Loss Formula ($h_m = K_L \frac{V^2}{2g}$) & Hydraulic Diameter ($D_h = \frac{4A}{P_{\text{wetted}}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Total Head Loss (Major + Minor) in a Pumping Pipe System Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Piping Component / Minor Loss Coefficient $K_L$ & Flow Separation Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Characteristic Dimension Used to Analyze Non-Circular Ducts in Fluid Mechanics Is the ___ Diameter (Hydraulic / Dh) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydraulic Engineering Problem: Calculating the Minor Head Loss in a Sudden Pipe Expansion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Minor Losses & Hydraulic Diameter (White 2016; Munson 2016):
   - **Minor Loss Formulations:**
     $$\mathbf{h_{\text{minor}} = \sum K_L \frac{V^2}{2g} \quad \Big| \quad L_{\text{eq}} = \frac{K_L D}{f} \quad \Big| \quad D_h = \frac{4 A_c}{P_{\text{wetted}}}}$$
   - **Component Loss Coefficients ($K_L$) Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Piping Component / Fitting} & \textbf{Loss Coeff } K_L & \textbf{Physical Flow Mechanism} \\
     \hline
     \mathbf{\text{Pipe Exit into Tank (All shapes)}} & \mathbf{K_L = 1.0} & \mathbf{\text{100\% of kinetic energy } V^2/2g \text{ dissipated as heat}} \\
     \mathbf{\text{Re-entrant Pipe Inlet (Borda)}} & K_L = 0.80 & \text{Severe vena contracta flow separation} \\
     \mathbf{\text{Sharp-Edged Pipe Inlet}} & K_L = 0.50 & \text{Moderate vena contracta separation} \\
     \mathbf{\text{Well-Rounded Bellmouth Inlet}} & \mathbf{K_L = 0.04} & \mathbf{\text{Smooth streamline guidance; separation avoided}} \\
     \mathbf{\text{Sudden Expansion (Borda-Carnot)}} & \mathbf{K_L = \left(1 - \frac{A_1}{A_2}\right)^2} & \text{Turbulent deceleration eddy dissipation} \\
     \hline
     \end{array}$$
   - **Hydraulic Diameter Invariant:** For non-circular ducts, replace $D$ with $D_h = \frac{4 A_c}{P_{\text{wetted}}}$ in all Reynolds number and Darcy-Weisbach calculations!
2. **Slide 2 (`ordering`):** Provide 5 steps of total head loss calculation: (1) determine flow velocity $V$ from discharge $Q$ and pipe diameter $D$, (2) compute major friction factor $f$ and major head loss $h_f = f \frac{L}{D} \frac{V^2}{2g}$, (3) identify all fittings, elbows, valves, entrances, and exits, tabulating their loss coefficients $K_L$, (4) compute total minor head loss $h_m = (\sum K_L) \frac{V^2}{2g}$, (5) sum major and minor head losses $h_{L,\text{total}} = h_f + h_m$ to determine required pump head $H_{\text{pump}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Pipe Exit $K_L=1.0$, Well-Rounded Inlet $K_L=0.04$, Equivalent Length $L_{\text{eq}}$, Hydraulic Diameter $D_h$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Hydraulic. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating sudden expansion loss: Water flows at $V_1 = 6.0\text{ m/s}$ in a pipe of cross-sectional area $A_1 = 0.01\text{ m}^2$ before suddenly expanding into a larger pipe of area $A_2 = 0.02\text{ m}^2$ ($g = 9.81\text{ m/s}^2$). Using the Borda-Carnot equation, what is the minor head loss $h_m$ caused by this sudden expansion? ($K_L = \left(1 - \frac{A_1}{A_2}\right)^2 = \left(1 - \frac{0.01}{0.02}\right)^2 = (1 - 0.5)^2 = (0.5)^2 = \mathbf{0.25}$; $h_m = K_L \frac{V_1^2}{2g} = 0.25 \frac{(6.0\text{ m/s})^2}{2(9.81\text{ m/s}^2)} = 0.25 \frac{36}{19.62} = \frac{9.0}{19.62} \approx \mathbf{0.459\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "minor_losses_in_piping_systems_and_hydraulic_diameter",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Minor Head Losses \\& Hydraulic Diameter (Frank M. White)**\n• **Minor Head Loss \\& Equivalent Length Formulations:**\n$$\n\\mathbf{h_{\\text{minor}} = \\sum K_L \\frac{V^2}{2g} \\quad \\Big| \\quad L_{\\text{eq}} = \\frac{K_L D}{f} \\quad \\Big| \\quad D_h = \\frac{4 A_c}{P_{\\text{wetted}}}}\n$$\n• **Piping Fitting Loss Coefficient (K_L) Matrix:**\n$$\n\\begin{array}{|l|c|l|}\n\\hline\n\\textbf{Piping Component / Fitting} & \\textbf{Loss Factor } K_L & \\textbf{Fluid Mechanics Cause} \\\\\n\\hline\n\\mathbf{\\text{Submerged Pipe Exit (All)}} & \\mathbf{K_L = 1.0} & \\mathbf{\\text{100\\% of kinetic velocity head } V^2/2g \\text{ is lost to heat}} \\\\\n\\mathbf{\\text{Re-entrant Borda Inlet}} & K_L = 0.80 & \\text{Extreme flow separation at sharp re-entrant edges} \\\\\n\\mathbf{\\text{Sharp-Edged Inlet}} & K_L = 0.50 & \\text{Moderate vena contracta flow separation} \\\\\n\\mathbf{\\text{Well-Rounded Bellmouth}} & \\mathbf{K_L = 0.04} & \\mathbf{\\text{Streamlined guidance (Eliminates separation!)}} \\\\\n\\mathbf{\\text{Sudden Expansion (Borda-Carnot)}} & \\mathbf{K_L = \\left(1 - \\frac{A_1}{A_2}\\right)^2} & \\text{Violent turbulent eddy dissipation during expansion} \\\\\n\\hline\n\\end{array}\n$$\n• **Hydraulic Diameter Invariant:** For non-circular ducts (rectangular HVAC, annular concentric pipes), replace pipe diameter with $\\mathbf{D_h = \\frac{4 A_c}{P_{\\text{wetted}}}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the total head loss (Major + Minor) through a complex industrial piping network.",
      "orderItems": [
        "Compute average fluid flow velocity V from the pipeline volumetric discharge rate Q and cross-sectional area A",
        "Calculate the Reynolds number Re and determine the Darcy friction factor f from the Moody diagram or Colebrook equation",
        "Evaluate the major frictional head loss along all straight pipe runs using h_f = f * (L / D) * (V^2 / 2g)",
        "Identify all fittings, valves, bends, and inlets, summing their minor loss coefficients: sum K_L",
        "Sum major and minor losses: h_L_total = h_f + (sum K_L) * (V^2 / 2g) to determine total pump delivery head"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Minor Loss / Duct Geometry Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Pipe Exit Loss (K_L = 1.0)", "right": "Total dissipation of fluid kinetic energy into turbulent thermal eddies upon entering a reservoir" },
        { "left": "Well-Rounded Inlet (K_L = 0.04)", "right": "Bellmouth geometry that virtually eliminates vena contracta separation and minor head loss" },
        { "left": "Borda-Carnot Expansion Loss", "right": "h_m = (V1 - V2)^2 / (2g), modeling head loss across an abrupt cross-sectional area increase" },
        { "left": "Hydraulic Diameter (D_h)", "right": "D_h = 4 * Area / Wetted_Perimeter, enabling circular pipe correlations to be used on non-circular ducts" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The characteristic equivalent dimension used to analyze fluid flow in non-circular ducts is the ___ diameter.",
      "blankAnswer": "hydraulic",
      "blankDistractors": ["geometric", "mean", "viscous"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Water flows at velocity V1 = 6.0 m/s through a pipe of area A1 = 0.01 m^2 before suddenly expanding into a larger pipe of area A2 = 0.02 m^2 (g = 9.81 m/s^2). Using the Borda-Carnot sudden expansion formula, what is the minor head loss h_m caused by this expansion?",
      "options": [
        { "text": "h_m = 0.459 m (K_L = 0.25 and h_m = K_L * V1^2 / (2g))", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Borda-Carnot sudden expansion formula (Frank M. White *Fluid Mechanics* Chapter 6). 1. **Calculate Minor Loss Coefficient ($K_L$):** For a sudden pipe expansion: $$K_L = \\left(1 - \\frac{A_1}{A_2}\\right)^2 = \\left(1 - \\frac{0.01\\text{ m}^2}{0.02\\text{ m}^2}\\right)^2 = (1 - 0.5)^2 = (0.5)^2 = \\mathbf{0.25}$$ 2. **Calculate Minor Head Loss ($h_m$):** $$h_m = K_L \\frac{V_1^2}{2g} = (0.25) \\frac{(6.0\\text{ m/s})^2}{2(9.81\\text{ m/s}^2)} = (0.25) \\frac{36}{19.62} = \\frac{9.0}{19.62} \\approx \\mathbf{0.4587\\text{ m} \\approx 0.459\\text{ m}}$$ 3. **Verification via Velocity Difference ($V_2 = 3.0\\text{ m/s}$ from continuity):** $$h_m = \\frac{(V_1 - V_2)^2}{2g} = \\frac{(6.0 - 3.0)^2}{2(9.81)} = \\frac{3.0^2}{19.62} = \\frac{9.0}{19.62} = \\mathbf{0.459\\text{ m}}$$ Exact and flawless match!" },
        { "text": "h_m = 1.835 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "h_m = 0.917 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "h_m = 0.115 m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
