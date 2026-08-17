# Duofy Reusable Lesson Format: RSA Number-Theoretic Foundations and Key Generation

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Asymmetric_Encryption_RSA_ECC`  
**Lesson Format Type:** `rsa_number_theoretic_foundations_and_key_generation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the number theory foundations, Euler's totient arithmetic, and Extended Euclidean Algorithm calculations of the RSA cryptosystem (Ron Rivest, Adi Shamir, Leonard Adleman 1977; Katz & Lindell *Introduction to Modern Cryptography* Chapter 8.2 & 11.2; William Stallings Chapter 9): master the **5-Step RSA Key Generation Algorithm** (**1. Generate distinct primes $p, q$**, **2. Compute Modulus $n = p \cdot q$**, **3. Compute Euler's Totient $\phi(n) = (p-1)(q-1)$**, **4. Select Public Exponent $e$ coprime to $\phi(n)$**, **5. Calculate Private Exponent $d \equiv e^{-1} \pmod{\phi(n)}$ using Extended Euclidean Algorithm such that $e \cdot d \equiv 1 \pmod{\phi(n)}$**), prove encryption and decryption correctness via **Euler's Totient Theorem ($M^{\phi(n)} \equiv 1 \pmod n \implies M^{ed} \equiv M^{k\phi(n)+1} \equiv M \pmod n$)**, and calculate exact keys for small prime examples.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RSA Algebraic Theorems, Euler Totient Phi, & Key Generation Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step RSA Keypair Generation and Encryption/Decryption Lifecycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RSA Variable / Mathematical Function & Number-Theoretic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Function Equal to (p-1)(q-1) Used to Compute RSA Private Exponents (Euler's Totient) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Computation of Modulus n, Totient phi(n), and Private Key d for Primes p=61 and q=53 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State RSA Math (Rivest et al. 1977; Katz & Lindell 8.2):
   - **RSA Number-Theoretic Equations:**
     $$\mathbf{n = p \cdot q \qquad ; \qquad \mathbf{\phi(n) = (p-1)(q-1)}}$$
     $$\mathbf{\gcd(e, \phi(n)) = 1 \qquad ; \qquad \mathbf{e \cdot d \equiv 1 \pmod{\phi(n)} \iff d \equiv e^{-1} \pmod{\phi(n)}}}$$
   - **Encryption & Decryption:**
     $$\mathbf{\text{Ciphertext: } C \equiv M^e \pmod n \qquad ; \qquad \mathbf{\text{Plaintext: } M \equiv C^d \pmod n}}$$
   - **Correctness Proof:** By Euler's Theorem, $M^{ed} = M^{k\phi(n)+1} = (M^{\phi(n)})^k \cdot M \equiv 1^k \cdot M \equiv M \pmod n$.
   - **Public Key:** $(e, n)$; **Private Key:** $(d, n)$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the RSA lifecycle: (1) select two distinct large prime numbers p and q, (2) compute modulus n = p * q and Euler's totient phi(n) = (p-1)(q-1), (3) choose public exponent e coprime to phi(n) (e.g. e = 65537), (4) compute private key d as the modular multiplicative inverse of e mod phi(n) via Extended Euclidean Algorithm, (5) encrypt message via C = M^e mod n and decrypt via M = C^d mod n!
3. **Slide 3 (`matching`):** Pair 4 RSA variables (Modulus n, Euler's Totient phi(n), Public Exponent e, Private Exponent d) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Euler's totient function. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing RSA keypair with small primes: Given two prime numbers $p = 61$ and $q = 53$, and public exponent $e = 17$: what are the Modulus $n$, Euler's Totient $\phi(n)$, and Private Exponent $d$? (Modulus $n = 61 \times 53 = \mathbf{3233}$; Euler's Totient $\phi(n) = (61-1)(53-1) = 60 \times 52 = \mathbf{3120}$; Private Exponent $d \equiv 17^{-1} \pmod{3120} \implies 17 \cdot d \equiv 1 \pmod{3120} \implies \mathbf{d = 2753}$ [since $17 \times 2753 = 46801 = 15 \times 3120 + 1$]).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rsa_number_theoretic_foundations_and_key_generation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RSA Cryptosystem Foundations (Rivest, Shamir, Adleman 1977)**\n• **Number-Theoretic Invariants (Katz & Lindell Chapter 8.2):**\n$$\n\\mathbf{n = p \\cdot q \\qquad ; \\qquad \\mathbf{\\phi(n) = (p-1)(q-1)}}\n$$\n$$\n\\mathbf{\\gcd(e, \\phi(n)) = 1 \\qquad ; \\qquad \\mathbf{e \\cdot d \\equiv 1 \\pmod{\\phi(n)} \\iff d \\equiv e^{-1} \\pmod{\\phi(n)}}}\n$$\n• **Encryption \\& Decryption Formulas (Euler-Fermat):**\n$$\n\\mathbf{C \\equiv M^e \\pmod n \\qquad ; \\qquad \\mathbf{M \\equiv C^d \\equiv (M^e)^d \\equiv M^{k\\phi(n)+1} \\equiv M \\pmod n}}\n$$\n• **Key Distribution:** **Public Key:** $(e, n)$; **Private Key:** $(d, n)$ (with $p, q$ secret)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential mathematical steps of the RSA Key Generation and Cryptographic Lifecycle.",
      "orderItems": [
        "Select two large distinct random prime numbers p and q using probabilistic primality testing (Miller-Rabin)",
        "Compute the public modulus n = p * q and calculate Euler's Totient function value: phi(n) = (p - 1) * (q - 1)",
        "Choose a public exponent e that is strictly coprime to phi(n) (1 < e < phi(n) with gcd(e, phi(n)) = 1, e.g. e = 65537)",
        "Compute the secret private exponent d as the modular multiplicative inverse of e modulo phi(n) using the Extended Euclidean Algorithm",
        "Encrypt plaintext block via C = M^e mod n and decrypt ciphertext via M = C^d mod n"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RSA Mathematical Variable to its exact Cryptographic Definition.",
      "matchPairs": [
        { "left": "Public Modulus n", "right": "Product of two secret primes (n = p * q) defining the finite ring arithmetic domain Z_n" },
        { "left": "Euler's Totient phi(n)", "right": "The order of the multiplicative group Z_n^* calculated as phi(n) = (p - 1)(q - 1)" },
        { "left": "Public Exponent e", "right": "Integer coprime to phi(n) used to encrypt messages via modular exponentiation (C = M^e mod n)" },
        { "left": "Private Exponent d", "right": "Modular multiplicative inverse of e mod phi(n) used to invert encryption and decrypt ciphertext (M = C^d mod n)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In RSA cryptography, the mathematical function phi(n) = (p-1)(q-1) is Euler's ___ function.",
      "blankAnswer": "totient",
      "blankDistractors": ["logarithm", "modulus", "matrix"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Given the two prime numbers p = 61 and q = 53, and public exponent e = 17: what are the exact Public Modulus n, Euler's Totient phi(n), and Private Exponent d?",
      "options": [
        { "text": "Modulus n = 3233; Euler's Totient phi(n) = 3120; Private Exponent d = 2753; calculated via: n = 61 * 53 = 3233; phi(n) = (61 - 1) * (53 - 1) = 60 * 52 = 3120; solving 17 * d = 1 (mod 3120) via the Extended Euclidean Algorithm yields d = 2753 (since 17 * 2753 = 46801 = 15 * 3120 + 1 = 1 mod 3120)", "isCorrect": true, "explanation": "Correct! This is the classic foundational RSA manual computation example (Katz & Lindell Chapter 8.2). 1. **Step 1: Compute Modulus $n$:** - $n = p \\cdot q = 61 \\times 53 = \\mathbf{3233}$. 2. **Step 2: Compute Euler's Totient $\\phi(n)$:** - $\\phi(n) = (p - 1)(q - 1) = (61 - 1)(53 - 1) = 60 \\times 52 = \\mathbf{3120}$. 3. **Step 3: Compute Private Exponent $d$ via Extended Euclidean Algorithm:** - We must solve: $17 \\cdot d \\equiv 1 \\pmod{3120} \\iff 17d - 3120k = 1$. - Extended Euclidean divisions: - $3120 = 183 \\times 17 + 9$ - $17 = 1 \\times 9 + 8$ - $9 = 1 \\times 8 + 1$ - Working backwards: - $1 = 9 - 1 \\times 8$ - $1 = 9 - (17 - 9) = 2 \\times 9 - 17$ - $1 = 2 \\times (3120 - 183 \\times 17) - 17 = 2 \\times 3120 - 367 \\times 17$. - Thus: $-367 \\times 17 \\equiv 1 \\pmod{3120}$. - To find positive $d$: $d = -367 + 3120 = \\mathbf{2753}$! 4. Verification: $17 \\times 2753 = 46801$. $46801 \\div 3120 = 15\\text{ remainder } 1$. Correct!" },
        { "text": "Modulus n = 3233; phi(n) = 3232; d = 17", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Modulus n = 114; phi(n) = 112; d = 53", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Modulus n = 3233; phi(n) = 3120; d = 65537", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
