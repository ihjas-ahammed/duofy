# Duofy Reusable Lesson Format: Medical Genetics (Glycogen Storage Diseases I, II, V)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Biochemistry_and_Clinical_Genetics / Metabolic_Pathways_and_Inborn_Errors`  
**Lesson Format Type:** `glycogen_storage_diseases_von_gierke_pompe_mcardle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the enzymatic defects, tissue-specific pathologies, and clinical differentials of the **Glycogen Storage Diseases (GSDs)**, the central role of glycogen in hepatic glucose buffering and skeletal muscle anaerobic ATP generation, **Von Gierke Disease (GSD Type I)** caused by Glucose-6-Phosphatase deficiency in the ER lumen of hepatocytes and renal cortex (severe fasting hypoglycemia, profound lactic acidosis due to pyruvate accumulation, hyperuricemia / gout, hyperlipidemia, and massive doll-like face hepatomegaly; unresponsive to glucagon/epinephrine), **Pompe Disease (GSD Type II)** caused by Lysosomal Acid $\alpha$-1,4-Glucosidase (Acid Maltase) deficiency (accumulation of glycogen in lysosomal vacuoles leading to fatal infantile hypertrophic cardiomyopathy, hypotonia, and macroglossia: *"Pompe trashes the Pump [Heart]"*), **Cori Disease (GSD Type III)** caused by Debranching enzyme ($\alpha$-1,6-glucosidase) deficiency (accumulation of limit dextrin, intact gluconeogenesis, normal blood lactate), and **McArdle Disease (GSD Type V)** caused by Skeletal Muscle Glycogen Phosphorylase (myophosphorylase) deficiency (painful exercise-induced cramps, myoglobinuria / rhabdomyolysis, second-wind phenomenon, flat blood lactate curve during ischemic forearm exercise) (David L. Nelson, Michael M. Cox *Lehninger Principles of Biochemistry* 8th ed. Chapter 15; Denise R. Ferrier *Lippincott Illustrated Reviews: Biochemistry* 7th ed. Chapter 11): formulate the **Glycogen Storage Diseases Differential Diagnostic Master Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{GSD Type / Eponym} & \textbf{Deficient Enzyme} & \textbf{Primary Organ Involved} & \textbf{Hallmark Clinical Presentation} & \textbf{Blood Lactate / Uric Acid} \\
\hline
\mathbf{\text{Type I: Von Gierke}} & \mathbf{\text{Glucose-6-Phosphatase}} & \mathbf{\text{Liver \& Kidneys}} & \mathbf{\text{Severe fasting hypoglycemia, Hepatomegaly, Doll face}} & \mathbf{\uparrow\uparrow \text{Lactate, } \uparrow\uparrow \text{Uric Acid (Gout)}} \\
\mathbf{\text{Type II: Pompe}} & \mathbf{\text{Lysosomal Acid Maltase}} & \mathbf{\text{Heart, Skeletal Muscle, Liver}} & \mathbf{\text{Massive Cardiomegaly, Hypertrophic CM, Hypotonia}} & \text{Normal (Lysosomal storage)} \\
\mathbf{\text{Type III: Cori}} & \mathbf{\text{Debranching Enzyme}} & \text{Liver \& Muscle} & \text{Milder hypoglycemia, Accumulation of Limit Dextrin} & \mathbf{\text{NORMAL Lactate (Gluconeogenesis intact)}} \\
\mathbf{\text{Type V: McArdle}} & \mathbf{\text{Muscle Glycogen Phosphorylase}} & \mathbf{\text{Skeletal Muscle Only}} & \mathbf{\text{Exercise cramps, Myoglobinuria, Second-wind}} & \mathbf{\text{NO LACTATE RISE on Forearm Test}} \\
\hline
\end{array}$$
(proving that Glucose-6-Phosphatase is shared by both glycogenolysis and gluconeogenesis, explaining why Von Gierke disease causes catastrophic fasting hypoglycemia, whereas Cori disease spares gluconeogenesis, leaving blood lactate normal).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GSD Types I (Von Gierke), II (Pompe), III (Cori) & V (McArdle) Enzymatic & Clinical Differential Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Differentiate Hepatic from Myopathic GSDs on Ischemic Forearm Testing Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Glycogen Storage Disease Type / Enzyme Defect & Technical Clinical Pathophysiology Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Fatal Infantile Glycogen Storage Disease (Type II) Characterized by Massive Cardiomegaly, Hypotonia, and Glycogen Vacuoles in Lysosomes Caused by Acid Maltase Deficiency Is ___ Disease (Pompe / Pompe Disease) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Genetics & Pediatrics Problem: Diagnosing Von Gierke Disease from Fasting Lactic Acidosis and Hepatomegaly Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Glycogen Storage Diseases Classification (Lehninger 2021; Ferrier 2017):
   - **Enzyme Defect Formulations:**
     $$\mathbf{\text{Type I (Von Gierke): Glucose-6-Phosphatase Defect} \implies \text{Blocks BOTH Glycogenolysis \& Gluconeogenesis}}$$
     $$\mathbf{\text{Type II (Pompe): Lysosomal Acid Maltase Defect} \implies \text{Cardiomegaly / Pompe Trashes the Pump}}$$
     $$\mathbf{\text{Type V (McArdle): Muscle Glycogen Phosphorylase Defect} \implies \text{Exercise Cramps / Myoglobinuria}}$$
   - **The Lactate Differential Invariant:**
     - **Von Gierke (Type I):** High blood lactate (excess Glucose-6-P shunted to glycolysis $\to$ pyruvate $\to$ lactic acidosis);
     - **Cori (Type III):** Normal blood lactate (gluconeogenic pathway is fully functional)!
2. **Slide 2 (`ordering`):** Provide 5 steps of diagnosing a patient with glycogen storage disease: (1) infant presents with severe lethargy and tremors after a 3-4 hour fasting interval, (2) laboratory testing reveals profound hypoglycemia accompanied by elevated blood lactate, hyperuricemia, and hyperlipidemia, (3) physical exam reveals marked hepatomegaly with a doll-like facial appearance and normal heart size, (4) administration of intramuscular glucagon fails to increase blood glucose but further worsens lactic acidosis, (5) genetic sequencing confirms a pathogenic mutation in the G6PC gene encoding Glucose-6-Phosphatase (Von Gierke Disease GSD Type Ia)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Von Gierke Disease, Pompe Disease, McArdle Disease, Cori Disease) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pompe (or Pompe Disease). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Von Gierke disease: A 4-month-old infant presents with lethargy, irritability, and seizures when feedings are delayed. Physical examination reveals massive hepatomegaly and chubby "doll-like" cheeks. Laboratory analysis shows severe fasting hypoglycemia ($22\text{ mg/dL}$), severe lactic acidosis ($8.5\text{ mmol/L}$), hypertriglyceridemia, and hyperuricemia. Glucagon challenge test fails to increase blood glucose. What is the deficient enzyme and diagnosis?
   - Severe fasting hypoglycemia + Lactic acidosis + Hepatomegaly + Gout $\implies$ **Von Gierke Disease (GSD Type I)**;
   - Deficient enzyme: **Glucose-6-Phosphatase**;
   - What is the diagnosis and enzyme? (**Von Gierke Disease (Type I)** caused by **Glucose-6-Phosphatase** deficiency).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "glycogen_storage_diseases_von_gierke_pompe_mcardle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Glycogen Storage Diseases (GSDs) (Denise R. Ferrier)**\n• **Major Glycogen Storage Diseases Master Classification:**\n$$\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{GSD Type / Eponym} & \\textbf{Deficient Enzyme} & \\textbf{Primary Organ Involved} & \\textbf{Hallmark Clinical Findings} \\\\\n\\hline\n\\mathbf{\\text{Type I: Von Gierke}} & \\mathbf{\\text{Glucose-6-Phosphatase}} & \\mathbf{\\text{Liver \\& Kidney ER}} & \\mathbf{\\text{Severe Fasting Hypoglycemia, Lactic Acidosis, Gout, Doll-face}} \\\\\n\\mathbf{\\text{Type II: Pompe}} & \\mathbf{\\text{Lysosomal Acid Maltase}} & \\mathbf{\\text{Heart \\& Skeletal Muscle}} & \\mathbf{\\text{Cardiomegaly, Hypertrophic CM, Early Death ('Pompe trashes Pump')}} \\\\\n\\mathbf{\\text{Type III: Cori}} & \\mathbf{\\text{Debranching (}\\alpha\\text{-1,6) Enzyme}} & \\text{Liver \\& Muscle} & \\mathbf{\\text{Milder hypoglycemia, NORMAL Lactate, Limit Dextrin accumulation}} \\\\\n\\mathbf{\\text{Type V: McArdle}} & \\mathbf{\\text{Muscle Glycogen Phosphorylase}} & \\mathbf{\\text{Skeletal Muscle}} & \\mathbf{\\text{Exercise cramps, Myoglobinuria, Flat forearm lactate curve}} \\\\\n\\hline\n\\end{array}$$\n• **The Glucose-6-Phosphatase Metabolic Bottleneck Invariant:** Because **Glucose-6-Phosphatase is required for BOTH glycogenolysis and gluconeogenesis**, its deficiency in Von Gierke disease prevents the liver from releasing ANY free glucose into the blood during fasting, driving massive shunting of G6P into lactic acid, triglycerides, and uric acid!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential diagnostic and biochemical findings that establish a diagnosis of Von Gierke Disease (GSD Type I).",
      "orderItems": [
        "Infant develops profound hypoglycemia, tremors, and seizures within 2 to 4 hours of fasting",
        "Physical exam demonstrates marked hepatomegaly with liver enlargement but normal cardiac size",
        "Laboratory blood tests reveal severe lactic acidosis, hyperlipidemia, and elevated uric acid (gout)",
        "Administration of an intramuscular glucagon or epinephrine challenge fails to raise blood glucose and worsens lactate",
        "Molecular genetic testing identifies a loss-of-function mutation in the G6PC gene encoding Glucose-6-Phosphatase"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Glycogen Storage Disease to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Von Gierke (Type I)", "right": "Glucose-6-Phosphatase defect blocking both glycogenolysis and gluconeogenesis causing lactic acidosis and gout" },
        { "left": "Pompe (Type II)", "right": "Lysosomal acid alpha-1,4-glucosidase defect leading to glycogen vacuoles in myocardium and fatal cardiomegaly" },
        { "left": "McArdle (Type V)", "right": "Muscle myophosphorylase deficiency causing painful exertional cramps, rhabdomyolysis, and zero lactate rise" },
        { "left": "Cori (Type III)", "right": "Debranching enzyme deficiency accumulating limit dextrins with intact gluconeogenesis and normal blood lactate" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fatal infantile glycogen storage disease (Type II) characterized by massive cardiomegaly, hypotonia, and glycogen vacuoles in lysosomes caused by acid maltase deficiency is ___ disease.",
      "blankAnswer": "Pompe",
      "blankDistractors": ["Gaucher", "Fabry", "Tay-Sachs"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 4-month-old infant presents with severe fasting hypoglycemia (blood glucose 22 mg/dL), metabolic lactic acidosis (blood lactate 8.5 mmol/L), hyperuricemia, and prominent hepatomegaly with a doll-like facial appearance. A glucagon administration test fails to increase blood glucose. What is the diagnosis and deficient enzyme?",
      "options": [
        { "text": "Von Gierke Disease (GSD Type I) caused by Glucose-6-Phosphatase deficiency (Blocks both glycogenolysis and gluconeogenesis, producing severe fasting hypoglycemia with lactic acidosis)", "isCorrect": true, "explanation": "Correct! Let's analyze the biochemical and clinical features of Von Gierke Disease (David L. Nelson *Lehninger Principles of Biochemistry* Chapter 15; Denise R. Ferrier *Lippincott Illustrated Reviews: Biochemistry* Chapter 11). 1. **Biochemical Mechanism:** - **Glucose-6-Phosphatase** is an enzyme located in the endoplasmic reticulum membrane of hepatocytes and renal proximal tubule cells. - It catalyzes the final dephosphorylation of **Glucose-6-Phosphate to free Glucose**, which is the obligate terminal step for BOTH hepatic **glycogenolysis** and **gluconeogenesis**. 2. **Derivation of Hallmark Symptoms:** - **Severe Fasting Hypoglycemia:** The liver cannot release free glucose into the systemic circulation during even short fasting intervals. - **Profound Lactic Acidosis:** Trapped Glucose-6-Phosphate cannot exit the cell and is shunted down the glycolytic pathway into pyruvate, which is converted into massive amounts of **Lactate**. - **Hepatomegaly:** Trapped Glucose-6-P stimulates glycogen synthesis and lipogenesis, causing massive glycogen and lipid accumulation in the liver. - **Hyperuricemia (Gout):** Elevated lactic acid competitively inhibits renal uric acid clearance, while increased G6P drives the HMP shunt to overproduce purines! Flawless Glycogen Storage Disease differential derivation!" },
        { "text": "Pompe Disease (GSD Type II) caused by Lysosomal Acid Maltase deficiency (Pompe presents with massive cardiomegaly without hypoglycemia)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "McArdle Disease (GSD Type V) caused by Muscle Glycogen Phosphorylase deficiency (McArdle affects muscle only)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cori Disease (GSD Type III) caused by Debranching enzyme deficiency (Cori has normal lactate)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
