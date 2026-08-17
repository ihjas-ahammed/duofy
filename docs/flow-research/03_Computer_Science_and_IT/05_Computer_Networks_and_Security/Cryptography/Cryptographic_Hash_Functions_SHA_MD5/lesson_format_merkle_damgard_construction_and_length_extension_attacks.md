# Duofy Reusable Lesson Format: Merkle-Damgård Construction and Length Extension Attacks

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Cryptographic_Hash_Functions_SHA_MD5`  
**Lesson Format Type:** `merkle_damgard_construction_and_length_extension_attacks`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the iterative compression function chaining, padding rules, and length extension vulnerabilities of the Merkle-Damgård hash construction (Ralph Merkle 1979 & Ivan Damgård 1989; NIST FIPS 180-4 SHA-256; Katz & Lindell *Introduction to Modern Cryptography* Chapter 5.2 & 5.4; Serious Cryptography Chapter 6): master the **Merkle-Damgård Iteration Pipeline** (Initial Vector $IV = s_0$, fixed compression function $f$, message block splitting $M = M_1 || M_2 || \dots || M_k$, MD-strengthening bit-length padding, internal state recurrence $\mathbf{s_i = f(s_{i-1}, M_i)}$, and final output $H(M) = s_k$), analyze the **Length Extension Vulnerability** (why naive prefix MACs $\text{MAC} = H(\text{SecretKey} \ || \ M)$ are completely broken because an attacker knowing $H(\text{SecretKey} \ || \ M)$ can initialize the compression state to $H$ and append extra malicious data $M_{\text{extra}}$ without knowing the SecretKey), and evaluate why HMAC was created to fix this flaw.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Merkle-Damgård Chaining Recurrence, Length Extension Threat Diagram Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of a Length Extension Attack on a Vulnerable Web API Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Merkle-Damgård Component / Attack Vector & Cryptographic Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Vulnerability Where an Attacker Appends Data to a Hash Without Knowing the Prefix Secret Key (Length Extension Attack) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Naive Secret-Prefix Hashing H(Key || Message) is Insecure in SHA-256 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Merkle-Damgård & Length Extension (Merkle 1979; Damgård 1989; Katz & Lindell 5.2):
   - **The Merkle-Damgård Construction:**
     $$\mathbf{s_0 = IV \qquad ; \qquad \mathbf{s_i = f(s_{i-1}, M_i)} \qquad ; \qquad \mathbf{H(M) = s_k}}$$
     - Compression function $f: \{0,1\}^n \times \{0,1\}^b \to \{0,1\}^n$ (e.g. Davies-Meyer in SHA-256).
   - **The Fatal Flaw of Naive MAC ($\text{MAC} = H(K \ || \ M)$):**
     - Since $H(K \ || \ M)$ is simply the final state $s_k$, anyone who sees $H(K \ || \ M)$ can use it as the **new IV** to hash additional blocks:
       $$\mathbf{H(K \ || \ M \ || \ \text{pad} \ || \ M_{\text{extra}}) = f\big(H(K \ || \ M), \ M_{\text{extra}}\big)}$$
     - Attacker creates valid signature for $(M \ || \ \text{pad} \ || \ M_{\text{extra}})$ **WITHOUT EVER KNOWING THE SECRET KEY $K$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of executing a Length Extension Attack on API token: (1) server issues URL `download.php?file=report.pdf&admin=0&sig=H(Key || "file=report.pdf&admin=0")`, (2) attacker intercepts URL and extracts original message and hash digest H_original, (3) attacker computes padding bytes for original message length (MD-strengthening padding), (4) attacker initializes SHA-256 state registers (a-h) directly with H_original and feeds malicious block `&admin=1` into compression function f, (5) attacker sends forged request `download.php?file=report.pdf&admin=0<pad>&admin=1&sig=H_forged`; server validates signature successfully!
3. **Slide 3 (`matching`):** Pair 4 concepts (Compression Function f, IV Initial Vector, MD-Strengthening Padding, Length Extension Attack) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of length extension attack. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why naive prefix hashing fails: Why is the naive message authentication scheme $\text{AuthToken} = \text{SHA-256}(\text{SecretKey} \ || \ \text{Message})$ fundamentally insecure against active forgery attacks? (Because in the Merkle-Damgård construction of SHA-256, **the final 256-bit hash output is identical to the internal chaining state $s_k$ of the hash function**; an attacker who intercepts $(\text{Message}, \text{AuthToken})$ and knows or guesses the byte-length of $\text{SecretKey}$ can reconstruct the exact internal state, apply Merkle-Damgård padding, and execute one additional round of the compression function to compute a mathematically valid signature for $(\text{Message} \ || \ \text{Padding} \ || \ \text{MaliciousPayload})$ **with zero knowledge of the SecretKey**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "merkle_damgard_construction_and_length_extension_attacks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Merkle-Damgård Construction & Length Extension (Merkle 1979)**\n• **Iterative Chaining Recurrence (Katz & Lindell Chapter 5.2):**\n$$\n\\mathbf{s_0 = IV \\qquad ; \\qquad \\mathbf{s_i = f(s_{i-1}, M_i)} \\qquad ; \\qquad \\mathbf{H(M) = s_k}}\n$$\n• **The Fatal Flaw of Secret-Prefix Hashing \\(\\text{MAC} = H(K \\ || \\ M)\\):**\nBecause the hash output $H(K \\ || \\ M)$ is **literally the final internal state $s_k$**, an attacker can initialize a new hash calculation using $s_k$ as the starting state:\n$$\n\\mathbf{H(K \\ || \\ M \\ || \\ \\text{Pad} \\ || \\ M_{\\text{extra}}) = f\\big(H(K \\ || \\ M), \\ M_{\\text{extra}}\\big)}\n$$\n• **The Result:** The attacker computes a valid cryptographic signature for extended data **WITHOUT EVER KNOWING SECRET KEY $K$**!\n• **The Cure:** Never use raw hashes for authentication; always use **HMAC (RFC 2104)** or **SHA-3 (Sponge)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by an attacker performing a Length Extension Attack against a vulnerable API using SHA-256(SecretKey || Message).",
      "orderItems": [
        "Intercept authorized web API request: 'action=view&user=alice&sig=' where sig = SHA-256(SecretKey || 'action=view&user=alice')",
        "Determine the byte length of the SecretKey (or iterate common key lengths from 16 to 64 bytes)",
        "Construct the Merkle-Damgård length padding string (0x80, zero padding, and 64-bit original bit length)",
        "Initialize the internal SHA-256 working registers (a through h) using the 8 words of the intercepted 'sig' hash digest",
        "Process the appended malicious payload '&role=admin' through compression function f and transmit forged request with new valid hash"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Merkle-Damgård / Hash Element to its exact Cryptographic Role.",
      "matchPairs": [
        { "left": "Compression Function f", "right": "Fixed-size one-way mapping taking chaining state s_{i-1} and message block M_i to produce next state s_i" },
        { "left": "MD-Strengthening", "right": "Padding rule appending original message bit length to prevent collisions across different message lengths" },
        { "left": "Length Extension Attack", "right": "Vulnerability allowing an attacker to compute H(K || M || pad || extra) from H(K || M) without knowing K" },
        { "left": "Initial Vector (IV)", "right": "Standardized constant bit string initializing the first compression function state s_0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The vulnerability where an attacker appends data to a Merkle-Damgård hash without knowing the secret key is a Length ___ Attack.",
      "blankAnswer": "Extension",
      "blankDistractors": ["Truncation", "Collision", "Preimage"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the intuitive message authentication construct AuthToken = SHA-256(SecretKey || Message) fundamentally insecure for authorizing web commands?",
      "options": [
        { "text": "Because in the Merkle-Damgård construction of SHA-256, the final hash digest output is identical to the internal register chaining state of the hash function; an attacker who intercepts (Message, AuthToken) and knows or guesses the SecretKey's length can reconstruct the internal state registers, append the mandatory Merkle-Damgård padding, and run one additional compression round on a malicious string (e.g. '&role=admin') to produce a 100% valid AuthToken without knowing the SecretKey", "isCorrect": true, "explanation": "Correct! This is one of the most famous real-world vulnerabilities discovered in web API tokens (e.g. Flickr API vulnerability in 2009; Katz & Lindell Section 5.4; Serious Cryptography Chapter 6). 1. **How SHA-256 Processes Data:** - SHA-256 maintains 8 32-bit state variables $(a, b, c, d, e, f, g, h) = 256\\text{ bits}$. - It processes block 1, updates state. Processes block 2, updates state. - The final 256-bit hash you see in your browser is **literally the exact state registers $(a, b, c, d, e, f, g, h)$ after the last block**! 2. **The Attacker's Trick (Length Extension):** - Suppose Server calculates: $\\text{sig} = \\text{SHA-256}(\\text{Key} \\ || \\ \\text{\"user=bob\"})$. - Attacker intercepts $\\text{\"user=bob\"}$ and $\\text{sig} = \\text{0x8f4a...}$. - The attacker does NOT need to crack the key! The attacker simply loads $\\text{0x8f4a...}$ directly into a SHA-256 program as the starting state, appends the valid padding bytes, and hashes the new text $\\text{\"&admin=true\"}$. - The resulting hash is **mathematically identical** to what the server would compute for $\\text{SHA-256}(\\text{Key} \\ || \\ \\text{\"user=bob<pad>&admin=true\"})$! 3. The server validates the forged signature, grants admin rights, and is compromised." },
        { "text": "Because SHA-256 is an asymmetric algorithm that requires a private key", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SHA-256 can only hash numbers and cannot hash letters", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SecretKey and Message cancel each other out via XOR", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
