# Duofy Reusable Lesson Format: Tubular Physiology (Nephron Transport & Diuretics)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Physiology / Renal_and_Endocrine_Physiology`  
**Lesson Format Type:** `nephron_tubular_transport_and_diuretic_mechanisms`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the segmental transport physiology of the nephron, the specialized apical and basolateral carrier proteins of each tubule segment (**Proximal Convoluted Tubule PCT**: $65-70\%$ $Na^+/H_2O$ reabsorption via SGLT2 $Na^+$-glucose cotransporters and NHE3 $Na^+/H^+$ antiporters, target of Acetazolamide and SGLT2 inhibitors; **Thick Ascending Limb of Henle TAL**: $25\%$ $Na^+$ reabsorption via the electroneutral **$\text{NKCC2 } (Na^+\text{-}K^+\text{-}2Cl^-)$** cotransporter and ROMK $K^+$ back-leak establishing the lumen-positive potential driving paracellular $Ca^{2+}/Mg^{2+}$ reabsorption, target of **Loop Diuretics Furosemide**; **Distal Convoluted Tubule DCT**: $5-7\%$ $Na^+$ reabsorption via the **$\text{NCC } (Na^+\text{-}Cl^-)$** cotransporter and PTH-regulated $Ca^{2+}$ reabsorption, target of **Thiazide Diuretics HCTZ**; **Late Distal / Cortical Collecting Duct CD**: Principal cells with **ENaC** channels regulated by **Aldosterone** and $\text{ROMK } K^+$ excretion, target of $K^+$-sparing diuretics Spironolactone/Amiloride; Intercalated cells for acid-base secretion; and **Aquaporin-2 (AQP2)** water channels regulated by **ADH / Vasopressin**) (John E. Hall, Michael E. Hall *Guyton and Hall Textbook of Medical Physiology* 14th ed. Chapters 27 & 28; Linda S. Costanzo *Physiology* 7th ed. Chapter 6): formulate the **Nephron Segment Transport & Diuretic Pharmacology Master Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Nephron Segment} & \textbf{Apical Transporter} & \textbf{Diuretic Drug Class} & \textbf{Fraction of } Na^+ \textbf{ Filtered} & \textbf{Effect on Calcium Handling} \\
\hline
\mathbf{\text{Proximal Tubule (PCT)}} & \mathbf{\text{SGLT2, NHE3, CA}} & \mathbf{\text{Acetazolamide, Dapagliflozin}} & \mathbf{65\% - 70\%} & \text{Isotonic reabsorption with } Na^+ \\
\mathbf{\text{Thick Ascending Limb}} & \mathbf{\text{NKCC2 } (Na^+\text{-}K^+\text{-}2Cl^-)} & \mathbf{\text{Loop Diuretics (Furosemide)}} & \mathbf{25\%} & \mathbf{\text{LOOPS LOSE CALCIUM (Hypercalciuria)}} \\
\mathbf{\text{Distal Tubule (DCT)}} & \mathbf{\text{NCC } (Na^+\text{-}Cl^-)} & \mathbf{\text{Thiazides (HCTZ, Chlorthalidone)}} & \mathbf{5\% - 7\%} & \mathbf{\text{THIAZIDES SAVE CALCIUM (Hypercalcemia)}} \\
\mathbf{\text{Collecting Duct (CD)}} & \mathbf{\text{ENaC Channels}} & \mathbf{K^+\text{-Sparing (Amiloride, Spironolactone)}} & \mathbf{2\% - 3\%} & \mathbf{\text{Inhibits } K^+/H^+ \text{ secretion (Prevents hypokalemia)}} \\
\hline
\end{array}$$
master the **Loop vs Thiazide Calcium Rule**:
$$\mathbf{\text{Loop Diuretics (Furosemide) } \to \mathbf{\text{Abolish Lumen-Positive Potential } \implies \text{Hypocalcemia / Hypercalciuria (Kidney Stones) }}}$$
$$\mathbf{\text{Thiazide Diuretics (HCTZ) } \to \mathbf{\uparrow \text{Basolateral } Na^+/Ca^{2+} \text{ Exchange } \implies \text{Hypercalcemia / Hypocalciuria (Treats Stones)}}}$$
(proving that loop diuretics cause powerful diuresis and calcium wasting, while thiazides produce moderate diuresis with calcium conservation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nephron Segments (PCT $\to$ TAL $\to$ DCT $\to$ CD), Transporters (SGLT2, NKCC2, NCC, ENaC) & Diuretics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Tubular Fluid Osmolality and Solute Reabsorption from Glomerulus to Papilla Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Nephron Transporter / Diuretic Drug Class & Technical Pharmacological Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Potent Class of Diuretic Medications That Inhibit the $Na^+\text{-}K^+\text{-}2Cl^-$ (NKCC2) Cotransporter in the Thick Ascending Limb of Henle to Promote Massive Saluresis Is Known as ___ Diuretics (Loop / Loop Diuretics) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Nephrology Problem: Explaining the Calcium-Sparing Mechanism and Hypokalemic Alkalosis of Thiazides Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Nephron Segmental Transport & Diuretic Mechanisms (Guyton 2021; Costanzo 2022):
   - **Segmental Transporter Formulations:**
     $$\mathbf{\text{PCT: SGLT2 / NHE3} \to \text{TAL: NKCC2 (Loops)} \to \text{DCT: NCC (Thiazides)} \to \text{CD: ENaC (Aldosterone) + AQP2 (ADH)}}$$
   - **The Calcium Handling Dichotomy Invariant:**
     - **Loops Lose Calcium:** Blocks NKCC2 $\implies$ Loss of lumen-positive charge $\implies \downarrow$ paracellular $Ca^{2+}/Mg^{2+}$ reabsorption;
     - **Thiazides Save Calcium:** Blocks NCC $\implies \downarrow$ intracellular $Na^+ \implies \uparrow$ basolateral $3Na^+/Ca^{2+}$ exchanger $\implies \uparrow Ca^{2+}$ reabsorption into blood!
2. **Slide 2 (`ordering`):** Provide 5 steps of tubular fluid processing: (1) PCT reabsorbs 65% of filtered $Na^+$, water, glucose, and amino acids isotonically ($300\text{ mOsm/kg}$), (2) thin descending limb reabsorbs pure water via AQP1 into hypertonic medulla, concentrating fluid to $1200\text{ mOsm/kg}$, (3) thick ascending limb reabsorbs $Na^+, K^+, 2Cl^-$ via NKCC2 while remaining impermeable to water, diluting fluid to $100\text{ mOsm/kg}$, (4) DCT reabsorbs $Na^+$ and $Cl^-$ via NCC under parathyroid hormone regulation of calcium, (5) collecting duct principal cells reabsorb $Na^+$ via ENaC under aldosterone and insert AQP2 water channels under ADH stimulation!
3. **Slide 3 (`matching`):** Pair 4 concepts (NKCC2 Cotransporter, NCC Cotransporter, ENaC Channel, Aquaporin-2 AQP2) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Loop (or Loop Diuretics). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on diuretic pharmacology and calcium handling: A 62-year-old male with recurrent calcium oxalate renal stones (hypercalciuria) and hypertension is prescribed hydrochlorothiazide. How does inhibiting the $Na^+\text{-}Cl^-$ (NCC) cotransporter in the distal convoluted tubule reduce urinary calcium excretion?
   - Thiazides inhibit apical NCC cotransporter in the DCT;
   - Decreases intracellular $Na^+$ in DCT epithelial cells, activating the basolateral $3Na^+/Ca^{2+}$ antiport exchanger;
   - Drives enhanced apical $Ca^{2+}$ reabsorption via TRPV5 channels into blood, **reducing urinary calcium excretion (hypocalciuria)** to prevent stone recurrence;
   - What is the mechanism? (Decreases intracellular $Na^+$, enhancing basolateral $Na^+/Ca^{2+}$ exchange and **promoting $Ca^{2+}$ reabsorption** into blood).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nephron_tubular_transport_and_diuretic_mechanisms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Nephron Tubular Transport \\& Diuretics (Linda S. Costanzo)**\n• **Segmental Nephron Transport Master System:**\n  - **Proximal Tubule (PCT):** Reabsorbs $65-70\\% \\ Na^+, \\text{H}_2\\text{O}, \\text{HCO}_3^-$, and $100\\%$ glucose/amino acids via **SGLT2** and **NHE3** (inhibited by SGLT2i and Acetazolamide);\n  - **Thick Ascending Limb (TAL):** Reabsorbs $25\\% \\ Na^+$ via **$\\text{NKCC2 } (Na^+\\text{-}K^+\\text{-}2Cl^-)$**; ROMK back-leak creates **+10 mV lumen-positive potential** driving paracellular $Ca^{2+}$ and $Mg^{2+}$ uptake;\n  - **Distal Convoluted Tubule (DCT):** Reabsorbs $5-7\\% \\ Na^+$ via **$\\text{NCC } (Na^+\\text{-}Cl^-)$** cotransporter (target of **Thiazides**);\n  - **Collecting Duct (CD):** **ENaC** channels reabsorb $Na^+$ under **Aldosterone**; **Aquaporin-2 (AQP2)** channels reabsorb water under **ADH / Vasopressin**;\n• **The High-Yield Calcium Mnemonic:**\n  - **LOOPS LOSE CALCIUM:** Loop diuretics (Furosemide) abolish lumen-positive charge $\\implies$ **Hypercalciuria / Hypocalcemia**;\n  - **THIAZIDES SAVE CALCIUM:** Thiazides (HCTZ) drop intracellular $Na^+$, driving basolateral $Na^+/Ca^{2+}$ exchange $\\implies$ **Hypocalciuria / Hypercalcemia** (treats recurrent kidney stones)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential tubular segments traversed by glomerular filtrate and trace the progressive changes in luminal osmolality.",
      "orderItems": [
        "Proximal convoluted tubule performs isosmotic reabsorption of 65% of filtered Na+, water, and HCO3- at 300 mOsm/kg",
        "Thin descending limb of Henle reabsorbs water into hypertonic medullary interstitium, concentrating tubular fluid to 1200 mOsm/kg",
        "Thick ascending limb reabsorbs Na+, K+, and 2Cl- via NKCC2 while remaining impermeable to water, diluting fluid to 100 mOsm/kg",
        "Distal convoluted tubule reabsorbs Na+ and Cl- via the NCC cotransporter and regulates transcellular calcium reabsorption",
        "Cortical and medullary collecting ducts insert AQP2 water channels under ADH to concentrate final urine up to 1200 mOsm/kg"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Nephron Transporter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "NKCC2 Cotransporter", "right": "Apical Na+-K+-2Cl- symporter in thick ascending limb inhibited by Loop Diuretics (Furosemide)" },
        { "left": "NCC Cotransporter", "right": "Apical Na+-Cl- symporter in distal convoluted tubule inhibited by Thiazide Diuretics (HCTZ)" },
        { "left": "ENaC Channel", "right": "Epithelial sodium channel in collecting duct principal cells stimulated by Aldosterone (blocked by Amiloride)" },
        { "left": "Aquaporin-2 (AQP2)", "right": "Vasopressin-regulated water channel inserted into apical membrane of collecting duct for water retention" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The potent class of diuretic medications that inhibit the Na+-K+-2Cl- (NKCC2) cotransporter in the thick ascending limb of Henle to promote massive saluresis is known as ___ diuretics.",
      "blankAnswer": "loop",
      "blankDistractors": ["thiazide", "osmotic", "carbonic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 62-year-old patient with recurrent calcium oxalate nephrolithiasis and hypertension is prescribed hydrochlorothiazide. How does inhibiting the apical Na+-Cl- (NCC) cotransporter in the distal convoluted tubule reduce urinary calcium excretion (hypocalciuria)?",
      "options": [
        { "text": "Decreases intracellular Na+ concentration in DCT cells, enhancing basolateral 3Na+/Ca2+ antiport exchange and promoting transcellular Ca2+ reabsorption into blood (Thiazides reduce urinary calcium, preventing recurrent renal stones)", "isCorrect": true, "explanation": "Correct! Let's trace the molecular mechanism of thiazide-induced hypocalciuria (John E. Hall *Guyton and Hall Textbook of Medical Physiology* Chapter 27; Linda S. Costanzo *Physiology* Chapter 6). 1. **Mechanism in the Distal Convoluted Tubule (DCT):** - Hydrochlorothiazide selectively blocks the apical **$Na^+\\text{-}Cl^-$ (NCC) cotransporter** in DCT epithelial cells. - This prevents $Na^+$ entry from the tubular lumen into the cell. 2. **Basolateral Membrane Exchange Activation:** - As intracellular $Na^+$ levels fall, a steep electrochemical gradient for $Na^+$ is established across the basolateral membrane. - This powerfully accelerates the basolateral **$3Na^+/Ca^{2+}$ antiport exchanger (NCX1)**, pumping intracellular $Ca^{2+}$ out into the peritubular blood while importing $Na^+$. 3. **Apical Calcium Entry Stimulation:** - The resulting drop in intracellular $Ca^{2+}$ concentration drives enhanced $Ca^{2+}$ entry through apical **TRPV5 calcium channels** from the tubular lumen. - **Net Outcome:** Renal calcium reabsorption is significantly increased, leading to **decreased urinary calcium excretion (hypocalciuria)**, making thiazides the drug of choice for patients with idiopathic hypercalciuria and recurrent calcium stones! Flawless tubular transport and diuretic pharmacology derivation!" },
        { "text": "Increases the lumen-positive potential in the thick ascending limb, driving paracellular calcium extrusion into urine", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Directly inhibits parathyroid hormone secretion from the parathyroid glands", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Precipitates calcium directly inside the proximal tubule brush border", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
