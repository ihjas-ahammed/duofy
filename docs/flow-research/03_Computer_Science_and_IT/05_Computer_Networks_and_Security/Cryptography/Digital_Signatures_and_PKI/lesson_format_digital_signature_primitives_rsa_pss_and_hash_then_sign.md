# Duofy Reusable Lesson Format: Digital Signature Primitives (RSA-PSS and Hash-then-Sign)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Digital_Signatures_and_PKI`  
**Lesson Format Type:** `digital_signature_primitives_rsa_pss_and_hash_then_sign`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical definitions, non-repudiation guarantees, and probabilistic padding architectures of digital signatures and RSA-PSS (Mihir Bellare & Phillip Rogaway 1996; RFC 8017 PKCS#1 v2.2; Katz & Lindell *Introduction to Modern Cryptography* Chapter 12.1–12.5; Serious Cryptography Chapter 13): master the **Hash-then-Sign Paradigm** ($\mathbf{\sigma = \text{Sign}_{SK}(H(M))}$, solving efficiency and security bounds), distinguish asymmetric digital signatures (**Non-Repudiation + Public Verifiability**) from symmetric MACs (private two-party verification only), analyze the vulnerabilities of **Textbook RSA Signatures ($\sigma = H(M)^d \pmod n$)** against multiplicative homomorphism and existential forgery, master the **RSA-PSS (Probabilistic Signature Scheme)** architecture incorporating random salt and Mask Generation Functions (MGF1), and prove **EUF-CMA (Existential Unforgeability under Chosen-Message Attack)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Digital Signature Guarantees (Non-Repudiation vs MAC), Hash-then-Sign & RSA-PSS Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step RSA-PSS Signature Generation and Verification Pipeline Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Digital Signature Primitive / Security Property & Cryptographic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Legal and Cryptographic Property Preventing a Signer from Falsely Denying Having Signed a Message (Non-Repudiation) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Digital Signatures Provide Non-Repudiation While Symmetric MACs Cannot Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Signature Foundations & RSA-PSS (Bellare & Rogaway 1996; RFC 8017; Katz & Lindell 12.1–12.5):
   - **The 3 Signature Pillars:**
     1. **Authenticity:** Verifies origin from holder of private key $SK$.
     2. **Integrity:** Detects any modification to message $M$.
     3. **Non-Repudiation:** Signer cannot deny creating the signature!
   - **Hash-then-Sign:** $\mathbf{\sigma = \text{Sign}_{SK}(H(M)) \implies \text{Verify}_{PK}(M, \sigma) \in \{\text{True}, \text{False}\}}$.
   - **RSA-PSS Architecture (RFC 8017):**
     $$\mathbf{H' = \text{Hash}(M_{\text{prefix}} \ || \ H(M) \ || \ \text{Salt}) \qquad ; \qquad \text{DB} = \text{PS} \ || \ \text{Salt} \qquad ; \qquad \text{MaskedDB} = \text{DB} \oplus \text{MGF1}(H')}$$
     - $\text{EM} = \text{MaskedDB} \ || \ H' \ || \ \text{0xBC} \implies \mathbf{\sigma = \text{EM}^d \pmod n}$.
     - Salt makes signatures randomized, achieving provable **EUF-CMA security**.
2. **Slide 2 (`ordering`):** Provide 5 steps of the RSA-PSS signing process: (1) hash the message using SHA-256 to compute mHash = H(M), (2) generate a cryptographically random salt string s, (3) concatenate padding, mHash, and salt to compute second hash H' = Hash(Padding || mHash || s), (4) apply Mask Generation Function to H' and XOR with Data Block to form MaskedDB, (5) construct encoded message EM = MaskedDB || H' || 0xBC and execute modular exponentiation: sigma = EM^d mod n!
3. **Slide 3 (`matching`):** Pair 4 signature concepts (Non-Repudiation, Hash-then-Sign, RSA-PSS Salt, EUF-CMA Security) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of non-repudiation. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why asymmetric digital signatures provide non-repudiation while symmetric MACs (HMAC) do not: Why can a digital signature be used in a court of law to legally prove that Alice sent a contract (Non-Repudiation), whereas a symmetric Message Authentication Code (HMAC) cannot prove whether Alice or Bob sent the contract? (In an HMAC scheme, Alice and Bob share the **exact same secret key $K$**; therefore, Bob could have created the HMAC tag himself and cannot prove to a judge that Alice was the author; in a digital signature scheme, **only Alice possesses her private signing key $SK$**, while Bob and the judge only have Alice's public verification key $PK$, mathematically proving that only Alice could have generated the signature).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "digital_signature_primitives_rsa_pss_and_hash_then_sign",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Digital Signatures & RSA-PSS (Bellare \\& Rogaway 1996)**\n• **Core Cryptographic Pillars (Katz & Lindell Chapter 12):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Security Property} & \\textbf{Digital Signatures (Asymmetric)} & \\textbf{MACs / HMAC (Symmetric)} \\\\\n\\hline\n\\mathbf{\\text{Authenticity}} & \\text{Guaranteed via Private Key } SK & \\text{Guaranteed via Shared Key } K \\\\\n\\mathbf{\\text{Integrity}} & \\text{Detects message tampering} & \\text{Detects message tampering} \\\\\n\\mathbf{\\text{Non-Repudiation}} & \\mathbf{\\text{YES (Only owner holds } SK\\text{)}} & \\mathbf{\\text{NO (Both parties hold } K\\text{)}} \\\\\n\\mathbf{\\text{Verifiability}} & \\mathbf{\\text{Public (Anyone with } PK\\text{)}} & \\text{Private (Only key holders)} \\\\\n\\hline\n\\end{array}\n$$\n• **Hash-then-Sign Invariant:** $\\mathbf{\\sigma = \\text{Sign}_{SK}(H(M)) \\implies \\text{Verify}_{PK}(M, \\sigma) \\in \\{\\text{True}, \\text{False}\\}}$\n• **RSA-PSS (RFC 8017):** Salted probabilistic encoding providing provable **EUF-CMA** security!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to construct an RSA-PSS digital signature.",
      "orderItems": [
        "Digest the arbitrary-length message using a cryptographic hash function: mHash = SHA-256(M)",
        "Generate a cryptographically secure random salt of length matching the hash output (e.g. 32 bytes)",
        "Concatenate fixed padding zeroes, mHash, and the random salt to compute second hash digest: H' = Hash(Padding || mHash || Salt)",
        "Apply Mask Generation Function (MGF1) to H' and XOR with Data Block to form MaskedDB: MaskedDB = DB XOR MGF1(H')",
        "Format Encoded Message EM = [MaskedDB || H' || 0xBC] and execute private key exponentiation: sigma = EM^d mod n"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Digital Signature Construct to its exact Functional Role.",
      "matchPairs": [
        { "left": "Non-Repudiation", "right": "Inability of a signer to falsely deny having authored a message because only they hold private key SK" },
        { "left": "Hash-then-Sign Paradigm", "right": "Hashes large data to fixed size before signing to optimize speed and eliminate algebraic attacks" },
        { "left": "RSA-PSS Random Salt", "right": "Injected randomness ensuring identical documents signed twice yield completely different signature values" },
        { "left": "EUF-CMA Security", "right": "Standard proof guaranteeing an attacker cannot forge signatures even after obtaining signatures for chosen messages" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The cryptographic property ensuring a signer cannot deny creating a signature is non-___.",
      "blankAnswer": "repudiation",
      "blankDistractors": ["malleability", "invertibility", "collision"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why can an asymmetric digital signature be used in a court of law to legally prove that Alice sent a contract (providing Non-Repudiation), whereas a symmetric Message Authentication Code (such as HMAC) cannot prove whether Alice or Bob generated the message?",
      "options": [
        { "text": "In symmetric HMAC authentication, Alice and Bob share the exact same secret key K; because Bob possesses key K, Bob is technically capable of generating valid HMAC tags himself, making it impossible for a third-party judge to determine whether Alice or Bob created the message; in an asymmetric digital signature scheme, only Alice possesses her private signing key SK, while Bob and the judge only have her public verification key PK, providing mathematical proof that only Alice could have created the signature", "isCorrect": true, "explanation": "Correct! This is the foundational distinction between symmetric message authentication codes and asymmetric digital signatures (Katz & Lindell Chapter 12.1; Serious Cryptography Chapter 13). 1. **The Shared Key Problem in Symmetric MACs:** - Alice and Bob share symmetric key $K$. - Alice sends: $(\\text{\"I promise to pay Bob $10,000\"}, \\text{HMAC}_K(\\text{Msg}))$. - Later, Alice tells the judge: 'I never sent that! Bob wrote that message himself and used our shared key $K$ to generate the HMAC!' - The judge CANNOT know who created the HMAC because **both Alice and Bob know $K$ and have identical cryptographic powers**. 2. **The Asymmetric Miracle of Digital Signatures:** - Alice signs with her private key $SK_{\\text{Alice}}$. - Bob and the judge verify with Alice's public key $PK_{\\text{Alice}}$. - Because NO ONE in the universe possesses $SK_{\\text{Alice}}$ except Alice, Alice cannot claim Bob fabricated it. - This provides absolute **Non-Repudiation** and public verifiability in legal contracts, software updates, and blockchain ledgers." },
        { "text": "Because HMAC keys can only be 4 bits long", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because digital signatures are written in handwriting on paper", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because HMAC hashes are destroyed after 24 hours", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
