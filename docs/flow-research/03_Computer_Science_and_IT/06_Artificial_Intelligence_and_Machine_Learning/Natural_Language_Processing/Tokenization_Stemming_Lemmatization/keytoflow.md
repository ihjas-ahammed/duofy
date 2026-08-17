# Key to Flow: Text Preprocessing & Subword Tokenization (Stemming, Lemmatization, BPE, & SentencePiece)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Tokenization_Stemming_Lemmatization`

---

## 📌 Core Concept & Mental Model
**Morphological Suffix Chopping (Porter Stemmer), Lexical & Part-of-Speech Lemmatization (WordNet), Frequency-Based Merge Pair Induction (Byte-Pair Encoding BPE), Likelihood-Based Subword Pruning (WordPiece & Unigram SentencePiece), and Byte-Level Representation (BBPE)** govern the textual representation and vocabulary encoding layer across classical information retrieval and modern foundation Large Language Models (Martin Porter 1980; George Miller 1995 WordNet; Philip Gage 1994 / Rico Sennrich et al. 2015 BPE; Mike Schuster & Kaisuke Nakajima 2012 WordPiece; Taku Kudo 2018 SentencePiece; Dan Jurafsky & James H. Martin *Speech and Language Processing* Chapter 2):
* **1. Stemming vs Lemmatization:**
  - **Stemming (Porter / Snowball):**
    - Heuristic, language-specific rule cascades (e.g. `sses -> ss`, `ational -> ate`) that crudely chop off suffixes.
    - *Pros/Cons:* Ultra-fast; fails with **Over-stemming** (`"universe"` & `"university"` $\to$ `"univers"`) and **Under-stemming** (`"alumnus"` & `"alumni"` $\to$ `"alumnus"`, `"alumni"`). Often outputs non-dictionary pseudo-words (`"troubl"`).
  - **Lemmatization (WordNet + POS Tagging):**
    - Full morphological analysis that uses a dictionary lexicon and **Part-of-Speech (POS) tags** to resolve inflected words to their true canonical dictionary base (**Lemma**).
    - *Example:* `"better"` with POS=Verb $\to$ `"better"`; `"better"` with POS=Adj $\to$ `"good"`. `"ran"` $\to$ `"run"`.
* **2. Byte-Pair Encoding (BPE - Sennrich et al. 2015 / GPT-2 / GPT-4 / tiktoken):**
  - Starts with a base vocabulary of individual characters (or UTF-8 bytes).
  - Iteratively counts all adjacent symbol pairs across the training corpus.
  - Finds the most frequent pair $(c_1, c_2)$ and creates a new merged token $c_{\text{new}} = c_1 c_2$.
  - Repeats for $K$ merge operations until desired vocabulary size $|V| = V_{\text{base}} + K$ is reached (e.g. 50,257 in GPT-2, 100k in tiktoken cl100k).
  - *Invariant:* Common words (e.g. `"the"`, `"learning"`) become single tokens; rare words (e.g. `"unsubdivided"`) are decomposed into familiar subwords (`"un"`, `"sub"`, `"divided"`), **drastically reducing Out-of-Vocabulary (OOV) errors**.
* **3. WordPiece & Unigram Language Model Tokenizers:**
  - **WordPiece (Schuster & Nakajima 2012 / BERT):** Similar to BPE, but selects the merge pair that **maximizes the unigram likelihood of the training corpus** rather than simple raw frequency ($S(u, v) = \frac{\text{count}(uv)}{\text{count}(u) \cdot \text{count}(v)}$).
  - **Unigram LM (Taku Kudo 2018 / SentencePiece / LLaMA / ALBERT):** Inverts BPE; starts with a massive initial vocabulary (e.g. all characters + 1,000,000 substrings) and **iteratively prunes the bottom 10-20% of subwords whose removal causes the smallest increase in corpus loss (entropy)**.
* **4. Byte-Level BPE (BBPE) & Vocabulary Size Trade-Offs:**
  - **Byte-Level BPE (Radford et al. 2019):** Initializes base vocabulary with all 256 raw UTF-8 bytes. Guarantees **0% Out-of-Vocabulary (OOV)** rate on ANY text, code, emoji, or non-Latin script in the world without requiring UNK fallback tokens.
  - **Vocabulary Size $|V|$ Dilemma:**
    - **Large Vocabulary ($|V| = 128,000$):** High compression ratio (fewer tokens per sentence $\implies$ faster inference), but large embedding matrix memory ($\mathcal{O}(|V| \cdot d_{\text{model}})$).
    - **Small Vocabulary ($|V| = 8,000$):** Small embedding matrix, but sentences split into many short tokens (long sequences $\implies$ expensive $\mathcal{O}(T^2)$ attention).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Tokenization Evolution
* Lexical Normalization $\to$ Regex Tokenization $\to$ Porter Stemmer.
* Morphological Accuracy $\to$ WordNet Lemmatization + POS Tagging.
* Subword Frequency Merges $\to$ Byte-Pair Encoding (BPE Merge Table).
* Probabilistic Selection $\to$ WordPiece / Unigram SentencePiece.
* Universal Zero-OOV $\to$ Byte-Level BPE (256 Byte Base).

### 2. Top Recommended Resources
* **The Definitive NLP Bible:** *Speech and Language Processing* (Dan Jurafsky & James H. Martin), Chapter 2 (Tokenization, Stemming, and Edit Distance).
* **Tokenization Deep Dive:** *Let's build the GPT Tokenizer* (Andrej Karpathy YouTube series / minbpe repo).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace 3 BPE merge steps on a toy corpus (`"low"`, `"lower"`, `"newest"`)?
- [ ] Can you explain why POS tagging is mandatory for correct WordNet Lemmatization?
- [ ] Can you explain the fundamental difference between BPE (bottom-up merge) and Unigram (top-down prune)?
- [ ] Can you explain why Byte-Level BPE has a 0% Out-of-Vocabulary rate?
