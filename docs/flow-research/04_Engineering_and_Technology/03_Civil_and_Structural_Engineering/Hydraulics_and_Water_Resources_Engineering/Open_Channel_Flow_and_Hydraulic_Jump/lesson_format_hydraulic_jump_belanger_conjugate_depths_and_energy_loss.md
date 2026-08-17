# Duofy Reusable Lesson Format: Hydraulic Jump (Bélanger Depths & Energy Dissipation)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Open_Channel_Flow_and_Hydraulic_Jump`  
**Lesson Format Type:** `hydraulic_jump_belanger_conjugate_depths_and_energy_loss`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fluid dynamics of the classical **Hydraulic Jump** in rectangular open channels, the abrupt turbulent transition from supercritical flow ($\text{Fr}_1 > 1$) to subcritical flow ($\text{Fr}_2 < 1$), the necessity of using the **Conservation of Linear Momentum** ($M_1 = M_2$) due to internal turbulent energy dissipation, Jean-Baptiste Bélanger's **Conjugate / Sequent Depth Equation**, head loss calculation ($\Delta E$), energy dissipation efficiency, jump length ($L_{\text{jump}} \approx 6(y_2 - y_1)$), and USBR stilling basin design (Ven Te Chow *Open-Channel Hydraulics* Chapter 15; Terry W. Sturm *Open Channel Hydraulics* Chapter 3; Jean-Baptiste Bélanger 1828): formulate the **Bélanger Conjugate Depth Ratio**:
$$\mathbf{\frac{y_2}{y_1} = \frac{1}{2} \left( \sqrt{1 + 8 \text{Fr}_1^2} - 1 \right) \Longleftrightarrow \mathbf{y_2 = \frac{y_1}{2} \left( \sqrt{1 + 8 \text{Fr}_1^2} - 1 \right)}}$$
where:
1. **$y_1$:** Initial upstream supercritical flow depth ($\text{Fr}_1 = \frac{V_1}{\sqrt{g y_1}} > 1.0$);
2. **$y_2$:** Sequent downstream subcritical flow depth ($\text{Fr}_2 = \frac{V_2}{\sqrt{g y_2}} < 1.0$);
derive the **Hydraulic Jump Energy Dissipation Head Loss ($\Delta E$)**:
$$\mathbf{\Delta E = E_1 - E_2 = \frac{(y_2 - y_1)^3}{4 y_1 y_2} \quad [\text{m}]}$$
derive the **Total Dissipated Hydraulic Power ($P_{\text{dissipated}}$)**:
$$\mathbf{P_{\text{dissipated}} = \gamma \cdot Q \cdot \Delta E = \rho \cdot g \cdot Q \cdot \Delta E \quad [\text{kW}]}$$
(proving that because massive turbulent vortices dissipate energy irreversibly, the downstream depth $y_2$ is fundamentally dictated by momentum balance rather than Bernoulli energy conservation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bélanger Equation ($y_2 = \frac{y_1}{2}(\sqrt{1+8\text{Fr}_1^2}-1)$), Head Loss ($\Delta E = \frac{(y_2-y_1)^3}{4y_1y_2}$) & Momentum Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Sequent Depth, Energy Loss, and Dissipated Power Across a Jump Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydraulic Jump Parameter / Characteristic & Technical Fluid Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Conjugate Depth Ratio Across a Hydraulic Jump Is Derived Solely from the Conservation of Linear ___ Rather Than Energy (Momentum / Linear Momentum) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Dam Spillway Problem: Calculating Sequent Depth y_2, Head Loss \Delta E, and Dissipated Power for Fr1 = 4.0 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bélanger Hydraulic Jump Mechanics (Bélanger 1828; Chow 1959):
   - **Jump Formulations:**
     $$\mathbf{\frac{y_2}{y_1} = \frac{1}{2}\left(\sqrt{1 + 8\text{Fr}_1^2} - 1\right) \quad \Big| \quad \Delta E = \frac{(y_2 - y_1)^3}{4 y_1 y_2} \quad \Big| \quad P_{\text{diss}} = \gamma Q \Delta E \quad \Big| \quad M_1 = M_2}$$
   - **Hydraulic Jump Classification Matrix (USBR):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Jump Classification} & \textbf{Upstream Froude } \text{Fr}_1 & \textbf{Energy Loss } \Delta E / E_1 & \textbf{Physical Nature / Stilling Basin} \\
     \hline
     \mathbf{\text{Undular Jump}} & 1.0 < \text{Fr}_1 \le 1.7 & < 5\% & \text{Standing surface waves without true break} \\
     \mathbf{\text{Weak Jump}} & 1.7 < \text{Fr}_1 \le 2.5 & 5\% - 15\% & \text{Small surface rollers; low turbulence} \\
     \mathbf{\text{Oscillating Jump}} & 2.5 < \text{Fr}_1 \le 4.5 & 15\% - 45\% & \text{Pulsating jet; hazardous wave generation} \\
     \mathbf{\text{Steady / Stable Jump}} & \mathbf{4.5 < \text{Fr}_1 \le 9.0} & \mathbf{45\% - 70\%} & \mathbf{\text{Best practical energy dissipator (USBR Type II/III)}} \\
     \mathbf{\text{Strong / Choppy Jump}} & \text{Fr}_1 > 9.0 & > 70\% & \text{Violent turbulent fountain; requires armored basin} \\
     \hline
     \end{array}$$
   - **The Momentum Conservation Invariant:** Because internal viscous friction and roller turbulence dissipate unpredictable amounts of head, the **Momentum Function $M = \frac{q^2}{g y} + \frac{y^2}{2}$ is conserved ($M_1 = M_2$)**, uniquely defining the sequent depth $y_2$!
2. **Slide 2 (`ordering`):** Provide 5 steps of hydraulic jump analysis: (1) measure upstream supercritical depth $y_1$ and calculate upstream velocity $V_1 = q / y_1$, (2) compute upstream Froude number $\text{Fr}_1 = V_1 / \sqrt{g y_1} > 1.0$, (3) apply the Bélanger equation to solve for downstream sequent subcritical depth: $y_2 = \frac{y_1}{2}(\sqrt{1 + 8\text{Fr}_1^2} - 1)$, (4) calculate head loss energy dissipation: $\Delta E = \frac{(y_2 - y_1)^3}{4 y_1 y_2}$, (5) compute dissipated mechanical power: $P = \gamma \cdot Q \cdot \Delta E$ and size stilling basin length: $L_{\text{basin}} \approx 6(y_2 - y_1)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bélanger Equation, Head Loss $\Delta E$, Steady Jump $\text{Fr}_1 = 4.5-9$, Stilling Basin Length $\approx 6(y_2-y_1)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Momentum (or Linear Momentum). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving hydraulic jump: Water flows down a dam spillway chute entering a rectangular stilling basin at supercritical depth $y_1 = 0.50\text{ m}$ with upstream Froude number $\text{Fr}_1 = 4.00$ ($g = 9.81\text{ m/s}^2, \gamma = 9.81\text{ kN/m}^3, Q = 30.0\text{ m}^3\text{/s}$).
   - Conjugate depth ratio: $\frac{y_2}{y_1} = \frac{1}{2}\left(\sqrt{1 + 8(4.0)^2} - 1\right) = \frac{1}{2}(\sqrt{1 + 128} - 1) = \frac{1}{2}(\sqrt{129} - 1) = \frac{1}{2}(11.3578 - 1) = \mathbf{5.1789}$;
   - Sequent depth: $y_2 = 0.50\text{ m} \times 5.1789 = \mathbf{2.589\text{ m} \approx 2.59\text{ m}}$;
   - Depth difference: $y_2 - y_1 = 2.589 - 0.50 = 2.089\text{ m}$;
   - Head loss: $\Delta E = \frac{(y_2 - y_1)^3}{4 y_1 y_2} = \frac{(2.0894)^3}{4 \times 0.50 \times 2.5894} = \frac{9.1221}{5.1789} = \mathbf{1.761\text{ m} \approx 1.76\text{ m}}$;
   - Dissipated power: $P_{\text{diss}} = \gamma \cdot Q \cdot \Delta E = 9.81\text{ kN/m}^3 \times 30.0\text{ m}^3\text{/s} \times 1.7613\text{ m} = 294.3 \times 1.7613 = \mathbf{518.35\text{ kW} \approx 518\text{ kW}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hydraulic_jump_belanger_conjugate_depths_and_energy_loss",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hydraulic Jump Mechanics \\& Bélanger Depths (Jean-Baptiste Bélanger)**\n• **Bélanger Conjugate Depth Ratio Formulation:**\n$$\n\\mathbf{\\frac{y_2}{y_1} = \\frac{1}{2} \\left( \\sqrt{1 + 8 \\text{Fr}_1^2} - 1 \\right) \\Longleftrightarrow \\mathbf{y_2 = \\frac{y_1}{2} \\left( \\sqrt{1 + 8 \\text{Fr}_1^2} - 1 \\right)}}\n$$\n  - **$y_1$:** Upstream initial supercritical flow depth ($\\text{Fr}_1 > 1.0$);\n  - **$y_2$:** Downstream sequent subcritical flow depth ($\\text{Fr}_2 < 1.0$);\n• **Head Loss \\& Energy Dissipation ($\\Delta E$):**\n$$\n\\mathbf{\\Delta E = E_1 - E_2 = \\frac{(y_2 - y_1)^3}{4 y_1 y_2} \\quad [\\text{m}]}\n$$\n• **Dissipated Hydraulic Power Formulation:**\n$$\n\\mathbf{P_{\\text{dissipated}} = \\gamma \\cdot Q \\cdot \\Delta E \\quad [\\text{kW}] \\quad (\\gamma = 9.81\\text{ kN/m}^3)}\n$$\n• **The Momentum Balance Invariant:** Because turbulent eddy collision dissipates immense kinetic energy, the jump's downstream depth $y_2$ is **derived strictly from Conservation of Momentum ($M_1 = M_2$)**, NOT from Bernoulli's energy equation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the conjugate sequent depth, energy dissipation, and power loss across a hydraulic jump.",
      "orderItems": [
        "Measure the upstream supercritical depth y1 and flow velocity V1 entering the apron",
        "Compute the upstream Froude number: Fr1 = V1 / \u221a(g * y1) and verify that Fr1 > 1.0",
        "Apply the Bélanger equation to calculate the downstream subcritical sequent depth: y2 = (y1/2) * (\u221a(1 + 8*Fr1^2) - 1)",
        "Calculate the specific energy head loss dissipated by turbulence: \u0394E = (y2 - y1)^3 / (4 * y1 * y2)",
        "Compute the total dissipated hydraulic power: P = \u03b3 * Q * \u0394E and estimate stilling basin length: L \u2248 6*(y2 - y1)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hydraulic Jump Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bélanger Equation", "right": "y2 = (y1/2)*(\u221a(1+8Fr1^2) - 1), derived from momentum conservation relating conjugate depths" },
        { "left": "Energy Loss (\u0394E)", "right": "\u0394E = (y2 - y1)^3 / (4*y1*y2), head lost as heat and sound through intense roller turbulence" },
        { "left": "Steady Jump (Fr1 = 4.5 to 9.0)", "right": "Optimal engineering regime with 45-70% energy dissipation forming a stable, well-behaved stilling basin" },
        { "left": "Stilling Basin Length (\u2248 6*(y2-y1))", "right": "Required armored concrete apron length to contain the full roller before reaching the erodible riverbed" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The conjugate depth ratio across a hydraulic jump is derived solely from the conservation of linear ___ rather than energy.",
      "blankAnswer": "momentum",
      "blankDistractors": ["energy", "mass", "volume"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A spillway chute discharges into a rectangular basin at supercritical depth y1 = 0.50 m with Froude number Fr1 = 4.00 (g = 9.81 m/s^2, \u03b3 = 9.81 kN/m^3, Q = 30.0 m^3/s). \u221a(1 + 8*16) = \u221a129 = 11.358. What is the downstream sequent depth y2, the head loss \u0394E, and the dissipated power P?",
      "options": [
        { "text": "y2 = 2.59 m, \u0394E = 1.76 m, and P = 518.4 kW (y2/y1 = 0.5*(11.358 - 1) = 5.179 \u2192 y2 = 2.589 m; \u0394E = (2.589 - 0.50)^3 / (4 * 0.50 * 2.589) = (2.089)^3 / 5.179 = 9.122 / 5.179 = 1.761 m; P = 9.81 * 30.0 * 1.761 = 518.35 kW)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Bélanger equation and energy dissipation formulas for hydraulic jumps (Ven Te Chow *Open-Channel Hydraulics* Chapter 15). 1. **Calculate Downstream Sequent Depth ($y_2$) via Bélanger Equation:** - Upstream Froude number: $\\text{Fr}_1 = 4.00$. - Conjugate depth ratio: $$\\frac{y_2}{y_1} = \\frac{1}{2} \\left( \\sqrt{1 + 8 \\text{Fr}_1^2} - 1 \\right) = \\frac{1}{2} \\left( \\sqrt{1 + 8(4.00)^2} - 1 \\right) = \\frac{1}{2} (\\sqrt{129} - 1)$$ $$\\frac{y_2}{y_1} = \\frac{1}{2} (11.35782 - 1) = \\frac{1}{2} (10.35782) = \\mathbf{5.17891}$$ - Downstream depth: $$y_2 = y_1 \\times 5.17891 = 0.50\\text{ m} \\times 5.17891 = \\mathbf{2.58945\\text{ m} \\approx 2.59\\text{ m}}$$ 2. **Calculate Specific Energy Head Loss ($\\Delta E$):** - Height of jump: $$y_2 - y_1 = 2.58945\\text{ m} - 0.50\\text{ m} = \\mathbf{2.08945\\text{ m}}$$ - Energy dissipation equation: $$\\Delta E = \\frac{(y_2 - y_1)^3}{4 y_1 y_2} = \\frac{(2.08945\\text{ m})^3}{4 \\times (0.50\\text{ m}) \\times (2.58945\\text{ m})} = \\frac{9.12214\\text{ m}^3}{5.17890\\text{ m}^2} = \\mathbf{1.76140\\text{ m} \\approx 1.76\\text{ m}}$$ 3. **Calculate Total Dissipated Hydraulic Power ($P_{\\text{dissipated}}$):** $$P_{\\text{dissipated}} = \\gamma \\cdot Q \\cdot \\Delta E = (9.81\\text{ kN/m}^3) \\times (30.0\\text{ m}^3\\text{/s}) \\times 1.76140\\text{ m}$$ $$P_{\\text{dissipated}} = 294.30 \\times 1.76140 = \\mathbf{518.38\\text{ kW} \\approx 518.4\\text{ kW}}$$ 4. **Stilling Basin Length Estimate:** $$L_{\\text{basin}} \\approx 6 \\times (y_2 - y_1) = 6 \\times 2.089\\text{ m} = \\mathbf{12.53\\text{ m}}$$ Flawless hydraulic jump and stilling basin energy dissipation calculation!" },
        { "text": "y2 = 2.59 m, \u0394E = 0.50 m, and P = 147.2 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y2 = 5.18 m, \u0394E = 3.50 m, and P = 1030.0 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y2 = 2.00 m, \u0394E = 1.76 m, and P = 518.4 kW", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
