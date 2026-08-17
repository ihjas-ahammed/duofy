# Duofy Reusable Lesson Format: Text Normalization (Porter Stemmer and WordNet Lemmatization)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Tokenization_Stemming_Lemmatization`  
**Lesson Format Type:** `text_normalization_porter_stemmer_and_wordnet_lemmatization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algorithmic rules, morphological analyses, and linguistic trade-offs of Stemming and Lemmatization in classical NLP (Martin Porter 1980, *An algorithm for suffix stripping*, Program; George Miller 1995 WordNet; Dan Jurafsky & James H. Martin *Speech and Language Processing* Chapter 2): analyze why text normalization is necessary to reduce lexical sparsity, master the **Porter Stemmer Algorithm** (a multi-stage cascading rule system that strips suffixes based on consonant-vowel syllable measure $([C](VC)^m[V])$), evaluate classical stemming failure modes (**Over-stemming** [merging distinct words e.g. `"universe"` and `"university"` to `"univers"`] and **Under-stemming** [failing to merge inflections e.g. `"alumnus"` and `"alumni"`]), master **WordNet Lemmatization** (morphological lookup against lexical databases), and prove why **Part-of-Speech (POS) Tagging is strictly required for accurate lemmatization** (e.g. resolving `"better"` to lemma `"good"` [Adj] vs `"better"` [Verb], `"running"` to `"run"` [Verb] vs `"running"` [Noun]).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Stemming vs Lemmatization Comparison Table, Porter Syllable Measure & POS Lookup Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Morphological Lemmatization Execution with POS Disambiguation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Normalization Algorithm / Error Category & Linguistic Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Canonical Base Dictionary Form Produced by Morphological Lemmatization is the ___ (Lemma) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Lemmatizers Fail to Reduce Irregular Verbs Without Explicit POS Tagging Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stemming vs Lemmatization (Porter 1980; Jurafsky & Martin Ch 2):
   - **Stemming vs Lemmatization Roster:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Method} & \textbf{Algorithm Mechanism} & \textbf{Output Form} & \textbf{Execution Speed} \\
     \hline
     \mathbf{\text{Stemming (Porter)}} & \text{Heuristic suffix stripping rules} & \text{Truncated stem (often non-word)} & \mathbf{\text{Ultra-fast (No DB lookup)}} \\
     \mathbf{\text{Lemmatization (WordNet)}} & \mathbf{\text{Morphology + POS + Lexicon}} & \mathbf{\text{Valid dictionary base (Lemma)}} & \text{Slower (Requires POS parsing)} \\
     \hline
     \end{array}$$
   - **Concrete Examples:**
     - Input: `"studies"` $\to$ Stemmer: `"studi"` ; Lemmatizer (POS=V): `"study"`.
     - Input: `"better"` $\to$ Stemmer: `"better"` ; Lemmatizer (POS=A): `"good"`.
     - Input: `"saw"` $\to$ Stemmer: `"saw"` ; Lemmatizer (POS=V): `"see"` ; (POS=N): `"saw"`.
2. **Slide 2 (`ordering`):** Provide 5 steps of pipeline text lemmatization: (1) tokenize raw sentence into word tokens, (2) run Part-of-Speech (POS) tagger to tag syntactic roles (Noun, Verb, Adjective, Adverb), (3) map Penn Treebank POS tags to WordNet POS categories (e.g. VBD -> 'v', JJ -> 'a'), (4) query WordNet morphological database with (token, POS) pair, (5) return true canonical dictionary base lemma!
3. **Slide 3 (`matching`):** Pair 4 concepts (Porter Stemmer, WordNet Lemma, Over-Stemming, POS Tagging) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that dictionary base form is Lemma. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why POS tagging is mandatory: When applying WordNet Lemmatizer in Python (e.g. `nltk.stem.WordNetLemmatizer().lemmatize('ran')`), why does the lemmatizer output `'ran'` (failing to convert it to `'run'`) unless the explicit argument `pos='v'` is provided? (WordNetLemmatizer defaults to assuming every input token is a **Noun (`pos='n'`)** unless specified otherwise; because `'ran'` is not a valid noun in the English dictionary, the lemmatizer leaves it unchanged; **providing the explicit tag `pos='v'` activates the irregular verb morphology lookup tables**, allowing WordNet to successfully trace the past-tense verb inflection `'ran'` back to its true base lemma `'run'`).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "text_normalization_porter_stemmer_and_wordnet_lemmatization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Text Normalization — Stemming vs Lemmatization**\n• **Core Paradigm Comparison (Jurafsky \\& Martin *SLP* Chapter 2):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Technique} & \\textbf{Operational Mechanism} & \\textbf{Output Example (\"ran\", \"better\")} & \\textbf{Linguistic Validity} \\\\\n\\hline\n\\mathbf{\\text{Stemming (Porter)}} & \\text{Heuristic rule-based suffix slicing} & \\text{\"ran\"} \\to \\text{\"ran\"} \\ ; \\ \\text{\"better\"} \\to \\text{\"better\"} & \\text{Often outputs non-words (e.g. \"studi\")} \\\\\n\\mathbf{\\text{Lemmatization}} & \\mathbf{\\text{Morphological Analysis + POS Tag}} & \\mathbf{\\text{\"ran\"} \\to \\text{\"run\"} \\ ; \\ \\text{\"better\"} \\to \\text{\"good\"}} & \\mathbf{\\text{Guaranteed true dictionary Lemma!}} \\\\\n\\hline\n\\end{array}\n$$\n• **Classical Stemming Pitfalls:**\n  - **Over-stemming:** Merging distinct concepts (*\"universe\"* \\& *\"university\"* $\\to$ *\"univers\"*).\n  - **Under-stemming:** Failing to link inflections (*\"alumnus\"* \\& *\"alumni\"* $\\to$ separate stems).\n• **The POS Dependency:** Lemmatization **requires Part-of-Speech tags** for disambiguation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed in an NLP pipeline to correctly lemmatize raw text using Part-of-Speech tags.",
      "orderItems": [
        "Tokenize the input sentence string into individual whitespace and punctuation-separated word tokens",
        "Pass the token sequence through a Part-of-Speech (POS) Tagger to determine syntactic categories (Noun, Verb, Adjective)",
        "Convert Penn Treebank grammatical POS tags into universal WordNet category characters (e.g. VBD/VBG -> 'v', JJ -> 'a')",
        "Query the WordNet morphological dictionary using the exact (word_token, pos_tag) pair",
        "Retrieve and output the true canonical grammatical base form (the Lemma) for each token"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Text Normalization Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Porter Stemmer (1980)", "right": "Deterministic cascading rule engine stripping common English suffixes (e.g. -ing, -ly, -ed) without vocabulary lookups" },
        { "left": "WordNet Lemmatization", "right": "Lexical database lookup reducing inflected words to canonical dictionary headwords using POS morphological rules" },
        { "left": "Over-Stemming Error", "right": "Pathology where semantically unrelated words are erroneously truncated into the exact same stem" },
        { "left": "POS Tag Disambiguation", "right": "Essential context determining whether 'saw' is lemmatized as the verb 'see' or the noun 'saw'" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The canonical base dictionary headword produced by morphological analysis is called the ___.",
      "blankAnswer": "lemma",
      "blankDistractors": ["stem", "token", "n-gram"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When executing a WordNet Lemmatizer in Python (e.g. NLTK's WordNetLemmatizer().lemmatize('ran')), why does the lemmatizer output 'ran' unchanged (failing to convert it to 'run') unless the parameter pos='v' is explicitly specified?",
      "options": [
        { "text": "WordNetLemmatizer defaults to assuming every input token is a Noun (pos='n') unless an explicit POS tag is provided; because 'ran' does not exist as a noun in the English dictionary, the lemmatizer treats it as an uninflected base noun and returns it unchanged; providing pos='v' instructs the morphological analyzer to search the irregular verb past-tense transformation tables, correctly resolving 'ran' to its base verb lemma 'run'", "isCorrect": true, "explanation": "Correct! This is one of the most common practical gotchas in classical Natural Language Processing (Jurafsky & Martin *Speech and Language Processing* Chapter 2.3; NLTK documentation). 1. **How WordNet Lemmatizer Works:** - The lemmatizer relies on WordNet's morphological exception lists (e.g. `verb.exc`, `noun.exc`, `adj.exc`). - Because natural language is full of homographs (words with multiple syntactic roles), the lemmatizer MUST know the Part of Speech. 2. **The Default POS Trap:** - In NLTK: `def lemmatize(self, word, pos='n'):` - If you run `lemmatize('ran')`: - WordNet checks `noun.exc` and noun dictionaries. - Is 'ran' an inflected plural noun? No (the plural of 'ran' doesn't exist). - Therefore, it assumes 'ran' is already a base noun like 'cat' or 'table', returning `'ran'`! 3. **The Solution:** - `lemmatize('ran', pos='v')` $\to$ checks `verb.exc` $\to$ successfully returns `'run'`. - `lemmatize('better', pos='a')` $\to$ checks `adj.exc` $\to$ successfully returns `'good'`." },
        { "text": "Because WordNet cannot process words with fewer than 4 letters", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Python strings are immutable and cannot be altered by lemmatizers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because WordNet only supports British English vocabulary", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
