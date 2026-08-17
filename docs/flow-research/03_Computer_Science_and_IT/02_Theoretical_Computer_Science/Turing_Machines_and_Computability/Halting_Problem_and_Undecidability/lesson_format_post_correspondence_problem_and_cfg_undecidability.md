# Duofy Reusable Lesson Format: Post Correspondence Problem and CFG Undecidability

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Turing_Machines_and_Computability / Halting_Problem_and_Undecidability`  
**Lesson Format Type:** `post_correspondence_problem_and_cfg_undecidability`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid combinatoric string matching, computation history tile reductions, and Context-Free Grammar undecidability proofs across Post's Correspondence Problem (PCP) (Emil L. Post 1946, *A Variant of a Recursively Unsolvable Problem*; Michael Sipser Chapter 5.2): formulate the **PCP Domino Matching Invariant** (given dominoes $\{[\frac{t_1}{b_1}], \dots, [\frac{t_k}{b_k}]\}$, find index sequence $i_1, \dots, i_m$ such that top string concatenation equals bottom string concatenation: $\mathbf{t_{i_1}} \dots t_{i_m} = \mathbf{b_{i_1}} \dots b_{i_m}$), formulate the **Modified PCP (MPCP)** requiring domino 1 first, trace the reduction from **Turing Machine Valid Computation Histories to MPCP**, execute reductions from PCP to prove the undecidability of CFG decision problems (**1. CFG Ambiguity**, **2. CFG Intersection Emptiness $L(G_1) \cap L(G_2) = \emptyset$**, and **3. CFG Universality $L(G) = \Sigma^*$**), and interact with live domino matching simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Post Correspondence Problem Tile Invariant, MPCP, & CFG Reductions Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | PCP Domino Formalism / Problem & Undecidability Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why CFG Ambiguity is Proven Undecidable via Reduction from PCP Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the Problem Asking Whether a Valid Match Sequence Exists for String Dominoes (PCP) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Post Correspondence Problem (PCP) Domino Matching Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "post_correspondence_problem_and_cfg_undecidability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Post Correspondence Problem (PCP) and how is it used to prove that CFG Ambiguity is Undecidable?",
      "blankAnswer": "Post Correspondence Problem (PCP) and Formal Language Undecidability (Post 1946; Sipser Chapter 5.2): (1) THE PCP PUZZLE: Given a collection of dominoes P = {[t_1 / b_1], [t_2 / b_2], ... [t_k / b_k]}. A match is a sequence of indices i_1, i_2, ... i_m such that: t_{i_1} t_{i_2} ... t_{i_m} == b_{i_1} b_{i_2} ... b_{i_m}! (2) THEOREM: PCP is mathematically UNDECIDABLE (proven by encoding Turing machine valid computation histories into domino tiles)! (3) CFG REDUCTIONS VIA PCP: (a) CFG Ambiguity: Undecidable (construct grammar G where top and bottom domino chains produce identical string iff PCP has a match; match produces two distinct parse trees!). (b) CFG Intersection Emptiness (Is L(G1) cap L(G2) == empty?): Undecidable! (c) CFG Universality (Is L(G) == Sigma*?): Undecidable! (4) BRIDGE: PCP serves as the primary bridge translating undecidability from Turing Machines into Context-Free Grammars!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each PCP / Formal Language concept to its exact theoretical property.",
      "matchPairs": [
        { "left": "PCP Match Condition", "right": "A non-empty index sequence producing identical concatenated top and bottom string words" },
        { "left": "Modified PCP (MPCP)", "right": "Restricted variant requiring the match sequence to begin strictly with the first domino tile [t1 / b1]" },
        { "left": "CFG Ambiguity Problem", "right": "UNDECIDABLE: Proven by reduction from PCP where a domino match generates ambiguous parse trees" },
        { "left": "CFG Universality: L(G) = Sigma*", "right": "UNDECIDABLE: Proven by generating the language of invalid Turing machine computation histories" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How is the Post Correspondence Problem (PCP) used in formal language theory to prove that deciding whether a Context-Free Grammar is Ambiguous is mathematically UNDECIDABLE?",
      "options": [
        { "text": "Given a PCP instance with dominoes [t_i / b_i], construct a CFG with rules generating top string-index pairs (A -> t_i A a_i | t_i a_i) and bottom string-index pairs (B -> b_i B a_i | b_i a_i) under start symbol S -> A | B; grammar G generates the same string from both A and B branches if and only if top string equals bottom string with matching index tags, meaning grammar G is ambiguous if and only if the PCP instance has a valid match", "isCorrect": true, "explanation": "Correct! This is the classic reduction developed by Emil Post to prove the undecidability of CFG ambiguity (Michael Sipser Theorem 5.15). 1. Given a PCP instance with $k$ dominoes $P = \\left\\{ \\left[ \\frac{t_1}{b_1} \\right], \\dots, \\left[ \\frac{t_k}{b_k} \\right] \\right\\}$. 2. We introduce $k$ unique index marker symbols $a_1, a_2, \\dots, a_k$ not present in the original alphabet. 3. We construct a CFG $G = (V, \\Sigma, R, S)$ with start symbol $S \\to A \\mid B$: - Variable $A$ generates top strings followed by their reversed index sequence: $A \\to t_1 A a_1 \\mid \\dots \\mid t_k A a_k \\mid t_1 a_1 \\mid \\dots \\mid t_k a_k$. - Variable $B$ generates bottom strings followed by their reversed index sequence: $B \\to b_1 B a_1 \\mid \\dots \\mid b_k B a_k \\mid b_1 a_1 \\mid \\dots \\mid b_k a_k$. 4. Notice that variable $A$ generates strings of the form $t_{i_1} \\dots t_{i_m} a_{i_m} \\dots a_{i_1}$, while variable $B$ generates $b_{j_1} \\dots b_{j_n} a_{j_n} \\dots a_{j_1}$. 5. Because the index markers $a_i$ are unique, variable $A$ is individually unambiguous, and variable $B$ is individually unambiguous. 6. Therefore, the ONLY way grammar $G$ can generate a string with TWO distinct parse trees (one derived from $A$ and one derived from $B$) is if there exists a string where the top text equals the bottom text AND the index sequences match exactly ($t_{i_1} \\dots t_{i_m} = b_{i_1} \\dots b_{i_m}$)! 7. Thus, grammar $G$ is ambiguous IF AND ONLY IF the PCP instance has a valid match. Since PCP is undecidable, deciding CFG ambiguity is provably undecidable." },
        { "text": "Because all CFGs with more than 5 rules are automatically ambiguous", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because PCP dominoes can only be parsed by regular expressions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because compilers cannot execute context-free grammar derivations", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The string-tile puzzle invented by Emil Post in 1946 used to prove grammar undecidability is called the Post ___ Problem.",
      "blankAnswer": "Correspondence",
      "blankDistractors": ["Complement", "Computation", "Confluence"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Post Correspondence Problem (PCP) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>PCP Domino Matcher Engine</h3><p>Dominoes: 1: [b / ca] | 2: [a / ab] | 3: [ca / a] | 4: [abc / c]</p><p>Sequence: <span id=\"domSeq\" style=\"color:#38bdf8; font-weight:bold;\">[]</span></p><div style=\"border:1px solid #475569; padding:10px; border-radius:6px; min-width:280px;\">Top String: <span id=\"topStr\" style=\"color:#10b981;\">-</span><br>Bottom String: <span id=\"botStr\" style=\"color:#f59e0b;\">-</span></div><div style=\"margin-top:10px;\"><button id=\"d3\" style=\"padding:4px 8px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Tile 3 [ca/a]</button><button id=\"d2\" style=\"padding:4px 8px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Tile 2 [a/ab]</button><button id=\"d1\" style=\"padding:4px 8px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Tile 1 [b/ca]</button><button id=\"d4\" style=\"padding:4px 8px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Tile 4 [abc/c]</button><button id=\"rst\" style=\"padding:4px 8px; margin:2px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">Reset</button></div><div id=\"pcpRes\" style=\"margin-top:10px; color:#fbbf24; font-family:monospace;\">Find sequence where Top == Bottom! (Hint: 3, 2, 1, 4)</div><script>let seq=[], D={1:['b','ca'], 2:['a','ab'], 3:['ca','a'], 4:['abc','c']}; function add(k){seq.push(k); update();} function rst(){seq=[]; update();} function update(){let top='', bot=''; for(let k of seq){top+=D[k][0]; bot+=D[k][1];} document.getElementById('domSeq').innerText='['+seq.join(', ')+']'; document.getElementById('topStr').innerText=top||'-'; document.getElementById('botStr').innerText=bot||'-'; if(seq.length>0 && top===bot){document.getElementById('pcpRes').innerText='MATCH FOUND! \"'+top+'\" == \"'+bot+'\"! (PCP Solved for this instance)'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');} else{document.getElementById('pcpRes').innerText=seq.length>0?'Strings not equal yet...':'Select tiles above';}} document.getElementById('d1').onclick=()=>add(1); document.getElementById('d2').onclick=()=>add(2); document.getElementById('d3').onclick=()=>add(3); document.getElementById('d4').onclick=()=>add(4); document.getElementById('rst').onclick=rst;</script></div>"
    }
  ]
}
```
