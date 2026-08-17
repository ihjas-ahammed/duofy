# Key to Flow: Cryptographic Hash Functions (Preimage Resistance, Merkle-Damgård, Keccak Sponges, & HMAC)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Cryptographic_Hash_Functions_SHA_MD5`

---

## 📌 Core Concept & Mental Model
**One-Way Compression Mappings, The Birthday Paradox $2^{n/2}$ Collision Bound, Iterative Merkle-Damgård Chaining vs Length Extension Attacks, The SHA-3 Keccak Sponge Permutation (Absorb & Squeeze), and Nested Keyed Message Authentication Codes (HMAC RFC 2104)** govern cryptographic hashing and data integrity verification (Ralph Merkle & Ivan Damgård 1979; Mihir Bellare et al. 1996 RFC 2104 HMAC; NIST FIPS 180-4 SHA-2; NIST FIPS 202 SHA-3 Keccak; Katz & Lindell Chapter 5; Serious Cryptography Chapters 6–7):
* **1. The 3 Fundamental Hash Security Properties:**
  - **1. Preimage Resistance (One-Wayness):** Given hash output $h = H(x)$, it is computationally infeasible to find *any* original input $x$. Work complexity: $\mathbf{\mathcal{O}(2^n)}$.
  - **2. Second Preimage Resistance (Weak Collision Resistance):** Given a fixed input $x_1$, it is computationally infeasible to find a *different* input $x_2 \ne x_1$ such that $H(x_1) = H(x_2)$. Work complexity: $\mathbf{\mathcal{O}(2^n)}$.
  - **3. Collision Resistance (Strong Collision Resistance):** It is computationally infeasible to find *any pair* of distinct inputs $(x_1, x_2)$ with $x_1 \ne x_2$ such that $H(x_1) = H(x_2)$.
  - **The Birthday Attack Collision Bound:**
    $$\mathbf{\text{Operations to find a collision in } n\text{-bit hash} \approx \sqrt{2^n} = \mathbf{2^{n/2}}}$$
    - MD5 (128-bit) $\implies 2^{64}$ ops (Broken in 2004 by Xiaoyun Wang; collisions generated in seconds!).
    - SHA-1 (160-bit) $\implies 2^{80}$ ops (Broken in 2017 by Google SHAttered).
    - SHA-256 (256-bit) $\implies \mathbf{2^{128} \text{ ops (Unbreakable: exceeds all computational power on Earth)}}$.
* **2. Merkle-Damgård Construction & Length Extension Attacks:**
  - Used in MD5, SHA-1, SHA-256, SHA-512.
  - Splits padded message into $m$-bit blocks $M_1, M_2, \dots, M_k$. State recurrence:
    $$s_0 = IV \qquad ; \qquad s_i = f(s_{i-1}, M_i) \qquad ; \qquad H(M) = s_k$$
  - **The Length Extension Attack:** Because the final hash $H(M)$ is the raw internal state $s_k$, an attacker knowing $H(M)$ and the length of $M$ can continue the hash chain: $H(M \ || \ \text{pad} \ || \ M_{\text{extra}}) = f(H(M), M_{\text{extra}})$ *without knowing the secret prefix key $M$*!
* **3. SHA-3 / Keccak Sponge Construction (FIPS 202):**
  - Uses an internal state of $b = r + c = 1600\text{ bits}$ ($r = \text{Rate [bandwidth]}$, $c = \text{Capacity [security level]}$).
  - **Absorbing Phase:** Message blocks are XORed into the first $r$ bits of state and transformed by permutation $f$ ($24\text{ rounds of }\theta, \rho, \pi, \chi, \iota$).
  - **Squeezing Phase:** Output digest is extracted $r$ bits at a time.
  - *Advantage:* **Completely immune to Length Extension Attacks** because the capacity $c$ remains hidden!
* **4. Keyed-Hashing for Message Authentication (HMAC - RFC 2104):**
  - Secures message integrity and authentication using a shared secret key $K$:
    $$\mathbf{\text{HMAC}(K, M) = H\Big((K \oplus \text{opad}) \ \Big|\Big| \ H\big((K \oplus \text{ipad}) \ \Big|\Big| \ M\big)\Big)}$$
    - Constants: $\text{ipad} = \text{0x3636\dots36}$, $\text{opad} = \text{0x5C5C\dots5C}$ (Hamming distance of 4 bits per byte).
    - The nested dual-hash structure mathematically prevents Length Extension attacks!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Hash Evolution Timeline
* Classical: MD5 (128b) / SHA-1 (160b) $\to$ Broken by Birthday Collisions.
* Modern Standard: SHA-256 (Merkle-Damgård) + HMAC (RFC 2104).
* Next-Gen Architecture: SHA-3 / Keccak Sponge (Absorb $\to$ Squeeze).
* Password Hashing: Argon2id (Memory-hard against ASICs/GPUs).

### 2. Top Recommended Resources
* **The Modern Standard:** *Introduction to Modern Cryptography* (Jonathan Katz & Yehuda Lindell), Chapter 5 (Hash Functions and MACs).
* **Applied Cryptography:** *Serious Cryptography* (Jean-Philippe Aumasson), Chapters 6 (Hashes) & 7 (HMAC).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you differentiate Preimage, Second Preimage, and Collision Resistance?
- [ ] Can you apply the Birthday Paradox to calculate collision attack work bounds ($2^{n/2}$)?
- [ ] Can you explain why Merkle-Damgård hashes are vulnerable to Length Extension Attacks?
- [ ] Can you trace the nested dual-hash formula of HMAC with ipad and opad?
