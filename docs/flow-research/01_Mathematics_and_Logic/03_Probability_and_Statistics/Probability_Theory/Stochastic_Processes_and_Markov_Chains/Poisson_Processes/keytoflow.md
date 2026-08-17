# Key to Flow: Poisson Processes & Counting Processes (Probability Theory)

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Poisson_Processes`

---

## 📌 Core Concept & Mental Model
A **Poisson Process** $\{N(t), t \ge 0\}$ with rate $\lambda > 0$ is a continuous-time integer-valued counting process tracking events occurring independently at a constant average rate:
* **The 3 Defining Characterizations:**
  1. **Independent & Stationary Increments:** For any disjoint intervals $(s_1, t_1]$ and $(s_2, t_2]$, increments $N(t_1) - N(s_1)$ and $N(t_2) - N(s_2)$ are independent, with distribution:
     $$P(N(t+s) - N(s) = k) = \frac{(\lambda t)^k e^{-\lambda t}}{k!}, \quad k = 0, 1, 2, \dots$$
  2. **Exponential Interarrival Times:** The waiting times between consecutive arrivals $T_n = S_n - S_{n-1} \overset{\text{i.i.d.}}{\sim} \operatorname{Exp}(\lambda)$ (Memoryless: $P(T > t+s \mid T > s) = P(T > t)$).
  3. **Infinitesimal Formulation:**
     $$P(N(t+h) - N(t) = 1) = \lambda h + o(h), \qquad P(N(t+h) - N(t) \ge 2) = o(h)$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Operations on Poisson Processes
* **Superposition (Merging):** If $N_1(t) \sim \operatorname{PP}(\lambda_1)$ and $N_2(t) \sim \operatorname{PP}(\lambda_2)$ are independent, then the combined stream $N(t) = N_1(t) + N_2(t)$ is a Poisson process with rate $\lambda = \lambda_1 + \lambda_2$.
* **Thinning (Splitting / Decomposition):** If each arrival is independently labeled Type 1 with probability $p$ and Type 2 with probability $1-p$, then $N_1(t) \sim \operatorname{PP}(p\lambda)$ and $N_2(t) \sim \operatorname{PP}((1-p)\lambda)$ are **independent Poisson processes**!

### 2. Generalizations & Order Statistics
* **Uniform Arrival Property (Order Statistics):** Conditional on $N(t) = n$, the $n$ arrival times $(S_1, S_2, \dots, S_n)$ have the exact joint distribution of the **order statistics** of $n$ i.i.d. $\operatorname{Uniform}(0, t)$ random variables.
* **Non-Homogeneous Poisson Process (NHPP):** Time-varying rate $\lambda(t) \ge 0$. Mean value function $m(t) = \int_0^t \lambda(s) ds$, with increment $N(t+s) - N(s) \sim \operatorname{Pois}(m(t+s) - m(s))$.
* **Compound Poisson Process:** $X(t) = \sum_{i=1}^{N(t)} Y_i$ where $Y_i \overset{\text{i.i.d.}}{\sim} F_Y$.
  $$\mathbb{E}[X(t)] = \lambda t \, \mathbb{E}[Y], \qquad \operatorname{Var}(X(t)) = \lambda t \, \mathbb{E}[Y^2] \quad (\text{Wald's Identity})$$

### 3. Top Recommended Resources
* **The Premier Stochastic Reference:** *Introduction to Probability Models* by Sheldon M. Ross (Chapter 5: The Poisson Process).
* **Deep Probabilistic Theory:** *Adventures in Stochastic Processes* by Sidney I. Resnick.
* **Classical Foundations:** *Stochastic Processes* by Emanuel Parzen.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you switch between counting representation $N(t) \ge n$ and arrival time representation $S_n \le t$?
- [ ] Can you calculate probabilities for merged and thinned Poisson event streams?
- [ ] Can you evaluate conditional expected values $\mathbb{E}[S_k \mid N(t) = n] = \frac{k}{n+1} t$?
- [ ] Can you compute the mean and variance of a Compound Poisson process using Wald's identity?
