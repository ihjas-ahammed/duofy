# Duofy Reusable Lesson Format: AES Four Round Transformations and State Matrix

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Symmetric_Encryption_AES_DES`  
**Lesson Format Type:** `aes_four_round_transformations_and_state_matrix`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic State Matrix transformations, Galois Field $GF(2^8)$ arithmetic, and key expansion pipelines of the Advanced Encryption Standard (AES / Rijndael) (Joan Daemen & Vincent Rijmen 2001, NIST FIPS PUB 197; Katz & Lindell *Introduction to Modern Cryptography* Chapter 6.2; William Stallings Chapter 5–6): master the **128-Bit $4 \times 4$ Byte State Matrix Representation** ($16\text{ bytes} \times 8\text{ bits} = 128\text{ bits}$), trace the **4 Distinct Round Transformations** in order (**1. `SubBytes` [Non-linear byte substitution using the Rijndael S-Box derived from multiplicative inverse in $GF(2^8)$ + affine transformation]**, **2. `ShiftRows` [Cyclic byte-level left shifts: Row 0 by 0, Row 1 by 1, Row 2 by 2, Row 3 by 3]**, **3. `MixColumns` [Linear matrix multiplication of each 4-byte column by fixed MDS polynomial matrix $c(x)$ in $GF(2^8)$]**, and **4. `AddRoundKey` [Bitwise XOR of the State with the 128-bit Round Subkey]**), understand the **Initial Pre-Round (`AddRoundKey`)** and **Final Round Exception (omits `MixColumns`)**, and decode the key schedule rounds ($AES\text{-}128 \implies 10\text{ rounds}$, $AES\text{-}192 \implies 12\text{ rounds}$, $AES\text{-}256 \implies 14\text{ rounds}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | AES $4 \times 4$ State Matrix, Round Schedule Table (10/12/14), & 4 Transformations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of a Standard AES Encryption Round Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | AES Transformation / Parameter & Cryptographic Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the AES Round Transformation Omitted in the Very Final Round (MixColumns) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why the Final Round of AES Omits the MixColumns Step Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State AES & Rijndael (FIPS 197; Katz & Lindell 6.2):
   - **The $4 \times 4$ Byte State Matrix (128 bits):**
     $$\mathbf{\text{State} = \begin{bmatrix} s_{0,0} & s_{0,1} & s_{0,2} & s_{0,3} \\ s_{1,0} & s_{1,1} & s_{1,2} & s_{1,3} \\ s_{2,0} & s_{2,1} & s_{2,2} & s_{2,3} \\ s_{3,0} & s_{3,1} & s_{3,2} & s_{3,3} \end{bmatrix}}$$
   - **Key Sizes & Round Counts:**
     - AES-128: 128-bit key $\implies$ **10 rounds** (11 round keys).
     - AES-192: 192-bit key $\implies$ **12 rounds** (13 round keys).
     - AES-256: 256-bit key $\implies$ **14 rounds** (15 round keys).
   - **The 4 Round Transformations:**
     1. **`SubBytes`:** $s'_{r,c} = S(s_{r,c})$ (Non-linear S-Box in $GF(2^8) \implies$ **Confusion**).
     2. **`ShiftRows`:** Row $r$ shifted left by $r$ bytes $\implies$ **Inter-Column Diffusion**.
     3. **`MixColumns`:** Column vector multiplied by Maximum Distance Separable (MDS) matrix over $GF(2^8) \implies$ **Intra-Column Diffusion**.
     4. **`AddRoundKey`:** $\text{State} \leftarrow \text{State} \oplus K_{\text{round}}$ (Key Dependency).
2. **Slide 2 (`ordering`):** Provide 5 steps of executing a standard AES round: (1) apply SubBytes: non-linearly substitute each byte of the 4x4 state matrix using the 256-byte S-Box lookup table, (2) apply ShiftRows: cyclically shift row 1 left by 1 byte, row 2 by 2 bytes, and row 3 by 3 bytes (row 0 untouched), (3) apply MixColumns: multiply each 4-byte column vector by the fixed MDS polynomial matrix over GF(2^8), (4) apply AddRoundKey: perform bitwise XOR between the 128-bit state matrix and the expanded round subkey, (5) pass the updated 128-bit state matrix as input into the subsequent AES encryption round!
3. **Slide 3 (`matching`):** Pair 4 AES transformations (SubBytes, ShiftRows, MixColumns, AddRoundKey) with their operations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that MixColumns is omitted in the final round. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why MixColumns is omitted in the final round: Why did the designers of AES (Joan Daemen & Vincent Rijmen) omit the `MixColumns` transformation from the final round (Round 10 of AES-128)? (Because `MixColumns` is a linear matrix multiplication over $GF(2^8)$ that is strictly reversible and key-independent; including `MixColumns` immediately before the final `AddRoundKey` step would provide **zero additional cryptographic security** against cryptanalysis (since an attacker could simply mathematically invert the linear mixing), while omitting it **makes the encryption and decryption structures symmetrical and avoids unnecessary CPU/hardware silicon overhead**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "aes_four_round_transformations_and_state_matrix",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Advanced Encryption Standard (AES / FIPS 197)**\n• **The 128-Bit \\(4 \\times 4\\) Byte State Matrix:**\n$$\n\\mathbf{\\text{State} = \\begin{bmatrix} s_{0,0} & s_{0,1} & s_{0,2} & s_{0,3} \\\\ s_{1,0} & s_{1,1} & s_{1,2} & s_{1,3} \\\\ s_{2,0} & s_{2,1} & s_{2,2} & s_{2,3} \\\\ s_{3,0} & s_{3,1} & s_{3,2} & s_{3,3} \\end{bmatrix} \\qquad (16\\text{ Bytes} = 128\\text{ Bits})}\n$$\n• **AES Variants & Round Parameters:**\n$$\n\\begin{array}{|c|c|c|c|}\n\\hline\n\\textbf{Algorithm} & \\textbf{Key Length} & \\textbf{Round Count } (N_r) & \\textbf{Expanded Subkeys} \\\\\n\\hline\n\\mathbf{\\text{AES-128}} & 128\\text{ bits (16B)} & \\mathbf{10\\text{ Rounds}} & 11\\text{ Subkeys (176B)} \\\\\n\\mathbf{\\text{AES-192}} & 192\\text{ bits (24B)} & \\mathbf{12\\text{ Rounds}} & 13\\text{ Subkeys (208B)} \\\\\n\\mathbf{\\text{AES-256}} & 256\\text{ bits (32B)} & \\mathbf{14\\text{ Rounds}} & 15\\text{ Subkeys (240B)} \\\\\n\\hline\n\\end{array}\n$$\n• **The 4 Round Transformations:** `SubBytes` (Confusion) $\\to$ `ShiftRows` (Diffusion) $\\to$ `MixColumns` (Diffusion) $\\to$ `AddRoundKey` (Key XOR)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential transformations executed within a standard intermediate AES encryption round (e.g. Round 1 to 9 of AES-128).",
      "orderItems": [
        "SubBytes Step: Perform non-linear byte-by-byte substitution on all 16 state bytes using the algebraic S-Box in GF(2^8)",
        "ShiftRows Step: Cyclically rotate Row 1 left by 1 byte, Row 2 left by 2 bytes, and Row 3 left by 3 bytes (Row 0 remains fixed)",
        "MixColumns Step: Multiply each 4-byte column vector by a fixed Maximum Distance Separable (MDS) matrix over Galois Field GF(2^8)",
        "AddRoundKey Step: Perform bitwise XOR (\\oplus) between the 128-bit state matrix and the 128-bit round subkey from key expansion",
        "Pass the transformed 4x4 byte state matrix as the direct input into the subsequent AES encryption round"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each AES Round Transformation to its exact Mathematical Action.",
      "matchPairs": [
        { "left": "SubBytes Transformation", "right": "Replaces each state byte with its non-linear multiplicative inverse in GF(2^8) combined with an affine mapping" },
        { "left": "ShiftRows Transformation", "right": "Performs circular left shifts on the bottom three rows of the 4x4 state matrix to provide inter-column diffusion" },
        { "left": "MixColumns Transformation", "right": "Treats each column as a polynomial over GF(2^8) and multiplies it modulo (x^4 + 1) by a constant MDS matrix" },
        { "left": "AddRoundKey Transformation", "right": "Executes a bitwise XOR between each column of the state matrix and a 32-bit word of the expanded round key" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the final round of AES encryption (Round 10 of AES-128), the ___ transformation is completely omitted.",
      "blankAnswer": "MixColumns",
      "blankDistractors": ["SubBytes", "ShiftRows", "AddRoundKey"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did the designers of AES (Joan Daemen and Vincent Rijmen) intentionally omit the MixColumns transformation from the very final round of AES encryption (Round 10 in AES-128)?",
      "options": [
        { "text": "MixColumns is a linear, key-independent matrix multiplication over GF(2^8); because the final round output is directly XORed with the final round key in AddRoundKey, an attacker analyzing ciphertext could simply mathematically invert the linear MixColumns step without knowing the key, offering zero additional cryptographic diffusion or resistance against cryptanalysis while omitting it makes encryption and decryption hardware circuits symmetrical and faster", "isCorrect": true, "explanation": "Correct! This is one of the most famous structural design optimizations in modern block ciphers (Joan Daemen & Vincent Rijmen *The Design of Rijndael: AES - The Advanced Encryption Standard*; William Stallings Chapter 5.2). 1. **The Mathematical Linearity of MixColumns:** - `MixColumns` is purely linear matrix multiplication over $GF(2^8)$: $\\mathbf{s'} = M \\cdot \\mathbf{s}$. - It contains no secret key material and no non-linear S-Boxes. 2. **Evaluating the Final Round:** - If Round 10 included `MixColumns`, the final steps would be: $\\text{Ciphertext } C = (M \\cdot \\text{State}) \\oplus K_{10}$. - Since $M$ is fixed, public, and mathematically invertible ($M^{-1}$ is known), an attacker could simply compute $M^{-1} \\cdot C$ directly on the ciphertext. - Thus, `MixColumns` in the final round provides **zero added algebraic complexity or cryptographic protection**! 3. **Hardware Symmetry:** - Omitting `MixColumns` in the final round ensures that AES decryption can be implemented as an exact inverted mirror of encryption, simplifying ASIC silicon chip layouts." },
        { "text": "Because Galois field matrix multiplication is forbidden in odd-numbered years", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 128-bit keys cannot be divided by 4", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the final round is executed in software while previous rounds run on CPU registers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
