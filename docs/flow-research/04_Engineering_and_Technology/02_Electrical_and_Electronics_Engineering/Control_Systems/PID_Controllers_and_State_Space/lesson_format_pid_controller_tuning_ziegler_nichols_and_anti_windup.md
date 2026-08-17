# Duofy Reusable Lesson Format: Industrial PID Control (Ziegler-Nichols & Anti-Windup)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / PID_Controllers_and_State_Space`  
**Lesson Format Type:** `pid_controller_tuning_ziegler_nichols_and_anti_windup`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical mechanisms of Proportional-Integral-Derivative ($\text{PID}$) feedback control, transfer function representations, empirical tuning via the Ziegler-Nichols Ultimate Gain / Oscillation method ($K_{cr}, P_{cr}$), derivative kick mitigation, and actuator saturation integral anti-windup clamping algorithms in industrial process automation (John G. Ziegler & Nathaniel B. Nichols 1942; Karl Johan Åström *PID Controllers* Chapter 2; Katsuhiko Ogata *Modern Control Engineering* Chapter 8): formulate the **Continuous Parallel Three-Term PID Controller**:
$$\mathbf{u(t) = K_p \left( e(t) + \frac{1}{T_i} \int_0^t e(\tau) d\tau + T_d \frac{de(t)}{dt} \right) \Longleftrightarrow \mathbf{G_c(s) = K_p + \frac{K_i}{s} + K_d s = \frac{K_d s^2 + K_p s + K_i}{s}}}$$
master the **Ziegler-Nichols Frequency-Response / Ultimate Oscillation Tuning Matrix**:
$$\begin{array}{|l|c|c|c|c|c|}
\hline
\textbf{Controller Form} & K_p & T_i & T_d & K_i = K_p / T_i & K_d = K_p T_d \\
\hline
\mathbf{\text{P (Proportional)}} & 0.50 K_{cr} & \infty & 0 & 0 & 0 \\
\mathbf{\text{PI (Proportional-Integral)}} & 0.45 K_{cr} & \frac{P_{cr}}{1.2} & 0 & \frac{0.54 K_{cr}}{P_{cr}} & 0 \\
\mathbf{\text{PID (Three-Term)}} & \mathbf{0.60 K_{cr}} & \mathbf{0.50 P_{cr}} & \mathbf{0.125 P_{cr}} & \mathbf{\frac{1.2 K_{cr}}{P_{cr}}} & \mathbf{0.075 K_{cr} P_{cr}} \\
\hline
\end{array}$$
(where $K_{cr}$ is the ultimate proportional gain driving the closed-loop system into sustained marginal oscillation and $P_{cr} = \frac{2\pi}{\omega_{cr}}$ is the period of oscillation); and formulate **Integral Anti-Windup Protection**:
$$\mathbf{\text{When } |u(t)| \ge u_{\text{sat}}, \quad \text{Halt or Clamp } \frac{d}{dt}\left[\int e(t) dt\right] = 0}$$
(preventing massive overshoot and lag caused by saturated actuators).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PID Formulation ($G_c(s) = K_p + \frac{K_i}{s} + K_d s$), Ziegler-Nichols ($K_p = 0.6 K_{cr}$) & Anti-Windup Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Tune an Industrial PID Controller via Ziegler-Nichols Ultimate Gain Method Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | PID Control Term / Tuning Parameter & Technical Closed-Loop Physical Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Ziegler-Nichols Frequency-Response Tuning for a Full PID Controller, the Proportional Gain Kp Is Set to Exactly 0.6 Times the ___ Gain (Ultimate / Critical / Kcr) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Control Problem: Calculating Kp, Ki, and Kd for a Plant with Critical Gain Kcr = 30 and Period Pcr = 4s Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PID Control & Ziegler-Nichols (Ziegler & Nichols 1942; Åström 2006; Ogata 2010):
   - **PID Transfer Function & Z-N Formulations:**
     $$\mathbf{G_c(s) = K_p + \frac{K_i}{s} + K_d s \quad \Big| \quad K_p = 0.60 K_{cr} \quad \Big| \quad T_i = 0.50 P_{cr} \quad \Big| \quad T_d = 0.125 P_{cr}}$$
   - **Three-Term Physical Action Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Term} & \textbf{Physical Nature} & \textbf{Primary Advantage} & \textbf{Potential Hazard} \\
     \hline
     \mathbf{\text{Proportional } (K_p)} & \text{Present Error } K_p e(t) & \text{Speeds up rise time, reduces error} & \text{High gain causes instability; } e_{ss} \neq 0 \\
     \mathbf{\text{Integral } (K_i)} & \text{Past Accumulated } K_i \int e dt & \mathbf{\text{Guarantees zero steady error } (e_{ss} = 0)} & \mathbf{\text{Reduces phase margin; Integral Windup}} \\
     \mathbf{\text{Derivative } (K_d)} & \text{Future Predicted } K_d \frac{de}{dt} & \mathbf{\text{Adds phase lead damping, slashes overshoot}} & \mathbf{\text{Amplifies high-frequency sensor noise}} \\
     \hline
     \end{array}$$
   - **The Integral Anti-Windup Invariant:** When actuator reaches maximum physical limits (valves $100\%$ open or motor voltage $+24\text{V}$), **integral error accumulation MUST be frozen** to prevent delayed recovery!
2. **Slide 2 (`ordering`):** Provide 5 steps of Z-N PID tuning: (1) set integral gain $K_i = 0$ ($T_i = \infty$) and derivative gain $K_d = 0$ ($T_d = 0$), (2) increase proportional gain $K_p$ gradually until the closed-loop system exhibits sustained, stable sinusoidal oscillations, (3) record the critical ultimate gain $K_{cr}$ and measure the oscillation period $P_{cr} = 2\pi / \omega_{cr}$, (4) compute PID parameters: $K_p = 0.60 K_{cr}$, $T_i = 0.50 P_{cr}$, $T_d = 0.125 P_{cr}$, (5) implement gains in the controller and configure integral anti-windup clamping to protect against actuator saturation!
3. **Slide 3 (`matching`):** Pair 4 concepts (Proportional Gain $K_p$, Integral Action $K_i/s$, Derivative Damping $K_d s$, Integral Anti-Windup) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Ultimate (or Critical or Kcr). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating PID gains via Z-N: An industrial chemical reactor under proportional control reaches sustained sinusoidal oscillations when the controller gain is raised to $K_{cr} = 30.0$. The measured oscillation period is $P_{cr} = 4.0\text{ seconds}$. Using the classical Ziegler-Nichols frequency response tuning rules for a full three-term PID controller, what are the exact values for $K_p$, $K_i$, and $K_d$? ($K_p = 0.60 K_{cr} = 0.60(30.0) = \mathbf{18.0}$; $T_i = 0.50 P_{cr} = 0.50(4.0) = 2.0\text{ s} \implies K_i = \frac{K_p}{T_i} = \frac{18.0}{2.0} = \mathbf{9.0\text{ s}^{-1}}$; $T_d = 0.125 P_{cr} = 0.125(4.0) = 0.50\text{ s} \implies K_d = K_p T_d = 18.0(0.50) = \mathbf{9.0\text{ s}}$; Final tuned gains: $K_p = \mathbf{18.0}$, $K_i = \mathbf{9.0}$, $K_d = \mathbf{9.0}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pid_controller_tuning_ziegler_nichols_and_anti_windup",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Industrial PID Control \\& Ziegler-Nichols Tuning (Ziegler \\& Nichols 1942)**\n• **Continuous Parallel Three-Term PID Controller Formulation:**\n$$\n\\mathbf{G_c(s) = K_p \\left( 1 + \\frac{1}{T_i s} + T_d s \\right) = K_p + \\frac{K_i}{s} + K_d s \\quad \\left(K_i = \\frac{K_p}{T_i}, \\ K_d = K_p T_d\\right)}\n$$\n• **Ziegler-Nichols Ultimate Frequency Response Tuning Rules:**\n$$\n\\begin{array}{|l|c|c|c|c|}\n\\hline\n\\textbf{Controller Structure} & \\mathbf{K_p} & \\mathbf{T_i} & \\mathbf{T_d} & \\textbf{Dynamic Effect} \\\\\n\\hline\n\\mathbf{\\text{Proportional (P)}} & 0.50 K_{cr} & \\infty & 0 & \\text{Faster response, leaves finite } e_{ss} \\\\\n\\mathbf{\\text{PI Controller}} & 0.45 K_{cr} & P_{cr} / 1.2 & 0 & \\mathbf{\\text{Guarantees } e_{ss} = 0\\text{, slows down settling}} \\\\\n\\mathbf{\\text{Full PID}} & \\mathbf{0.60 K_{cr}} & \\mathbf{0.50 P_{cr}} & \\mathbf{0.125 P_{cr}} & \\mathbf{\\text{Zero } e_{ss} + \\text{Phase-lead damping}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Integral Anti-Windup Invariant:** When physical actuators reach full saturation ($|u(t)| \\ge u_{\\text{sat}}$), **integral accumulation must be clamped ($\\\\dot{I} = 0$)** to prevent runaway overshoot and recovery delay!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to tune an industrial PID controller using the Ziegler-Nichols Ultimate Gain / Oscillation method.",
      "orderItems": [
        "Disable integral (Ti = \u221e) and derivative (Td = 0) control actions, leaving only pure proportional feedback",
        "Gradually increase proportional gain Kp until the closed-loop system reaches sustained, steady sinusoidal oscillations",
        "Record the critical ultimate gain Kcr and measure the exact oscillation period Pcr (in seconds)",
        "Calculate the three PID parameters: Kp = 0.60*Kcr, Ti = 0.50*Pcr, and Td = 0.125*Pcr (Ki = Kp/Ti, Kd = Kp*Td)",
        "Implement gains in the control loop and enable integral anti-windup clamping to prevent actuator saturation windup"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each PID Control Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Proportional Term (Kp)", "right": "Generates control effort proportional to current error, decreasing rise time but unable to eliminate steady-state offset" },
        { "left": "Integral Term (Ki / s)", "right": "Accumulates past error over time to force steady-state tracking error strictly to zero (ess = 0)" },
        { "left": "Derivative Term (Kd * s)", "right": "Predicts future error trajectory from rate of change, providing phase-lead damping to reduce overshoot" },
        { "left": "Integral Anti-Windup", "right": "Algorithm pausing integration when actuator saturates, eliminating massive overshoot upon setpoint steps" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Ziegler-Nichols frequency-response tuning for a full PID controller, the proportional gain Kp is set to 0.6 times the ___ gain.",
      "blankAnswer": "ultimate",
      "blankDistractors": ["minimum", "average", "settling"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An industrial temperature plant reaches sustained sinusoidal oscillations when proportional gain is adjusted to critical value Kcr = 30.0. The measured period of oscillation is Pcr = 4.0 seconds. Using Ziegler-Nichols closed-loop tuning for a full PID controller, what are Kp, Ki, and Kd?",
      "options": [
        { "text": "Kp = 18.0, Ki = 9.0 s^-1, and Kd = 9.0 s (Kp = 0.60*30 = 18.0; Ti = 0.50*4.0 = 2.0 s \u2192 Ki = 18/2 = 9.0; Td = 0.125*4.0 = 0.50 s \u2192 Kd = 18*0.50 = 9.0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Ziegler-Nichols frequency response tuning formulas (Katsuhiko Ogata *Modern Control Engineering* Chapter 8). 1. **Identify Critical Parameters:** - Ultimate Gain: $K_{cr} = 30.0$. - Ultimate Oscillation Period: $P_{cr} = 4.0\\text{ s}$. 2. **Compute Proportional Gain ($K_p$):** $$K_p = 0.60 \\times K_{cr} = 0.60 \\times 30.0 = \\mathbf{18.0}$$ 3. **Compute Integral Parameters ($T_i, K_i$):** - Integral Time Constant: $$T_i = 0.50 \\times P_{cr} = 0.50 \\times 4.0\\text{ s} = 2.0\\text{ s}$$ - Integral Gain: $$K_i = \\frac{K_p}{T_i} = \\frac{18.0}{2.0\\text{ s}} = \\mathbf{9.0\\text{ s}^{-1}}$$ 4. **Compute Derivative Parameters ($T_d, K_d$):** - Derivative Time Constant: $$T_d = 0.125 \\times P_{cr} = 0.125 \\times 4.0\\text{ s} = 0.50\\text{ s}$$ - Derivative Gain: $$K_d = K_p \\times T_d = 18.0 \\times 0.50\\text{ s} = \\mathbf{9.0\\text{ s}}$$ 5. **Final Controller Transfer Function:** $$G_c(s) = 18.0 + \\frac{9.0}{s} + 9.0 s = \\frac{9.0 s^2 + 18.0 s + 9.0}{s} = \\frac{9.0(s + 1)^2}{s}$$ Flawless Ziegler-Nichols PID tuning calculation!" },
        { "text": "Kp = 15.0, Ki = 7.5 s^-1, and Kd = 3.75 s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Kp = 18.0, Ki = 4.5 s^-1, and Kd = 18.0 s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Kp = 30.0, Ki = 15.0 s^-1, and Kd = 7.5 s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
