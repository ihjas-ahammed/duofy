# Duofy Reusable Lesson Format: Concrete Dams (Stability Forces & Middle-Third Rule)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Surface_Water_Hydrology_and_Dams`  
**Lesson Format Type:** `concrete_gravity_dam_stability_and_middle_third_rule`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural stability analysis of concrete gravity dams, resolving primary external forces (self-weight $W$, hydrostatic headwater thrust $F_H = \frac{1}{2} \gamma_w H^2$, and internal uplift water pressure $U$), verifying the three classical safety criteria ((1) Overturning Stability $FS_{\text{overturn}} \ge 1.50$, (2) Sliding Stability $FS_{\text{sliding}} \ge 1.50$, and (3) Compressive Crushing / Base Stress Distribution), and enforcing the **Middle-Third Rule ($e \le B/6$)** to prevent tensile cracking at the dam heel (USBR *Design of Small Dams* 3rd ed. Chapter 8; Warren Viessman *Introduction to Hydrology* Chapter 12): formulate the **Primary Force Equations on a Unit-Width Gravity Dam**:
1. **Self-Weight of Concrete:** $\mathbf{W = \sum \gamma_c \cdot \text{Area}}$ (acting through component centroids);
2. **Hydrostatic Horizontal Thrust:** $\mathbf{F_H = \frac{1}{2} \gamma_w H^2}$ (acting at lever arm $H/3$ above base);
3. **Triangular Uplift Pressure Force:** $\mathbf{U = \frac{1}{2} \gamma_w H B}$ (acting at lever arm $2B/3$ from toe);
derive the **Middle-Third Rule & Base Stresses**:
$$\mathbf{x = \frac{\sum M_{\text{toe}}}{\sum V} \implies \mathbf{e = \left| \frac{B}{2} - x \right| \le \frac{B}{6} \quad (\text{Enforces } \sigma_{\text{heel}} \ge 0 \text{ No-Tension Invariant})}}$$
$$\mathbf{\sigma_{\text{toe,heel}} = \frac{\sum V}{B} \left( 1 \pm \frac{6 e}{B} \right) \le \sigma_{\text{allowable,concrete}}}$$
derive the **Stability Factors of Safety**:
$$\mathbf{FS_{\text{overturning}} = \frac{\sum M_{\text{resisting}}}{\sum M_{\text{overturning}}} \ge 1.50 \quad \Big| \quad \mathbf{FS_{\text{sliding}} = \frac{\mu \sum V}{\sum H} \ge 1.50 \quad (\mu \approx 0.65 - 0.75)}}$$
(proving that keeping resultant force eccentricity within the middle third $B/6$ prevents progressive tensile joint opening and catastrophic dam breaching).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dam Forces ($W, F_H, U$), Middle-Third Rule ($e \le B/6$) & $FS_{\text{overturn}} \ge 1.50$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Check Overturning, Sliding, and Base Stresses for a Concrete Gravity Dam Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Dam Stability Force / Failure Criterion & Technical Mechanical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | To Guarantee That No Harmful Tensile Cracking Develops at the Heel of a Concrete Gravity Dam, the Resultant Force Eccentricity Must Satisfy $e \le B / \text{___}$ (6 / Six) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Dam Safety Problem: Evaluating Overturning Factor FS and Heel/Toe Stresses for a 30m Dam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gravity Dam Stability (USBR 1987; Viessman 2003):
   - **Dam Equilibrium & Stress Formulations:**
     $$\mathbf{F_H = \frac{1}{2}\gamma_w H^2 \quad \Big| \quad x = \frac{\sum M_{\text{toe}}}{\sum V} \quad \Big| \quad e = \left|\frac{B}{2} - x\right| \le \frac{B}{6} \quad \Big| \quad \sigma = \frac{\sum V}{B}\left(1 \pm \frac{6e}{B}\right) \quad \Big| \quad FS_{\text{overturn}} = \frac{\sum M_R}{\sum M_O} \ge 1.50}$$
   - **Failure Modes & Acceptance Criteria Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Failure Mode} & \textbf{Physical Mechanism} & \textbf{Governing Formula} & \textbf{Code Acceptance} \\
     \hline
     \mathbf{\text{Overturning Failure}} & \text{Rotation about downstream toe} & \mathbf{FS_O = \sum M_R / \sum M_O} & \mathbf{FS \ge 1.50 \ (\text{Normal}), \ \ge 1.20 \ (\text{Extreme})} \\
     \mathbf{\text{Sliding Failure}} & \text{Shearing along dam-rock interface} & \mathbf{FS_S = \mu \sum V / \sum H} & \mathbf{FS \ge 1.50 \ (\text{Friction Factor } \mu = 0.70)} \\
     \mathbf{\text{Tensile Cracking at Heel}} & \text{Excessive resultant eccentricity} & \mathbf{e \le B / 6 \ (\text{Middle-Third Rule})}} & \mathbf{\sigma_{\text{heel}} \ge 0 \ (\text{Strictly Compressive})} \\
     \mathbf{\text{Compressive Crushing at Toe}} & \text{Excessive toe edge pressure} & \mathbf{\sigma_{\text{toe}} = \frac{\sum V}{B}(1 + \frac{6e}{B})} & \sigma_{\text{toe}} \le f_{\text{allowable,concrete}} \ (\approx 5 - 10\text{ MPa}) \\
     \hline
     \end{array}$$
   - **The Uplift Destruction Invariant:** Water seeping under the dam foundation generates hydrostatic uplift $U$ that directly reduces effective vertical normal load ($\sum V = W - U$), **simultaneously degrading both sliding resistance and overturning stability**!
2. **Slide 2 (`ordering`):** Provide 5 steps of dam stability analysis: (1) resolve vertical forces: concrete self-weights $W$ and subtract base uplift $U$, (2) compute horizontal forces: hydrostatic water thrust $F_H = 0.5 \gamma_w H^2$, (3) take moments of all forces about the downstream toe to compute resisting moment $\sum M_R$ and overturning moment $\sum M_O$, (4) calculate factor of safety against overturning: $FS_O = \sum M_R / \sum M_O \ge 1.50$ and sliding: $FS_S = \mu \sum V / F_H \ge 1.50$, (5) compute resultant location $x = \frac{\sum M_R - \sum M_O}{\sum V}$, find eccentricity $e = |B/2 - x|$, and verify $e \le B/6$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Middle-Third Rule $e \le B/6$, Hydrostatic Thrust $F_H$, Uplift Pressure $U$, Overturning Factor of Safety) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 6 (or Six). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating dam stability: A triangular concrete gravity dam ($\gamma_c = 24.0\text{ kN/m}^3, \gamma_w = 10.0\text{ kN/m}^3$) has height $H = 30.0\text{ m}$ and base width $B = 20.0\text{ m}$. Water is at the crest ($H = 30\text{ m}$).
   - Dam self-weight: $W = \frac{1}{2} \times 20.0 \times 30.0 \times 24.0 = \mathbf{7200.0\text{ kN/m}}$ (lever arm from toe $= \frac{2}{3} B = 13.333\text{ m}$);
   - Uplift force: $U = \frac{1}{2} \times 10.0 \times 30.0 \times 20.0 = \mathbf{3000.0\text{ kN/m}}$ (lever arm from toe $= \frac{2}{3} B = 13.333\text{ m}$);
   - Net vertical force: $\sum V = W - U = 7200 - 3000 = \mathbf{4200.0\text{ kN/m}}$;
   - Horizontal thrust: $F_H = \frac{1}{2} \times 10.0 \times (30.0)^2 = \mathbf{4500.0\text{ kN/m}}$ (lever arm from toe $= H/3 = 10.0\text{ m}$);
   - Overturning moment about toe: $\sum M_O = F_H \times 10.0\text{ m} = 4500.0 \times 10.0 = \mathbf{45,000\text{ kNm/m}}$;
   - Resisting moment from net weight: $\sum M_R = \sum V \times 13.333\text{ m} = 4200.0 \times 13.333 = \mathbf{56,000\text{ kNm/m}}$;
   - What is the Factor of Safety against overturning $FS_O$ and is the dam stable against overturning? ($FS_O = \frac{56,000}{45,000} = \mathbf{1.244 \approx 1.24} < 1.50 \implies \text{Inadequate safety margin; requires wider base or drainage gallery!}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concrete_gravity_dam_stability_and_middle_third_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Concrete Gravity Dam Stability (USBR Small Dams)**\n• **Primary Forces on a Gravity Dam (Per Unit Width):**\n$$\n\\mathbf{W = \\sum \\gamma_c \\cdot A \\quad \\Big| \\quad \\mathbf{F_H = \\frac{1}{2} \\gamma_w H^2 \\quad (\\text{At } H/3)} \\quad \\Big| \\quad \\mathbf{U = \\frac{1}{2} \\gamma_w H B \\quad (\\text{At } 2B/3)}}\n$$\n• **The Middle-Third Rule (No-Tension Condition):**\n$$\n\\mathbf{x = \\frac{\\sum M_{\\text{toe}}}{\\sum V} \\implies \\mathbf{e = \\left| \\frac{B}{2} - x \\right| \\le \\frac{B}{6}}}\n$$\n  - **Base Compressive Stresses:** $\\mathbf{\\sigma_{\\text{toe/heel}} = \\frac{\\sum V}{B} \\left( 1 \\pm \\frac{6 e}{B} \\right)}$;\n• **Stability Factors of Safety:**\n$$\n\\mathbf{FS_{\\text{overturn}} = \\frac{\\sum M_R}{\\sum M_O} \\ge 1.50 \\quad \\Big| \\quad FS_{\\text{sliding}} = \\frac{\\mu \\sum V}{\\sum H} \\ge 1.50}\n$$\n• **The Heel Tension Hazard:** If $e > B/6$, tensile stress develops at the upstream heel, causing tensile crack propagation, uncontrolled uplift water intrusion, and **catastrophic overturning breaching**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform a complete structural stability analysis of a concrete gravity dam.",
      "orderItems": [
        "Resolve all vertical forces: compute concrete cross-section self-weights (W) and subtract foundation uplift water pressure (U)",
        "Compute horizontal forces: hydrostatic headwater pressure FH = 0.5 * \u03b3w * H^2 and tailwater thrust",
        "Take moments of all forces about the downstream toe to compute total resisting moment (\u2211MR) and overturning moment (\u2211MO)",
        "Calculate the factors of safety: FS_overturning = \u2211MR / \u2211MO \u2265 1.50 and FS_sliding = \u03bc * \u2211V / FH \u2265 1.50",
        "Compute resultant location x = (\u2211MR - \u2211MO) / \u2211V, find eccentricity e = |B/2 - x|, and verify the Middle-Third Rule: e \u2264 B/6"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Dam Stability Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Middle-Third Rule (e \u2264 B/6)", "right": "Eccentricity limit ensuring the entire dam foundation base remains in compression without heel tension cracks" },
        { "left": "Hydrostatic Thrust (0.5*\u03b3w*H^2)", "right": "Horizontal triangular water pressure force acting at 1/3 of the height above the base" },
        { "left": "Uplift Pressure (U)", "right": "Subsurface hydraulic pore pressure acting upward against the base, reducing effective vertical normal load" },
        { "left": "Overturning Margin (FS \u2265 1.50)", "right": "Ratio of stabilizing self-weight moments to destabilizing overturning water pressure moments" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To guarantee that no harmful tensile cracking develops at the heel of a concrete gravity dam, the resultant force eccentricity must satisfy e \u2264 B / ___.",
      "blankAnswer": "6",
      "blankDistractors": ["2", "3", "4"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A triangular concrete gravity dam (\u03b3c = 24.0 kN/m^3, \u03b3w = 10.0 kN/m^3) has H = 30.0 m and base B = 20.0 m. Self-weight is W = 7200 kN/m and full uplift is U = 3000 kN/m (\u2211V = 4200 kN/m acting at 13.33 m from toe). Hydrostatic thrust is FH = 4500 kN/m acting at 10.0 m from toe. Overturning moment is 45,000 kNm/m and resisting moment is 56,000 kNm/m. What is the Factor of Safety against overturning FS_O?",
      "options": [
        { "text": "FS_O = 1.24 (Unsafe: below required 1.50 threshold!) (FS_O = \u2211MR / \u2211MO = 56,000 / 45,000 = 1.244 < 1.50, requiring foundation drainage gallery or base widening)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using gravity dam limit equilibrium mechanics (USBR *Design of Small Dams* Chapter 8). 1. **Calculate Individual Force Components:** - Dam self-weight: $$W = \\frac{1}{2} \\cdot B \\cdot H \\cdot \\gamma_c = \\frac{1}{2} \\times 20.0\\text{ m} \\times 30.0\\text{ m} \\times 24.0\\text{ kN/m}^3 = \\mathbf{7200.0\\text{ kN/m}}$$ - Hydrostatic horizontal water thrust: $$F_H = \\frac{1}{2} \\cdot \\gamma_w \\cdot H^2 = \\frac{1}{2} \\times 10.0\\text{ kN/m}^3 \\times (30.0\\text{ m})^2 = \\mathbf{4500.0\\text{ kN/m}}$$ - Triangular foundation uplift force: $$U = \\frac{1}{2} \\cdot \\gamma_w \\cdot H \\cdot B = \\frac{1}{2} \\times 10.0\\text{ kN/m}^3 \\times 30.0\\text{ m} \\times 20.0\\text{ m} = \\mathbf{3000.0\\text{ kN/m}}$$ - Net vertical force: $$\\sum V = W - U = 7200.0 - 3000.0 = \\mathbf{4200.0\\text{ kN/m}}$$ 2. **Calculate Moments About the Downstream Toe:** - Overturning moment (from water pressure): $$\\sum M_O = F_H \\times \\left(\\frac{H}{3}\\right) = 4500.0\\text{ kN/m} \\times 10.0\\text{ m} = \\mathbf{45,000.0\\text{ kN}\\cdot\\text{m/m}}$$ - Resisting moment (from net vertical force): $$\\sum M_R = \\sum V \\times \\left(\\frac{2}{3} B\\right) = 4200.0\\text{ kN/m} \\times 13.3333\\text{ m} = \\mathbf{56,000.0\\text{ kN}\\cdot\\text{m/m}}$$ 3. **Calculate Factor of Safety Against Overturning ($FS_O$):** $$FS_O = \\frac{\\sum M_R}{\\sum M_O} = \\frac{56,000.0\\text{ kN}\\cdot\\text{m/m}}{45,000.0\\text{ kN}\\cdot\\text{m/m}} = \\mathbf{1.2444 \\approx 1.24}$$ 4. **Engineering Assessment:** Standard dam safety codes mandate **$FS_O \\ge 1.50$** under normal loading. Because $FS_O = 1.24 < 1.50$, the dam is **unacceptable as designed** and requires a wider base $B$ or a grout curtain and drainage gallery to reduce uplift $U$! Flawless concrete gravity dam stability evaluation!" },
        { "text": "FS_O = 1.60 (Safe design)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FS_O = 2.13 (Omitted uplift force)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FS_O = 0.80 (Complete overturning failure)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
