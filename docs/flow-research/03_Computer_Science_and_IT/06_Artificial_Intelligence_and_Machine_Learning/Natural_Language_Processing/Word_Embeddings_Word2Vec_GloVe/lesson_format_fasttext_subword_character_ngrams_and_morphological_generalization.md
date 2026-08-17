# Duofy Reusable Lesson Format: FastText (Subword Character n-grams and Morphological Generalization)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Word_Embeddings_Word2Vec_GloVe`  
**Lesson Format Type:** `fasttext_subword_character_ngrams_and_morphological_generalization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify character-level subword representations, morphological decomposition, and Out-of-Vocabulary embedding synthesis using FastText (Piotr Bojanowski, Edouard Grave, Armand Joulin, Tomas Mikolov 2017, *Enriching Word Vectors with Subword Information*, TACL; Facebook AI Research): analyze why standard Word2Vec and GloVe fail on morphologically rich languages (e.g. Finnish, Turkish, German, Arabic) by treating distinct inflections (`"read"`, `"reads"`, `"reading"`, `"readability"`) as isolated, independent vector slots, master the **FastText Subword Character $n$-gram Representation ($\mathbf{v_w = \sum_{g \in \mathcal{G}_w} z_g}$)** with boundary markers `<` and `>`, analyze the **Hashing Trick** ($2 \times 10^6$ buckets) that bounds memory overhead, evaluate why FastText synthesizes accurate embeddings for **misspelled or unseen Out-of-Vocabulary words**, and interact with live Word2Vec vector arithmetic, King-Queen analogy vector field, and FastText subword aggregator simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FastText Character $n$-gram Sum Formula $v_w = \sum z_g$, OOV Generalization Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Subword Embedding Component / Morphological Metric & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why FastText Outperforms Standard Word2Vec on Morphologically Rich Languages Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | FastText Decomposes Words into Character Sub-Units Known as Character ___-Grams (n / N) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Word Embedding Vector Arithmetic & FastText $n$-gram Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fasttext_subword_character_ngrams_and_morphological_generalization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does FastText represent words as character n-grams, and why does it excel at Out-of-Vocabulary (OOV) words?",
      "blankAnswer": "FastText Subword Embeddings (Bojanowski et al. 2017): (1) THE ATOMIC FLAW: Word2Vec/GloVe treat 'apple' and 'apples' as completely independent words sharing ZERO parameter weights. In agglutinative languages (Finnish, Turkish, German), words have hundreds of prefixes/suffixes, creating massive vocabularies with sparse data. (2) FASTTEXT N-GRAM FORMULATION: FastText bounds words with '<' and '>' and extracts all character n-grams (typically n=3 to 6). Example for 'where' with n=3: <wh, whe, her, ere, re>, plus whole word <where>. (3) VECTOR AGGREGATION: The final word vector is the direct linear sum of all its constituent n-gram vectors: v_w = sum_{g in G_w} z_g. (4) OOV SUPERPOWER: If an unseen word 'unbreakability' arrives during inference, FastText looks up the vectors for '<un', 'break', 'abil', 'ity>' and sums them, creating a rich semantic vector even if the full word was NEVER seen during training!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Subword Embedding Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Character n-grams (n=3..6)", "right": "Subword character sequences capturing internal prefixes, roots, and suffixes inside words" },
        { "left": "Boundary Markers '<' and '>'", "right": "Special characters distinguishing standalone morphemes from internal word substrings" },
        { "left": "Subword Vector Sum (v = sum z_g)", "right": "Linear superposition of constituent subword embeddings forming the total word representation" },
        { "left": "Hashing Trick", "right": "Maps millions of arbitrary character n-grams to fixed-size array of 2,000,000 buckets using Fowler-Noll-Vo hash" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does FastText (Bojanowski et al. TACL 2017) achieve dramatically higher syntactic and semantic accuracy than Word2Vec on morphologically rich and agglutinative languages (such as German, Finnish, Russian, and Turkish)?",
      "options": [
        { "text": "Word2Vec assigns a single atomic vector to each unique word string, treating grammatical inflections and compound words (e.g. German 'Donaudampfschiffahrtsgesellschaftskapitän' or Finnish case inflections) as completely distinct, rare tokens with insufficient training occurrences; FastText decomposes every word into a bag of overlapping character n-grams (n=3..6) and represents words as the sum of their subword embeddings, enabling parameter sharing across shared roots, prefixes, and suffixes and allowing unseen inflections to inherit rich representations from their sub-morphemes", "isCorrect": true, "explanation": "Correct! This is Piotr Bojanowski, Tomas Mikolov, and Facebook AI's major breakthrough in subword vector semantics (Bojanowski et al. 2017 *Enriching Word Vectors with Subword Information*). 1. **The Morphological Explosion in Word2Vec:** - In English: `eat`, `eats`, `eating`, `ate` (4 words). - In Finnish: A single noun has over **15 cases** (e.g. `talo` [house], `talossa` [in the house], `talosta` [out of the house], `taloon` [into the house]). - Word2Vec sees these as 15 completely unrelated words! Because rare inflections appear only 1 or 2 times in the corpus, Word2Vec fails to learn good embeddings for them. 2. **The FastText Subword Solution:** - FastText extracts $n$-grams: `<tal`, `talo`, `alos`, `loss`, `ossa`, `ssa>`. - All 15 Finnish inflections share the root $n$-grams `<tal` and `talo`! - The case endings (`ossa>`, `osta>`) are shared across thousands of other nouns. 3. **The Result:** - FastText shares parameters across all related words, trains robust embeddings even on rare inflections, and produces valid vectors for typos (e.g. `'computerr'`) and compound words with zero OOV errors!" },
        { "text": "Because FastText deletes all words that are not found in the Oxford English Dictionary", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because FastText replaces all neural networks with binary decision trees", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Finnish and German text cannot be processed by GPU matrices", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "FastText breaks words down into sub-word character sequences known as character ___-grams.",
      "blankAnswer": "n",
      "blankDistractors": ["k", "m", "z"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Vector Semantics & FastText n-gram Aggregator Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Vector Semantics & FastText</h3><p>Operation: <b style=\"color:#38bdf8;\">\"King\" - \"Man\" + \"Woman\" = ?</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnAnalogy\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Word2Vec Vector Arithmetic</button><button id=\"btnNgram\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. FastText Subwords (3-grams)</button><button id=\"btnOov\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Synthesize Unseen OOV Vector</button></div><div id=\"embLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to run vector analogy...</div><script>document.getElementById('btnAnalogy').onclick=()=>{document.getElementById('embLog').innerHTML='<b>1. WORD2VEC LINEAR VECTOR ANALOGY:</b><br>• v_King = [ 0.82,  0.45, -0.12, ... ]<br>• v_Man  = [ 0.21,  0.78, -0.34, ... ]<br>• v_Woman= [ 0.19, -0.65, -0.31, ... ]<br>• v_Result = v_King - v_Man + v_Woman<br>🎯 Closest Cosine Similarity (0.892): <b style=\"color:#10b981; font-size:16px;\">\"Queen\"</b>';}; document.getElementById('btnNgram').onclick=()=>{document.getElementById('embLog').innerHTML='<b>2. FASTTEXT CHARACTER N-GRAM EXTRACTION:</b><br>Target: &quot;&lt;where&gt;&quot; (3-grams):<br>• [ &quot;&lt;wh&quot;, &quot;whe&quot;, &quot;her&quot;, &quot;ere&quot;, &quot;re&gt;&quot;, &quot;&lt;where&gt;&quot; ]<br>• Word Vector = &sum; z_ngram (Superposition of subwords)';}; document.getElementById('btnOov').onclick=()=>{document.getElementById('embLog').innerHTML='<b>3. FASTTEXT UNSEEN OOV WORD SYNTHESIS:</b><br>Word: <b style=\"color:#f59e0b;\">\"unbreakability\"</b> (Never seen in training!)<br>• Subwords found: [&quot;&lt;un&quot;, &quot;break&quot;, &quot;abil&quot;, &quot;ity&gt;&quot;]<br>• v_OOV = z_&lt;un + z_break + z_abil + z_ity&gt;<br>🎉 <b style=\"color:#10b981;\">High-quality semantic vector successfully synthesized!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
