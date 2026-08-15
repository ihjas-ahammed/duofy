# Key to Flow: Divisibility and Prime Numbers (Elementary Number Theory)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Divisibility_and_Prime_Numbers`

---

## 📌 Core Concept & Mental Model
**Divisibility and Primality** constitute the atomic foundation of all discrete arithmetic on the ring of integers $\mathbb{Z}$:
* **The Division Algorithm:** For any $a \in \mathbb{Z}$ and $b \in \mathbb{Z}^+$, there exist unique integers $q, r$ such that:
  $$a = bq + r, \quad 0 \le r < b$$
* **Greatest Common Divisor $\gcd(a, b)$ & Bézout's Identity:** The smallest positive integer linear combination:
  $$\gcd(a, b) = \min \{ax + by > 0 \mid x, y \in \mathbb{Z}\} \implies \exists x, y \in \mathbb{Z}: ax + by = \gcd(a, b)$$
* **The Fundamental Theorem of Arithmetic (FTA):** Every integer $n \ge 2$ can be factored **uniquely** (up to order) as a product of prime numbers:
  $$n = p_1^{a_1} p_2^{a_2} \dots p_k^{a_k}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Core Theorems of Elementary Number Theory
1. **Euclidean Algorithm & Extended Euclidean Algorithm:** Computes $\gcd(a, b)$ in $\mathcal{O}(\log(\min(a, b)))$ steps by iterated remainders $r_{k-1} = q_k r_k + r_{k+1}$, and back-substitutes to find Bézout coefficients $x, y$.
2. **Euclid's Lemma:** If $p$ is prime and $p \mid ab$, then $p \mid a$ or $p \mid b$. (The crucial logical bridge proving uniqueness in the FTA).
3. **Infinitude of Primes (Euclid's Proof):** Given any finite list of primes $\{p_1, \dots, p_n\}$, the integer $N = p_1 p_2 \dots p_n + 1$ is not divisible by any $p_i$, proving primes never terminate.
4. **Sieve of Eratosthenes:** Finds all primes up to $N$ in $\mathcal{O}(N \log \log N)$ time by successively crossing out multiples of primes $p \le \sqrt{N}$.

### 2. Multiplicative Arithmetic Functions
* **Divisor Count $\tau(n) = \sum_{d \mid n} 1 = \prod (a_i + 1)$.**
* **Divisor Sum $\sigma(n) = \sum_{d \mid n} d = \prod \frac{p_i^{a_i+1} - 1}{p_i - 1}$.**
* **Euler's Totient Function $\phi(n) = n \prod_{p \mid n} \left(1 - \frac{1}{p}\right)$:** Counts integers $1 \le k \le n$ coprime to $n$.

### 3. Top Recommended Resources
* **The Gold Standard Text:** *Elementary Number Theory* by David M. Burton.
* **Classical Depth:** *An Introduction to the Theory of Numbers* by G.H. Hardy & E.M. Wright.
* **Competition & Problem-Solving:** *The Art of Problem Solving: Number Theory* by Mathew Crawford.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you run the Euclidean Algorithm and find Bézout coefficients $x, y$ such that $ax + by = \gcd(a, b)$?
- [ ] Can you prove Euclid's Lemma using Bézout's Identity?
- [ ] Can you calculate $\tau(n)$, $\sigma(n)$, and $\phi(n)$ directly from the prime factorization of $n$?
- [ ] Can you prove that $\sqrt{p}$ is irrational for any prime $p$ using the Fundamental Theorem of Arithmetic?
