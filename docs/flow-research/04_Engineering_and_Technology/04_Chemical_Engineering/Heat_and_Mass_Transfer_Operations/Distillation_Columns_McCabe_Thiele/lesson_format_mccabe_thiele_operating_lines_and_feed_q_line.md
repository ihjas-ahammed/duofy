# Duofy Reusable Lesson Format: McCabe-Thiele (Operating Lines & Feed q-Line Hydraulics)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Heat_and_Mass_Transfer_Operations / Distillation_Columns_McCabe_Thiele`  
**Lesson Format Type:** `mccabe_thiele_operating_lines_and_feed_q_line`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the graphical solution of binary fractional distillation columns using the **McCabe-Thiele Method**, Constant Molar Overflow (CMO) principles, column overall material balances ($F = D + B, F x_F = D x_D + B x_B$), the **Rectifying Section Operating Line (ROL)**, the **Stripping Section Operating Line (SOL)**, the **Feed Thermal Condition Parameter ($q$)**, the **Feed Line ($q$-line)** equation, and identifying the internal operating line intersection point ($x_i, y_i$) (Warren L. McCabe, Julian C. Smith, Peter Harriott *Unit Operations of Chemical Engineering* 7th ed. Chapter 21; McCabe & Thiele 1925): formulate the **Rectifying Section Operating Line (ROL) Master Formulation**:
$$\mathbf{y = \left( \frac{R}{R + 1} \right) x + \frac{x_D}{R + 1} \quad \left(R = \frac{L}{D} = \text{External Reflux Ratio}\right)}$$
where:
1. **$R = L/D$:** External reflux ratio;
2. **$\text{Slope}_{\text{ROL}} = \frac{R}{R + 1} < 1.0$**;
3. **$\text{y-intercept} = \frac{x_D}{R + 1}$**;
4. **Anchor Point:** Passes through $(x_D, x_D)$ on the $y = x$ diagonal;
formulate the **Feed Line ($q$-Line) Master Equation**:
$$\mathbf{y = \left( \frac{q}{q - 1} \right) x - \frac{x_F}{q - 1} \quad \left(\text{Anchor Point: Passes through } (x_F, x_F) \text{ on } y=x\right)}$$
master the **5 Feed Thermal Conditions ($q$-Values)**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Feed Thermal Condition} & \textbf{Parameter } q & \textbf{q-Line Slope } \frac{q}{q-1} & \textbf{Orientation on y-x Diagram} \\
\hline
\mathbf{\text{Subcooled Liquid (Cold)}} & \mathbf{q > 1.0} & \mathbf{\text{Positive Slope } (> +1)} & \mathbf{\text{Points upward and to the right}} \\
\mathbf{\text{Saturated Liquid (Bubble Point)}} & \mathbf{q = 1.0} & \mathbf{\text{Infinite Slope } (\to \infty)} & \mathbf{\text{Strictly vertical line }} (x = x_F) \\
\mathbf{\text{Liquid-Vapor Mix (Partially Flash)}} & \mathbf{0 < q < 1.0} & \mathbf{\text{Negative Slope } (< 0)} & \mathbf{\text{Points upward and to the left}} \\
\mathbf{\text{Saturated Vapor (Dew Point)}} & \mathbf{q = 0.0} & \mathbf{\text{Zero Slope } (= 0)} & \mathbf{\text{Strictly horizontal line }} (y = x_F) \\
\mathbf{\text{Superheated Vapor (Hot)}} & \mathbf{q < 0.0} & \mathbf{\text{Positive Slope } (0 < \text{slope} < 1)} & \mathbf{\text{Points downward and to the left}} \\
\hline
\end{array}$$
formulate the **Stripping Operating Line (SOL)**:
$$\mathbf{y = \left( \frac{\bar{L}}{\bar{V}} \right) x - \frac{B x_B}{\bar{V}} \quad \left(\text{Connects } (x_B, x_B) \text{ to the intersection } (x_i, y_i) \text{ of ROL and q-line}\right)}$$
(proving that the feed thermal condition $q$ acts as the geometric hinge determining the optimal feed plate location in the column).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ROL ($y = \frac{R}{R+1}x + \frac{x_D}{R+1}$), q-Line ($y = \frac{q}{q-1}x - \frac{x_F}{q-1}$) & 5 Feed Regimes Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct the ROL, q-Line, and SOL on a McCabe-Thiele Diagram Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Distillation Operating Line / Feed Thermal State & Technical Mathematical Slope Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | On a McCabe-Thiele Diagram, When the Feed Is a Saturated Liquid at its Bubble Point ($q = 1.0$), the Feed $q$-Line Is Strictly a ___ Line at $x = x_F$ (Vertical / Perpendicular) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Separation Engineering Problem: Finding the Slope, Y-Intercept, and Intersection Point (xi, yi) of ROL and q-Line Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State McCabe-Thiele Operating Lines & $q$-Line Formulations (McCabe & Thiele 1925; McCabe, Smith, Harriott 2005):
   - **Operating Formulations:**
     $$\mathbf{y_{\text{ROL}} = \left(\frac{R}{R+1}\right)x + \frac{x_D}{R+1} \quad \Big| \quad y_q = \left(\frac{q}{q-1}\right)x - \frac{x_F}{q-1} \quad \Big| \quad q = \frac{H_V - H_F}{H_V - H_L}}$$
   - **The 5 Feed States Summary:**
     - Subcooled liquid: $q > 1 \implies \text{Slope} > 1$;
     - Saturated liquid: $q = 1 \implies \text{Vertical } x = x_F$;
     - Two-phase mixture: $0 < q < 1 \implies \text{Negative slope}$;
     - Saturated vapor: $q = 0 \implies \text{Horizontal } y = x_F$;
     - Superheated vapor: $q < 0 \implies \text{Gentle positive slope}$;
   - **The Constant Molar Overflow Invariant:** Assuming negligible heat losses and equal molar heats of vaporization, the **liquid and vapor molar flow rates remain constant throughout each respective column section ($L_n = L, V_n = V$)**, making all operating lines strictly linear!
2. **Slide 2 (`ordering`):** Provide 5 steps of McCabe-Thiele operating line construction: (1) plot the $y=x$ diagonal line and the binary VLE equilibrium curve, (2) mark target compositions: bottoms $x_B$, feed $x_F$, and distillate $x_D$ on the $y=x$ line, (3) draw the Rectifying Section Operating Line (ROL) starting from $(x_D, x_D)$ with slope $\frac{R}{R+1}$ and y-intercept $\frac{x_D}{R+1}$, (4) draw the feed $q$-line starting from $(x_F, x_F)$ with slope $\frac{q}{q-1}$ to find intersection coordinate $(x_i, y_i)$, (5) draw the Stripping Section Operating Line (SOL) connecting $(x_B, x_B)$ through the intersection point $(x_i, y_i)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (ROL Equation, Saturated Liquid $q=1$, Saturated Vapor $q=0$, SOL Equation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Vertical (or Perpendicular). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating ROL slope, intercept, and intersection with $q$-line: A binary distillation column has feed $x_F = 0.40$ (saturated liquid at bubble point, $q = 1.0$), distillate $x_D = 0.90$, and reflux ratio $R = 2.0$.
   - ROL slope: $\frac{R}{R + 1} = \frac{2.0}{2.0 + 1.0} = \frac{2.0}{3.0} = \mathbf{0.6667}$;
   - ROL y-intercept: $\frac{x_D}{R + 1} = \frac{0.90}{3.0} = \mathbf{0.300}$;
   - Equation of ROL: $y = 0.6667 x + 0.300$;
   - Since feed is saturated liquid ($q = 1.0$), the $q$-line is vertical at $x = x_F = 0.400$;
   - Intersection coordinate $(x_i, y_i)$: $x_i = 0.400 \implies y_i = 0.6667(0.400) + 0.300 = 0.2667 + 0.300 = \mathbf{0.5667}$;
   - What is the ROL y-intercept and the intersection coordinate $(x_i, y_i)$? (Intercept $= \mathbf{0.300}$, $(x_i, y_i) = \mathbf{(0.400, 0.567)}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mccabe_thiele_operating_lines_and_feed_q_line",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: McCabe-Thiele Operating Lines \\& Feed q-Line (McCabe \\& Thiele 1925)**\n• **Rectifying Section Operating Line Master Formulation (ROL):**\n$$\n\\mathbf{y = \\left( \\frac{R}{R + 1} \\right) x + \\frac{x_D}{R + 1} \\quad \\left(R = \\frac{L}{D} = \\text{External Reflux Ratio}\\right)}\n$$\n  - **$\\text{Slope} = \\frac{R}{R + 1}$**; **$\\text{y-intercept} = \\frac{x_D}{R + 1}$**;\n  - Passes through $(x_D, x_D)$ on the $y=x$ diagonal line;\n• **Feed Thermal Condition Parameter ($q$) \\& q-Line Formulation:**\n$$\n\\mathbf{y = \\left( \\frac{q}{q - 1} \\right) x - \\frac{x_F}{q - 1} \\quad \\Big| \\quad q = \\frac{H_V - H_F}{H_V - H_L}}\n$$\n  - **Subcooled Liquid ($q > 1$):** Positive slope ($> 1$);\n  - **Saturated Liquid ($q = 1$):** Strictly vertical line ($x = x_F$);\n  - **Partially Vaporized ($0 < q < 1$):** Negative slope;\n  - **Saturated Vapor ($q = 0$):** Strictly horizontal line ($y = x_F$);\n• **Stripping Section Operating Line (SOL):** Connects $(x_B, x_B)$ to the intersection $(x_i, y_i)$ of ROL and $q$-line;\n• **The Constant Molar Overflow Invariant:** Assuming equal molar heats of vaporization, **internal vapor and liquid molar rates ($L, V$) remain strictly constant** in each section, making all operating lines straight!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct the operating lines and feed line on a McCabe-Thiele binary distillation diagram.",
      "orderItems": [
        "Plot the y = x diagonal line and the vapor-liquid equilibrium (VLE) curve on the x-y coordinate plane",
        "Mark the target bottoms composition xB, feed composition xF, and distillate composition xD on the y = x line",
        "Draw the Rectifying Section Operating Line (ROL) from (xD, xD) with slope R / (R + 1) and y-intercept xD / (R + 1)",
        "Draw the feed q-line from (xF, xF) with slope q / (q - 1) to find the internal intersection point (xi, yi)",
        "Draw the Stripping Section Operating Line (SOL) as the straight line connecting (xB, xB) through the intersection (xi, yi)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each McCabe-Thiele Line / State to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Rectifying Line (ROL)", "right": "y = [R/(R+1)]*x + xD/(R+1), mass balance equation governing fluid traffic above the feed tray" },
        { "left": "Saturated Liquid (q = 1)", "right": "Bubble-point feed condition creating a strictly vertical q-line at x = xF" },
        { "left": "Saturated Vapor (q = 0)", "right": "Dew-point feed condition creating a strictly horizontal q-line at y = xF" },
        { "left": "Stripping Line (SOL)", "right": "Mass balance line governing the column base, connecting (xB, xB) to the ROL/q-line intersection" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "On a McCabe-Thiele diagram, when the feed is a saturated liquid at its bubble point (q = 1.0), the feed q-line is strictly a ___ line at x = xF.",
      "blankAnswer": "vertical",
      "blankDistractors": ["horizontal", "diagonal", "curved"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A binary distillation tower has xD = 0.90, xF = 0.40 (saturated liquid at bubble point, q = 1.0), and reflux ratio R = 2.0. The ROL has slope R/(R+1) = 2/3 = 0.6667 and y-intercept xD/(R+1) = 0.90 / 3.0 = 0.300. Since q = 1.0, the q-line is x = 0.40. What is the ROL y-intercept and the intersection coordinate (xi, yi)?",
      "options": [
        { "text": "y-intercept = 0.300 and (xi, yi) = (0.400, 0.567) (y-intercept = 0.90 / 3 = 0.300; since q = 1.0, xi = 0.400 and yi = 0.6667 * 0.400 + 0.300 = 0.2667 + 0.300 = 0.5667 \u2248 0.567)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the McCabe-Thiele operating line and $q$-line equations (Warren L. McCabe *Unit Operations of Chemical Engineering* Chapter 21). 1. **Calculate Rectifying Section Operating Line (ROL) Parameters:** - Given: $x_D = 0.90, \\quad R = 2.0$. - ROL slope: $$\\text{Slope} = \\frac{R}{R + 1} = \\frac{2.0}{2.0 + 1.0} = \\frac{2.0}{3.0} = \\mathbf{0.66667}$$ - ROL y-intercept: $$\\text{y-intercept} = \\frac{x_D}{R + 1} = \\frac{0.90}{2.0 + 1.0} = \\frac{0.90}{3.0} = \\mathbf{0.3000}$$ - Equation of ROL: $$y = 0.66667 \\cdot x + 0.3000$$ 2. **Calculate Feed $q$-Line Parameters:** - Feed thermal state: Saturated liquid at bubble point $\\implies q = 1.0$. - $q$-line formula: $$y = \\left( \\frac{q}{q - 1} \\right) x - \\frac{x_F}{q - 1}$$ - As $q \\to 1.0$, the slope $\\frac{q}{q-1} \\to \\infty$, which represents a **strictly vertical line**: $$x = x_F = \\mathbf{0.400}$$ 3. **Find Intersection Point ($(x_i, y_i)$) of ROL and $q$-Line:** - Since the $q$-line is vertical at $x = 0.400$, the intersection $x$-coordinate is: $$x_i = \\mathbf{0.400}$$ - Substituting $x_i = 0.400$ into the ROL equation: $$y_i = 0.66667 \\times (0.400) + 0.3000 = 0.26667 + 0.3000 = \\mathbf{0.56667 \\approx 0.567}$$ - Intersection coordinate: $$(x_i, y_i) = \\mathbf{(0.400, 0.567)}$$ Flawless McCabe-Thiele operating line and $q$-line derivation!" },
        { "text": "y-intercept = 0.450 and (xi, yi) = (0.400, 0.650)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y-intercept = 0.300 and (xi, yi) = (0.400, 0.400)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y-intercept = 0.900 and (xi, yi) = (0.500, 0.700)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
