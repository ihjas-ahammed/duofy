# Duofy Reusable Lesson Format: Non-Regular and Non-CFL Proof Patterns

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Automata_and_Formal_Languages / Pumping_Lemma`  
**Lesson Format Type:** `non_regular_and_non_cfl_proof_patterns`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of non-regular and non-context-free language templates, string-selection heuristics, and pumping exponent choice tactics across theoretical computer science (Michael Sipser Chapters 1 & 2; John E. Hopcroft et al.): master the **4 Archetypal Non-Regularity Proof Archetypes** (**1. Equal Count Patterns: $0^n 1^n$**, **2. Full Palindromes / Duplicated Substrings: $w w$ and $w w^R$**, **3. Quadratic / Exponential Powers: $0^{n^2}$ and $0^{2^n}$**, and **4. Prime Numbers: $0^p$ where $p$ is prime**), master the **Non-CFL Archetypes** (**$a^n b^n c^n$, $a^i b^j c^k$ ($i \le j \le k$), $w w$, and $a^{n^2}$**), formulate strategic pumping exponent selection (**Pumping Up with $i=2$** vs **Pumping Down with $i=0$** to break inequalities), and interact with live pumping game adversary simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Non-Regular & Non-CFL Language Archetypes & Pumping Strategies Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Target Language Pattern & Non-Regular / Non-CFL Proof Heuristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Pumping Prime String 0^p with Exponent i = p + 1 Breaks Primality Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Pumping Exponent Used to Delete the Middle Substrings Entirely (0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Pumping Lemma Adversarial Game Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "non_regular_and_non_cfl_proof_patterns",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the master proof patterns for showing languages are Non-Regular or Non-Context-Free?",
      "blankAnswer": "Formal Language Non-Regularity & Non-CFL Archetypes (Sipser Chapters 1 & 2): (1) EQUAL COUNT PATTERNS: (a) {0^n 1^n} (Non-Regular; use w = 0^p 1^p, y = 0^k, i = 2). (b) {a^n b^n c^n} (Non-CFL; use w = a^p b^p c^p, |vxy| <= p cannot touch all 3 letters). (2) DUPLICATION PATTERNS: (a) {w w | w in {0, 1}*} is NOT CFL (PDA stack reverses strings ww^R, cannot maintain straight order ww)! (b) Use test string w = 0^p 1^p 0^p 1^p. (3) NON-LINEAR GROWTH PATTERNS: (a) {0^(n^2)} (Non-Regular; gap between consecutive squares (n+1)^2 - n^2 = 2n + 1 grows larger than pumping length p; pumping y with 1 <= |y| <= p lands in the gap between squares!). (4) PRIME NUMBERS: (a) {0^q | q is prime} (Non-Regular; choose prime q >= p, let w = 0^q, split w = xyz with |y| = k; pick pumping exponent i = q + 1; length becomes |x y^(q+1) z| = q + q*k = q*(1 + k), which is composite!). (5) PUMPING DOWN (i = 0): Indispensable when language definition requires greater-than inequalities (e.g. {0^i 1^j | i > j})!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each language pattern to its exact non-regular / non-CFL proof strategy.",
      "matchPairs": [
        { "left": "Language: {0^n 1^n}", "right": "Non-Regular: |xy| <= p forces y into 0's; pumping i = 2 imbalances 0 and 1 counts" },
        { "left": "Language: {a^n b^n c^n}", "right": "Non-CFL: |vxy| <= p prevents vy from spanning across all three distinct letter blocks" },
        { "left": "Language: {0^(n^2)}", "right": "Non-Regular: Gap between consecutive squares exceeds max cycle length |y| <= p" },
        { "left": "Language: {0^q | q is prime}", "right": "Non-Regular: Pumping with i = q + 1 produces composite length q*(1 + |y|)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the proof that L = {0^q | q is prime} is NOT regular, let string w = 0^q where q is a prime >= p, and let w = xyz with |y| = k >= 1. Why does choosing the specific pumping exponent i = q + 1 mathematically guarantee a contradiction?",
      "options": [
        { "text": "The length of the pumped string w' = x y^(q+1) z is |w'| = |xz| + (q + 1)|y| = (q - k) + (q + 1)k = q - k + q*k + k = q + q*k = q * (1 + k); because q >= 2 and k >= 1, the number q * (1 + k) is the product of two integers strictly greater than 1, proving the length is composite (not prime), so w' is not in L", "isCorrect": true, "explanation": "Correct! This is one of the most elegant algebraic proofs in automata theory (Michael Sipser Section 1.4). The language is $L = \\{0^q \\mid q \\text{ is prime}\\}$. 1. Assume $L$ is regular with pumping length $p$. 2. Pick a prime number $q \\ge p$, and let test string $w = 0^q \\in L$ (with $|w| = q$). 3. By the Pumping Lemma, $w = xyz$ where $|xy| \\le p$ and $|y| = k \\ge 1$. 4. The unpumped string has length $|w| = |xz| + |y| = |xz| + k = q$, which means $|xz| = q - k$. 5. Now, choose pumping exponent $i = q + 1$. The length of the pumped string $w' = x y^{q+1} z$ is: $|w'| = |xz| + (q + 1)|y| = (q - k) + (q + 1)k = q - k + qk + k = q + qk = q(1 + k)$. 6. Notice that $q \\ge 2$ (since $q$ is prime) and $(1 + k) \\ge 2$ (since $k = |y| \\ge 1$). 7. Therefore, $|w'|$ is the product of two integers $> 1$, which means $|w'| = q(1 + k)$ is COMPOSITE! Because its length is not prime, $w' \\notin L$. This contradiction proves that the language of unary primes is not regular." },
        { "text": "Because q + 1 is always a negative number", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because prime numbers cannot be written with the digit 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all loops in finite automata must have length 2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Pumping down by setting exponent i = ___ removes the cycle substring y completely from the string.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "2", "-1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Pumping Lemma Adversarial Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Pumping Lemma Game (L = {0^n 1^n})</h3><p>Pumping Length p = <span id=\"pLen\" style=\"color:#38bdf8;\">4</span> | w = 00001111</p><p>Adversary Split: x=\"00\", y=\"00\", z=\"1111\"</p><button id=\"pUp\" style=\"padding:6px 12px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Pump Up (i = 2): x y^2 z</button><button id=\"pDown\" style=\"padding:6px 12px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Pump Down (i = 0): x y^0 z</button><div id=\"pumpOut\" style=\"margin-top:12px; color:#fbbf24; font-family:monospace;\">Choose your move to defeat the adversary...</div><script>document.getElementById('pUp').onclick=()=>{document.getElementById('pumpOut').innerText='PUMP UP RESULT:\n• String: \"0000001111\" (6 zeros, 4 ones)\n• 6 != 4 => NOT in L!\nCONTRADICTION FOUND! Language is NOT regular.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; document.getElementById('pDown').onclick=()=>{document.getElementById('pumpOut').innerText='PUMP DOWN RESULT:\n• String: \"001111\" (2 zeros, 4 ones)\n• 2 != 4 => NOT in L!\nCONTRADICTION FOUND! Language is NOT regular.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
