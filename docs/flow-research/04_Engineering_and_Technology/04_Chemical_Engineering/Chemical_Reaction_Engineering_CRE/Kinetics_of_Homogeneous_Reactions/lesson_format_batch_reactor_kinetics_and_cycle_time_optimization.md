# Duofy Reusable Lesson Format: Batch Reactors (Reaction Kinetics & Cycle Time Optimization)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Reaction_Engineering_CRE / Kinetics_of_Homogeneous_Reactions`  
**Lesson Format Type:** `batch_reactor_kinetics_and_cycle_time_optimization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through unsteady-state chemical reactor modeling for pharmaceutical and specialty chemical synthesis, **Ideal Batch Reactor Mole Balances**, definition of fractional reactant conversion ($X = \frac{N_{A0} - N_A}{N_{A0}}$), analytical integration of batch reaction times ($t_R$) across reaction orders ($n = 0, 1, 2$), batch cycle times ($t_{\text{cycle}} = t_R + t_{\text{dead}}$ including charging, heating, discharging, and cleaning downtime), and overall daily batch production rate maximization ($\dot{P} = \frac{N_{A0} X}{t_R + t_{\text{dead}}}$) (H. Scott Fogler *Elements of Chemical Reaction Engineering* 5th/6th ed. Chapter 4; Octave Levenspiel *Chemical Reaction Engineering* Chapter 3): formulate the **Ideal Batch Reactor Mole Balance Master Formulation**:
$$\mathbf{t_R = N_{A0} \int_0^X \frac{dX}{\left( -r_A \right) V} = C_{A0} \int_0^X \frac{dX}{-r_A} \quad (\text{for constant volume } V = V_0)}$$
where:
1. **$t_R$:** Reaction holding time in seconds or minutes;
2. **$N_{A0}, C_{A0}$:** Initial moles and concentration of limiting reactant $A$;
3. **$X$:** Fractional conversion ($C_A = C_{A0}(1 - X)$);
4. **$-r_A$:** Reaction rate law;
derive the **Integrated Batch Reaction Times for Standard Kinetic Orders**:
- **Zero-Order ($-r_A = k$):** $\mathbf{t_R = \frac{C_{A0} \cdot X}{k}}$;
- **First-Order ($-r_A = k C_A$):** $\mathbf{t_R = \frac{1}{k} \ln\left( \frac{1}{1 - X} \right) = \frac{1}{k} \ln\left( \frac{C_{A0}}{C_A} \right)}$;
- **Second-Order ($-r_A = k C_A^2$):** $\mathbf{t_R = \frac{1}{k \cdot C_{A0}} \left( \frac{X}{1 - X} \right) = \frac{1}{k} \left( \frac{1}{C_A} - \frac{1}{C_{A0}} \right)}$;
derive the **Optimal Batch Cycle Time & Productivity Equation**:
$$\mathbf{t_{\text{cycle}} = t_R + t_{\text{dead}} \quad \Big| \quad \mathbf{\text{Productivity } \dot{m} = \frac{V \cdot C_{A0} \cdot X \cdot M_w}{t_R + t_{\text{dead}}} \quad [\text{kg/day}]}$$
(proving that for first-order batch reactions, reaction time is completely independent of initial concentration $C_{A0}$, depending only on rate constant $k$ and target conversion $X$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Batch Mole Balance ($t_R = C_{A0}\int_0^X \frac{dX}{-r_A}$), 1st Order ($t_R = \frac{1}{k}\ln\frac{1}{1-X}$) & 2nd Order ($t_R = \frac{X}{k C_{A0}(1-X)}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Batch Reaction Time, Total Cycle Time, and Number of Daily Batches Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Batch Reaction Order / Cycle Entity & Technical Mathematical Formulation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Constant-Volume First-Order Batch Reaction ($-r_A = k C_A$), the Reaction Time $t_R$ Required to Reach Conversion $X$ Equals $1/k$ Times the Natural Logarithm of 1 Divided by $(1 - \text{___})$ (X / Conversion X) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Specialty Chemical Synthesis Problem: Sizing Batch Reaction Time t_R and Daily Yield for 95% Conversion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Batch Reactor Kinetics (Fogler 2016; Levenspiel 1999):
   - **Integrated Batch Time Formulations:**
     $$\mathbf{t_R = C_{A0}\int_0^X \frac{dX}{-r_A} \quad \Big| \quad t_{\text{1st}} = \frac{1}{k}\ln\left(\frac{1}{1-X}\right) \quad \Big| \quad t_{\text{2nd}} = \frac{X}{k C_{A0}(1-X)} \quad \Big| \quad t_{\text{cycle}} = t_R + t_{\text{dead}}}$$
   - **Batch Integration across Orders Matrix:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Reaction Order } n & \textbf{Rate Law } -r_A & \textbf{Integrated Reaction Time } t_R & \textbf{Concentration Profile } C_A(t) \\
     \hline
     \mathbf{n = 0 \text{ (Zero Order)}} & k & \mathbf{t_R = \frac{C_{A0} X}{k}} & C_A(t) = C_{A0} - k t \\
     \mathbf{n = 1 \text{ (First Order)}} & k C_A & \mathbf{t_R = \frac{1}{k}\ln\left(\frac{1}{1 - X}\right)} & C_A(t) = C_{A0} e^{-k t} \\
     \mathbf{n = 2 \text{ (Second Order)}} & k C_A^2 & \mathbf{t_R = \frac{X}{k C_{A0} (1 - X)}} & C_A(t) = \frac{C_{A0}}{1 + k C_{A0} t} \\
     \mathbf{n = 1/2 \text{ (Half Order)}} & k C_A^{1/2} & t_R = \frac{2 C_{A0}^{1/2}}{k} \left[1 - (1 - X)^{1/2}\right] & C_A(t) = \left(C_{A0}^{1/2} - \frac{k t}{2}\right)^2 \\
     \hline
     \end{array}$$
   - **The Asymptotic Conversion Invariant:** Reaching $100\%$ conversion ($X \to 1.0$) in first- or second-order reactions requires **infinite reaction time ($t_R \to \infty$)**; commercial batch cycles optimize economic stopping points at $X \approx 90-98\%$!
2. **Slide 2 (`ordering`):** Provide 5 steps of batch reactor design: (1) determine reaction order $n$, rate constant $k$, and initial concentration $C_{A0}$, (2) establish target fractional conversion $X$ (e.g. $0.95$), (3) integrate the batch mole balance to calculate reaction time: $t_R = \frac{1}{k}\ln\frac{1}{1-X}$ (for 1st order), (4) add operational turnaround dead time (charging, heating, emptying, cleaning) to get total cycle time: $t_{\text{cycle}} = t_R + t_{\text{dead}}$, (5) compute total number of batches per day: $N_{\text{batches}} = 24\text{ hours} / t_{\text{cycle}}$ and multiply by batch volume to get daily plant production capacity!
3. **Slide 3 (`matching`):** Pair 4 concepts (First-Order Batch Time, Second-Order Batch Time, Dead Time $t_{\text{dead}}$, Batch Productivity) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of X (or Conversion X). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating batch reaction time: A pharmaceutical synthesis reaction $A \to \text{Product}$ is first-order with rate constant $k = 0.050\text{ min}^{-1}$. Initial concentration is $C_{A0} = 2.0\text{ mol/L}$ in a $V = 1000\text{ L}$ batch reactor. Target conversion is $X = 0.950$ ($95.0\%$). Dead time between batches for loading and cleaning is $t_{\text{dead}} = 40.0\text{ min}$.
   - Remaining unreacted fraction: $1 - X = 1 - 0.950 = \mathbf{0.050}$;
   - Reaction time: $t_R = \frac{1}{k} \ln\left(\frac{1}{1 - X}\right) = \frac{1}{0.050\text{ min}^{-1}} \ln\left(\frac{1}{0.050}\right) = 20.0 \times \ln(20.0) = 20.0 \times 2.99573 = \mathbf{59.91\text{ min} \approx 60.0\text{ min}}$;
   - Total batch cycle time: $t_{\text{cycle}} = t_R + t_{\text{dead}} = 59.91 + 40.0 = \mathbf{99.91\text{ min} \approx 100.0\text{ min} = 1.667\text{ hours}}$;
   - What is the required reaction holding time $t_R$ and total cycle time $t_{\text{cycle}}$? ($t_R = \mathbf{59.9\text{ min}}$ and $t_{\text{cycle}} = \mathbf{99.9\text{ min}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "batch_reactor_kinetics_and_cycle_time_optimization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Batch Reactor Kinetics \\& Cycle Times (H. Scott Fogler)**\n• **Ideal Batch Reactor Mole Balance Master Formulation:**\n$$\n\\mathbf{t_R = N_{A0} \\int_0^X \\frac{dX}{\\left( -r_A \\right) V} = C_{A0} \\int_0^X \\frac{dX}{-r_A} \\quad (\\text{for constant volume } V = V_0)}\n$$\n  - **$t_R$:** Reaction holding duration ($\\text{min}$ or $\\text{s}$);\n  - **$X = \\frac{C_{A0} - C_A}{C_{A0}}$:** Fractional reactant conversion;\n• **Standard Integrated Reaction Times by Kinetic Order:**\n  - **Zero-Order ($-r_A = k$):** $\\mathbf{t_R = \\frac{C_{A0} \\cdot X}{k}}$;\n  - **First-Order ($-r_A = k C_A$):** $\\mathbf{t_R = \\frac{1}{k} \\ln\\left( \\frac{1}{1 - X} \\right) = \\frac{1}{k} \\ln\\left( \\frac{C_{A0}}{C_A} \\right)}$;\n  - **Second-Order ($-r_A = k C_A^2$):** $\\mathbf{t_R = \\frac{1}{k \\cdot C_{A0}} \\left( \\frac{X}{1 - X} \\right)}$;\n• **Total Cycle Time \\& Daily Plant Productivity Formulation:**\n$$\n\\mathbf{t_{\\text{cycle}} = t_R + t_{\\text{dead}} \\quad \\Big| \\quad \\text{Daily Batches} = \\frac{24\\text{ hours}}{t_{\\text{cycle}}}}\n$$\n• **The First-Order Scale Invariant:** For first-order batch kinetics, **reaction time $t_R$ is completely independent of initial concentration $C_{A0}$**, depending exclusively on reaction rate constant $k$ and target conversion $X$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size a pharmaceutical batch reactor cycle time and determine maximum daily product output.",
      "orderItems": [
        "Determine the reaction mechanism, kinetic order n, rate constant k, and initial reactant concentration CA0",
        "Specify the target fractional conversion X required for product purity (e.g. X = 0.95)",
        "Integrate the batch mole balance to compute reaction holding time: tR = (1/k) * ln[ 1 / (1 - X) ] for 1st order",
        "Add process turnaround downtime (filling, heating, emptying, washing): t_cycle = tR + t_dead",
        "Calculate daily batch frequency: N_batches = 24h / t_cycle and multiply by batch volume to establish daily production rate"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Batch Reactor Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "First-Order Time (tR)", "right": "tR = (1/k)*ln(1 / (1 - X)), holding time required for unimolecular decomposition independent of CA0" },
        { "left": "Second-Order Time (tR)", "right": "tR = X / [ k*CA0*(1 - X) ], holding time scaling inversely with initial concentration CA0" },
        { "left": "Turnaround Dead Time (t_dead)", "right": "Non-reaction operating duration consumed by charging, heating, discharging, and cleaning between batches" },
        { "left": "Fractional Conversion (X)", "right": "X = (NA0 - NA) / NA0, fraction of initial reactant moles transformed into chemical products" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a constant-volume first-order batch reaction (-rA = k*CA), the reaction time tR required to reach conversion X equals 1/k times the natural logarithm of 1 divided by (1 - ___).",
      "blankAnswer": "X",
      "blankDistractors": ["k", "CA0", "t_dead"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A batch reaction is first-order with k = 0.050 min^-1 and CA0 = 2.0 mol/L. Target conversion is X = 0.950 (1 / (1 - 0.95) = 20.0, ln20.0 = 2.9957). Turnaround dead time is t_dead = 40.0 min. What is the required reaction holding time tR and the total batch cycle time t_cycle?",
      "options": [
        { "text": "tR = 59.9 min and t_cycle = 99.9 min (tR = (1 / 0.050) * ln(20.0) = 20.0 * 2.99573 = 59.91 min \u2248 59.9 min; t_cycle = 59.91 + 40.0 = 99.91 min \u2248 99.9 min)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the integrated first-order batch reactor mole balance (H. Scott Fogler *Elements of Chemical Reaction Engineering* Chapter 4; Octave Levenspiel *Chemical Reaction Engineering* Chapter 3). 1. **Identify Given Reaction Kinetic Inputs:** - Reaction rate law: $-r_A = k C_A$ (First Order). - Rate constant: $k = 0.050\\text{ min}^{-1}$. - Initial concentration: $C_{A0} = 2.0\\text{ mol/L}$. - Target fractional conversion: $X = 0.950$. - Non-reaction turnaround dead time: $t_{\\text{dead}} = 40.0\\text{ min}$. 2. **Calculate Required Reaction Holding Time ($t_R$):** - Remaining unreacted fraction: $$1 - X = 1 - 0.950 = \\mathbf{0.050}$$ - Ratio: $$\\frac{1}{1 - X} = \\frac{1}{0.050} = \\mathbf{20.00}$$ - Natural logarithm: $$\\ln\\left( \\frac{1}{1 - X} \\right) = \\ln(20.00) = \\mathbf{2.995732}$$ - Integrated reaction time: $$t_R = \\frac{1}{k} \\ln\\left( \\frac{1}{1 - X} \\right) = \\frac{1}{0.050\\text{ min}^{-1}} \\times 2.995732$$ $$t_R = 20.0\\text{ min} \\times 2.995732 = \\mathbf{59.9146\\text{ min} \\approx 59.9\\text{ min}}$$ 3. **Calculate Total Batch Cycle Time ($t_{\\text{cycle}}$):** $$t_{\\text{cycle}} = t_R + t_{\\text{dead}} = 59.9146\\text{ min} + 40.0\\text{ min} = \\mathbf{99.9146\\text{ min} \\approx 99.9\\text{ min} = 1.665\\text{ hours}}$$ 4. **Production Check:** - Over a 24-hour day, the reactor completes: $$N_{\\text{batches}} = \\frac{24 \\times 60\\text{ min}}{99.9146\\text{ min}} = \\frac{1440}{99.9146} = \\mathbf{14.41\\text{ batches/day}}$$ Flawless first-order batch reactor reaction time and cycle time derivation!" },
        { "text": "tR = 19.0 min and t_cycle = 59.0 min (Used X instead of ln(1/(1-X)))", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "tR = 59.9 min and t_cycle = 59.9 min (Forgot turnaround dead time)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "tR = 120.0 min and t_cycle = 160.0 min", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
