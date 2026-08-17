# Duofy Reusable Lesson Format: Fatty Acid Beta-Oxidation and the Carnitine Shuttle

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Enzymology_and_Metabolism / Lipid_and_Amino_Acid_Metabolism`  
**Lesson Format Type:** `fatty_acid_beta_oxidation_and_carnitine_shuttle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the activation, mitochondrial translocation, and 4-step cyclic degradation of long-chain fatty acids (Franz Knoop 1904; Feodor Lynen & Eugene Kennedy 1952): analyze the **Carnitine Shuttle (CPT-I, CACT, CPT-II)** importing acyl-CoAs across the inner mitochondrial membrane, master the **allosteric cross-regulation by Malonyl-CoA** (the committed intermediate of fatty acid synthesis potently inhibiting CPT-I to prevent futile cycles), trace the 4 repeating enzymatic reactions of the $\beta$-oxidation spiral (**1. Oxidation via Acyl-CoA Dehydrogenase yielding $\text{FADH}_2$**, **2. Hydration via Enoyl-CoA Hydratase**, **3. Oxidation via $\beta$-Hydroxyacyl-CoA Dehydrogenase yielding $\text{NADH}$**, and **4. Thiolytic Cleavage via $\beta$-Ketothiolase releasing $\text{Acetyl-CoA}$**), calculate the complete thermodynamic ATP yield for Palmitate ($16\text{C} \to 106\text{ Net ATP}$), and evaluate **Medium-Chain Acyl-CoA Dehydrogenase (MCAD) Deficiency**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Carnitine Shuttle & Beta-Oxidation Spiral Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fatty Acyl-CoA Transport & 4-Step Spiral Reaction Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beta-Oxidation Enzyme / Carrier & Catalytic Output Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Physiological Allosteric Inhibitor of Carnitine Palmitoyltransferase-I Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Medium-Chain Acyl-CoA Dehydrogenase MCAD Deficiency Fasting Hypoglycemia Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fatty Acid Activation & The $\beta$-Oxidation Spiral (1904/1952):
   - **Activation & The Carnitine Shuttle:**
     - Cytosol: $\text{Fatty Acid} + \text{CoA} + \text{ATP} \xrightarrow{\text{Acyl-CoA Synthetase}} \mathbf{\text{Fatty Acyl-CoA}} + \text{AMP} + \text{PP}_i$ (costs $2\text{ ATP}$ equivalents).
     - Outer Membrane: **Carnitine Palmitoyltransferase-I (CPT-I / CAT-1)** transfers acyl group onto carnitine $\implies \mathbf{\text{Acyl-Carnitine}}$.
     - **Allosteric Brake:** **CPT-I is potently inhibited by Malonyl-CoA** (blocks fatty acid oxidation during de novo lipogenesis!).
     - Translocation: Carnitine-Acylcarnitine Translocase (CACT) antiporter $\to$ **CPT-II** on inner membrane regenerates Acyl-CoA inside the mitochondrial matrix.
   - **The 4-Step $\beta$-Oxidation Spiral:**
     $$\begin{array}{|c|l|l|l|}
     \hline
     \textbf{Step} & \textbf{Enzyme} & \textbf{Chemical Reaction} & \textbf{High-Energy Product} \\
     \hline
     \mathbf{1} & \textbf{Acyl-CoA Dehydrogenase} & \text{Alkane } \to \text{ trans-}\Delta^2\text{-Enoyl-CoA} & \mathbf{1\text{ FADH}_2} \ (1.5\text{ ATP}) \\
     \mathbf{2} & \textbf{Enoyl-CoA Hydratase} & \text{Hydration } \to \text{ L-}\beta\text{-Hydroxyacyl-CoA} & \text{None} \\
     \mathbf{3} & \mathbf{\beta\text{-Hydroxyacyl-CoA Dehydrogenase}} & \text{Oxidation } \to \beta\text{-Ketoacyl-CoA} & \mathbf{1\text{ NADH}} \ (2.5\text{ ATP}) \\
     \mathbf{4} & \mathbf{\beta\text{-Ketothiolase}} & \text{Thiolysis with CoA-SH} & \mathbf{1\text{ Acetyl-CoA}} \ (10\text{ ATP}) \\
     \hline
     \end{array}$$
   - **Palmitate ($16\text{C}$) Yield:** $7\text{ cycles} \to 8\text{ Acetyl-CoA} (80\text{ ATP}) + 7\text{ FADH}_2 (10.5) + 7\text{ NADH} (17.5) = 108\text{ ATP} - 2\text{ ATP (activation)} = \mathbf{106\text{ Net ATP}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of fatty acid activation and beta-oxidation: (1) cytoplasmic acyl-CoA synthetase condenses palmitate with Coenzyme A, consuming 2 high-energy phosphate equivalents to form palmitoyl-CoA, (2) CPT-I on the outer mitochondrial membrane converts palmitoyl-CoA into palmitoyl-carnitine, allowing translocation into the matrix via CACT, (3) CPT-II on the inner membrane reconverts the molecule back into matrix palmitoyl-CoA and free carnitine, (4) acyl-CoA dehydrogenase oxidizes the alpha-beta single bond into a trans-double bond, generating the first FADH2, (5) enoyl-CoA hydratase, beta-hydroxyacyl-CoA dehydrogenase (yielding NADH), and beta-ketothiolase cleave off Acetyl-CoA, shortening the chain by 2 carbons!
3. **Slide 3 (`matching`):** Pair 4 beta-oxidation components (CPT-I / CAT-1, Acyl-CoA Dehydrogenase, Beta-Hydroxyacyl-CoA Dehydrogenase, Beta-Ketothiolase) with their catalytic actions and products.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the allosteric inhibitor of CPT-I that prevents futile cycles during lipogenesis is malonyl-CoA. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the pathophysiology of Medium-Chain Acyl-CoA Dehydrogenase (MCAD) deficiency: A 2-year-old child presents with lethargy, vomiting, severe non-ketotic hypoglycemia, and dicarboxylic aciduria following a 14-hour fasting episode during a mild viral illness. Why does an inability to oxidize medium-chain fatty acids cause hypoketotic hypoglycemia? (Without functional MCAD, **mitochondria cannot perform $\beta$-oxidation on 6- to 12-carbon fatty acids during fasting**, failing to generate the Acetyl-CoA and NADH/ATP needed to drive both hepatic **Ketogenesis (causing non-ketosis)** and **Gluconeogenesis (causing severe hypoglycemia)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fatty_acid_beta_oxidation_and_carnitine_shuttle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fatty Acid Beta-Oxidation & Carnitine Shuttle (1904/1952)**\n• **The Carnitine Translocation Shuttle:**\n  - **Activation:** $\\text{Fatty Acid} + \\text{CoA} + \\text{ATP} \\to \\text{Acyl-CoA} + \\text{AMP} + \\text{PP}_i$ (costs $2\\text{ ATP}$). \n  - **CPT-I / CAT-1:** Forms Acyl-Carnitine on outer membrane $\\implies$ **Potently inhibited by Malonyl-CoA** (prevents futile cycles during fat synthesis!).\n  - **CACT + CPT-II:** Shuttles and regenerates matrix Acyl-CoA.\n• **The 4-Step $\\beta$-Oxidation Spiral:**\n$$\n\\text{Acyl-CoA} \\xrightarrow{\\mathbf{\\text{Oxidation (FADH}_2\\text{)}}} \\text{Enoyl-CoA} \\xrightarrow{\\mathbf{\\text{Hydration}}} \\beta\\text{-OH-Acyl-CoA} \\xrightarrow{\\mathbf{\\text{Oxidation (NADH)}}} \\beta\\text{-Ketoacyl-CoA} \\xrightarrow{\\mathbf{\\text{Thiolysis}}} \\mathbf{\\text{Acetyl-CoA}}\n$$\n• **Palmitate ($16\\text{C}$) Thermodynamic Balance Sheet:**\n$$\n7\\text{ Cycles } \\implies 8\\text{ Acetyl-CoA } (80) + 7\\text{ FADH}_2 (10.5) + 7\\text{ NADH } (17.5) - 2\\text{ (Activation)} = \\mathbf{106\\text{ Net ATP}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of fatty acid transport into mitochondria and initial round of beta-oxidation.",
      "orderItems": [
        "Fatty acyl-CoA synthetase activates cytoplasmic free fatty acid to fatty acyl-CoA, consuming 2 ATP equivalents",
        "Carnitine Palmitoyltransferase-I (CPT-I) on the outer mitochondrial membrane attaches carnitine to form fatty acyl-carnitine",
        "Carnitine-Acylcarnitine Translocase (CACT) and CPT-II transport and regenerate fatty acyl-CoA in the mitochondrial matrix",
        "Acyl-CoA Dehydrogenase oxidizes the alpha-beta single bond into a trans-delta-2 double bond, reducing FAD to FADH2",
        "Enoyl-CoA hydratase, beta-hydroxyacyl-CoA dehydrogenase (yielding NADH), and beta-ketothiolase cleave off Acetyl-CoA"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each beta-oxidation pathway component to its specific biochemical function.",
      "matchPairs": [
        { "left": "Carnitine Palmitoyltransferase-I (CPT-I)", "right": "Rate-limiting mitochondrial outer membrane transporter that is allosterically inhibited by Malonyl-CoA" },
        { "left": "Acyl-CoA Dehydrogenase", "right": "First enzyme of the beta-oxidation spiral that introduces a trans-double bond and reduces FAD to FADH2" },
        { "left": "Beta-Hydroxyacyl-CoA Dehydrogenase", "right": "Third enzyme of the spiral that oxidizes the beta-hydroxyl group to a ketone while reducing NAD+ to NADH" },
        { "left": "Beta-Ketothiolase", "right": "Fourth enzyme of the spiral that uses Coenzyme A to cleave off a terminal 2-carbon Acetyl-CoA unit" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The committed 3-carbon intermediate of fatty acid synthesis that allosterically inhibits CPT-I to prevent futile fatty acid oxidation is ___-CoA.",
      "blankAnswer": "malonyl",
      "blankDistractors": ["acetyl", "succinyl", "propionyl"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does an infant with an inherited deficiency in Medium-Chain Acyl-CoA Dehydrogenase (MCAD) develop severe fasting hypoketotic hypoglycemia and lethargy during periods of fasting or illness?",
      "options": [
        { "text": "Inability to oxidize medium-chain (C6-C12) fatty acids halts mitochondrial beta-oxidation during fasting, failing to generate the Acetyl-CoA and ATP/NADH needed to fuel both hepatic Ketogenesis (causing zero ketone production) and hepatic Gluconeogenesis (causing profound hypoglycemia)", "isCorrect": true, "explanation": "Correct! During fasting, tissues switch from glucose to fatty acid beta-oxidation as their primary fuel. In the liver, beta-oxidation produces vast quantities of Acetyl-CoA (which allosterically activates Pyruvate Carboxylase to drive gluconeogenesis and provides substrate for ketogenesis) and NADH/ATP (which fuels the energetic cost of gluconeogenesis). In MCAD deficiency (the most common inborn error of beta-oxidation), fatty acid breakdown stalls after the chain is trimmed down to 6-12 carbons. The liver runs out of Acetyl-CoA and ATP. Consequently, gluconeogenesis fails (causing profound hypoglycemia), and ketogenesis fails completely because no excess Acetyl-CoA is available (causing 'hypoketotic' or non-ketotic hypoglycemia), starving the brain of both glucose and ketone bodies." },
        { "text": "Because MCAD is required for insulin breakdown in the pancreas", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because medium-chain fatty acids turn into pure toxic cyanide", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because MCAD is the primary enzyme of glycolysis", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
