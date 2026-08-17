# Duofy Reusable Lesson Format: ECDSA Signature Mechanics and Nonce Reuse Vulnerabilities

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Digital_Signatures_and_PKI`  
**Lesson Format Type:** `ecdsa_signature_mechanics_and_nonce_reuse_vulnerabilities`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the scalar group arithmetic, signature pair verification formulas, and catastrophic random nonce reuse vulnerabilities of the Elliptic Curve Digital Signature Algorithm (ECDSA) (NIST FIPS 186-4; Don Johnson, Alfred Menezes, Scott Vanstone 2001; Serious Cryptography Chapter 13.2; Katz & Lindell Chapter 12.5): master the **ECDSA Signing Algorithm** (select random per-signature nonce $k \in [1, n-1]$, compute ephemeral point $R = k \cdot G = (x_R, y_R)$, set $\mathbf{r = x_R \pmod n}$, and compute $\mathbf{s \equiv k^{-1}\big(H(M) + d_A \cdot r\big) \pmod n}$, outputting signature pair $\mathbf{(r, s)}$), master **ECDSA Verification** ($u_1 = H(M) s^{-1} \pmod n$, $u_2 = r s^{-1} \pmod n$, verify $(u_1 G + u_2 Q_A).x \equiv r \pmod n$), and mathematically dissect the **Catastrophic Nonce $k$ Reuse Attack (The 2010 Sony PlayStation 3 Private Signing Key Recovery)** ($k = \frac{H(M_1) - H(M_2)}{s_1 - s_2} \pmod n \implies d_A = \frac{s_1 k - H(M_1)}{r} \pmod n$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ECDSA Signing & Verification Formulas, Nonce $k$ Invariant & PS3 Threat Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Algebraic Recovery of a Private Key from Two Signatures Sharing Nonce $k$ Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ECDSA Variable / Mathematical Component & Cryptographic Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Ephemeral Secret Scalar Value That Must NEVER Be Reused in ECDSA (Nonce k) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Derivation of Private Key d from Reused Nonce k on Messages M1 and M2 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ECDSA Math & Nonce Reuse (FIPS 186-4; Johnson et al. 2001):
   - **ECDSA Signing Algorithm:**
     1. Choose cryptographically random secret nonce $k \in [1, n-1]$.
     2. Compute point $R = k \cdot G = (x_R, y_R)$.
     3. $\mathbf{r = x_R \pmod n}$.
     4. $\mathbf{s \equiv k^{-1}\big(H(M) + d_A \cdot r\big) \pmod n}$.
     - Signature: $\mathbf{(r, s)}$.
   - **Verification:** $w = s^{-1} \pmod n \implies u_1 = H(M)w, \ u_2 = rw \implies \mathbf{(u_1 G + u_2 Q_A).x \equiv r \pmod n}$.
   - **The Nonce Reuse Disaster (Fail0verflow PS3 2010):**
     - If $k$ is reused for $M_1$ and $M_2$:
       $$s_1 - s_2 = k^{-1}\big(H(M_1) - H(M_2)\big) \pmod n \implies \mathbf{k \equiv \frac{H(M_1) - H(M_2)}{s_1 - s_2} \pmod n}$$
     - Once $k$ is known: $\mathbf{d_A \equiv \frac{s_1 k - H(M_1)}{r} \pmod n}$ (Private key completely compromised!).
2. **Slide 2 (`ordering`):** Provide 5 steps of exploiting ECDSA nonce reuse to steal private key: (1) adversary observes two distinct messages M1 and M2 signed with the exact same r value (indicating nonce k was reused), (2) compute hash digests z1 = H(M1) and z2 = H(M2), (3) subtract signature equations: s1 - s2 = k^(-1)(z1 - z2) mod n, (4) calculate secret nonce k = (z1 - z2)/(s1 - s2) mod n using modular inverse, (5) substitute k into signature equation to extract master private signing key: d = (s1 * k - z1) / r mod n!
3. **Slide 3 (`matching`):** Pair 4 ECDSA variables (Signature Component r, Signature Component s, Ephemeral Nonce k, Public Key Q_A) with their formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the nonce k term. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Sony PS3 ECDSA vulnerability: In 2010, the Fail0verflow hacker collective completely broke Sony's PlayStation 3 security by recovering Sony's master private firmware signing key. What precise mathematical failure in Sony's ECDSA implementation allowed them to extract the private key in seconds? (Sony's developers made the catastrophic implementation error of **hardcoding the secret random nonce $k$ as a constant static number** across all firmware update signatures; because two official firmware files were signed using the exact same nonce $k$, their signatures had identical $r$ values, allowing hackers to **use elementary modular arithmetic to solve for $k$ and extract Sony's master private key $d_A$**, allowing anyone to sign custom firmware permanently).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ecdsa_signature_mechanics_and_nonce_reuse_vulnerabilities",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ECDSA Mechanics & Nonce Vulnerability (FIPS 186-4)**\n• **ECDSA Signing Pipeline (Johnson et al. 2001):**\n$$\n\\mathbf{R = k \\cdot G = (x_R, y_R) \\implies \\mathbf{r = x_R \\pmod n} \\qquad ; \\qquad \\mathbf{s \\equiv k^{-1}\\big(H(M) + d_A \\cdot r\\big) \\pmod n}}\n$$\n• **Signature Verification Invariant:**\n$$\n\\mathbf{w = s^{-1} \\pmod n \\implies \\big(H(M)w \\cdot G \\ + \\ rw \\cdot Q_A\\big).x \\equiv r \\pmod n}\n$$\n• **The Fatal Nonce Reuse Hazard (Sony PS3 2010):**\nIf secret nonce $k$ is reused to sign two distinct messages $M_1$ and $M_2$:\n$$\n\\mathbf{k \\equiv \\frac{H(M_1) - H(M_2)}{s_1 - s_2} \\pmod n \\qquad \\implies \\qquad \\mathbf{d_A \\equiv \\frac{s_1 k - H(M_1)}{r} \\pmod n}}\n$$\n• **The Catastrophe:** The master private key $d_A$ is **instantly extracted in microseconds**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algebraic steps executed to recover an ECDSA private signing key from two signatures sharing the same nonce k.",
      "orderItems": [
        "Detect two distinct signed messages (M1, s1) and (M2, s2) that share the exact same signature r value (indicating k was reused)",
        "Compute the cryptographic hash digests of both messages: z1 = H(M1) and z2 = H(M2)",
        "Set up the system of linear equations: s1 = k^(-1)(z1 + d*r) and s2 = k^(-1)(z2 + d*r) (mod n)",
        "Subtract equations to eliminate private key d: (s1 - s2) = k^(-1)(z1 - z2) mod n, and solve for nonce: k = (z1 - z2)/(s1 - s2) mod n",
        "Substitute the recovered scalar k back into equation 1 to extract the master private key: d = (s1 * k - z1) * r^(-1) mod n"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ECDSA Signature Component to its exact Mathematical Definition.",
      "matchPairs": [
        { "left": "Signature Component r", "right": "The x-coordinate of the ephemeral curve point R = k * G reduced modulo subgroup order n" },
        { "left": "Signature Component s", "right": "Scalar proof calculated as s = k^(-1) * [H(M) + d * r] mod n combining hash, key, and nonce" },
        { "left": "Secret Nonce k", "right": "Cryptographically secure random ephemeral scalar that MUST be unique for every single signature" },
        { "left": "Public Key Q_A", "right": "Elliptic curve point Q_A = d_A * G used by anyone in the world to verify signature authenticity" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ECDSA, the secret ephemeral scalar that must never be reused across multiple signatures is the ___.",
      "blankAnswer": "nonce",
      "blankDistractors": ["modulus", "generator", "totient"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In 2010, the Fail0verflow hacker collective completely bypassed the security of Sony's PlayStation 3 by recovering Sony's master private firmware signing key. What precise mathematical failure in Sony's ECDSA implementation allowed them to extract the private key in seconds?",
      "options": [
        { "text": "Sony's software developers made the catastrophic implementation error of hardcoding the secret random nonce k as a constant static integer across all firmware signing operations; because multiple distinct firmware update packages were signed using the exact same nonce k, their signatures had identical r values, allowing hackers to use basic modular subtraction to solve for k and instantly extract Sony's master private key d_A, allowing anyone in the world to sign and install custom operating systems", "isCorrect": true, "explanation": "Correct! This is widely considered the most famous cryptographic implementation blunder in computer history (Fail0verflow 27C3 Presentation 2010; Serious Cryptography Chapter 13.2). 1. **The Rule of ECDSA:** - The variable $k$ is called a **nonce** (Number used ONCE). - $k$ MUST be a cryptographically random, secret integer chosen freshly for every single signature. 2. **What Sony Did Wrong:** - Sony's engineers hardcoded $k$ as a constant number in their build scripts. - Every time Sony released a firmware update ($M_1, M_2, M_3$), they signed it with the EXACT SAME $k$. 3. **The Exploit:** - Since $R = k \\cdot G$, the signature component $r = R.x \\pmod n$ was identical across all updates! - Hackers noticed two different updates had the exact same $r$. - They calculated: $k = \\frac{H(M_1) - H(M_2)}{s_1 - s_2} \\pmod n$. - They calculated: $d_{\\text{Sony}} = \\frac{s_1 k - H(M_1)}{r} \\pmod n$. - Sony's private root key was printed on the conference screen at 27C3 in Berlin. Game over!" },
        { "text": "Because Sony used a 5-bit RSA modulus that was factored on an abacus", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because elliptic curve points cannot be multiplied by odd numbers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because ECDSA was officially revoked by the United Nations", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
