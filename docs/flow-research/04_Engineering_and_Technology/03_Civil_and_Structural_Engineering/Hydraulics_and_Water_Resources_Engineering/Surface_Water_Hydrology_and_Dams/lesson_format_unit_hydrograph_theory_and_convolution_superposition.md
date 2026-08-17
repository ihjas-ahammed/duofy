# Duofy Reusable Lesson Format: Surface Hydrology (Unit Hydrographs & Convolution)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Surface_Water_Hydrology_and_Dams`  
**Lesson Format Type:** `unit_hydrograph_theory_and_convolution_superposition`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through LeRoy Sherman's 1932 **Unit Hydrograph (UH) Theory**, the fundamental principles of **Linearity (Proportional Scaling)** and **Time-Invariance**, baseflow separation, calculating effective rainfall excess ($P_{\text{eff}}$), discrete linear convolution to synthesize direct runoff hydrographs (DRH) for multi-period storms, S-Curve summation techniques for duration adjustment, and adding constant baseflow to predict peak river flood stage (Ven Te Chow, David R. Maidment, Larry W. Mays *Applied Hydrology* Chapters 7 & 8; Warren Viessman *Introduction to Hydrology* Chapter 6): formulate the **Discrete Linear Convolution Equation**:
$$\mathbf{Q_n = \sum_{m=1}^M P_m \cdot U_{n - m + 1} \quad \left(\text{Total River Hydrograph: } Q_{\text{total},n} = Q_n + Q_{\text{base}}\right)}$$
where:
1. **$U_k$:** Ordinates of the $D$-hour Unit Hydrograph ($1.0\text{ cm}$ or $1.0\text{ in}$ unit response in $\text{m}^3\text{/s}$);
2. **$P_m$:** Effective excess rainfall depth occurring in time interval $m$ ($\text{cm}$ or $\text{in}$);
3. **$M$:** Total number of rainfall pulses in the storm hyetograph;
4. **$K$:** Number of ordinates in the Unit Hydrograph (Total hydrograph duration: $N = M + K - 1$);
master the **Sherman Hydrologic Invariants**:
- **Proportionality:** An excess rainfall of $2.5\text{ cm}$ produces a direct runoff hydrograph with ordinates exactly $2.5\times$ those of the $1\text{-cm}$ Unit Hydrograph;
- **Superposition:** Runoff responses from sequential rainfall bursts add linearly after appropriate time-lagging ($D, 2D, 3D, \dots$);
(proving how unit hydrographs transform complex meteorological rainstorm events into deterministic catchment runoff hydrographs).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Unit Hydrograph Principles (Linearity, Time-Invariance), Convolution ($Q_n = \sum P_m U_{n-m+1}$) & Baseflow Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Convolve a 2-Period Storm with a 2-Hour Unit Hydrograph Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydrologic Term / Operation & Technical Mathematical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | By Definition, a Unit Hydrograph Represents the Direct Surface Runoff Resulting from Exactly ___ Unit of Effective Excess Rainfall (One / 1.0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Watershed Engineering Problem: Computing the Peak Flood Discharge for a 2-Burst Storm via Convolution Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Unit Hydrograph & Convolution (Sherman 1932; Chow 1988):
   - **Convolution & Superposition Formulations:**
     $$\mathbf{Q_n = \sum_{m=1}^M P_m \cdot U_{n - m + 1} \quad \Big| \quad Q_{\text{total}}(t) = Q_{\text{DRH}}(t) + Q_{\text{baseflow}} \quad \Big| \quad N_{\text{ordinates}} = M + K - 1}$$
   - **Unit Hydrograph Core Axioms Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Fundamental Axiom} & \textbf{Mathematical Definition} & \textbf{Physical Hydrologic Meaning} \\
     \hline
     \mathbf{\text{Linear Proportionality}} & \mathbf{Q(t) = P_{\text{eff}} \cdot U(t)} & \text{Doubling rainfall depth doubles runoff discharge at every point} \\
     \mathbf{\text{Time Invariance}} & U(t - \tau) \text{ is identical at all times} & \text{Catchment drainage response does not change with seasons/dates} \\
     \mathbf{\text{Linear Superposition}} & Q(t) = \sum Q_i(t - t_i) & \text{Sequential rain bursts accumulate independently without interference} \\
     \hline
     \end{array}$$
   - **The Volume Invariant:** The area under the Unit Hydrograph curve multiplied by $\Delta t$ is **strictly equal to $1.0\text{ cm} \times A_{\text{catchment}}$**, preserving total hydrologic mass balance!
2. **Slide 2 (`ordering`):** Provide 5 steps of rainfall-runoff convolution: (1) obtain the $D$-hour Unit Hydrograph ordinates $U = [U_1, U_2, \dots, U_K]$, (2) extract the effective rainfall excess depths $P_1, P_2, \dots, P_M$ from the storm hyetograph, (3) multiply the unit hydrograph by $P_1$ for the first burst: $Q_1(t) = P_1 \cdot U(t)$, (4) multiply by $P_2$ and lag by duration $D$: $Q_2(t) = P_2 \cdot U(t - D)$, (5) sum the overlapping columns and add constant baseflow to obtain the total river hydrograph!
3. **Slide 3 (`matching`):** Pair 4 concepts (Unit Hydrograph, Effective Rainfall Excess, S-Curve Method, Baseflow Separation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of One (or 1.0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on convolving a 2-burst storm: A 2-hour Unit Hydrograph has ordinates: $U = [0, 10, 30, 20, 10, 0]\text{ m}^3\text{/s}$ at $t = 0, 2, 4, 6, 8, 10\text{ hours}$. A 4-hour storm produces two successive 2-hour excess rainfall bursts: $P_1 = 2.0\text{ cm}$ in hours $0-2$, and $P_2 = 3.0\text{ cm}$ in hours $2-4$. The baseflow is a constant $Q_{\text{base}} = 5.0\text{ m}^3\text{/s}$.
   - Direct runoff from Burst 1 ($P_1 = 2.0\text{ cm}$ at $t = 0, 2, 4, 6, 8, 10$):
     $Q_1 = [0, 20, 60, 40, 20, 0]\text{ m}^3\text{/s}$;
   - Direct runoff from Burst 2 ($P_2 = 3.0\text{ cm}$ lagged by $2\text{ hr}$, at $t = 2, 4, 6, 8, 10, 12$):
     $Q_2 = [0, 30, 90, 60, 30, 0]\text{ m}^3\text{/s}$;
   - Combined DRH at $t = 4\text{ hr}$: $Q_{\text{DRH}}(4) = 60 + 30 = \mathbf{90\text{ m}^3\text{/s}}$;
   - Combined DRH at $t = 6\text{ hr}$: $Q_{\text{DRH}}(6) = 40 + 90 = \mathbf{130\text{ m}^3\text{/s}}$ (Peak DRH);
   - Total river peak discharge at $t = 6\text{ hr}$: $Q_{\text{total}} = 130 + 5.0 = \mathbf{135.0\text{ m}^3\text{/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "unit_hydrograph_theory_and_convolution_superposition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Unit Hydrograph Theory \\& Linear Convolution (LeRoy Sherman)**\n• **Discrete Linear Convolution Formulation:**\n$$\n\\mathbf{Q_n = \\sum_{m=1}^M P_m \\cdot U_{n - m + 1} \\quad \\Big| \\quad \\mathbf{Q_{\\text{total}}(t) = Q_{\\text{DRH}}(t) + Q_{\\text{baseflow}}}}\n$$\n  - **$U_k$:** Ordinates of the $D$-hour Unit Hydrograph ($1.0\\text{ cm}$ unit depth response in $\\text{m}^3\\text{/s}$);\n  - **$P_m$:** Effective excess rainfall depth in time block $m$ ($\\text{cm}$);\n• **The Sherman Axioms of Catchment Response:**\n  - **Linear Proportionality:** Runoff discharge scales linearly with excess precipitation ($\\mathbf{Q = P \\cdot U}$);\n  - **Time Invariance:** Watershed runoff signature is constant over time;\n  - **Superposition:** Successive rainfall bursts add linearly when time-lagged by multiples of $D$;\n• **The Mass Balance Invariant:** Total volume under the Unit Hydrograph strictly equals $\\mathbf{1.0\\text{ cm} \\times A_{\\text{watershed}}}$, guaranteeing exact conservation of water volume!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the total streamflow hydrograph resulting from a multi-burst storm event using convolution.",
      "orderItems": [
        "Determine the D-hour Unit Hydrograph ordinates (U) and separate constant baseflow from the total river hydrograph",
        "Extract the effective excess rainfall depths (P1, P2, ..., PM) for each consecutive D-hour storm interval",
        "Scale the Unit Hydrograph by P1 to compute the direct runoff hydrograph for the first storm burst: Q1(t) = P1 * U(t)",
        "Scale the Unit Hydrograph by P2, P3, ... and shift them in time by increments of D hours: Q2(t) = P2 * U(t - D)",
        "Sum all overlapping direct runoff hydrograph ordinates column-by-column and add constant baseflow to obtain total flood discharge"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Surface Hydrology Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Unit Hydrograph (UH)", "right": "Direct runoff hydrograph resulting from exactly 1.0 unit (1 cm or 1 in) of uniform excess rainfall over duration D" },
        { "left": "Effective Rainfall Excess (P_eff)", "right": "Total precipitation minus abstraction losses (infiltration, depression storage, interception) causing direct runoff" },
        { "left": "S-Curve Hydrograph", "right": "Continuous summation hydrograph used to convert a Unit Hydrograph of duration D1 to a new duration D2" },
        { "left": "Baseflow Separation", "right": "Isolating sustained groundwater seepage contribution from total recorded streamflow hydrographs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By definition, a Unit Hydrograph represents the direct surface runoff resulting from exactly ___ unit of effective excess rainfall.",
      "blankAnswer": "one",
      "blankDistractors": ["two", "ten", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-hr Unit Hydrograph has ordinates: U = [0, 10, 30, 20, 10, 0] m^3/s at t = 0, 2, 4, 6, 8, 10 hrs. A storm produces P1 = 2.0 cm (hrs 0-2) and P2 = 3.0 cm (hrs 2-4). Baseflow is constant at Q_base = 5.0 m^3/s. What is the peak direct runoff discharge (Q_DRH) and the total river peak discharge (Q_total) occurring at t = 6 hrs?",
      "options": [
        { "text": "Q_DRH = 130.0 m^3/s and Q_total = 135.0 m^3/s at t = 6 hrs (At t = 6 hrs: Q1 = P1*U(6) = 2.0 * 20 = 40 m^3/s; Q2 = P2*U(4) = 3.0 * 30 = 90 m^3/s; Q_DRH = 40 + 90 = 130 m^3/s; Q_total = 130 + 5.0 = 135.0 m^3/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Sherman's discrete linear convolution formula (Ven Te Chow *Applied Hydrology* Chapter 7). 1. **Tabulate Ordinates for Burst 1 ($P_1 = 2.0\\text{ cm}$ starting at $t = 0\\text{ hr}$):** - $Q_1(0) = 2.0 \\times 0 = 0\\text{ m}^3\\text{/s}$ - $Q_1(2) = 2.0 \\times 10 = 20\\text{ m}^3\\text{/s}$ - $Q_1(4) = 2.0 \\times 30 = 60\\text{ m}^3\\text{/s}$ - $Q_1(6) = 2.0 \\times 20 = \\mathbf{40\\text{ m}^3\\text{/s}}$ - $Q_1(8) = 2.0 \\times 10 = 20\\text{ m}^3\\text{/s}$ - $Q_1(10) = 2.0 \\times 0 = 0\\text{ m}^3\\text{/s}$ 2. **Tabulate Ordinates for Burst 2 ($P_2 = 3.0\\text{ cm}$ lagged by $2\\text{ hr}$):** - $Q_2(2) = 3.0 \\times 0 = 0\\text{ m}^3\\text{/s}$ - $Q_2(4) = 3.0 \\times 10 = 30\\text{ m}^3\\text{/s}$ - $Q_2(6) = 3.0 \\times 30 = \\mathbf{90\\text{ m}^3\\text{/s}}$ - $Q_2(8) = 3.0 \\times 20 = 60\\text{ m}^3\\text{/s}$ - $Q_2(10) = 3.0 \\times 10 = 30\\text{ m}^3\\text{/s}$ - $Q_2(12) = 3.0 \\times 0 = 0\\text{ m}^3\\text{/s}$ 3. **Calculate Combined Direct Runoff at Peak ($t = 6\\text{ hr}$):** $$Q_{\\text{DRH}}(6) = Q_1(6) + Q_2(6) = 40.0\\text{ m}^3\\text{/s} + 90.0\\text{ m}^3\\text{/s} = \\mathbf{130.0\\text{ m}^3\\text{/s}}$$ 4. **Calculate Total River Flood Peak (Including Baseflow):** $$Q_{\\text{total}}(6) = Q_{\\text{DRH}}(6) + Q_{\\text{base}} = 130.0\\text{ m}^3\\text{/s} + 5.0\\text{ m}^3\\text{/s} = \\mathbf{135.0\\text{ m}^3\\text{/s}}$$ Flawless unit hydrograph convolution and superposition calculation!" },
        { "text": "Q_DRH = 90.0 m^3/s and Q_total = 95.0 m^3/s (Calculated at t = 4 hrs)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Q_DRH = 150.0 m^3/s and Q_total = 155.0 m^3/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Q_DRH = 130.0 m^3/s and Q_total = 130.0 m^3/s (Forgot baseflow)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
