# Duofy Reusable Lesson Format: SHA-3 Keccak Sponge Construction (Absorb and Squeeze)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Cryptographic_Hash_Functions_SHA_MD5`  
**Lesson Format Type:** `sha3_keccak_sponge_construction_absorb_squeeze`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the state permutation geometry, sponge absorption/squeezing phases, and length extension immunity of the Secure Hash Algorithm 3 (SHA-3 / Keccak) (Guido Bertoni, Joan Daemen, Michaël Peeters, Gilles Van Assche 2011; NIST FIPS PUB 202; Serious Cryptography Chapter 6.4; Katz & Lindell *Introduction to Modern Cryptography* Chapter 5.3): master the **1600-Bit 3D State Matrix Representation** ($5 \times 5 \times 64$-bit lanes $= 1600\text{ bits}$), analyze the **Sponge Construction Parameters** ($\mathbf{\text{Width } b = \text{Rate } r + \text{Capacity } c = 1600\text{ bits}}$, where Rate $r$ determines throughput and Capacity $c = 2 \times \text{Security Level}$ determines resistance to collision/preimage attacks), trace the **Absorbing Phase (XORing message blocks into rate $r$ followed by 24 rounds of Keccak-$f[1600]$ permutation: $\theta, \rho, \pi, \chi, \iota$)** and the **Squeezing Phase (extracting hash digest output $r$ bits at a time)**, and evaluate why SHA-3 is completely immune to Length Extension Attacks.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Keccak Sponge Architecture Diagram, 1600-bit State (Rate + Capacity) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of the Absorbing and Squeezing Phases in SHA-3 Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sponge Construct / Keccak Permutation Step & Functional Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Hidden Portion of the Keccak Sponge State Providing Cryptographic Security Is Called the ___ (Capacity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why the Sponge Construction is Inherently Immune to Length Extension Attacks Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SHA-3 & Sponge (FIPS 202; Serious Cryptography 6.4):
   - **The 1600-Bit Sponge State:**
     $$\mathbf{\text{State Width } b = \mathbf{\text{Rate } r} \ + \ \mathbf{\text{Capacity } c} = 1600\text{ bits}}$$
     - **Rate $r$:** Number of bits absorbed/squeezed per iteration (High $r \implies$ high speed).
     - **Capacity $c$:** Unexposed security buffer ($\text{Security Level } = \frac{c}{2}$).
       - For SHA3-256: $c = 512\text{ bits}$, $r = 1088\text{ bits}$.
   - **The 2 Phases:**
     1. **Absorbing:** $S \leftarrow f(S \oplus (M_i \ || \ 0^c))$.
     2. **Squeezing:** Digest $\leftarrow$ truncate first $r$ bits of $S$, iterate $f(S)$ if more output bits needed.
   - **The Keccak-$f[1600]$ Permutation (24 Rounds):** $\theta$ (parity mix), $\rho$ (bit rotate), $\pi$ (lane permute), $\chi$ (non-linear S-Box), $\iota$ (round constant XOR).
2. **Slide 2 (`ordering`):** Provide 5 steps of hashing message in SHA-3: (1) pad message using multi-rate 10*1 padding rule to align with block size r, (2) initialize 1600-bit state matrix to all zeros, (3) XOR message block M_1 with the first r bits of the state (leaving capacity c untouched), (4) apply 24 rounds of the Keccak-f[1600] permutation function to scramble all 1600 bits, (5) enter Squeezing phase: read out the first 256 bits of the state as the final SHA3-256 hash digest!
3. **Slide 3 (`matching`):** Pair 4 sponge concepts (Rate r, Capacity c, Absorbing Phase, Squeezing Phase) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the hidden security buffer is capacity. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Sponge construction eliminates length extension attacks: Why is the Keccak Sponge construction used in SHA-3 fundamentally immune to the Length Extension Attacks that plague Merkle-Damgård hashes (such as SHA-256)? (Because in SHA-3, **the Capacity $c$ (e.g. 512 bits in SHA3-256) is completely hidden and never output in the hash digest**; during the squeezing phase, only the Rate portion $r$ is exposed to the user, meaning an attacker does NOT know the internal capacity bits and **cannot reconstruct the 1600-bit internal state $S$ needed to continue the permutation chain**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sha3_keccak_sponge_construction_absorb_squeeze",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SHA-3 Keccak Sponge Construction (FIPS 202)**\n• **Sponge State Partitioning (Bertoni et al. 2011):**\n$$\n\\mathbf{\\text{Total State Width } b = \\mathbf{\\text{Rate } r} \\ + \\ \\mathbf{\\text{Capacity } c} = 1600\\text{ Bits}}\n$$\n• **The Two Operational Sponge Phases:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Phase} & \\textbf{State Action} & \\textbf{Cryptographic Function} \\\\\n\\hline\n\\mathbf{\\text{Absorbing}} & \\text{XOR } M_i \\text{ into Rate } r \\to \\text{Permute } f & \\mathbf{\\text{Ingests variable-length message blocks into state}} \\\\\n\\mathbf{\\text{Squeezing}} & \\text{Extract } r \\text{ bits} \\to \\text{Permute } f & \\mathbf{\\text{Extracts arbitrary-length cryptographic digest outputs}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 24-Round Keccak Permutation:** $\\theta$ (Diffusion) $\\to$ $\\rho$ (Rotations) $\\to$ $\\pi$ (Transposition) $\\to$ $\\chi$ (Non-linear Confusion) $\\to$ $\\iota$ (Asymmetry)!\n• **Security Guarantee:** **Zero Length Extension Attacks** because Capacity $c$ is NEVER exposed!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by SHA-3 to hash a message using the Sponge Construction.",
      "orderItems": [
        "Append 10*1 multi-rate padding to message to ensure total length is an exact multiple of Rate (r) bits",
        "Initialize the 1600-bit (5x5x64-bit array) internal state matrix to all zeroes",
        "Absorbing Step: Bitwise XOR the first r-bit message block into the Rate portion of the state, leaving Capacity (c) untouched",
        "Permutation Step: Execute 24 rounds of the Keccak-f[1600] non-linear permutation (theta, rho, pi, chi, iota) across all 1600 bits",
        "Squeezing Step: Truncate and read the first 256 bits of the Rate portion of the state as the final SHA3-256 hash digest"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Sponge Construction Parameter / Phase to its exact Cryptographic Role.",
      "matchPairs": [
        { "left": "Rate Parameter (r)", "right": "The visible portion of the 1600-bit state where message blocks are absorbed and digests squeezed" },
        { "left": "Capacity Parameter (c)", "right": "The hidden secret buffer portion of the state guaranteeing 2^(c/2) security against attacks" },
        { "left": "Absorbing Phase", "right": "Iterative process of XORing incoming message blocks into the rate and applying Keccak-f permutation" },
        { "left": "Squeezing Phase", "right": "Output generation process extracting digest bits from the rate portion of the scrambled state" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In SHA-3 sponge architecture, the unexposed state portion providing cryptographic security is the ___.",
      "blankAnswer": "capacity",
      "blankDistractors": ["rate", "width", "digest"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Keccak Sponge construction used in SHA-3 completely immune to the Length Extension Attacks that compromise Merkle-Damgård hash functions like SHA-256?",
      "options": [
        { "text": "In SHA-3, the 1600-bit state is divided into Rate (r) and Capacity (c); during the Squeezing phase, the hash digest only extracts bits from the Rate portion, while the Capacity portion (e.g. 512 bits in SHA3-256) remains completely hidden and unrevealed; because an attacker does not know the private Capacity bits, they cannot reconstruct the complete 1600-bit internal state matrix required to continue the Keccak permutation and append extra data", "isCorrect": true, "explanation": "Correct! This is one of the most celebrated architectural breakthroughs of the Keccak sponge construction (Guido Bertoni et al. 2011; Serious Cryptography Chapter 6.4). 1. **Why Merkle-Damgård Failed (SHA-256):** - In SHA-256, the entire internal state ($256\\text{ bits}$) is dumped directly into the hash output! - An attacker who sees the hash knows $100\\%$ of the internal state. 2. **How SHA-3 Solves It (The Hidden Capacity Buffer):** - In SHA3-256, the total internal state is $1600\\text{ bits}$. - $\\text{Rate } r = 1088\\text{ bits}$, $\\text{Capacity } c = 512\\text{ bits}$. - When the hash output is produced, SHA3-256 extracts only the first $256\\text{ bits}$ of the Rate. - The remaining $1344\\text{ bits}$ (and crucially, the entire $512\\text{ bits}$ of Capacity $c$) remain **completely secret**! 3. **The Impossibility of Extension:** - An attacker trying to append data needs all 1600 bits to run the next round of $\\text{Keccak-}f[1600]$. - Since the attacker is missing the 512 capacity bits, guessing them would require $2^{512}$ operations (which is physically impossible). - Length Extension Attacks fail with probability 1." },
        { "text": "Because SHA-3 can only be calculated on quantum supercomputers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SHA-3 uses 56-bit DES keys for encryption", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SHA-3 prohibits strings longer than 100 characters", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
