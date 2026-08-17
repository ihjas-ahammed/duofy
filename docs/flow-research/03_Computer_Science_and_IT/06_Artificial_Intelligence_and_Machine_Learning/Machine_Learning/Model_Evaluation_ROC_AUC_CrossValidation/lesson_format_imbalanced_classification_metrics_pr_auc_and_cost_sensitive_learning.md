# Duofy Reusable Lesson Format: Imbalanced Classification Metrics (PR-AUC and Cost-Sensitive Learning)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Machine_Learning / Model_Evaluation_ROC_AUC_CrossValidation`  
**Lesson Format Type:** `imbalanced_classification_metrics_pr_auc_and_cost_sensitive_learning`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify performance evaluation metrics, loss weighting architectures, and sampling strategies for highly imbalanced classification datasets (Jesse Davis & Mark Goadrich 2006 *The Relationship Between Precision-Recall and ROC Curves*, ICML '06; Charles Elkan 2001 *The Foundations of Cost-Sensitive Learning*; Nitesh Chawla et al. 2002 SMOTE): analyze why standard ROC-AUC gives an overly optimistic, deceptive evaluation on severe class imbalance (where the massive flood of True Negatives artificially suppresses $\text{FPR} = \frac{\text{FP}}{\text{FP}+\text{TN}} \approx 0$), master the **Precision-Recall Curve (PR-AUC / Average Precision)** which isolates the positive minority class by ignoring TNs, contrast **Resampling Techniques (Random Undersampling, Random Oversampling, and Synthetic Minority Over-sampling Technique [SMOTE])** with **Cost-Sensitive Learning / Class Weighting (assigning loss weights inversely proportional to class frequencies: $w_j = \frac{N}{K \cdot N_j}$ via `class_weight='balanced'`)**, and interact with live Imbalanced Fraud Detection ROC vs PR Curve comparison and SMOTE synthesis simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ROC-AUC vs PR-AUC on Imbalanced Data, Cost-Sensitive Loss Weighting & SMOTE Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Imbalanced Learning Technique / Metric & Operational Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why PR-AUC Exposes Terrible Model Performance on Imbalanced Datasets That ROC-AUC Masks Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Synthetic Oversampling Algorithm That Creates Interpolated Minority Class Examples is ___ (SMOTE) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Imbalanced Fraud Detection: ROC vs PR Curve Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "imbalanced_classification_metrics_pr_auc_and_cost_sensitive_learning",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why is PR-AUC superior to ROC-AUC for severe class imbalance, and how does Cost-Sensitive Learning work?",
      "blankAnswer": "Imbalanced Learning & PR-AUC (Davis & Goadrich 2006; Elkan 2001; Chawla 2002): (1) THE ROC-AUC IMBALANCE TRAP: On rare positive datasets (e.g. 1 fraud per 1,000 transactions = 99.9% Negative), the True Negative count TN is enormous. In ROC, FPR = FP / (FP + TN). Even if the model generates 500 False Positives, FPR remains tiny (~0.005), yielding a deceptively high ROC-AUC > 0.95! (2) PR-AUC (PRECISION-RECALL CURVE): Focuses STRICTLY on the positive minority class (Precision = TP/(TP+FP), Recall = TP/(TP+FN)). It completely ignores TN! In the scenario above, Precision collapses from 100% to 0.2%, and PR-AUC collapses from 1.0 to 0.05, exposing the model's true flaw! (3) MITIGATION STRATEGIES: (a) Cost-Sensitive Learning (`class_weight='balanced'`): Scales loss gradient by inverse class frequency w_pos = N_neg / N_pos, heavily penalizing false negatives. (b) SMOTE (Synthetic Minority Over-sampling): Synthesizes new minority instances along k-NN line segments in feature space!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Imbalanced Learning Construct to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Precision-Recall AUC (PR-AUC)", "right": "Area under precision vs recall curve providing an honest evaluation for highly skewed minority targets" },
        { "left": "SMOTE Algorithm", "right": "Generates synthetic minority examples by linearly interpolating between neighboring minority instances" },
        { "left": "Cost-Sensitive Loss (class_weight)", "right": "Scales objective loss functions to assign heavily disproportionate penalties to minority class errors" },
        { "left": "Random Undersampling", "right": "Discards majority class instances to balance class proportions, risking the loss of informative data" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a credit card fraud detection dataset containing 100 fraudulent transactions (Class 1) and 99,900 legitimate transactions (Class 0), a model achieves an impressive ROC-AUC score of 0.96, but its PR-AUC score is a dismal 0.12. What mathematical reality explains this massive divergence?",
      "options": [
        { "text": "The False Positive Rate in ROC analysis (FPR = FP / (FP + TN)) contains the massive 99,900 True Negatives in its denominator; if the model produces 1,000 false alarms (FP = 1,000), FPR is only 1,000/100,900 approx 0.0099, keeping the ROC curve pushed tightly into the top-left corner with a deceptive 0.96 AUC; however, Precision (TP / (TP + FP)) contains no True Negatives, so 80 True Positives against 1,000 False Positives causes Precision to collapse to 80/1080 = 7.4%, which PR-AUC accurately reflects as an unusable 0.12 score", "isCorrect": true, "explanation": "Correct! This is one of the most vital insights in real-world data science and anomaly detection (Jesse Davis & Mark Goadrich 2006; Tom Fawcett 2006). 1. **The Numbers:** - Actual Fraud ($y=1$): $100$. - Actual Legitimate ($y=0$): $99,900$. - The model flags $1,080$ transactions as fraud: - $\\text{TP} = 80$ (Caught $80\\%$ of fraud $\\implies \\text{Recall} = 0.80$). - $\\text{FP} = 1,000$ (False alarms on innocent cardholders). - $\\text{TN} = 98,900$. 2. **Why ROC-AUC Lies (0.96):** - $\\text{FPR} = \\frac{\\text{FP}}{\\text{FP} + \\text{TN}} = \\frac{1,000}{1,000 + 98,900} = \\mathbf{0.0101}$ (Only $1\\%$ false alarm rate!). - The point $(\\text{FPR}=0.01, \\text{TPR}=0.80)$ is right near $(0, 1)$, giving a stellar ROC-AUC of $0.96$. 3. **Why PR-AUC Tells the Brutal Truth (0.12):** - $\\text{Precision} = \\frac{\\text{TP}}{\\text{TP} + \\text{FP}} = \\frac{80}{80 + 1,000} = \\mathbf{0.074\\text{ (7.4%)}}$! - If this system is deployed, $92.6\\%$ of all flagged credit cards are innocent users having their cards blocked. Customer support will be overwhelmed! - PR-AUC isolates this disaster and scores it a failing $0.12$." },
        { "text": "Because PR-AUC is only valid for multi-class classification", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because ROC curves cannot be calculated on credit card datasets", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because PR-AUC only works when classes are 50/50 balanced", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The synthetic oversampling algorithm that creates artificial minority examples along k-NN lines is ___.",
      "blankAnswer": "SMOTE",
      "blankDistractors": ["PCA", "DBSCAN", "MCTS"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Imbalanced Fraud: ROC vs PR Curve Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Imbalanced Fraud: ROC vs PR Curve</h3><p>Data: <b style=\"color:#ef4444;\">100 Fraud (0.1%)</b> vs <b style=\"color:#38bdf8;\">99,900 Legit (99.9%)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnRoc\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Inspect ROC-AUC (Deceptive)</button><button id=\"btnPr\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Inspect PR-AUC (Truth)</button><button id=\"btnSmote\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Apply SMOTE + Class Weight</button></div><div id=\"imbLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Select an evaluation perspective above...</div><script>document.getElementById('btnRoc').onclick=()=>{document.getElementById('imbLog').innerHTML='<b>ROC-AUC PERSPECTIVE:</b><br>• True Positives: 80 | False Positives: 1,000<br>• FPR = 1000 / (1000 + 98900) = <b style=\"color:#10b981;\">0.01 (1%)</b><br>• <b style=\"color:#10b981;\">ROC-AUC = 0.96 (MISLEADING EXCELLENCE!)</b><br>⚠️ Massive TNs hide 1000 false alarms!';}; document.getElementById('btnPr').onclick=()=>{document.getElementById('imbLog').innerHTML='<b>PR-AUC PERSPECTIVE (REALITY):</b><br>• Recall: 80 / 100 = 80.0%<br>• Precision: 80 / (80 + 1000) = <b style=\"color:#ef4444;\">7.4% (92.6% False Alarms!)</b><br>• <b style=\"color:#ef4444;\">PR-AUC = 0.12 (COLLAPSED!)</b><br>🚨 PR-AUC correctly flags model as unusable for production.';}; document.getElementById('btnSmote').onclick=()=>{document.getElementById('imbLog').innerHTML='<b>APPLIED SMOTE + BALANCED CLASS WEIGHTS:</b><br>• Synthetic minority interpolation + cost matrix tuning.<br>• Precision boosted to <b style=\"color:#10b981;\">82.4%</b> at 85% Recall.<br>🎉 <b style=\"color:#10b981;\">PR-AUC Reached 0.84! Production Ready!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
