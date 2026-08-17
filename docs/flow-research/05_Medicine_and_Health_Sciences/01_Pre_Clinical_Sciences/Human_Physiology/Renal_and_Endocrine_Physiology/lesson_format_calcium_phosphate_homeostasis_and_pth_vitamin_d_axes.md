# Duofy Reusable Lesson Format: Endocrine Mineral (PTH, Calcitriol, & Calcium Axes)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Physiology / Renal_and_Endocrine_Physiology`  
**Lesson Format Type:** `calcium_phosphate_homeostasis_and_pth_vitamin_d_axes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the endocrine regulation of systemic calcium ($\text{Ca}^{2+}$) and inorganic phosphate ($\text{PO}_4^{3-}$) homeostasis, the calcium-sensing receptor (CaSR on parathyroid chief cells), the three targeted actions of **Parathyroid Hormone (PTH)** to elevate ionized serum calcium and lower serum phosphate (1: stimulating osteoclast bone resorption via osteoblast RANKL signaling, 2: increasing distal convoluted tubule apical $Ca^{2+}$ reabsorption via TRPV5 and calbindin, 3: inhibiting proximal tubule $\text{Na}^+\text{-phosphate}$ cotransporters Npt2a/2c causing phosphaturia, and 4: up-regulating renal mitochondrial **1-$\alpha$-hydroxylase (CYP27B1)** to synthesize active **Calcitriol / 1,25-$(\text{OH})_2\text{-D}_3$**), the actions of Calcitriol on the intestine (inducing calbindin-D28k for intestinal $Ca^{2+}$ and $PO_4^{3-}$ absorption), **Fibroblast Growth Factor 23 (FGF23)**, **Calcitonin** (thyroid C-cells), and the laboratory differential of calcium disorders: **Primary Hyperparathyroidism** ($\uparrow \text{PTH}, \uparrow \text{Ca}^{2+}, \downarrow \text{PO}_4^{3-}$, "bones, stones, groans, psychiatric overtones"), **Hypoparathyroidism** ($\downarrow \text{PTH}, \downarrow \text{Ca}^{2+}, \uparrow \text{PO}_4^{3-}$, Chvostek/Trousseau signs), and **Secondary Hyperparathyroidism in Chronic Kidney Disease** ($\uparrow \text{PTH}, \downarrow \text{Ca}^{2+}, \uparrow \text{PO}_4^{3-}$, renal osteodystrophy) (John E. Hall, Michael E. Hall *Guyton and Hall Textbook of Medical Physiology* 14th ed. Chapter 80; Linda S. Costanzo *Physiology* 7th ed. Chapter 7): formulate the **Calcium-Phosphate Mineral Endocrine Dual Action Master Formulations**:
$$\mathbf{\text{PTH Output} \implies \begin{cases} \mathbf{\uparrow \text{Serum } Ca^{2+}} & (\text{Bone Resorption via RANKL} + \text{Distal Tubule } Ca^{2+} \text{ Reabsorption}) \\ \mathbf{\downarrow \text{Serum } PO_4^{3-}} & (\text{Inhibits PCT Na-Phosphate Cotransport } \to \mathbf{\text{Phosphaturia}}) \\ \mathbf{\uparrow \text{1,25-(OH)}_2\text{-D}_3} & (\text{Stimulates Renal 1-}\alpha\text{-Hydroxylase } \to \uparrow \text{Intestinal } Ca^{2+}/PO_4^{3-} \text{ Absorption}) \end{cases}}$$
master the **Calcium & Phosphate Endocrine Laboratory Differential Matrix**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Clinical Endocrine Disorder} & \textbf{Serum PTH} & \textbf{Serum } Ca^{2+} & \textbf{Serum } PO_4^{3-} & \textbf{Underlying Pathophysiology} \\
\hline
\mathbf{\text{Primary Hyperparathyroidism}} & \mathbf{\uparrow \text{ELEVATED}} & \mathbf{\uparrow \text{ELEVATED}} & \mathbf{\downarrow \text{DECREASED}} & \mathbf{\text{Parathyroid adenoma autonomous PTH hypersecretion}} \\
\mathbf{\text{Hypoparathyroidism}} & \mathbf{\downarrow \text{DECREASED}} & \mathbf{\downarrow \text{DECREASED}} & \mathbf{\uparrow \text{ELEVATED}} & \mathbf{\text{Surgical thyroidectomy / autoimmune parathyroid destruction}} \\
\mathbf{\text{Secondary Hyperparathyroidism}} & \mathbf{\uparrow \text{ELEVATED}} & \mathbf{\downarrow \text{DECREASED}} & \mathbf{\uparrow \text{ELEVATED}} & \mathbf{\text{Chronic Kidney Disease (Phosphate retention + } \downarrow \text{Calcitriol)}} \\
\text{Vitamin D Deficiency (Rickets)} & \uparrow \text{Elevated (Secondary)} & \downarrow \text{Decreased / Normal} & \downarrow \text{Decreased} & \text{Lack of UV / Dietary Vitamin D } \to \downarrow \text{GI absorption} \\
\hline
\end{array}$$
(proving that PTH acts as a phosphate-wasting hormone to prevent the precipitation of insoluble calcium phosphate crystals in soft tissues when serum calcium is mobilized), and interact with live Renal clearance GFR/RPF calculator, Nephron tubular transport & diuretic mapper, RAAS hemodynamic cascade simulator, and Calcium-phosphate mineral balance explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PTH vs Calcitriol Actions on Bone, Kidney, Intestine & Primary vs Secondary Lab Profiles Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Parathyroid Hormone Signaling from Hypocalcemia to Normal Serum Calcium Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mineral Hormone / Cellular Effector & Technical Calcium Regulation Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Kidney Proximal Tubule, Parathyroid Hormone Inhibits the $Na^+\text{-Phosphate}$ Cotransporter to Increase Urinary Phosphate Excretion, a Physiological Process Termed ___ (Phosphaturia / Phosphate Wasting) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Renal & Endocrine Physiology Studio: Clearance, Tubular Diuretics, RAAS & Calcium Homeostasis Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "calcium_phosphate_homeostasis_and_pth_vitamin_d_axes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do PTH and Calcitriol cooperatively regulate serum calcium and phosphate, and what are the hallmark lab profiles of primary hyperparathyroidism vs CKD?",
      "blankAnswer": "Mineral Physiology \\& Endocrine Axes (Hall 2021; Costanzo 2022): (1) PTH ACTIONS: Stimulated by low ionized Ca2+ sensing at CaSR. - Bone: Stimulates osteoclast resorption via osteoblast RANKL. - Kidney: Reabsorbs Ca2+ in DCT via TRPV5; Inhibits Na-phosphate cotransporter in PCT (\u2193 serum PO4, Phosphaturia); Stimulates 1-\u03b1-hydroxylase. (2) CALCITRIOL (1,25-(OH)2-D3): Stimulates intestinal absorption of BOTH Ca2+ and PO4. (3) PRIMARY HYPERPARATHYROIDISM: \u2191 PTH, \u2191 Ca2+, \u2193 PO4 (Stones, bones, groans). (4) SECONDARY (CKD): \u2191 PTH, \u2193 Ca2+, \u2191 PO4 (Failing kidneys retain phosphate and cannot activate Vitamin D)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential endocrine and renal responses triggered by acute systemic hypocalcemia to restore normal ionized calcium levels.",
      "orderItems": [
        "Drop in extracellular ionized Ca2+ relieves calcium-sensing receptor (CaSR) inhibition on parathyroid chief cells",
        "Chief cells rapidly exocytose stored Parathyroid Hormone (PTH) into the systemic bloodstream",
        "PTH binds to osteoblasts, increasing RANKL expression to stimulate osteoclast bone resorption and release Ca2+",
        "PTH stimulates distal convoluted tubule TRPV5 channels to maximize renal calcium reabsorption while inducing phosphaturia",
        "PTH up-regulates renal 1-\u03b1-hydroxylase, synthesizing calcitriol to enhance intestinal calcium and phosphate absorption"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Mineral Endocrine Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Parathyroid Hormone (PTH)", "right": "Polypeptide hormone elevating serum Ca2+ while lowering serum PO4 via renal phosphaturia" },
        { "left": "Calcitriol (1,25-(OH)2-D3)", "right": "Active steroid hormone synthesized in proximal tubule driving intestinal absorption of Ca2+ and PO4" },
        { "left": "Calcium-Sensing Receptor (CaSR)", "right": "G-protein coupled receptor on parathyroid chief cells tonically inhibiting PTH release when Ca2+ is high" },
        { "left": "Fibroblast Growth Factor 23 (FGF23)", "right": "Bone-derived phosphaturic hormone suppressing renal 1-\u03b1-hydroxylase to defend against hyperphosphatemia" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the kidney proximal tubule, parathyroid hormone inhibits the Na+-phosphate cotransporter to increase urinary phosphate excretion, a physiological process termed ___.",
      "blankAnswer": "phosphaturia",
      "blankDistractors": ["calciuria", "natriuresis", "glucosuria"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Renal & Endocrine Physiology Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Renal & Endocrine Physiology Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Clearance (GFR/RPF), Tubular Diuretics, RAAS & Calcium Homeostasis</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnClr\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Clearance (GFR=120, RPF=600, FF=20%)</button><button id=\"btnDiu\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Diuretics (Loops vs Thiazides)</button><button id=\"btnPth\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. RAAS & PTH Mineral Axis</button></div><div id=\"renLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate renal clearance and filtration fraction...</div><script>document.getElementById('btnClr').onclick=()=>{document.getElementById('renLog').innerHTML='<b>1. RENAL CLEARANCE \\& GLOMERULAR HEMODYNAMICS:</b><br>• GFR (Inulin) = <b style=\"color:#10b981;\">120.0 mL/min</b> | RPF (PAH) = <b style=\"color:#10b981;\">600.0 mL/min</b><br>• Filtration Fraction: FF = GFR / RPF = <b style=\"color:#38bdf8;\">0.200 (20.0%)!</b><br>• RBF = 600 / (1 - 0.40) = <b style=\"color:#10b981;\">1000.0 mL/min!</b>';}; document.getElementById('btnDiu').onclick=()=>{document.getElementById('renLog').innerHTML='<b>2. TUBULAR TRANSPORTERS \\& DIURETICS:</b><br>• Loops (Furosemide): <b style=\"color:#10b981;\">Blocks NKCC2 in TAL &rarr; LOOPS LOSE CALCIUM!</b><br>• Thiazides (HCTZ): <b style=\"color:#38bdf8;\">Blocks NCC in DCT &rarr; THIAZIDES SAVE CALCIUM (Treats Stones)!</b><br>• Spironolactone: Blocks Aldosterone in Collecting Duct (K-sparing)!';}; document.getElementById('btnPth').onclick=()=>{document.getElementById('renLog').innerHTML='<b>3. RAAS \\& PARATHYROID MINERAL AXIS:</b><br>• Angiotensin II: <b style=\"color:#10b981;\">Constricts Efferent Arterioles &rarr; Preserves GFR!</b><br>• PTH: <b style=\"color:#10b981;\">\u2191 Serum Ca2+</b> (Bone + DCT) \\& <b style=\"color:#38bdf8;\">\u2193 Serum PO4 (Phosphaturia)!</b><br>• 1\u00b0 Hyperparathyroidism: \u2191 PTH, \u2191 Ca2+, \u2193 PO4 | CKD: \u2191 PTH, \u2193 Ca2+, \u2191 PO4<br>🏆 <b style=\"color:#10b981;\">Renal_and_Endocrine_Physiology 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
