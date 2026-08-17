# Duofy Reusable Lesson Format: Elliptic Curve Cryptography (Group Law and ECDLP)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Asymmetric_Encryption_RSA_ECC`  
**Lesson Format Type:** `elliptic_curve_cryptography_group_law_and_ecdlp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic geometry, abelian group law, and discrete logarithm hardness proofs of Elliptic Curve Cryptography (ECC) (Neal Koblitz & Victor Miller 1985; Katz & Lindell *Introduction to Modern Cryptography* Chapter 8.3 & 10.5; Serious Cryptography Chapter 12): master the **Short Weierstrass Curve Equation over Finite Prime Field $\mathbb{F}_p$ ($p > 3$)** ($\mathbf{y^2 \equiv x^3 + ax + b \pmod p}$ with non-singularity condition $\mathbf{4a^3 + 27b^2 \not\equiv 0 \pmod p}$), execute the **Chord-and-Tangent Group Law** (Point Addition $P + Q = R'$, Point Doubling $2P$, reflection across x-axis, and the identity **Point at Infinity $\mathcal{O}$**), master **Scalar Point Multiplication** ($\mathbf{Q = d \cdot P = \sum_{i=1}^d P \pmod p}$ via Double-and-Add algorithm), and formulate the **Elliptic Curve Discrete Logarithm Problem (ECDLP)** ($O(\sqrt{p})$ hardness resisting sub-exponential index calculus).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Weierstrass Curve Equations, Abelian Group Law & Point at Infinity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Geometric Point Addition (P + Q = R') Using the Chord-and-Tangent Law Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ECC Geometric Construct / Parameter & Cryptographic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Identity Element in the Elliptic Curve Abelian Group (Point at Infinity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why ECC Provides Higher Security Per Bit Than RSA Due to the Hardness of ECDLP Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ECC Math (Koblitz & Miller 1985; Katz & Lindell 8.3):
   - **Weierstrass Elliptic Curve over $\mathbb{F}_p$:**
     $$\mathbf{y^2 \equiv x^3 + ax + b \pmod p \qquad \text{where } \mathbf{4a^3 + 27b^2 \not\equiv 0 \pmod p}}$$
   - **Abelian Group Law $(E(\mathbb{F}_p), +)$:**
     - **Identity Element:** Point at Infinity $\mathcal{O}$ ($P + \mathcal{O} = P$).
     - **Inverse:** $-P = (x_P, -y_P \pmod p) \implies P + (-P) = \mathcal{O}$.
     - **Slope $\lambda$:**
       $$\lambda = \begin{cases} \frac{y_Q - y_P}{x_Q - x_P} \pmod p & \text{if } P \ne Q \text{ (Chord / Addition)} \\ \frac{3x_P^2 + a}{2y_P} \pmod p & \text{if } P = Q \text{ (Tangent / Doubling)} \end{cases}$$
     - **Sum Point $R = (x_R, y_R)$:** $x_R = \lambda^2 - x_P - x_Q \pmod p$ ; $y_R = \lambda(x_P - x_R) - y_P \pmod p$.
   - **The ECDLP:** Given public point $Q$ and generator $P$, finding integer scalar $d$ such that $Q = dP$ requires $O(\sqrt{p})$ operations!
2. **Slide 2 (`ordering`):** Provide 5 steps of adding two distinct points P and Q on an elliptic curve: (1) plot distinct points P(x_P, y_P) and Q(x_Q, y_Q) on curve E(F_p), (2) calculate chord slope lambda = (y_Q - y_P)/(x_Q - x_P) mod p, (3) compute third intersection x-coordinate x_3 = lambda^2 - x_P - x_Q mod p, (4) compute third intersection y-coordinate y_3 = lambda(x_P - x_3) - y_P mod p to find intermediate intersection point (x_3, y_3), (5) reflect point across x-axis to obtain final point sum R = P + Q = (x_3, -y_3 mod p)!
3. **Slide 3 (`matching`):** Pair 4 ECC concepts (Point at Infinity, Scalar Multiplication, Generator Point G, Slope Lambda) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the point at infinity. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why ECC achieves higher security per bit than RSA: Why does a 256-bit Elliptic Curve key (e.g. Curve25519) provide equivalent cryptographic security to a massive 3072-bit RSA key? (Because RSA modulus factorization ($n = pq$) can be solved in sub-exponential time using the **General Number Field Sieve (GNFS)** algorithm, forcing RSA keys to grow exponentially ($3072\text{-bit}$ for 128-bit security, $15360\text{-bit}$ for 256-bit security); in contrast, **no sub-exponential index calculus algorithm is known for general elliptic curves**, so solving the **Elliptic Curve Discrete Logarithm Problem (ECDLP)** requires fully exponential $O(\sqrt{p})$ time via Pollard's Rho, allowing a compact 256-bit ECC key to deliver a full 128 bits of symmetric security).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "elliptic_curve_cryptography_group_law_and_ecdlp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Elliptic Curve Cryptography & ECDLP (Koblitz \\& Miller 1985)**\n• **Weierstrass Curve Equation over Finite Field \\(\\mathbb{F}_p\\):**\n$$\n\\mathbf{y^2 \\equiv x^3 + ax + b \\pmod p \\qquad \\text{with discriminant: } 4a^3 + 27b^2 \\not\\equiv 0 \\pmod p}\n$$\n• **Chord-and-Tangent Point Addition Formulas:**\n$$\n\\mathbf{\\lambda = \\frac{y_Q - y_P}{x_Q - x_P} \\pmod p \\quad \\implies \\quad \\begin{cases} x_R = \\lambda^2 - x_P - x_Q \\pmod p \\\\ y_R = \\lambda(x_P - x_R) - y_P \\pmod p \\end{cases}}\n$$\n• **Identity Element:** **Point at Infinity \\(\\mathcal{O}\\)** ($P + \\mathcal{O} = P$).\n• **The ECDLP:** Given public point $Q = d \\cdot P$, computing scalar secret key $d$ is computationally intractable ($O(\\sqrt{p})$ fully exponential complexity)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential mathematical steps to compute the sum of two distinct points P and Q (P + Q = R) on an elliptic curve.",
      "orderItems": [
        "Select distinct points P(x_P, y_P) and Q(x_Q, y_Q) residing on the Weierstrass curve over finite field F_p",
        "Compute the chord line slope connecting P and Q: lambda = (y_Q - y_P) / (x_Q - x_P) mod p",
        "Determine the x-coordinate of the third curve intersection point: x_3 = lambda^2 - x_P - x_Q mod p",
        "Calculate the y-coordinate of the third curve intersection point: y_3 = lambda * (x_P - x_3) - y_P mod p",
        "Reflect the third intersection point across the x-axis: R = P + Q = (x_3, -y_3 mod p) = (x_3, p - y_3 mod p)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Elliptic Curve Mathematical Element to its exact Cryptographic Role.",
      "matchPairs": [
        { "left": "Point at Infinity (\\(\\mathcal{O}\\))", "right": "The additive identity element of the elliptic curve group where P + (-P) = \\(\\mathcal{O}\\)" },
        { "left": "Base Generator Point (G)", "right": "Fixed standard point of large prime order n generating the cyclic subgroup for key generation" },
        { "left": "Scalar Multiplication (d * P)", "right": "Repeated point addition executed in O(log d) steps using the Double-and-Add algorithm" },
        { "left": "ECDLP Hardness", "right": "The mathematical intractability of finding private scalar d given generator P and public point Q = d * P" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In elliptic curve abelian group theory, the identity element is the Point at ___.",
      "blankAnswer": "infinity",
      "blankDistractors": ["origin", "tangent", "modulus"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does a 256-bit Elliptic Curve key (such as Curve25519 or secp256k1) provide equivalent cryptographic strength to a massive 3072-bit RSA key?",
      "options": [
        { "text": "The fastest algorithms for factoring RSA moduli (the General Number Field Sieve / GNFS) run in sub-exponential time, requiring RSA keys to grow exponentially (3072 bits for 128-bit security, 15360 bits for 256-bit security); for elliptic curves, no sub-exponential index calculus algorithm exists, so solving the Elliptic Curve Discrete Logarithm Problem (ECDLP) requires fully exponential O(sqrt(p)) operations via Pollard's Rho algorithm, allowing a compact 256-bit ECC key to provide a full 128 bits of symmetric security with dramatically faster computation and lower bandwidth", "isCorrect": true, "explanation": "Correct! This is the primary reason why the entire cryptographic world (TLS 1.3, Bitcoin, Signal, Apple Secure Enclave, SSH) migrated from RSA to ECC (Katz & Lindell Chapter 8.3 & 10.5; Serious Cryptography Chapter 12). 1. **Why RSA Scales Terribly (Sub-exponential Attacks):** - Factoring an RSA modulus $n = pq$ does NOT require trying every prime. - The **General Number Field Sieve (GNFS)** exploits the algebraic structure of integer rings to factor integers in sub-exponential time: $L_n[1/3, c]$. - Because of GNFS, increasing RSA security from 80-bit to 128-bit requires jumping from 1024-bit to **3072-bit keys**, causing massive CPU slowdowns during modular exponentiation. 2. **Why ECC Scales Elegantly (Exponential Hardness):** - The points on an elliptic curve have no natural 'factor base' or order relations. - The best known classical attack against the **ECDLP** is **Pollard's Rho Algorithm**, which runs in **strictly exponential time**: $O(\\sqrt{p}) = O(2^{n/2})$. - To achieve $128\\text{ bits}$ of symmetric security, you only need $n = 2 \\times 128 = \\mathbf{256\\text{ bits}}$! - 256-bit ECC keys fit in 32 bytes, encrypt/sign in microseconds, and consume tiny fractions of battery power on mobile devices." },
        { "text": "Because 256 is an even number while 3072 is an odd number", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because RSA keys are encrypted using DES", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because elliptic curves do not use prime numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
