# Key to Flow: Large Language Models & Prompt Engineering (Alignment, LoRA, Prompting, & RAG)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Large_Language_Models_LLMs_and_Prompt_Eng`

---

## 📌 Core Concept & Mental Model
**Autoregressive Pre-training & Chinchilla Scaling Laws, Alignment Optimization (RLHF with PPO vs Direct Preference Optimization DPO), Low-Rank Adaptation Matrix Decomposition (LoRA $\Delta W = \frac{\alpha}{r} B A$), Structured Reasoning In-Context Prompts (Chain-of-Thought CoT, Tree-of-Thoughts ToT, ReAct Agent Loops), and Grounded Vector Retrieval (Retrieval-Augmented Generation RAG)** govern modern foundation LLMs and enterprise AI systems (Tom Brown et al. 2020 GPT-3; Long Ouyang et al. 2022 InstructGPT; Rafael Rafailov et al. 2023 DPO; Edward Hu et al. 2021 LoRA; Jason Wei et al. 2022 CoT; Shunyu Yao et al. 2022 ReAct; Patrick Lewis et al. 2020 RAG):
* **1. Alignment: RLHF (PPO) vs DPO (Rafailov et al. 2023):**
  - **RLHF (InstructGPT):** 3-Stage pipeline: (1) SFT, (2) Reward Model training on pairwise human preferences ($r_\psi(x, y)$), (3) PPO reinforcement learning maximizing $\mathbb{E}[r_\psi(x, y)] - \beta D_{KL}(\pi_\theta \parallel \pi_{\text{ref}})$.
  - **Direct Preference Optimization (DPO):** Derives an analytical closed-form mapping directly from the Bradley-Terry preference model to the optimal policy $\pi_\theta$, **eliminating the separate reward model, value model, and complex PPO loop entirely**:
    $$\mathbf{\mathcal{L}_{\text{DPO}}(\theta; \pi_{\text{ref}}) = \mathbf{-\mathbb{E}_{(x, y_w, y_l) \sim \mathcal{D}}\left[ \ln \sigma\left( \beta \ln \frac{\pi_\theta(y_w|x)}{\pi_{\text{ref}}(y_w|x)} \ - \ \beta \ln \frac{\pi_\theta(y_l|x)}{\pi_{\text{ref}}(y_l|x)} \right) \right]}}$$
    - $y_w$: Chosen (winning) response.
    - $y_l$: Rejected (losing) response.
    - $\beta$: Temperature parameter controlling KL regularization strength.
* **2. Parameter-Efficient Fine-Tuning (PEFT / LoRA - Hu et al. 2021):**
  - The Intrinsic Rank Hypothesis: Weight updates $\Delta W$ reside in a low-dimensional manifold ($r \ll d$).
  - Freezes base model weights $W_0 \in \mathbb{R}^{d \times k}$ and decomposes the update into two low-rank matrices $B \in \mathbb{R}^{d \times r}$ (initialized to 0) and $A \in \mathbb{R}^{r \times k}$ (Gaussian initialized):
    $$\mathbf{h = W_0 x \ + \ \Delta W x = \mathbf{W_0 x \ + \ \frac{\alpha}{r} B A x}}$$
  - **Zero Inference Overhead:** Weights merge into base model: $\mathbf{W_{\text{merged}} = W_0 + \frac{\alpha}{r} B A}$.
* **3. Advanced Prompt Engineering & Reasoning Frameworks:**
  - **Zero-Shot / Few-Shot Chain-of-Thought (CoT - Wei et al. 2022 / Kojima et al. 2022):** Appends *"Let's think step by step"* to force the model to emit intermediate computational tokens before generating final answer, unlocking Transformer working memory.
  - **ReAct (Reason + Act - Yao et al. 2022):** Synergizes reasoning and action generation in an iterative loop: `Thought` $\to$ `Action[Tool(query)]` $\to$ `Observation` $\to$ `Final Answer`.
* **4. Retrieval-Augmented Generation (RAG - Lewis et al. 2020):**
  - Mitigates hallucinations and knowledge cutoffs by injecting external grounded context into prompt:
  - Pipeline: **Chunking $\to$ Dense Vector Embeddings $\to$ HNSW Vector Database Search $\to$ Cross-Encoder Re-ranking $\to$ Augmented Prompt Generation**.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Post-Training & Prompting Stack
* Pre-training $\to$ Next-Token Prediction $\mathcal{L} = -\sum \log P(x_t | x_{<t})$.
* Fine-Tuning $\to$ Full SFT vs Parameter-Efficient LoRA ($W_0 + \frac{\alpha}{r} B A$).
* Alignment $\to$ RLHF (Reward + PPO) vs Direct Preference Optimization (DPO).
* In-Context Reasoning $\to$ CoT / Few-Shot / ReAct Agentic Tools.
* Knowledge Grounding $\to$ Dense Vector RAG + Cross-Encoder Reranker.

### 2. Top Recommended Resources
* **The SFT/RLHF Paper:** *Training language models to follow instructions with human feedback* (Ouyang et al., NeurIPS 2022).
* **The DPO Paper:** *Direct Preference Optimization: Your Language Model is Secretly a Reward Model* (Rafailov et al., NeurIPS 2023).
* **The LoRA Paper:** *LoRA: Low-Rank Adaptation of Large Language Models* (Hu et al., ICLR 2022).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you write the DPO loss equation and explain why it eliminates the reward model?
- [ ] Can you trace parameter savings for LoRA on a $4096 \times 4096$ matrix with rank $r=8$?
- [ ] Can you explain why Chain-of-Thought (CoT) prompting elicits multi-step reasoning?
- [ ] Can you diagram the full RAG pipeline from document chunking to vector database retrieval and generation?
