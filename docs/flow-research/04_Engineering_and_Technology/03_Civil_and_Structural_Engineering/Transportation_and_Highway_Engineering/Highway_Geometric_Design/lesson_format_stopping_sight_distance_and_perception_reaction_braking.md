# Duofy Reusable Lesson Format: Sight Distance (Perception-Reaction & Braking on Grade)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Highway_Geometric_Design`  
**Lesson Format Type:** `stopping_sight_distance_and_perception_reaction_braking`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamental physics of vehicle braking kinematics, human driver perception-reaction time ($t_r = 2.5\text{ s}$ standard per AASHTO Green Book), deceleration rates ($a = 3.4\text{ m/s}^2 \implies a/g = 0.35$), the compounding impact of roadway longitudinal grade ($\pm G$), and the calculation of design **Stopping Sight Distance (SSD)** (AASHTO Green Book 7th ed. Chapter 3; Fred L. Mannering *Principles of Highway Engineering and Traffic Analysis* Chapter 3): formulate the **AASHTO Stopping Sight Distance (SSD) Master Formulation (SI Metric)**:
$$\mathbf{d_{\text{SSD}} = d_{\text{reaction}} + d_{\text{braking}} = 0.278 \cdot V \cdot t_r + \frac{V^2}{254 \left( \frac{a}{g} \pm G \right)}}$$
where:
1. **$V$:** Design vehicle speed in $\text{km/h}$ ($0.278 V$ converts $\text{km/h}$ to $\text{m/s}$);
2. **$t_r$:** Brake reaction time ($t_r = 2.5\text{ s}$, covering $90\text{th}$-percentile drivers);
3. **$a/g$:** Normalized vehicle deceleration coefficient ($a = 3.4\text{ m/s}^2, g = 9.81\text{ m/s}^2 \implies \frac{a}{g} = 0.3466 \approx 0.35$);
4. **$G$:** Longitudinal roadway grade expressed as a decimal ($+G$ for upgrades / uphill, $-G$ for downgrades / downhill);
master the **Grade Impact Invariant**:
- **Level Roadway ($G = 0$):** $d_{\text{SSD}} = 0.278 V (2.5) + \frac{V^2}{254(0.35)} = 0.695 V + \frac{V^2}{88.9}$;
- **Downgrade ($-G$):** Gravity accelerates vehicle down the slope, substantially lengthening $d_{\text{braking}}$ and necessitating longer sight clear zones;
(proving why geometric highway design must guarantee that driver sightline visibility exceeds $d_{\text{SSD}}$ at every single station along the roadway).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | AASHTO SSD Equation ($d_{\text{SSD}} = 0.278 V t_r + \frac{V^2}{254(a/g \pm G)}$), $t_r = 2.5\text{s}$ & Grade Effects Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Stopping Sight Distance on a 4% Downgrade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Stopping Distance Component / Human Factor & Technical Kinematic Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the AASHTO Green Book, the Standard Design Driver Perception-Reaction Time $t_r$ Is Set to Exactly ___ Seconds (2.5 / Two Point Five) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Highway Engineering Problem: Calculating Total Stopping Sight Distance for 100 km/h on a 3% Downgrade Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State AASHTO Stopping Sight Distance (AASHTO 2018; Mannering 2020):
   - **SSD Kinematic Formulations:**
     $$\mathbf{d_{\text{SSD}} = 0.278 V t_r + \frac{V^2}{254(a/g \pm G)} \quad \Big| \quad t_r = 2.5\text{ s} \quad \Big| \quad a/g = 0.35 \quad \Big| \quad \text{US Units: } d = 1.47 V t_r + \frac{V^2}{30(a/32.2 \pm G)}}$$
   - **Speed vs Stopping Distance Matrix (Level Grade $G = 0$):**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Design Speed } V & \textbf{Reaction Dist } d_r & \textbf{Braking Dist } d_b & \textbf{Calculated SSD} & \textbf{AASHTO Design Standard} \\
     \hline
     \mathbf{60\text{ km/h} \ (37\text{ mph})} & 41.7\text{ m} & 40.5\text{ m} & 82.2\text{ m} & \mathbf{85\text{ m}} \\
     \mathbf{80\text{ km/h} \ (50\text{ mph})} & 55.6\text{ m} & 72.0\text{ m} & 127.6\text{ m} & \mathbf{130\text{ m}} \\
     \mathbf{100\text{ km/h} \ (62\text{ mph})} & 69.5\text{ m} & 112.5\text{ m} & 182.0\text{ m} & \mathbf{185\text{ m}} \\
     \mathbf{120\text{ km/h} \ (75\text{ mph})} & 83.4\text{ m} & 162.0\text{ m} & 245.4\text{ m} & \mathbf{250\text{ m}} \\
     \hline
     \end{array}$$
   - **The Downgrade Penalty Invariant:** On a downhill slope ($-G$), gravity directly opposes brake retarding friction, **increasing braking distance by the factor $\frac{a/g}{a/g - G}$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of SSD calculation: (1) determine roadway design speed $V$ in $\text{km/h}$ and longitudinal grade $G$, (2) calculate perception-reaction distance traveled during human reaction: $d_r = 0.278 \cdot V \cdot (2.5\text{ s})$, (3) compute effective net deceleration factor $(0.35 \pm G)$ accounting for slope, (4) evaluate vehicle braking distance: $d_b = \frac{V^2}{254 (0.35 \pm G)}$, (5) sum reaction and braking distances: $d_{\text{SSD}} = d_r + d_b$ and round up to the nearest $5\text{ m}$ increment per AASHTO standards!
3. **Slide 3 (`matching`):** Pair 4 concepts (Perception-Reaction Time $t_r = 2.5\text{ s}$, Deceleration Rate $a = 3.4\text{ m/s}^2$, Downgrade Braking Penalty, Metric Velocity Conversion $0.278$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 2.5 (or Two Point Five). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating SSD on a downgrade: A rural arterial highway has a design speed $V = 100.0\text{ km/h}$ and is situated on a $3.0\%$ downgrade ($G = -0.030$). The AASHTO design perception-reaction time is $t_r = 2.5\text{ s}$ and deceleration coefficient is $a/g = 0.35$.
   - Reaction distance: $d_r = 0.278 \times (100.0) \times (2.5) = \mathbf{69.50\text{ m}}$;
   - Net deceleration factor: $a/g - G = 0.35 - 0.030 = \mathbf{0.320}$;
   - Braking distance: $d_b = \frac{100.0^2}{254 \times (0.320)} = \frac{10,000}{81.28} = \mathbf{123.03\text{ m}}$;
   - Total stopping sight distance: $d_{\text{SSD}} = 69.50 + 123.03 = \mathbf{192.53\text{ m} \approx 192.5\text{ m}}$ (AASHTO design standard rounds up to $\mathbf{195\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stopping_sight_distance_and_perception_reaction_braking",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: AASHTO Stopping Sight Distance (AASHTO Green Book)**\n• **Stopping Sight Distance (SSD) Master Formulation (SI Units):**\n$$\n\\mathbf{d_{\\text{SSD}} = d_{\\text{reaction}} + d_{\\text{braking}} = 0.278 \\cdot V \\cdot t_r + \\frac{V^2}{254 \\left( \\frac{a}{g} \\pm G \\right)}}\n$$\n  - **$V$:** Design vehicle speed ($\\text{km/h}$);\n  - **$t_r = 2.5\\text{ s}$:** AASHTO driver brake reaction time ($90^{\\text{th}}$-percentile);\n  - **$\\frac{a}{g} = 0.35$:** Normalized vehicle deceleration coefficient ($a = 3.4\\text{ m/s}^2$);\n  - **$G$:** Roadway longitudinal grade as a decimal ($+G$ uphill, $-G$ downhill);\n• **Level Roadway Form ($G = 0$):**\n$$\n\\mathbf{d_{\\text{SSD}} = 0.695 \\cdot V + \\frac{V^2}{88.9}}\n$$\n• **The Quadratic Velocity Invariant:** While reaction distance increases linearly with speed ($d_r \\propto V$), braking distance increases **quadratically ($d_b \\propto V^2$)**; doubling speed quadruples braking distance!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the design Stopping Sight Distance for a highway segment on a downhill grade.",
      "orderItems": [
        "Identify the highway design speed V (in km/h) and the longitudinal roadway slope grade G (expressed as a decimal)",
        "Compute the perception-reaction distance: d_r = 0.278 * V * 2.5 (where 2.5 s is the standard AASHTO reaction time)",
        "Determine the effective net deceleration factor accounting for grade: (0.35 - G) on a downgrade",
        "Calculate the physical vehicle braking distance: d_b = V^2 / [254 * (0.35 - G)]",
        "Sum reaction and braking components: d_SSD = d_r + d_b and round up to the nearest 5-meter increment per AASHTO standards"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Sight Distance Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Brake Reaction Time (tr = 2.5s)", "right": "AASHTO standard time encompassing 90% of drivers from hazard perception to physical brake pedal application" },
        { "left": "Deceleration Rate (a = 3.4 m/s^2)", "right": "Comfortable emergency braking deceleration rate defining normalized friction a/g \u2248 0.35" },
        { "left": "Downgrade Penalty (-G)", "right": "Gravity component accelerating vehicle downhill that significantly increases required braking distance" },
        { "left": "Speed Conversion (0.278)", "right": "Conversion factor transforming velocity from kilometers per hour (km/h) into meters per second (m/s)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the AASHTO Green Book, the standard design driver perception-reaction time tr is set to exactly ___ seconds.",
      "blankAnswer": "2.5",
      "blankDistractors": ["1.0", "1.5", "3.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rural highway has design speed V = 100.0 km/h on a 3.0% downgrade (G = -0.030, a/g = 0.35, tr = 2.5 s). Reaction distance is dr = 0.278 * 100 * 2.5 = 69.5 m. Net deceleration factor is (0.35 - 0.030) = 0.320. What is the total calculated Stopping Sight Distance d_SSD?",
      "options": [
        { "text": "d_SSD = 192.5 m (dr = 69.50 m; db = 100^2 / (254 * 0.320) = 10000 / 81.28 = 123.03 m; d_SSD = 69.50 + 123.03 = 192.53 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the AASHTO Stopping Sight Distance equation on grade (AASHTO Green Book 7th ed. Chapter 3). 1. **Calculate Perception-Reaction Distance ($d_r$):** $$d_r = 0.278 \\cdot V \\cdot t_r = 0.278 \\times (100.0\\text{ km/h}) \\times (2.5\\text{ s}) = \\mathbf{69.50\\text{ m}}$$ 2. **Calculate Net Deceleration Factor with Downgrade:** - Longitudinal grade: $G = -0.030$ (3.0% downgrade). $$\\text{Factor} = \\frac{a}{g} - G = 0.350 - 0.030 = \\mathbf{0.320}$$ 3. **Calculate Vehicle Braking Distance ($d_b$):** $$d_b = \\frac{V^2}{254 \\left(\\frac{a}{g} - G\\right)} = \\frac{(100.0)^2}{254 \\times (0.320)} = \\frac{10,000}{81.28} = \\mathbf{123.0315\\text{ m}}$$ 4. **Calculate Total Stopping Sight Distance ($d_{\\text{SSD}}$):** $$d_{\\text{SSD}} = d_r + d_b = 69.50\\text{ m} + 123.0315\\text{ m} = \\mathbf{192.5315\\text{ m} \\approx 192.5\\text{ m}}$$ 5. **AASHTO Design Rounding:** - Standard tables round $192.5\\text{ m}$ up to **$195\\text{ m}$** for conservative highway clear line-of-sight design! Flawless stopping sight distance calculation!" },
        { "text": "d_SSD = 182.0 m (Level grade without downgrade penalty)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d_SSD = 123.0 m (Omitted perception-reaction distance)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d_SSD = 245.0 m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
