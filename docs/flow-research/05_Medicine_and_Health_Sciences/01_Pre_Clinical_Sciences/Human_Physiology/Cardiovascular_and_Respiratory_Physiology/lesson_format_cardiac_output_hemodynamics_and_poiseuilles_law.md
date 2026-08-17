# Duofy Reusable Lesson Format: Hemodynamics (Cardiac Output & Poiseuille Resistance)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Physiology / Cardiovascular_and_Respiratory_Physiology`  
**Lesson Format Type:** `cardiac_output_hemodynamics_and_poiseuilles_law`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the quantitative biophysics and clinical formulas of cardiovascular hemodynamics, the fundamental **Cardiac Output Equation ($CO = \text{HR} \times \text{SV}$)**, the **Stroke Volume & Ejection Fraction Formulations ($\text{SV} = \text{EDV} - \text{ESV}$, $\text{EF} = \frac{\text{SV}}{\text{EDV}} \times 100\%$)**, the **Mean Arterial Pressure Equation ($\text{MAP} = \text{DBP} + \frac{1}{3}[\text{SBP} - \text{DBP}] = CO \times \text{SVR}$)**, the **Fick Principle for Cardiac Output ($CO = \frac{\dot{V}O_2}{C_a O_2 - C_v O_2}$)**, the **Poiseuille Law of Vascular Resistance ($R = \frac{8\eta L}{\pi r^4}$)**, the physiological role of arteriolar smooth muscle as the primary site of total peripheral vascular resistance ($r^4$ sensitivity), and systemic vascular resistance calculations in septic vs cardiogenic shock (John E. Hall, Michael E. Hall *Guyton and Hall Textbook of Medical Physiology* 14th ed. Chapters 14, 20; Linda S. Costanzo *Physiology* 7th ed. Chapter 4): formulate the **Cardiovascular Hemodynamics Master Formulas**:
$$\mathbf{CO = \text{HR} \times \text{SV} \quad [\text{L/min}] \quad \Big| \quad \text{SV} = \text{EDV} - \text{ESV} \quad [\text{mL}] \quad \Big| \quad \text{EF} = \frac{\text{EDV} - \text{ESV}}{\text{EDV}} \times 100\%}$$
$$\mathbf{\text{MAP} = \text{DBP} + \frac{1}{3} \left( \text{SBP} - \text{DBP} \right) = CO \times \text{SVR} \quad [\text{mmHg}]}$$
derive the **Poiseuille Vascular Resistance Law ($r^4$ Dependence)**:
$$\mathbf{R = \frac{8 \eta L}{\pi r^4} \quad \left( \frac{R_2}{R_1} = \left[ \frac{r_1}{r_2} \right]^4 \right)}$$
derive the **Fick Principle Equation for Cardiac Output ($CO$)**:
$$\mathbf{CO = \frac{\text{Whole-Body Oxygen Consumption Rate } (\dot{V}O_2)}{\text{Arterial } O_2 \text{ Content } (C_a O_2) - \text{Mixed Venous } O_2 \text{ Content } (C_v O_2)}}$$
(proving that halving the radius of an arteriole from $r \to r/2$ increases its local vascular resistance by $2^4 = 16\text{-fold}$, demonstrating why arteriolar vasoconstriction/vasodilation serves as the master controller of systemic blood pressure).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hemodynamic Formulations ($CO = \text{HR} \cdot \text{SV}, \text{MAP} = \text{DBP} + \frac{1}{3}\Delta P, \text{EF} = \frac{\text{SV}}{\text{EDV}}$) & Poiseuille ($R \propto 1/r^4$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Stroke Volume, Ejection Fraction, MAP, and SVR Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hemodynamic Parameter / Biophysical Law & Technical Clinical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | According to Poiseuille's Law of Fluid Dynamics ($R = \frac{8\eta L}{\pi r^4}$), Vascular Resistance Is Inversely Proportional to the Radius Raised to the ___ Power (Fourth / 4th) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Critical Care Problem: Computing Stroke Volume, Ejection Fraction, and Mean Arterial Pressure Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Cardiovascular Hemodynamics & Poiseuille Biophysics (Guyton 2021; Costanzo 2022):
   - **Hemodynamic Formulations:**
     $$\mathbf{CO = \text{HR} \times \text{SV} \quad \Big| \quad \text{EF} = \frac{\text{EDV} - \text{ESV}}{\text{EDV}} \times 100\% \quad \Big| \quad \text{MAP} = \text{DBP} + \frac{1}{3}(\text{SBP} - \text{DBP}) \quad \Big| \quad R = \frac{8\eta L}{\pi r^4}}$$
   - **The $r^4$ Power Invariant:**
     - Radius decreased by $50\%$ ($r \to 0.5r$) $\implies$ Resistance $R$ increases by $(1/0.5)^4 = \mathbf{16\times}$;
     - Radius increased by $20\%$ ($r \to 1.2r$) $\implies$ Resistance $R$ drops to $(1/1.2)^4 = \mathbf{0.482\times}$ ($> 50\%$ drop in resistance)!
2. **Slide 2 (`ordering`):** Provide 5 steps of comprehensive hemodynamic assessment: (1) measure End-Diastolic Volume (EDV) and End-Systolic Volume (ESV) via echocardiography, (2) calculate Stroke Volume $\text{SV} = \text{EDV} - \text{ESV}$ and Ejection Fraction $\text{EF} = (\text{SV} / \text{EDV}) \times 100\%$, (3) multiply Stroke Volume by Heart Rate to calculate Cardiac Output: $CO = \text{HR} \times \text{SV}$, (4) measure systolic and diastolic arterial pressures to calculate Mean Arterial Pressure: $\text{MAP} = \text{DBP} + \frac{1}{3}(\text{SBP} - \text{DBP})$, (5) evaluate Systemic Vascular Resistance: $\text{SVR} = (\text{MAP} - \text{CVP}) / CO \times 80$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Ejection Fraction EF, Mean Arterial Pressure MAP, Poiseuille's Law, Fick Principle) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Fourth (or 4th). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating SV, EF, and MAP: An ICU echocardiogram of a 55-year-old patient with hypertension reveals an End-Diastolic Volume of $\text{EDV} = 140.0\text{ mL}$ and an End-Systolic Volume of $\text{ESV} = 56.0\text{ mL}$. The patient's heart rate is $\text{HR} = 75.0\text{ bpm}$, and non-invasive blood pressure is $130.0 / 70.0\text{ mmHg}$ ($\text{SBP} = 130.0\text{ mmHg}, \text{DBP} = 70.0\text{ mmHg}$).
   - Stroke Volume:
     $\text{SV} = \text{EDV} - \text{ESV} = 140.0\text{ mL} - 56.0\text{ mL} = \mathbf{84.0\text{ mL}}$;
   - Ejection Fraction:
     $\text{EF} = \frac{84.0\text{ mL}}{140.0\text{ mL}} \times 100\% = \mathbf{0.600 \times 100\% = 60.0\%}$;
   - Cardiac Output:
     $CO = 75\text{ bpm} \times 84.0\text{ mL} = 6300\text{ mL/min} = \mathbf{6.30\text{ L/min}}$;
   - Mean Arterial Pressure:
     $\text{MAP} = 70.0 + \frac{1}{3}(130.0 - 70.0) = 70.0 + \frac{60.0}{3} = 70.0 + 20.0 = \mathbf{90.0\text{ mmHg}}$;
   - What are the Stroke Volume $\text{SV}$, Ejection Fraction $\text{EF}$, and Mean Arterial Pressure $\text{MAP}$? ($\text{SV} = \mathbf{84.0\text{ mL}}$, $\text{EF} = \mathbf{60.0\%}$, $\text{MAP} = \mathbf{90.0\text{ mmHg}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cardiac_output_hemodynamics_and_poiseuilles_law",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cardiovascular Hemodynamics \\& Poiseuille's Law (John E. Hall)**\n• **Core Hemodynamic Master Formulations:**\n$$\n\\mathbf{CO = \\text{HR} \\times \\text{SV} \\quad \\Big| \\quad \\text{SV} = \\text{EDV} - \\text{ESV} \\quad \\Big| \\quad \\text{EF} = \\frac{\\text{EDV} - \\text{ESV}}{\\text{EDV}} \\times 100\\%}\n$$\n$$\n\\mathbf{\\text{MAP} = \\text{DBP} + \\frac{1}{3} \\left( \\text{SBP} - \\text{DBP} \\right) = CO \\times \\text{SVR} \\quad [\\text{mmHg}]}\n$$\n• **Poiseuille Vascular Resistance Law ($r^4$ Power Invariant):**\n$$\n\\mathbf{R = \\frac{8 \\eta L}{\\pi r^4} \\quad \\left( \\text{Halving vessel radius } r \\to \\frac{r}{2} \\implies \\text{Resistance } R \\text{ increases by } 2^4 = \\mathbf{16\\times} \\right)}\n$$\n• **The Arteriolar SVR Invariant:** Arterioles constitute the **primary resistance vessels** of the systemic circulation; slight changes in arteriolar smooth muscle tone produce massive $r^4$-dependent shifts in systemic vascular resistance (SVR) and afterload!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform a complete hemodynamic calculation of Stroke Volume, EF, Cardiac Output, and MAP.",
      "orderItems": [
        "Record left ventricular End-Diastolic Volume (EDV) and End-Systolic Volume (ESV) from apical 4-chamber echocardiography",
        "Calculate Stroke Volume: SV = EDV - ESV and Ejection Fraction: EF = (SV / EDV) * 100%",
        "Multiply Stroke Volume by measured Heart Rate to compute total Cardiac Output: CO = HR * SV",
        "Record systemic blood pressure (SBP and DBP) and calculate pulse pressure: \u0394P = SBP - DBP",
        "Evaluate Mean Arterial Pressure: MAP = DBP + (1/3)*\u0394P to determine organ perfusion pressure"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hemodynamic Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Ejection Fraction (EF)", "right": "Fraction of end-diastolic volume ejected per beat: EF = (EDV - ESV) / EDV * 100% (Normal 55-70%)" },
        { "left": "Mean Arterial Pressure (MAP)", "right": "Time-weighted average arterial pressure driving tissue perfusion: MAP = DBP + 1/3*(SBP - DBP)" },
        { "left": "Poiseuille's Law (R \u221d 1/r^4)", "right": "Vascular resistance equation showing 16-fold resistance surge when arteriolar radius is halved" },
        { "left": "Fick Principle", "right": "Method computing cardiac output from whole-body O2 consumption divided by arteriovenous O2 difference" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to Poiseuille's law of fluid dynamics (R = 8\u03b7L / [\u03c0*r^4]), vascular resistance is inversely proportional to the radius raised to the ___ power.",
      "blankAnswer": "fourth",
      "blankDistractors": ["second", "third", "first"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An echocardiogram of a 55-year-old patient reveals EDV = 140.0 mL and ESV = 56.0 mL. The heart rate is HR = 75.0 bpm, and blood pressure is 130.0 / 70.0 mmHg. SV = 140.0 - 56.0 = 84.0 mL. EF = (84.0 / 140.0) * 100% = 60.0%. CO = 75 * 84.0 = 6.30 L/min. MAP = 70.0 + 1/3*(130.0 - 70.0) = 70.0 + 20.0 = 90.0 mmHg. What are the Stroke Volume SV, Ejection Fraction EF, and Mean Arterial Pressure MAP?",
      "options": [
        { "text": "SV = 84.0 mL, EF = 60.0%, and MAP = 90.0 mmHg (SV = 140.0 - 56.0 = 84.0 mL; EF = 84/140*100 = 60%; MAP = 70 + 60/3 = 90 mmHg)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the standard cardiovascular hemodynamic equations (John E. Hall *Guyton and Hall Textbook of Medical Physiology* Chapter 9; Linda S. Costanzo *Physiology* Chapter 4). 1. **Calculate Stroke Volume (SV):** - End-Diastolic Volume: $\\text{EDV} = 140.0\\text{ mL}$. - End-Systolic Volume: $\\text{ESV} = 56.0\\text{ mL}$. $$\\text{SV} = \\text{EDV} - \\text{ESV} = 140.0\\text{ mL} - 56.0\\text{ mL} = \\mathbf{84.0\\text{ mL}}$$ 2. **Calculate Ejection Fraction (EF):** $$\\text{EF} = \\frac{\\text{SV}}{\\text{EDV}} \\times 100\\% = \\frac{84.0\\text{ mL}}{140.0\\text{ mL}} \\times 100\\% = 0.6000 \\times 100\\% = \\mathbf{60.0\\%}$$ 3. **Calculate Cardiac Output (CO):** $$CO = \\text{HR} \\times \\text{SV} = 75.0\\text{ bpm} \\times 84.0\\text{ mL} = 6300\\text{ mL/min} = \\mathbf{6.30\\text{ L/min}}$$ 4. **Calculate Mean Arterial Pressure (MAP):** - Systolic Blood Pressure: $\\text{SBP} = 130.0\\text{ mmHg}$. - Diastolic Blood Pressure: $\\text{DBP} = 70.0\\text{ mmHg}$. - Pulse Pressure: $\\Delta P = \\text{SBP} - \\text{DBP} = 130.0 - 70.0 = 60.0\\text{ mmHg}$. $$\\text{MAP} = \\text{DBP} + \\frac{1}{3} \\left( \\text{SBP} - \\text{DBP} \\right) = 70.0\\text{ mmHg} + \\frac{60.0\\text{ mmHg}}{3} = 70.0 + 20.0 = \\mathbf{90.0\\text{ mmHg}}$$ Flawless cardiovascular hemodynamic and Poiseuille derivation!" },
        { "text": "SV = 56.0 mL, EF = 40.0%, and MAP = 100.0 mmHg (Calculated using simple midpoint average for MAP)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SV = 84.0 mL, EF = 84.0%, and MAP = 90.0 mmHg", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SV = 140.0 mL, EF = 100.0%, and MAP = 130.0 mmHg", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
