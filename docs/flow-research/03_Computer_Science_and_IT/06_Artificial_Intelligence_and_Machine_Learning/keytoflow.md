# Key to Flow: Artificial Intelligence and Machine Learning

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning`

---

## 📌 Core Concept & Mental Model
AI and Machine Learning build systems that learn patterns from data to perform tasks without explicit rule programming. 

$$\text{Data} + \text{Model Family} + \text{Loss Function } L(\theta) \xrightarrow{\text{Optimization (SGD)}} \text{Trained Model } \theta^*$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Machine Learning Hierarchy
* **Supervised Learning:**
  * **Regression:** Linear Regression, Ridge/Lasso ($L_1/L_2$ regularization).
  * **Classification:** Logistic Regression, Decision Trees, Random Forests, Gradient Boosted Trees (XGBoost), Support Vector Machines (SVM).
* **Unsupervised Learning:** Clustering (K-Means, DBSCAN), Dimensionality Reduction (PCA, t-SNE).
* **Deep Learning (Neural Networks):**
  * **MLP & Backpropagation:** Chain rule gradient calculation $\nabla_\theta L$.
  * **CNNs:** Convolution, Pooling, Feature maps (Image processing).
  * **RNNs / LSTMs / GRUs:** Sequential data processing.
  * **Transformers & Attention:** Scaled Dot-Product Attention $\text{Softmax}\left(\frac{Q K^T}{\sqrt{d_k}}\right) V$. Multi-Head Self-Attention.
  * **Generative Models:** VAEs, GANs, Diffusion Models, LLMs (Autoregressive language modeling).

### 2. Top Recommended Resources
* **The AI Bible:** *Artificial Intelligence: A Modern Approach (AIMA)* by Russell & Norvig.
* **Deep Learning Classic:** *Deep Learning* by Ian Goodfellow, Yoshua Bengio, Aaron Courville (Free online).
* **Practical Machine Learning:** *Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow* by Aurélien Géron.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive the Backpropagation equations for a 2-layer Neural Network?
- [ ] Can you compute Self-Attention matrices given $Q, K, V$?
- [ ] Can you evaluate models using Precision, Recall, F1-Score, and ROC-AUC curves?
- [ ] Can you diagnose Overfitting vs Underfitting using Learning Curves and apply Regularization?
