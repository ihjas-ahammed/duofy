# Duofy Reusable Lesson Format: River DO Sag (Streeter-Phelps Model & Critical Deficit)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Wastewater_Treatment_and_Sewage`  
**Lesson Format Type:** `streeter_phelps_dissolved_oxygen_sag_curve_and_critical_deficit`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through river water quality modeling, the balance between microbial organic deoxygenation and surface atmospheric reaeration, H. W. Streeter and Earle B. Phelps' 1925 **Dissolved Oxygen (DO) Sag Equation**, initial mixing zone conditions (flow-weighted BOD $L_0$ and initial deficit $D_0 = \text{DO}_{\text{sat}} - \text{DO}_{\text{mix}}$), deoxygenation coefficient ($k_d$), reaeration coefficient ($k_r$), self-purification ratio ($f = k_r / k_d$), calculating the **Critical Travel Time ($t_c$)**, and determining the **Maximum Critical DO Deficit ($D_c$)** and minimum river dissolved oxygen ($\text{DO}_{\text{min}} = \text{DO}_{\text{sat}} - D_c$) (Metcalf & Eddy *Wastewater Engineering* Chapter 2; Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 11; Streeter & Phelps 1925): formulate the **Streeter-Phelps Dissolved Oxygen Deficit Master Equation**:
$$\mathbf{D(t) = \frac{k_d \cdot L_0}{k_r - k_d} \left( e^{-k_d t} - e^{-k_r t} \right) + D_0 \cdot e^{-k_r t} \quad [\text{mg/L}]}$$
derive the **Critical Travel Time ($t_c$) Formula ($\frac{dD}{dt} = 0$)**:
$$\mathbf{t_c = \frac{1}{k_r - k_d} \ln\left\{ \frac{k_r}{k_d} \left[ 1 - D_0 \left( \frac{k_r - k_d}{k_d \cdot L_0} \right) \right] \right\} \quad [\text{days}]}$$
derive the **Maximum Critical Deficit ($D_c$) Formula**:
$$\mathbf{D_c = \frac{k_d}{k_r} \cdot L_0 \cdot e^{-k_d \cdot t_c} = \frac{k_d}{k_r} \cdot L_t(t_c) \Longleftrightarrow \mathbf{\text{DO}_{\text{min}} = \text{DO}_{\text{sat}} - D_c}}$$
master the **Equilibrium Invariant at Critical Sag**:
- At $t = t_c$, the rate of bacterial deoxygenation **strictly equals the rate of atmospheric reaeration**:
  $$\mathbf{r_{\text{deoxygenation}} = r_{\text{reaeration}} \Longleftrightarrow \mathbf{k_d \cdot L(t_c) = k_r \cdot D_c}}$$
(proving why rivers can suffer acute fish kills at distance $x_c = v_{\text{river}} \cdot t_c$ kilometers downstream of an effluent outfall even if DO is high at the discharge point).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Streeter-Phelps DO Sag ($D(t) = \frac{k_d L_0}{k_r - k_d}(e^{-k_d t}-e^{-k_r t})+D_0 e^{-k_r t}$), $t_c$ & $D_c$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Initial Mixture, Critical Sag Time, and Minimum Stream DO Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | DO Sag Parameter / Physical Rate & Technical Stream Process Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | At the Exact Bottom of the Streeter-Phelps DO Sag Curve ($t = t_c$), the Rate of Microbial Deoxygenation Strictly Equals the Rate of Atmospheric ___ (Reaeration / Oxygen Transfer) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Environmental River Problem: Calculating Critical Travel Time t_c, Max Deficit D_c, and Minimum DO Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Streeter-Phelps DO Sag Mechanics (Streeter & Phelps 1925; Davis 2020):
   - **DO Deficit Formulations:**
     $$\mathbf{D(t) = \frac{k_d L_0}{k_r - k_d}\left(e^{-k_d t} - e^{-k_r t}\right) + D_0 e^{-k_r t} \quad \Big| \quad t_c = \frac{1}{k_r - k_d}\ln\left[\frac{k_r}{k_d}\left(1 - \frac{D_0(k_r-k_d)}{k_d L_0}\right)\right] \quad \Big| \quad D_c = \frac{k_d L_0}{k_r}e^{-k_d t_c}}$$
   - **Initial Mixing Mass Balance Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Mixture Parameter} & \textbf{Mass Balance Formula} & \textbf{Physical Definition} \\
     \hline
     \mathbf{\text{Mixed Stream Flow }} Q_{\text{mix}} & Q_{\text{mix}} = Q_r + Q_w & \text{Combined river and wastewater discharge} \\
     \mathbf{\text{Mixed Ultimate BOD }} L_0 & \mathbf{L_0 = \frac{Q_r L_r + Q_w L_w}{Q_r + Q_w}} & \text{Initial flow-weighted organic oxygen load} \\
     \mathbf{\text{Mixed Dissolved Oxygen }} \text{DO}_0 & \mathbf{\text{DO}_0 = \frac{Q_r \text{DO}_r + Q_w \text{DO}_w}{Q_r + Q_w}} & \text{Initial dissolved oxygen right after outfall} \\
     \mathbf{\text{Initial Deficit }} D_0 & \mathbf{D_0 = \text{DO}_{\text{sat}} - \text{DO}_0} & \text{Difference from saturation DO at stream temp} \\
     \hline
     \end{array}$$
   - **The Critical Rate Equality Invariant:** At the point of minimum dissolved oxygen ($t = t_c$), the derivative $dD/dt = 0$, enforcing **$k_d L(t_c) = k_r D_c$** (oxygen consumption rate exactly balances atmospheric replenishment rate)!
2. **Slide 2 (`ordering`):** Provide 5 steps of DO sag analysis: (1) calculate initial mixed ultimate BOD ($L_0$) and initial oxygen deficit ($D_0 = \text{DO}_{\text{sat}} - \text{DO}_{\text{mix}}$) using mass balance, (2) determine stream deoxygenation rate $k_d$ and surface reaeration rate $k_r$, (3) calculate critical travel time to the sag trough: $t_c = \frac{1}{k_r - k_d} \ln\left[ \frac{k_r}{k_d} \left( 1 - \frac{D_0 (k_r - k_d)}{k_d L_0} \right) \right]$, (4) compute maximum critical DO deficit: $D_c = \frac{k_d L_0}{k_r} e^{-k_d t_c}$, (5) evaluate minimum stream dissolved oxygen: $\text{DO}_{\text{min}} = \text{DO}_{\text{sat}} - D_c$ and verify $\text{DO}_{\text{min}} \ge 4.0\text{ or } 5.0\text{ mg/L}$ for aquatic life!
3. **Slide 3 (`matching`):** Pair 4 concepts (Deoxygenation Rate $k_d$, Reaeration Rate $k_r$, Critical Deficit $D_c$, Self-Purification Ratio $k_r/k_d$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Reaeration (or Oxygen Transfer). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Streeter-Phelps critical sag: A wastewater outfall mixes with a river to produce an initial organic load $L_0 = 25.0\text{ mg/L}$ and initial deficit $D_0 = 2.0\text{ mg/L}$. River deoxygenation rate is $k_d = 0.20\text{ day}^{-1}$ and reaeration rate is $k_r = 0.50\text{ day}^{-1}$ ($k_r - k_d = 0.30\text{ day}^{-1}$). Saturation DO is $\text{DO}_{\text{sat}} = 9.0\text{ mg/L}$.
   - Critical time:
     $\text{Term} = \frac{D_0(k_r - k_d)}{k_d L_0} = \frac{2.0 \times 0.30}{0.20 \times 25.0} = \frac{0.60}{5.00} = \mathbf{0.120}$;
     $\text{Bracket} = 1 - 0.120 = \mathbf{0.880}$;
     $\text{Log argument} = \frac{k_r}{k_d} \times 0.880 = \frac{0.50}{0.20} \times 0.880 = 2.50 \times 0.880 = \mathbf{2.200}$;
     $t_c = \frac{1}{0.30} \ln(2.200) = \frac{0.78846}{0.30} = \mathbf{2.628\text{ days} \approx 2.63\text{ days}}$;
   - Critical deficit ($e^{-k_d t_c} = e^{-0.20 \times 2.628} = e^{-0.5256} = 0.5912$):
     $D_c = \left(\frac{k_d}{k_r}\right) L_0 e^{-k_d t_c} = \left(\frac{0.20}{0.50}\right) \times 25.0 \times 0.5912 = 0.40 \times 25.0 \times 0.5912 = 10.0 \times 0.5912 = \mathbf{5.91\text{ mg/L}}$;
   - Minimum DO: $\text{DO}_{\text{min}} = \text{DO}_{\text{sat}} - D_c = 9.00 - 5.91 = \mathbf{3.09\text{ mg/L} \approx 3.1\text{ mg/L}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "streeter_phelps_dissolved_oxygen_sag_curve_and_critical_deficit",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Streeter-Phelps DO Sag Model (H. W. Streeter \\& Earle Phelps 1925)**\n• **Dissolved Oxygen Deficit Master Formulation ($D(t)$):**\n$$\n\\mathbf{D(t) = \\frac{k_d \\cdot L_0}{k_r - k_d} \\left( e^{-k_d t} - e^{-k_r t} \\right) + D_0 \\cdot e^{-k_r t} \\quad [\\text{mg/L}]}\n$$\n  - **$L_0$:** Initial mixed ultimate BOD ($\\text{mg/L}$);\n  - **$D_0 = \\text{DO}_{\\text{sat}} - \\text{DO}_{\\text{mix}}$:** Initial mixed oxygen deficit ($\\text{mg/L}$);\n  - **$k_d$:** Stream deoxygenation rate constant ($\\text{day}^{-1}$);\n  - **$k_r$:** Atmospheric reaeration rate constant ($\\text{day}^{-1}$);\n• **Critical Sag Time ($t_c$) \\& Maximum Deficit ($D_c$) Formulations:**\n$$\n\\mathbf{t_c = \\frac{1}{k_r - k_d} \\ln\\left[ \\frac{k_r}{k_d} \\left( 1 - \\frac{D_0 (k_r - k_d)}{k_d \\cdot L_0} \\right) \\right] \\quad \\Big| \\quad \\mathbf{D_c = \\frac{k_d \\cdot L_0}{k_r} e^{-k_d \\cdot t_c}}}\n$$\n• **Minimum Stream Dissolved Oxygen:** $\\mathbf{\\text{DO}_{\\text{min}} = \\text{DO}_{\\text{sat}} - D_c}$\n• **The Critical Equilibrium Invariant:** At the absolute lowest point of the sag curve ($t = t_c$), **deoxygenation rate equals reaeration rate ($k_d L(t_c) = k_r D_c$)**, marking the exact transition where river recovery surpasses organic decay!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the critical travel time and minimum dissolved oxygen in a river following a wastewater discharge.",
      "orderItems": [
        "Calculate the initial mixed ultimate BOD (L0) and initial oxygen deficit (D0 = DO_sat - DO_mix) using mass balance at the outfall",
        "Determine the stream deoxygenation rate kd and surface reaeration rate kr (adjusted for water temperature)",
        "Calculate the critical travel time to the DO sag trough: tc = [1 / (kr - kd)] * ln[ (kr/kd) * (1 - D0*(kr - kd)/(kd*L0)) ]",
        "Calculate the maximum critical dissolved oxygen deficit: Dc = (kd * L0 / kr) * e^(-kd * tc)",
        "Evaluate the minimum river dissolved oxygen: DO_min = DO_sat - Dc and verify compliance with aquatic standards (e.g. \u2265 5.0 mg/L)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each DO Sag Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Deoxygenation Rate (kd)", "right": "First-order microbial oxygen depletion rate driven by heterotrophic bacteria digesting wastewater BOD" },
        { "left": "Reaeration Rate (kr)", "right": "Rate of atmospheric oxygen transfer across the turbulent water-air interface replenishing dissolved oxygen" },
        { "left": "Critical Deficit (Dc)", "right": "Maximum difference between saturation DO and actual stream DO occurring at critical travel time tc" },
        { "left": "Self-Purification Ratio (kr/kd)", "right": "Dimensionless recovery index (typically 1.5 - 4.0) measuring a river's natural capacity to assimilate organic waste" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "At the exact bottom of the Streeter-Phelps DO sag curve (t = tc), the rate of microbial deoxygenation strictly equals the rate of atmospheric ___.",
      "blankAnswer": "reaeration",
      "blankDistractors": ["settling", "evaporation", "nitrification"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A river has L0 = 25.0 mg/L, D0 = 2.0 mg/L, kd = 0.20 day^-1, kr = 0.50 day^-1 (kr - kd = 0.30), and DO_sat = 9.0 mg/L. (kr/kd)*[1 - D0*(kr-kd)/(kd*L0)] = 2.50 * [1 - 0.60/5.00] = 2.50 * 0.88 = 2.20 (ln2.20 = 0.7885). What is the critical sag time tc and the minimum stream dissolved oxygen DO_min (e^(-0.20*2.628) = 0.5912)?",
      "options": [
        { "text": "tc = 2.63 days and DO_min = 3.09 mg/L (tc = 0.7885 / 0.30 = 2.628 days; Dc = (0.20/0.50) * 25.0 * 0.5912 = 10.0 * 0.5912 = 5.912 mg/L; DO_min = 9.00 - 5.912 = 3.088 mg/L)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Streeter-Phelps DO sag formulations (Metcalf & Eddy *Wastewater Engineering* Chapter 2; Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 11). 1. **Calculate Critical Sag Time ($t_c$):** - Given parameters: $L_0 = 25.0\\text{ mg/L}, \\ D_0 = 2.0\\text{ mg/L}, \\ k_d = 0.20\\text{ day}^{-1}, \\ k_r = 0.50\\text{ day}^{-1}$. - Difference: $k_r - k_d = 0.50 - 0.20 = \\mathbf{0.30\\text{ day}^{-1}}$. - Bracket term: $$1 - \\frac{D_0 (k_r - k_d)}{k_d \\cdot L_0} = 1 - \\frac{2.0 \\times 0.30}{0.20 \\times 25.0} = 1 - \\frac{0.60}{5.00} = 1 - 0.120 = \\mathbf{0.880}$$ - Natural logarithm argument: $$\\frac{k_r}{k_d} \\times 0.880 = \\frac{0.50}{0.20} \\times 0.880 = 2.50 \\times 0.880 = \\mathbf{2.200}$$ - Critical time: $$t_c = \\frac{1}{k_r - k_d} \\ln(2.200) = \\frac{1}{0.30} \\times 0.788457 = \\mathbf{2.62819\\text{ days} \\approx 2.63\\text{ days}}$$ 2. **Calculate Maximum Critical Deficit ($D_c$):** - Exponential decay factor: $$e^{-k_d \\cdot t_c} = e^{-0.20 \\times 2.62819} = e^{-0.525638} = \\mathbf{0.591176}$$ - Critical deficit: $$D_c = \\left( \\frac{k_d}{k_r} \\right) \\cdot L_0 \\cdot e^{-k_d \\cdot t_c} = \\left( \\frac{0.20}{0.50} \\right) \\times 25.0\\text{ mg/L} \\times 0.591176$$ $$D_c = 10.0\\text{ mg/L} \\times 0.591176 = \\mathbf{5.9118\\text{ mg/L} \\approx 5.91\\text{ mg/L}}$$ 3. **Calculate Minimum River Dissolved Oxygen ($\\text{DO}_{\\text{min}}$):** $$\\text{DO}_{\\text{min}} = \\text{DO}_{\\text{sat}} - D_c = 9.00\\text{ mg/L} - 5.9118\\text{ mg/L} = \\mathbf{3.0882\\text{ mg/L} \\approx 3.09\\text{ mg/L}}$$ Flawless Streeter-Phelps critical DO sag derivation!" },
        { "text": "tc = 2.63 days and DO_min = 5.91 mg/L (Confused critical deficit Dc with dissolved oxygen DO_min)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "tc = 1.50 days and DO_min = 4.50 mg/L", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "tc = 3.50 days and DO_min = 2.00 mg/L", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
