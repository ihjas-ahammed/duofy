# Duofy Reusable Lesson Format: Gear Contact & Interference (Contact Ratio & Undercutting)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Gears_and_Gear_Trains`  
**Lesson Format Type:** `contact_ratio_and_pinion_undercutting_interference_prevention`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through gear tooth engagement mechanics, length of path of contact, contact ratio thresholds, and the physical causes and prevention of pinion undercutting in machine design (Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 7; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 13): calculate the **Total Path of Contact ($\mathbf{L_{ab}}$)**:
$$\mathbf{L_{ab} = \text{Path of Approach } (L_a) + \text{Path of Recess } (L_r) = \sqrt{r_{a2}^2 - r_{b2}^2} + \sqrt{r_{a1}^2 - r_{b1}^2} - C \sin\phi}$$
master the **Contact Ratio ($\mathbf{CR}$)**:
$$\mathbf{CR = \frac{\text{Length of Path of Contact}}{\text{Base Pitch}} = \frac{L_{ab}}{p_b} = \frac{L_{ab}}{\pi m \cos\phi} \ge 1.2 - 1.4}$$
(proving why $CR > 1.0$ is mandatory so that the next tooth pair engages *before* the preceding pair disengages, preventing shock loading), analyze **Tooth Interference and Undercutting** (which occurs when the tip of the gear tooth extends beyond the tangency point on the pinion's base circle, machining away the tooth root during manufacturing), and derive the **Minimum Number of Pinion Teeth to Avoid Undercutting**:
$$\mathbf{T_{\text{min}} = \frac{2 a_w}{\sin^2\phi} \quad \left(\text{For standard } \phi = 20^\circ, a_w = 1.0 m \implies T_{\text{min}} = \frac{2}{\sin^2(20^\circ)} = 17.097 \implies \mathbf{18 \text{ teeth}}}\right)}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Path of Contact ($L_{ab}$), Contact Ratio ($CR = \frac{L_{ab}}{p_b}$) & $T_{\text{min}} = 18$ Teeth Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Path of Contact, Contact Ratio, and Undercutting Check Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Gear Contact Metric / Undercutting Parameter & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Minimum Number of Pinion Teeth Required to Completely Prevent Undercutting for Standard 20° Full-Depth Involute Gears Is ___ (18 / Eighteen) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Machine Design Calculation: Sizing Path of Contact and Evaluating Contact Ratio CR for a Meshing Gear Pair Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Contact Ratio & Undercutting (Shigley 2014; Budynas 2020):
   - **Path of Contact & Contact Ratio Formulations:**
     $$\mathbf{L_{ab} = \sqrt{r_{a1}^2 - r_{b1}^2} + \sqrt{r_{a2}^2 - r_{b2}^2} - C \sin\phi \quad \Big| \quad CR = \frac{L_{ab}}{p_b} = \frac{L_{ab}}{\pi m \cos\phi}}$$
   - **Interference & Undercutting Invariant:**
     $$\mathbf{T_{\text{min}} = \frac{2 a_w}{\sin^2\phi} \quad \left(\text{For } \phi = 20^\circ \text{ full-depth} \implies T_{\text{min}} = \frac{2(1.0)}{\sin^2(20^\circ)} = 17.097 \implies \mathbf{18 \text{ teeth}}}\right)}$$
   - **Contact Ratio Rule:** $CR \ge 1.2$ (typically $1.4-1.6$) ensures continuous, quiet power transfer and shared tooth load distribution!
2. **Slide 2 (`ordering`):** Provide 5 steps of gear contact analysis: (1) calculate pitch radii $r_{p1}, r_{p2}$, base radii $r_{b1}, r_{b2} = r_p \cos\phi$, and tip addendum radii $r_{a1}, r_{a2} = r_p + m$, (2) evaluate the path of contact $L_{ab} = \sqrt{r_{a1}^2 - r_{b1}^2} + \sqrt{r_{a2}^2 - r_{b2}^2} - C \sin\phi$, (3) compute the base pitch $p_b = \pi m \cos\phi$, (4) evaluate the contact ratio $CR = \frac{L_{ab}}{p_b}$ and confirm $CR > 1.2$, (5) verify that the pinion has at least $T \ge T_{\text{min}} = 18$ teeth to prevent root undercutting!
3. **Slide 3 (`matching`):** Pair 4 concepts (Contact Ratio $CR$, Path of Contact $L_{ab}$, Undercutting, Minimum Teeth $T_{\text{min}}=18$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 18 (or Eighteen). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating contact ratio: A pair of standard $20^\circ$ full-depth spur gears has module $m = 5\text{ mm}$. Geometric calculation reveals the total length of path of contact is $L_{ab} = 22.14\text{ mm}$. What is the Contact Ratio ($CR$) of this gear pair? ($p_b = \pi m \cos(20^\circ) = \pi (5)(0.93969) \approx 14.7607\text{ mm}$; $CR = \frac{L_{ab}}{p_b} = \frac{22.14\text{ mm}}{14.7607\text{ mm}} = \mathbf{1.50}$; **$CR = 1.50$, indicating that on average, $1.5$ pairs of teeth share the load simultaneously, ensuring smooth continuous engagement**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "contact_ratio_and_pinion_undercutting_interference_prevention",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gear Contact Ratio \\& Interference Prevention (Shigley \\& Budynas)**\n• **Path of Contact \\& Contact Ratio Formulations:**\n$$\n\\mathbf{L_{ab} = \\sqrt{r_{a1}^2 - r_{b1}^2} + \\sqrt{r_{a2}^2 - r_{b2}^2} - C \\sin\\phi \\quad \\Big| \\quad CR = \\frac{L_{ab}}{p_b} = \\frac{L_{ab}}{\\pi m \\cos\\phi}}\n$$\n• **Interference \\& Pinion Undercutting Invariant:**\n$$\n\\mathbf{T_{\\text{min}} = \\frac{2 a_w}{\\sin^2\\phi} \\quad \\left(\\text{For standard } \\phi = 20^\\circ, a_w = 1.0m \\implies T_{\\text{min}} = \\frac{2}{\\sin^2(20^\\circ)} = 17.097 \\implies \\mathbf{18 \\text{ teeth}}\\right)}\n$$\n• **The Smooth Engagement Criterion:** For continuous, quiet power transmission without impact shock, the Contact Ratio MUST satisfy $\\mathbf{CR \\ge 1.2}$ (typically $1.4 - 1.6$), ensuring the next tooth pair engages *before* the previous pair disengages!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the path of contact, contact ratio, and undercutting safety of a meshing spur gear pair.",
      "orderItems": [
        "Compute the pitch radii (rp1, rp2), base radii (rb = rp*cos(phi)), and addendum tip radii (ra = rp + m)",
        "Calculate the length of the path of contact using L_ab = sqrt(ra1^2 - rb1^2) + sqrt(ra2^2 - rb2^2) - C*sin(phi)",
        "Compute the normal base pitch of the gear teeth: p_b = pi * m * cos(phi)",
        "Evaluate the Contact Ratio using CR = L_ab / p_b and verify that CR strictly exceeds 1.2 (CR >= 1.2)",
        "Check pinion tooth count against the minimum threshold (T_pinion >= 2 / sin^2(phi) = 18) to ensure zero undercutting"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Gear Mesh Contact Metric to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Contact Ratio (CR)", "right": "CR = L_ab / p_b, the average number of tooth pairs in simultaneous contact during rotation" },
        { "left": "Path of Contact (L_ab)", "right": "Total line segment along the line of action where mating gear tooth profiles touch" },
        { "left": "Pinion Undercutting", "right": "Harmful removal of metal at the tooth root when the mating gear tip extends below the base circle" },
        { "left": "Minimum Pinion Teeth (T_min)", "right": "T_min = 2 / sin^2(\u03c6) = 18 teeth for 20° full-depth gears to eliminate interference" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The minimum number of teeth on a pinion to prevent undercutting in standard 20° full-depth involute gears is ___.",
      "blankAnswer": "18",
      "blankDistractors": ["12", "14", "24"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A pair of standard 20° full-depth spur gears has module m = 5 mm. Geometric analysis determines that the total length of the path of contact is L_ab = 22.14 mm. What is the Contact Ratio (CR) of this gear pair?",
      "options": [
        { "text": "CR = 1.50 (Calculated from base pitch p_b = pi * 5 * cos(20°) = 14.76 mm and CR = 22.14 / 14.76 = 1.50)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Contact Ratio formula (Shigley *Theory of Machines and Mechanisms* Chapter 7; Budynas *Shigley's Mechanical Engineering Design* Chapter 13). 1. **Calculate Base Pitch ($p_b$):** $$p_b = \u03c0 m \\cos\\phi$$ $$p_b = \\pi (5\\text{ mm}) \\cos(20^\\circ) = (15.708\\text{ mm})(0.93969) \\approx \\mathbf{14.7607\\text{ mm}}$$ 2. **Calculate Contact Ratio ($CR$):** $$CR = \\frac{L_{ab}}{p_b} = \\frac{22.14\\text{ mm}}{14.7607\\text{ mm}} = \\mathbf{1.500 \\approx 1.50}$$ 3. **Physical Significance:** - $CR = 1.50$ means that for $50\\%$ of the operating time, **two pairs of teeth share the load simultaneously**, and for $50\\%$ of the time, one pair is in contact. - This guarantees smooth, shock-free tooth engagement and validates excellent gear design!" },
        { "text": "CR = 1.00 (Marginal point contact)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "CR = 2.25", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "CR = 0.75 (Discontinuous motion)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
