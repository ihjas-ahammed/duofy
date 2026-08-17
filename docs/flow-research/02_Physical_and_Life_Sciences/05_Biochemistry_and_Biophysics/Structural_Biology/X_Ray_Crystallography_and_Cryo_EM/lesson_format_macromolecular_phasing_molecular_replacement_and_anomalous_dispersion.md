# Duofy Reusable Lesson Format: Macromolecular Phasing (Molecular Replacement and Anomalous Dispersion)

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Structural_Biology / X_Ray_Crystallography_and_Cryo_EM`  
**Lesson Format Type:** `macromolecular_phasing_molecular_replacement_and_anomalous_dispersion`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical strategies, experimental techniques, and computational algorithms developed to solve the Crystallographic Phase Problem (Michael Rossmann & David Blow 1962; Wayne Hendrickson; Axel Brünger): analyze **Molecular Replacement (MR)** using homologous known structural models ($>25-30\%$ sequence identity) via 6-dimensional parameter search decomposed into a **3D Rotation Function (Patterson space)** followed by a **3D Translation Function**, master **Single/Multi-Wavelength Anomalous Dispersion (SAD/MAD)** utilizing anomalous resonance scatterers (e.g. **Selenomethionine [Se-Met]** substituting for methionine near selenium X-ray absorption edge $K$-edge $\lambda \approx 0.979\text{ \AA}$, breaking Friedel's Law $|\mathbf{F}_{hkl}| \neq |\mathbf{F}_{\bar{h}\bar{k}\bar{l}}|$ to determine heavy atom substructure and phase angles), and evaluate crystallographic cross-validation via **$R_{\text{work}}$ and $R_{\text{free}}$**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Molecular Replacement & Anomalous Dispersion Phasing Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Molecular Replacement Rotation and Translation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Phasing Method / Validation Metric & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Heavy Atom Element Used to Replace Methionine in SAD/MAD Phasing Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Critical Role of R_free in Preventing Model Overfitting Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Macromolecular Phasing Strategies & Model Validation:
   - **1. Molecular Replacement (MR - Rossmann & Blow 1962):**
     - Requires a homologous known protein structure ($>25-30\%$ sequence identity).
     - Decomposes the 6D search into:
       1. **Rotation Function:** Aligns the Patterson vectors of the model with the Patterson vectors of the unknown crystal (determines Euler angles $\alpha, \beta, \gamma$).
       2. **Translation Function:** Translates the rotated model within the unit cell to locate its exact origin coordinates $(x, y, z)$.
   - **2. Anomalous Dispersion (SAD / MAD - Hendrickson):**
     - Exploits resonance absorption of X-rays near heavy-atom absorption edges:
       $$f = f_0 + f'(\lambda) + i f''(\lambda)$$
     - The imaginary component $f''$ introduces a phase shift that **breaks Friedel's Law**:
       $$|\mathbf{F}_{hkl}| \neq |\mathbf{F}_{\bar{h}\bar{k}\bar{l}}| \quad (\text{Bijvoet Differences})$$
     - **Selenomethionine (Se-Met):** Biosynthetically replaces methionine residues with selenium atoms $\implies$ Yields robust anomalous signal to locate Se substructure and calculate experimental phases!
   - **3. Cross-Validation & The $R$-Factor (Axel Brünger 1992):**
     - **$R_{\text{work}}$:** Measures agreement between observed $|F_{\text{obs}}|$ and model-calculated $|F_{\text{calc}}|$ on working data.
     - **$R_{\text{free}}$:** Calculated on a random, reserved **$5-10\%$ test set** of reflections *never used during refinement*; prevents overfitting and geometric distortion!
2. **Slide 2 (`ordering`):** Provide 5 steps of solving a protein crystal structure via Molecular Replacement (MR): (1) identify a homologous search model in the Protein Data Bank (PDB) with significant sequence identity, (2) compute Patterson vector maps for both the experimental target diffraction data and the search model, (3) execute the 3D Rotation Function to find the orientation angles that maximize Patterson overlap, (4) execute the 3D Translation Function to position the rotated model correctly within the target unit cell, (5) calculate initial phases from the positioned model to generate the first electron density map for rebuilding and refinement!
3. **Slide 3 (`matching`):** Pair 4 phasing concepts (Molecular Replacement, SAD / MAD Phasing, R_free Validation Factor, Friedel's Law Breakdown) with their physical/algorithmic roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the heavy atom element used in biosynthetic selenomethionine incorporation for experimental MAD phasing is selenium. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the purpose and interpretation of $R_{\text{free}}$ in crystallographic refinement: Why did Axel Brünger introduce the free R-factor ($R_{\text{free}}$), and what does a large divergence between $R_{\text{work}} = 0.15$ and $R_{\text{free}} = 0.35$ indicate about a protein model? (It serves as an unbiased cross-validation metric; a large gap between $R_{\text{work}}$ and $R_{\text{free}}$ proves that the crystallographer has **overfitted the atomic parameters to experimental noise**, introducing artificial coordinate distortions to match the working reflections without improving true physical accuracy).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "macromolecular_phasing_molecular_replacement_and_anomalous_dispersion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Macromolecular Phasing & Model Validation**\n• **1. Molecular Replacement (MR - Rossmann 1962):**\n  - Uses a homologous structure ($>25\\text{--}30\\%$ identity).\n  - **Rotation Function (Patterson Space):** Determines orientation $(\\alpha, \\beta, \\gamma)$.\n  - **Translation Function:** Positions model in target unit cell $(x, y, z)$.\n• **2. Anomalous Dispersion (SAD/MAD - Hendrickson):**\n  - $f = f_0 + f' + if'' \\implies$ Breaks Friedel's Law ($|\\mathbf{F}_{hkl}| \\neq |\\mathbf{F}_{\\bar{h}\\bar{k}\\bar{l}}|$).\n  - **Selenomethionine (Se-Met):** Selenium atoms replace Met $\\implies$ Locates heavy atom substructure $\\to$ Solves experimental phases!\n• **3. Cross-Validation ($R_{\\text{free}}$ - Brünger 1992):**\n$$\n\\mathbf{R_{\\text{free}} = \\frac{\\sum_{\\text{test}} ||F_{\\text{obs}}| - |F_{\\text{calc}}||}{\\sum_{\\text{test}} |F_{\\text{obs}}|}}\n$$\n  - Calculated on an unbiased **$5\\text{--}10\\%$ test set** $\\implies$ **Guards against model overfitting!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of solving a macromolecular crystal structure using Molecular Replacement (MR).",
      "orderItems": [
        "Select a homologous 3D structure from the Protein Data Bank (PDB) to serve as a search model",
        "Calculate Patterson vector maps for both the experimental target diffraction data and the search model",
        "Perform the 3D Rotation Function to identify the optimal angular orientation of the model in Patterson space",
        "Perform the 3D Translation Function to locate the absolute spatial coordinates of the rotated model in the unit cell",
        "Calculate initial model phases from the positioned search coordinates to generate the first electron density map"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each macromolecular phasing/validation concept to its exact function.",
      "matchPairs": [
        { "left": "Molecular Replacement (MR)", "right": "Phasing method utilizing a homologous known structural coordinate model to calculate initial phases" },
        { "left": "SAD / MAD Phasing", "right": "Experimental phasing method exploiting anomalous X-ray absorption of heavy atoms like Selenium" },
        { "left": "R_free Cross-Validation Factor", "right": "Unbiased quality metric calculated on a reserved 5-10% test set of reflections to prevent overfitting" },
        { "left": "Breakdown of Friedel's Law", "right": "Inequality in Bijvoet spot intensities (|F_hkl| != |F_-h-k-l|) caused by anomalous resonant scattering" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In experimental macromolecular MAD phasing, recombinant proteins are biosynthetically expressed with selenomethionine to incorporate anomalous scattering ___ atoms.",
      "blankAnswer": "selenium",
      "blankDistractors": ["sulfur", "carbon", "nitrogen"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "During the refinement of an X-ray crystal structure, the crystallographer reports an R_work of 0.16 (16%) but an R_free of 0.38 (38%). What does this substantial discrepancy indicate about the model?",
      "options": [
        { "text": "MODEL OVERFITTING; the atomic parameters have been mathematically over-refined against experimental noise and errors in the working dataset without improving the true physical accuracy of the structure, as revealed by the unbiased test reflections in R_free", "isCorrect": true, "explanation": "Correct! In crystallographic refinement, atomic coordinates (x, y, z) and temperature factors (B-factors) are adjusted to minimize the difference between calculated and observed structure factor amplitudes (R_work). Because the number of parameters is large relative to observations, an unscrupulous or unguided refinement algorithm can easily fit the model to random experimental noise, driving R_work down artificially. To detect this, Axel Brünger introduced R_free, which is calculated exclusively on a randomly chosen 5-10% subset of reflection data that is set aside and never used during refinement. If a model is physically accurate, R_free will track closely with R_work (typically within 3-5 percentage points, e.g. R_work = 0.18, R_free = 0.22). A massive divergence (R_work = 0.16 vs R_free = 0.38) is a definitive indicator of severe overfitting and erroneous atomic positions." },
        { "text": "The crystal was made of pure sodium chloride", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The X-ray beam was too bright", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The protein structure has achieved sub-atomic 0.5 Angstrom resolution", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
