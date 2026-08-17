# Duofy Reusable Lesson Format: Signal Delay (Webster Equation & HCM Level of Service)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Traffic_Engineering_and_Signals`  
**Lesson Format Type:** `intersection_delay_and_hcm_level_of_service_analysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through vehicle control delay mechanics at signalized intersections, F. V. Webster's analytical delay formulation, the decomposition of delay into **Uniform Delay ($d_1$)** and **Random / Incremental Delay ($d_2$)**, green ratio ($\lambda = g / C$), degree of saturation ($X = v / c$), and the Highway Capacity Manual (HCM) **Level of Service (LOS A through F)** thresholds (TRB *Highway Capacity Manual* Chapter 19; Roger P. Roess *Traffic Engineering* 5th ed. Chapter 19; F. V. Webster 1958): formulate the **Webster Uniform Delay Formulation ($d_1$)**:
$$\mathbf{d_1 = \frac{C \left( 1 - \frac{g}{C} \right)^2}{2 \left( 1 - \frac{v}{s} \right)} = \frac{C (1 - \lambda)^2}{2 (1 - \lambda X)} \quad [\text{s/veh}]}$$
where:
1. **$C$:** Signal cycle length in seconds;
2. **$\lambda = \frac{g}{C}$:** Effective green time ratio;
3. **$X = \frac{v}{c} = \frac{v}{s \cdot \lambda}$:** Volume-to-capacity degree of saturation ($X \le 1.0$);
4. **$v / s$:** Flow ratio ($\frac{v}{s} = \lambda \cdot X$);
derive the **Total Control Delay Master Formulation ($d$)**:
$$\mathbf{d = d_1 \cdot PF + d_2 + d_3}$$
where:
- **$PF$:** Progression adjustment factor (platooning from coordinated signals);
- **$d_2$:** Incremental delay due to random vehicle arrivals and cycle overflow;
- **$d_3$:** Residual initial queue delay from previous saturated cycles;
master the **HCM Level of Service (LOS) Control Delay Thresholds**:
- **LOS A:** $d \le 10.0\text{ s/veh}$ (Free flow, no queues);
- **LOS B:** $10.0 < d \le 20.0\text{ s/veh}$ (Good progression);
- **LOS C:** $20.0 < d \le 35.0\text{ s/veh}$ (Fair progression, stable);
- **LOS D:** $35.0 < d \le 55.0\text{ s/veh}$ (Noticeable congestion, tolerable);
- **LOS E:** $55.0 < d \le 80.0\text{ s/veh}$ (Unstable, approaching capacity $X \approx 1.0$);
- **LOS F:** $d > 80.0\text{ s/veh}$ (Breakdown, gridlock, $X > 1.0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Webster Uniform Delay ($d_1 = \frac{C(1-\lambda)^2}{2(1-\lambda X)}$) & HCM LOS (A to F) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Uniform Delay and Assign HCM Level of Service Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | HCM Delay Component / LOS Grade & Technical Operational Characterization Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Highway Capacity Manual, an Intersection with an Average Control Delay Exceeding 80 Seconds per Vehicle Is Classified as LOS ___ (F / Level of Service F) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Traffic Operations Problem: Calculating Uniform Delay d_1 and Finding LOS for a Lane Group Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Signal Delay & HCM LOS (Webster 1958; HCM 2022; Roess 2018):
   - **Delay Formulations:**
     $$\mathbf{d_1 = \frac{C(1-\lambda)^2}{2(1-\lambda X)} = \frac{C(1-g/C)^2}{2(1-v/s)} \quad \Big| \quad \lambda = \frac{g}{C} \quad \Big| \quad X = \frac{v}{c} = \frac{v}{s\lambda}}$$
   - **HCM Signalized Intersection Level of Service (LOS) Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Level of Service } \text{LOS} & \textbf{Control Delay } d \ [\text{s/veh}] & \textbf{Operational Traffic Flow Characteristics} \\
     \hline
     \mathbf{\text{LOS A}} & \mathbf{d \le 10.0\text{ s}} & \text{Extremely favorable progression; most vehicles do not stop} \\
     \mathbf{\text{LOS B}} & 10.0 < d \le 20.0\text{ s} & \text{Good signal progression; short cycle lengths} \\
     \mathbf{\text{LOS C}} & 20.0 < d \le 35.0\text{ s} & \text{Fair progression; noticeable number of stopped vehicles} \\
     \mathbf{\text{LOS D}} & 35.0 < d \le 55.0\text{ s} & \text{Noticeable congestion; individual cycle failures begin} \\
     \mathbf{\text{LOS E}} & 55.0 < d \le 80.0\text{ s} & \text{Poor progression; high delay; operation at capacity limit} \\
     \mathbf{\text{LOS F}} & \mathbf{d > 80.0\text{ s}} & \mathbf{\text{Unacceptable delay; breakdown; oversaturation }} (X > 1.0) \\
     \hline
     \end{array}$$
   - **The Red-Time Quadratic Invariant:** Uniform delay $d_1$ scales with the square of effective red time **$r^2 = (C - g)^2 = C^2 (1 - \lambda)^2$**; longer cycle lengths with long red intervals dramatically worsen average vehicle delay!
2. **Slide 2 (`ordering`):** Provide 5 steps of delay calculation: (1) extract cycle length $C$, effective green time $g$, lane volume $v$, and saturation flow $s$, (2) compute green ratio $\lambda = g / C$ and capacity $c = s \cdot \lambda$, (3) compute degree of saturation $X = v / c$, (4) calculate Webster uniform delay: $d_1 = \frac{C (1 - \lambda)^2}{2 (1 - \lambda X)}$, (5) check total delay against HCM thresholds to assign Level of Service (LOS A through F)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Uniform Delay $d_1$, Incremental Delay $d_2$, Degree of Saturation $X = v/c$, LOS F Threshold $>80\text{ s}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of F (or Level of Service F). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating uniform delay and determining LOS: A signalized approach has cycle length $C = 80.0\text{ s}$, effective green time $g = 32.0\text{ s}$, approach volume $v = 600\text{ veh/h}$, and saturation flow rate $s = 1800\text{ veh/h}$.
   - Green ratio: $\lambda = \frac{g}{C} = \frac{32.0}{80.0} = \mathbf{0.400}$;
   - Approach capacity: $c = s \times \lambda = 1800 \times 0.400 = \mathbf{720\text{ veh/h}}$;
   - Degree of saturation: $X = \frac{v}{c} = \frac{600}{720} = \mathbf{0.8333}$;
   - Flow ratio: $\frac{v}{s} = \frac{600}{1800} = \mathbf{0.3333} = \lambda \cdot X$;
   - Numerator: $C (1 - \lambda)^2 = 80.0 \times (1 - 0.40)^2 = 80.0 \times (0.60)^2 = 80.0 \times 0.36 = \mathbf{28.80\text{ s}}$;
   - Denominator: $2 (1 - v/s) = 2 (1 - 0.3333) = 2 \times 0.6667 = \mathbf{1.3333}$;
   - Uniform delay: $d_1 = \frac{28.80}{1.3333} = \mathbf{21.60\text{ s/veh} \approx 21.6\text{ s}}$;
   - What is the uniform delay $d_1$ and its corresponding HCM Level of Service? ($d_1 = \mathbf{21.6\text{ s/veh}} \implies \text{Falls in } 20.0 < d \le 35.0\text{ s} \implies \mathbf{\text{LOS C}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "intersection_delay_and_hcm_level_of_service_analysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Intersection Delay \\& HCM Level of Service (HCM 7th ed.)**\n• **Webster Uniform Control Delay Formulation ($d_1$):**\n$$\n\\mathbf{d_1 = \\frac{C \\left( 1 - \\frac{g}{C} \\right)^2}{2 \\left( 1 - \\frac{v}{s} \\right)} = \\frac{C (1 - \\lambda)^2}{2 (1 - \\lambda X)} \\quad [\\text{s/veh}]}\n$$\n  - **$C$:** Signal cycle length ($\\text{s}$);\n  - **$\\lambda = \\frac{g}{C}$:** Effective green ratio;\n  - **$X = \\frac{v}{c} = \\frac{v}{s \\cdot \\lambda}$:** Degree of saturation ($v/c$ ratio);\n  - **$v / s$:** Volume-to-saturation flow ratio ($\\lambda \\cdot X$);\n• **HCM Level of Service (LOS) Control Delay Criteria:**\n  - **LOS A:** $d \\le 10.0\\text{ s/veh}$ (Uncongested, near-zero stops);\n  - **LOS B:** $10.0 < d \\le 20.0\\text{ s/veh}$ (Good progression);\n  - **LOS C:** $20.0 < d \\le 35.0\\text{ s/veh}$ (Satisfactory, stable);\n  - **LOS D:** $35.0 < d \\le 55.0\\text{ s/veh}$ (Noticeable queueing delays);\n  - **LOS E:** $55.0 < d \\le 80.0\\text{ s/veh}$ (Unstable, operating at capacity);\n  - **LOS F:** $\\mathbf{d > 80.0\\text{ s/veh}}$ (Severe oversaturation, breakdown);\n• **The Red Time Quadratic Invariant:** Uniform delay increases with the **square of red time $r^2 = (C - g)^2$**; unnecessarily long cycle lengths amplify intersection waiting times!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate uniform vehicle delay and determine the Highway Capacity Manual Level of Service.",
      "orderItems": [
        "Extract the signal timing parameters: cycle length C, effective green time g, arrival volume v, and saturation flow s",
        "Calculate the effective green ratio: \u03bb = g / C and lane group capacity: c = s * \u03bb",
        "Compute the degree of saturation: X = v / c and flow ratio: v / s",
        "Calculate the Webster uniform delay: d1 = [ C * (1 - \u03bb)^2 ] / [ 2 * (1 - v/s) ]",
        "Compare calculated control delay against HCM thresholds to assign the operational Level of Service (LOS A through F)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Intersection Delay Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Uniform Delay (d1)", "right": "Deterministic delay assuming smooth, perfectly uniform vehicle arrivals throughout the cycle" },
        { "left": "Incremental Delay (d2)", "right": "Stochastic delay caused by random vehicle clustering and cycle overflow failures" },
        { "left": "Degree of Saturation (X = v/c)", "right": "Ratio of demand volume to total lane group capacity measuring proximity to breakdown" },
        { "left": "LOS F Threshold (> 80 s)", "right": "Highway Capacity Manual standard defining unacceptable traffic congestion and severe queueing" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Highway Capacity Manual, a signalized intersection approach with an average control delay exceeding 80 seconds per vehicle is classified as LOS ___.",
      "blankAnswer": "F",
      "blankDistractors": ["A", "C", "E"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A signalized lane group has C = 80.0 s, g = 32.0 s (\u03bb = 0.40), v = 600 veh/h, and s = 1800 veh/h (v/s = 0.3333, c = 720 veh/h, X = 0.8333). Numerator is 80 * (0.60)^2 = 28.80 s. Denominator is 2 * (1 - 0.3333) = 1.3333. What is the uniform delay d1 and the resulting HCM Level of Service?",
      "options": [
        { "text": "d1 = 21.6 s/veh and LOS C (d1 = 28.80 / 1.3333 = 21.60 s/veh; since 20.0 < 21.6 \u2264 35.0 s, it corresponds to Level of Service C)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Webster's uniform delay equation and HCM Level of Service criteria (HCM 7th ed. Chapter 19; Roger P. Roess *Traffic Engineering* Chapter 19). 1. **Calculate Geometric Signal Ratios:** - Cycle length: $C = 80.0\\text{ s}$. - Effective green time: $g = 32.0\\text{ s}$. - Green ratio: $$\\lambda = \\frac{g}{C} = \\frac{32.0\\text{ s}}{80.0\\text{ s}} = \\mathbf{0.400}$$ - Red ratio: $$1 - \\lambda = 1 - 0.400 = \\mathbf{0.600}$$ 2. **Calculate Approach Capacity \\& Flow Parameters:** - Saturation flow: $s = 1800\\text{ veh/h}$. - Arrival volume: $v = 600\\text{ veh/h}$. - Lane group capacity: $$c = s \\cdot \\lambda = 1800\\text{ veh/h} \\times 0.400 = \\mathbf{720\\text{ veh/h}}$$ - Degree of saturation: $$X = \\frac{v}{c} = \\frac{600\\text{ veh/h}}{720\\text{ veh/h}} = \\mathbf{0.8333}$$ - Flow ratio: $$\\frac{v}{s} = \\frac{600}{1800} = \\mathbf{0.3333}$$ 3. **Calculate Webster Uniform Delay ($d_1$):** - Numerator: $$C (1 - \\lambda)^2 = 80.0\\text{ s} \\times (0.600)^2 = 80.0 \\times 0.360 = \\mathbf{28.80\\text{ s}}$$ - Denominator: $$2 \\left( 1 - \\frac{v}{s} \\right) = 2 (1 - 0.333333) = 2 \\times 0.666667 = \\mathbf{1.333333}$$ - Uniform delay: $$d_1 = \\frac{28.80\\text{ s}}{1.333333} = \\mathbf{21.60\\text{ s/veh} \\approx 21.6\\text{ s/veh}}$$ 4. **Assign HCM Level of Service (LOS):** - Referring to HCM delay brackets: $$20.0\\text{ s} < d_1 = 21.6\\text{ s/veh} \\le 35.0\\text{ s} \\implies \\mathbf{\\text{LOS C}}$$ Flawless intersection delay and Level of Service derivation!" },
        { "text": "d1 = 21.6 s/veh and LOS B (Misclassified threshold)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d1 = 14.4 s/veh and LOS B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d1 = 43.2 s/veh and LOS D", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
