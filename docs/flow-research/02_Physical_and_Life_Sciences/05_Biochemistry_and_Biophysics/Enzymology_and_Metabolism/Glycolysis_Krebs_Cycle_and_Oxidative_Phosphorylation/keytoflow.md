# Key to Flow: Glycolysis, Krebs Cycle, and Oxidative Phosphorylation (Bioenergetics)

**Subject Area:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Enzymology_and_Metabolism / Glycolysis_Krebs_Cycle_and_Oxidative_Phosphorylation`

---

## 📌 Core Concept & Mental Model
**Substrate-Level Glycolysis, Multi-Enzyme Pyruvate Dehydrogenase, the Citric Acid Hub, and Chemiosmotic ATP Synthesis** govern cellular aerobic and anaerobic energy transduction from glucose to ATP (Hans Krebs 1953 Nobel, Peter Mitchell 1978 Nobel, Paul Boyer & John Walker 1997 Nobel):
* **The Glycolytic Pathway (Embden-Meyerhof-Parnas):**
  - **Investment Phase (Costs $2\text{ ATP}$):**
    - Hexokinase/Glucokinase: $\text{Glucose} + \text{ATP} \to \text{Glucose-6-P}$.
    - **Phosphofructokinase-1 (PFK-1 - The Committed Step):** $\text{Fructose-6-P} + \text{ATP} \to \text{Fructose-1,6-BP}$.
      - **Allosteric Activators:** **Fructose-2,6-bisphosphate (F-2,6-BP)** (most potent, synthesized by PFK-2 in response to insulin), AMP, ADP.
      - **Allosteric Inhibitors:** ATP, Citrate, $\text{H}^+$ (acidosis).
    - Aldolase: Cleaves $\text{F-1,6-BP} \to \text{DHAP} + \text{GAP}$ (Triose Phosphate Isomerase equilibrates).
  - **Payoff Phase (Yields $4\text{ ATP} + 2\text{ NADH}$):**
    - GAPDH: $\text{GAP} + \text{NAD}^+ + \text{P}_i \to \mathbf{\text{1,3-BPG}} + \text{NADH}$.
    - Phosphoglycerate Kinase: $\text{1,3-BPG} + \text{ADP} \to \text{3-PG} + \mathbf{\text{ATP}}$ (Substrate-Level Phosphorylation).
    - Pyruvate Kinase: $\text{PEP} + \text{ADP} \to \text{Pyruvate} + \mathbf{\text{ATP}}$ (Feed-forward activation by F-1,6-BP).
  - **Net Balance:** $\mathbf{1\text{ Glucose} + 2\text{ NAD}^+ + 2\text{ ADP} + 2\text{ P}_i \longrightarrow 2\text{ Pyruvate} + 2\text{ NADH} + 2\text{ ATP} + 2\text{ H}_2\text{O}}$.
* **Pyruvate Dehydrogenase (PDH) Multi-Enzyme Complex:**
  - Converts $\text{Pyruvate} + \text{CoA} + \text{NAD}^+ \to \mathbf{\text{Acetyl-CoA}} + \text{CO}_2 + \mathbf{\text{NADH}}$.
  - **3 Catalytic Subunits & 5 Essential Cofactors ("TLC For Nancy"):**
    1. **E1 (Pyruvate Dehydrogenase):** Uses **Thiamine Pyrophosphate (TPP)** to decarboxylate pyruvate.
    2. **E2 (Dihydrolipoyl Transacetylase):** Uses swinging **Lipoamide (Lipoic Acid)** arm and **Coenzyme A (CoA)** to form Acetyl-CoA.
    3. **E3 (Dihydrolipoyl Dehydrogenase):** Uses **FAD** and **NAD$^+$** to re-oxidize reduced dihydrolipoamide.
* **The Citric Acid (Krebs / TCA) Cycle (Hans Krebs, 1953 Nobel):**
  - **The 8 Reactions:** $\text{Oxaloacetate (4C)} + \text{Acetyl-CoA (2C)} \xrightarrow{\text{Citrate Synthase}} \text{Citrate (6C)} \to \text{Isocitrate} \xrightarrow{\text{IDH}} \alpha\text{-Ketoglutarate (5C)} + \text{NADH} + \text{CO}_2 \xrightarrow{\alpha\text{-KGDH}} \text{Succinyl-CoA (4C)} + \text{NADH} + \text{CO}_2 \xrightarrow{\text{Succinyl-CoA Synthetase}} \text{Succinate} + \mathbf{\text{GTP/ATP}} \xrightarrow{\text{Succinate Dehydrogenase / Complex II}} \text{Fumarate} + \mathbf{\text{FADH}_2} \xrightarrow{\text{Fumarase}} \text{Malate} \xrightarrow{\text{MDH}} \text{Oxaloacetate} + \mathbf{\text{NADH}}$.
  - **Yield per Acetyl-CoA:** $\mathbf{3\text{ NADH} + 1\text{ FADH}_2 + 1\text{ GTP/ATP} + 2\text{ CO}_2}$.
* **Oxidative Phosphorylation & Chemiosmosis (Mitchell 1978; Boyer 1997 Nobel):**
  - **The Mitochondrial Electron Transport Chain (ETC):**
    - **Complex I (NADH Dehydrogenase):** Translocates $\mathbf{4\text{H}^+}$ into intermembrane space.
    - **Complex II (Succinate Dehydrogenase):** Zero protons pumped; transfers electrons from $\text{FADH}_2 \to \text{Ubiquinone (Q)}$.
    - **Complex III (Cytochrome $bc_1$ / Q-Cycle):** Converts 2-electron carrier $QH_2$ to 1-electron Cytochrome $c$; translocates $\mathbf{4\text{H}^+}$.
    - **Complex IV (Cytochrome $c$ Oxidase):** Reduces $\text{O}_2 \to 2\text{H}_2\text{O}$; translocates $\mathbf{2\text{H}^+}$.
  - **Proton Motive Force ($\Delta p = \Delta \Psi - 59\Delta \text{pH}$):** $\approx 10\text{H}^+$ pumped per NADH; $\approx 6\text{H}^+$ per $\text{FADH}_2$.
  - **$F_0F_1$ ATP Synthase Rotary Motor (Paul Boyer's Binding Change Mechanism):**
    - Proton flow through $F_0$ drives rotation of the central $\gamma$ axle.
    - As $\gamma$ rotates $360^\circ$, each of the $3\ \beta$ catalytic subunits cycles through **Open (O: releases ATP) $\to$ Loose (L: binds ADP+$\text{P}_i$) $\to$ Tight (T: catalyzes ATP synthesis)**, synthesizing **$3\text{ ATP}$ per full revolution**!
  - **P/O Ratios:** $\mathbf{\approx 2.5\text{ ATP per NADH}}$ and $\mathbf{\approx 1.5\text{ ATP per FADH}_2} \implies \mathbf{\approx 30-32\text{ ATP per Glucose}}$.
  - **Inhibitors vs Uncouplers:**
    - **ETC Inhibitors:** Rotenone (Complex I), Antimycin A (Complex III), Cyanide / CO / Azide (Complex IV). Block both electron flow and ATP synthesis.
    - **Chemical Uncouplers (2,4-DNP, Thermogenin UCP1):** Dissipate proton gradient without blocking ETC $\implies$ Electron flow runs rampant, generating pure heat!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Carbon Accounting & Proton Battery Map
* Track carbons: Glucose ($6\text{C}$) $\to 2\times$ Pyruvate ($3\text{C}$) $\to 2\times$ Acetyl-CoA ($2\text{C}$) $\to 4\times \text{CO}_2$.
* Proton stoichiometry: Complex I ($4\text{H}^+$) $+$ Complex III ($4\text{H}^+$) $+$ Complex IV ($2\text{H}^+$) $= 10\text{H}^+/\text{NADH}$.

### 2. Top Recommended Resources
* **The Masterwork:** *Lehninger Principles of Biochemistry* (Nelson & Cox).
* **Bioenergetics Classic:** *Bioenergetics 4* by David G. Nicholls & Stuart J. Ferguson (Academic Press).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace all 10 steps of glycolysis and identify the two substrate-level phosphorylation reactions?
- [ ] Can you explain the allosteric activation of PFK-1 by Fructose-2,6-bisphosphate?
- [ ] Can you list the 5 cofactors of the Pyruvate Dehydrogenase complex and assign each to its catalytic subunit (E1, E2, E3)?
- [ ] Can you calculate the ATP yield of complete glucose oxidation and explain the effect of 2,4-dinitrophenol (DNP)?
