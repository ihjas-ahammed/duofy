# Duofy Reusable Lesson Format: Vector Semantics (Cosine Similarity and Analogical Reasoning)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Word_Embeddings_Word2Vec_GloVe`  
**Lesson Format Type:** `vector_semantics_cosine_similarity_and_analogical_reasoning`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through vector space geometry, angular distance metrics, and linear semantic offset arithmetic in word embedding spaces (Tomas Mikolov et al. 2013; Jurafsky & Martin *SLP* Chapter 6.3–6.5): analyze why Euclidean distance ($\|u - v\|_2$) is distorted by word frequency (as frequent words have longer vector norms), master **Cosine Similarity ($\mathbf{\text{CosineSim}(u, v) = \frac{u \cdot v}{\|u\|_2 \|v\|_2} = \cos(\theta)}$)** which measures directional alignment independent of vector magnitude, derive the **Linear Vector Analogy Formulation ($\mathbf{\vec{v}_{\text{King}} - \vec{v}_{\text{Man}} + \vec{v}_{\text{Woman}} \approx \vec{v}_{\text{Queen}}}$)**, solve relational analogies using **3CosAdd ($\mathbf{\arg\max_{x \notin \{a, a^*, b\}} \text{CosineSim}(x, b + a^* - a)}$)** and **3CosMul**, and evaluate both the power and societal bias hazards (gender/racial bias in vector subspaces) of analogical embeddings.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cosine Similarity Formula, Linear Vector Analogy Diagram $\vec{v}_b - \vec{v}_a + \vec{v}_{a^*}$, & 3CosAdd Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Evaluation of a 4-Word Semantic Analogy Vector Search Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Vector Metric / Geometric Operation & Semantic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Angular Metric Measuring Directional Alignment Independent of Vector Magnitude is ___ Similarity (Cosine) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Linear Vector Offsets (e.g. King - Man + Woman = Queen) Naturally Emerge in Dense Embeddings Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Vector Semantics & Analogies (Mikolov 2013; Jurafsky *SLP* Ch 6):
   - **Cosine Similarity Equation:**
     $$\mathbf{\text{CosineSim}(u, v) = \frac{\mathbf{u \cdot v}}{\mathbf{\|u\|_2 \|v\|_2}} = \frac{\sum_{i=1}^d u_i v_i}{\sqrt{\sum_{i=1}^d u_i^2} \sqrt{\sum_{i=1}^d v_i^2}} \qquad \in [-1, +1]}$$
   - **The Linear Analogy Principle:**
     $$\mathbf{\vec{v}_{\text{Paris}} - \vec{v}_{\text{France}} \approx \vec{v}_{\text{Rome}} - \vec{v}_{\text{Italy}} \implies \mathbf{\vec{v}_{\text{Capital\_Of}}}}$$
     $$\mathbf{\vec{v}_{\text{King}} - \vec{v}_{\text{Man}} + \vec{v}_{\text{Woman}} \approx \mathbf{\vec{v}_{\text{Queen}}}}$$
   - **The 3CosAdd Retrieval Query:**
     $$\mathbf{\hat{w} = \arg\max_{x \in V \setminus \{a, a^*, b\}} \text{CosineSim}\big(x, \ \vec{v}_b + \vec{v}_{a^*} - \vec{v}_a\big)}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of vector analogy query "Athens is to Greece as Madrid is to [?]": (1) extract pre-trained normalized embeddings for "Athens" (v_a), "Greece" (v_a*), and "Madrid" (v_b), (2) compute country-capital relational vector offset: v_offset = v_a* - v_a = v_Greece - v_Athens, (3) add relational offset to target query word vector: v_target = v_b + v_offset = v_Madrid + (v_Greece - v_Athens), (4) compute cosine similarity between v_target and every candidate word x in the vocabulary, (5) exclude input words from candidate pool and return highest similarity match: "Spain"!
3. **Slide 3 (`matching`):** Pair 4 concepts (Cosine Similarity, 3CosAdd Analogy, Semantic Vector Offset, Gender/Relational Direction) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that angular similarity is Cosine similarity. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why linear vector analogies emerge: Why do dense word embedding models (such as Word2Vec and GloVe) naturally produce linear vector offsets where adding or subtracting word vectors solves complex semantic analogies (such as $\vec{v}_{\text{King}} - \vec{v}_{\text{Man}} + \vec{v}_{\text{Woman}} \approx \vec{v}_{\text{Queen}}$)? (The training objectives (SGNS dot products and GloVe log-ratios) force word vectors to encode conditional probability distributions over context words; because relationships like gender ($[\text{King} \to \text{Queen}]$ and $[\text{Man} \to \text{Woman}]$) or capital cities ($[\text{Paris} \to \text{France}]$) share **identical differences in their contextual word co-occurrence statistics**, the optimization algorithm maps these consistent statistical shifts to **parallel, constant linear directional vectors (displacement vectors) across the embedding space**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vector_semantics_cosine_similarity_and_analogical_reasoning",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Vector Semantics \\& Linear Analogies (Mikolov 2013)**\n• **Cosine Similarity Metric (Jurafsky \\& Martin *SLP* Chapter 6):**\n$$\n\\mathbf{\\text{CosineSim}(u, v) = \\frac{\\mathbf{u \\cdot v}}{\\mathbf{\\|u\\|_2 \\|v\\|_2}} = \\frac{\\sum_{i=1}^d u_i v_i}{\\sqrt{\\sum_{i=1}^d u_i^2} \\sqrt{\\sum_{i=1}^d v_i^2}} \\qquad \\in [-1, +1]}\n$$\n• **The Linear Vector Analogy Formula:**\n$$\n\\mathbf{\\vec{v}_{\\text{King}} - \\vec{v}_{\\text{Man}} + \\vec{v}_{\\text{Woman}} \\approx \\mathbf{\\vec{v}_{\\text{Queen}}}}\n$$\n• **The 3CosAdd Retrieval Query:**\n$$\n\\mathbf{w^* = \\arg\\max_{x \\in V \\setminus \\{a, a^*, b\\}} \\text{CosineSim}\\big(x, \\ \\mathbf{\\vec{v}_b + \\vec{v}_{a^*} - \\vec{v}_a}\\big)}\n$$\n• **The Geometry Invariant:** Semantic relationships (gender, tense, capital-country) are **parallel translation vectors** in high-dimensional space!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to solve a word analogy query (Athens : Greece :: Madrid : ?) using 3CosAdd vector arithmetic.",
      "orderItems": [
        "Retrieve the normalized dense embedding vectors for base terms: v_Athens, v_Greece, and query term v_Madrid",
        "Compute the capital-to-country relational displacement vector: v_relation = v_Greece - v_Athens",
        "Add the displacement vector to the query vector to formulate the target candidate vector: v_target = v_Madrid + v_relation",
        "Compute Cosine Similarity between v_target and all normalized word vectors across the entire model vocabulary",
        "Filter out the input query words (Athens, Greece, Madrid) and return the maximum similarity vector match: 'Spain'"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Vector Semantics Construct to its exact Mathematical Identity.",
      "matchPairs": [
        { "left": "Cosine Similarity", "right": "Normalized dot product measuring the cosine of the angle between two vectors independent of magnitude" },
        { "left": "Relational Vector Offset (b - a)", "right": "Linear spatial displacement vector encoding semantic relationships such as tense, gender, or capital" },
        { "left": "3CosAdd Analogy Formula", "right": "Vector retrieval objective finding argmax CosineSim(x, v_b + v_a* - v_a) over vocabulary" },
        { "left": "Embedding Subspace Bias", "right": "Systemic societal stereotypes (e.g. Doctor-Nurse gender bias) encoded as unwanted linear directions" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The metric measuring the angular orientation between two word embedding vectors is ___ similarity.",
      "blankAnswer": "cosine",
      "blankDistractors": ["euclidean", "manhattan", "minkowski"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why do dense word embedding models (such as Word2Vec and GloVe) naturally develop linear vector arithmetic capabilities where subtracting and adding vectors solves semantic analogies (such as King - Man + Woman = Queen)?",
      "options": [
        { "text": "The training objectives force word vectors to encode conditional probability distributions over contextual vocabulary; because grammatical and semantic relationships (e.g. male-to-female gender shifts or capital-to-country links) correspond to consistent multiplicative shifts in context word co-occurrence ratios across the corpus, the optimization solver maps these consistent statistical differences to parallel linear spatial displacement vectors with nearly identical magnitude and direction across the embedding space", "isCorrect": true, "explanation": "Correct! This is one of the most celebrated emergent properties of distributed representation learning (Tomas Mikolov et al. 2013; Jeffrey Pennington et al. 2014; Jurafsky & Martin *Speech and Language Processing* Section 6.5). 1. **The Context Shift Invariant:** - Consider the word `'King'`. It appears near words like `['throne', 'crown', 'reign', 'he', 'him', 'palace']`. - Consider the word `'Queen'`. It appears near words like `['throne', 'crown', 'reign', 'she', 'her', 'palace']`. - Notice that the ONLY difference between the context distribution of King and Queen is the **female-gender pronouns and royal titles**! 2. **The Vector Subtraction Proof:** - When you compute $\\vec{v}_{\\text{King}} - \\vec{v}_{\\text{Man}}$, you mathematically subtract the 'male human' direction, leaving pure 'royalty'. - When you add $\\vec{v}_{\\text{Woman}}$, you re-introduce the 'female human' direction onto the 'royalty' base. - The resulting coordinate point lands directly in the neighborhood of $\\vec{v}_{\\text{Queen}}$! 3. **Universal Relational Directions:** - This holds for verb tenses: $\\vec{v}_{\\text{walking}} - \\vec{v}_{\\text{walk}} \\approx \\vec{v}_{\\text{swimming}} - \\vec{v}_{\\text{swim}}$ (The $+ing$ direction). - This holds for geography: $\\vec{v}_{\\text{Tokyo}} - \\vec{v}_{\\text{Japan}} \\approx \\vec{v}_{\\text{Paris}} - \\vec{v}_{\\text{France}}$ (The Capital-City direction)." },
        { "text": "Because the model was explicitly programmed with English grammar rules", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because word embeddings are generated by calculating Unicode character differences", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Word2Vec uses quantum superposition to align word meanings", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
