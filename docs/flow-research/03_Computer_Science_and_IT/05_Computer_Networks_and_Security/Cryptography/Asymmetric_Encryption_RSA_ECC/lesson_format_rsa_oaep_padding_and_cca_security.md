# Duofy Reusable Lesson Format: RSA-OAEP Padding and Chosen-Ciphertext Security (IND-CCA2)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Asymmetric_Encryption_RSA_ECC`  
**Lesson Format Type:** `rsa_oaep_padding_and_cca_security`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural vulnerabilities of raw 'textbook' RSA and the randomized engineering proofs of Optimal Asymmetric Encryption Padding (RSA-OAEP) (Mihir Bellare & Phillip Rogaway 1994, *Optimal Asymmetric Encryption*, EUROCRYPT; RFC 8017 PKCS#1 v2.2; Daniel Bleichenbacher 1998 *Chosen Ciphertext Attacks against protocols based on the RSA Encryption Standard PKCS #1*; Katz & Lindell *Introduction to Modern Cryptography* Chapter 11.2): prove why **Textbook RSA is Insecure** (deterministic encryption allows dictionary matching, algebraic multiplicativity causes **Homomorphic Malleability**: $E(M_1) \cdot E(M_2) \equiv (M_1 M_2)^e \equiv E(M_1 M_2) \pmod n$, and small exponent attacks), master the **2-Round Feistel Structure of RSA-OAEP** using random seed $r$, Mask Generation Functions (MGF1 based on SHA-256), and data block parameters, and evaluate how OAEP guarantees **IND-CCA2 (Indistinguishability under Adaptive Chosen-Ciphertext Attack)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Textbook RSA Flaws (Malleability, Multiplicativity), OAEP Feistel Diagram Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Encoding and Encryption of a Plaintext Message Using RSA-OAEP Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RSA Attack Vector / Padding Primitive & Cryptographic Countermeasure Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Gold-Standard Security Level Guaranteed by RSA-OAEP Against Active Attackers (IND-CCA2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof of Multiplicative Malleability in Unpadded Textbook RSA Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Textbook RSA Flaws & OAEP (Bellare & Rogaway 1994; RFC 8017):
   - **Textbook RSA Flaws:**
     1. **Deterministic:** Encrypting the same message $M$ twice produces the exact same ciphertext $C$ (leaks identity/equality).
     2. **Multiplicative Malleability (Homomorphic Property):**
        $$\mathbf{E(M_1) \cdot E(M_2) \equiv M_1^e \cdot M_2^e \equiv (M_1 \cdot M_2)^e \equiv E(M_1 \cdot M_2) \pmod n}$$
        - An active attacker can double a bid without knowing the original bid: $C' = C \cdot 2^e \pmod n \implies M' = 2M$!
   - **The RSA-OAEP Solution (RFC 8017):**
     $$\mathbf{\text{MaskedDB} = \text{DB} \oplus \text{MGF}(r) \qquad ; \qquad \mathbf{\text{MaskedSeed} = r \oplus \text{MGF}(\text{MaskedDB})}}$$
     - Injects random seed $r$; turns deterministic RSA into **probabilistic randomized encryption**!
     - Guarantees **IND-CCA2** (resists Bleichenbacher Million-Message attacks!).
2. **Slide 2 (`ordering`):** Provide 5 steps of encrypting via RSA-OAEP: (1) pad plaintext into Data Block DB containing optional label hash, padding string of zeros, and message M, (2) generate cryptographically secure random k-bit seed r, (3) compute MaskedDB = DB XOR MGF(seed r) using SHA-256 Mask Generation Function, (4) compute MaskedSeed = seed r XOR MGF(MaskedDB), (5) concatenate (MaskedSeed || MaskedDB) to form encoded message EM, and compute RSA modular exponentiation C = EM^e mod n!
3. **Slide 3 (`matching`):** Pair 4 concepts (Multiplicative Malleability, Bleichenbacher Attack, RSA-OAEP Padding, Random Seed r) with their descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of IND-CCA2 security. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on multiplicative malleability in textbook RSA: An attacker intercepts a ciphertext $C$ representing an encrypted bank transfer amount $M$ encrypted under the victim's public key $(e, n)$ using unpadded textbook RSA ($C \equiv M^e \pmod n$). The attacker cannot factor $n$ or compute $d$. How can the attacker forge a valid ciphertext $C'$ that will decrypt to exactly TEN TIMES the original amount ($10M \pmod n$) on the receiving bank's server? (The attacker computes $C' \equiv C \cdot (10^e) \pmod n$; upon receipt, the bank calculates $(C')^d \equiv (C \cdot 10^e)^d \equiv C^d \cdot (10^e)^d \equiv M \cdot 10^{ed} \equiv M \cdot 10 \equiv \mathbf{10M \pmod n}$; this proves textbook RSA is **multiplicatively malleable and completely insecure without OAEP padding**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rsa_oaep_padding_and_cca_security",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RSA-OAEP Padding & CCA Security (Bellare & Rogaway 1994)**\n• **Textbook RSA Vulnerabilities (Katz & Lindell Chapter 11.2):**\nUnpadded RSA ($C \\equiv M^e \\pmod n$) is fatally flawed due to **Multiplicative Malleability**:\n$$\n\\mathbf{E(M_1) \\cdot E(M_2) \\equiv M_1^e \\cdot M_2^e \\equiv (M_1 \\cdot M_2)^e \\equiv E(M_1 \\cdot M_2) \\pmod n}\n$$\n• **The RSA-OAEP Architecture (RFC 8017 / PKCS#1 v2.2):**\n$$\n\\mathbf{\\text{MaskedDB} = \\text{DB} \\oplus \\text{MGF}(\\text{Seed } r) \\qquad ; \\qquad \\mathbf{\\text{MaskedSeed} = r \\oplus \\text{MGF}(\\text{MaskedDB})}}\n$$\n• **Security Guarantee:** Converts deterministic RSA into **probabilistic randomized encryption**, achieving **IND-CCA2** (resisting chosen-ciphertext and Bleichenbacher padding attacks)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to encode and encrypt a message using RSA-OAEP.",
      "orderItems": [
        "Format Data Block (DB): Concatenate label hash, padding zeroes, message delimiter byte, and plaintext message M",
        "Generate a cryptographically secure random seed (r) of length equal to the hash function output (e.g. 256-bit for SHA-256)",
        "Apply Mask Generation Function (MGF1) to seed r and XOR with Data Block: MaskedDB = DB XOR MGF(r)",
        "Apply MGF1 to MaskedDB and XOR with random seed r: MaskedSeed = r XOR MGF(MaskedDB)",
        "Concatenate [0x00 || MaskedSeed || MaskedDB] to form Encoded Message (EM) and execute modular exponentiation: C = EM^e mod n"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RSA Security Vulnerability / Defense to its exact Mechanism.",
      "matchPairs": [
        { "left": "Multiplicative Malleability", "right": "Textbook RSA flaw allowing attackers to multiply plaintext by modifying ciphertext: C' = C * k^e mod n" },
        { "left": "Bleichenbacher Attack", "right": "Adaptive chosen-ciphertext attack exploiting PKCS#1 v1.5 error messages to decrypt ciphertexts" },
        { "left": "RSA-OAEP Padding", "right": "Two-round Feistel-like randomized padding scheme providing IND-CCA2 security in the random oracle model" },
        { "left": "Ephemeral Seed (r)", "right": "Random nonces ensuring encrypting the exact same message twice generates completely distinct ciphertexts" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "RSA-OAEP provides the highest standard of public-key security, known as IND-___ (Indistinguishability under Adaptive Chosen-Ciphertext Attack).",
      "blankAnswer": "CCA2",
      "blankDistractors": ["CPA", "CCA1", "ECB"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An attacker intercepts an encrypted financial transaction C representing an unknown transfer amount M sent to a bank, encrypted using the bank's public key (e, n) via unpadded textbook RSA (C = M^e mod n). Without factoring n or knowing the private key d, how can the attacker forge a valid modified ciphertext C' that will decrypt to exactly TEN TIMES the original amount (10M mod n)?",
      "options": [
        { "text": "The attacker computes C' = C * (10^e) mod n; because textbook RSA is homomorphically multiplicative, the bank will decrypt C' via (C')^d = [C * 10^e]^d = C^d * (10^e)^d = M * 10^(ed) = M * 10 = 10M mod n, successfully multiplying the decrypted transfer by 10 without ever decrypting the original ciphertext", "isCorrect": true, "explanation": "Correct! This is the classic mathematical proof of why raw textbook RSA is never used in real-world software without randomized padding like OAEP (Katz & Lindell Chapter 11.2; Serious Cryptography Chapter 9). 1. **The Algebraic Homomorphism of RSA:** - $C = M^e \\pmod n$. - Suppose the attacker wants the bank to decrypt $M' = 10 \\cdot M$. - The attacker knows the bank's public exponent $e$ and modulus $n$. - The attacker computes $C_{10} = 10^e \\pmod n$. - The attacker multiplies the intercepted ciphertext $C$ by $C_{10}$: $C' \\equiv C \\cdot 10^e \\pmod n$. 2. **What Happens at the Bank (Decryption):** - Bank computes: $(C')^d \\equiv (C \\cdot 10^e)^d \\equiv C^d \\cdot (10^e)^d \\pmod n$. - Since $C^d \\equiv M \\pmod n$ and $(10^e)^d \\equiv 10 \\pmod n$: - Decrypted Result $= M \\cdot 10 = \\mathbf{10M \\pmod n}$! 3. The bank's database debits $10 \\times M$ instead of $M$! 4. **How OAEP Prevents This:** In RSA-OAEP, multiplying ciphertexts destroys the random Feistel hash padding (MGF1), causing OAEP integrity validation to fail immediately and discard the forged ciphertext." },
        { "text": "The attacker adds 10 to C: C' = C + 10 mod n", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The attacker calculates d by running the Miller-Rabin test on C", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The attacker cannot modify C without knowing the bank's Wi-Fi password", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
