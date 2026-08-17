# Duofy Reusable Lesson Format: Coagulation & Bleeding (PT, aPTT, & vWD)

**Target Topic:** `05_Medicine_and_Health_Sciences / 02_Para_Clinical_Sciences / Pathology_and_Hematology / Hematology_Blood_Disorders_and_Anemias`  
**Lesson Format Type:** `hemostasis_and_coagulation_disorders_pt_aptt_and_vwd`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the physiology and clinical differential of Primary vs Secondary Hemostasis, the molecular mechanisms of the **Platelet Plug** (Adhesion: subendothelial collagen binds von Willebrand Factor [vWF] $\to$ binds platelet **Glycoprotein Ib [GpIb]**; Activation: release of $\text{ADP}$ and Thromboxane $A_2$; Aggregation: **Fibrinogen** cross-links platelets via activated **Glycoprotein IIb/IIIa [GpIIb/IIIa]**), the differential diagnosis of platelet disorders (**Immune Thrombocytopenic Purpura ITP** with anti-GpIIb/IIIa antibodies vs **Thrombotic Thrombocytopenic Purpura TTP** caused by autoantibodies inhibiting the **ADAMTS13** vWF-cleaving metalloprotease leading to ultra-large vWF multimers, microangiopathic hemolytic anemia with schistocytes, thrombocytopenia, fever, renal failure, and neurological deficits), the **Secondary Hemostasis Coagulation Cascade** (Extrinsic Pathway: **Prothrombin Time [PT / INR]** measuring Factor VII and Tissue Factor, monitored in Warfarin therapy; Intrinsic Pathway: **Activated Partial Thromboplastin Time [aPTT]** measuring Factors XII, XI, IX, VIII, monitored in unfractionated Heparin therapy; Common Pathway: Factors X, V, II [Prothrombin], I [Fibrinogen]), and the bleeding disorder differential: **Hemophilia A** (X-linked Factor VIII deficiency $\to \mathbf{\uparrow \text{aPTT}}$, normal PT, normal Bleeding Time, deep hemarthroses), **Hemophilia B / Christmas Disease** (X-linked Factor IX deficiency $\to \mathbf{\uparrow \text{aPTT}}$), **von Willebrand Disease (vWD)** (autosomal dominant vWF deficiency $\to \mathbf{\uparrow \text{Bleeding Time}}$, $\mathbf{\uparrow \text{aPTT}}$ due to loss of Factor VIII carrier protection, normal PT, mucocutaneous epistaxis/menorrhagia), and **Disseminated Intravascular Coagulation (DIC)** ($\uparrow \text{PT}$, $\uparrow \text{aPTT}$, $\downarrow$ Platelets, $\downarrow$ Fibrinogen, $\mathbf{\uparrow\uparrow \text{D-Dimer}}$) (Vinay Kumar, Abul K. Abbas, Jon C. Aster *Robbins and Cotran Pathologic Basis of Disease* 10th ed. Chapter 14; Barbara J. Bain *Dacie and Lewis Practical Haematology* 12th ed.): formulate the **Coagulation & Bleeding Disorders Laboratory Differential Master Matrix**:
$$\begin{array}{|l|c|c|c|c|l|}
\hline
\textbf{Bleeding Condition} & \textbf{Platelet Count} & \textbf{Bleeding Time} & \textbf{PT / INR} & \textbf{aPTT} & \textbf{Pathophysiologic Defect} \\
\hline
\mathbf{\text{Hemophilia A}} & \text{Normal} & \text{Normal} & \text{Normal} & \mathbf{\uparrow\uparrow \text{PROLONGED}} & \mathbf{\text{Factor VIII Deficiency (X-Linked Recessive)}} \\
\mathbf{\text{Hemophilia B}} & \text{Normal} & \text{Normal} & \text{Normal} & \mathbf{\uparrow\uparrow \text{PROLONGED}} & \mathbf{\text{Factor IX Deficiency (X-Linked Recessive)}} \\
\mathbf{\text{von Willebrand (vWD)}} & \text{Normal} & \mathbf{\uparrow\uparrow \text{PROLONGED}} & \text{Normal} & \mathbf{\uparrow \text{PROLONGED / Normal}} & \mathbf{\text{Defective Platelet Adhesion (vWF) } + \text{ Low FVIII}} \\
\mathbf{\text{Immune Thrombocytopenia (ITP)}} & \mathbf{\downarrow\downarrow \text{LOW}} & \mathbf{\uparrow \text{PROLONGED}} & \text{Normal} & \text{Normal} & \mathbf{\text{Anti-GpIIb/IIIa Antibodies (Splenic clearance)}} \\
\mathbf{\text{DIC}} & \mathbf{\downarrow\downarrow \text{LOW}} & \mathbf{\uparrow \text{PROLONGED}} & \mathbf{\uparrow \text{PROLONGED}} & \mathbf{\uparrow \text{PROLONGED}} & \mathbf{\text{Widespread clotting } \to \text{ Consumptive coagulopathy}} \\
\hline
\end{array}$$
master the **Extrinsic vs Intrinsic Pathway Monitoring Formula**:
$$\mathbf{\text{Extrinsic (PT / INR): Measures Factor VII } \implies \mathbf{\text{Monitors WARFARIN (Blocks Vit K Epoxide Reductase)}}}$$
$$\mathbf{\text{Intrinsic (aPTT): Measures Factors XII, XI, IX, VIII } \implies \mathbf{\text{Monitors UNFRACTIONATED HEPARIN (Activates AT-III)}}}$$
(proving that von Willebrand disease uniquely bridges primary and secondary hemostasis because vWF is both the essential glue for platelet GpIb adhesion and the circulating carrier protein protecting Factor VIII from rapid degradation), and interact with live Microcytic iron studies solver, Macrocytic B12 vs folate metabolite tracer, Hemolytic smear/osmotic fragility simulator, and Hemostasis coagulation cascade widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Primary (GpIb/GpIIb-IIIa) vs Secondary (PT vs aPTT) Hemostasis & Hemophilia vs vWD Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Primary Platelet Plug Formation to Fibrin Mesh Crosslinking Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Coagulation Factor / Platelet Glycoprotein & Technical Hemostatic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Thrombotic Thrombocytopenic Purpura (TTP), Deficiency of the Metalloprotease Enzyme ___ Prevents the Cleavage of Ultra-Large vWF Multimers, Triggering Microvascular Thrombosis and Schistocyte Hemolysis (ADAMTS13) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Hematology & Blood Pathology Studio: Iron Studies, Megaloblastic Markers, Hemolysis & Coagulation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hemostasis_and_coagulation_disorders_pt_aptt_and_vwd",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do PT and aPTT differ in pathway testing, and why does von Willebrand disease cause both prolonged bleeding time and prolonged aPTT?",
      "blankAnswer": "Hemostasis \\& Coagulation (Kumar 2021; Bain 2017): (1) COAGULATION PATHWAYS: - PT/INR (Extrinsic): Tests Factor VII and tissue factor; monitors Warfarin (Vitamin K antagonist). - aPTT (Intrinsic): Tests Factors XII, XI, IX, VIII; monitors Unfractionated Heparin (Antithrombin III activator). (2) HEMOPHILIA A vs B: - Hemophilia A (Factor VIII defect, X-linked) & Hemophilia B (Factor IX defect, X-linked) cause deep hemarthroses and isolated PROLONGED aPTT with normal bleeding time and normal PT! (3) VON WILLEBRAND DISEASE (vWD): - Autosomal dominant vWF deficiency causes mucosal bleeding. - Prolongs Bleeding Time because platelets cannot adhere via Glycoprotein Ib (GpIb). - Prolongs aPTT because vWF is the obligate carrier protein that protects Factor VIII from rapid proteolysis!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Primary and Secondary Hemostasis from initial vascular endothelial injury to stable crosslinked fibrin clot.",
      "orderItems": [
        "Endothelial damage exposes subendothelial collagen and releases stored von Willebrand Factor (vWF)",
        "Platelets adhere to collagen-bound vWF via their surface Glycoprotein Ib (GpIb) receptors",
        "Platelets undergo shape change and degranulation, releasing ADP and Thromboxane A2 to recruit additional platelets",
        "Fibrinogen binds to activated Glycoprotein IIb/IIIa (GpIIb/IIIa) receptors to crosslink aggregating platelets (Primary Hemostasis)",
        "Tissue factor initiates the coagulation cascade, generating Thrombin (Factor IIa) to cleave fibrinogen into a crosslinked Fibrin Mesh"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hemostatic Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Glycoprotein Ib (GpIb)", "right": "Platelet surface receptor binding von Willebrand Factor to mediate initial platelet adhesion to collagen" },
        { "left": "Glycoprotein IIb/IIIa", "right": "Integrin receptor cross-linked by fibrinogen during platelet aggregation; targeted by autoantibodies in ITP" },
        { "left": "ADAMTS13 Metalloprotease", "right": "Enzyme cleaving ultra-large vWF multimers; autoantibody deficiency causes microthrombi in TTP" },
        { "left": "Factor VIII (FVIII)", "right": "Cofactor in intrinsic tenase complex stabilized by circulating vWF; deficient in Hemophilia A" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In thrombotic thrombocytopenic purpura (TTP), deficiency of the metalloprotease enzyme ___ prevents the cleavage of ultra-large vWF multimers, triggering microvascular thrombosis and schistocyte hemolysis.",
      "blankAnswer": "ADAMTS13",
      "blankDistractors": ["thrombin", "plasmin", "antithrombin"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hematology & Blood Pathology Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Hematology & Blood Pathology Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Iron Studies, Megaloblastic Markers, Hemolysis & Coagulation</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnIrn\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Iron Studies (IDA vs ACD)</button><button id=\"btnB12\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. B12 vs Folate (MMA / SCD)</button><button id=\"btnCoa\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Hemolysis & Coagulation (PT/aPTT)</button></div><div id=\"hemLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate microcytic anemia iron studies...</div><script>document.getElementById('btnIrn').onclick=()=>{document.getElementById('hemLog').innerHTML='<b>1. MICROCYTIC ANEMIAS (MCV &lt; 80 fL):</b><br>• Iron Deficiency (IDA): \u2193 Iron, <b style=\"color:#10b981;\">\u2191\u2191 TIBC, \u2193\u2193 Ferritin (&lt; 15 ng/mL)!</b><br>• Anemia of Chronic Disease: \u2193 Iron, <b style=\"color:#38bdf8;\">\u2193 TIBC, \u2191 Ferritin (Hepcidin traps iron)!</b><br>• Thalassemia: Normal Ferritin/RDW | Sideroblastic: \u2191 Iron, \u2191 Ferritin';}; document.getElementById('btnB12').onclick=()=>{document.getElementById('hemLog').innerHTML='<b>2. MACROCYTIC MEGALOBLASTIC ANEMIAS (MCV &gt; 100 fL):</b><br>• Folate (B9) Deficiency: <b style=\"color:#10b981;\">\u2191 Homocysteine + NORMAL Methylmalonic Acid (MMA)!</b><br>• Cobalamin (B12) Deficiency: <b style=\"color:#38bdf8;\">\u2191 Homocysteine + \u2191\u2191 MMA &rarr; Subacute Combined Degeneration (SCD)!</b>';}; document.getElementById('btnCoa').onclick=()=>{document.getElementById('hemLog').innerHTML='<b>3. HEMOLYSIS \\& COAGULATION (PT vs aPTT):</b><br>• G6PD: \u2193 NADPH &rarr; <b style=\"color:#10b981;\">Heinz Bodies &rarr; Splenic Bite Cells!</b><br>• Sickle Cell: \u03b26 Glu&rarr;Val | Spherocytosis: Ankyrin defect (\u2191 MCHC)<br>• Coagulation: PT (Factor VII / Warfarin) | aPTT (Factors XII, XI, IX, VIII / Heparin)<br>• vWD: <b style=\"color:#38bdf8;\">\u2191 Bleeding Time (GpIb defect) + \u2191 aPTT (FVIII carrier)!</b><br>🏆 <b style=\"color:#10b981;\">Hematology_Blood_Disorders_and_Anemias 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
