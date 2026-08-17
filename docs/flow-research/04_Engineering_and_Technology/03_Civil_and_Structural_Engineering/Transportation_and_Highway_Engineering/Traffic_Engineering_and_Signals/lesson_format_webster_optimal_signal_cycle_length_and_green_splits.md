# Duofy Reusable Lesson Format: Traffic Signals (Webster Optimal Cycle & Green Splits)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Traffic_Engineering_and_Signals`  
**Lesson Format Type:** `webster_optimal_signal_cycle_length_and_green_splits`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through signalized intersection timing design, critical lane group volumes ($v_i$), saturation flow rate ($s_i \approx 1900\text{ pc/h/ln}$), flow ratios ($y_i = v_i / s_i$), total cycle lost time ($L = \sum t_{L,i}$), F. V. Webster's seminal 1958 formula for **Optimum Cycle Length ($C_0$)** minimizing total vehicle intersection delay, the feasibility condition ($\sum y_i < 1.0$), effective green time phase allocation ($g_i$), and lane group capacity verification ($c_i = s_i \frac{g_i}{C}$) (TRB *Highway Capacity Manual* Chapter 19; Roger P. Roess *Traffic Engineering* 5th ed. Chapter 18; F. V. Webster 1958): formulate **Webster's Optimum Cycle Length ($C_0$) Master Formulation**:
$$\mathbf{C_0 = \frac{1.5 L + 5}{1 - Y}}$$
where:
1. **$L$:** Total lost time per cycle in seconds: $\mathbf{L = \sum_{i=1}^{\Phi} t_{L,i} + R_{\text{all-red}}}$;
2. **$Y$:** Sum of critical lane group flow ratios: $\mathbf{Y = \sum_{i=1}^{\Phi} y_{i,\text{critical}} = \sum_{i=1}^{\Phi} \frac{v_i}{s_i} < 1.0}$;
3. **$\Phi$:** Number of signal phases in the cycle;
formulate the **Effective Green Time Split Allocation Equation ($g_i$)**:
$$\mathbf{g_i = \left( \frac{y_i}{Y} \right) \left( C - L \right) \quad \left(\sum g_i = C - L\right)}$$
derive the **Lane Group Capacity ($c_i$) & Degree of Saturation ($X_i$)**:
$$\mathbf{c_i = s_i \cdot \left( \frac{g_i}{C} \right) \quad \Big| \quad X_i = \frac{v_i}{c_i} = \frac{v_i}{s_i (g_i / C)} \le 1.0}$$
(proving that allocating green time proportionally to critical flow ratios balances the degree of saturation $X$ equally across all competing intersection phases).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Webster's Cycle Formula ($C_0 = \frac{1.5L+5}{1-Y}$), Green Splits ($g_i = \frac{y_i}{Y}(C-L)$) & $c_i = s_i \frac{g_i}{C}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Optimal Cycle Length and Phase Green Times Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Signal Timing Parameter / Phasing Entity & Technical Traffic Operational Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Webster's Optimum Cycle Formula $C_0 = (1.5L + 5) / (1 - Y)$, the Sum of Critical Flow Ratios $Y$ Must Strictly Be Less Than Exactly ___ (1.0 / One) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal Design Problem: Sizing Webster Optimum Cycle Length C_0 and Phase Green Times for a 2-Phase Intersection Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Webster's Optimal Signal Timing (Webster 1958; Roess 2018):
   - **Signal Timing Formulations:**
     $$\mathbf{C_0 = \frac{1.5 L + 5}{1 - Y} \quad \Big| \quad g_i = \left(\frac{y_i}{Y}\right)(C - L) \quad \Big| \quad Y = \sum \frac{v_i}{s_i} < 1.0 \quad \Big| \quad c_i = s_i \left(\frac{g_i}{C}\right)}$$
   - **Cycle Length Practical Range Guidelines:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Intersection Complexity} & \textbf{Optimum Cycle Range } C_0 & \textbf{Operational Behavior} \\
     \hline
     \mathbf{\text{Simple 2-Phase Crossroad}} & \mathbf{45\text{ s} - 65\text{ s}} & \text{Short delay; quick pedestrian turnarounds} \\
     \mathbf{\text{Standard 4-Phase (Protected Lefts)}} & \mathbf{70\text{ s} - 100\text{ s}} & \text{Balanced vehicular progression} \\
     \mathbf{\text{Complex Multi-Phase / Congested}} & \mathbf{100\text{ s} - 140\text{ s}} & \text{Maximum green efficiency; high queue clearance} \\
     \text{Oversaturated Failure } (Y \to 1.0) & C_0 \to \infty & \text{Requires lane additions / grade separation} \\
     \hline
     \end{array}$$
   - **The Equal Saturation Invariant:** Proportional allocation ($g_i \propto y_i$) ensures that **$X_1 = X_2 = \dots = X_n = Y \frac{C}{C - L}$**, preventing one approach from gridlocking while another sits underutilized!
2. **Slide 2 (`ordering`):** Provide 5 steps of Webster signal design: (1) determine critical design lane group volumes ($v_1, v_2, \dots$) and saturation flow rates ($s_1, s_2, \dots$), (2) calculate flow ratios $y_i = v_i / s_i$ and compute sum $Y = \sum y_i$, (3) compute total cycle lost time $L = \sum t_{L,i}$ (e.g. $4\text{ s/phase}$), (4) calculate Webster's optimum cycle length: $C_0 = (1.5 L + 5) / (1 - Y)$ and round to nearest $5\text{ s}$, (5) compute effective green time for each phase: $g_i = (y_i / Y)(C - L)$ and verify minimum pedestrian green times!
3. **Slide 3 (`matching`):** Pair 4 concepts (Webster Cycle Length $C_0$, Critical Flow Ratio $Y$, Effective Green Time $g_i$, Saturation Flow Rate $s$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 1.0 (or One). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Webster cycle length and green splits: A 2-phase signalized intersection has critical lane volumes $v_1 = 600\text{ veh/h}$ (Phase 1) and $v_2 = 400\text{ veh/h}$ (Phase 2). Saturation flow rate is $s = 1800\text{ veh/h}$ for both phases. Total lost time is $t_L = 4.0\text{ s/phase} \implies L = 2 \times 4.0 = \mathbf{8.0\text{ s}}$.
   - Flow ratios: $y_1 = \frac{600}{1800} = \mathbf{0.3333}$; $y_2 = \frac{400}{1800} = \mathbf{0.2222}$;
   - Sum of flow ratios: $Y = 0.3333 + 0.2222 = \mathbf{0.5556} < 1.0$;
   - Denominator: $1 - Y = 1 - 0.5556 = \mathbf{0.4444}$;
   - Numerator: $1.5 L + 5 = 1.5(8.0) + 5 = 12.0 + 5.0 = \mathbf{17.0\text{ s}}$;
   - Optimum cycle length: $C_0 = \frac{17.0}{0.4444} = \mathbf{38.25\text{ s}} \implies \text{Adopt design cycle } C = \mathbf{40.0\text{ s}}$;
   - Total available green: $C - L = 40.0 - 8.0 = \mathbf{32.0\text{ s}}$;
   - Effective green Phase 1: $g_1 = \frac{0.3333}{0.5556} \times 32.0\text{ s} = 0.60 \times 32.0 = \mathbf{19.2\text{ s}}$;
   - Effective green Phase 2: $g_2 = \frac{0.2222}{0.5556} \times 32.0\text{ s} = 0.40 \times 32.0 = \mathbf{12.8\text{ s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "webster_optimal_signal_cycle_length_and_green_splits",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Webster's Optimal Signal Timing (F. V. Webster 1958)**\n• **Webster's Optimum Minimum-Delay Cycle Length Formulation:**\n$$\n\\mathbf{C_0 = \\frac{1.5 L + 5}{1 - Y}}\n$$\n  - **$L$:** Total lost time per cycle in seconds ($\\mathbf{L = \\sum t_{L,i}}$);\n  - **$Y$:** Sum of critical lane group flow ratios ($\\mathbf{Y = \\sum \\frac{v_i}{s_i} < 1.0}$);\n• **Effective Green Time Phase Allocation Formulation:**\n$$\n\\mathbf{g_i = \\left( \\frac{y_i}{Y} \\right) \\left( C - L \\right) \\quad \\left(\\sum g_i = C - L\\right)}\n$$\n• **Lane Group Capacity Formulation:** $\\mathbf{c_i = s_i \\cdot \\left( \\frac{g_i}{C} \\right)}$\n• **The Equal Saturation Invariant:** Allocating green time in direct proportion to flow ratios ($g_i \\propto y_i$) enforces **identical degree of saturation $X = v/c$ across all phases**, perfectly balancing delay and preventing one approach from bottlenecking the network!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design optimal signal cycle length and phase green allocations using Webster's method.",
      "orderItems": [
        "Determine the critical lane group design volumes (v1, v2, ...) and saturation flow rates (s1, s2, ...) for each phase",
        "Calculate the individual flow ratios: yi = vi / si and sum them to obtain total critical ratio Y = \u2211yi (verify Y < 1.0)",
        "Determine the total cycle lost time: L = \u2211(start-up loss + clearance loss) across all phases",
        "Calculate Webster's optimum cycle length: C0 = (1.5*L + 5) / (1 - Y) and select practical rounded cycle C",
        "Apportion effective green times to each phase: gi = (yi / Y) * (C - L) and verify minimum pedestrian walk intervals"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Signal Timing Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Optimum Cycle (C0)", "right": "C0 = (1.5L + 5) / (1 - Y), mathematical cycle length that minimizes average intersection vehicle delay" },
        { "left": "Critical Flow Ratio (Y)", "right": "Y = \u2211(v_crit / s), proportion of cycle time demanded by critical conflicting vehicular movements" },
        { "left": "Total Lost Time (L)", "right": "Time wasted per cycle due to driver starting sluggishness and yellow/red clearance intervals" },
        { "left": "Phase Green Split (gi)", "right": "gi = (yi/Y)*(C - L), effective green interval assigned to phase i based on its flow proportion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Webster's optimum cycle formula C0 = (1.5L + 5) / (1 - Y), the sum of critical flow ratios Y must strictly be less than exactly ___.",
      "blankAnswer": "1.0",
      "blankDistractors": ["0.5", "2.0", "10.0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-phase signal has critical volumes v1 = 600 veh/h, v2 = 400 veh/h, saturation flow s = 1800 veh/h for both, and total lost time L = 8.0 s. Flow ratios are y1 = 0.3333, y2 = 0.2222 (Y = 0.5556, 1 - Y = 0.4444). What is the Webster optimum cycle length C0 and the effective green time g1 for an adopted C = 40 s?",
      "options": [
        { "text": "C0 = 38.3 s and g1 = 19.2 s (C0 = (1.5*8.0 + 5) / (1 - 0.5556) = 17.0 / 0.4444 = 38.25 s \u2248 38.3 s; with C = 40 s: C - L = 32 s; g1 = (0.3333 / 0.5556) * 32 = 0.60 * 32 = 19.2 s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Webster's optimal signal timing method (Roger P. Roess *Traffic Engineering* Chapter 18; F. V. Webster 1958). 1. **Calculate Individual Flow Ratios ($y_i$):** - Phase 1 flow ratio: $$y_1 = \\frac{v_1}{s_1} = \\frac{600\\text{ veh/h}}{1800\\text{ veh/h}} = \\mathbf{0.3333}$$ - Phase 2 flow ratio: $$y_2 = \\frac{v_2}{s_2} = \\frac{400\\text{ veh/h}}{1800\\text{ veh/h}} = \\mathbf{0.2222}$$ - Total critical flow ratio sum: $$Y = y_1 + y_2 = 0.3333 + 0.2222 = \\mathbf{0.5556}$$ - Capacity feasibility check: Since $Y = 0.5556 < 1.00$, the intersection is **stable and under-saturated**! 2. **Calculate Webster's Optimum Cycle Length ($C_0$):** - Total cycle lost time: $L = 8.0\\text{ s}$. - Numerator: $$1.5 \\cdot L + 5 = 1.5(8.0\\text{ s}) + 5.0 = 12.0 + 5.0 = \\mathbf{17.0\\text{ s}}$$ - Denominator: $$1 - Y = 1 - 0.555556 = \\mathbf{0.444444}$$ - Optimum cycle length: $$C_0 = \\frac{17.0\\text{ s}}{0.444444} = \\mathbf{38.25\\text{ s} \\approx 38.3\\text{ s}}$$ 3. **Adopt Design Cycle \\& Compute Effective Green Times:** - Adopt rounded cycle length: $C = \\mathbf{40.0\\text{ s}}$. - Total available effective green time: $$G_{\\text{total}} = C - L = 40.0\\text{ s} - 8.0\\text{ s} = \\mathbf{32.0\\text{ s}}$$ - Phase 1 green time: $$g_1 = \\left( \\frac{y_1}{Y} \\right) \\cdot (C - L) = \\left( \\frac{0.3333}{0.5556} \\right) \\times 32.0\\text{ s} = 0.600 \\times 32.0\\text{ s} = \\mathbf{19.2\\text{ s}}$$ - Phase 2 green time: $$g_2 = \\left( \\frac{y_2}{Y} \\right) \\cdot (C - L) = \\left( \\frac{0.2222}{0.5556} \\right) \\times 32.0\\text{ s} = 0.400 \\times 32.0\\text{ s} = \\mathbf{12.8\\text{ s}}$$ Flawless Webster optimal signal timing and green split derivation!" },
        { "text": "C0 = 38.3 s and g1 = 16.0 s (Equal 50/50 split)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C0 = 60.0 s and g1 = 28.8 s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C0 = 20.0 s and g1 = 10.0 s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
