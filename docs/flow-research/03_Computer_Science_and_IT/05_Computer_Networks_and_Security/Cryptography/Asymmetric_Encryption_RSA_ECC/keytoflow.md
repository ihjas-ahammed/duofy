# Key to Flow: Asymmetric Cryptography (RSA Key Generation, OAEP Padding, ECC Group Law, & ECDH)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Asymmetric_Encryption_RSA_ECC`

---

## 📌 Core Concept & Mental Model
**Trapdoor One-Way Permutations, Euler's Totient Arithmetic & Modular Inverses (RSA), Probabilistic Asymmetric Padding (RSA-OAEP), Abelian Group Point Arithmetic on Weierstrass Curves, and The Elliptic Curve Discrete Logarithm Problem (ECDLP / ECDH)** govern public-key asymmetric cryptography (Whitfield Diffie & Martin Hellman 1976; Ron Rivest, Adi Shamir, Leonard Adleman 1977 RSA; Mihir Bellare & Phillip Rogaway 1994 RSA-OAEP; Neal Koblitz & Victor Miller 1985 ECC; Daniel J. Bernstein Curve25519; Katz & Lindell Chapters 8–11; Serious Cryptography Chapters 9–12):
* **1. RSA Cryptosystem Architecture (Rivest-Shamir-Adleman 1977):**
  - **Key Generation Pipeline:**
    1. Select large random primes $p, q$ ($p \ne q$).
    2. Compute Modulus $\mathbf{n = p \cdot q}$.
    3. Compute Euler's Totient $\mathbf{\phi(n) = (p-1)(q-1)}$.
    4. Choose Public Exponent $\mathbf{e}$ such that $\gcd(e, \phi(n)) = 1$ (Standard: $e = 65537 = 2^{16}+1$).
    5. Compute Private Exponent $\mathbf{d \equiv e^{-1} \pmod{\phi(n)}}$ using the **Extended Euclidean Algorithm** ($e \cdot d \equiv 1 \pmod{\phi(n)}$).
    - **Public Key:** $(e, n)$; **Private Key:** $(d, n)$ (or secret factors $p, q$).
  - **Encryption & Decryption (Euler-Fermat Theorem):**
    $$\mathbf{C \equiv M^e \pmod n \qquad ; \qquad \mathbf{M \equiv C^d \equiv (M^e)^d \equiv M^{k\phi(n)+1} \equiv M \pmod n}}$$
  - **Hardness Assumption:** Integer Factorization Problem (Factoring $n \to p, q$ is sub-exponentially hard via General Number Field Sieve GNFS).
* **2. Textbook RSA Vulnerabilities & RSA-OAEP (RFC 8017):**
  - **Textbook RSA is Insecure:** Deterministic encryption ($C = M^e \pmod n$) allows frequency analysis, multiplicative malleability ($E(M_1) \cdot E(M_2) = E(M_1 M_2)$), and Bleichenbacher padding attacks.
  - **RSA-OAEP (Optimal Asymmetric Encryption Padding):**
    - Feistel-like 2-round randomized padding using random seed $r$ and Mask Generation Functions (MGF1 based on SHA-256).
    - Guarantees **IND-CCA2 (Indistinguishability under Adaptive Chosen Ciphertext Attack)**.
* **3. Elliptic Curve Cryptography (ECC - Koblitz & Miller 1985):**
  - **Weierstrass Curve Equation over Finite Field $\mathbb{F}_p$ ($p > 3$):**
    $$\mathbf{y^2 \equiv x^3 + ax + b \pmod p \qquad \text{with non-singular condition: } 4a^3 + 27b^2 \not\equiv 0 \pmod p}$$
  - **Group Law & Point Addition (Chord-and-Tangent):**
    - $P + Q = R'$ where line intersecting $P$ and $Q$ hits curve at 3rd point $R$, then reflected across x-axis to $(x_R, -y_R \pmod p)$.
    - Identity Element: **Point at Infinity $\mathcal{O}$** ($P + (-P) = \mathcal{O}$).
  - **Scalar Point Multiplication & The ECDLP:**
    $$\mathbf{Q = d \cdot P = \underbrace{P + P + \dots + P}_{d \text{ times}} \pmod p}$$
    - Given scalar private key $d$ and base generator point $P$, computing public key $Q = dP$ via Double-and-Add is fast ($O(\log d)$).
    - Given $Q$ and $P$, finding private key $d$ is the **Elliptic Curve Discrete Logarithm Problem (ECDLP)** ($O(\sqrt{p})$ via Pollard's Rho, fully exponential!).
* **4. Key Size Scaling & Modern ECDH (Curve25519):**
  - **Security Equivalence:**
    $$\mathbf{256\text{-bit ECC (e.g. Curve25519 / secp256k1)} \approx \mathbf{3072\text{-bit RSA}} \ (128\text{-bit security level})}$$
    $$\mathbf{384\text{-bit ECC (NIST P-384)} \approx \mathbf{7680\text{-bit RSA}} \ (192\text{-bit security level})}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Asymmetric Algorithm Pathway
* Number Theory Foundations $\to$ $\gcd$, Euler's $\phi(n)$, Extended Euclid.
* RSA Math $\to$ $n = pq$, $\phi(n) = (p-1)(q-1)$, $ed \equiv 1 \pmod{\phi(n)}$.
* Secure Padding $\to$ RSA-OAEP (Randomized IND-CCA2).
* Modern Geometric Evolution $\to$ ECC Weierstrass $y^2 = x^3 + ax + b \to$ ECDLP $Q = dP$.

### 2. Top Recommended Resources
* **The Mathematical Standard:** *Introduction to Modern Cryptography* (Jonathan Katz & Yehuda Lindell), Chapters 8, 9, 10, & 11.
* **Applied Engineering:** *Serious Cryptography* (Jean-Philippe Aumasson), Chapters 9 (RSA) & 12 (ECC).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute an RSA keypair given small primes $p, q$ and public exponent $e$?
- [ ] Can you explain why textbook RSA is malleable and why OAEP padding is mandatory?
- [ ] Can you perform point addition and doubling on an elliptic curve using chord-and-tangent arithmetic?
- [ ] Can you contrast RSA 3072-bit vs ECC 256-bit computational and key size scaling?
