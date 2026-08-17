# Key to Flow: Reaction Mechanisms (SN1, SN2, Addition, Elimination) (Organic Chemistry)

**Subject Area:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Reaction_Mechanisms_SN1_SN2_Addition_Elimination`

---

## 📌 Core Concept & Mental Model
**Polar Organic Reaction Mechanisms** operate through fundamental electron-pushing curved-arrow pathways governed by substrate sterics, electronic stabilization, nucleophile/base strength, and orbital overlap:
* **Nucleophilic Aliphatic Substitution ($\text{S}_{\text{N}}1$ vs $\text{S}_{\text{N}}2$):**
  - **$\text{S}_{\text{N}}2$ (Substitution Nucleophilic Bimolecular, Concerted):**
    - **Rate Law:** $\text{Rate} = k [\text{Substrate}][\text{Nu}^-]$ (Single transition state).
    - **Stereochemistry:** **Walden Inversion** ($100\%$ backside attack into $\sigma_{\text{C}-\text{LG}}^*$ LUMO).
    - **Substrate Hierarchy:** $\text{Methyl} > 1^\circ > 2^\circ \gg 3^\circ$ (sterically unreactive).
    - **Solvent Preference:** Polar Aprotic (DMSO, DMF, Acetone, MeCN) to leave nucleophile unencumbered.
  - **$\text{S}_{\text{N}}1$ (Substitution Nucleophilic Unimolecular, Stepwise):**
    - **Rate Law:** $\text{Rate} = k [\text{Substrate}]$ (Rate-determining loss of leaving group to form planar carbocation).
    - **Stereochemistry:** **Racemization** (equal front/back attack; slight inversion excess from intimate ion pairs).
    - **Substrate Hierarchy:** $3^\circ > 2^\circ \gg 1^\circ / \text{Methyl}$ (stabilized by hyperconjugation and resonance).
    - **Solvent Preference:** Polar Protic ($\text{H}_2\text{O}, \text{MeOH}, \text{EtOH}$) to stabilize leaving group anion and carbocation.
* **Elimination Pathways ($\text{E}1, \text{E}2, \text{E}1\text{cb}$):**
  - **$\text{E}2$ (Bimolecular Concerted):** Requires strict **Anti-Periplanar Geometry** ($\text{H}-\text{C}_\beta-\text{C}_\alpha-\text{LG}$ dihedral angle $= 180^\circ$). In cyclohexanes, both $\text{H}$ and $\text{LG}$ must be *diaxial*!
    - **Zaitsev's Rule (Small Base, e.g. $\text{NaOMe}, \text{NaOEt}$):** More substituted, thermodynamically stable alkene.
    - **Hofmann's Rule (Bulky Base, e.g. $t\text{-BuOK}$, $\text{LDA}$ or quaternary ammonium):** Less substituted, kinetically accessible alkene.
  - **$\text{E}1$ (Unimolecular Stepwise):** Carbocation intermediate, competes with $\text{S}_{\text{N}}1$ at elevated temperatures.
  - **$\text{E}1\text{cb}$ (Conjugate Base Elimination):** Carbanion intermediate; occurs with acidic $\beta$-H and poor leaving groups ($-\text{F}, -\text{OH}$ in aldol condensations).
* **Electrophilic Addition to Alkenes & Stereospecificity:**
  - **Markovnikov's Rule:** Electrophile ($\text{H}^+$) adds to form the more stable carbocation ($\text{H}-\text{X}$ addition).
  - **Anti-Addition via Halonium Ions ($\text{Br}_2 / \text{Cl}_2$):** Cyclic 3-membered bromonium ion intermediate undergoes backside nucleophilic ring opening to yield *anti*-1,2-dihalide.
  - **Syn-Addition:** Catalytic hydrogenation ($\text{H}_2, \text{Pd/C}$), Hydroboration-Oxidation ($\text{BH}_3\cdot\text{THF} \to \text{anti-Markovnikov syn-alcohol}$), Dihydroxylation ($\text{OsO}_4$).
* **Nucleophilic Acyl Substitution (Addition-Elimination, $B_{\text{Ac}}2$):**
  - Nucleophile attacks carbonyl carbon forming tetrahedral intermediate, followed by expulsion of best leaving group:
    $$\text{Acyl Chloride } > \text{Anhydride } > \text{Ester / Carboxylic Acid } > \text{Amide } > \text{Carboxylate}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The 4-Factor Diagnostic Decision Tree
* When evaluating an alkyl halide $+$ nucleophile/base mixture, check in strict sequence:
  1. **Substrate Sterics:** $1^\circ$ (Favors $\text{S}_{\text{N}}2$), $3^\circ$ (Blocks $\text{S}_{\text{N}}2$, favors $\text{E}2$ with strong base or $\text{S}_{\text{N}}1/\text{E}1$ with weak base).
  2. **Reagent Nature:** Strong base ($\text{RO}^- \implies \text{E}2$), Strong nucleophile/weak base ($\text{I}^-, \text{RS}^-, \text{CN}^- \implies \text{S}_{\text{N}}2$).
  3. **Solvent:** Polar Protic ($\text{S}_{\text{N}}1/\text{E}1$) vs Polar Aprotic ($\text{S}_{\text{N}}2$).
  4. **Temperature:** High heat ($\Delta$) strongly favors Elimination ($\Delta G = \Delta H - T\Delta S$, positive $\Delta S$ from making 3 molecules from 2).

### 2. Top Recommended Resources
* **The Mechanistic Authority:** *Organic Chemistry* by Clayden, Greeves, Warren (Oxford University Press).
* **Classic Text:** *Organic Chemistry: Structure and Function* by K. Peter C. Vollhardt & Neil E. Schore.
* **Electron-Pushing Guide:** *The Art of Writing Reasonable Organic Reaction Mechanisms* by Robert B. Grossman.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you predict the major product and mechanism ($\text{S}_{\text{N}}1, \text{S}_{\text{N}}2, \text{E}1, \text{E}2$) for any alkyl halide under given reaction conditions?
- [ ] Can you identify whether an E2 elimination in a substituted cyclohexane is allowed based on diaxial conformational alignment?
- [ ] Can you explain the stereochemical outcome of alkene bromination using the cyclic bromonium ion model?
- [ ] Can you rank carboxylic acid derivatives by their rate of nucleophilic acyl substitution?
