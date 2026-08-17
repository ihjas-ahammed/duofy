# Duofy Reusable Lesson Format: Cardiovascular Pathology (MI Timeline & Rupture Risks)

**Target Topic:** `05_Medicine_and_Health_Sciences / 02_Para_Clinical_Sciences / Pathology_and_Hematology / Systemic_Pathology_Organ_Systems`  
**Lesson Format Type:** `myocardial_infarction_histologic_timeline_and_rupture_risks`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the chronological histopathological evolution, gross macroscopic appearances, and life-threatening complications of acute **Myocardial Infarction (MI)** across all six canonical timeframes (**$0 - 4\text{ hours}$**: gross/light microscopic changes absent, minimal wavy fibers at infarct border, primary lethal risk is fatal **Ventricular Fibrillation**; **$4 - 24\text{ hours}$**: dark mottling grossly, early **coagulative necrosis**, wavy fibers, and contraction band necrosis from reperfusion, troponin I and CK-MB surge; **$1 - 3\text{ days}$**: yellow-tan pallor with hyperemic border, dense **neutrophilic infiltrate**, fibrinous pericarditis causing pericardial friction rub; **$3 - 7\text{ days}$**: central yellow-tan softening with hyperemic rim, **macrophage infiltration** digesting necrotic debris, **PEAK RISK OF MECHANICAL RUPTURES**: 1: Left ventricular free wall rupture $\to$ hemopericardium and fatal cardiac tamponade with Beck's triad, 2: Interventricular septum rupture $\to$ VSD with harsh holosystolic murmur and left-to-right shunt, 3: Posteromedial papillary muscle rupture $\to$ acute severe mitral regurgitation and cardiogenic pulmonary edema; **$7 - 10\text{ days}$**: red-purple depressed margins, well-developed **granulation tissue** with neovessels and Type III collagen; **$> 2\text{ weeks} - \text{months}$**: gray-white dense fibrous **Type I collagen scar**, risk of true ventricular aneurysm and autoimmune Dressler syndrome pericarditis) (Vinay Kumar, Abul K. Abbas, Jon C. Aster *Robbins and Cotran Pathologic Basis of Disease* 10th ed. Chapter 12; Edward C. Klatt *Robbins and Cotran Review of Pathology* 5th ed.): formulate the **Myocardial Infarction Histopathologic Evolution Master Matrix**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Time Post-MI} & \textbf{Gross Appearance} & \textbf{Microscopic Hallmark} & \textbf{Primary Lethal Complications} \\
\hline
\mathbf{0 - 4\text{ Hours}} & \text{None (Pale/Normal)} & \text{Minimal wavy fibers at border} & \mathbf{\text{Fatal Ventricular Fibrillation (VFib)}} \\
\mathbf{4 - 24\text{ Hours}} & \text{Dark mottling, Tetrazolium pallor} & \mathbf{\text{Early coagulative necrosis, Contraction bands}} & \text{Cardiogenic shock, Arrhythmias} \\
\mathbf{1 - 3\text{ Days}} & \text{Yellow-tan center, Hyperemic rim} & \mathbf{\text{Peak Neutrophilic Infiltrate, Loss of nuclei}} & \mathbf{\text{Fibrinous Pericarditis (Friction rub)}} \\
\mathbf{3 - 7\text{ Days}} & \mathbf{\text{Yellow-tan soft necrotic center}} & \mathbf{\text{Macrophage Phagocytosis of dead myocytes}} & \mathbf{\begin{cases} \mathbf{\text{1. Free Wall Rupture (Tamponade)}} \\ \mathbf{\text{2. IV Septum Rupture (VSD)}} \\ \mathbf{\text{3. Papillary Muscle Rupture (MR)}} \end{cases}} \\
\hline
\mathbf{7 - 10\text{ Days}} & \text{Red-purple depressed edges} & \mathbf{\text{Granulation Tissue (Neovessels + Type III Coll)}} & \text{Mural thrombus formation} \\
\mathbf{> 2\text{ Wks - Mos}} & \text{Gray-white dense fibrous scar} & \mathbf{\text{Dense Type I Collagenous Scar}} & \mathbf{\text{Ventricular Aneurysm, Dressler Syndrome}} \\
\hline
\end{array}$$
master the **Day 3-7 Mechanical Rupture Triad Formulation**:
$$\mathbf{\text{Day 3 - 7 Macrophage Hydrolysis} \implies \text{Myocardial Structural Weakness} \to \begin{cases} \mathbf{\text{Free Wall Rupture } \implies \text{Cardiac Tamponade (Beck's Triad)}} \\ \mathbf{\text{Papillary Muscle Rupture } \implies \text{Acute Mitral Regurgitation \& Shock}} \\ \mathbf{\text{Septal Rupture } \implies \text{Ventricular Septal Defect (VSD)}} \end{cases}}$$
(proving that the heart wall is structurally weakest between Days 3 and 7 because dead tissue has been digested by macrophages before new collagenous granulation tissue can deposit tensile support).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Post-MI Timeline (0-4h, 4-24h, 1-3d, 3-7d, 7-10d, 2wk+) & Rupture Risks Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Histopathological Healing from Contraction Bands to Mature Fibrous Scar Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Time Post-MI / Morphologic Phase & Technical Pathological Hallmark Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Timeline of Myocardial Infarction, Left Ventricular Free Wall Rupture Leading to Fatal Cardiac Tamponade Occurs Most Commonly Between Days ___ Post-MI (3 to 7 / 3-7) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Cardiology & Autopsy Problem: Diagnosing Papillary Muscle Rupture Causing Acute Pulmonary Edema on Day 5 Post-MI Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Myocardial Infarction Morphologic Timeline (Robbins 2021):
   - **Chronological Formulations:**
     $$\mathbf{0-4\text{h: Arrhythmias (VFib)} \to 4-24\text{h: Coagulative Necrosis} \to 1-3\text{d: Neutrophils} \to \mathbf{3-7\text{d: Macrophages \& Ruptures}} \to >2\text{wks: Collagen Scar}}$$
   - **The Day 3-7 Rupture Invariant:**
     - Macrophage enzymes digest the necrotic myocytes before granulation collagen has matured;
     - This creates the absolute **structural nadir of myocardial tensile strength**, making Days 3-7 the peak window for free wall rupture, VSD, and papillary muscle rupture!
2. **Slide 2 (`ordering`):** Provide 5 steps of the post-MI healing timeline: (1) coronary occlusion results in early coagulative necrosis with wavy myocardial fibers and contraction bands within 4-24 hours, (2) dense neutrophilic infiltrate peaks between days 1 and 3, causing a localized fibrinous pericarditis, (3) macrophages infiltrate between days 3 and 7, phagocytosing dead cardiomyocytes and predisposing to mechanical wall rupture, (4) vascular granulation tissue with budding neovessels and Type III collagen forms between days 7 and 10, (5) dense Type I collagenous scar progressively replaces granulation tissue beyond 2 weeks, completing a mature fibrous scar by 2 months!
3. **Slide 3 (`matching`):** Pair 4 concepts (4-24 Hours, 1-3 Days, 3-7 Days, > 2 Weeks) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 3 to 7 (or 3-7). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Day 5 post-MI mechanical rupture: On day 5 following an acute ST-elevation myocardial infarction involving the right coronary artery (inferior wall), a 66-year-old male develops sudden severe dyspnea, hypotension ($80/50\text{ mmHg}$), and a new loud, harsh holosystolic murmur heard best at the cardiac apex radiating to the axilla. Pulmonary examination reveals diffuse bilateral crackles. What is the most likely mechanical complication?
   - Day 5 post-MI + Inferior MI (RCA) + Sudden hypotension + Apical holosystolic murmur radiating to axilla + Acute pulmonary edema $\implies$ **Posteromedial Papillary Muscle Rupture causing Acute Severe Mitral Regurgitation**;
   - Macrophage lysis between days 3-7 weakens the single-blood-supply posteromedial papillary muscle;
   - What is the diagnosis? (**Posteromedial Papillary Muscle Rupture** causing **Acute Severe Mitral Regurgitation**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "myocardial_infarction_histologic_timeline_and_rupture_risks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Myocardial Infarction Chronological Evolution (Vinay Kumar)**\n• **Post-MI Histopathologic \\& Clinical Timeline Matrix:**\n$$\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Time Post-MI} & \\textbf{Gross Appearance} & \\textbf{Microscopic Hallmark} & \\textbf{Primary Lethal Complications} \\\\\n\\hline\n\\mathbf{0 - 4\\text{ Hours}} & \\text{None / Dark mottling} & \\text{Minimal wavy fibers at border} & \\mathbf{\\text{Fatal Ventricular Fibrillation (VFib)}} \\\\\n\\mathbf{4 - 24\\text{ Hours}} & \\text{Dark mottling, Tetrazolium pallor} & \\mathbf{\\text{Early coagulative necrosis, Contraction bands}} & \\text{Cardiogenic shock, Troponin surge} \\\\\n\\mathbf{1 - 3\\text{ Days}} & \\text{Yellow-tan center, Hyperemic rim} & \\mathbf{\\text{Peak Neutrophils, Anucleate myocytes}} & \\mathbf{\\text{Fibrinous Pericarditis (Friction rub)}} \\\\\n\\mathbf{3 - 7\\text{ Days}} & \\mathbf{\\text{Yellow-tan soft necrotic center}} & \\mathbf{\\text{Macrophage Phagocytosis of dead tissue}} & \\mathbf{\\begin{cases} \\mathbf{\\text{1. Free Wall Rupture (Tamponade)}} \\\\ \\mathbf{\\text{2. IV Septal Rupture (VSD)}} \\\\ \\mathbf{\\text{3. Papillary Muscle Rupture (MR)}} \\end{cases}} \\\\\n\\hline\n\\mathbf{7 - 10\\text{ Days}} & \\text{Red-purple depressed margins} & \\mathbf{\\text{Granulation Tissue (Neovessels + Type III Coll)}} & \\text{Mural thrombi formation} \\\\\n\\mathbf{> 2\\text{ Wks - Mos}} & \\text{Gray-white dense fibrous scar} & \\mathbf{\\text{Dense Type I Collagenous Scar}} & \\mathbf{\\text{Ventricular Aneurysm, Dressler Syndrome}} \\\\\n\\hline\n\\end{array}$$\n• **The Structural Nadir Invariant:** The myocardium is **structurally weakest between Days 3 and 7** because macrophage proteases have digested necrotic muscle while new collagen synthesis is just beginning, creating the **peak window for lethal cardiac rupture**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential histopathological healing phases of a Myocardial Infarction from acute coronary occlusion to mature collagen scar.",
      "orderItems": [
        "Wavy myofibers and early coagulative necrosis with contraction bands appear within 4 to 24 hours of occlusion",
        "Dense neutrophilic infiltrate peaks between days 1 and 3, causing a localized fibrinous pericarditis",
        "Abundant macrophages infiltrate between days 3 and 7 to phagocytose necrotic debris, creating maximal rupture risk",
        "Vascular granulation tissue containing budding capillaries and Type III collagen establishes margin repair at 7 to 10 days",
        "Dense Type I collagenous scar progressively replaces granulation tissue beyond 2 weeks to form a permanent fibrous scar"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Time Interval Post-MI to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "4 - 24 Hours", "right": "Early coagulative necrosis with contraction bands and wavy fibers; first rise in serum troponin and CK-MB" },
        { "left": "1 - 3 Days", "right": "Peak neutrophilic infiltration with loss of myocyte nuclei and localized fibrinous pericarditis" },
        { "left": "3 - 7 Days", "right": "Macrophage phagocytosis of dead tissue with peak risk of ventricular free wall, septal, and papillary rupture" },
        { "left": "> 2 Weeks to Months", "right": "Mature gray-white Type I collagenous scar with late risk of true ventricular aneurysm and Dressler syndrome" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the timeline of myocardial infarction, left ventricular free wall rupture leading to fatal cardiac tamponade occurs most commonly between days ___ post-MI.",
      "blankAnswer": "3 to 7",
      "blankDistractors": ["1 to 3", "7 to 10", "14 to 21"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "On day 5 following an acute ST-elevation myocardial infarction of the inferior wall (RCA territory), a 66-year-old male develops sudden severe dyspnea, hypotension (80/50 mmHg), and a new loud, harsh apical holosystolic murmur radiating to the axilla. Pulmonary examination reveals diffuse bilateral crackles. What is the most likely mechanical complication?",
      "options": [
        { "text": "Posteromedial Papillary Muscle Rupture causing acute severe Mitral Regurgitation and cardiogenic pulmonary edema (Day 3-7 macrophage lysis weakens the single-blood-supply posteromedial papillary muscle)", "isCorrect": true, "explanation": "Correct! Let's examine the timeline and mechanical complications of acute myocardial infarction (Vinay Kumar *Robbins and Cotran Pathologic Basis of Disease* Chapter 12; Edward C. Klatt *Robbins and Cotran Review of Pathology* Chapter 11). 1. **Pathophysiology of Days 3 to 7 Post-MI:** - Between **Days 3 and 7 post-MI**, abundant macrophages infiltrate the infarcted zone to clear necrotic cardiomyocytes via active phagocytosis. - This enzymatic digestion reaches a structural nadir where dead muscle has been removed but substantial collagenous granulation tissue has not yet deposited, leaving the myocardium at its **highest risk for mechanical rupture**. 2. **Evaluation of Posteromedial Papillary Muscle Rupture:** - The **posteromedial papillary muscle** has a single vascular blood supply from the Posterior Descending Artery (PDA, usually from the **Right Coronary Artery RCA** in $85\\%$ of individuals with right-dominant circulation). - In contrast, the anterolateral papillary muscle has dual blood supply (LAD and LCx), making it far more resistant to ischemic necrosis. - Necrosis and rupture of the posteromedial papillary muscle at Day 5 detaches the chordae tendineae, causing a flail mitral leaflet. 3. **Clinical Presentation:** - Manifests abruptly as **acute, severe Mitral Regurgitation (MR)** with a new loud apical holosystolic murmur radiating to the left axilla. - The sudden, massive volume overload into the compliant, non-dilated left atrium transmits high hydrostatic pressure into pulmonary veins, triggering acute cardiogenic **pulmonary edema (diffuse crackles)**, severe hypotension, and cardiogenic shock requiring emergent surgical intervention! Flawless MI timeline and cardiovascular pathology derivation!" },
        { "text": "Left ventricular free wall rupture with cardiac tamponade and electrical alternans", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ventricular septal defect with a harsh left sternal border holosystolic murmur and left-to-right shunt", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Dressler syndrome autoimmune pericarditis occurring 4 weeks later", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
