# Duofy Reusable Lesson Format: Symmetric Cryptanalysis, Avalanche Effect, and Side Channels

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Symmetric_Encryption_AES_DES`  
**Lesson Format Type:** `symmetric_cryptanalysis_avalanche_effect_and_side_channels`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify cryptographic strength metrics, statistical diffusion proofs, and hardware implementation attack vectors against symmetric block ciphers (Eli Biham & Adi Shamir 1991 *Differential Cryptanalysis of DES*; Mitsuru Matsui 1993 *Linear Cryptanalysis*; Paul Kocher 1996 *Timing Attacks*; Katz & Lindell *Introduction to Modern Cryptography* Chapter 6.3–6.6): master the **Strict Avalanche Criterion (SAC)** (flipping a single bit in the plaintext or key must cause each output ciphertext bit to change with probability exactly $p = 0.5$, flipping $\approx 50\%$ of all bits [$\approx 64$ bits in AES]), analyze theoretical cryptanalytic techniques (**Brute Force $2^{128} / 2^{256}$ keyspace complexity**, **Differential Cryptanalysis [tracking difference propagation $\Delta X \to \Delta Y$ through S-Boxes]**, **Linear Cryptanalysis [approximating non-linear transformations with linear relations]**), master **Side-Channel Attacks** (**Cache-Timing Attacks on AES T-Tables**, **Power Analysis DPA**, and **Constant-Time Hardware Implementations using AES-NI instructions**), and interact with live 1-bit flip Avalanche Effect and Hamming distance simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Strict Avalanche Criterion (SAC), Differential/Linear Attacks, & Constant-Time AES Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Cryptanalysis Technique / Side Channel & Attack Vector Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why AES Implementations Replaced Software T-Table Lookups with Hardware AES-NI Instructions Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Statistical Principle Where a 1-Bit Change Flips Approximately 50% of Output Bits (Avalanche Effect) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive 1-Bit Plaintext Mutation Avalanche Effect & Hamming Distance Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "symmetric_cryptanalysis_avalanche_effect_and_side_channels",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Strict Avalanche Criterion, how do Differential/Linear cryptanalysis work, and what are Cache-Timing side-channel attacks?",
      "blankAnswer": "Symmetric Cryptanalysis & Side Channels (Katz & Lindell Chapter 6): (1) STRICT AVALANCHE CRITERION (SAC): A high-quality cryptographic cipher must guarantee that flipping a SINGLE bit in either the plaintext or key causes each ciphertext output bit to flip with probability p = 0.5 (averaging ~50% or ~64 bits flipped in 128-bit AES!). (2) MATHEMATICAL ATTACKS: (a) Differential Cryptanalysis (Biham & Shamir 1991): Analyzes how differences in plaintext pairs (Delta X = P1 XOR P2) propagate through S-Boxes to reveal round keys. AES was specifically designed to resist differential attacks (wide-trail strategy). (b) Linear Cryptanalysis (Matsui 1993): Finds high-probability linear approximations connecting plaintext, ciphertext, and key bits. (3) SIDE-CHANNEL ATTACKS (Paul Kocher 1996): Attacks that exploit physical implementation artifacts rather than mathematical flaws: (i) Cache-Timing Attacks: Software AES implementations using 256-byte S-Box lookup tables (T-Tables) leak secret key bits through CPU memory cache hit/miss timing variations! (ii) Constant-Time Mitigation: Modern CPUs implement dedicated hardware instruction sets (AES-NI / ARMv8-A Crypto) that execute in constant time, eliminating all cache timing leaks!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Cryptanalytic Method / Implementation Hazard to its exact Technical Mechanism.",
      "matchPairs": [
        { "left": "Strict Avalanche Criterion (SAC)", "right": "Property requiring each output bit to change with probability 0.5 whenever any single input bit is flipped" },
        { "left": "Differential Cryptanalysis", "right": "Exploits non-uniform output XOR difference distributions across S-Boxes from known plaintext differences" },
        { "left": "Cache-Timing Side Channel", "right": "Deduces secret key bits by measuring CPU memory cache access latency during S-Box table lookups" },
        { "left": "AES-NI Hardware Instructions", "right": "Dedicated CPU silicon instructions executing AES transformations in constant time to thwart timing attacks" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why did modern cryptographic engineering (e.g. OpenSSL, Linux kernel, web browsers) abandon software S-Box lookup tables (T-Tables) for AES in favor of constant-time bit-sliced software algorithms or CPU hardware instructions (AES-NI)?",
      "options": [
        { "text": "Software lookup tables (T-Tables) index memory based on secret key-dependent values (e.g. S-Box[byte XOR key]); because CPU memory caching causes memory lookups for cached addresses to execute faster than memory lookups that miss cache, a local co-located attacker can measure microsecond execution timing variations (Cache-Timing Side-Channel) to reconstruct the secret AES key; constant-time hardware instructions (AES-NI) execute in fixed clock cycles independent of key or data values, completely eliminating cache timing leaks", "isCorrect": true, "explanation": "Correct! This is one of the most famous hardware security paradigms discovered in modern computing (Paul Kocher 1996; Daniel J. Bernstein 2005 *Cache-timing attacks on AES*; Katz & Lindell Chapter 6). 1. **How Software AES Worked (T-Tables):** - To make AES fast in C/C++, developers precomputed $4 \\times 1024$-byte lookup tables combining `SubBytes`, `ShiftRows`, and `MixColumns`. - The array index used was: `index = state[i] ^ key[i]`. 2. **The Cache-Timing Attack (D.J. Bernstein 2005):** - When the CPU accesses `T_Table[index]`, that memory line is loaded into the CPU L1/L2 cache. - An attacker running a process on the same multi-core CPU primes the cache and measures how many nanoseconds AES takes to encrypt a block. - If a cache line hit occurs, it takes $1\\text{ns}$; if a cache miss occurs, it takes $10\\text{ns}$. - By collecting timing histograms over thousands of encryptions, the attacker mathematically extracts the exact indices accessed, completely recovering the 128-bit AES private key without breaking AES math! 3. **The Solution (AES-NI & Constant Time):** - Modern CPUs (Intel AES-NI, AMD, Apple M-series) built dedicated AES hardware circuits (`AESENC`, `AESENCLAST`). - These instructions run in exactly constant clock cycles (e.g. 4 cycles) with **zero memory lookups**, making cache-timing attacks physically impossible." },
        { "text": "Because software lookup tables run out of RAM when encrypting large videos", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because C++ compilers refuse to compile arrays larger than 100 bytes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because software S-Boxes can only encrypt odd numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The cryptographic property where changing a single plaintext bit flips approximately 50% of output ciphertext bits is the ___ effect.",
      "blankAnswer": "avalanche",
      "blankDistractors": ["diffusion", "confusion", "cascade"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 1-Bit Mutation Avalanche Effect Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>AES Avalanche Effect & Hamming Distance</h3><p>Plaintext: <span style=\"font-family:monospace; color:#38bdf8;\">00000000000000000000000000000000</span></p><button id=\"btnFlip\" style=\"padding:8px 16px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">Flip 1 Single Bit (Bit #0) & Re-Encrypt</button><div id=\"avaLog\" style=\"margin-top:12px; border:1px solid #475569; padding:12px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click above to demonstrate the Avalanche Effect...</div><script>document.getElementById('btnFlip').onclick=()=>{document.getElementById('avaLog').innerHTML='<b>1-BIT MUTATION ENCRYPTED (AES-128):</b><br>• Ciphertext 1: <b>66e94bd4ef8a2c3b884cfa59ca342b2e</b><br>• Ciphertext 2: <b>a784d2f0991823bc4f1a2380d998a14c</b><br><br>📊 <b>HAMMING DISTANCE ANALYSIS:</b><br>• Total Bits: 128<br>• Bits Flipped: <b style=\"color:#38bdf8;\">63 / 128 (49.2%)</b><br>✨ Perfect Strict Avalanche Criterion (SAC ~= 50%)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
