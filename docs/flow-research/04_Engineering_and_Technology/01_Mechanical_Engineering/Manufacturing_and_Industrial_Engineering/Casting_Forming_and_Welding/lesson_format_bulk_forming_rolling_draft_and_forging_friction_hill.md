# Duofy Reusable Lesson Format: Bulk Forming (Rolling Maximum Draft & Forging Friction Hill)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Casting_Forming_and_Welding`  
**Lesson Format Type:** `bulk_forming_rolling_draft_and_forging_friction_hill`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through plastic metal flow mechanics, rolling bite conditions, maximum draft constraints, and the forging "friction hill" pressure distribution (Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapter 13 & 14; Mikell P. Groover *Fundamentals of Modern Manufacturing* Chapter 18 & 19): master the **Plastic Flow Stress Formulation (Hollomon)**:
$$\mathbf{\sigma = K \epsilon^n \quad \left(\epsilon = \ln\left(\frac{h_0}{h_f}\right) = \text{True Plastic Strain}\right)}$$
derive the **Flat Rolling Bite & Maximum Single-Pass Draft ($\mathbf{\Delta h_{\text{max}}}$)**:
$$\mathbf{\tan\alpha \le \mu \implies \mathbf{\Delta h_{\text{max}} = h_0 - h_f = \mu^2 R}}$$
(proving why the maximum thickness reduction is strictly limited by the square of the friction coefficient $\mu^2$ and roll radius $R$, demonstrating why hot rolling uses large rough-textured rolls to maximize draft); master the **Neutral (No-Slip) Point in Rolling** (where strip speed exactly equals roll surface velocity $v_{\text{strip}} = v_{\text{roll}}$, with backward slip at entry $v_0 < v_r$ and forward slip at exit $v_f > v_r$); and master the **Open-Die Forging Friction Hill Equation**:
$$\mathbf{p(x) = Y_f' e^{\frac{2\mu}{h}(a - x)} \implies \mathbf{F_{\text{forging}} = Y_f' A \left( 1 + \frac{2 \mu r}{3 h} \right)}}$$
(analyzing how friction at the die-workpiece interface causes die pressures to skyrocket at the center forming a massive friction hill).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rolling Maximum Draft ($\Delta h_{\text{max}} = \mu^2 R$) & Forging Friction Hill ($F = Y_f A(1 + \frac{2\mu r}{3h})$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Maximum Rolling Draft, Roll Separating Force, and Forging Tonnage Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Metal Forming Variable / Kinematic Condition & Physical Mechanical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Flat Rolling, the Point Along the Contact Arc Where Strip Velocity Matches Roll Velocity Is the ___ Point (Neutral / No-Slip) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Heavy Forming Problem: Calculating the Maximum Allowable Single-Pass Draft in a Cold Rolling Mill Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bulk Forming Mechanics (Kalpakjian 2020; Groover 2020):
   - **Rolling Bite & Draft Formulations:**
     $$\mathbf{\Delta h_{\text{max}} = h_0 - h_f = \mu^2 R \quad \Big| \quad L_p = \sqrt{R \Delta h} \quad \Big| \quad F_{\text{roll}} = w L_p \bar{Y}_f}$$
   - **Forging Friction Hill Formulations:**
     $$\mathbf{p(x) = Y_f' e^{\frac{2\mu}{h}(a-x)} \implies \mathbf{F_{\text{forging}} = Y_f A \left(1 + \frac{2 \mu r}{3 h}\right)}}$$
   - **The Rolling Bite Invariant:** Self-gripping entry requires $\mathbf{\tan\alpha \le \mu}$; if the contact angle $\alpha$ exceeds $\tan^{-1}\mu$, the rolls will slip and skid over the metal without pulling it in!
2. **Slide 2 (`ordering`):** Provide 5 steps of rolling analysis: (1) measure initial slab thickness $h_0$, target thickness $h_f$, roll radius $R$, and friction coefficient $\mu$, (2) check if desired reduction $\Delta h = h_0 - h_f \le \mu^2 R$ to ensure self-entry, (3) calculate true strain $\epsilon = \ln(h_0/h_f)$ and evaluate mean flow stress $\bar{Y}_f = \frac{K \epsilon^n}{1+n}$, (4) compute projected contact arc length $L_p = \sqrt{R \Delta h}$, (5) multiply projected area by mean flow stress to calculate roll separating force $F = w L_p \bar{Y}_f$ and motor drive torque!
3. **Slide 3 (`matching`):** Pair 4 concepts (Maximum Draft $\Delta h_{\text{max}} = \mu^2 R$, Neutral Point, Forging Friction Hill, Forward Slip) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Neutral (or No-Slip). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating maximum draft: A cold rolling mill uses steel rolls of diameter $D = 600\text{ mm}$ ($R = 300\text{ mm}$). The coefficient of friction between rolls and strip is $\mu = 0.15$. What is the maximum thickness reduction (maximum draft $\Delta h_{\text{max}}$) that can be achieved in a single rolling pass without slipping? ($\Delta h_{\text{max}} = \mu^2 R = (0.15)^2 (300\text{ mm}) = 0.0225 \times 300\text{ mm} = \mathbf{6.75\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bulk_forming_rolling_draft_and_forging_friction_hill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bulk Metal Forming \\& Rolling Friction Limits (Kalpakjian \\& Groover)**\n• **Flat Rolling Maximum Draft \\& Self-Bite Formulation:**\n$$\n\\mathbf{\\Delta h_{\\text{max}} = h_0 - h_f = \\mu^2 R \\quad \\Big| \\quad \\tan\\alpha \\le \\mu \\quad \\left(R = \\text{Roll Radius}, \\ \\mu = \\text{Friction Coeff}\\right)}\n$$\n• **Rolling Contact Length \\& Separating Force:**\n$$\n\\mathbf{L_p = \\sqrt{R \\Delta h} \\quad \\Big| \\quad F_{\\text{roll}} = w \\cdot L_p \\cdot \\bar{Y}_f \\quad \\left(\\bar{Y}_f = \\frac{K \\epsilon^n}{1 + n}\\right)}\n$$\n• **The Forging Friction Hill Formulation (Cylindrical Upsetting):**\n$$\n\\mathbf{F_{\\text{forging}} = Y_f \\cdot A \\left( 1 + \\frac{2 \\mu r}{3 h} \\right)}\n$$\n• **The Neutral Point Invariant:** Along the rolling contact arc, there is exactly **one Neutral Point where strip speed equals roll speed ($v_{\\text{strip}} = v_{\\text{roll}}$)**; metal enters slower ($v_0 < v_r$) and exits faster ($v_f > v_r$, forward slip)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate self-gripping bite feasibility and calculate roll separating force in flat strip rolling.",
      "orderItems": [
        "Determine roll radius R, friction coefficient mu, initial strip thickness h0, and target thickness hf",
        "Calculate the maximum allowable draft delta_h_max = mu^2 * R and verify that actual draft delta_h <= delta_h_max",
        "Compute the true plastic strain epsilon = ln(h0 / hf) and determine the average flow stress Y_avg = K*epsilon^n / (1+n)",
        "Calculate the projected length of the roll contact arc: L_p = sqrt(R * delta_h)",
        "Compute the total roll separating force F = width * L_p * Y_avg and size the mill drive motor"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Bulk Metal Forming Parameter to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Maximum Draft (\u0394h_max)", "right": "\u0394h_max = \u03bc^2 * R, the maximum single-pass thickness reduction achievable without roll skidding" },
        { "left": "Neutral (No-Slip) Point", "right": "Location along the roll gap arc where workpiece velocity exactly matches roll surface velocity" },
        { "left": "Forging Friction Hill", "right": "Parabolic die pressure profile peaking at the center due to frictional resistance against outward flow" },
        { "left": "Forward Slip", "right": "S = (v_exit - v_roll) / v_roll, the percentage by which exit strip speed exceeds roll linear speed" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In flat rolling, the unique location along the contact arc where strip velocity matches roll velocity is the ___ point.",
      "blankAnswer": "neutral",
      "blankDistractors": ["choke", "stagnation", "critical"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A cold rolling mill uses steel rolls of diameter D = 600 mm (radius R = 300 mm). The coefficient of friction between the rolls and the steel strip is \u03bc = 0.15. What is the maximum thickness reduction (maximum draft \u0394h_max) achievable in a single pass without slipping?",
      "options": [
        { "text": "\u0394h_max = 6.75 mm (Calculated from \u0394h_max = \u03bc^2 * R = (0.15)^2 * 300 mm = 0.0225 * 300 = 6.75 mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the flat rolling maximum draft formula (Serope Kalpakjian *Manufacturing Engineering and Technology* Chapter 13). 1. **Identify Roll Radius ($R$):** $$R = \\frac{D}{2} = \\frac{600\\text{ mm}}{2} = \\mathbf{300\\text{ mm}}$$ 2. **Apply the Maximum Draft Equation:** $$\\Delta h_{\\text{max}} = \\mu^2 R$$ 3. **Substitute Given Numerical Values:** $$\\Delta h_{\\text{max}} = (0.15)^2 \\times 300\\text{ mm} = 0.0225 \\times 300\\text{ mm} = \\mathbf{6.75\\text{ mm}}$$ 4. **Physical Significance:** If the mill operator attempts to reduce strip thickness by more than $6.75\\text{ mm}$ in a single pass without front/back tensions, the bite angle will exceed the friction angle, causing the rolls to skid and spin over the metal without pulling it into the roll gap!" },
        { "text": "\u0394h_max = 45.0 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394h_max = 13.5 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394h_max = 2.25 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
