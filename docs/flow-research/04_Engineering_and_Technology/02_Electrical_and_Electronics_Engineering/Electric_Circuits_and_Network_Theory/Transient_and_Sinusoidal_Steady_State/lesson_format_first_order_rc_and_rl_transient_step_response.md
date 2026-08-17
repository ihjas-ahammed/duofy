# Duofy Reusable Lesson Format: First-Order Circuits (RC & RL Transient Step Response)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Transient_and_Sinusoidal_Steady_State`  
**Lesson Format Type:** `first_order_rc_and_rl_transient_step_response`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through first-order differential circuit dynamics, state variable continuity, time constant determination, and the universal step-response formulation for RC and RL networks (Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 7; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapter 7): master the **Universal First-Order Step Response Equation**:
$$\mathbf{x(t) = x(\infty) + \left[ x(0^+) - x(\infty) \right] e^{-t/\tau} \quad (t \ge 0)}$$
where $x(t)$ represents capacitor voltage $v_C(t)$ or inductor current $i_L(t)$; master the **Time Constant Formulations**:
$$\mathbf{\tau_{RC} = R_{th} \cdot C \quad \Big| \quad \mathbf{\tau_{RL} = \frac{L}{R_{th}}}}$$
where $R_{th}$ is the Thévenin equivalent resistance seen by the storage element for $t > 0$; enforce the **Energy Storage Continuity Invariants**:
$$\mathbf{v_C(0^+) = v_C(0^-) \quad (\text{Capacitor Voltage Continuity})} \quad \Big| \quad \mathbf{i_L(0^+) = i_L(0^-) \quad (\text{Inductor Current Continuity})}$$
and calculate the **Settling Time Thresholds** ($t = 1\tau \to 63.2\%$ transition; $t = 3\tau \to 95.0\%$; $t = 5\tau \to 99.3\%$ steady-state settling).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Universal Step Equation ($x(t) = x(\infty) + [x(0^+)-x(\infty)]e^{-t/\tau}$), Time Constants & Continuity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve the Transient Voltage Response in a Switched RC Circuit Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | First-Order Circuit Variable / Transient Metric & Technical Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Because an Inductor Opposes Instantaneous Changes in Stored Magnetic Energy, the Inductor Current at t = 0+ Exactly Equals i_L at t = 0- by State ___ (Continuity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Transient Circuit Problem: Calculating the Instantaneous Voltage Across a Switched Capacitor at t = 2 ms Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State First-Order RC/RL Step Response (Alexander & Sadiku 2021; Nilsson 2020):
   - **Universal Step Formulation:**
     $$\mathbf{x(t) = x(\infty) + \left[x(0^+) - x(\infty)\right] e^{-t/\tau} \quad \Big| \quad \tau_{RC} = R_{th} C \quad \Big| \quad \tau_{RL} = \frac{L}{R_{th}}}$$
   - **Continuity Invariants Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Storage Element} & \textbf{Continuous State Variable} & \textbf{Behavior at } t = 0^+ & \textbf{DC Steady-State } (t \to \infty) \\
     \hline
     \mathbf{\text{Capacitor (Electric)}} & \mathbf{v_C(0^+) = v_C(0^-)} & \text{Independent voltage source } v_C(0^+) & \mathbf{\text{Open Circuit } (i_C = 0)} \\
     \mathbf{\text{Inductor (Magnetic)}} & \mathbf{i_L(0^+) = i_L(0^-)} & \text{Independent current source } i_L(0^+) & \mathbf{\text{Short Circuit } (v_L = 0)} \\
     \hline
     \end{array}$$
   - **The 5-Tau Settling Rule:** In electrical engineering, a transient is considered **$100\%$ fully settled at $t \ge 5\tau$ ($e^{-5} \approx 0.0067 \implies 99.33\%$ settled)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of first-order transient analysis: (1) analyze circuit for $t < 0$ to find initial pre-switching energy state $v_C(0^-)$ or $i_L(0^-)$, (2) apply state continuity to establish initial post-switching state $v_C(0^+) = v_C(0^-)$ or $i_L(0^+) = i_L(0^-)$, (3) analyze circuit for $t \to \infty$ with storage elements in DC steady state (C open, L short) to find final value $x(\infty)$, (4) deactivate independent sources for $t > 0$ to calculate Thévenin resistance $R_{th}$ seen by storage element and evaluate time constant $\tau$, (5) assemble into universal response formula $x(t) = x(\infty) + [x(0^+) - x(\infty)] e^{-t/\tau}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Universal Step Formula, RC Time Constant $\tau = RC$, RL Time Constant $\tau = L/R$, Capacitor Continuity $v_C(0^+)=v_C(0^-)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Continuity. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating transient capacitor voltage: A series RC circuit has $R = 1.0\text{ k}\Omega = 1000\,\Omega$ and $C = 2.0\text{ }\mu\text{F} = 2.0 \times 10^{-6}\text{ F}$. The capacitor is initially uncharged ($v_C(0) = 0\text{ V}$). At $t = 0$, a DC step voltage $V_s = 10.0\text{ V}$ is applied. What is the capacitor voltage $v_C(t)$ at time $t = 2.0\text{ ms}$? ($\tau = R C = (1000\,\Omega)(2.0 \times 10^{-6}\text{ F}) = 0.0020\text{ s} = \mathbf{2.0\text{ ms}}$; $t = 2.0\text{ ms} = 1\tau$; $v_C(t) = V_s(1 - e^{-t/\tau}) = 10.0(1 - e^{-1}) = 10.0(1 - 0.367879) = 10.0(0.63212) = \mathbf{6.32\text{ V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "first_order_rc_and_rl_transient_step_response",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: First-Order RC \\& RL Transient Step Response (Alexander \\& Sadiku)**\n• **Universal Step Response Formulation ($t \\ge 0$):**\n$$\n\\mathbf{x(t) = x(\\infty) + \\left[ x(0^+) - x(\\infty) \\right] e^{-t/\\tau} \\quad \\Big| \\quad \\tau_{RC} = R_{th} C \\quad \\Big| \\quad \\tau_{RL} = \\frac{L}{R_{th}}}\n$$\n• **Energy Storage Continuity Invariants:**\n$$\n\\mathbf{v_C(0^+) = v_C(0^-) \\quad (\\text{Capacitor Voltage Continuity})} \\quad \\Big| \\quad \\mathbf{i_L(0^+) = i_L(0^-) \\quad (\\text{Inductor Current Continuity})}\n$$\n• **DC Steady-State Behavior ($t \\to \\infty$):**\n  - **Capacitor:** Acts as an **Open Circuit** ($i_C(\\infty) = 0\\text{ A}$);\n  - **Inductor:** Acts as a **Short Circuit** ($v_L(\\infty) = 0\\text{ V}$).\n• **The 5-Tau Rule:** At $t = 5\\tau$, $e^{-5} = 0.0067$, meaning the transient is **99.33\\% fully settled to steady state**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve the transient response of a switched first-order RC or RL circuit.",
      "orderItems": [
        "Analyze the circuit for t < 0 to find the initial stored energy state: v_C(0-) or i_L(0-)",
        "Apply state variable continuity to establish initial post-switch conditions: v_C(0+) = v_C(0-) or i_L(0+) = i_L(0-)",
        "Analyze the circuit for t -> infinity in DC steady state (C open, L short) to determine final value x(infinity)",
        "Deactivate independent sources for t > 0 to calculate Thévenin resistance R_th and determine time constant tau",
        "Assemble the universal step response equation: x(t) = x(infinity) + [x(0+) - x(infinity)] * exp(-t / tau)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each First-Order Transient Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Universal Step Formula", "right": "x(t) = x(\u221e) + [x(0+) - x(\u221e)]*exp(-t/\u03c4), expressing the exponential transition between initial and final states" },
        { "left": "RC Time Constant (\u03c4 = RC)", "right": "Time required for a charging capacitor to reach 63.2% of its final steady-state voltage" },
        { "left": "RL Time Constant (\u03c4 = L/R)", "right": "Characteristic time scale governing exponential current growth and decay in inductive circuits" },
        { "left": "Capacitor Continuity", "right": "vC(0+) = vC(0-), principle that electric field energy cannot change instantaneously in zero time" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because magnetic field energy cannot change in zero time, inductor current i_L(0+) equals i_L(0-) by state ___.",
      "blankAnswer": "continuity",
      "blankDistractors": ["superposition", "conductance", "damping"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A series RC circuit with R = 1.0 k\u03a9 and C = 2.0 \u03bcF has an initially uncharged capacitor (vC(0) = 0 V). At t = 0, a DC step voltage Vs = 10.0 V is applied. What is the capacitor voltage vC(t) at time t = 2.0 ms?",
      "options": [
        { "text": "vC = 6.32 V (\u03c4 = R*C = 1000 * 2*10^-6 = 2.0 ms; at t = 1\u03c4, vC = 10.0 * (1 - e^-1) = 10.0 * (1 - 0.3679) = 6.32 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the first-order RC step response equation (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 7). 1. **Calculate the Circuit Time Constant ($\\tau$):** $$\\tau = R \\cdot C = (1000\\,\\Omega) \\times (2.0 \\times 10^{-6}\\text{ F}) = 0.0020\\text{ s} = \\mathbf{2.0\\text{ ms}}$$ 2. **Identify Initial and Final States:** - Initial voltage: $v_C(0^+) = v_C(0^-) = 0.0\\text{ V}$. - Final DC steady-state voltage: $v_C(\\infty) = V_s = 10.0\\text{ V}$ (capacitor behaves as open circuit). 3. **Assemble Universal Response Formula:** $$v_C(t) = v_C(\\infty) + \\left[ v_C(0^+) - v_C(\\infty) \\right] e^{-t/\\tau} = 10.0 + [0 - 10.0] e^{-t/0.002} = 10.0 \\left( 1 - e^{-t/0.002} \\right)$$ 4. **Evaluate at $t = 2.0\\text{ ms}$ ($t = 1\\tau$):** $$v_C(2.0\\text{ ms}) = 10.0 \\left( 1 - e^{-1} \\right) = 10.0 (1 - 0.367879) = 10.0 (0.63212) = \\mathbf{6.3212\\text{ V} \\approx 6.32\\text{ V}}$$ 5. **Physical Meaning:** After exactly one time constant ($1\\tau$), any first-order step response completes **$63.2\\%$ of its total trajectory**!" },
        { "text": "vC = 5.00 V (Linear half-way point)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "vC = 3.68 V (The remaining voltage 10*e^-1)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "vC = 8.65 V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
