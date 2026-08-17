# Duofy Reusable Lesson Format: Glycolytic Pathway and Allosteric PFK-1 Regulation

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Enzymology_and_Metabolism / Glycolysis_Krebs_Cycle_and_Oxidative_Phosphorylation`  
**Lesson Format Type:** `glycolytic_pathway_and_allosteric_pfk1_regulation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 10 enzymatic reactions, bioenergetic stoichiometry, and master allosteric checkpoints of the Embden-Meyerhof-Parnas glycolytic pathway: contrast the **Preparatory Investment Phase** (consuming $2\text{ ATP}$ to phosphorylate and cleave hexose into two trioses) with the **Payoff Phase** (generating $4\text{ ATP}$ via **Substrate-Level Phosphorylation [Phosphoglycerate Kinase & Pyruvate Kinase]** and $2\text{ NADH}$ via GAPDH), master the committed pacemaker step catalyzed by **Phosphofructokinase-1 (PFK-1)**, analyze its potent allosteric activator **Fructose-2,6-bisphosphate (F-2,6-BP)** regulated by the bifunctional **PFK-2 / FBPase-2** enzyme under insulin/glucagon reciprocal control, and calculate net thermodynamic yields.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Glycolytic Pathway Architecture & PFK-1 Regulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Preparatory to Payoff Glycolysis Intermediate Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Glycolytic Enzyme & Catalytic Action / Regulatory Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Most Potent Allosteric Activator of PFK-1 Chemical Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | PFK-2/FBPase-2 Bifunctional Enzyme Glucagon vs Insulin Reciprocal Switch Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Glycolytic Pathway & Allosteric PFK-1 Control:
   - **The Overall Reaction:**
     $$\mathbf{\text{Glucose} + 2\text{ NAD}^+ + 2\text{ ADP} + 2\text{ P}_i \longrightarrow 2\text{ Pyruvate} + 2\text{ NADH} + 2\text{ ATP} + 2\text{ H}_2\text{O} + 2\text{H}^+}$$
   - **The 3 Irreversible Thermodynamically Regulated Steps:**
     1. **Hexokinase / Glucokinase ($\Delta G'^\circ = -16.7\text{ kJ/mol}$):** Phosphorylates glucose to trap it inside the cell as Glucose-6-P.
     2. **Phosphofructokinase-1 (PFK-1 - The Committed Pacemaker, $\Delta G'^\circ = -14.2\text{ kJ/mol}$):**
        - Catalyzes: $\text{Fructose-6-P} + \text{ATP} \to \text{Fructose-1,6-bisphosphate} + \text{ADP}$.
        - **Allosteric Activators:** **Fructose-2,6-bisphosphate (F-2,6-BP)** (overcomes ATP inhibition), AMP, ADP.
        - **Allosteric Inhibitors:** High ATP (binds low-affinity allosteric site), Citrate, $\text{H}^+$ ions.
     3. **Pyruvate Kinase ($\Delta G'^\circ = -31.4\text{ kJ/mol}$):** Substrate-level phosphorylation of PEP $\to$ Pyruvate (activated by F-1,6-BP feed-forward).
   - **PFK-2 / FBPase-2 Bifunctional Switch:**
     - **Fed State (Insulin):** Dephosphorylated $\to$ PFK-2 active $\to \uparrow \text{F-2,6-BP} \implies$ **Stimulates Glycolysis**.
     - **Fasting State (Glucagon $\to$ PKA):** Phosphorylated $\to$ FBPase-2 active $\to \downarrow \text{F-2,6-BP} \implies$ **Halts Glycolysis, drives Gluconeogenesis**.
2. **Slide 2 (`ordering`):** Provide 5 steps tracing the metabolic transformation of glucose through glycolysis: (1) hexokinase phosphorylates glucose into glucose-6-phosphate consuming 1 ATP, (2) phosphohexose isomerase converts glucose-6-phosphate into fructose-6-phosphate, (3) PFK-1 phosphorylates fructose-6-phosphate into fructose-1,6-bisphosphate consuming a 2nd ATP (committed step), (4) aldolase cleaves the hexose into glyceraldehyde-3-phosphate (GAP) and dihydroxyacetone phosphate (DHAP), which is converted to GAP by triose phosphate isomerase, (5) the payoff phase oxidizes 2 GAP into 1,3-BPG and converts them via substrate-level phosphorylations into 2 pyruvate, yielding 4 ATP and 2 NADH!
3. **Slide 3 (`matching`):** Pair 4 glycolytic enzymes (Hexokinase, PFK-1, GAPDH, Pyruvate Kinase) with their specific biochemical actions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the most potent physiological allosteric activator of PFK-1 is fructose-2,6-bisphosphate. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the hormonal regulation of the bifunctional enzyme PFK-2/FBPase-2 in the liver: During prolonged fasting, how does high circulating glucagon via Protein Kinase A (PKA) turn off hepatic glycolysis to preserve blood glucose for the brain? (Glucagon activates PKA, which **phosphorylates the bifunctional enzyme, activating the FBPase-2 domain while inactivating the PFK-2 domain**; this degrades Fructose-2,6-bisphosphate, releasing the allosteric activation of PFK-1 and shutting down glycolysis).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "glycolytic_pathway_and_allosteric_pfk1_regulation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Glycolysis & Allosteric PFK-1 Regulation**\n• **Net Glycolytic Equation:**\n$$\n\\mathbf{\\text{Glucose} + 2\\text{ NAD}^+ + 2\\text{ ADP} + 2\\text{ P}_i \\longrightarrow 2\\text{ Pyruvate} + 2\\text{ NADH} + 2\\text{ ATP}}\n$$\n• **PFK-1: The Committed Pacemaker Step:**\n  - Reaction: $\\text{Fructose-6-P} + \\text{ATP} \\xrightarrow{\\text{PFK-1}} \\text{Fructose-1,6-BP} + \\text{ADP}$.\n  - **Potent Allosteric Activator:** **Fructose-2,6-bisphosphate (F-2,6-BP)** (relieves ATP inhibition).\n  - **Allosteric Inhibitors:** High ATP, Citrate, Acidic $\\text{H}^+$.\n• **The Bifunctional PFK-2 / FBPase-2 Master Switch:**\n  - **Insulin (Fed):** Dephosphorylated $\\implies$ PFK-2 ON $\\implies \\uparrow \\text{F-2,6-BP} \\implies$ **Glycolysis Active**.\n  - **Glucagon / PKA (Fasting):** Phosphorylated $\\implies$ FBPase-2 ON $\\implies \\downarrow \\text{F-2,6-BP} \\implies$ **Glycolysis OFF** (Gluconeogenesis ON)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential metabolic intermediates of the glycolytic pathway from glucose to pyruvate.",
      "orderItems": [
        "Hexokinase phosphorylates free glucose to form intracellular Glucose-6-Phosphate (costs 1 ATP)",
        "Phosphoglucose isomerase isomerizes Glucose-6-Phosphate into Fructose-6-Phosphate",
        "PFK-1 phosphorylates Fructose-6-Phosphate to generate Fructose-1,6-Bisphosphate (costs 1 ATP; committed step)",
        "Aldolase and Triose Phosphate Isomerase cleave and convert the hexose into two Glyceraldehyde-3-Phosphate (GAP) molecules",
        "The payoff phase oxidizes both GAP into 1,3-BPG, yielding 2 NADH and 4 ATP via substrate-level phosphorylation to form Pyruvate"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each glycolytic enzyme to its precise biochemical function.",
      "matchPairs": [
        { "left": "Phosphofructokinase-1 (PFK-1)", "right": "Catalyzes the committed, rate-limiting phosphorylation of Fructose-6-P to Fructose-1,6-BP" },
        { "left": "Glyceraldehyde-3-Phosphate Dehydrogenase (GAPDH)", "right": "Oxidizes and phosphorylates GAP to produce high-energy 1,3-Bisphosphoglycerate and NADH" },
        { "left": "Phosphoglycerate Kinase", "right": "Executes first substrate-level phosphorylation, transferring phosphate from 1,3-BPG to ADP to make ATP" },
        { "left": "Pyruvate Kinase", "right": "Catalyzes irreversible transfer of high-energy phosphate from phosphoenolpyruvate (PEP) to ADP" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The most potent physiological allosteric activator of phosphofructokinase-1 (PFK-1) in human hepatocytes is fructose-2,6-___.",
      "blankAnswer": "bisphosphate",
      "blankDistractors": ["monophosphate", "triphosphate", "kinase"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a fasting state, how does elevated circulating glucagon turn off glycolysis in the liver to conserve glucose for the central nervous system?",
      "options": [
        { "text": "Glucagon binds GPCRs to elevate cAMP and activate Protein Kinase A (PKA), which phosphorylates the bifunctional enzyme PFK-2/FBPase-2; this activates the FBPase-2 phosphatase domain, depleting Fructose-2,6-bisphosphate and relieving the allosteric activation of PFK-1, completely halting glycolysis", "isCorrect": true, "explanation": "Correct! In the liver, glucose metabolism is coordinated by the single polypeptide bifunctional enzyme containing two opposing catalytic domains: PFK-2 (kinase) and FBPase-2 (phosphatase). During fasting, glucagon signals through G_alpha_s to activate Adenylyl Cyclase -> cAMP -> PKA. PKA directly phosphorylates a single serine residue on the bifunctional enzyme. Phosphorylation simultaneously inhibits the PFK-2 domain and stimulates the FBPase-2 domain. FBPase-2 hydrolyzes Fructose-2,6-bisphosphate into Fructose-6-phosphate. In the absence of F-2,6-BP, PFK-1 is potently inhibited by physiological ATP, immediately halting glycolytic flux and allowing the liver to direct carbons into gluconeogenesis to maintain blood glucose levels." },
        { "text": "Glucagon destroys all glucose molecules inside the liver", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Glucagon converts PFK-1 directly into insulin", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Glucagon removes all mitochondria from hepatocytes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
