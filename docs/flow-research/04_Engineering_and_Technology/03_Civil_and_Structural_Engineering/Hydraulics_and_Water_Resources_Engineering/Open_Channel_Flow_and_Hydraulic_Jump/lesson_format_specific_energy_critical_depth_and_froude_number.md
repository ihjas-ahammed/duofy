# Duofy Reusable Lesson Format: Specific Energy (Critical Flow & Froude Dynamics)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Open_Channel_Flow_and_Hydraulic_Jump`  
**Lesson Format Type:** `specific_energy_critical_depth_and_froude_number`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Boris A. Bakhmeteff's concept of **Specific Energy ($E$)**, the $E - y$ curve with subcritical and supercritical alternate depths, the **Froude Number ($\text{Fr}$)**, critical flow conditions where specific energy is minimized ($\frac{dE}{dy} = 0$), critical flow depth ($y_c$), critical velocity ($V_c = \sqrt{g y_c}$), and channel transitions (bed raises $\Delta z$ and width contractions $\Delta b$) (Ven Te Chow *Open-Channel Hydraulics* Chapter 3; Terry W. Sturm *Open Channel Hydraulics* Chapter 3): formulate the **Specific Energy Formulation (Rectangular Channel)**:
$$\mathbf{E = y + \frac{V^2}{2g} = y + \frac{q^2}{2g y^2} \quad \left(q = \frac{Q}{b} = \text{Unit Discharge in } \text{m}^2\text{/s}\right)}$$
derive the **Critical Flow Conditions ($\frac{dE}{dy} = 1 - \frac{q^2}{g y^3} = 0 \implies \text{Fr} = 1.0$)**:
$$\mathbf{y_c = \sqrt[3]{\frac{q^2}{g}} \quad \Big| \quad \mathbf{V_c = \sqrt{g y_c}} \quad \Big| \quad \mathbf{E_{\text{min}} = y_c + \frac{V_c^2}{2g} = y_c + \frac{y_c}{2} = \frac{3}{2} y_c = 1.5 y_c}}$$
derive the **Froude Number Flow Regimes**:
$$\mathbf{\text{Fr} = \frac{V}{\sqrt{g D_h}} = \frac{V}{\sqrt{g (A/T)}}}$$
1. **$\mathbf{\text{Fr} < 1.0}$ (Subcritical Flow):** $y > y_c, V < V_c$; Tranquil deep flow governed by downstream controls; surface gravity waves travel upstream ($c = \sqrt{gy} > V$);
2. **$\mathbf{\text{Fr} = 1.0}$ (Critical Flow):** $y = y_c, E = E_{\text{min}}$; Maximum discharge for a given energy;
3. **$\mathbf{\text{Fr} > 1.0}$ (Supercritical Flow):** $y < y_c, V > V_c$; Rapid shallow flow governed by upstream controls; waves swept downstream;
(proving that at critical flow, exactly one-third of the total specific energy is kinetic velocity head $V^2/2g = y_c/2$ and two-thirds is potential depth $y_c$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Specific Energy ($E = y + \frac{q^2}{2gy^2}$), Critical State ($y_c = \sqrt[3]{q^2/g}, E_{\text{min}} = 1.5 y_c$) & $\text{Fr} = \frac{V}{\sqrt{gy}}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Critical Depth and Alternate Depths for a Rectangular Channel Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Flow Regime / Energy Parameter & Technical Hydraulic Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Rectangular Open Channel at Critical Flow, the Minimum Specific Energy $E_{\text{min}}$ Is Mathematically Equal to ___ Times the Critical Depth $y_c$ (1.5 / Three-Halves) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydraulic Engineering Problem: Calculating Critical Depth y_c, Froude Number, and Flow State for a Rectangular Canal Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Specific Energy & Critical Flow (Bakhmeteff 1932; Chow 1959):
   - **Energy & Critical Formulations:**
     $$\mathbf{E = y + \frac{q^2}{2gy^2} \quad \Big| \quad y_c = \left(\frac{q^2}{g}\right)^{1/3} \quad \Big| \quad E_{\text{min}} = \frac{3}{2} y_c \quad \Big| \quad \text{Fr} = \frac{V}{\sqrt{gy}} = \frac{q}{\sqrt{g y^3}}}$$
   - **Flow Regime Classification Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Flow Regime} & \textbf{Froude Number } \text{Fr} & \textbf{Water Depth } y & \textbf{Flow Velocity } V & \textbf{Wave Propagation Behavior} \\
     \hline
     \mathbf{\text{Subcritical (Tranquil)}} & \mathbf{\text{Fr} < 1.0} & \mathbf{y > y_c} & V < V_c & \mathbf{\text{Gravity ripples can travel upstream }} (c > V) \\
     \mathbf{\text{Critical State}} & \mathbf{\text{Fr} = 1.0} & \mathbf{y = y_c} & \mathbf{V = V_c = \sqrt{g y_c}} & \mathbf{\text{Minimum energy }} E_{\text{min}} = 1.5 y_c \text{ (standing waves)} \\
     \mathbf{\text{Supercritical (Shooting)}} & \mathbf{\text{Fr} > 1.0} & \mathbf{y < y_c} & V > V_c & \text{Disturbances swept downstream } (V > c) \\
     \hline
     \end{array}$$
   - **The Kinetic Ratio Invariant:** At the critical point ($E_{\text{min}}$), the velocity head is **strictly equal to half the water depth: $\frac{V_c^2}{2g} = \frac{y_c}{2}$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of critical flow calculation: (1) determine total discharge $Q$ and channel width $b$ to find unit discharge $q = Q/b$, (2) compute critical flow depth $y_c = (q^2 / g)^{1/3}$, (3) compute minimum specific energy $E_{\text{min}} = 1.5 y_c$, (4) calculate actual flow velocity $V = q / y$ and evaluate Froude number $\text{Fr} = V / \sqrt{g y}$, (5) compare actual depth $y$ against $y_c$ to classify the flow regime as subcritical ($\text{Fr} < 1$) or supercritical ($\text{Fr} > 1$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Subcritical Flow $\text{Fr} < 1$, Critical Depth $y_c$, Supercritical Flow $\text{Fr} > 1$, Minimum Energy $1.5 y_c$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 1.5 (or Three-Halves). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on critical flow and Froude number: A rectangular channel of width $b = 5.0\text{ m}$ carries a discharge $Q = 20.0\text{ m}^3\text{/s}$ ($q = 20.0 / 5.0 = 4.0\text{ m}^2\text{/s}, g = 9.81\text{ m/s}^2$). The actual measured flow depth in the channel is $y = 0.80\text{ m}$.
   - Critical depth: $y_c = \left(\frac{q^2}{g}\right)^{1/3} = \left(\frac{4.0^2}{9.81}\right)^{1/3} = \left(\frac{16.0}{9.81}\right)^{1/3} = (1.63099)^{1/3} = \mathbf{1.177\text{ m} \approx 1.18\text{ m}}$;
   - Minimum energy: $E_{\text{min}} = 1.5 y_c = 1.5 \times 1.177 = \mathbf{1.766\text{ m}}$;
   - Actual velocity: $V = \frac{q}{y} = \frac{4.0}{0.80} = \mathbf{5.00\text{ m/s}}$;
   - Froude number: $\text{Fr} = \frac{V}{\sqrt{g y}} = \frac{5.00}{\sqrt{9.81 \times 0.80}} = \frac{5.00}{\sqrt{7.848}} = \frac{5.00}{2.8014} = \mathbf{1.785 \approx 1.78} > 1.0$;
   - Flow classification: Since $y = 0.80\text{ m} < y_c = 1.18\text{ m}$ and $\text{Fr} = 1.78 > 1.0$, the flow is **Supercritical (Shooting)**.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "specific_energy_critical_depth_and_froude_number",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Specific Energy \\& Critical Flow Dynamics (Boris Bakhmeteff)**\n• **Specific Energy Formulation ($E$):**\n$$\n\\mathbf{E = y + \\frac{V^2}{2g} = y + \\frac{q^2}{2g y^2} \\quad \\left(q = \\frac{Q}{b} = \\text{Unit Discharge in } \\text{m}^2\\text{/s}\\right)}\n$$\n• **Critical Flow State ($\\frac{dE}{dy} = 0 \\implies \\mathbf{\\text{Fr} = 1.0}$):**\n$$\n\\mathbf{y_c = \\sqrt[3]{\\frac{q^2}{g}} \\quad \\Big| \\quad \\mathbf{V_c = \\sqrt{g y_c}} \\quad \\Big| \\quad \\mathbf{E_{\\text{min}} = \\frac{3}{2} y_c = 1.5 y_c}}\n$$\n• **Froude Number Flow Regime Classifications:**\n  - **Subcritical Flow ($\\mathbf{\\text{Fr} < 1.0}$):** $y > y_c, \\ V < V_c$; Tranquil deep flow governed by downstream controls;\n  - **Critical Flow ($\\mathbf{\\text{Fr} = 1.0}$):** $y = y_c, \\ E = E_{\\text{min}}$; Minimum energy per unit discharge;\n  - **Supercritical Flow ($\\mathbf{\\text{Fr} > 1.0}$):** $y < y_c, \\ V > V_c$; Rapid shallow flow governed by upstream controls;\n• **The Velocity Head Ratio:** At the critical point, kinetic energy equals half potential energy: $\\mathbf{\\frac{V_c^2}{2g} = \\frac{y_c}{2}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate critical flow depth, minimum specific energy, and determine the Froude number regime.",
      "orderItems": [
        "Calculate the unit discharge: q = Q / b by dividing total volumetric flow rate by rectangular channel width",
        "Compute the critical flow depth: yc = (q^2 / g)^(1/3) and minimum specific energy: E_min = 1.5 * yc",
        "Determine actual flow velocity: V = q / y for the observed flow depth y in the channel",
        "Calculate the dimensionless Froude number: Fr = V / \u221a(g * y)",
        "Classify the hydraulic flow regime as Subcritical (Fr < 1, y > yc) or Supercritical (Fr > 1, y < yc)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Specific Energy Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Critical Depth (yc = (q^2/g)^(1/3))", "right": "Water depth at which a given discharge passes with absolute minimum specific energy (Fr = 1.0)" },
        { "left": "Minimum Energy (E_min = 1.5*yc)", "right": "Total minimum energy head where 2/3 is potential depth yc and 1/3 is velocity head (yc/2)" },
        { "left": "Subcritical Flow (Fr < 1)", "right": "Deep, tranquil flow regime where surface gravity waves travel upstream against the current" },
        { "left": "Supercritical Flow (Fr > 1)", "right": "Shallow, shooting flow regime where velocity exceeds wave speed (V > \u221a(gy)), sweeping ripples downstream" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a rectangular open channel at critical flow, the minimum specific energy E_min is mathematically equal to ___ times the critical depth yc.",
      "blankAnswer": "1.5",
      "blankDistractors": ["1.0", "2.0", "0.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular canal (b = 5.0 m, g = 9.81 m/s^2) carries discharge Q = 20.0 m^3/s (q = 4.0 m^2/s). Observed depth is y = 0.80 m. What is the critical depth yc, the Froude number Fr, and the flow regime?",
      "options": [
        { "text": "yc = 1.18 m, Fr = 1.78, and Supercritical Flow (yc = (4^2 / 9.81)^(1/3) = (1.631)^(1/3) = 1.177 m; V = 4.0 / 0.80 = 5.0 m/s; Fr = 5.0 / \u221a(9.81 * 0.80) = 5.0 / 2.801 = 1.785 > 1.0; since y = 0.80 < yc = 1.18, flow is supercritical)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using open channel specific energy and Froude mechanics (Ven Te Chow *Open-Channel Hydraulics* Chapter 3). 1. **Calculate Unit Discharge ($q$):** $$q = \\frac{Q}{b} = \\frac{20.0\\text{ m}^3\\text{/s}}{5.0\\text{ m}} = \\mathbf{4.00\\text{ m}^2\\text{/s}}$$ 2. **Calculate Critical Flow Depth ($y_c$):** $$y_c = \\sqrt[3]{\\frac{q^2}{g}} = \\sqrt[3]{\\frac{(4.00)^2}{9.81\\text{ m/s}^2}} = \\sqrt[3]{\\frac{16.00}{9.81}} = \\sqrt[3]{1.630989} = \\mathbf{1.1771\\text{ m} \\approx 1.18\\text{ m}}$$ - Minimum specific energy: $$E_{\\text{min}} = 1.5 \\cdot y_c = 1.5 \\times 1.1771\\text{ m} = \\mathbf{1.7656\\text{ m}}$$ 3. **Calculate Actual Flow Velocity ($V$):** $$V = \\frac{q}{y} = \\frac{4.00\\text{ m}^2\\text{/s}}{0.80\\text{ m}} = \\mathbf{5.00\\text{ m/s}}$$ 4. **Calculate Froude Number ($\\text{Fr}$):** - Surface wave propagation speed: $$c = \\sqrt{g \\cdot y} = \\sqrt{9.81\\text{ m/s}^2 \\times 0.80\\text{ m}} = \\sqrt{7.848} = \\mathbf{2.8014\\text{ m/s}}$$ - Froude number: $$\\text{Fr} = \\frac{V}{\\sqrt{g \\cdot y}} = \\frac{5.00\\text{ m/s}}{2.8014\\text{ m/s}} = \\mathbf{1.7848 \\approx 1.78}$$ 5. **Classify Hydraulic Flow Regime:** - Because $\\text{Fr} = 1.78 > 1.00$ and actual depth $y = 0.80\\text{ m} < y_c = 1.18\\text{ m}$, the flow is **Supercritical (Rapid / Shooting)**! Flawless critical flow and Froude number derivation!" },
        { "text": "yc = 1.18 m, Fr = 0.56, and Subcritical Flow", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "yc = 0.80 m, Fr = 1.00, and Critical Flow", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "yc = 2.00 m, Fr = 2.50, and Supercritical Flow", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
