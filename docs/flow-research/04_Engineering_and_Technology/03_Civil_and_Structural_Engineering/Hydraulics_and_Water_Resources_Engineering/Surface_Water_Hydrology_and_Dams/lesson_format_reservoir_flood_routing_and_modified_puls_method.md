# Duofy Reusable Lesson Format: Reservoir Routing (Modified Puls & Storage Indication)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Surface_Water_Hydrology_and_Dams`  
**Lesson Format Type:** `reservoir_flood_routing_and_modified_puls_method`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through level-pool reservoir flood routing, the hydrologic continuity equation, peak attenuation, hydrograph lag time, and the **Modified Puls (Storage Indication) Method** used to calculate the outflow hydrograph and peak reservoir water surface elevation during a major flood (Ven Te Chow, David R. Maidment, Larry W. Mays *Applied Hydrology* Chapter 8; Warren Viessman *Introduction to Hydrology* Chapter 8): formulate the **Modified Puls Continuity Equation**:
$$\mathbf{\frac{I_1 + I_2}{2} - \frac{O_1 + O_2}{2} = \frac{S_2 - S_1}{\Delta t}}$$
rearrange into the **Storage Indication Master Formulation**:
$$\mathbf{\left( \frac{2 S_2}{\Delta t} + O_2 \right) = \left( I_1 + I_2 \right) + \left( \frac{2 S_1}{\Delta t} - O_1 \right)}$$
where:
1. **$I_1, I_2$:** Known inflow hydrograph rates at time step $t_1$ and $t_2$;
2. **$O_1, O_2$:** Outflow discharge rates through the spillway and low-level outlets;
3. **$S_1, S_2$:** Water storage volume in the reservoir pool;
4. **$\frac{2 S}{\Delta t} + O$:** Storage Indication Function tabulated against outflow $O$;
derive the **Outflow Calculation Step**:
$$\mathbf{\left( \frac{2 S_1}{\Delta t} - O_1 \right) = \left( \frac{2 S_1}{\Delta t} + O_1 \right) - 2 O_1}$$
(proving that when the reservoir outflow hydrograph reaches its peak $O_{\text{peak}}$, the outflow curve intersects the inflow hydrograph: $I(t_{\text{peak}}) = O(t_{\text{peak}})$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Modified Puls Routing Equation ($\left(\frac{2S_2}{\Delta t}+O_2\right) = (I_1+I_2) + (\frac{2S_1}{\Delta t}-O_1)$) & Storage Curve Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Route a Flood Inflow Hydrograph Through a Reservoir Using Modified Puls Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Reservoir Routing Entity / Curve & Technical Hydrologic Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Level-Pool Reservoir Flood Routing, the Maximum Peak Outflow Occurs Exactly at the Time Instant When Outflow Rate $O$ Equals the Inflow Rate ___ (I / Inflow) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydraulic Engineering Problem: Computing the Storage Indication Value and Outflow O_2 for Time Step 1 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Modified Puls Method (Chow 1988; Viessman 2003):
   - **Modified Puls & Storage Formulations:**
     $$\mathbf{\left( \frac{2 S_2}{\Delta t} + O_2 \right) = \left( I_1 + I_2 \right) + \left( \frac{2 S_1}{\Delta t} - O_1 \right) \quad \Big| \quad \left(\frac{2S}{\Delta t} - O\right) = \left(\frac{2S}{\Delta t} + O\right) - 2 O}$$
   - **Routing Curve Relationship Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Physical Variable} & \textbf{Functional Dependency} & \textbf{Hydrologic Purpose} \\
     \hline
     \mathbf{\text{Water Surface Elevation } h} & \text{Topographic contour survey} & \text{Independent physical state variable} \\
     \mathbf{\text{Reservoir Storage } S(h)} & \text{Integrated bathymetry volume } (\text{m}^3) & \text{Quantifies total water retention} \\
     \mathbf{\text{Spillway Outflow } O(h)} & O = C_d L H^{3/2} \ (\text{Spillway rating}) & \text{Relates head to discharge capacity} \\
     \mathbf{\text{Storage Indication } \frac{2S}{\Delta t} + O} & \text{Pre-computed vs } O \text{ table} & \mathbf{\text{Converts continuity PDE into algebraic lookup}} \\
     \hline
     \end{array}$$
   - **The Peak Intersection Invariant:** At the moment of peak reservoir outflow ($dO/dt = 0$), water surface elevation and storage are at their maximum ($dS/dt = 0$), enforcing **$I(t) = O(t)$** (the outflow hydrograph peak lies directly on the receding limb of the inflow hydrograph)!
2. **Slide 2 (`ordering`):** Provide 5 steps of Modified Puls routing: (1) construct the reservoir stage-storage-discharge table and compute the Storage Indication column $\frac{2S}{\Delta t} + O$ vs $O$, (2) initialize with initial inflow $I_1$, outflow $O_1$, and storage value $\frac{2S_1}{\Delta t} - O_1 = \left(\frac{2S_1}{\Delta t} + O_1\right) - 2O_1$, (3) compute inflow sum $(I_1 + I_2)$ for the current time step $\Delta t$, (4) calculate the target value: $\left(\frac{2S_2}{\Delta t} + O_2\right) = (I_1 + I_2) + \left(\frac{2S_1}{\Delta t} - O_1\right)$, (5) look up the corresponding outflow $O_2$ from the Storage Indication curve and compute $\left(\frac{2S_2}{\Delta t} - O_2\right)$ to advance to the next step!
3. **Slide 3 (`matching`):** Pair 4 concepts (Storage Indication Function, Peak Attenuation, Hydrograph Lag Time, Inflow-Outflow Equality at Peak) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of I (or Inflow). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating routing step: A reservoir flood routing calculation uses time step $\Delta t = 1.0\text{ hour} = 3600\text{ s}$. At $t_1 = 0$, inflow is $I_1 = 20.0\text{ m}^3\text{/s}$, outflow is $O_1 = 20.0\text{ m}^3\text{/s}$, and $\frac{2S_1}{\Delta t} + O_1 = 220.0\text{ m}^3\text{/s}$. At $t_2 = 1.0\text{ hr}$, the inflow jumps to $I_2 = 80.0\text{ m}^3\text{/s}$. The reservoir's pre-calibrated rating relationship is $O = 0.10 \times \left(\frac{2S}{\Delta t} + O\right) - 2.0$.
   - Previous term: $\frac{2S_1}{\Delta t} - O_1 = \left(\frac{2S_1}{\Delta t} + O_1\right) - 2 O_1 = 220.0 - 2(20.0) = \mathbf{180.0\text{ m}^3\text{/s}}$;
   - Inflow sum: $I_1 + I_2 = 20.0 + 80.0 = \mathbf{100.0\text{ m}^3\text{/s}}$;
   - Next Storage Indication value: $\frac{2S_2}{\Delta t} + O_2 = (I_1 + I_2) + \left(\frac{2S_1}{\Delta t} - O_1\right) = 100.0 + 180.0 = \mathbf{280.0\text{ m}^3\text{/s}}$;
   - Next outflow: $O_2 = 0.10 \times (280.0) - 2.0 = 28.0 - 2.0 = \mathbf{26.0\text{ m}^3\text{/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reservoir_flood_routing_and_modified_puls_method",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Reservoir Flood Routing \\& Modified Puls Method (Chow \\& Mays)**\n• **Hydrologic Continuity Routing Equation:**\n$$\n\\mathbf{\\frac{I_1 + I_2}{2} - \\frac{O_1 + O_2}{2} = \\frac{S_2 - S_1}{\\Delta t}}\n$$\n• **Modified Puls Storage Indication Formulation:**\n$$\n\\mathbf{\\left( \\frac{2 S_2}{\\Delta t} + O_2 \\right) = \\left( I_1 + I_2 \\right) + \\left( \\frac{2 S_1}{\\Delta t} - O_1 \\right)}\n$$\n  - **$\\left(\\frac{2S_1}{\\Delta t} - O_1\\right)$:** Evaluated as $\\mathbf{\\left(\\frac{2S_1}{\\Delta t} + O_1\\right) - 2 O_1}$;\n• **Spillway Rating Function:** $O = C_d \\cdot L \\cdot H^{3/2}$;\n• **The Peak Outflow Intersection Invariant:** When the reservoir outflow reaches its absolute maximum ($dO/dt = 0$), storage is maximized ($dS/dt = 0$), which enforces that **Outflow strictly equals Inflow: $\\mathbf{O_{\\text{peak}} = I(t_{\\text{peak}})}$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to execute a level-pool reservoir flood routing analysis using the Modified Puls Method.",
      "orderItems": [
        "Construct the elevation-storage (S) and elevation-outflow (O) curves to build a table of (2S/\u0394t + O) versus O",
        "Initialize the routing table at time t1 with initial inflow I1, outflow O1, and compute (2S1/\u0394t - O1) = (2S1/\u0394t + O1) - 2*O1",
        "Sum the inflow hydrograph values over the time step: (I1 + I2)",
        "Calculate the new storage indication value: (2S2/\u0394t + O2) = (I1 + I2) + (2S1/\u0394t - O1)",
        "Look up the corresponding outflow O2 from the pre-computed storage indication curve and advance to the next time interval"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reservoir Routing Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Storage Indication (2S/\u0394t + O)", "right": "Pre-tabulated composite parameter converting non-linear differential storage into an algebraic lookup" },
        { "left": "Peak Flood Attenuation", "right": "Reduction in maximum peak outflow discharge compared to peak inflow caused by temporary reservoir retention" },
        { "left": "Hydrograph Lag Time", "right": "Time delay between the peak of the inflow hydrograph and the peak of the outflow hydrograph" },
        { "left": "Spillway Rating Curve", "right": "O = Cd*L*H^(3/2), hydraulic relationship linking reservoir head above crest to spillway discharge" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In level-pool reservoir flood routing, the maximum peak outflow occurs exactly at the time instant when outflow rate O equals the inflow rate ___.",
      "blankAnswer": "I",
      "blankDistractors": ["S", "H", "Cd"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a flood routing step (\u0394t = 1 hr), I1 = 20.0 m^3/s, O1 = 20.0 m^3/s, and (2S1/\u0394t + O1) = 220.0 m^3/s. Next inflow is I2 = 80.0 m^3/s. The storage indication relationship is O = 0.10*(2S/\u0394t + O) - 2.0. What is the value of (2S2/\u0394t + O2) and the new outflow discharge O2?",
      "options": [
        { "text": "(2S2/\u0394t + O2) = 280.0 m^3/s and O2 = 26.0 m^3/s ((2S1/\u0394t - O1) = 220 - 2(20) = 180 m^3/s; (2S2/\u0394t + O2) = (20 + 80) + 180 = 280.0 m^3/s; O2 = 0.10 * 280.0 - 2.0 = 28.0 - 2.0 = 26.0 m^3/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Modified Puls storage indication method (Ven Te Chow *Applied Hydrology* Chapter 8). 1. **Calculate the Previous Subtracted Storage Indication Term:** $$\\left(\\frac{2S_1}{\\Delta t} - O_1\\right) = \\left(\\frac{2S_1}{\\Delta t} + O_1\\right) - 2 O_1 = 220.0\\text{ m}^3\\text{/s} - 2(20.0\\text{ m}^3\\text{/s}) = 220.0 - 40.0 = \\mathbf{180.0\\text{ m}^3\\text{/s}}$$ 2. **Calculate Total Inflow Over Time Step $\\Delta t$:** $$I_1 + I_2 = 20.0\\text{ m}^3\\text{/s} + 80.0\\text{ m}^3\\text{/s} = \\mathbf{100.0\\text{ m}^3\\text{/s}}$$ 3. **Calculate New Storage Indication Value $\\left(\\frac{2S_2}{\\Delta t} + O_2\\right)$:** $$\\left(\\frac{2S_2}{\\Delta t} + O_2\\right) = (I_1 + I_2) + \\left(\\frac{2S_1}{\\Delta t} - O_1\\right) = 100.0\\text{ m}^3\\text{/s} + 180.0\\text{ m}^3\\text{/s} = \\mathbf{280.0\\text{ m}^3\\text{/s}}$$ 4. **Look Up New Outflow ($O_2$) via Rating Formula:** $$O_2 = 0.10 \\times \\left(\\frac{2S_2}{\\Delta t} + O_2\\right) - 2.0 = 0.10 \\times (280.0) - 2.0 = 28.0 - 2.0 = \\mathbf{26.0\\text{ m}^3\\text{/s}}$$ 5. **Physical Check:** Inflow spiked from $20$ to $80\\text{ m}^3\\text{/s}$, but outflow only gently increased from $20$ to $26\\text{ m}^3\\text{/s}$, illustrating massive **peak flood attenuation** as the reservoir absorbs excess volume! Flawless Modified Puls routing calculation!" },
        { "text": "(2S2/\u0394t + O2) = 320.0 m^3/s and O2 = 30.0 m^3/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "(2S2/\u0394t + O2) = 280.0 m^3/s and O2 = 28.0 m^3/s (Forgot -2.0 constant)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "(2S2/\u0394t + O2) = 200.0 m^3/s and O2 = 18.0 m^3/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
