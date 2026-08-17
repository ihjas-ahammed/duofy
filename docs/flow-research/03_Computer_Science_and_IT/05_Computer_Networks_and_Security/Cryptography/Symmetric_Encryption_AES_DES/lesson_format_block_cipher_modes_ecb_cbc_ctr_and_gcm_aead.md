# Duofy Reusable Lesson Format: Block Cipher Modes (ECB, CBC, CTR, and GCM AEAD)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Symmetric_Encryption_AES_DES`  
**Lesson Format Type:** `block_cipher_modes_ecb_cbc_ctr_and_gcm_aead`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the operational equations, initialization vector (IV) requirements, parallelism properties, and security vulnerabilities of standard block cipher modes of operation (NIST SP 800-38A / NIST SP 800-38D; Katz & Lindell *Introduction to Modern Cryptography* Chapter 3.6–3.7; William Stallings Chapter 6): master the **Insecurity of Electronic Codebook (ECB)** ($C_i = E_K(P_i)$, proves deterministic encryption leaks data patterns e.g. the ECB Penguin), decode **Cipher Block Chaining (CBC)** ($C_i = E_K(P_i \oplus C_{i-1})$ with unique unpredictable IV, vulnerability to CBC Padding Oracle attacks like POODLE/Vaudenay), decode **Counter Mode (CTR)** ($C_i = P_i \oplus E_K(Nonce \ || \ Counter_i)$, converts block cipher to stream cipher with multi-core parallelism and precomputation), and master **Galois/Counter Mode (GCM - AEAD)** (integrates CTR encryption with Galois Field $GF(2^{128})$ GHASH authentication to provide simultaneous **Confidentiality, Authenticity, and Integrity** in one pass).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Block Cipher Modes Comparison Matrix (ECB vs CBC vs CTR vs GCM) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Encryption Flow of a Multi-Block Message in CBC Mode Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Block Cipher Mode & Cryptographic Vulnerability / Capability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Mode of Operation That Combines CTR Encryption with Galois Field GHASH Authentication Is ___ (GCM) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why the ECB Penguin Phenomenon Occurs in Electronic Codebook Mode Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Block Cipher Modes (NIST SP 800-38A/D; Katz & Lindell 3.6–3.7):
   - **The 4 Major Modes Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Mode} & \textbf{Encryption Formula} & \textbf{IV / Nonce} & \textbf{Parallelizable?} & \textbf{Security Guarantee} \\
     \hline
     \mathbf{\text{ECB}} & C_i = E_K(P_i) & \text{None} & \text{Yes} & \mathbf{\text{INSECURE! (Pattern leakage)}} \\
     \mathbf{\text{CBC}} & C_i = E_K(P_i \oplus C_{i-1}) & \text{Random IV} & \text{Decryption Only} & \text{Confidentiality (Needs HMAC)} \\
     \mathbf{\text{CTR}} & C_i = P_i \oplus E_K(\text{Nonce} \ || \ i) & \text{Unique Nonce} & \mathbf{\text{Yes (Both Enc/Dec)}} & \text{Confidentiality (Stream cipher)} \\
     \mathbf{\text{GCM}} & \text{CTR Encryption} + \text{GHASH} & \text{96-bit Nonce} & \mathbf{\text{Yes (Hardware ASIC)}} & \mathbf{\text{AEAD (Confidentiality + Authenticity)}} \\
     \hline
     \end{array}$$
   - **The Golden Rule:** Always use **Authenticated Encryption with Associated Data (AEAD)** like **AES-GCM** or **ChaCha20-Poly1305**!
2. **Slide 2 (`ordering`):** Provide 5 steps of CBC mode encryption: (1) generate cryptographically secure random 128-bit Initialization Vector (IV), (2) perform bitwise XOR between first plaintext block P_1 and IV: (P_1 XOR IV), (3) encrypt XOR result with secret key K using AES: C_1 = E_K(P_1 XOR IV), (4) chain to next block: XOR second plaintext block P_2 with previous ciphertext C_1: (P_2 XOR C_1), (5) encrypt with AES: C_2 = E_K(P_2 XOR C_1) and prepend IV to final ciphertext!
3. **Slide 3 (`matching`):** Pair 4 cipher modes (ECB Mode, CBC Mode, CTR Mode, GCM Mode) with their properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Galois/Counter Mode (GCM). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the ECB Penguin effect: When an uncompressed bitmap image of Tux the Linux Penguin is encrypted using AES in Electronic Codebook (ECB) mode, why does the resulting ciphertext image clearly display the full visual outline and shape of the penguin? (Because **ECB mode is completely deterministic and lacks an Initialization Vector (IV) or chaining**; identical 16-byte plaintext blocks (such as solid white background pixels or solid black penguin body pixels) **always encrypt to the exact same 16-byte ciphertext blocks**, preserving the spatial frequency and visual structure of the original image; randomized modes like CBC, CTR, and GCM produce completely uniform pseudorandom noise).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "block_cipher_modes_ecb_cbc_ctr_and_gcm_aead",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Block Cipher Modes of Operation (NIST SP 800-38A/D)**\n• **Core Modes Taxonomy (Katz & Lindell Chapter 3.6):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Mode} & \\textbf{Encryption Recurrence} & \\textbf{Parallelism} & \\textbf{Security Assessment} \\\\\n\\hline\n\\mathbf{\\text{ECB}} & C_i = E_K(P_i) & \\text{Fully Parallel} & \\mathbf{\\text{BROKEN! (Leaks plaintext patterns)}} \\\\\n\\mathbf{\\text{CBC}} & C_i = E_K(P_i \\oplus C_{i-1}) & \\text{Decryption Only} & \\text{Confidentiality (Padding Oracle risk)} \\\\\n\\mathbf{\\text{CTR}} & C_i = P_i \\oplus E_K(\\text{Nonce} \\ || \\ i) & \\mathbf{\\text{Enc \\& Dec Parallel}} & \\text{Stream Cipher (Requires MAC)} \\\\\n\\mathbf{\\text{GCM}} & \\mathbf{\\text{CTR Encrypt} + \\text{GHASH MAC}} & \\mathbf{\\text{Full Hardware Line-Rate}} & \\mathbf{\\text{AEAD (Confidentiality + Integrity)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The ECB Penguin Disaster:** Identical input blocks produce identical output blocks!\n• **Modern Standard:** Always mandate **AES-GCM** (AEAD) in TLS and disk encryption!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to encrypt a message in Cipher Block Chaining (CBC) mode.",
      "orderItems": [
        "Generate a cryptographically secure 128-bit random Initialization Vector (IV) and pad plaintext to 16-byte boundary",
        "Perform bitwise XOR between the first plaintext block (P_1) and the IV: [P_1 XOR IV]",
        "Encrypt the XORed result using the AES block cipher and secret key K to generate the first ciphertext block: C_1 = E_K(P_1 XOR IV)",
        "Chain into block 2: XOR the second plaintext block (P_2) with the previous ciphertext block: [P_2 XOR C_1]",
        "Encrypt [P_2 XOR C_1] with AES to produce C_2 = E_K(P_2 XOR C_1) and prepend the unencrypted IV to the transmitted ciphertext"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Block Cipher Mode to its exact Cryptographic Property.",
      "matchPairs": [
        { "left": "Electronic Codebook (ECB)", "right": "Stateless deterministic mode that fatally leaks plaintext patterns and image outlines" },
        { "left": "Cipher Block Chaining (CBC)", "right": "Sequential feedback mode where each plaintext block is XORed with preceding ciphertext before encryption" },
        { "left": "Counter Mode (CTR)", "right": "Converts a block cipher into a stream cipher by encrypting incrementing counter values" },
        { "left": "Galois/Counter Mode (GCM)", "right": "NIST-standardized AEAD mode providing simultaneous high-speed encryption and Galois GHASH authentication" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The modern AEAD mode that combines CTR encryption with Galois Field GHASH authentication is ___.",
      "blankAnswer": "GCM",
      "blankDistractors": ["ECB", "CBC", "CFB"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When a raw uncompressed bitmap image of Tux the Linux Penguin is encrypted using AES in Electronic Codebook (ECB) mode, why does the resulting ciphertext image clearly display the visible shape and outline of the penguin?",
      "options": [
        { "text": "Because ECB mode is completely deterministic and lacks an Initialization Vector (IV) or chaining feedback; every identical 16-byte plaintext block (such as continuous regions of white background pixels or solid black body pixels) always encrypts to the exact same 16-byte ciphertext block under the same key, perfectly preserving the spatial frequency, contours, and statistical structure of the original image", "isCorrect": true, "explanation": "Correct! This is the legendary 'ECB Penguin' demonstration in cryptography (Katz & Lindell Section 3.6.1; Serious Cryptography Chapter 4). 1. **How ECB Mode Works:** - $C_1 = E_K(P_1)$ - $C_2 = E_K(P_2)$ - $C_3 = E_K(P_3)$ - There is no random Initialization Vector (IV) and no feedback from previous blocks. 2. **The Flaw (Deterministic Mapping):** - If an image has 10,000 blocks of pure white background (where each block is `0xFF, 0xFF, ...`), EVERY ONE of those 10,000 blocks encrypts to the exact same ciphertext block `0x9A, 0x4F, ...`. - If Tux's belly is 2,000 blocks of pure yellow pixels, every yellow block encrypts to `0x3B, 0x1C, ...`. - When you display the encrypted bytes on a screen, the background is one uniform pseudo-color, the belly is another pseudo-color, and Tux the Penguin is clearly visible! 3. **The Solution:** - Randomized modes like **CBC, CTR, and GCM** incorporate a unique IV/Nonce, ensuring that 10,000 identical white blocks encrypt to 10,000 completely different, pseudorandom ciphertext blocks that appear as pure white noise." },
        { "text": "Because Linux images contain a copyright watermark that cannot be encrypted", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AES only encrypts text and ignores image pixel data", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because ECB mode compresses files before encryption", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
