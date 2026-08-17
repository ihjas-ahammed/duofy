# Duofy Reusable Lesson Format: Closed-Loop Systems (Servo vs Regulatory Transfer Functions)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Process_Control_and_Instrumentation / Feedback_Control_and_Process_Dynamics`  
**Lesson Format Type:** `closed_loop_servo_regulatory_transfer_functions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through block diagram algebra for closed-loop feedback control loops, the distinction between **Servo Problems (Setpoint Tracking: $D(s) = 0, Y_{\text{sp}}(s) \ne 0$)** and **Regulatory Problems (Disturbance Rejection: $Y_{\text{sp}}(s) = 0, D(s) \ne 0$)**, the forward-path transfer function ($G_{\text{forward}}$), the open-loop transfer function ($G_{\text{OL}}(s) = G_c G_v G_p G_m$), the universal closed-loop block diagram formula ($\frac{\text{Output}}{\text{Input}} = \frac{G_{\text{forward}}}{1 + G_{\text{OL}}}$), the **Closed-Loop Characteristic Equation ($1 + G_{\text{OL}}(s) = 0$)**, and closed-loop pole stability analysis via Routh-Hurwitz criteria (Dale E. Seborg *Process Dynamics and Control* 4th ed. Chapter 11; George Stephanopoulos *Chemical Process Control* Chapter 11): formulate the **Universal Closed-Loop Transfer Function Master Formula**:
$$\mathbf{\frac{Y(s)}{\text{Input}(s)} = \frac{\prod (\text{Transfer Functions in Forward Path Between Input and Output})}{1 + \prod (\text{All Transfer Functions in the Closed Feedback Loop})}}$$
derive the **Closed-Loop Servo Transfer Function ($Y(s) / Y_{\text{sp}}(s)$ with $D(s) = 0$)**:
$$\mathbf{\frac{Y(s)}{Y_{\text{sp}}(s)} = \frac{G_c(s) \cdot G_v(s) \cdot G_p(s)}{1 + G_c(s) \cdot G_v(s) \cdot G_p(s) \cdot G_m(s)} = \frac{G_c G_v G_p}{1 + G_{\text{OL}}(s)}}$$
derive the **Closed-Loop Regulatory Transfer Function ($Y(s) / D(s)$ with $Y_{\text{sp}}(s) = 0$)**:
$$\mathbf{\frac{Y(s)}{D(s)} = \frac{G_d(s)}{1 + G_c(s) \cdot G_v(s) \cdot G_p(s) \cdot G_m(s)} = \frac{G_d(s)}{1 + G_{\text{OL}}(s)}}$$
master the **Closed-Loop Stability Invariant**:
- Both Servo and Regulatory responses share the exact same denominator, the **Characteristic Equation**:
  $$\mathbf{1 + G_{\text{OL}}(s) = 1 + G_c(s) \cdot G_v(s) \cdot G_p(s) \cdot G_m(s) = 0}$$
- A closed-loop feedback system is stable if and only if **all roots of the characteristic equation have strictly negative real parts ($\text{Re}(s) < 0$)**, residing in the left-half of the complex $s$-plane.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Servo ($\frac{G_c G_v G_p}{1 + G_{\text{OL}}}$), Regulatory ($\frac{G_d}{1 + G_{\text{OL}}}$) & Characteristic Eq ($1 + G_{\text{OL}}=0$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Derive Closed-Loop Transfer Functions and Formulate Characteristic Equation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Closed-Loop Element / Transfer Function Entity & Technical Block Diagram Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Both the Closed-Loop Servo and Regulatory Transfer Functions Share the Exact Same Denominator Known as the Closed-Loop ___ Equation $1 + G_{\text{OL}}(s) = 0$ (Characteristic / Stability) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Process Control Problem: Formulating Closed-Loop Servo Transfer Function for a Proportional Controlled Heated Tank Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Closed-Loop Transfer Function Mechanics (Seborg 2016; Stephanopoulos 1984):
   - **Closed-Loop Formulations:**
     $$\mathbf{\frac{Y}{Y_{\text{sp}}} = \frac{G_c G_v G_p}{1 + G_{\text{OL}}} \quad \Big| \quad \frac{Y}{D} = \frac{G_d}{1 + G_{\text{OL}}} \quad \Big| \quad G_{\text{OL}}(s) = G_c G_v G_p G_m \quad \Big| \quad 1 + G_{\text{OL}}(s) = 0}$$
   - **Servo vs Regulatory Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Operational Problem} & \textbf{Setpoint } Y_{\text{sp}} & \textbf{Disturbance } D & \textbf{Primary Industrial Engineering Goal} \\
     \hline
     \mathbf{\text{Servo (Tracking)}} & \mathbf{Y_{\text{sp}}(s) \ne 0} & \mathbf{D(s) = 0} & \mathbf{\text{Drive controlled variable } y(t) \text{ rapidly to match new target setpoint}} \\
     \mathbf{\text{Regulatory (Rejection)}} & \mathbf{Y_{\text{sp}}(s) = 0} & \mathbf{D(s) \ne 0} & \mathbf{\text{Hold controlled variable steady despite load changes (feed flow, ambient temp)}} \\
     \hline
     \end{array}$$
   - **The Common Denominator Invariant:** Regardless of whether the excitation is a setpoint step or an external disturbance, **the closed-loop stability is identical**, governed entirely by the roots of $1 + G_{\text{OL}}(s) = 0$!
2. **Slide 2 (`ordering`):** Provide 5 steps of closed-loop derivation: (1) identify all block diagram transfer functions: controller $G_c(s)$, valve $G_v(s)$, process $G_p(s)$, disturbance $G_d(s)$, and sensor transmitter $G_m(s)$, (2) compute the open-loop transfer function: $G_{\text{OL}}(s) = G_c G_v G_p G_m$, (3) formulate the characteristic equation: $1 + G_{\text{OL}}(s) = 0$, (4) identify the forward path between setpoint and output to construct servo transfer function: $\frac{Y}{Y_{\text{sp}}} = \frac{G_c G_v G_p}{1 + G_{\text{OL}}}$, (5) identify the forward path from disturbance to output to construct regulatory transfer function: $\frac{Y}{D} = \frac{G_d}{1 + G_{\text{OL}}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Servo Transfer Function, Regulatory Transfer Function, Open-Loop Transfer Function $G_{\text{OL}}$, Characteristic Equation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Characteristic (or Stability). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on formulating closed-loop transfer function: A liquid heating tank has process $G_p(s) = \frac{2.0}{5.0 s + 1}$, control valve $G_v(s) = 1.0$, sensor transmitter $G_m(s) = 1.0$, and proportional controller $G_c(s) = K_c = 4.0$.
   - Open-loop transfer function: $G_{\text{OL}}(s) = G_c G_v G_p G_m = 4.0 \times 1.0 \times \frac{2.0}{5.0 s + 1} \times 1.0 = \frac{8.0}{5.0 s + 1}$;
   - Characteristic equation denominator: $1 + G_{\text{OL}}(s) = 1 + \frac{8.0}{5.0 s + 1} = \frac{5.0 s + 1 + 8.0}{5.0 s + 1} = \frac{5.0 s + 9.0}{5.0 s + 1}$;
   - Forward path numerator: $G_c G_v G_p = \frac{8.0}{5.0 s + 1}$;
   - Closed-loop servo transfer function: $\frac{Y(s)}{Y_{\text{sp}}(s)} = \frac{8.0 / (5.0 s + 1)}{(5.0 s + 9.0) / (5.0 s + 1)} = \frac{8.0}{5.0 s + 9.0} = \frac{8/9}{(5/9) s + 1} = \frac{0.8889}{0.5556 s + 1}$;
   - Note closed-loop gain $K_{\text{CL}} = 8/9 = 0.8889 \implies \text{Offset} = 1 - 0.8889 = \mathbf{0.1111 = 11.1\%}$;
   - What is the closed-loop servo transfer function $\frac{Y(s)}{Y_{\text{sp}}(s)}$? ($\frac{Y(s)}{Y_{\text{sp}}(s)} = \mathbf{\frac{8.0}{5.0 s + 9.0}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "closed_loop_servo_regulatory_transfer_functions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Closed-Loop Feedback Control (Dale E. Seborg \\& Stephanopoulos)**\n• **Closed-Loop Servo Transfer Function Master Formulation ($D = 0$):**\n$$\n\\mathbf{\\frac{Y(s)}{Y_{\\text{sp}}(s)} = \\frac{G_c(s) \\cdot G_v(s) \\cdot G_p(s)}{1 + G_c(s) \\cdot G_v(s) \\cdot G_p(s) \\cdot G_m(s)} = \\frac{G_{\\text{forward}}}{1 + G_{\\text{OL}}(s)}}\n$$\n• **Closed-Loop Regulatory Transfer Function Master Formulation ($Y_{\\text{sp}} = 0$):**\n$$\n\\mathbf{\\frac{Y(s)}{D(s)} = \\frac{G_d(s)}{1 + G_c(s) \\cdot G_v(s) \\cdot G_p(s) \\cdot G_m(s)} = \\frac{G_d(s)}{1 + G_{\\text{OL}}(s)}}\n$$\n• **Closed-Loop Characteristic Equation:**\n$$\n\\mathbf{1 + G_{\\text{OL}}(s) = 1 + G_c(s) \\cdot G_v(s) \\cdot G_p(s) \\cdot G_m(s) = 0}\n$$\n• **The Stability Equivalence Invariant:** Both servo and regulatory responses share **identical denominator roots**; a feedback loop's stability, damping, and natural frequency are intrinsic system properties completely independent of input disturbances!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to derive the closed-loop transfer functions and evaluate feedback loop stability.",
      "orderItems": [
        "Identify the individual transfer functions for all loop components: controller Gc, valve Gv, process Gp, disturbance Gd, and sensor Gm",
        "Multiply all loop components together to form the open-loop transfer function: G_OL(s) = Gc * Gv * Gp * Gm",
        "Formulate the closed-loop characteristic equation: 1 + G_OL(s) = 0",
        "Determine the forward-path transfer function from setpoint to output (Gc*Gv*Gp) to construct the servo transfer function: Y/Ysp",
        "Find the roots (poles) of the characteristic equation and verify that all real parts are strictly negative for stability"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Closed-Loop Transfer Function Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Servo Transfer Function", "right": "Y(s)/Ysp(s) = (Gc*Gv*Gp) / (1 + G_OL), closed-loop response describing how output tracks setpoint changes" },
        { "left": "Regulatory Transfer Function", "right": "Y(s)/D(s) = Gd / (1 + G_OL), closed-loop response describing how output rejects external load disturbances" },
        { "left": "Open-Loop Transfer Function (G_OL)", "right": "G_OL(s) = Gc*Gv*Gp*Gm, product of all transfer functions encountered traveling once around feedback loop" },
        { "left": "Characteristic Equation", "right": "1 + G_OL(s) = 0, fundamental denominator equation whose roots (poles) dictate closed-loop stability" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Both the closed-loop servo and regulatory transfer functions share the exact same denominator known as the closed-loop ___ equation 1 + G_OL(s) = 0.",
      "blankAnswer": "characteristic",
      "blankDistractors": ["differential", "algebraic", "transient"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A feedback heating loop has process Gp(s) = 2.0 / (5.0s + 1), valve Gv(s) = 1.0, sensor Gm(s) = 1.0, and proportional controller Gc(s) = Kc = 4.0. G_OL(s) = 8.0 / (5.0s + 1). Denominator 1 + G_OL(s) = (5.0s + 9.0) / (5.0s + 1). Forward path is Gc*Gv*Gp = 8.0 / (5.0s + 1). What is the closed-loop servo transfer function Y(s) / Ysp(s)?",
      "options": [
        { "text": "Y(s) / Ysp(s) = 8.0 / (5.0s + 9.0) (Y(s)/Ysp(s) = [8.0 / (5.0s + 1)] / [(5.0s + 9.0) / (5.0s + 1)] = 8.0 / (5.0s + 9.0))", "isCorrect": true, "explanation": "Correct! Let's solve systematically using block diagram algebra and closed-loop transfer function formulas (Dale E. Seborg *Process Dynamics and Control* Chapter 11; George Stephanopoulos *Chemical Process Control* Chapter 11). 1. **Identify Block Diagram Transfer Functions:** - Process: $G_p(s) = \\frac{2.0}{5.0 s + 1}$. - Final control valve: $G_v(s) = 1.0$. - Sensor transmitter: $G_m(s) = 1.0$. - Controller: $G_c(s) = K_c = 4.0$. 2. **Calculate Open-Loop Transfer Function ($G_{\\text{OL}}(s)$):** $$G_{\\text{OL}}(s) = G_c(s) \\cdot G_v(s) \\cdot G_p(s) \\cdot G_m(s) = 4.0 \\times 1.0 \\times \\left( \\frac{2.0}{5.0 s + 1} \\right) \\times 1.0 = \\mathbf{\\frac{8.0}{5.0 s + 1}}$$ 3. **Calculate Closed-Loop Characteristic Denominator ($1 + G_{\\text{OL}}(s)$):** $$1 + G_{\\text{OL}}(s) = 1 + \\frac{8.0}{5.0 s + 1} = \\frac{(5.0 s + 1) + 8.0}{5.0 s + 1} = \\mathbf{\\frac{5.0 s + 9.0}{5.0 s + 1}}$$ 4. **Calculate Forward Path Transfer Function ($G_{\\text{forward}}(s)$):** $$G_{\\text{forward}}(s) = G_c(s) \\cdot G_v(s) \\cdot G_p(s) = 4.0 \\times 1.0 \\times \\left( \\frac{2.0}{5.0 s + 1} \\right) = \\mathbf{\\frac{8.0}{5.0 s + 1}}$$ 5. **Assemble Closed-Loop Servo Transfer Function ($\\frac{Y(s)}{Y_{\\text{sp}}(s)}$):** $$\\frac{Y(s)}{Y_{\\text{sp}}(s)} = \\frac{G_{\\text{forward}}(s)}{1 + G_{\\text{OL}}(s)} = \\frac{\\frac{8.0}{5.0 s + 1}}{\\frac{5.0 s + 9.0}{5.0 s + 1}} = \\mathbf{\\frac{8.0}{5.0 s + 9.0}}$$ - In standard gain-time constant form: $$\\frac{Y(s)}{Y_{\\text{sp}}(s)} = \\frac{8.0 / 9.0}{(5.0 / 9.0) s + 1} = \\frac{0.8889}{0.5556 s + 1}$$ - Notice that proportional control accelerated the time constant from $5.0\\text{ s}$ down to $0.556\\text{ s}$ ($9\\times$ faster!), but left a steady-state offset of $1 - 0.8889 = 11.11\\%$! Flawless closed-loop servo transfer function derivation!" },
        { "text": "Y(s) / Ysp(s) = 8.0 / (5.0s + 1.0) (Forgot to add 1 in denominator)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Y(s) / Ysp(s) = 4.0 / (5.0s + 9.0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Y(s) / Ysp(s) = 2.0 / (5.0s + 5.0)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
