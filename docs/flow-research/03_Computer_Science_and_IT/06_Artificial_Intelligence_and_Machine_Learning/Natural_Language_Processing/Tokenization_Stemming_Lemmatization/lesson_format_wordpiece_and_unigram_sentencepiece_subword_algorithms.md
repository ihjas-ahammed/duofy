# Duofy Reusable Lesson Format: WordPiece and Unigram SentencePiece Subword Algorithms

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Tokenization_Stemming_Lemmatization`  
**Lesson Format Type:** `wordpiece_and_unigram_sentencepiece_subword_algorithms`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the probabilistic criteria, language model likelihoods, and pruning algorithms of WordPiece and Unigram SentencePiece tokenizers (Mike Schuster & Kaisuke Nakajima 2012, *Japanese and Korean voice search*, ICASSP; Jacob Devlin et al. 2018 BERT; Taku Kudo 2018, *Subword Regularization: Improving Neural Network Translation Models with Multiple Subword Candidates*, ACL; SentencePiece framework): contrast **BPE (frequency-greedy bottom-up merges)** with **WordPiece (likelihood-maximizing bottom-up merges via score $S(u, v) = \frac{\text{count}(uv)}{\text{count}(u)\cdot \text{count}(v)}$ with `##` continuation markers)**, master the **Unigram Language Model Tokenizer (a top-down pruning algorithm starting from a massive seed vocabulary of 1M+ substrings and iteratively removing the bottom 10-20% of subwords that minimize corpus entropy increase)**, analyze **SentencePiece's whitespace-preserving representation (treating whitespace as a regular character `_`)**, and evaluate why SentencePiece operates seamlessly across languages without whitespace word boundaries (e.g. Japanese, Chinese, Thai).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | WordPiece Likelihood Score Formula, Unigram Top-Down Pruning, & SentencePiece Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Top-Down Vocabulary Pruning in the Unigram Language Model Tokenizer Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Subword Tokenizer / Algorithmic Construct & Mathematical Principle Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In WordPiece (BERT), Subword Continuations Attached to the End of Words Are Prefixed by the Double Hash ___ (##) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical and Algorithmic Contrast: Bottom-Up Merging (BPE/WordPiece) vs Top-Down Pruning (Unigram) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State WordPiece & Unigram (Schuster 2012; Kudo 2018):
   - **The 3 Major Subword Algorithmic Families:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Algorithm} & \textbf{Paradigm} & \textbf{Selection Criterion} & \textbf{Used In} \\
     \hline
     \mathbf{\text{BPE}} & \text{Bottom-Up Merging} & \mathbf{\text{Raw Pair Frequency } \text{count}(u, v)} & \text{GPT-2/4, LLaMA, RoBERTa} \\
     \mathbf{\text{WordPiece}} & \text{Bottom-Up Merging} & \mathbf{\text{Likelihood Score: } \frac{\text{count}(uv)}{\text{count}(u)\text{count}(v)}} & \text{BERT, DistilBERT} \\
     \mathbf{\text{Unigram}} & \mathbf{\text{Top-Down Pruning}} & \mathbf{\text{Viterbi Loss / Entropy Minimal Increase}} & \text{SentencePiece, ALBERT, T5} \\
     \hline
     \end{array}$$
   - **SentencePiece Universal Whitespace Invariant:**
     - Treats raw input as a stream of characters, replacing whitespace with `_` (e.g. `_New _York`).
     - Reversible lossless detokenization with **zero language-specific pre-tokenizers required**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Unigram tokenizer training: (1) initialize massive seed vocabulary containing all individual characters plus 1,000,000 frequent corpus substrings, (2) compute optimal unigram probabilities p(x) for each subword using EM algorithm on corpus, (3) evaluate total corpus loss L = -sum log P(sentence) via Viterbi dynamic programming segmentation, (4) compute loss increase delta_L for every subword if removed from vocabulary, (5) prune bottom 20% of subwords with smallest loss increase; repeat until target vocabulary size is reached!
3. **Slide 3 (`matching`):** Pair 4 concepts (WordPiece ## Prefix, Unigram Language Model, SentencePiece Framework, Viterbi Dynamic Segmentation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the ## continuation prefix in WordPiece. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on bottom-up vs top-down: How does the fundamental operational paradigm of the Unigram Language Model tokenizer (Kudo 2018 / SentencePiece) differ from Byte-Pair Encoding (BPE) and WordPiece? (While BPE and WordPiece are **greedy bottom-up merging algorithms** that start with individual characters and iteratively fuse pairs based on local frequencies, **Unigram is a top-down probabilistic pruning algorithm**; it starts with an enormous over-complete vocabulary of substrings, trains a unigram language model, and **iteratively prunes the bottom 10-20% of subwords whose removal causes the smallest increase in total corpus loss**, enabling probabilistic subword regularization and optimal dynamic programming segmentation via the Viterbi algorithm).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "wordpiece_and_unigram_sentencepiece_subword_algorithms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: WordPiece, Unigram, \\& SentencePiece (Kudo 2018)**\n• **Algorithmic Subword Taxonomy (Jurafsky \\& Martin *SLP* Chapter 2):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Tokenizer} & \\textbf{Construction Paradigm} & \\textbf{Mathematical Selection Rule} & \\textbf{Prominent Models} \\\\\n\\hline\n\\mathbf{\\text{BPE}} & \\text{Bottom-Up Greedy Merge} & \\text{Raw co-occurrence pair count: } \\text{count}(u, v) & \\text{GPT-4, LLaMA, Mistral} \\\\\n\\mathbf{\\text{WordPiece}} & \\text{Bottom-Up Likelihood Merge} & \\mathbf{\\text{Mutual Information: } \\frac{\\text{count}(uv)}{\\text{count}(u) \\cdot \\text{count}(v)}} & \\text{BERT (uses } \\text{\\\"##\\\"} \\text{ prefix)} \\\\\n\\mathbf{\\text{Unigram}} & \\mathbf{\\text{Top-Down Pruning}} & \\mathbf{\\text{Minimizes increase in corpus loss } \\Delta \\mathcal{L}} & \\mathbf{\\text{SentencePiece, T5, ALBERT}} \\\\\n\\hline\n\\end{array}\n$$\n• **The SentencePiece Paradigm (Taku Kudo 2018):**\n  - Treats whitespace as a regular character symbol (e.g. `_` or ` `).\n  - Language-agnostic: Works effortlessly on **Japanese, Chinese, \\& Thai without spaces**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to train a Unigram Language Model Tokenizer (SentencePiece).",
      "orderItems": [
        "Initialize a massive candidate vocabulary containing all characters and millions of frequent corpus substrings",
        "Estimate subword emission probabilities p(x) across the corpus using the Expectation-Maximization (EM) algorithm",
        "Compute the optimal Viterbi token segmentation for all corpus sentences and calculate total dataset negative log-likelihood loss L",
        "Calculate the loss delta (Delta L) for each candidate subword measuring the exact increase in corpus loss if that subword is deleted",
        "Prune the bottom 10-20% of subwords with the smallest Delta L; repeat iteratively until reaching target vocabulary size"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Subword Tokenization Technology to its exact Algorithmic Implementation.",
      "matchPairs": [
        { "left": "WordPiece '##' Marker", "right": "Prefix attached to internal subwords (e.g. 'play', '##ing') indicating attachment to preceding token" },
        { "left": "Unigram Language Model", "right": "Probabilistic tokenizer ranking subwords by corpus likelihood and pruning uninformative tokens top-down" },
        { "left": "SentencePiece Framework", "right": "Lossless tokenizer encoding whitespace directly as a character symbol to support all world scripts" },
        { "left": "Subword Regularization", "right": "Training data augmentation technique randomly sampling from multiple subword segmentations to boost robustness" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In BERT's WordPiece tokenizer, subword continuations attached to the end of a word are prefixed with ___.",
      "blankAnswer": "##",
      "blankDistractors": ["@@", "$$", "__"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does the fundamental operational paradigm of the Unigram Language Model tokenizer (Taku Kudo 2018 / SentencePiece) differ from Byte-Pair Encoding (BPE) and WordPiece?",
      "options": [
        { "text": "While BPE and WordPiece are bottom-up merging algorithms that begin with atomic characters and greedily fuse pairs based on local frequency or mutual information, Unigram is a top-down probabilistic pruning algorithm; it begins with an enormous over-complete vocabulary of substrings, trains a unigram language model over the corpus, and iteratively prunes the bottom 10-20% of subwords whose removal causes the smallest increase in total corpus loss, enabling optimal global Viterbi segmentation and probabilistic subword regularization", "isCorrect": true, "explanation": "Correct! This is Taku Kudo's core algorithmic breakthrough in creating SentencePiece and the Unigram tokenizer (Taku Kudo 2018 *Subword Regularization: Improving Neural Network Translation Models with Multiple Subword Candidates*, ACL). 1. **Bottom-Up (BPE / WordPiece):** - Start small: $V = \\{a, b, c, \\dots\\}$ (256 characters). - Greedily merge pairs: `(t, h) -> th`, `(th, e) -> the`. - Merges are **deterministic and permanent** (if an early merge was sub-optimal, it can never be undone). 2. **Top-Down (Unigram LM):** - Start huge: $V = \\{a, b, c, \\dots, \\text{all } 1,000,000\\text{ frequent substrings}\\}$. - Run Expectation-Maximization (EM) to compute $P(x)$ for each token. - For every token, ask: *If I delete this token, how much does the language model perplexity get worse?* - Delete the worst $20\\%$ of tokens. - Repeat until vocabulary drops to exactly $32,000$ tokens! 3. **The Unigram Superpower (Subword Regularization):** - In BPE, every word has exactly ONE fixed tokenization. - In Unigram, any word has multiple valid token paths with assigned probabilities. - During training, we can randomly sample from the top-5 segmentations (e.g. `'unigram'` as `['uni', 'gram']` or `['u', 'ni', 'gram']`), acting as **powerful data augmentation** that boosts translation and reasoning robustness!" },
        { "text": "Because Unigram only works on single-letter words", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because BPE requires Python while Unigram requires C++", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because WordPiece cannot be used for deep learning", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
