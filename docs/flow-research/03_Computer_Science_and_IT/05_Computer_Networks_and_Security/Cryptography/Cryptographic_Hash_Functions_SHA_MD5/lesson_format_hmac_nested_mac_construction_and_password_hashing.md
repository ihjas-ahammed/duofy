# Duofy Reusable Lesson Format: HMAC Nested MAC Construction and Password Hashing

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Cryptographic_Hash_Functions_SHA_MD5`  
**Lesson Format Type:** `hmac_nested_mac_construction_and_password_hashing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify keyed message authentication codes, padding constants, and specialized memory-hard password derivation functions (Mihir Bellare, Ran Canetti, Hugo Krawczyk 1996 RFC 2104 HMAC; Alex Biryukov, Daniel Dinu, Dmitry Khovratovich 2015 Argon2, Password Hashing Competition Winner; Katz & Lindell *Introduction to Modern Cryptography* Chapter 5.4; Serious Cryptography Chapters 7 & 15): master the **HMAC Nested Dual-Hash Construction Formula** ($\mathbf{\text{HMAC}(K, M) = H\Big((K \oplus \text{opad}) \ \Big|\Big| \ H\big((K \oplus \text{ipad}) \ \Big|\Big| \ M\big)\Big)}$ where $\text{ipad} = \text{0x3636\dots36}$ and $\text{opad} = \text{0x5C5C\dots5C}$), analyze how this sandwich construction mathematically immunizes Merkle-Damgård hashes against length extension, distinguish **Fast Cryptographic Hashes (SHA-256 - insecure for passwords)** from **Slow Memory-Hard Password Derivation Functions (PBKDF2, bcrypt, scrypt, Argon2id with work/memory factors)**, and interact with live HMAC computation and password hashing simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | HMAC RFC 2104 Nested Formula, ipad/opad Hamming Distance, & Argon2 Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | HMAC Construct / Password Hash Algorithm & Cryptographic Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Fast Hashes (SHA-256) Are Dangerous for Storing Passwords Compared to Argon2id Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Winner of the Password Hashing Competition Featuring Memory-Hardness is ___ (Argon2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive HMAC-SHA256 Nested Keyed-Hashing Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hmac_nested_mac_construction_and_password_hashing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the HMAC nested construction formula, and why are memory-hard functions (Argon2) required for passwords?",
      "blankAnswer": "HMAC & Password Hashing (RFC 2104; Katz & Lindell Chapter 5.4): (1) HMAC NESTED FORMULA: HMAC(K, M) = H((K XOR opad) || H((K XOR ipad) || M)). Constants: ipad = 0x36 repeated to block size B; opad = 0x5C repeated to block size B. (2) WHY NESTED: The inner hash H(K_in || M) digests the message; the outer hash H(K_out || inner_hash) digests the fixed-length output, mathematically eliminating Length Extension Attacks! (3) FAST HASHES VS PASSWORD HASHES: General hashes (SHA-256, BLAKE3) are designed to be blazingly fast in hardware (billions of hashes/sec on GPUs, making offline password dictionary/brute-force attacks trivial!). (4) MEMORY-HARD PASSWORD FUNCTIONS: Specialized functions that are intentionally SLOW and MEMORY-INTENSIVE: (i) PBKDF2: Iteration count (CPU-bound). (ii) bcrypt: Blowfish-based key schedule. (iii) Argon2id (PHC Winner): Fills megabytes of RAM per hash, thwarting GPU/ASIC parallel cracking!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Keyed Authentication / Password Hashing Function to its exact Technical Mechanism.",
      "matchPairs": [
        { "left": "HMAC (RFC 2104)", "right": "Nested dual-hash MAC using inner and outer key pads (ipad/opad) to authenticate message integrity" },
        { "left": "Argon2id Algorithm", "right": "State-of-the-art password hashing function combining memory-hardness and side-channel resistance" },
        { "left": "Salt Value", "right": "Unique cryptographically random string appended to passwords before hashing to defeat precomputed Rainbow Tables" },
        { "left": "Work Factor / Cost", "right": "Configurable computational iteration and memory allocation parameters tuned to increase brute-force defense" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is storing user passwords as raw SHA-256(password + salt) considered a dangerous security vulnerability in modern systems compared to using Argon2id or bcrypt?",
      "options": [
        { "text": "SHA-256 was engineered to be ultra-fast in hardware for high-throughput stream integrity; a modern consumer GPU cluster can calculate over 100 billion SHA-256 hashes per second, allowing an attacker who steals a database to brute-force billions of candidate salted passwords in minutes; Argon2id is intentionally slow and memory-hard, requiring gigabytes of RAM and heavy CPU cycles per single verification, rendering massively parallel GPU and custom ASIC cracking hardware economically and computationally infeasible", "isCorrect": true, "explanation": "Correct! This is one of the most vital software security design principles (Password Hashing Competition 2015; Serious Cryptography Chapter 15). 1. **The Purpose of General Hash Functions:** - Hash functions like SHA-256, MD5, and SHA-3 are designed to verify multi-gigabyte disk files and high-throughput network packets. - Speed is a feature! Modern CPUs execute SHA-256 in dedicated hardware instructions, and mining GPUs compute **tens of billions of SHA-256 hashes every second**. 2. **Why Speed Destroys Passwords:** - If an attacker breaches a web database and steals salted SHA-256 password hashes: - An 8-character password from an English dictionary can be cracked on a single GPU in a fraction of a second. 3. **The Password Hashing Paradigm (Argon2id & bcrypt):** - Passwords are verified by humans logging in (where a 100ms verification delay is completely unnoticeable). - **Argon2id** forces the computer to allocate, write, and shuffle **64MB of RAM** in a complex memory graph for every single password hash! - Because GPUs and ASICs have tiny per-core cache memory, running 1,000 parallel Argon2id cracks on a GPU exhausts memory bandwidth instantly, slowing attacks down by a factor of over $1,000,000\\times$." },
        { "text": "Because SHA-256 is an insecure cipher created by the Russian government", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SHA-256 cannot hash strings containing special characters like # and $", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because salts do not work with SHA-256", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The memory-hard password hashing standard that won the Password Hashing Competition in 2015 is ___.",
      "blankAnswer": "Argon2",
      "blankDistractors": ["MD5", "DES", "SHA1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive HMAC-SHA256 Nested Construction Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>HMAC-SHA256 Nested Engine</h3><p>Key: <b style=\"color:#38bdf8;\">\"secretKey\"</b> | Msg: <b style=\"color:#38bdf8;\">\"Transfer $500\"</b></p><button id=\"btnHmac\" style=\"padding:8px 16px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">Compute Nested HMAC (ipad + opad)</button><div id=\"hmacLog\" style=\"margin-top:12px; border:1px solid #475569; padding:12px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click above to trace RFC 2104 nested hashing...</div><script>document.getElementById('btnHmac').onclick=()=>{document.getElementById('hmacLog').innerHTML='<b>RFC 2104 HMAC PIPELINE:</b><br>1. K_in = Key XOR ipad (0x3636...)<br>2. Inner_Hash = SHA256(K_in || \"Transfer $500\")<br>&nbsp;&nbsp;&rarr; <b>a19f88c2... (32 Bytes)</b><br>3. K_out = Key XOR opad (0x5C5C...)<br>4. Final HMAC = SHA256(K_out || Inner_Hash)<br>&nbsp;&nbsp;&rarr; <b style=\"color:#10b981;\">5a6e2b4f91c8... (Valid HMAC!)</b><br>🛡️ 100% immune to Length Extension Attacks!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
