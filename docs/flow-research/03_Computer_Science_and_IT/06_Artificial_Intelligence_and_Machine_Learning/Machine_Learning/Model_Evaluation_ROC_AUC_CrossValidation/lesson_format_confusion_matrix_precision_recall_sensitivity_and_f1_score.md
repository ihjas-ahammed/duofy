# Duofy Reusable Lesson Format: Confusion Matrix (Precision, Recall, Specificity, and F1-Score)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Machine_Learning / Model_Evaluation_ROC_AUC_CrossValidation`  
**Lesson Format Type:** `confusion_matrix_precision_recall_sensitivity_and_f1_score`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic definitions, error trade-offs, and clinical/industrial priorities of Confusion Matrix metrics (Hastie, Tibshirani, Friedman *ESL* Chapter 7; Christopher Bishop *PRML* Chapter 1.5): analyze why Accuracy ($\frac{\text{TP}+\text{TN}}{\text{Total}}$) is dangerously deceptive under class imbalance (the Accuracy Paradox), master the **Confusion Matrix Quartet (True Positive [TP], False Positive [FP / Type I Error], True Negative [TN], False Negative [FN / Type II Error])**, derive **Precision / Positive Predictive Value ($\mathbf{\text{Precision} = \frac{\text{TP}}{\text{TP} + \text{FP}}}$)**, **Recall / Sensitivity / TPR ($\mathbf{\text{Recall} = \frac{\text{TP}}{\text{TP} + \text{FN}}}$)**, **Specificity / TNR ($\mathbf{\text{Specificity} = \frac{\text{TN}}{\text{TN} + \text{FP}}}$)**, and prove why the **F1-Score Harmonic Mean ($\mathbf{F_1 = 2 \frac{P \cdot R}{P + R} = \frac{2\text{TP}}{2\text{TP} + \text{FP} + \text{FN}}}$)** penalizes extreme asymmetries significantly more severely than the arithmetic mean.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Confusion Matrix Table, Precision, Recall, Specificity, & F1 Harmonic Mean Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Calculation of Confusion Matrix Derived Metrics from Raw Counts Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Evaluation Metric / Error Type & Diagnostic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Metric Measuring the Proportion of Actual Positives That Were Correctly Identified is ___ (Recall / Sensitivity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis of Why the F1-Score Uses the Harmonic Mean Rather Than the Arithmetic Mean Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Confusion Matrix & Metrics (Bishop *PRML* 1.5; Hastie *ESL* 7):
   - **The Confusion Matrix Breakdown:**
     $$\begin{array}{|c|c|c|}
     \hline
     & \textbf{Actual Positive } (y=1) & \textbf{Actual Negative } (y=0) \\
     \hline
     \mathbf{\text{Predicted Pos } (\hat{y}=1)} & \mathbf{\text{TP (True Positive)}} & \mathbf{\text{FP (False Positive - Type I)}} \\
     \mathbf{\text{Predicted Neg } (\hat{y}=0)} & \mathbf{\text{FN (False Negative - Type II)}} & \mathbf{\text{TN (True Negative)}} \\
     \hline
     \end{array}$$
   - **The Core Metric Formulas:**
     $$\mathbf{\text{Precision} = \frac{\text{TP}}{\text{TP} + \text{FP}} \qquad ; \qquad \mathbf{\text{Recall (Sensitivity)} = \frac{\text{TP}}{\text{TP} + \text{FN}}}}$$
     $$\mathbf{\text{Specificity (TNR)} = \frac{\text{TN}}{\text{TN} + \text{FP}} \qquad ; \qquad \mathbf{F_1 = 2 \cdot \frac{\text{Precision} \cdot \text{Recall}}{\text{Precision} + \text{Recall}} = \frac{2\text{TP}}{2\text{TP} + \text{FP} + \text{FN}}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of evaluating a cancer diagnosis model with TP=80, FP=20, FN=10, TN=890: (1) calculate total samples N = TP + FP + FN + TN = 1000, (2) compute overall Accuracy = (80 + 890) / 1000 = 97.0%, (3) calculate Precision = TP / (TP + FP) = 80 / (80 + 20) = 80.0%, (4) calculate Recall / Sensitivity = TP / (TP + FN) = 80 / (80 + 10) = 88.9%, (5) compute F1-Score = 2 * (0.80 * 0.889) / (0.80 + 0.889) = 84.2%!
3. **Slide 3 (`matching`):** Pair 4 metrics (Precision, Recall / Sensitivity, Specificity, F1-Score) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that TP/(TP+FN) is Recall (or Sensitivity). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why F1 uses the harmonic mean: In model evaluation, why is the F1-Score formulated as the Harmonic Mean of Precision and Recall ($2 \frac{P \cdot R}{P + R}$) rather than the standard Arithmetic Mean ($\frac{P + R}{2}$)? (The Arithmetic Mean allows a severely defective model to mask terrible performance; for instance, a naive model that predicts positive for every single instance achieves $\text{Recall} = 1.0$ and $\text{Precision} = 0.01$, yielding a misleading Arithmetic Mean of $\frac{1.0 + 0.01}{2} = 0.505$; **the Harmonic Mean is dominated by the smaller number and approaches zero if either Precision or Recall collapses**, yielding an honest $F_1 = 2 \frac{0.01 \times 1.0}{0.01 + 1.0} = \mathbf{0.0198}$, properly punishing extreme metric imbalances).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "confusion_matrix_precision_recall_sensitivity_and_f1_score",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Confusion Matrix \\& Performance Metrics**\n• **The Two-by-Two Contingency Matrix (Bishop *PRML* Chapter 1.5):**\n$$\n\\begin{array}{|c|c|c|}\n\\hline\n& \\textbf{Actual Positive } (y=1) & \\textbf{Actual Negative } (y=0) \\\\\n\\hline\n\\mathbf{\\text{Predicted Pos } (\\hat{y}=1)} & \\mathbf{\\text{True Positive (TP)}} & \\mathbf{\\text{False Positive (FP - Type I)}} \\\\\n\\mathbf{\\text{Predicted Neg } (\\hat{y}=0)} & \\mathbf{\\text{False Negative (FN - Type II)}} & \\mathbf{\\text{True Negative (TN)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Core Diagnostic Metric Equations:**\n$$\n\\mathbf{\\text{Precision} = \\frac{\\text{TP}}{\\text{TP} + \\text{FP}} \\qquad ; \\qquad \\mathbf{\\text{Recall (Sensitivity)} = \\frac{\\text{TP}}{\\text{TP} + \\text{FN}}}}\n$$\n$$\n\\mathbf{\\text{Specificity (TNR)} = \\frac{\\text{TN}}{\\text{TN} + \\text{FP}} \\qquad ; \\qquad \\mathbf{F_1 = 2 \\cdot \\frac{\\text{Precision} \\cdot \\text{Recall}}{\\text{Precision} + \\text{Recall}} = \\frac{2\\text{TP}}{2\\text{TP} + \\text{FP} + \\text{FN}}}}\n$$\n• **The Accuracy Paradox:** A dummy model predicting all zeroes on 99% negative data gets **99% accuracy while catching zero positives!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to compute diagnostic evaluation metrics from raw confusion matrix counts (TP=80, FP=20, FN=10, TN=890).",
      "orderItems": [
        "Sum all contingency table cells to determine total dataset sample size: N = 80 + 20 + 10 + 890 = 1000 total observations",
        "Compute overall Accuracy = (TP + TN) / N = (80 + 890) / 1000 = 97.0%",
        "Compute Precision (Positive Predictive Value) = TP / (TP + FP) = 80 / (80 + 20) = 80.0%",
        "Compute Recall (Sensitivity / True Positive Rate) = TP / (TP + FN) = 80 / (80 + 10) = 88.9%",
        "Calculate the balanced F1-Score Harmonic Mean = 2 * (0.80 * 0.889) / (0.80 + 0.889) = 84.2%"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Diagnostic Performance Metric to its exact Question Answered.",
      "matchPairs": [
        { "left": "Precision (PPV)", "right": "Of all instances predicted positive by the model, what fraction were truly positive?" },
        { "left": "Recall (Sensitivity)", "right": "Of all actual real-world positive instances in existence, what fraction did the model successfully detect?" },
        { "left": "Specificity (TNR)", "right": "Of all actual negative instances, what fraction did the model correctly identify as negative?" },
        { "left": "F1-Score", "right": "Harmonic mean of precision and recall providing a balanced metric robust against class imbalance" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The metric measuring the proportion of actual positive cases that were correctly identified is ___.",
      "blankAnswer": "recall",
      "blankDistractors": ["precision", "accuracy", "specificity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the F1-Score mathematically formulated as the Harmonic Mean of Precision and Recall (2 * P * R / (P + R)) rather than the standard Arithmetic Mean ((P + R) / 2)?",
      "options": [
        { "text": "The Arithmetic Mean allows an unusable model with extreme metric asymmetry to appear deceptively effective; for example, a trivial dummy model that predicts positive for every single sample in a rare fraud dataset achieves Recall = 1.0 and Precision = 0.01, yielding a misleading Arithmetic Mean of (1.0 + 0.01)/2 = 0.505; the Harmonic Mean is dominated by the smaller value and collapses toward zero if either metric is poor, properly assigning this broken model an honest F1-Score of 0.0198", "isCorrect": true, "explanation": "Correct! This is the classic mathematical justification for the Harmonic Mean in machine learning evaluation (Hastie et al. *ESL* Chapter 7; Bishop *PRML* Section 1.5). 1. **The Properties of the Harmonic Mean:** - The harmonic mean of two numbers $a$ and $b$ is $\\frac{2}{\\frac{1}{a} + \\frac{1}{b}} = \\frac{2ab}{a+b}$. - It is mathematically impossible for the harmonic mean to be large unless BOTH numbers are large! 2. **The Arithmetic Mean Trap:** - Consider a spam filter. If the model marks ALL emails as spam: - $\\text{Recall} = 1.0$ (It caught $100\\%$ of spam). - $\\text{Precision} = 0.02$ ($98\\%$ of flagged emails are legitimate inbox emails!). - Arithmetic Mean = $\\frac{1.0 + 0.02}{2} = \\mathbf{0.51}$ ($51\\%$ sounds like an acceptable mediocre model to an executive!). 3. **The F1 Harmonic Mean Reality Check:** - $F_1 = 2 \\times \\frac{1.0 \\times 0.02}{1.0 + 0.02} = \\mathbf{0.039}$! - The score collapses, accurately reflecting that a spam filter with $2\\%$ precision is completely broken and unusable." },
        { "text": "Because the arithmetic mean cannot be calculated for fractions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because harmonic means require quantum computer processing", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the F1-score is always equal to 1.0 for all models", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
