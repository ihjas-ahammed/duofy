# Duofy Reusable Lesson Format: Continuous Reactors (CSTR vs PFR Sizing & Levenspiel Plots)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Reaction_Engineering_CRE / Kinetics_of_Homogeneous_Reactions`  
**Lesson Format Type:** `cstr_vs_pfr_sizing_and_levenspiel_plots`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through steady-state continuous flow reactor design, **Continuous Stirred-Tank Reactors (CSTR / Backmix)**, **Plug Flow Reactors (PFR / Tubular)**, volumetric flow rate ($v_0$), inlet molar feed rate ($F_{A0} = C_{A0} \cdot v_0$), space time ($\tau = V / v_0$), space velocity ($SV = 1 / \tau$), Octave Levenspiel's graphical reactor sizing framework ($F_{A0} / (-r_A)$ plotted against conversion $X$), the mathematical proof that $V_{\text{CSTR}} > V_{\text{PFR}}$ for all positive-order reactions ($n > 0$), and sizing comparison for identical fractional conversions (H. Scott Fogler *Elements of Chemical Reaction Engineering* 5th/6th ed. Chapters 2 & 4; Octave Levenspiel *Chemical Reaction Engineering* Chapters 4 & 5): formulate the **CSTR Design Equation Master Formulation**:
$$\mathbf{V_{\text{CSTR}} = \frac{F_{A0} \cdot X}{-r_{A,\text{exit}}} = \frac{v_0 \left( C_{A0} - C_A \right)}{-r_{A,\text{exit}}} \Longleftrightarrow \mathbf{\tau_{\text{CSTR}} = \frac{V_{\text{CSTR}}}{v_0} = \frac{C_{A0} \cdot X}{-r_{A,\text{exit}}}}}$$
formulate the **PFR Design Equation Master Formulation**:
$$\mathbf{V_{\text{PFR}} = F_{A0} \int_0^X \frac{dX}{-r_A} \Longleftrightarrow \mathbf{\tau_{\text{PFR}} = \frac{V_{\text{PFR}}}{v_0} = C_{A0} \int_0^X \frac{dX}{-r_A}}}$$
master the **Levenspiel Graphical Plot Interpretation**:
- **CSTR Volume:** Exactly equal to the area of the **rectangle** $[X \times \frac{F_{A0}}{-r_{A}(X)}]$;
- **PFR Volume:** Exactly equal to the **area under the curve** of $\frac{F_{A0}}{-r_A}$ from $0$ to $X$;
derive the **First-Order Liquid Reaction ($A \to B, \ -r_A = k C_A$) Volume Ratio**:
$$\mathbf{V_{\text{CSTR}} = \frac{v_0 \cdot X}{k (1 - X)} \quad \Big| \quad \mathbf{V_{\text{PFR}} = \frac{v_0}{k} \ln\left( \frac{1}{1 - X} \right)} \implies \mathbf{\frac{V_{\text{CSTR}}}{V_{\text{PFR}}} = \frac{X}{(1 - X) \ln\left( \frac{1}{1 - X} \right)}}}$$
- At $X = 0.50 \implies \frac{V_{\text{CSTR}}}{V_{\text{PFR}}} = \frac{0.50}{0.50 \ln(2)} = \frac{1}{0.693} = \mathbf{1.44}$;
- At $X = 0.90 \implies \frac{V_{\text{CSTR}}}{V_{\text{PFR}}} = \frac{0.90}{0.10 \ln(10)} = \frac{9.0}{2.303} = \mathbf{3.91}$;
- At $X = 0.99 \implies \frac{V_{\text{CSTR}}}{V_{\text{PFR}}} = \frac{0.99}{0.01 \ln(100)} = \frac{99.0}{4.605} = \mathbf{21.50}$;
(proving that at high conversions, a CSTR requires up to 20 times the volume of a PFR because backmixing dilutes the reactant to its lowest exit concentration).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CSTR ($V = \frac{F_{A0}X}{-r_A}$), PFR ($V = F_{A0}\int_0^X \frac{dX}{-r_A}$) & Levenspiel Graphical Comparison Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Both a CSTR and a PFR for a Specified 90% First-Order Conversion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Continuous Reactor Type / Levenspiel Entity & Technical Flow Characterization Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | On a Levenspiel Plot of $F_{A0}/(-r_A)$ Versus Conversion $X$, the Required Volume of an Ideal Plug Flow Reactor Equals the Area ___ the Curve from 0 to X (Under / Below / Beneath) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Continuous Reactor Design Problem: Sizing CSTR vs PFR Volumes for a 90% Liquid Conversion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CSTR vs PFR & Levenspiel Plots (Levenspiel 1972; Fogler 2016):
   - **Continuous Reactor Formulations:**
     $$\mathbf{V_{\text{CSTR}} = \frac{F_{A0} X}{-r_{A,\text{exit}}} \quad \Big| \quad V_{\text{PFR}} = F_{A0} \int_0^X \frac{dX}{-r_A} \quad \Big| \quad \tau = \frac{V}{v_0} \quad \Big| \quad \frac{V_{\text{CSTR}}}{V_{\text{PFR}}} = \frac{X}{(1-X)\ln(1/(1-X))}}$$
   - **CSTR vs PFR Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Reactor Type} & \textbf{Mixing & Fluid Dynamics} & \textbf{Levenspiel Sizing Area} & \textbf{Volume Relative to PFR } (n > 0) \\
     \hline
     \mathbf{\text{CSTR (Backmix)}} & \text{Perfect uniform mixing throughout} & \mathbf{\text{Bounding Rectangle Area }} [X \cdot \frac{F_{A0}}{-r_A}] & \mathbf{V_{\text{CSTR}} > V_{\text{PFR}} \ (3\times \text{ to } 20\times \text{ larger at high } X)} \\
     \mathbf{\text{PFR (Tubular)}} & \text{Zero axial mixing, plug flow} & \mathbf{\text{Area Under the Curve }} \int_0^X \frac{F_{A0}}{-r_A} dX & \mathbf{V_{\text{PFR}} < V_{\text{CSTR}} \ (\text{Smallest footprint for } n>0)} \\
     \hline
     \end{array}$$
   - **The Backmixing Dilution Invariant:** In a CSTR, incoming feed is **instantaneously diluted to the exit concentration $C_{A,\text{exit}}$**; because positive-order reactions slow down at low concentrations, the entire CSTR operates at the slowest possible rate!
2. **Slide 2 (`ordering`):** Provide 5 steps of CSTR vs PFR sizing: (1) determine feed volumetric flow rate $v_0$, inlet concentration $C_{A0}$, and rate constant $k$, (2) calculate inlet molar flow rate: $F_{A0} = C_{A0} \cdot v_0$, (3) determine exit rate $-r_A(X) = k C_{A0}(1 - X)$ at target conversion $X$, (4) calculate CSTR volume: $V_{\text{CSTR}} = \frac{F_{A0} X}{-r_A(X)}$, (5) evaluate PFR volume: $V_{\text{PFR}} = \frac{v_0}{k} \ln\left(\frac{1}{1-X}\right)$ and compare space times $\tau_{\text{CSTR}}$ vs $\tau_{\text{PFR}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (CSTR Design Equation, PFR Design Equation, Levenspiel Rectangle Area, Space Time $\tau$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Under (or Below / Beneath). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing CSTR vs PFR: A first-order liquid reaction $A \to B$ ($-r_A = k C_A$) has $k = 0.100\text{ min}^{-1}$. Feed enters at $v_0 = 10.0\text{ L/min}$ with $C_{A0} = 2.0\text{ mol/L}$ ($F_{A0} = 20.0\text{ mol/min}$). Target conversion is $X = 0.900$ ($90.0\%$). Given $\ln\left(\frac{1}{1 - 0.90}\right) = \ln(10.0) = 2.3026$.
   - CSTR sizing:
     - Exit concentration: $C_{A,\text{exit}} = C_{A0}(1 - X) = 2.0 \times 0.10 = \mathbf{0.20\text{ mol/L}}$;
     - Exit reaction rate: $-r_{A,\text{exit}} = k C_{A,\text{exit}} = 0.100 \times 0.20 = \mathbf{0.020\text{ mol/L}\cdot\text{min}}$;
     - CSTR volume: $V_{\text{CSTR}} = \frac{F_{A0} X}{-r_{A,\text{exit}}} = \frac{20.0 \times 0.90}{0.020} = \frac{18.0}{0.020} = \mathbf{900.0\text{ L}}$;
     - CSTR space time: $\tau_{\text{CSTR}} = \frac{V_{\text{CSTR}}}{v_0} = \frac{900.0}{10.0} = \mathbf{90.0\text{ min}}$;
   - PFR sizing:
     - PFR volume: $V_{\text{PFR}} = \frac{v_0}{k} \ln\left(\frac{1}{1 - X}\right) = \frac{10.0}{0.100} \times 2.3026 = 100.0 \times 2.3026 = \mathbf{230.26\text{ L} \approx 230.3\text{ L}}$;
     - PFR space time: $\tau_{\text{PFR}} = \frac{230.26}{10.0} = \mathbf{23.03\text{ min}}$;
   - What are the required reactor volumes $V_{\text{CSTR}}$ and $V_{\text{PFR}}$? ($V_{\text{CSTR}} = \mathbf{900\text{ L}}$ and $V_{\text{PFR}} = \mathbf{230.3\text{ L}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cstr_vs_pfr_sizing_and_levenspiel_plots",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Continuous Reactor Sizing \\& Levenspiel Plots (Octave Levenspiel)**\n• **Continuous Stirred-Tank Reactor (CSTR) Design Formulation:**\n$$\n\\mathbf{V_{\\text{CSTR}} = \\frac{F_{A0} \\cdot X}{-r_{A,\\text{exit}}} = \\frac{v_0 \\left( C_{A0} - C_A \\right)}{-r_{A,\\text{exit}}} \\Longleftrightarrow \\mathbf{\\tau_{\\text{CSTR}} = \\frac{C_{A0} \\cdot X}{-r_{A,\\text{exit}}}}}\n$$\n• **Plug Flow Reactor (PFR) Design Formulation:**\n$$\n\\mathbf{V_{\\text{PFR}} = F_{A0} \\int_0^X \\frac{dX}{-r_A} \\Longleftrightarrow \\mathbf{\\tau_{\\text{PFR}} = C_{A0} \\int_0^X \\frac{dX}{-r_A}}}\n$$\n• **Levenspiel Graphical Plot Interpretation ($F_{A0}/(-r_A)$ vs $X$):**\n  - **CSTR Volume:** Sized by the outer bounding **rectangle area** ($X \\times \\frac{F_{A0}}{-r_{A,\\text{exit}}}$);\n  - **PFR Volume:** Sized by the **area under the curve** ($\\int_0^X \\frac{F_{A0}}{-r_A} dX$);\n• **The Backmix Penalty Invariant:** For all positive reaction orders ($n > 0$), **$V_{\\text{CSTR}} > V_{\\text{PFR}}$ for identical conversion**; at $90\\%$ conversion, a CSTR requires $\\approx 3.91\\times$ the volume of a PFR due to exit concentration dilution!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size both a CSTR and a PFR for a target 90% first-order liquid-phase conversion.",
      "orderItems": [
        "Determine inlet volumetric flow rate v0, initial reactant concentration CA0, and reaction rate constant k",
        "Calculate inlet molar flow rate: FA0 = CA0 * v0 and exit reactant concentration: CA_exit = CA0 * (1 - X)",
        "Evaluate the exit reaction rate: -rA(X) = k * CA_exit",
        "Calculate the required CSTR volume from the algebraic mole balance: V_CSTR = (FA0 * X) / -rA(X)",
        "Calculate the required PFR volume from the integral mole balance: V_PFR = (v0 / k) * ln[ 1 / (1 - X) ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Continuous Reactor Sizing Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "CSTR Design Equation", "right": "V = FA0*X / -rA_exit, algebraic mole balance where the entire tank operates at lowest exit reaction rate" },
        { "left": "PFR Design Equation", "right": "V = FA0 \u222b [1 / -rA] dX, differential tubular mole balance where reaction rate decreases along reactor length" },
        { "left": "Space Time (\u03c4 = V / v0)", "right": "Time necessary to process one reactor volume of fluid at entering volumetric flow conditions" },
        { "left": "Levenspiel Rectangle", "right": "Graphical representation of CSTR volume on a plot of FA0 / (-rA) versus conversion X" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "On a Levenspiel plot of FA0/(-rA) versus conversion X, the required volume of an ideal plug flow reactor equals the area ___ the curve from 0 to X.",
      "blankAnswer": "under",
      "blankDistractors": ["above", "outside", "around"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 1st-order liquid reaction (-rA = k*CA) has k = 0.100 min^-1, v0 = 10.0 L/min, and CA0 = 2.0 mol/L (FA0 = 20.0 mol/min). For target conversion X = 0.900 (CA_exit = 0.20 mol/L, -rA_exit = 0.020 mol/L*min; ln(1/(1-0.90)) = ln10 = 2.3026), what are the required volumes V_CSTR and V_PFR?",
      "options": [
        { "text": "V_CSTR = 900.0 L and V_PFR = 230.3 L (V_CSTR = (20.0 * 0.90) / 0.020 = 18.0 / 0.020 = 900.0 L; V_PFR = (10.0 / 0.100) * 2.3026 = 100.0 * 2.3026 = 230.26 L \u2248 230.3 L)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the CSTR and PFR design equations (H. Scott Fogler *Elements of Chemical Reaction Engineering* Chapter 2 & 4; Octave Levenspiel *Chemical Reaction Engineering* Chapter 4 & 5). 1. **Identify Operating \\& Kinetic Parameters:** - Volumetric flow rate: $v_0 = 10.0\\text{ L/min}$. - Inlet concentration: $C_{A0} = 2.0\\text{ mol/L}$. - Inlet molar feed rate: $$F_{A0} = C_{A0} \\cdot v_0 = 2.0\\text{ mol/L} \\times 10.0\\text{ L/min} = \\mathbf{20.0\\text{ mol/min}}$$ - First-order rate constant: $k = 0.100\\text{ min}^{-1}$. - Target conversion: $X = 0.900$. 2. **Calculate CSTR Volume ($V_{\\text{CSTR}}$):** - Exit reactant concentration: $$C_{A,\\text{exit}} = C_{A0} (1 - X) = 2.0\\text{ mol/L} \\times (1 - 0.900) = \\mathbf{0.20\\text{ mol/L}}$$ - Reaction rate at exit: $$-r_{A,\\text{exit}} = k \\cdot C_{A,\\text{exit}} = 0.100\\text{ min}^{-1} \\times 0.20\\text{ mol/L} = \\mathbf{0.020\\text{ mol/L}\\cdot\\text{min}}$$ - CSTR algebraic mole balance: $$V_{\\text{CSTR}} = \\frac{F_{A0} \\cdot X}{-r_{A,\\text{exit}}} = \\frac{20.0\\text{ mol/min} \\times 0.900}{0.020\\text{ mol/L}\\cdot\\text{min}} = \\frac{18.0}{0.020} = \\mathbf{900.0\\text{ Liters}}$$ - CSTR space time: $\\tau_{\\text{CSTR}} = \\frac{900.0\\text{ L}}{10.0\\text{ L/min}} = \\mathbf{90.0\\text{ min}}$. 3. **Calculate PFR Volume ($V_{\\text{PFR}}$):** - PFR integral mole balance for first-order reaction: $$V_{\\text{PFR}} = \\frac{v_0}{k} \\ln\\left( \\frac{1}{1 - X} \\right) = \\frac{10.0\\text{ L/min}}{0.100\\text{ min}^{-1}} \\times \\ln(10.00)$$ $$V_{\\text{PFR}} = 100.0\\text{ L} \\times 2.302585 = \\mathbf{230.26\\text{ Liters} \\approx 230.3\\text{ Liters}}$$ - PFR space time: $\\tau_{\\text{PFR}} = \\frac{230.26\\text{ L}}{10.0\\text{ L/min}} = \\mathbf{23.03\\text{ min}}$. 4. **Volume Ratio Comparison:** - Ratio: $\\frac{V_{\\text{CSTR}}}{V_{\\text{PFR}}} = \\frac{900.0\\text{ L}}{230.26\\text{ L}} = \\mathbf{3.909 \\approx 3.91}$. The CSTR requires nearly $4\\times$ the volume of the PFR! Flawless continuous reactor sizing and Levenspiel derivation!" },
        { "text": "V_CSTR = 900.0 L and V_PFR = 900.0 L", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V_CSTR = 230.3 L and V_PFR = 900.0 L (Inverted the reactor volumes)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V_CSTR = 1800.0 L and V_PFR = 460.5 L", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
