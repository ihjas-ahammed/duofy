# Key to Flow: Word Embeddings (Word2Vec, SGNS, GloVe Co-occurrence, & FastText)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Word_Embeddings_Word2Vec_GloVe`

---

## 📌 Core Concept & Mental Model
**The Distributional Hypothesis (Firth 1957 "You shall know a word by the company it keeps"), Continuous Vector Space Projections, Predictive Local Window Embeddings (Word2Vec Skip-Gram vs CBOW), Noise-Contrastive Negative Sampling ($P(w)^{3/4}$), Global Log-Bilinear Matrix Factorization (GloVe), Vector Space Linear Analogy Arithmetic ($\vec{v}_{\text{King}} - \vec{v}_{\text{Man}} + \vec{v}_{\text{Woman}} \approx \vec{v}_{\text{Queen}}$), and Subword Character $n$-gram Embeddings (FastText)** govern distributed representation learning and dense semantic vector geometry in natural language processing (Tomas Mikolov et al. 2013; Jeffrey Pennington et al. 2014 GloVe; Piotr Bojanowski et al. 2017 FastText; Jurafsky & Martin *SLP* Chapter 6):
* **1. Word2Vec: CBOW vs Skip-Gram (Mikolov et al. 2013):**
  - **Continuous Bag-of-Words (CBOW):** Predicts center target word $w_t$ given context words within sliding window $C = \{w_{t-c}, \dots, w_{t+c}\}$ (Averages context vectors; faster on frequent words).
  - **Continuous Skip-Gram:** Predicts context words $w_{t+j}$ given single center target word $w_t$ (Superior on rare words and smaller corpora).
  - **Negative Sampling (SGNS - Skip-Gram with Negative Sampling):**
    - Avoids computing the catastrophic $\mathcal{O}(|V|)$ full vocabulary Softmax denominator by converting multi-class prediction into binary logistic regressions:
      $$\mathbf{\mathcal{L}_{\text{SGNS}} = \mathbf{\log \sigma(v'_{w_O}{}^T v_{w_I})} \ + \ \sum_{i=1}^K \mathbb{E}_{w_i \sim P_n(w)}\Big[ \mathbf{\log \sigma(-v'_{w_i}{}^T v_{w_I})} \Big]}$$
    - **The $3/4$ Power Unigram Distribution:** Negative noise words are sampled from $\mathbf{P_n(w) = \frac{U(w)^{3/4}}{\sum U(w')^{3/4}}}$, which elevates rare words relative to stop words like `"the"`.
* **2. GloVe: Global Vectors for Word Representation (Pennington et al. 2014):**
  - Combines local context windows with global matrix factorization statistics.
  - Constructs global word-word co-occurrence matrix $X$, where $X_{ij}$ counts how often word $j$ appears in the context of word $i$.
  - **The Log-Bilinear Weighted Least-Squares Objective:**
    $$\mathbf{J = \sum_{i,j=1}^V f(X_{ij}) \Big( \mathbf{w_i^T \tilde{w}_j + b_i + \tilde{b}_j \ - \ \ln X_{ij}} \Big)^2}$$
  - **The Truncated Weighting Function:**
    $$\mathbf{f(x) = \begin{cases} (x / x_{\max})^\alpha & \text{if } x < x_{\max} \\ 1 & \text{otherwise} \end{cases} \qquad (\text{typically } x_{\max}=100, \ \alpha=0.75)}$$
    - Prevents extremely frequent stopwords (`"the"`, `"and"`) from dominating the loss function.
* **3. Vector Space Semantics & Linear Analogies:**
  - **Cosine Similarity:** $\mathbf{\text{CosineSim}(u, v) = \frac{u \cdot v}{\|u\|_2 \|v\|_2} \in [-1, +1]}$.
  - **Linear Subspace Composition:** The vector displacement between words encodes semantic relations:
    $$\mathbf{\vec{v}_{\text{King}} - \vec{v}_{\text{Man}} \approx \vec{v}_{\text{Queen}} - \vec{v}_{\text{Woman}} \implies \mathbf{\vec{v}_{\text{King}} - \vec{v}_{\text{Man}} + \vec{v}_{\text{Woman}} \approx \vec{v}_{\text{Queen}}}}$$
* **4. FastText (Bojanowski et al. 2017 / Facebook AI):**
  - Represents each word as a bag of **character $n$-grams** (e.g. for `"where"` with $n=3$: `<wh`, `whe`, `her`, `ere`, `re>`, plus special whole word `<where>`).
  - Word vector is the sum of its $n$-gram embeddings: $\mathbf{v_w = \sum_{g \in \mathcal{G}_w} z_g}$.
  - *Invariant:* Allows model to generate meaningful embeddings for **Out-of-Vocabulary words and misspelled words** based on subword morphology.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Distributed Semantics Progression
* Sparse Vectors $\to$ One-Hot ($|V|$-dim) $\to$ Curse of Dimensionality / Zero Similarity.
* Dense Predictive $\to$ Word2Vec (CBOW vs Skip-Gram + Negative Sampling $P^{3/4}$).
* Dense Matrix Factorization $\to$ GloVe ($w_i^T \tilde{w}_j \approx \ln X_{ij}$).
* Geometry $\to$ Cosine Similarity + Linear Vector Analogies ($K - M + W = Q$).
* Subword Robustness $\to$ FastText Character $n$-grams.

### 2. Top Recommended Resources
* **The Definitive NLP Text:** *Speech and Language Processing* (Dan Jurafsky & James H. Martin), Chapter 6 (Vector Semantics and Embeddings).
* **Foundational Papers:** *Efficient Estimation of Word Representations in Vector Space* (Mikolov et al. 2013); *GloVe: Global Vectors for Word Representation* (Pennington et al. 2014).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you contrast CBOW (predict target from context) vs Skip-Gram (predict context from target)?
- [ ] Can you explain why Negative Sampling uses the $U(w)^{3/4}$ unigram exponent?
- [ ] Can you derive the GloVe objective $w_i^T \tilde{w}_j + b_i + \tilde{b}_j \approx \ln X_{ij}$?
- [ ] Can you explain how FastText computes embeddings for out-of-vocabulary words using $n$-grams?
