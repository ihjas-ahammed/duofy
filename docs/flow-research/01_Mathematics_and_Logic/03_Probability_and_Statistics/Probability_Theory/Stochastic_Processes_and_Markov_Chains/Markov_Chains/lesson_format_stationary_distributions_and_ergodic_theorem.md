# Duofy Reusable Lesson Format: Stationary Distributions and the Ergodic Theorem

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Markov_Chains`  
**Lesson Format Type:** `stationary_distributions_and_ergodic_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the computation of the **Stationary Distribution** $\mathbf{\pi}^T = \mathbf{\pi}^T P$ ($\sum \pi_i = 1$), prove the **Ergodic Theorem** for irreducible, positive recurrent, aperiodic Markov chains ($\lim P_{ij}^{(n)} = \pi_j = 1/\mu_{jj}$), explore the Google PageRank random surfer model, and evaluate time-reversibility via detailed balance.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Stationary Distribution & Ergodic Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Stationary Distribution Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Ergodic Condition & Markov Chain Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Stationary Probability Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Long-Run Time Average Equals Spatial Average Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a Stationary (Invariant / Equilibrium) Distribution: A probability vector $\mathbf{\pi} = (\pi_1, \dots, \pi_{|S|})^T$ satisfying $\mathbf{\pi}^T = \mathbf{\pi}^T P$, $\pi_i \ge 0$, and $\sum_{i \in S} \pi_i = 1$. State the Fundamental Ergodic Theorem: If a Markov chain is **irreducible**, **positive recurrent**, and **aperiodic**, then: (1) A unique stationary distribution $\mathbf{\pi}$ exists, (2) $\lim_{n \to \infty} P_{ij}^{(n)} = \pi_j = \frac{1}{\mu_{jj}}$ for all $i, j \in S$ (where $\mu_{jj} = \mathbb{E}[\tau_j \mid X_0 = j]$ is the mean return time), (3) Ergodicity: $\lim_{N \to \infty} \frac{1}{N}\sum_{n=1}^N f(X_n) = \sum_{j \in S} f(j) \pi_j$ almost surely.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 calculation steps: (1) set up the homogeneous transpose system: $(P^T - I)\mathbf{\pi} = \mathbf{0}$, (2) replace one redundant equation with the normalization condition $\sum_{i=1}^k \pi_i = 1$, (3) solve the linear system via Gaussian elimination, (4) verify that all $\pi_i > 0$ strictly when the chain is irreducible.
3. **Slide 3 (`matching`):** Pair 4 Markov chain concepts (Stationary Distribution, Detailed Balance / Reversibility, Google PageRank, Ergodic Theorem) with their core mathematical descriptions.
4. **Slide 4 (`numerical`):** Ask student: For a 2-state Markov chain with transition matrix $P = \begin{bmatrix} 0.8 & 0.2 \\ 0.4 & 0.6 \end{bmatrix}$, solve $\mathbf{\pi}^T = \mathbf{\pi}^T P$ for $\pi_1 = \frac{\beta}{\alpha + \beta} = \frac{0.4}{0.2 + 0.4} = \frac{0.4}{0.6} = \frac{2}{3} \approx 0.67$ to two decimal places (numeric answer: 0.67).
5. **Slide 5 (`quiz`):** Quiz on the Ergodic Theorem's equality between time averages and ensemble averages: What does the almost sure convergence $\lim_{N \to \infty} \frac{1}{N}\sum_{n=1}^N g(X_n) = \sum_{j} g(j) \pi_j$ signify physically? (The long-term time average of any function along a single sample path equals the spatial statistical ensemble expectation under the stationary distribution $\mathbf{\pi}$, regardless of starting state $X_0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stationary_distributions_and_ergodic_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Stationary Distributions and the Ergodic Theorem**\n• **Stationary Distribution $\\mathbf{\\pi}$:** A probability vector satisfying:\n$$\n\\mathbf{\\pi}^T = \\mathbf{\\pi}^T P, \\qquad \\sum_{i \\in S} \\pi_i = 1, \\quad \\pi_i \\ge 0\n$$\n• **The Fundamental Limit Theorem:** If a discrete-time Markov chain is **irreducible**, **positive recurrent**, and **aperiodic**, then:\n$$\n\\lim_{n \\to \\infty} P_{ij}^{(n)} = \\pi_j = \\frac{1}{\\mu_{jj}} \\quad \\forall i, j \\in S\n$$\nwhere $\\mu_{jj} = \\mathbb{E}[\\tau_j \\mid X_0 = j]$ is the **mean recurrence time** to state $j$.\n• **Ergodicity (Birkhoff Ergodic Theorem):** The long-run time average along any single trajectory equals the spatial ensemble average: $\\lim_{N \\to \\infty} \\frac{1}{N} \\sum_{n=1}^N f(X_n) = \\sum_{j \\in S} f(j) \\pi_j$ almost surely."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Form Transpose System):** Set up the balance equation $(P^T - I)\\mathbf{\\pi} = \\mathbf{0}$.\n• **Step 2 (Drop Redundancy):** Because $\\operatorname{det}(P^T - I) = 0$, replace the last balance equation with the total probability normalization constraint $\\sum_{i} \\pi_i = 1$.\n• **Step 3 (Linear Solve):** Solve the resulting non-singular $(k \\times k)$ linear system $A \\mathbf{\\pi} = \\mathbf{b}$ where $\\mathbf{b} = [0, 0, \\dots, 1]^T$.\n• **Step 4 (Mean Return Times):** Compute the expected steps to return to each state via $\\mu_{ii} = 1 / \\pi_i$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Markov chain stationary property to its mathematical formulation.",
      "matchPairs": [
        { "left": "Global Balance Equations", "right": "pi^T = pi^T P with sum pi_i = 1 (left eigenvector with eigenvalue lambda = 1)" },
        { "left": "Detailed Balance (Reversibility)", "right": "pi_i P_{ij} = pi_j P_{ji} (flux between any two states is symmetric)" },
        { "left": "Mean Recurrence Time", "right": "mu_{ii} = E[tau_i | X_0 = i] = 1 / pi_i" },
        { "left": "Google PageRank Algorithm", "right": "Stationary distribution of web hyperlink graph with random teleportation damping (1 - d)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For a 2-state Markov chain with transition matrix P = [[0.8, 0.2], [0.4, 0.6]], calculate the stationary probability pi_1 = 0.4 / (0.2 + 0.4) to two decimal places.",
      "numericAnswer": 0.67,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the physical and practical significance of the Ergodic Theorem in Markov chain simulation (such as in MCMC or physics simulations)?",
      "options": [
        { "text": "The long-run TIME AVERAGE of any observable function along a single infinite sample path equals the true ENSEMBLE AVERAGE under the stationary distribution: lim (1/N) sum f(X_n) = E_pi[f(X)]", "isCorrect": true, "explanation": "Correct! Ergodicity guarantees that tracking a single long simulation trajectory provides consistent empirical estimates for the entire ensemble probability distribution." },
        { "text": "The chain stops moving after 100 steps", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The transition matrix becomes diagonal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The initial state determines all future states deterministically", "isCorrect": false, "explanation": "Incorrect: Ergodicity guarantees that initial states are forgotten." }
      ]
    }
  ]
}
```
