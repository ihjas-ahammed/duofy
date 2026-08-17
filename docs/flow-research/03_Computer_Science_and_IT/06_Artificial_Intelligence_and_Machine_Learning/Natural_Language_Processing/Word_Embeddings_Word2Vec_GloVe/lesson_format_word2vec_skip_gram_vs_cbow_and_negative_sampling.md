# Duofy Reusable Lesson Format: Word2Vec (Skip-Gram vs CBOW and Negative Sampling)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Word_Embeddings_Word2Vec_GloVe`  
**Lesson Format Type:** `word2vec_skip_gram_vs_cbow_and_negative_sampling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the shallow neural network predictive architectures, Softmax denominator bottlenecks, and Noise-Contrastive Negative Sampling formulations of Word2Vec (Tomas Mikolov et al. 2013, *Distributed Representations of Words and Phrases and their Compositionality*, NeurIPS; Jurafsky & Martin *SLP* Chapter 6): contrast the **Continuous Bag-of-Words (CBOW)** architecture (predicting center target word $w_t$ given context window $\{w_{t-c}, \dots, w_{t+c}\}$) with the **Continuous Skip-Gram** architecture (predicting surrounding context words given center word $w_t$), analyze why standard full-vocabulary Softmax normalization ($\frac{e^{v'_{w_O}{}^T v_{w_I}}}{\sum_{w \in V} e^{v'_w{}^T v_{w_I}}}$) is computationally intractable with cost $\mathcal{O}(|V|)$ per word, master the **Skip-Gram Negative Sampling (SGNS) Binary Logistic Objective ($\mathbf{\mathcal{L}_{\text{SGNS}} = \log \sigma(v'_{w_O}{}^T v_{w_I}) + \sum_{i=1}^K \mathbb{E}_{w_i \sim P_n(w)}[\log \sigma(-v'_{w_i}{}^T v_{w_I})]}$)**, and prove why sampling $K$ negative noise words from the **$3/4$ Power Unigram Distribution ($\mathbf{P_n(w) \propto U(w)^{3/4}}$)** provides the optimal balance between frequent stopwords and rare semantic terms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CBOW vs Skip-Gram Architectures, SGNS Binary Logistic Loss Formula, & $U(w)^{3/4}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Training Iteration of Word2Vec Skip-Gram with Negative Sampling Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Word2Vec Model Component / Sampling Variable & Functional Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Word2Vec Architecture That Predicts Context Words from a Single Center Target Word is the ___-Gram Model (Skip) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis of Why the Unigram Distribution Is Raised to the 3/4 Power in Negative Sampling Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Word2Vec & SGNS (Mikolov et al. 2013; Jurafsky & Martin Ch 6):
   - **CBOW vs Skip-Gram:**
     - **CBOW:** $\text{Context } \{w_{t-2}, w_{t-1}, w_{t+1}, w_{t+2}\} \xrightarrow{\text{Average}} \text{Predict Target } w_t$.
     - **Skip-Gram:** $\text{Target } w_t \xrightarrow{\text{Predict}} \text{Context Words } \{w_{t-2}, w_{t-1}, w_{t+1}, w_{t+2}\}$.
   - **The Negative Sampling (SGNS) Objective:**
     $$\mathbf{\mathcal{L}_{\text{SGNS}} = \mathbf{\log \sigma(v'_{w_O}{}^T v_{w_I})} \ + \ \sum_{i=1}^K \mathbf{\log \sigma(-v'_{w_i}{}^T v_{w_I})}}$$
     - Replaces $\mathcal{O}(|V|)$ full softmax with $K+1$ binary logistic classifications!
   - **The $3/4$ Power Unigram Noise Distribution:**
     $$\mathbf{P_n(w) = \frac{\text{count}(w)^{3/4}}{\sum_{w'} \text{count}(w')^{3/4}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of SGNS training on window ("the", "quick", "brown", "fox"): (1) select target center word w_I = "quick" and true positive context word w_O = "fox", (2) draw K negative noise words (e.g. "car", "apple", "sky") from unigram distribution P_n(w) proportional to count(w)^0.75, (3) compute dot product between target vector and true context vector: log sigma(v'_fox^T v_quick), (4) compute dot products between target vector and K negative vectors: sum log sigma(-v'_k^T v_quick), (5) compute loss gradient and update input and output embedding vectors via Stochastic Gradient Descent!
3. **Slide 3 (`matching`):** Pair 4 concepts (Continuous Skip-Gram, CBOW, Negative Sampling, 3/4 Power Distribution) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that predicting context from center is Skip-Gram. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why unigram exponent is $3/4$: Why does Word2Vec Negative Sampling (Mikolov et al. 2013) sample negative words from the Unigram distribution raised to the $3/4$ power ($P(w) \propto U(w)^{0.75}$) rather than the raw unigram frequency distribution ($U(w)$)? (In natural text, raw word frequencies follow Zipf's law where top stopwords (`"the"`, `"a"`, `"is"`) account for over $30\%$ of all words; sampling from the raw distribution $U(w)$ would cause the model to draw **almost exclusively stopwords as negative samples**, while rare semantic words (e.g. `"zebra"`, `"molecule"`) would almost never be sampled; **raising the probability to the $3/4$ exponent ($0.75$) mathematically compresses the dynamic range, slightly diminishing the probability of ubiquitous stopwords while boosting the sampling probability of rare words by $3\times$ to $5\times$**, ensuring balanced semantic discrimination across the entire vocabulary).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "word2vec_skip_gram_vs_cbow_and_negative_sampling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Word2Vec \\& Negative Sampling (Mikolov et al. 2013)**\n• **Continuous Bag-of-Words (CBOW) vs Skip-Gram (Jurafsky *SLP* 6):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Architecture} & \\textbf{Prediction Direction} & \\textbf{Training Speed} & \\textbf{Best Performance Domain} \\\\\n\\hline\n\\mathbf{\\text{CBOW}} & \\text{Context } \\{w_{t-c}, \\dots, w_{t+c}\\} \\to \\text{Center } w_t & \\mathbf{\\text{Faster}} & \\text{Large datasets; frequent words} \\\\\n\\mathbf{\\text{Skip-Gram}} & \\mathbf{\\text{Center } w_t \\to \\text{Context } \\{w_{t+j}\\}} & \\text{Slower} & \\mathbf{\\text{Small datasets; rare words}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Negative Sampling Objective (SGNS):**\n$$\n\\mathbf{\\mathcal{L}_{\\text{SGNS}} = \\mathbf{\\ln \\sigma(v'_{w_O}{}^T v_{w_I})} \\ + \\ \\sum_{i=1}^K \\mathbf{\\ln \\sigma(-v'_{w_i}{}^T v_{w_I})}}\n$$\n• **The \\(3/4\\) Power Distribution Invariant:** Sample noise words from $\\mathbf{P_n(w) \\propto U(w)^{3/4}}$, which **amplifies rare words relative to ubiquitous stopwords**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during a single Skip-Gram with Negative Sampling (SGNS) optimization step.",
      "orderItems": [
        "Select a center target word w_I and an actual observed context word w_O from a sliding local text window",
        "Sample K negative noise words (e.g. w_1, ..., w_K) from the vocabulary according to the smoothed unigram distribution P_n(w) proportional to count(w)^0.75",
        "Compute the positive pair similarity logit: log sigma((v'_wO)^T * v_wI), pulling the true context embedding closer to the target embedding",
        "Compute the negative pair repulsion logits: sum_{i=1}^K log sigma(-(v'_wi)^T * v_wI), pushing the K random noise embeddings away",
        "Sum all binary logistic loss terms and update input and output embedding weight vectors via Stochastic Gradient Descent"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Word2Vec Algorithmic Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Skip-Gram Architecture", "right": "Predicts surrounding context words given a single center target word, excelling on rare vocabulary" },
        { "left": "CBOW Architecture", "right": "Averages context word vectors to predict the missing center target word with high computational speed" },
        { "left": "Negative Sampling (SGNS)", "right": "Approximates full vocabulary softmax by training K+1 binary logistic classifiers per window step" },
        { "left": "Unigram 3/4 Smoothing", "right": "Probability exponent mathematically boosting the selection chance of rare words during negative sampling" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Word2Vec model that predicts surrounding context words given a center target word is the ___-Gram model.",
      "blankAnswer": "skip",
      "blankDistractors": ["cbow", "n-gram", "fast"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Word2Vec Negative Sampling (Mikolov et al. NeurIPS 2013) sample negative noise words from the unigram frequency distribution raised to the 3/4 power (P(w) proportional to U(w)^0.75) rather than the raw unigram distribution U(w)?",
      "options": [
        { "text": "In natural text, raw word frequencies follow Zipf's law where top stopwords (e.g. 'the', 'is', 'of') account for a massive percentage of total occurrences; sampling from raw unigram frequencies would cause the model to draw almost exclusively stopwords as negative examples while rare semantic words would virtually never be sampled; raising probabilities to the 3/4 power compresses the frequency disparity, slightly suppressing frequent stopwords while boosting the sampling probability of rare words by 3x to 5x to ensure balanced semantic discrimination", "isCorrect": true, "explanation": "Correct! This is one of the most famous empirical and statistical discoveries in word embedding research (Tomas Mikolov et al. 2013; Jurafsky & Martin *Speech and Language Processing* Section 6.8). 1. **Zipf's Law in Natural Language:** - In a 1-billion-word corpus: - The word `'the'` appears $50,000,000\\text{ times}$ ($5\\%$ of corpus). - The word `'aardvark'` appears $10\\text{ times}$ ($0.000001\\%$ of corpus). - Ratio of raw frequencies: $\\frac{50,000,000}{10} = \\mathbf{5,000,000 : 1}$! 2. **What Happens with Raw $U(w)$ Sampling:** - Out of every 5 million negative samples drawn, `'the'` is picked 5 million times, and `'aardvark'` is picked ONCE. - The model learns to push away `'the'`, but never learns anything about `'aardvark'`! 3. **The $3/4$ Power Compression:** - $(50,000,000)^{0.75} \\approx 595,000$. - $(10)^{0.75} \\approx 5.62$. - New ratio: $\\frac{595,000}{5.62} \\approx \\mathbf{105,800 : 1}$ (a **$50\\times$ boost in relative sampling probability** for rare words!). - Rare words are sampled frequently enough to build rich, accurate geometric vector embeddings." },
        { "text": "Because fractions with exponent 3/4 run faster on GPUs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the English alphabet contains 26 letters and 26 * 3/4 is an integer", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 3/4 eliminates all negative numbers from the loss gradient", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
