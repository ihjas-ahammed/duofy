# Duofy Reusable Lesson Format: Cardiovascular Mechanics (Wiggers Diagram & PV Loops)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Physiology / Cardiovascular_and_Respiratory_Physiology`  
**Lesson Format Type:** `cardiac_cycle_wiggers_diagram_and_pv_loops`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the electromechanical events of the cardiac cycle, the chronological synchronization of ECG waveforms, intracardiac pressures, and ventricular volume on the **Wiggers Diagram**, the four cardinal phases of the **Left Ventricular Pressure-Volume (P-V) Loop** (Phase 1: Ventricular Filling; Phase 2: **Isovolumetric Contraction** where all 4 valves are closed and $dP/dt$ peaks; Phase 3: **Rapid & Reduced Ventricular Ejection**; Phase 4: **Isovolumetric Relaxation** where all 4 valves are closed and pressure plummets), the mechanical genesis of heart sounds (**S1 "lub"** caused by Mitral and Tricuspid AV valve closure at the onset of isovolumetric contraction; **S2 "dub"** caused by Aortic and Pulmonic semilunar valve closure at the onset of isovolumetric relaxation; **S3** early diastolic rapid filling sound in heart failure / volume overload; **S4** late diastolic "atrial kick" against a stiff, non-compliant hypertrophied ventricle), and P-V loop shifts under altered **Preload**, **Afterload**, and **Inotropy** (John E. Hall, Michael E. Hall *Guyton and Hall Textbook of Medical Physiology* 14th ed. Chapter 9; Linda S. Costanzo *Physiology* 7th ed. Chapter 4): formulate the **Cardiac Cycle Phases & Heart Sounds Master Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Cardiac Cycle Phase} & \textbf{Mitral Valve} & \textbf{Aortic Valve} & \textbf{Ventricular Volume} & \textbf{Acoustic Heart Sound Genesis} \\
\hline
\mathbf{\text{Isovolumetric Contraction}} & \mathbf{\text{CLOSED}} & \mathbf{\text{CLOSED}} & \mathbf{\text{Constant (EDV } \approx 120\text{ mL)}} & \mathbf{\text{S1 Heart Sound (AV valve closure at R-wave)}} \\
\mathbf{\text{Ventricular Ejection}} & \text{CLOSED} & \mathbf{\text{OPEN}} & \text{Decreases } (120 \to 50\text{ mL}) & \text{Systolic murmur if aortic stenosis} \\
\mathbf{\text{Isovolumetric Relaxation}} & \mathbf{\text{CLOSED}} & \mathbf{\text{CLOSED}} & \mathbf{\text{Constant (ESV } \approx 50\text{ mL)}} & \mathbf{\text{S2 Heart Sound (Semilunar closure at end T-wave)}} \\
\mathbf{\text{Early Rapid Filling}} & \mathbf{\text{OPEN}} & \text{CLOSED} & \text{Increases rapidly} & \mathbf{\text{S3 Heart Sound (Volume overload / dilated cardiomyopathy)}} \\
\mathbf{\text{Late Atrial Systole}} & \mathbf{\text{OPEN}} & \text{CLOSED} & \text{Topping off to EDV} & \mathbf{\text{S4 Heart Sound (Atrial kick into stiff hypertrophied LV)}} \\
\hline
\end{array}$$
master the **P-V Loop Morphing Rules**:
$$\mathbf{\text{Preload } \uparrow \implies \text{EDV } \uparrow \implies \text{Loop widens rightward } (\text{SV } \uparrow) \ \Big| \ \text{Afterload } \uparrow \implies \text{ESV } \uparrow \implies \text{Loop taller and narrower } (\text{SV } \downarrow)}$$
$$\mathbf{\text{Inotropy } \uparrow \implies \text{ESPVR shifts leftward } \implies \text{ESV } \downarrow \implies \text{Loop widens leftward } (\text{SV } \uparrow, \text{EF } \uparrow)}$$
(proving that S1 occurs when AV valves snap shut as ventricular pressure exceeds atrial pressure, while S2 occurs when semilunar valves snap shut as ventricular pressure drops below aortic pressure).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Wiggers Diagram, Left Ventricular P-V Loop Phases & S1, S2, S3, S4 Heart Sounds Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Left Ventricular Hemodynamics Through the 4 P-V Loop Phases Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cardiac Phase / Heart Sound & Technical Mechanical Event Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The First Heart Sound (S1) Produced at the Onset of Isovolumetric Contraction Is Caused by the Closure of the Atrioventricular (Mitral and Tricuspid) ___ (Valves / AV Valves) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Cardiology Problem: Identifying the Impact of Increased Inotropy on the End-Systolic Pressure-Volume Relationship Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Wiggers Diagram & P-V Loop Mechanics (Guyton 2021; Costanzo 2022):
   - **Phase Formulations:**
     $$\mathbf{\text{Phase 1: Filling } (\text{Mitral Open}) \to \text{Phase 2: Isovol. Contraction } (\text{All Closed, S1}) \to \text{Phase 3: Ejection } (\text{Aortic Open}) \to \text{Phase 4: Isovol. Relaxation } (\text{All Closed, S2})}$$
   - **Heart Sound Invariants:**
     - **S1 ("lub"):** Mitral + Tricuspid closure (start of systole, isovolumetric contraction);
     - **S2 ("dub"):** Aortic + Pulmonic closure (end of systole, isovolumetric relaxation);
     - **S3:** Rapid ventricular filling in early diastole (volume overload / CHF);
     - **S4:** Atrial contraction against stiff non-compliant ventricle (LV hypertrophy / hypertension)!
2. **Slide 2 (`ordering`):** Provide 5 steps of the left ventricular P-V loop: (1) mitral valve closes when left ventricular pressure exceeds left atrial pressure at End-Diastolic Volume (EDV), generating S1, (2) left ventricle contracts with all valves closed during isovolumetric contraction, rapidly spiking pressure to $80\text{ mmHg}$, (3) aortic valve opens when LV pressure exceeds aortic diastolic pressure, ejecting stroke volume into the aorta, (4) aortic valve snaps shut when LV pressure falls below aortic pressure at End-Systolic Volume (ESV), generating S2, (5) LV undergoes isovolumetric relaxation until LV pressure falls below atrial pressure, reopening the mitral valve to begin diastolic filling!
3. **Slide 3 (`matching`):** Pair 4 concepts (S1 Heart Sound, S2 Heart Sound, S3 Heart Sound, S4 Heart Sound) with their mechanical origins.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Valves (or AV Valves). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on P-V loop alteration by inotropic drugs: A patient with acute decompensated heart failure is administered an intravenous infusion of dobutamine (a beta-1 adrenergic inotrope). How does this increase in myocardial contractility alter the Left Ventricular Pressure-Volume loop?
   - Dobutamine increases inotropy $\implies$ Shifts the End-Systolic Pressure-Volume Relationship (ESPVR) line to the **left**;
   - Increases stroke volume by decreasing **End-Systolic Volume (ESV)** and increasing **Ejection Fraction (EF)**;
   - How does the loop change? (Shifts the **ESPVR to the left**, decreasing **End-Systolic Volume (ESV)** and increasing **Stroke Volume**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cardiac_cycle_wiggers_diagram_and_pv_loops",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cardiac Cycle \\& Pressure-Volume Loops (Linda S. Costanzo)**\n• **Left Ventricular Pressure-Volume (P-V) Loop Four-Phase Cycle:**\n  - **Phase 1 (Ventricular Filling):** Mitral valve open; LV volume increases from End-Systolic Volume ($\\text{ESV} \\approx 50\\text{ mL}$) to End-Diastolic Volume ($\\text{EDV} \\approx 120\\text{ mL}$);\n  - **Phase 2 (Isovolumetric Contraction):** **All 4 valves CLOSED**; LV pressure spikes from $10 \\to 80\\text{ mmHg}$ at constant EDV volume; begins with **S1 Heart Sound** (Mitral/Tricuspid closure);\n  - **Phase 3 (Ventricular Ejection):** Aortic valve opens at $80\\text{ mmHg}$; stroke volume is ejected into aorta, peaking at $120\\text{ mmHg}$;\n  - **Phase 4 (Isovolumetric Relaxation):** **All 4 valves CLOSED**; begins with **S2 Heart Sound** (Aortic/Pulmonic closure); LV pressure plummets from $100 \\to 10\\text{ mmHg}$ at constant ESV volume;\n• **The Four Heart Sounds Acoustic Hierarchy:**\n  - **S1 ('lub'):** Closure of AV valves (Mitral + Tricuspid) at onset of systole;\n  - **S2 ('dub'):** Closure of Semilunar valves (Aortic + Pulmonic) at end of systole;\n  - **S3:** Rapid ventricular filling in early diastole (Volume overload / Heart failure);\n  - **S4 ('Atrial Kick'):** Atrial contraction against a stiff, non-compliant ventricle (LV hypertrophy / Chronic hypertension)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential hemodynamic events of the Left Ventricular Pressure-Volume loop during a single cardiac cycle.",
      "orderItems": [
        "Mitral valve closes at End-Diastolic Volume (EDV \u2248 120 mL) producing the S1 heart sound",
        "Ventricular myocardium contracts with all valves closed during isovolumetric contraction spiking pressure to 80 mmHg",
        "Aortic valve opens as LV pressure exceeds aortic diastolic pressure, ejecting stroke volume into the systemic aorta",
        "Aortic valve closes at End-Systolic Volume (ESV \u2248 50 mL) producing the S2 heart sound",
        "Left ventricle relaxes with all valves closed during isovolumetric relaxation until mitral valve reopens for diastolic filling"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Heart Sound to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "S1 Heart Sound", "right": "Closure of Mitral and Tricuspid atrioventricular valves marking the onset of isovolumetric contraction" },
        { "left": "S2 Heart Sound", "right": "Closure of Aortic and Pulmonic semilunar valves marking the onset of isovolumetric relaxation" },
        { "left": "S3 Heart Sound", "right": "Early diastolic rapid filling sound caused by massive blood influx into a dilated, volume-overloaded ventricle" },
        { "left": "S4 Heart Sound", "right": "Late diastolic sound caused by atrial kick forcing blood into a stiff, hypertrophied non-compliant ventricle" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The first heart sound (S1) produced at the onset of isovolumetric contraction is caused by the closure of the atrioventricular (mitral and tricuspid) ___.",
      "blankAnswer": "valves",
      "blankDistractors": ["arteries", "chambers", "septa"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A patient in cardiogenic shock is treated with an intravenous infusion of dobutamine, a beta-1 adrenergic agonist that markedly enhances myocardial contractility (inotropy). How does this positive inotropic intervention alter the Left Ventricular Pressure-Volume loop?",
      "options": [
        { "text": "Shifts the End-Systolic Pressure-Volume Relationship (ESPVR) line to the left, decreasing End-Systolic Volume (ESV) and increasing Stroke Volume (Enhanced inotropy ejects more blood, emptying the ventricle to a lower ESV)", "isCorrect": true, "explanation": "Correct! Let's analyze how inotropy alters the Left Ventricular Pressure-Volume (P-V) loop (John E. Hall *Guyton and Hall Textbook of Medical Physiology* Chapter 9; Linda S. Costanzo *Physiology* Chapter 4). 1. **Myocardial Inotropy \\& The ESPVR Line:** - The slope of the **End-Systolic Pressure-Volume Relationship (ESPVR)** line represents myocardial contractility (inotropy). - Beta-1 adrenergic stimulation (via Dobutamine or Epinephrine) enhances intracellular calcium release via Protein Kinase A phosphorylation of L-type calcium channels and phospholamban. 2. **P-V Loop Morphological Shift:** - Increased contractility causes the ventricle to contract with greater force and velocity, ejecting a larger fraction of blood against any given afterload. - This shifts the **ESPVR line to the left and increases its slope**. - Consequently, the ventricle empties more completely, resulting in a **decreased End-Systolic Volume (ESV)**. 3. **Hemodynamic Calculations:** $$\\text{Stroke Volume (SV)} = \\text{EDV} - \\text{ESV} \\implies \\text{Decreased ESV increases SV!}$$ $$\\text{Ejection Fraction (EF)} = \\frac{\\text{SV}}{\\text{EDV}} \\times 100\\% \\implies \\text{Increases EF!}$$ Flawless cardiovascular Pressure-Volume loop inotropic derivation!" },
        { "text": "Shifts the loop to the right, increasing End-Diastolic Volume without changing ESV (This describes an increase in preload)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Increases afterload, leading to an elevated ESV and reduced Stroke Volume", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Abolishes the isovolumetric contraction phase completely", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
