# Duofy Reusable Lesson Format: Non-Homogeneous and Compound Poisson Processes

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Poisson_Processes`  
**Lesson Format Type:** `non_homogeneous_and_compound_poisson_processes`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze **Non-Homogeneous Poisson Processes (NHPP)** with time-dependent intensity $\lambda(t)$ and integrated mean value function $m(t) = \int_0^t \lambda(s) ds$, formulate **Compound Poisson Processes** $X(t) = \sum_{i=1}^{N(t)} Y_i$ for insurance claim modeling and financial jumps, and apply **Wald's Identity** and the **Law of Total Variance** ($\mathbb{E}[X(t)] = \lambda t \mathbb{E}[Y], \operatorname{Var}(X(t)) = \lambda t \mathbb{E}[Y^2]$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | NHPP & Compound Poisson Mathematical Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Wald's Identity Mean & Variance Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Counting Process Extension & Statistical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Time-Dependent Rate Mean Value Integral Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Compound Poisson Second Moment Variance Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Non-Homogeneous Poisson Process (NHPP) definition: A counting process $\{N(t), t \ge 0\}$ with intensity function $\lambda(t) \ge 0$ and mean value function $m(t) = \int_0^t \lambda(s) ds$. Increments $N(t+s) - N(s) \sim \operatorname{Pois}(m(t+s) - m(s))$. State the Compound Poisson Process: $X(t) = \sum_{i=1}^{N(t)} Y_i$ where $\{N(t)\}$ is a homogeneous Poisson process of rate $\lambda$, and $Y_1, Y_2, \dots$ are i.i.d. random jump sizes independent of $N(t)$. State Wald's Identities: $\mathbb{E}[X(t)] = \lambda t \mathbb{E}[Y]$, $\operatorname{Var}(X(t)) = \lambda t \mathbb{E}[Y^2]$.
2. **Slide 2 (`concept_pieces`):** Deconstruct conditional expectation derivations: (1) evaluate $\mathbb{E}[X(t)] = \mathbb{E}[\mathbb{E}[X(t) \mid N(t)]]$, (2) given $N(t) = n$, $\mathbb{E}[\sum_{i=1}^n Y_i \mid N(t) = n] = n \mathbb{E}[Y]$, (3) $\mathbb{E}[N(t) \mathbb{E}[Y]] = \mathbb{E}[N(t)] \mathbb{E}[Y] = (\lambda t) \mathbb{E}[Y]$, (4) apply Eve's Law: $\operatorname{Var}(X(t)) = \mathbb{E}[\operatorname{Var}(X \mid N)] + \operatorname{Var}(\mathbb{E}[X \mid N]) = \mathbb{E}[N \operatorname{Var}(Y)] + \operatorname{Var}(N \mathbb{E}[Y]) = \lambda t \operatorname{Var}(Y) + \lambda t (\mathbb{E}[Y])^2 = \lambda t (\operatorname{Var}(Y) + (\mathbb{E}[Y])^2) = \lambda t \mathbb{E}[Y^2]$.
3. **Slide 3 (`matching`):** Pair 4 processes (Homogeneous Poisson Process, Non-Homogeneous Poisson Process, Compound Poisson Process, Marked Poisson Process) with their defining properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the mean value function $m(t)$ in an NHPP is obtained by integrating the intensity rate function lambda(s). Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question on Compound Poisson variance: Why does $\operatorname{Var}(X(t)) = \lambda t \mathbb{E}[Y^2]$ depend on the second raw moment $\mathbb{E}[Y^2]$ rather than simply $\operatorname{Var}(Y)$? (Because total variance comes from TWO independent sources of randomness: the uncertainty in the jump sizes $\operatorname{Var}(Y)$ PLUS the randomness in the total number of arrivals $\operatorname{Var}(N) (\mathbb{E}[Y])^2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "non_homogeneous_and_compound_poisson_processes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Non-Homogeneous and Compound Poisson Processes**\n• **Non-Homogeneous Poisson Process (NHPP):** Has **time-dependent intensity** $\\lambda(t) \\ge 0$.\n  - **Mean Value Function:** $m(t) = \\int_0^t \\lambda(s) \\, ds$.\n  - **Increments:** $N(t+s) - N(s) \\sim \\operatorname{Pois}\\left( m(t+s) - m(s) \\right)$.\n• **Compound Poisson Process:** Tracks cumulative jump values $X(t) = \\sum_{i=1}^{N(t)} Y_i$ where:\n  - $N(t) \\sim \\operatorname{PP}(\\lambda)$ is a Poisson counting process.\n  - $Y_1, Y_2, \\dots \\overset{\\text{i.i.d.}}{\\sim} F_Y$ are random claim/jump amounts independent of $N(t)$.\n• **Wald's Identity & Variance Formula:**\n$$\n\\mathbb{E}[X(t)] = \\lambda t \\, \\mathbb{E}[Y], \\qquad \\operatorname{Var}(X(t)) = \\lambda t \\, \\mathbb{E}[Y^2]\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Condition on Count):** By the Law of Total Expectation:\n  $$\\mathbb{E}[X(t)] = \\mathbb{E}[\\mathbb{E}[X(t) \\mid N(t)]] = \\mathbb{E}[N(t) \\mathbb{E}[Y]] = (\\lambda t) \\mathbb{E}[Y]$$\n• **Step 2 (Law of Total Variance):**\n  $$\\operatorname{Var}(X(t)) = \\mathbb{E}[\\operatorname{Var}(X(t) \\mid N(t))] + \\operatorname{Var}(\\mathbb{E}[X(t) \\mid N(t)])$$\n• **Step 3 (Substitute Conditionals):**\n  $$= \\mathbb{E}[N(t) \\operatorname{Var}(Y)] + \\operatorname{Var}(N(t) \\mathbb{E}[Y]) = (\\lambda t) \\operatorname{Var}(Y) + (\\lambda t) (\\mathbb{E}[Y])^2$$\n• **Step 4 (Combine Moments):** Factor $\\lambda t$:\n  $$\\operatorname{Var}(X(t)) = \\lambda t \\left( \\operatorname{Var}(Y) + (\\mathbb{E}[Y])^2 \\right) = \\lambda t \\mathbb{E}[Y^2]$$"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each stochastic counting model to its mathematical definition.",
      "matchPairs": [
        { "left": "Homogeneous Poisson Process", "right": "Constant rate lambda with stationary independent increments" },
        { "left": "Non-Homogeneous Poisson Process", "right": "Time-varying intensity lambda(t) with mean measure m(t) = int_0^t lambda(s) ds" },
        { "left": "Compound Poisson Process", "right": "Random sum X(t) = sum_{i=1}^{N(t)} Y_i with jump sizes Y_i" },
        { "left": "Spatial Poisson Process", "right": "Counts random points scattered across multidimensional subset A subset R^d" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a non-homogeneous Poisson process, the expected number of arrivals m(t) = E[N(t)] is computed by integrating the intensity rate function ___.",
      "blankAnswer": "lambda",
      "blankDistractors": ["mu", "sigma", "gamma"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the total variance of a Compound Poisson process Var(X(t)) = lambda * t * E[Y^2] depend on the SECOND RAW MOMENT E[Y^2] rather than simply Var(Y)?",
      "options": [
        { "text": "Total variance stems from TWO distinct sources of randomness: the variance within jump sizes Var(Y) AND the variance in the number of arrivals Var(N(t)) * (E[Y])^2", "isCorrect": true, "explanation": "Correct! By Eve's Law of Total Variance, Var(X) = E[N]Var(Y) + Var(N)(E[Y])^2 = lambda t [Var(Y) + (E[Y])^2] = lambda t E[Y^2]." },
        { "text": "Because Poisson counts have zero variance", "isCorrect": false, "explanation": "Incorrect: Var(N(t)) = lambda t." },
        { "text": "Because jumps cannot be negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because E[Y] is always zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
