# Duofy Reusable Lesson Format: GloVe (Global Co-occurrence Matrix Factorization)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Word_Embeddings_Word2Vec_GloVe`  
**Lesson Format Type:** `glove_global_cooccurrence_matrix_factorization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the co-occurrence probability ratio derivations, global count matrix construction, and weighted log-bilinear least squares optimization of GloVe (Jeffrey Pennington, Richard Socher, Christopher D. Manning 2014, *GloVe: Global Vectors for Word Representation*, EMNLP; Jurafsky & Martin *SLP* Chapter 6): construct the **Global Word-Word Co-occurrence Matrix ($X_{ij}$)**, derive the **Co-occurrence Probability Ratio Insight ($\frac{P(k|i)}{P(k|j)} = \frac{P(k|\text{ice})}{P(k|\text{steam})}$)** proving that semantic meaning is naturally encoded in linear vector differences, master the **GloVe Log-Bilinear Least-Squares Objective ($\mathbf{J = \sum_{i,j=1}^V f(X_{ij}) \big( w_i^T \tilde{w}_j + b_i + \tilde{b}_j - \ln X_{ij} \big)^2}$)**, analyze the **Truncated Weighting Function ($f(x) = \min(1, (x/x_{\max})^\alpha)$)** which prevents common stopwords from dominating gradients while suppressing noise, and evaluate why GloVe combines the statistical advantages of global matrix factorization with local window models.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GloVe Co-occurrence Ratio Proof, Log-Bilinear Objective Formula & Weighting Function Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction and Weighted Factorization of the GloVe Matrix Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | GloVe Mathematical Variable / Objective Term & Algorithmic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In GloVe, the Vector Dot Product $w_i^T \tilde{w}_j + b_i + \tilde{b}_j$ Is Trained to Equal the Natural Log of the Co-occurrence Count $\ln$ ___ (X_ij) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of the Probability Ratio Intuition (Ice vs Steam) in GloVe Vector Semantics Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State GloVe (Pennington et al. 2014; Jurafsky *SLP* Ch 6):
   - **The Co-occurrence Probability Ratio Insight:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Probability Ratio} & k = \text{\"solid\"} & k = \text{\"gas\"} & k = \text{\"water\"} \\
     \hline
     P(k \mid \text{ice}) & 1.9 \times 10^{-4} & 1.0 \times 10^{-5} & 3.0 \times 10^{-3} \\
     P(k \mid \text{steam}) & 2.2 \times 10^{-5} & 7.8 \times 10^{-4} & 2.2 \times 10^{-3} \\
     \mathbf{\frac{P(k \mid \text{ice})}{P(k \mid \text{steam})}} & \mathbf{8.9 \ (\gg 1)} & \mathbf{0.013 \ (\ll 1)} & \mathbf{1.36 \ (\approx 1)} \\
     \hline
     \end{array}$$
   - **The GloVe Objective Function:**
     $$\mathbf{J = \sum_{i,j=1}^V \mathbf{f(X_{ij})} \Big( \mathbf{w_i^T \tilde{w}_j + b_i + \tilde{b}_j \ - \ \ln X_{ij}} \Big)^2}$$
   - **The Weighting Function:**
     $$\mathbf{f(x) = \begin{cases} (x / x_{\max})^\alpha & \text{if } x < x_{\max} \\ 1 & \text{otherwise} \end{cases} \qquad (x_{\max}=100, \ \alpha=0.75)}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of GloVe training: (1) pass a sliding context window across entire text corpus to populate global co-occurrence count matrix X_ij, (2) compute log-counts ln(X_ij) and assign weights f(X_ij) using alpha=0.75 cutoff, (3) initialize word vector w_i, context vector w_tilde_j, and scalar biases b_i and b_tilde_j, (4) evaluate squared error: f(X_ij) * (w_i^T w_tilde_j + b_i + b_tilde_j - ln X_ij)^2 for all non-zero entries, (5) update parameters using AdaGrad and sum final embedding vectors: v_final = w_i + w_tilde_i!
3. **Slide 3 (`matching`):** Pair 4 GloVe concepts (Co-occurrence Count X_ij, Weighting Function f(X_ij), Log-Count ln(X_ij), Final Sum w_i + w_tilde_i) with their roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that dot product approximates ln(X_ij). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the GloVe probability ratio insight: Why did Pennington, Socher, and Manning formulate GloVe using the Ratio of Co-occurrence Probabilities $\frac{P(k|i)}{P(k|j)}$ rather than raw individual co-occurrence probabilities $P(k|i)$? (Raw co-occurrence probabilities $P(k|i)$ are noisy and heavily contaminated by non-discriminative background words (e.g. `"water"` occurs frequently with both `"ice"` and `"steam"`, failing to distinguish them); **the ratio of probabilities $\frac{P(k|\text{ice})}{P(k|\text{steam})}$ mathematically cancels out background noise (yielding $\approx 1$ for shared words like `"water"`), while producing large ratios $\gg 1$ for words unique to ice (`"solid"`) and tiny fractions $\ll 1$ for words unique to steam (`"gas"`)**, allowing linear vector differences $(w_i - w_j)$ to directly encode semantic properties).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "glove_global_cooccurrence_matrix_factorization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: GloVe Global Vector Factorization (Pennington et al. 2014)**\n• **The Co-occurrence Probability Ratio Matrix (Jurafsky *SLP* Chapter 6):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Ratio Computation} & k = \\text{\"solid\" (Ice Property)} & k = \\text{\"gas\" (Steam Property)} & k = \\text{\"water\" (Shared)} \\\\\n\\hline\n\\mathbf{\\frac{P(k \\mid \\text{ice})}{P(k \\mid \\text{steam})}} & \\mathbf{8.9 \\ (\\gg 1 \\implies \\text{Ice})} & \\mathbf{0.013 \\ (\\ll 1 \\implies \\text{Steam})} & \\mathbf{1.36 \\ (\\approx 1 \\implies \\text{Noise})} \\\\\n\\hline\n\\end{array}\n$$\n• **The GloVe Log-Bilinear Least-Squares Objective:**\n$$\n\\mathbf{J = \\sum_{i=1}^V \\sum_{j=1}^V \\mathbf{f(X_{ij})} \\Big( \\mathbf{w_i^T \\tilde{w}_j + b_i + \\tilde{b}_j \\ - \\ \\ln X_{ij}} \\Big)^2}\n$$\n• **The Truncated Weighting Function Invariant:**\n$$\n\\mathbf{f(x) = \\begin{cases} (x / x_{\\max})^\\alpha & \\text{if } x < x_{\\max} \\\\ 1 & \\text{otherwise} \\end{cases} \\qquad (x_{\\max} = 100, \\ \\alpha = 0.75)}\n$$\n• **Dual Memory Symmetry:** The final word vector is the sum $\\mathbf{v_i = w_i + \\tilde{w}_i}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed in GloVe word embedding training on a large corpus.",
      "orderItems": [
        "Scan the entire text corpus with a sliding window to construct the global sparse word-word co-occurrence matrix X_ij",
        "Compute the natural logarithm of all non-zero co-occurrence counts: ln(X_ij)",
        "Evaluate the weighting function f(X_ij) = min(1, (X_ij / 100)^0.75) for all non-zero cell pairs to prevent stopword dominance",
        "Perform gradient descent optimization (AdaGrad) to minimize the weighted squared loss J = sum f(X_ij) * (w_i^T * w_tilde_j + b_i + b_tilde_j - ln X_ij)^2",
        "Sum the learned main word vector and context word vector to produce the final robust embedding: v_final = w_i + w_tilde_i"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each GloVe Mathematical Construct to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Co-occurrence Matrix X_ij", "right": "Global count tensor recording how many times word j appears in the context window of word i" },
        { "left": "Weighting Function f(X_ij)", "right": "Sub-linear power scaling preventing frequent stopwords from dominating gradients while filtering rare noise" },
        { "left": "Log-Bilinear Target ln(X_ij)", "right": "The natural log of co-occurrence counts modeled as a linear inner product of embedding vectors" },
        { "left": "Ensemble Sum v = w + w_tilde", "right": "Combines main and context vectors to reduce variance and capture symmetric co-occurrence statistics" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In GloVe, the dot product w_i^T w_tilde_j + b_i + b_tilde_j is trained to approximate the natural log of the co-occurrence count ln ___.",
      "blankAnswer": "X_ij",
      "blankDistractors": ["P_i", "V_k", "D_ij"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did Pennington, Socher, and Manning formulate the GloVe model around the Ratio of Co-occurrence Probabilities (P(k|i) / P(k|j)) rather than raw co-occurrence probabilities P(k|i)?",
      "options": [
        { "text": "Raw co-occurrence probabilities P(k|i) are heavily distorted by common background words that appear frequently everywhere (e.g. 'water' co-occurs frequently with both 'ice' and 'steam', failing to differentiate them); taking the ratio P(k|ice) / P(k|steam) mathematically cancels out shared background noise (yielding ~1.0 for 'water'), while producing large ratios >> 1 for words specific to ice (e.g. 'solid') and tiny fractions << 1 for words specific to steam (e.g. 'gas'), enabling linear vector differences (w_ice - w_steam) to directly encode semantic properties", "isCorrect": true, "explanation": "Correct! This is the foundational philosophical and mathematical motivation for GloVe (Jeffrey Pennington, Richard Socher, Christopher Manning 2014 *GloVe: Global Vectors for Word Representation*, EMNLP). 1. **The Flaw of Raw Probabilities:** - If you look at $P(k|\\text{ice})$: - $P(\\text{solid}|\\text{ice}) = 0.00019$. - $P(\\text{water}|\\text{ice}) = 0.00300$. - A model looking only at raw probabilities would conclude that 'water' is $15\\times$ more important to 'ice' than 'solid' is! But 'water' is also $15\\times$ more important to 'steam' and 'coffee'. It tells us nothing about what makes ice unique. 2. **The Ratio of Probabilities Insight:** - Look at the ratio $\\frac{P(k|\\text{ice})}{P(k|\\text{steam})}$: - For $k=\\text{\"solid\"}$: $\\frac{0.00019}{0.000022} = \\mathbf{8.9 \\gg 1}$ (Strongly correlated with Ice!). - For $k=\\text{\"gas\"}$: $\\frac{0.000010}{0.00078} = \\mathbf{0.013 \\ll 1}$ (Strongly correlated with Steam!). - For $k=\\text{\"water\"}$: $\\frac{0.0030}{0.0022} = \\mathbf{1.36 \\approx 1}$ (Irrelevant shared baseline word!). - For $k=\\text{\"fashion\"}$: $\\frac{0.000017}{0.000018} = \\mathbf{0.96 \\approx 1}$ (Irrelevant unrelated word!). 3. **The Algebraic Derivation:** - GloVe forces the vector dot product to satisfy: $w_i^T \\tilde{w}_k - w_j^T \\tilde{w}_k = (w_i - w_j)^T \\tilde{w}_k = \\ln\\left(\\frac{P(k|i)}{P(k|j)}\right) = \\ln X_{ik} - \\ln X_{jk}$. - This guarantees that linear vector arithmetic ($w_i - w_j$) encodes pure semantic distinctions!" },
        { "text": "Because computing ratios eliminates all floating-point math", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because raw probabilities can only be computed on CPU hardware", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because GloVe cannot process positive numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
