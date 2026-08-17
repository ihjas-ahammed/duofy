# Key to Flow: Decision Trees and Random Forests (Gini/Entropy, Bagging, Subspace Sampling, & OOB Error)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Machine_Learning / Decision_Trees_and_Random_Forests`

---

## 📌 Core Concept & Mental Model
**Recursive Binary Partitioning, Information-Theoretic Splitting Metrics (Shannon Entropy vs Gini Impurity), Cost-Complexity Pruning ($R_\alpha(T)$), Bootstrap Aggregation (Bagging), Feature Subspace Randomization ($m = \sqrt{p}$), and Out-of-Bag (OOB $\approx 36.8\%$) Validation** govern non-parametric tree models and ensemble learning architectures (Leo Breiman et al. 1984 CART; Ross Quinlan 1986 ID3 / 1993 C4.5; Leo Breiman 2001 Random Forests; Hastie, Tibshirani, Friedman *ESL* Chapters 9.2 & 15):
* **1. Decision Tree Splitting Metrics:**
  - **Shannon Entropy (Information Disorder):**
    $$\mathbf{H(S) = -\sum_{i=1}^K p_i \log_2(p_i)}$$
  - **Information Gain (ID3 / C4.5):**
    $$\mathbf{IG(S, A) = H(S) \ - \ \sum_{v \in \text{Values}(A)} \frac{|S_v|}{|S|} H(S_v)}$$
  - **Gini Impurity (CART - Default in Scikit-Learn):**
    $$\mathbf{\text{Gini}(S) = 1 - \sum_{i=1}^K p_i^2 = \sum_{i \ne j} p_i p_j}$$
    - Faster in practice because it avoids computationally expensive $\log_2$ evaluations.
    - Pure node ($p_1 = 1 \implies \text{Gini} = 0$). Maximum impurity in binary split ($p_1 = 0.5 \implies \text{Gini} = 0.5$).
* **2. Tree Pruning & Regularization:**
  - Deep unpruned trees have **low bias, but extremely high variance (severe overfitting)**.
  - **Cost-Complexity Pruning (Weakest Link Pruning):**
    $$\mathbf{R_\alpha(T) = R(T) \ + \ \alpha |T|}$$
    - $R(T)$: Training error / total leaf impurity.
    - $|T|$: Number of terminal leaf nodes (tree complexity penalty).
    - $\alpha \ge 0$: Tuning parameter (selected via cross-validation).
* **3. Random Forests: Bagging + Feature Subspace Sampling (Breiman 2001):**
  - **Bootstrap Aggregating (Bagging):**
    - Draw $B$ independent bootstrap training sets of size $N$ sampled **with replacement** from the original dataset.
    - Train an unpruned deep decision tree $T_b$ on each bootstrap sample.
    - Aggregate predictions: **Majority voting** for classification; **arithmetic mean** $\frac{1}{B}\sum T_b(x)$ for regression.
  - **Feature Subspace Sampling (Tree Decorrelation):**
    - At every split in every tree, randomly select a subset of $\mathbf{m = \lfloor \sqrt{p} \rfloor}$ features (for classification) or $\mathbf{m = \lfloor p/3 \rfloor}$ (for regression).
    - *Why Decorrelate?* If one feature is extremely dominant, standard bagging trees all pick that feature at the root, making trees highly correlated ($\text{Var}(\bar{T}) = \rho \sigma^2 + \frac{1-\rho}{B}\sigma^2$). Random feature sampling forces trees to explore alternative features, driving correlation $\rho \to 0$ and drastically slashing ensemble variance!
* **4. Out-of-Bag (OOB) Error & Feature Importance:**
  - **The 36.8% Invariant:** Probability a specific sample is NOT picked in a bootstrap sample of size $N$:
    $$\mathbf{P(\text{Unselected}) = \left(1 - \frac{1}{N}\right)^N \xrightarrow{N \to \infty} \frac{1}{e} \approx \mathbf{0.368 \ (36.8\%)}}$$
  - **Free Cross-Validation:** Every tree is tested on its unseen ~36.8% OOB samples; aggregating these gives an unbiased out-of-bag validation score without needing a separate test set!
  - **Feature Importance:**
    - **Mean Decrease in Impurity (MDI):** Total Gini reduction accumulated across all splits on feature $j$.
    - **Permutation Importance:** Performance drop when feature $j$'s values are randomly shuffled in OOB samples.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Tree-to-Forest Architectural Ladder
* Single Split $\to$ Entropy / Information Gain / Gini Impurity.
* Tree Regularization $\to$ Pre-Pruning (Depth) + Post-Pruning (Cost-Complexity $\alpha |T|$).
* Ensemble Bagging $\to$ Bootstrap with replacement $\to$ Variance Reduction.
* Random Forest $\to$ Feature Subsampling ($m=\sqrt{p}$) $\to$ Decorrelation $\to$ OOB ($36.8\%$).

### 2. Top Recommended Resources
* **The Definitive Text:** *The Elements of Statistical Learning (ESL)* (Trevor Hastie, Robert Tibshirani, Jerome Friedman), Chapters 9.2 (Tree-Based Methods) & 15 (Random Forests).
* **Machine Learning Classic:** *Classification and Regression Trees (CART)* (Leo Breiman, Jerome Friedman, Richard Olshen, Charles Stone, Wadsworth).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute Gini Impurity and Information Gain for a binary split?
- [ ] Can you explain why deep unpruned trees have high variance and how Bagging reduces it?
- [ ] Can you prove why $P(\text{OOB}) \to 1/e \approx 36.8\%$ as $N \to \infty$?
- [ ] Can you explain why random feature subsampling ($m=\sqrt{p}$) decorrelates trees?
