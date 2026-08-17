# Duofy Reusable Lesson Format: Open Addressing (Linear, Quadratic, and Double Hashing)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Hash_Tables_and_Disjoint_Sets`  
**Lesson Format Type:** `open_addressing_linear_quadratic_and_double_hashing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the in-table storage, probe sequences, clustering phenomena, and deletion tombstone mechanics of Open Addressing hash tables (Donald Knuth; Thomas H. Cormen et al. CLRS Chapter 11.4): master the strict requirement that **$\alpha = n/m \le 1$** (all elements stored directly in the array with no linked lists), evaluate the 3 probing strategies (**1. Linear Probing: $h(k, i) = (h'(k) + i) \bmod m$ [suffers from severe Primary Clustering]**, **2. Quadratic Probing: $h(k, i) = (h'(k) + c_1 i + c_2 i^2) \bmod m$ [suffers from Secondary Clustering]**, and **3. Double Hashing: $\mathbf{h(k, i) = (h_1(k) + i \cdot h_2(k)) \bmod m}$ [produces $\Theta(m^2)$ probe permutations, eliminating clustering]**), prove that unsuccessful search takes $\mathbf{\frac{1}{1 - \alpha}}$ expected probes, and formulate the **Deleted / Tombstone Sentinel Protocol** to prevent early search termination bugs.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Open Addressing Probing Functions, Clustering Types, & Deletion Tombstones Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Key Insertion with Double Hashing Probe Loop Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Probing Technique / Artifact & Algorithmic Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Special Sentinel Marker Written to Open Addressing Slots Upon Deletion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Mathematical Failure Mode if Deleted Slots are Set to Empty Null Instead of Tombstones Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Open Addressing (Knuth; CLRS Section 11.4):
   - **The Open Addressing Principle:** All elements stored directly in array ($n \le m$, $\alpha = n/m \le 1$). No pointers!
   - **The 3 Probing Strategies ($i = 0, 1, \dots, m-1$):**
     1. **Linear Probing:** $h(k, i) = (h'(k) + i) \bmod m$.
        - *Defect:* **Primary Clustering** (long occupied blocks grow, increasing average probe times).
     2. **Quadratic Probing:** $h(k, i) = (h'(k) + c_1 i + c_2 i^2) \bmod m$.
        - *Defect:* Secondary Clustering (keys with same initial hash follow identical probe sequences).
     3. **Double Hashing:** $\mathbf{h(k, i) = \Big( h_1(k) + i \cdot h_2(k) \Big) \bmod m}$.
        - *Condition:* $h_2(k)$ must be relatively prime to $m$ ($\gcd(h_2(k), m) = 1$).
        - *Advantage:* Produces $\Theta(m^2)$ probe sequences, **eliminating clustering**!
   - **Performance Bounds (Uniform Hashing):**
     - Expected probes in unsuccessful search: $\mathbf{\frac{1}{1 - \alpha}}$.
     - Expected probes in successful search: $\mathbf{\frac{1}{\alpha} \ln \frac{1}{1 - \alpha}}$.
   - **Deletion Protocol:** Must use a special **`DELETED` (Tombstone)** marker instead of `NULL`!
2. **Slide 2 (`ordering`):** Provide 5 steps of inserting key k using Double Hashing: (1) compute primary hash h1(k) and secondary step size h2(k) ensuring gcd(h2(k), m) = 1, (2) initialize probe index counter i = 0, (3) compute candidate slot index = (h1(k) + i * h2(k)) mod m, (4) if slot contains an active key, increment probe counter i = i + 1 and repeat probe calculation, (5) if slot is empty (NULL) or marked DELETED, write the new key into the slot and terminate with success!
3. **Slide 3 (`matching`):** Pair 4 open addressing concepts (Primary Clustering, Double Hashing Formula, Tombstone DELETED Marker, 1 / (1 - alpha) Probes) with their descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that deleted slots in open addressing must be marked with a tombstone (or DELETED) sentinel. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the disastrous bug that occurs if a deleted slot is overwritten with `NULL` instead of a tombstone in open addressing: Why does setting a deleted slot to `NULL` (empty) break subsequent search operations in open addressing? (Because search queries probe through consecutive occupied slots and **terminate immediately upon encountering the first `NULL` slot**; if a middle slot in a probe sequence is replaced with `NULL`, **all subsequent keys that collided and probed PAST that slot will become unreachable and incorrectly reported as 'Not Found'**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "open_addressing_linear_quadratic_and_double_hashing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Open Addressing & Probing Architectures (CLRS 11.4)**\n• **The 3 Probing Sequences ($i = 0 \\dots m-1$):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Probing Technique} & \\textbf{Hash Sequence Formula } h(k, i) & \\textbf{Clustering Defect} \\\\\n\\hline\n\\mathbf{\\text{Linear Probing}} & (h'(k) + i) \\bmod m & \\text{Severe Primary Clustering} \\\\\n\\mathbf{\\text{Quadratic Probing}} & (h'(k) + c_1 i + c_2 i^2) \\bmod m & \\text{Secondary Clustering} \\\\\n\\mathbf{\\text{Double Hashing}} & \\mathbf{(h_1(k) + i \\cdot h_2(k)) \\bmod m} & \\mathbf{\\text{NO Clustering } (\\gcd(h_2, m) = 1)} \\\\\n\\hline\n\\end{array}\n$$\n• **Expected Unsuccessful Search Probes:** $\\mathbf{\\frac{1}{1 - \\alpha}}$ (e.g. at $\\alpha = 0.5$, exactly 2 probes!).\n• **The Tombstone Protocol:** Deleted slots must be marked **`DELETED`** (never `NULL`) to preserve probe continuity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of inserting a key k into an open addressing table using Double Hashing.",
      "orderItems": [
        "Compute primary hash h1(k) and secondary step size h2(k), ensuring h2(k) is coprime to table size m",
        "Initialize the probe iteration counter variable i = 0",
        "Compute target candidate array slot index = (h1(k) + i * h2(k)) mod m",
        "If target slot is occupied by an active key, increment probe counter i = i + 1 and re-evaluate slot index",
        "If target slot is NULL or marked DELETED, write the new key into the slot and successfully terminate insertion"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Open Addressing term to its exact operational characteristic.",
      "matchPairs": [
        { "left": "Primary Clustering", "right": "Phenomenon in linear probing where contiguous blocks of occupied slots merge, drastically slowing insertions" },
        { "left": "Double Hashing: (h1 + i*h2) % m", "right": "Probing method where step size depends on key k, generating m^2 distinct probe sequences" },
        { "left": "Tombstone (DELETED) Marker", "right": "Sentinel value marking deleted slots allowing search probes to continue past without breaking" },
        { "left": "Formula: 1 / (1 - alpha)", "right": "Expected number of probe operations required in an unsuccessful search under uniform hashing" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In open addressing hash tables, deleted slots must be replaced with a special ___ sentinel marker rather than empty null.",
      "blankAnswer": "tombstone",
      "blankDistractors": ["pointer", "zero", "boolean"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does setting a deleted slot to empty NULL (instead of a DELETED tombstone marker) cause subsequent search queries to produce false negative results in open addressing?",
      "options": [
        { "text": "Search queries probe through the table and stop immediately upon encountering the first empty NULL slot; if an intermediate slot in a collision probe chain is replaced with NULL, any existing keys that were inserted after that slot during earlier collisions will become unreachable, causing search to falsely claim they do not exist", "isCorrect": true, "explanation": "Correct! This is one of the most critical implementation subtleties in open addressing (CLRS Section 11.4). In open addressing, when two keys $k_1$ and $k_2$ hash to the same initial index $h$, $k_1$ occupies slot $h$, and $k_2$ is forced to probe further and occupy slot $h + 1$. When looking up $k_2$, the search algorithm checks slot $h$, sees it is occupied by $k_1$, and continues probing to slot $h + 1$, where it successfully finds $k_2$. Now, suppose key $k_1$ is deleted. If you simply wipe slot $h$ back to `NULL` (empty): When a search for $k_2$ is performed, the search begins at slot $h$. It sees that slot $h$ is `NULL` (empty). By the rules of open addressing, an empty `NULL` slot means 'no key has ever probed past this point', so the search algorithm immediately terminates and returns 'Key $k_2$ Not Found'—even though $k_2$ is sitting right next door in slot $h+1$! To fix this bug, deleted slots must be marked with a special `DELETED` (tombstone) marker. A search query treats `DELETED` as 'occupied, keep probing', while an insertion query treats `DELETED` as 'free slot, can overwrite'." },
        { "text": "Because setting a slot to NULL causes the operating system to shut down", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because NULL slots invert the polarity of the RAM bits", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because open addressing tables cannot hold more than 2 elements", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
