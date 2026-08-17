# Duofy Reusable Lesson Format: ROC Curve, AUC Metric, and Precision-Recall Trade-offs

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Machine_Learning / Model_Evaluation_ROC_AUC_CrossValidation`  
**Lesson Format Type:** `roc_curve_auc_metric_and_precision_recall_tradeoffs`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the probability threshold parameter sweeps, diagnostic trade-offs, and ranking interpretations of Receiver Operating Characteristic (ROC) and Precision-Recall (PR) curves (Tom Fawcett 2006, *An Introduction to ROC Analysis*, Pattern Recognition Letters; Jesse Davis & Mark Goadrich 2006 PR-AUC, ICML '06): plot **The ROC Curve ($\mathbf{\text{True Positive Rate (TPR)} = \frac{\text{TP}}{\text{TP}+\text{FN}}}$ on $y$-axis vs $\mathbf{\text{False Positive Rate (FPR)} = \frac{\text{FP}}{\text{FP}+\text{TN}}}$ on $x$-axis)** across continuous probability decision thresholds $\tau \in [0, 1]$, prove the **Probabilistic Meaning of Area Under Curve (ROC-AUC)** as the exact probability that the model ranks a randomly chosen positive sample higher than a randomly chosen negative sample ($\mathbf{P(\hat{y}_{\text{pos}} > \hat{y}_{\text{neg}})}$ - equivalent to the **Wilcoxon-Mann-Whitney $U$ statistic**), evaluate the baseline diagonal ($\text{AUC}=0.5$) vs perfect classifier ($\text{AUC}=1.0$), and contrast ROC-AUC with the **Precision-Recall Curve (PR-AUC)** on severe class-imbalanced datasets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ROC Curve Coordinate Plane (TPR vs FPR), ROC-AUC Probabilistic Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of an Empirical ROC Curve by Sweeping Decision Thresholds Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Curve Metric / Threshold Point & Classification Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The ROC-AUC Score of a Completely Uninformed Random-Guessing Classifier is ___ (0.5 / 0.50) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis of Why the ROC-AUC Metric Is Invariant to Monotonic Probability Calibration Scaling Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ROC & AUC (Tom Fawcett 2006):
   - **The ROC Curve Coordinate Space:**
     $$\mathbf{y\text{-axis} = \mathbf{\text{TPR (Sensitivity)}} = \frac{\text{TP}}{\text{TP} + \text{FN}} \qquad ; \qquad x\text{-axis} = \mathbf{\text{FPR}} = \frac{\text{FP}}{\text{FP} + \text{TN}} = 1 - \text{Specificity}}$$
     - Sweeping threshold $\tau$ from $1.0 \to 0.0$ traces path from $(0, 0)$ (predict all 0) to $(1, 1)$ (predict all 1).
     - Ideal operating point is the top-left corner $(0, 1)$ where $\text{TPR}=1.0, \text{FPR}=0.0$.
   - **The Probabilistic Meaning of ROC-AUC:**
     $$\mathbf{\text{ROC-AUC} = \mathbf{P\big(\hat{y}_{\text{positive}} > \hat{y}_{\text{negative}}\big)} = \frac{U}{n_{\text{pos}} \cdot n_{\text{neg}}}}$$
     - Measures **ranking quality**! Equivalent to the Wilcoxon-Mann-Whitney $U$ rank test.
     - $\text{AUC}=1.0 \implies$ Perfect separation; $\text{AUC}=0.5 \implies$ Random coin flip.
2. **Slide 2 (`ordering`):** Provide 5 steps of generating an ROC curve: (1) obtain predicted probability scores for all test instances from classification model, (2) sort test samples in descending order of predicted probabilities, (3) set initial threshold tau = 1.0 (start at origin 0,0 where all predictions are negative), (4) step through sorted samples one by one, decreasing threshold tau: if sample is true positive, move graph UP by 1/N_pos; if sample is true negative, move graph RIGHT by 1/N_neg, (5) reach threshold tau = 0.0 at point (1, 1) and calculate total Area Under the Curve (AUC) using trapezoidal rule!
3. **Slide 3 (`matching`):** Pair 4 ROC concepts (Point (0, 1), Diagonal Line AUC=0.5, ROC-AUC Score, Threshold tau) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that random guesser has AUC = 0.5. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why ROC-AUC is scale-invariant: A data scientist applies a strictly monotonic non-linear mathematical transformation (e.g. $f(p) = \ln(p)$ or multiplying all probabilities by a constant factor) to a model's predicted output probabilities. Why does this transformation leave the ROC curve and ROC-AUC score completely unchanged? (ROC-AUC is **strictly a threshold-independent ranking metric**; the ROC curve is constructed exclusively by sorting predictions in relative descending order; because any strictly monotonic increasing function **preserves the exact relative pairwise ordering of all data instances without changing which point ranks above another**, the sequence of vertical (TPR) and horizontal (FPR) steps in the ROC plot remains 100% identical, resulting in an unchanged AUC).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "roc_curve_auc_metric_and_precision_recall_tradeoffs",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ROC Analysis \\& The AUC Ranking Metric (Tom Fawcett 2006)**\n• **The ROC Coordinate Plane:**\n$$\n\\mathbf{y\\text{-axis} = \\mathbf{\\text{TPR (Recall)}} = \\frac{\\text{TP}}{\\text{TP} + \\text{FN}} \\qquad ; \\qquad x\\text{-axis} = \\mathbf{\\text{FPR}} = \\frac{\\text{FP}}{\\text{FP} + \\text{TN}} = 1 - \\text{Specificity}}\n$$\n• **Probabilistic Interpretation of ROC-AUC:**\n$$\n\\mathbf{\\text{ROC-AUC} = \\mathbf{P\\big(\\hat{y}_{\\text{positive}} > \\hat{y}_{\\text{negative}}\\big)} = \\frac{U}{n_{\\text{pos}} \\cdot n_{\\text{neg}}}}\n$$\n• **Performance Scale:**\n  - $\\mathbf{\\text{AUC} = 1.0}:$ Perfect discrimination (Top-left corner $(0, 1)$ reached).\n  - $\\mathbf{\\text{AUC} = 0.5}:$ Random guessing baseline (Diagonal line from $(0,0)$ to $(1,1)$).\n  - $\\mathbf{\\text{AUC} < 0.5}:$ Inverted predictions (Worse than random; flip predictions to fix!).\n• **Core Property:** **Threshold-Invariant \\& Scale-Invariant!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to construct an empirical ROC curve and compute its Area Under the Curve (AUC).",
      "orderItems": [
        "Compute predicted continuous probability scores for all test instances using the trained classification model",
        "Sort all test instances in descending order of their predicted positive probability scores",
        "Initialize the plotting cursor at the coordinate origin (0, 0) corresponding to probability threshold tau = 1.0",
        "Iterate down through the sorted instances decreasing threshold tau: For each True Positive move UP by 1/N_pos; for each False Positive move RIGHT by 1/N_neg",
        "Terminate at coordinate (1, 1) when tau = 0.0 and integrate the total area beneath the stepped path using the trapezoidal rule"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ROC Metric / Coordinate Point to its exact Diagnostic Meaning.",
      "matchPairs": [
        { "left": "Top-Left Coordinate (0, 1)", "right": "The ideal classification operating point achieving 100% True Positive Rate and 0% False Positive Rate" },
        { "left": "Diagonal Baseline (AUC = 0.5)", "right": "The expected performance curve of an uninformative random guessing coin-toss classifier" },
        { "left": "ROC-AUC Probabilistic Meaning", "right": "The exact probability that the model assigns a higher prediction score to a randomly chosen positive sample" },
        { "left": "Decision Threshold tau", "right": "The cutoff boundary above which continuous probability predictions are classified as positive instances" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ROC-AUC score of a completely uninformative random-guessing classifier is ___.",
      "blankAnswer": "0.5",
      "blankDistractors": ["0.0", "1.0", "0.25"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A machine learning engineer applies a strictly monotonic non-linear transformation (e.g. taking the natural log of all probabilities or multiplying by a constant factor) to a model's predicted probability scores. Why does this transformation leave the ROC curve and the ROC-AUC score completely unchanged?",
      "options": [
        { "text": "ROC-AUC is fundamentally a rank-based metric rather than a calibrated probability metric; the ROC curve is generated exclusively by sorting predictions in descending order and stepping through them one by one; because any strictly monotonic increasing function preserves the exact relative pairwise ordering of all data instances without altering which sample ranks above another, the sequence of upward (TPR) and rightward (FPR) plot steps remains 100% identical, resulting in an unchanged AUC", "isCorrect": true, "explanation": "Correct! This is one of the most vital mathematical properties of ROC analysis (Tom Fawcett 2006; Davis & Goadrich 2006). 1. **Ranking Invariance:** - The ROC curve does not care whether your model predicts $0.99$ or $0.51$ for a positive sample. - It ONLY cares: *Is the positive sample ranked higher than the negative sample?* 2. **The Monotonic Function Proof:** - Let $f(x)$ be any strictly increasing function (e.g. $f(p) = \\ln(p)$ or $f(p) = p^3$). - If Sample $A$ had higher probability than Sample $B$ ($p_A > p_B$), then $f(p_A) > f(p_B)$ remains strictly true! - When you sort the test set by $f(p)$, the sorted order of samples is **$100\\%$ identical to sorting by $p$**. 3. **The Wilcoxon Connection:** - Because $\\text{ROC-AUC} = \\frac{U}{n_1 n_0}$ (The Mann-Whitney $U$ rank-sum statistic), any transformation that preserves rank preserves the AUC score with mathematical perfection." },
        { "text": "Because monotonic functions automatically round all numbers to zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because ROC curves can only be plotted using log scales", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AUC is calculated using quantum entanglement", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
