# Duofy Reusable Lesson Format: Gear Trains (Simple, Compound, & Reverted Speed Ratios)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Gears_and_Gear_Trains`  
**Lesson Format Type:** `simple_compound_and_reverted_gear_train_speed_ratios`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through fixed-axis gear transmission kinematics, compound speed reductions, and reverted gearbox architectures in mechanical engineering (Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 8; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 13): master **Simple Gear Trains** (proving why intermediate **Idler Gears** alter the direction of rotation but have **ZERO mathematical effect on the overall speed ratio $\mathbf{\frac{\omega_1}{\omega_n} = (-1)^{n-1} \frac{T_n}{T_1}}$**), master **Compound Gear Trains** (where multiple gears are rigidly keyed to the same rotating intermediate shaft, multiplying speed reductions without massive gearbox physical envelopes):
$$\mathbf{\text{Train Value } e = \frac{\omega_{\text{out}}}{\omega_{\text{in}}} = \frac{\text{Product of Teeth on Driving Gears}}{\text{Product of Teeth on Driven Gears}} = \frac{T_1 \cdot T_3 \cdot T_5}{T_2 \cdot T_4 \cdot T_6}}$$
and master **Reverted Gear Trains** (where the input driving shaft and output driven shaft are strictly **Collinear (Coaxial)**, establishing the geometric center distance constraint $\mathbf{r_1 + r_2 = r_3 + r_4 \implies m_1(T_1 + T_2) = m_2(T_3 + T_4)}$, the foundational architecture of mechanical wristwatches and industrial speed reducers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Simple, Compound & Reverted Gear Train Formulations ($e = \prod \frac{T_{\text{driver}}}{T_{\text{driven}}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Gear Ratio Calculation for a Reverted Collinear Gearbox Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Gear Train Configuration / Intermediate Component & Kinematic Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Reverted Gear Train, the Input Driving Shaft and the Output Driven Shaft Are Strictly ___ (Collinear / Coaxial) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Transmission Problem: Calculating the Output Speed and Torque of a Compound Reduction Gearbox Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fixed-Axis Gear Trains (Shigley 2014; Budynas 2020):
   - **Gear Train Formulations:**
     $$\mathbf{e = \frac{\omega_{\text{out}}}{\omega_{\text{in}}} = \frac{\prod T_{\text{drivers}}}{\prod T_{\text{driven}}} \quad \Big| \quad \text{Gear Ratio } i = \frac{1}{e} = \frac{\prod T_{\text{driven}}}{\prod T_{\text{drivers}}}}$$
   - **Gear Train Configuration Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Gear Train Architecture} & \textbf{Shaft Configuration} & \textbf{Kinematic Relationship} \\
     \hline
     \mathbf{\text{Simple Gear Train}} & \text{1 gear per shaft} & \mathbf{\frac{\omega_{\text{out}}}{\omega_{\text{in}}} = (-1)^{n-1} \frac{T_{\text{in}}}{T_{\text{out}}} \text{ (Idlers change only direction)}} \\
     \mathbf{\text{Compound Gear Train}} & \text{2+ gears keyed per shaft} & \mathbf{\frac{\omega_{\text{out}}}{\omega_{\text{in}}} = \frac{T_1 \cdot T_3 \cdot T_5}{T_2 \cdot T_4 \cdot T_6}} \\
     \mathbf{\text{Reverted Gear Train}} & \mathbf{\text{Input \\& output collinear}} & \mathbf{r_1 + r_2 = r_3 + r_4 \implies m(T_1 + T_2) = m(T_3 + T_4)} \\
     \hline
     \end{array}$$
   - **Torque & Power Invariant:** For $100\%$ mechanical efficiency: $\mathbf{\text{Power} = T_{\text{in}} \omega_{\text{in}} = T_{\text{out}} \omega_{\text{out}} \implies T_{\text{out}} = T_{\text{in}} \times i}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of reverted gearbox design: (1) identify required overall speed reduction ratio $i_{\text{total}} = \frac{\omega_{\text{in}}}{\omega_{\text{out}}}$, (2) split the total reduction into two balanced stages: $i_1 \times i_2 = i_{\text{total}}$, (3) size teeth for stage 1 ($T_1, T_2$) ensuring $T_1 \ge 18$ to prevent undercutting, (4) apply the collinear center distance constraint $T_1 + T_2 = T_3 + T_4$ (for equal module $m$), (5) solve for stage 2 teeth ($T_3, T_4$) and verify exact final speed ratio!
3. **Slide 3 (`matching`):** Pair 4 concepts (Idler Gear, Compound Gear, Reverted Gear Train, Train Value $e$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Collinear (or Coaxial). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating compound gearbox output: An electric motor spinning at $N_{\text{in}} = 1800\text{ RPM}$ delivers $P = 15\text{ kW}$ to a compound two-stage gearbox. Stage 1 has driver $T_1 = 20$ teeth meshing with driven gear $T_2 = 60$ teeth. Keyed to the same shaft as $T_2$ is driver $T_3 = 25$ teeth, which meshes with final output gear $T_4 = 100$ teeth. Assuming $100\%$ mechanical efficiency, what is the output rotational speed $N_{\text{out}}$ and output torque $\tau_{\text{out}}$? ($i_1 = \frac{T_2}{T_1} = \frac{60}{20} = 3.0$; $i_2 = \frac{T_4}{T_3} = \frac{100}{25} = 4.0$; Total ratio $i_{\text{total}} = 3.0 \times 4.0 = \mathbf{12.0}$; Output speed $N_{\text{out}} = \frac{1800}{12} = \mathbf{150\text{ RPM}}$; $\omega_{\text{out}} = \frac{2\pi(150)}{60} = 5\pi \approx 15.708\text{ rad/s}$; Torque $\tau_{\text{out}} = \frac{P}{\omega_{\text{out}}} = \frac{15000\text{ W}}{15.708\text{ rad/s}} \approx \mathbf{954.9\text{ N}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "simple_compound_and_reverted_gear_train_speed_ratios",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fixed-Axis Gear Trains \\& Reverted Gearboxes (Shigley \\& Budynas)**\n• **Master Gear Train Kinematic Formulations:**\n$$\n\\mathbf{e = \\frac{\\omega_{\\text{out}}}{\\omega_{\\text{in}}} = \\frac{\\prod T_{\\text{drivers}}}{\\prod T_{\\text{driven}}} \\quad \\Longleftrightarrow \\quad \\mathbf{i = \\frac{\\omega_{\\text{in}}}{\\omega_{\\text{out}}} = \\frac{\\prod T_{\\text{driven}}}{\\prod T_{\\text{drivers}}}}}\n$$\n• **Fixed-Axis Transmission Architecture Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Gear Train Class} & \\textbf{Shaft Configuration} & \\textbf{Kinematic Characteristic} \\\\\n\\hline\n\\mathbf{\\text{Simple Train}} & \\text{1 gear per fixed shaft} & \\mathbf{\\frac{\\omega_{\\text{out}}}{\\omega_{\\text{in}}} = (-1)^{n-1} \\frac{T_1}{T_n} \\text{ (Idlers change only direction)}} \\\\\n\\mathbf{\\text{Compound Train}} & \\text{Multiple gears keyed per shaft} & \\mathbf{\\frac{\\omega_{\\text{out}}}{\\omega_{\\text{in}}} = \\frac{T_1 \\cdot T_3 \\cdot T_5}{T_2 \\cdot T_4 \\cdot T_6} \\text{ (Multiplies speed reductions)}} \\\\\n\\mathbf{\\text{Reverted Train}} & \\mathbf{\\text{Input \\& Output Collinear}} & \\mathbf{r_1 + r_2 = r_3 + r_4 \\implies T_1 + T_2 = T_3 + T_4 \\text{ (Equal } m)} \\\\\n\\hline\n\\end{array}\n$$\n• **The Ideal Power Invariant:** For 100\\% mechanical efficiency: $\\mathbf{P = \\tau_{\\text{in}} \\omega_{\\text{in}} = \\tau_{\\text{out}} \\omega_{\\text{out}} \\implies \\tau_{\\text{out}} = \\tau_{\\text{in}} \\times i}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a reverted two-stage gearbox with collinear input and output shafts.",
      "orderItems": [
        "Determine the required total speed reduction ratio: i_total = omega_in / omega_out",
        "Decompose the total gear ratio into two balanced stage reductions: i_total = i_stage1 * i_stage2",
        "Select tooth numbers for the first stage (T1, T2) ensuring driver pinion T1 >= 18 to prevent undercutting",
        "Enforce the collinear center distance constraint: T1 + T2 = T3 + T4 (for identical module m)",
        "Solve for second stage teeth (T3, T4) satisfying both stage ratio and center distance, then compute output torque"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Gear Train Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Idler Gear", "right": "Intermediate gear in a simple train that reverses rotation direction without affecting the overall ratio" },
        { "left": "Compound Gear Train", "right": "Transmission where two gears of different sizes are keyed to a common shaft, multiplying speed ratio" },
        { "left": "Reverted Gear Train", "right": "Architecture where input and output shafts share the exact same collinear geometric axis" },
        { "left": "Train Value (e)", "right": "e = omega_out / omega_in, the reciprocal of the overall gear reduction ratio" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a reverted gear train, the input driving shaft and the output driven shaft are strictly ___.",
      "blankAnswer": "collinear",
      "blankDistractors": ["perpendicular", "skew", "oscillating"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An electric motor spinning at N_in = 1800 RPM delivers P = 15 kW to a two-stage compound gearbox. Stage 1 has driver T1 = 20 teeth meshing with driven T2 = 60 teeth. Keyed to the intermediate shaft is driver T3 = 25 teeth meshing with final output gear T4 = 100 teeth. What is the output rotational speed N_out and output torque \u03c4_out (assuming 100% efficiency)?",
      "options": [
        { "text": "N_out = 150 RPM and \u03c4_out = 954.9 N·m (Overall reduction ratio i = (60/20) * (100/25) = 3 * 4 = 12)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using compound gear train kinematics (Shigley *Theory of Machines and Mechanisms* Chapter 8). 1. **Calculate Stage Ratios:** - Stage 1 reduction: $$i_1 = \\frac{T_2}{T_1} = \\frac{60}{20} = 3.0$$ - Stage 2 reduction: $$i_2 = \\frac{T_4}{T_3} = \\frac{100}{25} = 4.0$$ 2. **Calculate Total Speed Reduction Ratio ($i_{\\text{total}}$):** $$i_{\\text{total}} = i_1 \\times i_2 = 3.0 \\times 4.0 = \\mathbf{12.0}$$ 3. **Calculate Output Rotational Speed ($N_{\\text{out}}$):** $$N_{\\text{out}} = \\frac{N_{\\text{in}}}{i_{\\text{total}}} = \\frac{1800\\text{ RPM}}{12.0} = \\mathbf{150\\text{ RPM}}$$ 4. **Calculate Output Torque ($\\tau_{\\text{out}}$):** - Output angular velocity: $$\\omega_{\\text{out}} = \\frac{2 \\pi N_{\\text{out}}}{60} = \\frac{2 \\pi (150)}{60} = 5 \\pi \\approx \\mathbf{15.708\\text{ rad/s}}$$ - Power conservation: $$P = \\tau_{\\text{out}} \\omega_{\\text{out}} \\implies \\tau_{\\text{out}} = \\frac{15,000\\text{ W}}{15.708\\text{ rad/s}} \\approx \\mathbf{954.93\\text{ N}\\cdot\\text{m} \\approx 954.9\\text{ N}\\cdot\\text{m}}$$ Flawless compound reduction calculation!" },
        { "text": "N_out = 300 RPM and \u03c4_out = 477.5 N·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_out = 75 RPM and \u03c4_out = 1909.8 N·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_out = 1800 RPM and \u03c4_out = 79.6 N·m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
