# Duofy Reusable Lesson Format: Byte-Pair Encoding (BPE Iterative Merges and GPT Tokenization)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Tokenization_Stemming_Lemmatization`  
**Lesson Format Type:** `byte_pair_encoding_bpe_iterative_merges_and_gpt_tokenization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the data compression origins, iterative merge table construction, and subword tokenization mechanics of Byte-Pair Encoding (Philip Gage 1994; Rico Sennrich, Barry Haddow, Alexandra Birch 2015, *Neural Machine Translation of Rare Words with Subword Units*, ACL; Alec Radford et al. 2019 GPT-2; Andrej Karpathy *minbpe*): analyze why word-level tokenization fails (massive Out-of-Vocabulary [OOV] rates and bloated vocabulary matrices) while character-level tokenization produces impractically long sequences with weak semantic compression, master the **BPE Algorithm** (initializing vocabulary with individual characters/bytes, counting all adjacent pair frequencies, iteratively merging the most frequent pair into a new subword token, and saving the ranked **Merge Table**), trace how BPE tokenizes unseen test words by decomposing rare terms into known subword fragments, and evaluate how BPE powers foundation models (GPT-2 50k, GPT-4 tiktoken 100k, LLaMA).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | BPE Merge Algorithm, Word vs Char vs Subword Spectrum, & Merge Table Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of BPE Vocabulary Training on a Toy Word Frequency Corpus Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Subword Tokenization Construct / Merge Step & Operational Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In BPE Training, the Algorithm Iteratively Merges the Most ___ Pair of Adjacent Tokens (Frequent) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of How Byte-Pair Encoding Effectively Solves the Out-of-Vocabulary (OOV) Dilemma Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State BPE (Sennrich et al. 2015; Karpathy *minbpe*):
   - **The Tokenization Spectrum:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Granularity} & \textbf{Vocab Size } |V| & \textbf{Sequence Length } T & \textbf{OOV Risk} \\
     \hline
     \mathbf{\text{Word-Level}} & \text{Huge } (10^6+) & \text{Short} & \mathbf{\text{High (Catastrophic for rare words)}} \\
     \mathbf{\text{Char-Level}} & \text{Tiny } (\approx 100) & \text{Extremely Long } (5\times) & \text{Zero (Weak semantic density)} \\
     \mathbf{\text{Subword (BPE)}} & \mathbf{\text{Optimal } (32k - 100k)} & \mathbf{\text{Balanced}} & \mathbf{\text{Zero / Near-Zero (Optimal SOTA)}} \\
     \hline
     \end{array}$$
   - **The BPE Training Invariant:**
     - Start: $V = \{\text{all basic characters}\}$.
     - Loop: Count pairs $\to$ Pick $\arg\max \text{count}(c_1, c_2) \to$ Create token $c_1 c_2 \to$ Add to Merge Table!
2. **Slide 2 (`ordering`):** Provide 5 steps of BPE training on corpus {`"l o w </w>": 5`, `"l o w e s t </w>": 2`, `"n e w e s t </w>": 6`}: (1) decompose all words into individual characters with end-of-word tokens, (2) count all adjacent pair frequencies: ('e', 's') appears 8 times, ('s', 't') appears 8 times, (3) merge highest frequency pair ('e', 's') -> 'es' to update vocabulary, (4) merge next highest pair ('es', 't') -> 'est' (frequency 8), (5) repeat merge cycle until target vocabulary size is reached and export ordered merge rule table!
3. **Slide 3 (`matching`):** Pair 4 BPE concepts (Merge Table, Subword Token, Base Vocabulary, End-of-Word Symbol) with their roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that BPE merges the most Frequent pair. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how BPE resolves Out-of-Vocabulary (OOV) tokens: When a trained Transformer language model encounters a never-before-seen domain-specific word during inference (e.g. `"unsubdivided"`), how does Byte-Pair Encoding (BPE) process this input without producing a `<UNK>` (Unknown) error? (BPE does not require the entire word `"unsubdivided"` to exist in its vocabulary; during inference tokenization, it applies its learned merge rules in priority order, **gracefully decomposing the rare unseen word into its familiar constituent subword tokens (e.g. `["un", "sub", "divided"]`)**, allowing the model to construct a rich contextual embedding from known morphological sub-units with **zero Out-of-Vocabulary information loss**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "byte_pair_encoding_bpe_iterative_merges_and_gpt_tokenization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Byte-Pair Encoding (Sennrich et al. ACL 2015)**\n• **The Subword Tokenization Spectrum (Jurafsky \\& Martin *SLP* Chapter 2):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Method} & \\textbf{Vocabulary Size } |V| & \\textbf{Sequence Length } T & \\textbf{OOV Failure Risk} \\\\\n\\hline\n\\mathbf{\\text{Word-Level}} & \\text{Massive } (10^6+) & \\text{Short} & \\mathbf{\\text{High (Rare words become <UNK>)}} \\\\\n\\mathbf{\\text{Character-Level}} & \\text{Tiny } (\\approx 256) & \\text{Extremely Long } (5\\times) & \\text{Zero (Low semantic density)} \\\\\n\\mathbf{\\text{Subword (BPE)}} & \\mathbf{\\text{Balanced } (32k - 100k)} & \\mathbf{\\text{Compact \\& Dense}} & \\mathbf{\\text{Zero (Splits rare words to subwords!)}} \\\\\n\\hline\n\\end{array}\n$$\n• **BPE Iterative Merge Loop:**\n  1. Initialize vocabulary $V$ with all unique individual characters.\n  2. Count co-occurrence frequency of all adjacent symbol pairs across corpus.\n  3. Merge most frequent pair: $\\mathbf{(c_1, c_2) \\longrightarrow c_{\\text{new}}}$ and record in **Merge Table**.\n  4. Repeat for $K$ iterations until target vocabulary size $|V|$ is achieved!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during Byte-Pair Encoding (BPE) tokenizer training on a text corpus.",
      "orderItems": [
        "Pre-tokenize the corpus into whitespace/regex-split words and append an end-of-word suffix token (e.g. '</w>') to each word",
        "Split all words into individual character sequences to construct the initial base character vocabulary",
        "Count the global occurrence frequencies of all adjacent subword pairs across the entire tokenized training corpus",
        "Identify the single most frequent adjacent pair (c_1, c_2) and merge it into a single new subword token c_new in the vocabulary",
        "Record the merge rule in the ranked Merge Table and iterate until the target vocabulary size (e.g. 50,257 tokens) is reached"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Subword Tokenization Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "BPE Merge Table", "right": "Ordered list of learned pair-replacement rules applied sequentially during inference tokenization" },
        { "left": "Subword Unit", "right": "Frequent character n-gram (e.g. 'ing', 'pre', 'tion') bridging character and word granularities" },
        { "left": "Base Vocabulary", "right": "Initial set of atomic characters or raw UTF-8 bytes guaranteeing universal character coverage" },
        { "left": "OOV Elimination", "right": "Property where unseen complex words are naturally broken into known subword fragments rather than <UNK>" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In BPE tokenizer training, the algorithm iteratively merges the most ___ pair of adjacent tokens.",
      "blankAnswer": "frequent",
      "blankDistractors": ["complex", "rare", "longest"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When a trained Large Language Model (such as GPT-4 or LLaMA) encounters a completely novel, never-before-seen compound word during inference (e.g. 'unsubdivided'), how does Byte-Pair Encoding (BPE) process this input without producing an Out-of-Vocabulary (<UNK>) error?",
      "options": [
        { "text": "BPE does not require the entire multi-syllable word 'unsubdivided' to exist as a monolithic token in its vocabulary; during inference tokenization, it consults its ranked merge table and iteratively decomposes the rare word into its familiar constituent subword units (e.g. ['un', 'sub', 'divided']), allowing the Transformer to compute rich semantic embeddings from known morphological building blocks with zero Out-of-Vocabulary information loss", "isCorrect": true, "explanation": "Correct! This is Rico Sennrich et al.'s foundational insight that revolutionized neural machine translation and modern LLMs (Sennrich et al. ACL 2015 *Neural Machine Translation of Rare Words with Subword Units*; Andrej Karpathy *minbpe*). 1. **The Failure of Classical Word-Level Models:** - In word-level tokenization, if the dictionary contains 50,000 words, any word not in the dictionary (like 'unsubdivided' or a typo 'appllee') becomes `<UNK>`. - The model loses $100\\%$ of the information about that word! 2. **How BPE Handles Unseen Words:** - BPE's base vocabulary contains all single characters (`u`, `n`, `s`, `b`, etc.). - When `'unsubdivided'` arrives: - The tokenizer checks its merge rules. - It finds merges for `'un'`, `'sub'`, and `'divided'`. - It splits the string into: `['un', 'sub', 'divided']`. 3. **The Semantic Result:** - The Transformer receives 3 valid token IDs. - The self-attention layers combine the prefix 'un-' (negation) with 'sub-' (under/part) and 'divided' (separated), understanding the full semantic meaning of the compound word seamlessly!" },
        { "text": "Because BPE automatically downloads new words from the internet during inference", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because BPE ignores punctuation marks and numbers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because BPE converts all unknown words into the letter 'e'", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
