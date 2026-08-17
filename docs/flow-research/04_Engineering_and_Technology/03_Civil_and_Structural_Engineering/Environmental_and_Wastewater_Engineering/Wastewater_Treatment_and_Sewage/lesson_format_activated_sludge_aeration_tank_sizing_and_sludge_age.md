# Duofy Reusable Lesson Format: Activated Sludge (Bioreactor Sizing & Sludge Age)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Wastewater_Treatment_and_Sewage`  
**Lesson Format Type:** `activated_sludge_aeration_tank_sizing_and_sludge_age`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the biological engineering of the **Completely Mixed Activated Sludge (CMAS)** secondary wastewater treatment process, Jacques Monod microbial substrate growth kinetics, the master design control parameter **Mean Cell Residence Time (MCRT / Sludge Age $\theta_c$)**, the **Food-to-Microorganism Ratio ($F/M$)**, hydraulic retention time ($\theta = V / Q$), Mixed Liquor Suspended Solids ($X = \text{MLSS}$), daily waste activated sludge mass ($Q_w X_w$), and aeration tank volume sizing ($V$) (Metcalf & Eddy *Wastewater Engineering* 5th ed. Chapters 7 & 8; Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 12): formulate the **Mean Cell Residence Time (Sludge Age $\theta_c$) Master Formulation**:
$$\mathbf{\theta_c = \frac{\text{Biomass in Aeration Tank}}{\text{Biomass Lost Daily}} = \frac{V \cdot X}{Q_w \cdot X_w + Q_e \cdot X_e} \approx \frac{V \cdot X}{Q_w \cdot X_w} \quad [\text{days}]}$$
where:
1. **$V$:** Aeration tank volume ($\text{m}^3$);
2. **$X$:** MLSS biomass concentration in aeration tank ($\approx 2000 - 4000\text{ mg/L}$);
3. **$Q_w$:** Waste activated sludge (WAS) flow rate ($\text{m}^3\text{/day}$);
4. **$X_w$:** Underflow sludge concentration from secondary clarifier ($\approx 8000 - 12,000\text{ mg/L}$);
5. **$Q_e, X_e$:** Effluent flow rate and clear effluent suspended solids ($X_e \approx 5 - 15\text{ mg/L}$);
formulate the **Food-to-Microorganism ($F/M$) Loading Ratio**:
$$\mathbf{\frac{F}{M} = \frac{Q \cdot S_0}{V \cdot X} \quad \left[\frac{\text{kg BOD}_5}{\text{kg MLSS}\cdot\text{day}}\right] \quad (\text{Standard Conventional Range: } 0.20 - 0.50)}$$
formulate the **Aeration Tank Volume Sizing ($V$)**:
$$\mathbf{V = \frac{Q \cdot S_0}{X \cdot (F/M)} = \left( \frac{\theta_c \cdot Q \cdot Y (S_0 - S)}{X (1 + k_d \cdot \theta_c)} \right)}$$
(proving that setting sludge age $\theta_c \ge 10\text{ days}$ allows autotrophic nitrifying bacteria with slow growth rates to proliferate without being washed out of the system).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Activated Sludge Mass Balances, Sludge Age ($\theta_c = \frac{VX}{Q_w X_w}$), $F/M = \frac{Q S_0}{V X}$ & Tank Sizing Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Aeration Basin Volume and Calculate Daily Sludge Wasting Rate Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Biological Reactor Parameter / Operational Metric & Technical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In an Activated Sludge Plant, the Food-to-Microorganism Ratio $F/M$ Is Defined as the Daily Mass of Influent $\text{BOD}_5$ Divided by the Total Mass of ___ in the Aeration Tank (MLSS / Biomass) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Wastewater Treatment Problem: Sizing Aeration Tank Volume V and Daily WAS Mass for Target F/M and Sludge Age Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Activated Sludge Bioreactor Mechanics (Monod 1949; Metcalf & Eddy 2014; Davis 2020):
   - **Bioreactor Formulations:**
     $$\mathbf{\theta_c = \frac{V X}{Q_w X_w + Q_e X_e} \quad \Big| \quad \frac{F}{M} = \frac{Q S_0}{V X} \quad \Big| \quad V = \frac{Q S_0}{X (F/M)} \quad \Big| \quad P_x = \frac{V X}{\theta_c} = Q_w X_w}$$
   - **Process Design Parameters Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Activated Sludge System} & \textbf{Sludge Age } \theta_c & \textbf{F/M Ratio } [\text{day}^{-1}] & \textbf{MLSS } X & \textbf{Primary Operational Purpose} \\
     \hline
     \mathbf{\text{High-Rate Conventional}} & 3 - 5\text{ days} & 0.40 - 0.80 & 1500 - 2500\text{ mg/L} & \text{Rapid carbonaceous BOD removal only} \\
     \mathbf{\text{Standard Conventional}} & \mathbf{5 - 12\text{ days}} & \mathbf{0.20 - 0.40} & \mathbf{2000 - 3500\text{ mg/L}} & \mathbf{\text{Complete BOD removal with stable settling}} \\
     \mathbf{\text{Extended Aeration (Nitrifying)}} & \mathbf{15 - 30\text{ days}} & \mathbf{0.05 - 0.15} & \mathbf{3000 - 5000\text{ mg/L}} & \mathbf{\text{Full nitrification + biological nutrient removal (BNR)}} \\
     \hline
     \end{array}$$
   - **The Sludge Age Control Invariant:** Plant operators control the entire ecosystem by adjusting **wasted sludge mass $P_x = V X / \theta_c$**; increasing wasting rate $Q_w$ lowers sludge age $\theta_c$, driving bacteria into younger, faster-growing metabolic states!
2. **Slide 2 (`ordering`):** Provide 5 steps of aeration tank design: (1) determine influent wastewater flow rate $Q$ and primary effluent $\text{BOD}_5$ substrate concentration $S_0$, (2) select target $F/M$ ratio (e.g. $0.30\text{ day}^{-1}$) and design MLSS biomass concentration $X = 3000\text{ mg/L}$, (3) calculate required aeration basin volume: $V = \frac{Q \cdot S_0}{X \cdot (F/M)}$, (4) compute hydraulic retention time: $\theta = V / Q$ (verify $\theta \approx 4 - 8\text{ hours}$), (5) determine daily waste activated sludge mass: $P_x = (V \cdot X) / \theta_c$ and calculate waste flow rate $Q_w = P_x / X_w$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Sludge Age $\theta_c$, F/M Ratio, MLSS Biomass $X$, WAS Sludge Mass $P_x$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of MLSS (or Biomass). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing an activated sludge basin: A wastewater plant treats $Q = 10,000\text{ m}^3\text{/day}$ with influent BOD $S_0 = 150.0\text{ mg/L} = 0.150\text{ kg/m}^3$ (Total organic loading $= 10,000 \times 0.150 = 1500.0\text{ kg BOD/day}$). Target design parameters: $F/M = 0.25\text{ day}^{-1}$, $\text{MLSS } X = 3000\text{ mg/L} = 3.0\text{ kg/m}^3$, and target sludge age $\theta_c = 10.0\text{ days}$. Clarifier underflow concentration is $X_w = 10,000\text{ mg/L} = 10.0\text{ kg/m}^3$ (neglecting effluent $X_e$).
   - Aeration volume: $V = \frac{Q S_0}{X (F/M)} = \frac{1500\text{ kg/day}}{3.0\text{ kg/m}^3 \times 0.25\text{ day}^{-1}} = \frac{1500}{0.75} = \mathbf{2000.0\text{ m}^3}$;
   - Total biomass in aeration tank: $V \times X = 2000.0\text{ m}^3 \times 3.0\text{ kg/m}^3 = \mathbf{6000.0\text{ kg MLSS}}$;
   - Daily waste sludge mass: $P_x = \frac{V X}{\theta_c} = \frac{6000.0\text{ kg}}{10.0\text{ days}} = \mathbf{600.0\text{ kg/day}}$;
   - Daily WAS flow rate: $Q_w = \frac{P_x}{X_w} = \frac{600.0\text{ kg/day}}{10.0\text{ kg/m}^3} = \mathbf{60.0\text{ m}^3\text{/day}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "activated_sludge_aeration_tank_sizing_and_sludge_age",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Activated Sludge Process \\& Sludge Age (Metcalf \\& Eddy)**\n• **Mean Cell Residence Time (Sludge Age $\\theta_c$) Master Formulation:**\n$$\n\\mathbf{\\theta_c = \\frac{\\text{Total Biomass in Aerator}}{\\text{Daily Biomass Wasted}} = \\frac{V \\cdot X}{Q_w \\cdot X_w + Q_e \\cdot X_e} \\approx \\frac{V \\cdot X}{Q_w \\cdot X_w} \\quad [\\text{days}]}\n$$\n  - **$V$:** Aeration tank volume ($\\text{m}^3$);\n  - **$X$:** Mixed Liquor Suspended Solids (MLSS in $\\text{mg/L}$ or $\\text{kg/m}^3$);\n  - **$Q_w, X_w$:** Waste activated sludge flow rate and underflow solids concentration;\n• **Food-to-Microorganism ($F/M$) Loading Ratio:**\n$$\n\\mathbf{\\frac{F}{M} = \\frac{Q \\cdot S_0}{V \\cdot X} \\quad \\left[\\frac{\\text{kg BOD}_5}{\\text{kg MLSS}\\cdot\\text{day}}\\right] \\Longleftrightarrow \\mathbf{V = \\frac{Q \\cdot S_0}{X \\cdot (F/M)}}}\n$$\n• **Daily Sludge Production ($P_x$):** $\\mathbf{P_x = \\frac{V \\cdot X}{\\theta_c} = Q_w \\cdot X_w \\quad [\\text{kg/day}]}$\n• **The Sludge Age Control Invariant:** The mean cell residence time $\\theta_c$ is the **master ecological selector**; maintaining $\\theta_c \\ge 10\\text{ days}$ is strictly required to prevent the washout of slow-growing autotrophic nitrifiers (*Nitrosomonas*)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size a continuous-flow activated sludge aeration tank and determine the daily sludge wasting flow rate.",
      "orderItems": [
        "Determine influent wastewater flow rate Q and primary effluent organic substrate concentration S0 (BOD5)",
        "Select target Food-to-Microorganism ratio (F/M \u2248 0.25 day^-1) and operating MLSS biomass concentration X (\u2248 3000 mg/L)",
        "Calculate the required aeration tank volume: V = (Q * S0) / [ X * (F/M) ] and check hydraulic retention time \u03b8 = V/Q",
        "Determine the target sludge age \u03b8c (e.g. 10 days for nitrification) and compute daily waste biomass: Px = (V * X) / \u03b8c",
        "Calculate the daily waste activated sludge flow rate: Qw = Px / Xw based on secondary clarifier underflow concentration Xw"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Biological Treatment Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Sludge Age (\u03b8c = VX / QwXw)", "right": "Mean cell residence time representing the average operational lifespan of bacteria in the bioreactor" },
        { "left": "F/M Ratio (Q*S0 / V*X)", "right": "Daily organic food mass applied per unit mass of active biological workforce" },
        { "left": "MLSS Biomass (X)", "right": "Total concentration of suspended biological solids maintained in the aerated mixed liquor" },
        { "left": "WAS Production (Px = VX / \u03b8c)", "right": "Total mass of excess biological sludge that must be purged daily to maintain steady state" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an activated sludge plant, the Food-to-Microorganism ratio F/M is defined as the daily mass of influent BOD5 divided by the total mass of ___ in the aeration tank.",
      "blankAnswer": "MLSS",
      "blankDistractors": ["dissolved oxygen", "effluent", "influent"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A treatment plant has Q = 10,000 m^3/day with S0 = 150.0 mg/L (Total daily BOD = 1500 kg/day). Target F/M = 0.25 day^-1, MLSS X = 3.0 kg/m^3 (3000 mg/L), target sludge age \u03b8c = 10.0 days, and clarifier underflow Xw = 10.0 kg/m^3. What is the required aeration tank volume V and the daily WAS flow rate Qw?",
      "options": [
        { "text": "V = 2000 m^3 and Qw = 60.0 m^3/day (V = 1500 / (3.0 * 0.25) = 1500 / 0.75 = 2000 m^3; Total biomass = 2000 * 3.0 = 6000 kg; Px = 6000 / 10.0 = 600 kg/day; Qw = 600 / 10.0 = 60.0 m^3/day)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the activated sludge mass balance and sizing formulas (Metcalf & Eddy *Wastewater Engineering* Chapter 7 & 8). 1. **Calculate Daily Applied Organic Food Load:** $$\\text{BOD Load} = Q \\cdot S_0 = 10,000\\text{ m}^3\\text{/day} \\times 0.150\\text{ kg/m}^3 = \\mathbf{1500.0\\text{ kg BOD}_5\\text{/day}}$$ 2. **Calculate Required Aeration Basin Volume ($V$):** - Given: $\\frac{F}{M} = 0.25\\text{ day}^{-1}$, $\\text{MLSS } X = 3.0\\text{ kg/m}^3$. $$V = \\frac{Q \\cdot S_0}{X \\cdot (F/M)} = \\frac{1500.0\\text{ kg/day}}{3.0\\text{ kg/m}^3 \\times 0.25\\text{ day}^{-1}} = \\frac{1500.0}{0.75} = \\mathbf{2000.0\\text{ m}^3}$$ - Hydraulic retention time: $$\\theta = \\frac{V}{Q} = \\frac{2000.0\\text{ m}^3}{10,000\\text{ m}^3\\text{/day}} = 0.20\\text{ days} = \\mathbf{4.80\\text{ hours}}$$ 3. **Calculate Total Aeration Biomass Inventory ($M_{\\text{biomass}}$):** $$M_{\\text{biomass}} = V \\cdot X = 2000.0\\text{ m}^3 \\times 3.0\\text{ kg/m}^3 = \\mathbf{6000.0\\text{ kg MLSS}}$$ 4. **Calculate Daily Sludge Production / Wasting ($P_x$):** - Sludge age: $\\theta_c = 10.0\\text{ days}$. $$P_x = \\frac{V \\cdot X}{\\theta_c} = \\frac{6000.0\\text{ kg}}{10.0\\text{ days}} = \\mathbf{600.0\\text{ kg MLSS/day}}$$ 5. **Calculate Waste Activated Sludge (WAS) Pumping Flow Rate ($Q_w$):** - Underflow solids concentration: $X_w = 10.0\\text{ kg/m}^3$ ($10,000\\text{ mg/L}$). $$Q_w = \\frac{P_x}{X_w} = \\frac{600.0\\text{ kg/day}}{10.0\\text{ kg/m}^3} = \\mathbf{60.0\\text{ m}^3\\text{/day}}$$ Flawless activated sludge aeration tank sizing and sludge wasting derivation!" },
        { "text": "V = 2000 m^3 and Qw = 600.0 m^3/day (Forgot to divide by Xw = 10 kg/m^3)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V = 1000 m^3 and Qw = 30.0 m^3/day", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V = 4000 m^3 and Qw = 120.0 m^3/day", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
