# Key to Flow: Elementary Number Theory

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory`

---

## 📌 Core Concept & Mental Model
Elementary Number Theory studies the properties of the Integers $\mathbb{Z}$, primes, divisibility, and congruences without relying on complex analysis or advanced abstract algebra.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Fundamental Theorems & Algorithms
* **Euclidean Algorithm:** Computes $\gcd(a, b)$ efficiently via repeated division.
* **Bézout's Identity:** $\gcd(a, b) = a x + b y$ for integers $x, y \in \mathbb{Z}$.
* **Fundamental Theorem of Arithmetic:** Every integer $n > 1$ factors uniquely into a product of prime numbers.
* **Modular Arithmetic Toolkit:**
  * **Fermat's Little Theorem:** $a^{p-1} \equiv 1 \pmod p$ for prime $p \nmid a$.
  * **Euler's Totient Theorem:** $a^{\phi(n)} \equiv 1 \pmod n$ for $\gcd(a, n) = 1$.
  * **Chinese Remainder Theorem (CRT):** Solves systems of simultaneous congruences with coprime moduli.
  * **Quadratic Reciprocity (Gauss's Golden Theorem):** Tells whether $x^2 \equiv p \pmod q$ is solvable using Legendre Symbols $\left(\frac{p}{q}\right)\left(\frac{q}{p}\right) = (-1)^{\frac{p-1}{2}\frac{q-1}{2}}$.

### 2. Top Recommended Resources
* **Standard Introductory Text:** *Elementary Number Theory* by David M. Burton.
* **Problem Solving Focus:** *An Introduction to the Theory of Numbers* by Niven, Zuckerman, and Montgomery.
* **Olympiad & Problem Practice:** *Number Theory: Concepts and Problems* by Titu Andreescu.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you apply the Extended Euclidean Algorithm to solve linear Diophantine equations $a x + b y = c$?
- [ ] Can you solve systems of congruences using the Chinese Remainder Theorem?
- [ ] Can you calculate Legendre and Jacobi symbols to evaluate quadratic residues?
- [ ] Can you compute Euler's phi function $\phi(n) = n \prod_{p|n} (1 - \frac{1}{p})$?
