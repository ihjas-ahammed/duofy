# Duofy Reusable Lesson Format: Hash Security Properties (Preimage Resistance and Birthday Paradox)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Cryptographic_Hash_Functions_SHA_MD5`  
**Lesson Format Type:** `hash_security_properties_preimage_and_birthday_paradox`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal mathematical definitions, adversary game models, and probability bounds of cryptographic hash function security (Katz & Lindell *Introduction to Modern Cryptography* Chapter 5.1–5.3; Serious Cryptography Chapter 6; William Stallings Chapter 11): master the **3 Cardinal Hash Security Properties** (**1. Preimage Resistance [One-Wayness: given $h$, find $x$ such that $H(x) = h$; complexity $\mathcal{O}(2^n)$]**, **2. Second Preimage Resistance [Weak Collision Resistance: given fixed $x_1$, find $x_2 \ne x_1$ such that $H(x_1) = H(x_2)$; complexity $\mathcal{O}(2^n)$]**, and **3. Collision Resistance [Strong Collision Resistance: find ANY pair $(x_1, x_2)$ with $x_1 \ne x_2$ such that $H(x_1) = H(x_2)$; complexity $\mathcal{O}(2^{n/2})$]**), derive the **Birthday Paradox Collision Bound ($\sqrt{2^n} = \mathbf{2^{n/2}}$)**, evaluate the historical depreciation of MD5 ($2^{64}$ ops) and SHA-1 ($2^{80}$ ops), and analyze why SHA-256 provides a permanent 128-bit collision security floor ($2^{128}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 3 Hash Security Properties, Birthday Paradox Theorem, & Bit Complexity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of a Birthday Paradox Collision Attack on an n-Bit Hash Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hash Security Property / Algorithm & Attack Complexity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Statistical Principle Proving That Finding ANY Hash Collision Requires Only 2^(n/2) Operations (Birthday Paradox) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Computation of Collision Resistance Operations for MD5 (128-bit) vs SHA-256 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hash Properties (Katz & Lindell 5.1–5.3):
   - **The 3 Canonical Hash Properties:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Property} & \textbf{Given to Adversary} & \textbf{Adversary Goal} & \textbf{Brute-Force Work} \\
     \hline
     \mathbf{\text{Preimage Resistance}} & \text{Target Hash } h & \text{Find any } x \text{ such that } H(x) = h & \mathbf{\mathcal{O}(2^n)} \\
     \mathbf{\text{2nd Preimage Resistance}} & \text{Fixed Input } x_1 & \text{Find } x_2 \ne x_1 \text{ such that } H(x_2) = H(x_1) & \mathbf{\mathcal{O}(2^n)} \\
     \mathbf{\text{Collision Resistance}} & \text{Nothing} & \mathbf{\text{Find ANY } x_1 \ne x_2 \text{ such that } H(x_1) = H(x_2)} & \mathbf{\mathcal{O}(2^{n/2})} \\
     \hline
     \end{array}$$
   - **The Birthday Attack Formula:** By Taylor expansion, $P(\ge 1 \text{ collision in } k \text{ samples}) \approx 1 - e^{-\frac{k^2}{2N}}$. For $P \ge 0.5$, $k \approx \sqrt{2N \ln 2} \approx 1.177 \sqrt{2^n} = \mathbf{\mathcal{O}(2^{n/2})}$.
   - **Implication:** An $n$-bit hash function provides only **$\frac{n}{2}$ bits of collision resistance**!
2. **Slide 2 (`ordering`):** Provide 5 steps of executing a Birthday Attack against an n-bit hash: (1) allocate a hash table in memory to store (hash_digest, input_message) pairs, (2) generate random variations of a benign document D1 and calculate their hashes H(D1_i), (3) generate random variations of a fraudulent document D2 and calculate their hashes H(D2_j), (4) store generated hashes in table and check for a collision match where H(D1_i) = H(D2_j), (5) after computing approximately 2^(n/2) total hashes, a collision is found with probability > 50%; get victim to digitally sign D1_i and transfer signature to fraudulent D2_j!
3. **Slide 3 (`matching`):** Pair 4 properties/hashes (Preimage Resistance, Collision Resistance, MD5 128-bit, SHA-256 256-bit) with their complexity bounds.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the birthday paradox term. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating collision operations for MD5 vs SHA-256: How many hash computations are required on average to find a collision in MD5 (128-bit digest) versus SHA-256 (256-bit digest) using a Birthday Attack, and why was MD5 retired from digital signatures? (MD5 requires only $2^{128/2} = \mathbf{2^{64} \text{ hash computations}}$, which is easily reachable by modern GPUs/ASICs in seconds (and broken in $2^{39}$ by Xiaoyun Wang in 2004); whereas SHA-256 requires $2^{256/2} = \mathbf{2^{128} \approx 3.4 \times 10^{38} \text{ hash computations}}$, requiring more energy than the Earth generates in centuries, making SHA-256 completely collision-resistant).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hash_security_properties_preimage_and_birthday_paradox",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cryptographic Hash Properties & The Birthday Bound**\n• **The 3 Canonical Hash Security Guarantees (Katz & Lindell Chapter 5):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Security Property} & \\textbf{Adversary Condition} & \\textbf{Work Complexity} \\\\\n\\hline\n\\mathbf{\\text{Preimage Resistance}} & \\text{Given } h, \\text{ find any } x \\text{ with } H(x) = h & \\mathbf{\\mathcal{O}(2^n)} \\\\\n\\mathbf{\\text{2nd Preimage Resistance}} & \\text{Given } x_1, \\text{ find } x_2 \\ne x_1 \\text{ with } H(x_2) = H(x_1) & \\mathbf{\\mathcal{O}(2^n)} \\\\\n\\mathbf{\\text{Collision Resistance}} & \\mathbf{\\text{Find ANY } x_1 \\ne x_2 \\text{ with } H(x_1) = H(x_2)} & \\mathbf{\\mathcal{O}(2^{n/2})} \\\\\n\\hline\n\\end{array}\n$$\n• **The Birthday Attack Collision Bound:**\n$$\n\\mathbf{k \\approx 1.177 \\sqrt{2^n} = \\mathbf{\\mathcal{O}(2^{n/2})}}\n$$\n• **Security Implication:** An $n$-bit hash function provides **only $\\frac{n}{2}$ bits of collision security** against an arbitrary collision search!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by an adversary to perform a Birthday Attack collision forgery against a digital signature scheme.",
      "orderItems": [
        "Create thousands of subtle formatting variations of a benign document (D1) and fraudulent contract (D2)",
        "Compute hash digests for all variations of benign document D1 and store (Hash, D1_variant) pairs in a hash table",
        "Compute hash digests for variations of fraudulent document D2, checking for collisions against stored benign hashes",
        "Identify a collision pair after approximately 2^(n/2) total hash calculations where H(D1_i) = H(D2_j)",
        "Obtain the victim's digital signature on benign document D1_i and attach that valid signature directly to fraudulent D2_j"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hash Security Concept to its exact Mathematical Work Complexity.",
      "matchPairs": [
        { "left": "Preimage Resistance", "right": "Requires O(2^n) brute-force evaluations to invert a one-way hash output back to an input" },
        { "left": "Collision Resistance Bound", "right": "Requires O(2^(n/2)) evaluations due to the combinatorial Birthday Paradox" },
        { "left": "MD5 Collision Security (128-bit)", "right": "Theoretical bound of 2^64 operations (catastrophically broken in practical seconds)" },
        { "left": "SHA-256 Collision Security (256-bit)", "right": "Robust bound of 2^128 operations (computationally impossible for all global computers)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mathematical probability phenomenon proving that finding any hash collision requires only 2^(n/2) attempts is the ___ Paradox.",
      "blankAnswer": "Birthday",
      "blankDistractors": ["Avogadro", "Poisson", "Simpson"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How many hash computations are required on average to locate an arbitrary collision in MD5 (128-bit digest) versus SHA-256 (256-bit digest) using a generic Birthday Attack, and why was MD5 banned from digital certificate signatures?",
      "options": [
        { "text": "MD5 requires only 2^(128/2) = 2^64 operations (which modern GPU clusters can compute in seconds, allowing attackers like Xiaoyun Wang and the Flame malware to forge rogue SSL CA certificates); whereas SHA-256 requires 2^(256/2) = 2^128 operations (~3.4 * 10^38 hashes), which would require more energy than the entire Earth consumes in millions of years, making SHA-256 completely unbreakable against collision attacks", "isCorrect": true, "explanation": "Correct! This is the foundational mathematical justification for hash function deprecation (Katz & Lindell Chapter 5.2; Serious Cryptography Chapter 6). 1. **The Birthday Math:** - For an $n$-bit hash function, the space of possible outputs is $N = 2^n$. - The number of random samples $k$ needed to find a collision with $50\\%$ probability is: $k \\approx \\sqrt{N} = \\sqrt{2^n} = \\mathbf{2^{n/2}}$. 2. **Evaluating MD5 (128-bit):** - Collision bound: $2^{128/2} = \\mathbf{2^{64}\\text{ operations}}$. - In 2004, Professor Xiaoyun Wang demonstrated chosen-prefix collision attacks against MD5 in $2^{39}$ operations (minutes on a laptop!). - In 2008, researchers generated a rogue Certificate Authority (CA) certificate using MD5 collisions to intercept HTTPS traffic. MD5 was permanently banned. 3. **Evaluating SHA-256 (256-bit):** - Collision bound: $2^{256/2} = \\mathbf{2^{128}\\text{ operations}}$. - $2^{128} \\approx 3.4 \\times 10^{38}$. - Even if every supercomputer on Earth computed a billion hashes per second for a trillion years, they would not find a single SHA-256 collision. SHA-256 is mathematically secure." },
        { "text": "MD5 requires 128 operations; SHA-256 requires 256 operations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "MD5 requires 2^128 operations; SHA-256 requires 2^256 operations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both require exactly 10,000 operations on an iPhone", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
