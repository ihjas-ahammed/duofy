# Key to Flow: Lipid and Amino Acid Metabolism (Metabolic Biochemistry)

**Subject Area:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Enzymology_and_Metabolism / Lipid_and_Amino_Acid_Metabolism`

---

## 📌 Core Concept & Mental Model
**Fatty Acid Degradation vs Synthesis, Ketone Body Bioenergetics, Transamination, the Urea Cycle, and Amino Acid Inborn Errors** govern macromolecular energy storage, nitrogen disposal, and metabolic homeostasis (Franz Knoop 1904, Hans Krebs & Kurt Henseleit 1932, Feodor Lynen 1964 Nobel):
* **Fatty Acid $\beta$-Oxidation (Mitochondrial Matrix):**
  - **Activation & The Carnitine Shuttle:** Fatty acids are activated to Acyl-CoA in cytoplasm. **Carnitine Palmitoyltransferase-I (CPT-I / CAT-1)** on outer mitochondrial membrane replaces CoA with carnitine $\implies$ Shuttles acyl-carnitine across inner membrane via CACT.
    - **Cross-Regulation (No Futile Cycles!):** **CPT-I is potently inhibited by Malonyl-CoA** (the first product of fatty acid synthesis), preventing newly synthesized fats from being immediately degraded!
  - **The 4-Step $\beta$-Oxidation Spiral:**
    1. **Oxidation:** Acyl-CoA Dehydrogenase $\to$ introduces trans-$\Delta^2$ double bond $\implies$ Generates $\mathbf{\text{FADH}_2}$. (MCAD deficiency causes fasting hypoketotic hypoglycemia!).
    2. **Hydration:** Enoyl-CoA Hydratase $\to$ adds $\text{H}_2\text{O}$ across double bond $\implies$ L-$\beta$-Hydroxyacyl-CoA.
    3. **Oxidation:** $\beta$-Hydroxyacyl-CoA Dehydrogenase $\to$ oxidizes $\beta$-OH to carbonyl $\implies$ Generates $\mathbf{\text{NADH}}$.
    4. **Thiolysis:** $\beta$-Ketothiolase $\to$ CoA-SH cleaves $2\text{C}$ fragment $\implies$ Releases $\mathbf{\text{Acetyl-CoA}} + \text{Acyl-CoA}_{(n-2)}$.
  - **Palmitate ($16\text{C}$) Energy Balance:** $7\text{ cycles} \to 8\text{ Acetyl-CoA} + 7\text{ FADH}_2 + 7\text{ NADH} \implies \mathbf{106\text{ Net ATP}}$ (after subtracting $2\text{ ATP}$ equivalents for activation).
* **De Novo Fatty Acid Synthesis / Lipogenesis (Cytoplasm):**
  - **Citrate Shuttle:** Excess mitochondrial Citrate is exported via tricarboxylate transporter $\to$ **ATP-Citrate Lyase** cleaves $\text{Citrate} + \text{CoA} + \text{ATP} \to \mathbf{\text{Acetyl-CoA}} + \text{Oxaloacetate}$.
  - **Acetyl-CoA Carboxylase (ACC - The Committed Pacemaker):**
    - Converts $\text{Acetyl-CoA} + \text{HCO}_3^- + \text{ATP} \xrightarrow{\text{Biotin}} \mathbf{\text{Malonyl-CoA}} + \text{ADP} + \text{P}_i$.
    - **Activated by:** Insulin (protein phosphatase 2A dephosphorylation) and Citrate (allosteric polymerization).
    - **Inhibited by:** Glucagon/Epinephrine (PKA phosphorylation), AMPK (low energy signal), and Palmitoyl-CoA (product feedback).
  - **Fatty Acid Synthase (FAS Multi-Enzyme Complex):**
    - Anchors growing chain to **Acyl Carrier Protein (ACP)** via its flexible $4'$-phosphopantetheine arm.
    - 4 repeating steps per 2C addition: **Condensation $\to$ Reduction (consumes NADPH) $\to$ Dehydration $\to$ Reduction (consumes NADPH)** until Palmitate ($16\text{C}$) is cleaved by Thioesterase (TE).
* **Ketogenesis & Ketone Body Utilization:**
  - **Hepatic Ketogenesis (Fasting / DKA):** Liver mitochondrial matrix converts excess Acetyl-CoA into **Acetoacetate, $\beta$-Hydroxybutyrate, and Acetone**.
    - Rate-limiting enzyme: **Mitochondrial HMG-CoA Synthase**.
  - **Peripheral Ketone Utilization (Brain, Heart, Muscle):**
    - $\beta$-Hydroxybutyrate is oxidized to Acetoacetate $\to$ converted to Acetoacetyl-CoA by **$\beta$-ketoacyl-CoA transferase (Thiophorase / SCOT)**.
    - **Crucial Rule:** The liver **lacks Thiophorase**, preventing the liver from consuming the ketones it synthesizes for other organs!
* **Amino Acid Catabolism & The Urea Cycle (Krebs & Henseleit 1932):**
  - **Transamination:** **Aminotransferases (AST/ALT)** transfer $\alpha$-amino groups to $\alpha$-Ketoglutarate to form **Glutamate**, utilizing **Pyridoxal Phosphate (PLP / Vitamin B6)**.
  - **Oxidative Deamination:** **Glutamate Dehydrogenase (GDH)** in mitochondrial matrix releases toxic $\text{NH}_4^+$.
  - **The 5-Step Urea Cycle (Mitochondria $\to$ Cytosol):**
    1. **CPS-I (Carbamoyl Phosphate Synthetase I - Rate Limiting):** $\text{NH}_4^+ + \text{HCO}_3^- + 2\text{ ATP} \to \mathbf{\text{Carbamoyl Phosphate}}$ (obligatorily activated by **N-Acetylglutamate [NAG]**).
    2. **OTC (Ornithine Transcarbamylase):** $\text{Carbamoyl-P} + \text{Ornithine} \to \mathbf{\text{Citrulline}}$ (exported to cytosol). *(OTC deficiency is X-linked; causes severe hyperammonemia with elevated urinary orotic acid)*.
    3. **Argininosuccinate Synthetase:** $\text{Citrulline} + \text{Aspartate} + \text{ATP} \to \text{Argininosuccinate}$.
    4. **Argininosuccinase (Lyase):** Cleaves $\text{Argininosuccinate} \to \text{Arginine} + \mathbf{\text{Fumarate}}$ (connects to Krebs cycle via "Krebs Bicycle").
    5. **Arginase:** Cleaves $\text{Arginine} + \text{H}_2\text{O} \to \mathbf{\text{Urea}} + \text{Ornithine}$ (Ornithine recycled back to mitochondria).
* **Inborn Errors of Amino Acid Metabolism:**
  - **PKU (Phenylketonuria):** Deficiency in **Phenylalanine Hydroxylase (PAH)** or cofactor **$\text{BH}_4$ (Tetrahydrobiopterin)** $\implies$ Phenylalanine accumulates $\to$ musty odor, severe intellectual disability if untreated; Tyrosine becomes an essential amino acid.
  - **MSUD (Maple Syrup Urine Disease):** Deficiency in **Branched-Chain $\alpha$-Keto Acid Dehydrogenase (BCKDH)** $\implies$ Leucine, Isoleucine, Valine accumulation; sweet maple syrup urine odor.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Cellular Compartment Matrix & Nitrogen Balance Map
* $\beta$-Oxidation = Mitochondria. Fatty Acid Synthesis = Cytosol.
* Urea Cycle: Step 1-2 in Mitochondria $\to$ Steps 3-5 in Cytosol.

### 2. Top Recommended Resources
* **The Masterwork:** *Lehninger Principles of Biochemistry* (Nelson & Cox, Macmillan).
* **Medical Biochemistry:** *Marks' Basic Medical Biochemistry* by Michael Lieberman & Alisa Peet (LWW).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace the 4 repeating steps of $\beta$-oxidation and calculate net ATP for Palmitate ($16\text{C}$)?
- [ ] Can you explain how Malonyl-CoA prevents a futile cycle by inhibiting CPT-I?
- [ ] Can you map the 5 steps of the Urea cycle and differentiate CPS-I vs OTC deficiency?
- [ ] Can you explain the molecular basis of Phenylketonuria (PKU) and why Tyrosine becomes essential?
