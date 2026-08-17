# Duofy Reusable Lesson Format: State Classification, Recurrence, and Periodicity

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Markov_Chains`  
**Lesson Format Type:** `state_classification_recurrence_and_periodicity`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to classify states in Markov Chains: decompose state space into **Communicating Classes**, determine **Irreducibility**, distinguish **Recurrence** ($\sum P_{ii}^{(n)} = \infty$) from **Transience** ($\sum P_{ii}^{(n)} < \infty$), calculate the **Period** $d(i) = \gcd\{n \ge 1 \mid P_{ii}^{(n)} > 0\}$, and evaluate Polya's Random Walk recurrence theorem in $\mathbb{Z}^d$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | State Classification & Recurrence Criteria Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Periodicity Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Markov State Classification Criterion Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Finite Irreducible Positive Recurrence Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Polya's Random Walk Recurrence in Dimensions Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definitions: (1) Accessibility & Communication: $i \to j$ if $P_{ij}^{(n)} > 0$ for some $n \ge 0$; $i \leftrightarrow j$ if $i \to j$ and $j \to i$. (2) Irreducibility: The chain has exactly one communicating class. (3) Recurrence vs Transience: Let $f_{ii} = P(\tau_i < \infty \mid X_0 = i)$. State Theorem: $i$ is recurrent $\iff f_{ii} = 1 \iff \sum_{n=1}^\infty P_{ii}^{(n)} = \infty$; $i$ is transient $\iff f_{ii} < 1 \iff \sum_{n=1}^\infty P_{ii}^{(n)} < \infty$. (4) Periodicity: $d(i) = \gcd\{n \ge 1 \mid P_{ii}^{(n)} > 0\}$; if $d(i) = 1$, $i$ is aperiodic.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) draw the directed transition graph of the Markov chain, (2) identify all closed paths starting and ending at state $i$, (3) list the lengths of all possible return cycles $\{n_1, n_2, n_3, \dots\}$, (4) compute the greatest common divisor $\gcd(n_1, n_2, \dots)$, (5) observe class property: periodicity is a class property (all communicating states share the identical period).
3. **Slide 3 (`matching`):** Pair 4 state classifications (Recurrent State, Transient State, Absorbing State $P_{ii} = 1$, Aperiodic State $d(i) = 1$) with their exact mathematical conditions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in any finite-state irreducible Markov chain, all states are strictly positive recurrent. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question on George Pólya's 1921 Random Walk Theorem: For a simple symmetric random walk on the $d$-dimensional integer lattice $\mathbb{Z}^d$, in what dimensions is the origin RECURRENT? (Recurrent in dimensions $d = 1$ and $d = 2$, but TRANSIENT for all dimensions $d \ge 3$: *"A drunk man will always find his way home, but a drunk bird may get lost forever"*).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "state_classification_recurrence_and_periodicity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**State Classification: Communicating Classes, Recurrence, and Periodicity**\n• **Communicating Class ($i \\leftrightarrow j$):** States $i$ and $j$ can reach each other ($P_{ij}^{(n)} > 0$ and $P_{ji}^{(m)} > 0$).\n• **Irreducibility:** A chain where all states communicate as a single class.\n• **Recurrence vs. Transience Criterion:**\n$$\n\\text{State } i \\text{ is } \\begin{cases} \\textbf{Recurrent} & \\iff \\sum_{n=1}^\\infty P_{ii}^{(n)} = \\infty \\quad (P(\\text{returns}) = 1) \\\\ \\textbf{Transient} & \\iff \\sum_{n=1}^\\infty P_{ii}^{(n)} < \\infty \\quad (P(\\text{returns}) < 1) \\end{cases}\n$$\n• **Periodicity:** The period of state $i$ is $d(i) = \\gcd\\{n \\ge 1 \\mid P_{ii}^{(n)} > 0\\}$. If $d(i) = 1$, the state is **aperiodic**.\n• **Class Property:** Communicating states share identical recurrence and periodicity!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Return Cycles):** Identify all return loops from state $i$ back to $i$ on the transition diagram.\n• **Step 2 (List Path Lengths):** Record loop lengths $\\{n_1, n_2, \\dots\\}$ where $P_{ii}^{(n_k)} > 0$.\n• **Step 3 (Compute GCD):** Calculate $d(i) = \\gcd(n_1, n_2, \\dots)$. If $P_{ii} > 0$ (self-loop exists), $d(i) = \\gcd(1, \\dots) = 1$ (instantly aperiodic!).\n• **Step 4 (Propagate Across Class):** By the class property theorem, every state in the same communicating class inherits the identical period $d$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each state classification to its defining mathematical property.",
      "matchPairs": [
        { "left": "Recurrent State", "right": "sum_{n=1}^infty P_{ii}^{(n)} = infty (expected number of visits is infinite)" },
        { "left": "Transient State", "right": "sum_{n=1}^infty P_{ii}^{(n)} < infty (expected number of visits is finite)" },
        { "left": "Absorbing State", "right": "P_{ii} = 1 (once entered, the process can never leave)" },
        { "left": "Aperiodic State", "right": "Period d(i) = gcd{n >= 1 | P_{ii}^{(n)} > 0} = 1" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In any finite-state irreducible Markov chain, every single state is strictly positive ___.",
      "blankAnswer": "recurrent",
      "blankDistractors": ["transient", "absorbing", "periodic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to George Pólya's famous 1921 theorem on simple symmetric random walks on the d-dimensional integer lattice Z^d, in which dimensions is the origin RECURRENT?",
      "options": [
        { "text": "Recurrent for dimensions d = 1 and d = 2; strictly TRANSIENT for all dimensions d >= 3", "isCorrect": true, "explanation": "Correct! As Shizuo Kakutani famously put it: 'A drunk man will find his way home (d=2), but a drunk bird may get lost forever (d=3)'." },
        { "text": "Recurrent in all dimensions d >= 1", "isCorrect": false, "explanation": "Incorrect: In 3D and higher, the probability of returning is < 1." },
        { "text": "Transient in all dimensions", "isCorrect": false, "explanation": "Incorrect: 1D and 2D random walks are recurrent." },
        { "text": "Recurrent only in dimension d = 1", "isCorrect": false, "explanation": "Incorrect: 2D random walks are also recurrent." }
      ]
    }
  ]
}
```
