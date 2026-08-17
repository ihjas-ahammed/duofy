# Duofy Reusable Lesson Format: Metabolic Regulation (PFK-1, FBPase-1, & F-2,6-BP Switch)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Biochemistry_and_Clinical_Genetics / Metabolic_Pathways_and_Inborn_Errors`  
**Lesson Format Type:** `glycolysis_gluconeogenesis_reciprocal_regulation_and_f26bp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the molecular biophysics and hormonal control of hepatic glucose metabolism, the rate-limiting committed step of glycolysis (**Phosphofructokinase-1 PFK-1**: Fructose-6-Phosphate $\to$ Fructose-1,6-Bisphosphate) versus the rate-limiting step of gluconeogenesis (**Fructose-1,6-Bisphosphatase-1 FBPase-1**), the allosteric master regulator **Fructose-2,6-Bisphosphate (F-2,6-BP)**, the covalent regulation of the single bifunctional tandem enzyme **PFK-2 / FBPase-2** by Insulin (dephosphorylation via Protein Phosphatase-1 activating PFK-2 to elevate F-2,6-BP $\implies$ allosteric activation of PFK-1 and inhibition of FBPase-1 accelerating glycolysis) versus Glucagon (cAMP-dependent Protein Kinase A phosphorylation activating FBPase-2 to degrade F-2,6-BP $\implies$ relieving FBPase-1 inhibition and driving hepatic gluconeogenesis), and the prevention of futile substrate cycling (David L. Nelson, Michael M. Cox *Lehninger Principles of Biochemistry* 8th ed. Chapters 14 & 15; Denise R. Ferrier *Lippincott Illustrated Reviews: Biochemistry* 7th ed. Chapter 10): formulate the **Reciprocal Glycolytic-Gluconeogenic Master Switch Formulation**:
$$\mathbf{\text{Fed State (High Insulin/Glucagon Ratio)} \to \text{Dephosphorylates PFK-2} \to \uparrow \mathbf{\text{F-2,6-BP}} \implies \begin{cases} \mathbf{\uparrow \text{PFK-1 Allosteric Activation (Glycolysis } \uparrow)} \\ \mathbf{\downarrow \text{FBPase-1 Allosteric Inhibition (Gluconeogenesis } \downarrow)} \end{cases}}$$
$$\mathbf{\text{Fasted State (High Glucagon/Insulin Ratio)} \to \uparrow \text{PKA} \to \text{Phosphorylates FBPase-2} \to \downarrow \mathbf{\text{F-2,6-BP}} \implies \begin{cases} \mathbf{\downarrow \text{PFK-1 Inactivity (Glycolysis } \downarrow)} \\ \mathbf{\uparrow \text{FBPase-1 Disinhibition (Gluconeogenesis } \uparrow)} \end{cases}}$$
master the **Bifunctional Enzyme Phosphorylation Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Hormonal State} & \textbf{Kinase / Phosphatase Trigger} & \textbf{Covalent Modification} & \textbf{Active Domain} & \textbf{Intracellular [F-2,6-BP]} \\
\hline
\mathbf{\text{Fed State (Insulin)}} & \mathbf{\text{Protein Phosphatase-1 (PP-1)}} & \mathbf{\text{DEPHOSPHORYLATED}} & \mathbf{\text{PFK-2 (Active)}} & \mathbf{\text{HIGH } (\uparrow \text{Glycolysis, } \downarrow \text{Gluconeogenesis})} \\
\mathbf{\text{Fasted State (Glucagon)}} & \mathbf{\text{Protein Kinase A (PKA)}} & \mathbf{\text{PHOSPHORYLATED}} & \mathbf{\text{FBPase-2 (Active)}} & \mathbf{\text{LOW } (\downarrow \text{Glycolysis, } \uparrow \text{Gluconeogenesis})} \\
\hline
\end{array}$$
(proving that F-2,6-BP is not an intermediate in glycolysis or gluconeogenesis, but a dedicated hormonal signal that prevents simultaneous futile operation of both pathways).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PFK-1 vs FBPase-1 Checkpoints, Bifunctional PFK-2/FBPase-2 & F-2,6-BP Allosteric Switch Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Hepatic Metabolic Reprogramming during Fasting Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Metabolic Regulator / Enzyme Domain & Technical Biochemical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Potent Allosteric Metabolite Synthesized by PFK-2 That Simultaneously Activates PFK-1 and Inhibits FBPase-1 Is Fructose-2,6-___ (Bisphosphate / Biphosphate) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Biochemistry Problem: Predicting the Glycolytic and Gluconeogenic Flux in Diabetic Ketoacidosis Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PFK-1, FBPase-1 & F-2,6-BP Reciprocal Regulation (Lehninger 2021; Ferrier 2017):
   - **Enzyme Switch Formulations:**
     $$\mathbf{\text{Insulin} \to \text{Dephosphorylated PFK-2/FBPase-2} \to \text{F-2,6-BP} \uparrow \implies \text{PFK-1} \uparrow \ (\text{Glycolysis})}$$
     $$\mathbf{\text{Glucagon} \to \text{PKA Phosphorylation} \to \text{F-2,6-BP} \downarrow \implies \text{FBPase-1} \uparrow \ (\text{Gluconeogenesis})}$$
   - **The Reciprocal Invariant:**
     - F-2,6-BP is the single most powerful allosteric activator of **PFK-1** (overcomes ATP inhibition);
     - F-2,6-BP is a potent allosteric inhibitor of **FBPase-1**;
     - This guarantees the cell never burns and synthesizes glucose simultaneously in the same compartment!
2. **Slide 2 (`ordering`):** Provide 5 steps of the fasting metabolic transition: (1) dropping blood glucose stimulates pancreatic alpha cells to secrete Glucagon, (2) Glucagon binds $G_s$-coupled receptors on hepatocytes, elevating intracellular cAMP and activating Protein Kinase A (PKA), (3) PKA phosphorylates the bifunctional PFK-2/FBPase-2 enzyme, inactivating the PFK-2 domain and activating the FBPase-2 phosphatase domain, (4) active FBPase-2 hydrolyzes F-2,6-BP to Fructose-6-Phosphate, causing intracellular [F-2,6-BP] to plummet, (5) the drop in F-2,6-BP halts PFK-1 and relieves allosteric inhibition on FBPase-1, accelerating hepatic gluconeogenesis to maintain systemic euglycemia!
3. **Slide 3 (`matching`):** Pair 4 concepts (Fructose-2,6-Bisphosphate, PFK-1, FBPase-1, PFK-2 Domain) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Bisphosphate (or Biphosphate). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on diabetic ketoacidosis metabolic flux: In uncontrolled Type 1 Diabetes Mellitus, an absolute lack of insulin combined with elevated glucagon creates a state of severe cellular starvation. How does this high glucagon/insulin ratio alter the phosphorylation state of the bifunctional PFK-2/FBPase-2 enzyme and the flux through hepatic gluconeogenesis?
   - High glucagon activates PKA $\implies$ **Phosphorylates** the PFK-2/FBPase-2 enzyme;
   - Phosphorylation activates FBPase-2, **decreasing [F-2,6-BP]**;
   - Low F-2,6-BP relieves inhibition on FBPase-1 $\implies$ **Accelerates Gluconeogenesis**, worsening hyperglycemia;
   - What is the molecular state and outcome? (The bifunctional enzyme is **Phosphorylated**, **[F-2,6-BP] decreases**, and **Gluconeogenesis is strongly accelerated**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "glycolysis_gluconeogenesis_reciprocal_regulation_and_f26bp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Glycolysis \\& Gluconeogenesis Reciprocal Regulation (David L. Nelson)**\n• **The Fructose-2,6-Bisphosphate (F-2,6-BP) Allosteric Master Switch:**\n$$\n\\mathbf{\\text{Insulin (Fed State)} \\to \\text{Dephosphorylates PFK-2} \\to \\uparrow \\mathbf{\\text{F-2,6-BP}} \\implies \\begin{cases} \\mathbf{\\uparrow \\text{PFK-1 (Accelerates Glycolysis)}} \\\\ \\mathbf{\\downarrow \\text{FBPase-1 (Inhibits Gluconeogenesis)}} \\end{cases}}\n$$\n$$\n\\mathbf{\\text{Glucagon (Fasted State)} \\to \\uparrow \\text{PKA} \\to \\text{Phosphorylates FBPase-2} \\to \\downarrow \\mathbf{\\text{F-2,6-BP}} \\implies \\begin{cases} \\mathbf{\\downarrow \\text{PFK-1 (Halts Glycolysis)}} \\\\ \\mathbf{\\uparrow \\text{FBPase-1 (Drives Gluconeogenesis)}} \\end{cases}}\n$$\n• **The Bifunctional Enzyme Architecture:**\n  - PFK-2 and FBPase-2 reside on a **single polypeptide chain**;\n  - **Dephosphorylated (Insulin):** PFK-2 active $\\implies$ Synthesizes F-2,6-BP $\\implies$ Drives Glycolysis;\n  - **Phosphorylated (Glucagon/PKA):** FBPase-2 active $\\implies$ Degrades F-2,6-BP $\\implies$ Drives Gluconeogenesis;\n• **The Anti-Futile Cycle Invariant:** F-2,6-BP prevents simultaneous futile operation of PFK-1 and FBPase-1, ensuring the liver acts as a **glucose consumer in the fed state** and a **glucose producer in the fasting state**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular steps of hepatic metabolic reprogramming from fasting glucagon release to gluconeogenic glucose production.",
      "orderItems": [
        "Fasting hypoglycemia stimulates pancreatic alpha cells to release Glucagon into the portal circulation",
        "Glucagon binds hepatic Gs-coupled receptors, elevating intracellular cAMP and activating Protein Kinase A (PKA)",
        "PKA phosphorylates the single bifunctional PFK-2/FBPase-2 enzyme, activating its FBPase-2 phosphatase domain",
        "Active FBPase-2 degrades Fructose-2,6-Bisphosphate, causing intracellular [F-2,6-BP] levels to plummet",
        "The depletion of F-2,6-BP shuts down PFK-1 and relieves allosteric inhibition on FBPase-1, driving active gluconeogenesis"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Metabolic Regulator to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Fructose-2,6-Bisphosphate", "right": "Potent allosteric regulator activating PFK-1 and inhibiting FBPase-1 whose levels drop during fasting" },
        { "left": "PFK-1", "right": "Rate-limiting committed enzyme of glycolysis converting Fructose-6-P to Fructose-1,6-bisphosphate" },
        { "left": "FBPase-1", "right": "Rate-limiting gluconeogenic enzyme converting Fructose-1,6-bisP to Fructose-6-P disinhibited in fasting" },
        { "left": "Protein Kinase A (PKA)", "right": "Glucagon-activated kinase that phosphorylates the bifunctional enzyme to activate the FBPase-2 domain" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The potent allosteric metabolite synthesized by PFK-2 that simultaneously activates PFK-1 and inhibits FBPase-1 is fructose-2,6-___.",
      "blankAnswer": "bisphosphate",
      "blankDistractors": ["monophosphate", "triphosphate", "pyrophosphate"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a patient with untreated Type 1 Diabetes Mellitus presenting in Diabetic Ketoacidosis (DKA), an absolute insulin deficiency creates an extremely high glucagon/insulin ratio. How does this hormonal imbalance alter the phosphorylation state of the bifunctional PFK-2/FBPase-2 enzyme and the rate of hepatic gluconeogenesis?",
      "options": [
        { "text": "The bifunctional enzyme is phosphorylated by PKA, [F-2,6-BP] drops, and gluconeogenesis is strongly accelerated (High glucagon drives PKA phosphorylation, degrading F-2,6-BP to disinhibit FBPase-1)", "isCorrect": true, "explanation": "Correct! Let's trace the molecular regulation of hepatic gluconeogenesis in Diabetic Ketoacidosis (David L. Nelson *Lehninger Principles of Biochemistry* Chapter 15; Denise R. Ferrier *Lippincott Illustrated Reviews: Biochemistry* Chapter 10). 1. **Hormonal Environment in DKA:** - The absolute absence of insulin combined with counter-regulatory hormone release (high Glucagon, Epinephrine, Cortisol) creates a massive surge in hepatic **cyclic AMP (cAMP)**. 2. **Enzymatic Phosphorylation Switch:** - cAMP activates **Protein Kinase A (PKA)**. - PKA phosphorylates a specific serine residue on the single tandem **PFK-2 / FBPase-2 bifunctional enzyme**. 3. **Consequences on [F-2,6-BP]:** - Phosphorylation inactivates the PFK-2 kinase domain and simultaneously activates the **FBPase-2 phosphatase domain**. - Active FBPase-2 rapidly hydrolyzes Fructose-2,6-Bisphosphate into Fructose-6-Phosphate, causing **[F-2,6-BP] levels to collapse**. 4. **Effect on Metabolic Flux:** - Loss of F-2,6-BP abolishes allosteric stimulation of **PFK-1** (halting glycolysis). - Crucially, the absence of F-2,6-BP **relieves the allosteric inhibition on FBPase-1** (the rate-limiting step of gluconeogenesis). - Uninhibited FBPase-1 drives maximal hepatic **gluconeogenesis**, pouring massive amounts of newly synthesized glucose into the blood and exacerbating life-threatening hyperglycemia! Flawless metabolic regulation and F-2,6-BP switch derivation!" },
        { "text": "The bifunctional enzyme is dephosphorylated, [F-2,6-BP] rises, and glycolysis is strongly accelerated", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "PFK-1 is directly mutated, causing complete glycogen depletion without affecting gluconeogenesis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FBPase-1 is irreversibly inhibited, causing severe fasting hypoglycemia", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
