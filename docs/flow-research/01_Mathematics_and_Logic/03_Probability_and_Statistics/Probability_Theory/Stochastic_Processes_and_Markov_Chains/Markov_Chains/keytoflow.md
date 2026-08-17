# Key to Flow: Markov Chains and Stochastic Processes (Probability Theory)

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Markov_Chains`

---

## 📌 Core Concept & Mental Model
A **Discrete-Time Markov Chain (DTMC)** is a stochastic sequence $\{X_n\}_{n=0}^\infty$ on state space $S$ satisfying the **Markov Memoryless Property**: the future state depends solely on the present state, independent of past history:
* **The Markov Property:**
  $$P(X_{n+1} = j \mid X_n = i, X_{n-1} = i_{n-1}, \dots, X_0 = i_0) = P(X_{n+1} = j \mid X_n = i) = P_{ij}$$
* **The Transition Matrix $P$:**
  $$P \in \mathbb{R}^{|S| \times |S|}, \quad P_{ij} \ge 0, \quad \sum_{j \in S} P_{ij} = 1 \quad (\text{Row-stochastic matrix})$$
* **The Chapman-Kolmogorov Equations:**
  $$P_{ij}^{(n+m)} = \sum_{k \in S} P_{ik}^{(n)} P_{kj}^{(m)} \iff P^{(n+m)} = P^n \cdot P^m$$
* **The Stationary Distribution $\mathbf{\pi}$:**
  $$\mathbf{\pi}^T = \mathbf{\pi}^T P, \qquad \sum_{i \in S} \pi_i = 1, \quad \pi_i \ge 0$$
  *(Left eigenvector of $P$ associated with eigenvalue $\lambda = 1$).*

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. State Classification & Decomposition
* **Communicating Class ($i \leftrightarrow j$):** State $i$ can reach $j$ ($i \to j$) and $j$ can reach $i$ ($j \to i$).
* **Irreducibility:** A chain is **irreducible** if all states belong to a single communicating class.
* **Recurrence vs Transience:** Let $f_{ii} = P(\text{ever return to } i \mid X_0 = i)$:
  * **Recurrent:** $f_{ii} = 1 \iff \sum_{n=1}^\infty P_{ii}^{(n)} = \infty$.
  * **Transient:** $f_{ii} < 1 \iff \sum_{n=1}^\infty P_{ii}^{(n)} < \infty$.
* **Periodicity:** Period $d(i) = \gcd\{n \ge 1 \mid P_{ii}^{(n)} > 0\}$. If $d(i) = 1$, the state is **aperiodic**.

### 2. The Fundamental Ergodic Convergence Theorem
* **Ergodic Theorem:** For any irreducible, positive recurrent, and aperiodic Markov chain:
  $$\lim_{n \to \infty} P_{ij}^{(n)} = \pi_j = \frac{1}{\mu_{jj}} \quad \forall i, j \in S$$
  where $\mu_{jj} = \mathbb{E}[\tau_j \mid X_0 = j]$ is the **mean recurrence time**.
  *(Long-run time average $\lim \frac{1}{N}\sum g(X_n)$ equals spatial ensemble average $\sum g(j) \pi_j$).*

### 3. Absorption Probabilities & Mean Hitting Times
* Partition transition matrix into transient $Q$ and absorbing $R$ states: $P = \begin{bmatrix} Q & R \\ 0 & I \end{bmatrix}$.
* **Fundamental Matrix:** $N = (I - Q)^{-1} = \sum_{k=0}^\infty Q^k$.
* **Mean Time to Absorption:** $\mathbf{k} = N \mathbf{1} = (I - Q)^{-1} \mathbf{1}$.
* **Absorption Probability Matrix:** $B = N R = (I - Q)^{-1} R$.

### 4. Top Recommended Resources
* **The Classical Masterpiece:** *Markov Chains* by J.R. Norris (Cambridge Series in Statistical and Probabilistic Mathematics).
* **Clear Conceptual Foundations:** *Introduction to Probability Models* by Sheldon M. Ross (Chapters 4 & 5).
* **Applied Stochastic Processes:** *Probability and Random Processes* by Geoffrey Grimmett & David Stirzaker.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you set up and solve the linear system $\mathbf{\pi}^T (P - I) = \mathbf{0}, \sum \pi_i = 1$ for a $3 \times 3$ Markov chain?
- [ ] Can you compute the period $d(i)$ of states from transition graphs?
- [ ] Can you calculate the fundamental matrix $N = (I - Q)^{-1}$ to find the expected steps to absorption?
- [ ] Can you verify detailed balance $\pi_i P_{ij} = \pi_j P_{ji}$ for time-reversible Markov chains?
