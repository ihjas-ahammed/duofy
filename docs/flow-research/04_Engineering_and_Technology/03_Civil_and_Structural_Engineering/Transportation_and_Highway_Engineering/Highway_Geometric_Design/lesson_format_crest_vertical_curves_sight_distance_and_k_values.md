# Duofy Reusable Lesson Format: Crest Vertical Curves (Sight Distance & K-Values)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Highway_Geometric_Design`  
**Lesson Format Type:** `crest_vertical_curves_sight_distance_and_k_values`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through symmetrical parabolic vertical alignment on highways, crest vertical curves formed when an upgrade meets a downgrade ($G_1 > G_2$), the algebraic difference in grades ($A = |G_1 - G_2|$ in percent), driver eye height ($h_1 = 1.08\text{ m}$ per AASHTO Green Book), object height ($h_2 = 0.60\text{ m}$ representing a vehicle taillight or roadway hazard), sightline tangency geometry over the crest, the design curve length equation for $S \le L$, and the dimensionless rate of vertical curvature **$K$-Value ($K = L / A$)** (AASHTO Green Book 7th ed. Chapter 3; Fred L. Mannering *Principles of Highway Engineering and Traffic Analysis* Chapter 3): formulate the **AASHTO Crest Vertical Curve Master Formulation ($S \le L$)**:
$$\mathbf{L = \frac{A \cdot S^2}{100 \left( \sqrt{2 h_1} + \sqrt{2 h_2} \right)^2} = \frac{A \cdot S^2}{100 \left( \sqrt{2(1.08)} + \sqrt{2(0.60)} \right)^2} = \mathbf{\frac{A \cdot S^2}{658}}}$$
where:
1. **$L$:** Length of the vertical curve in meters;
2. **$A$:** Algebraic difference in approach and departure grades: $\mathbf{A = |G_1 - G_2| \ [\%]}$;
3. **$S$:** Required Stopping Sight Distance ($d_{\text{SSD}}$) in meters;
4. **$K_{\text{crest}}$:** Design rate of vertical curvature:
   $$\mathbf{K_{\text{crest}} = \frac{L}{A} = \frac{S^2}{658} \implies \mathbf{L = K_{\text{crest}} \cdot A}}$$
master the **Elevation & Turning Point Equations**:
- Parabolic elevation at distance $x$ from Point of Vertical Curvature (PVC):
  $$\mathbf{y(x) = y_{\text{PVC}} + \left(\frac{G_1}{100}\right)x + \left(\frac{G_2 - G_1}{200 L}\right)x^2}$$
- Station of Summit High Point ($\frac{dy}{dx} = 0$):
  $$\mathbf{x_{\text{summit}} = -\frac{G_1 L}{G_2 - G_1} = \frac{G_1 \cdot L}{A} = \mathbf{K \cdot G_1}}$$
(proving that vertical curve length $L$ scales directly with the square of sight distance $S^2$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Crest Curve Equation ($L = \frac{A S^2}{658}$), $K = \frac{S^2}{658}$ & Summit Station ($x = K \cdot G_1$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Minimum Crest Length, K-Value, and High Point Station Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Crest Vertical Curve Entity / Geometric Parameter & Technical Highway Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In AASHTO Crest Curve Design, Driver Eye Height $h_1$ Is Taken as 1.08 m and Target Object Height $h_2$ Is Taken as Exactly ___ Meters (0.60 / 0.6 / Zero Point Six) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Highway Engineering Problem: Calculating Minimum Curve Length L and Summit Station for a Crest Curve Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Crest Vertical Curves (AASHTO 2018; Mannering 2020):
   - **Crest Curve Formulations:**
     $$\mathbf{L = \frac{A S^2}{658} \quad \Big| \quad K = \frac{S^2}{658} \quad \Big| \quad L = K \cdot A \quad \Big| \quad x_{\text{summit}} = K \cdot G_1 \quad \Big| \quad \text{US: } L = \frac{A S^2}{2158}, \ K = \frac{S^2}{2158}}$$
   - **Design K-Values for Crest Curves Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Design Speed } V & \textbf{Stopping Sight Distance } S & \textbf{Calculated } K = S^2/658 & \textbf{AASHTO Design } K\textbf{-Value} \\
     \hline
     \mathbf{60\text{ km/h}} & 85\text{ m} & 10.98 & \mathbf{K = 11} \\
     \mathbf{80\text{ km/h}} & 130\text{ m} & 25.68 & \mathbf{K = 26} \\
     \mathbf{100\text{ km/h}} & 185\text{ m} & 52.01 & \mathbf{K = 52} \\
     \mathbf{120\text{ km/h}} & 250\text{ m} & 94.98 & \mathbf{K = 95} \\
     \hline
     \end{array}$$
   - **The High Point Invariant:** The distance from the curve start (PVC) to the absolute highest point on the crest is **strictly equal to $x_{\text{summit}} = K \cdot G_1$** (where $G_1$ is the initial grade in percent)!
2. **Slide 2 (`ordering`):** Provide 5 steps of crest curve design: (1) determine design speed $V$ and find required Stopping Sight Distance $S = d_{\text{SSD}}$, (2) calculate algebraic difference in grades: $A = |G_1 - G_2|$, (3) compute required rate of vertical curvature: $K = S^2 / 658$, (4) evaluate minimum curve length: $L = K \cdot A$ and verify assumption $S \le L$, (5) calculate high point station: $x_{\text{summit}} = K \cdot G_1$ to locate critical drainage crest!
3. **Slide 3 (`matching`):** Pair 4 concepts (K-Value $L/A$, Grade Difference $A = |G_1-G_2|$, Object Height $h_2 = 0.60\text{ m}$, Summit Point $x = K \cdot G_1$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.60 (or 0.6). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating crest curve length: A crest vertical curve connects an initial grade $G_1 = +3.0\%$ to a final grade $G_2 = -2.0\%$ on a highway with design speed $V = 100.0\text{ km/h}$ ($S = 185.0\text{ m}$).
   - Grade difference: $A = |+3.0 - (-2.0)| = |+3.0 + 2.0| = \mathbf{5.0\%}$;
   - $K$-value: $K = \frac{S^2}{658} = \frac{185.0^2}{658} = \frac{34,225}{658} = \mathbf{52.014 \approx 52}$;
   - Minimum curve length: $L = K \cdot A = 52.014 \times 5.0 = \mathbf{260.07\text{ m} \approx 260\text{ m}}$ (matches $L = \frac{5.0 \times 185^2}{658} = 260.07\text{ m} \ge S = 185\text{ m}$, validating $S \le L$);
   - Distance from PVC to summit high point: $x_{\text{summit}} = K \cdot G_1 = 52.014 \times 3.0 = \mathbf{156.04\text{ m} \approx 156\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "crest_vertical_curves_sight_distance_and_k_values",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Crest Vertical Curves \\& K-Values (AASHTO Green Book)**\n• **Crest Curve Length Formulation ($S \\le L$, SI Units):**\n$$\n\\mathbf{L = \\frac{A \\cdot S^2}{100 \\left( \\sqrt{2 h_1} + \\sqrt{2 h_2} \\right)^2} = \\mathbf{\\frac{A \\cdot S^2}{658}}}\n$$\n  - **$A = |G_1 - G_2|$:** Algebraic difference in roadway grades ($\\text{\\%}$);\n  - **$S$:** Required design Stopping Sight Distance ($d_{\\text{SSD}}$ in meters);\n  - **$h_1 = 1.08\\text{ m}$:** AASHTO driver eye height above road;\n  - **$h_2 = 0.60\\text{ m}$:** AASHTO target hazard object height (taillight);\n• **Rate of Vertical Curvature ($K$-Value):**\n$$\n\\mathbf{K_{\\text{crest}} = \\frac{L}{A} = \\frac{S^2}{658} \\implies \\mathbf{L = K_{\\text{crest}} \\cdot A}}\n$$\n• **Summit High Point Station ($\\frac{dy}{dx} = 0$):** $\\mathbf{x_{\\text{summit}} = K \\cdot G_1}$\n• **The Tangency Line-of-Sight Invariant:** Crest curve length is sized so that a driver's line of sight over the apex of the hill is **tangent to the parabolic road profile**, unblocking vision of an object $0.60\\text{ m}$ high at distance $S$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the minimum length and summit high point for a crest vertical curve.",
      "orderItems": [
        "Determine the design speed V and look up the required Stopping Sight Distance S (d_SSD)",
        "Calculate the algebraic difference in roadway grades: A = |G1 - G2| expressed in percent",
        "Compute the design rate of vertical curvature: K = S^2 / 658",
        "Calculate the minimum parabolic curve length: L = K * A and verify that L \u2265 S",
        "Compute the location of the highest crest elevation point from the PVC: x_summit = K * G1 for drainage design"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Crest Vertical Curve Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "K-Value (L/A)", "right": "Horizontal distance in meters required to achieve a 1% change in roadway gradient" },
        { "left": "Grade Difference (A)", "right": "A = |G1 - G2|, total angular bend between approach and departure grade tangents" },
        { "left": "Object Height (h2 = 0.60m)", "right": "AASHTO standard dimension representing vehicle taillight or small hazard on pavement" },
        { "left": "Summit Point (x = K*G1)", "right": "Station of zero instantaneous grade where rainwater runoff diverges in opposite directions" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In AASHTO crest vertical curve design, driver eye height h1 is 1.08 m and target object height h2 is taken as exactly ___ meters.",
      "blankAnswer": "0.60",
      "blankDistractors": ["1.08", "0.15", "1.50"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A crest curve connects G1 = +3.0% to G2 = -2.0% (A = 5.0%) on a highway where V = 100.0 km/h (S = 185.0 m). K = 185^2 / 658 = 52.01. What is the minimum required curve length L and the distance from PVC to the high summit point x_summit?",
      "options": [
        { "text": "L = 260.1 m and x_summit = 156.0 m (L = K * A = 52.014 * 5.0 = 260.07 m; x_summit = K * G1 = 52.014 * 3.0 = 156.04 m; since L = 260.1 m > S = 185 m, the S \u2264 L condition is verified)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the AASHTO crest vertical curve formulas (AASHTO Green Book 7th ed. Chapter 3). 1. **Calculate Algebraic Difference in Grades ($A$):** $$A = |G_1 - G_2| = |(+3.0\\%) - (-2.0\\%)| = |+3.0 + 2.0| = \\mathbf{5.0\\%}$$ 2. **Calculate Rate of Vertical Curvature ($K$-Value):** - Design sight distance: $S = 185.0\\text{ m}$. $$K_{\\text{crest}} = \\frac{S^2}{658} = \\frac{(185.0\\text{ m})^2}{658} = \\frac{34,225}{658} = \\mathbf{52.0137 \\approx 52.01}$$ 3. **Calculate Minimum Vertical Curve Length ($L$):** $$L = K \\cdot A = 52.0137 \\times 5.0 = \\mathbf{260.068\\text{ m} \\approx 260.1\\text{ m}}$$ - Verify condition: Since $L = 260.1\\text{ m} > S = 185.0\\text{ m}$, the **$S \\le L$ assumption is strictly satisfied**! 4. **Calculate Distance from PVC to Summit High Point ($x_{\\text{summit}}$):** $$x_{\\text{summit}} = K \\cdot G_1 = 52.0137 \\times 3.0 = \\mathbf{156.041\\text{ m} \\approx 156.0\\text{ m}}$$ Flawless crest vertical curve length and summit point derivation!" },
        { "text": "L = 185.0 m and x_summit = 92.5 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L = 260.1 m and x_summit = 130.0 m (Used midpoint instead of K*G1)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L = 520.1 m and x_summit = 312.1 m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
