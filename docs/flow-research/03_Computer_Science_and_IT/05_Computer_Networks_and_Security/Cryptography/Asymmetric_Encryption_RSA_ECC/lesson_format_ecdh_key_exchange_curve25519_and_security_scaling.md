# Duofy Reusable Lesson Format: ECDH Key Exchange, Curve25519, and Security Scaling

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cryptography / Asymmetric_Encryption_RSA_ECC`  
**Lesson Format Type:** `ecdh_key_exchange_curve25519_and_security_scaling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify key exchange protocols, Montgomery curve architectures, and cross-party secret derivation across Elliptic Curve Diffie-Hellman (ECDH / ECDHE) and modern high-performance curves (Daniel J. Bernstein 2006, *Curve25519: new Diffie-Hellman speed records*; RFC 7748; Katz & Lindell Chapter 10.5; Serious Cryptography Chapter 12): master the **ECDH Ephemeral Key Agreement Protocol** (Alice with private scalar $d_A$ sends public point $Q_A = d_A G$; Bob with private scalar $d_B$ sends public point $Q_B = d_B G$; both compute shared secret point $\mathbf{K = d_A Q_B = d_A (d_B G) = d_B (d_A G) = d_B Q_A}$), master **Curve25519 Montgomery Form** ($\mathbf{y^2 = x^3 + 486662x^2 + x \pmod{2^{255}-19}}$ using Montgomery ladder in constant time with only x-coordinates, immune to timing side-channels), contrast **ECDHE vs Static RSA Key Exchange** in TLS 1.3, and interact with live ECDH key agreement and shared secret derivation simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ECDH Key Agreement Mathematics, Curve25519 Montgomery Form, & Security Table Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Cryptographic Protocol / Curve Construct & Performance Advantage Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Tracing Shared Secret Derivation Between Alice and Bob in an ECDH Exchange Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the State-of-the-Art 256-Bit Montgomery Curve Designed by Daniel J. Bernstein (Curve25519) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Elliptic Curve Diffie-Hellman (ECDH) Key Exchange Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ecdh_key_exchange_curve25519_and_security_scaling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the ECDH key exchange protocol, how does shared secret derivation work, and why is Curve25519 superior?",
      "blankAnswer": "ECDH Key Agreement & Curve25519 (RFC 7748; Bernstein 2006): (1) THE ECDH PROTOCOL: (a) Public generator point G on elliptic curve E(F_p). (b) Alice selects private scalar d_A in [1, n-1] and sends public point Q_A = d_A * G. (c) Bob selects private scalar d_B in [1, n-1] and sends public point Q_B = d_B * G. (d) Alice computes: K = d_A * Q_B = d_A * (d_B * G). (e) Bob computes: K = d_B * Q_A = d_B * (d_A * G). Both derive the IDENTICAL shared secret point K! An eavesdropper sees only Q_A and Q_B and cannot compute K without solving the ECDLP! (2) CURVE25519 (Daniel J. Bernstein 2006): Montgomery curve y^2 = x^3 + 486662x^2 + x over prime field 2^255 - 19. Advantages: (i) Uses Montgomery ladder requiring ONLY x-coordinates (32-byte keys/points). (ii) Complete addition formulas with zero branch conditions (100% immune to cache-timing attacks!). (iii) 128-bit security level operating at blazing CPU speeds in TLS 1.3, WireGuard, and SSH."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Key Exchange / Curve Protocol to its exact Technical Feature.",
      "matchPairs": [
        { "left": "ECDH Key Agreement", "right": "Protocol allowing two parties to derive a shared symmetric secret over an untrusted channel using point multiplication" },
        { "left": "Curve25519", "right": "High-speed Montgomery curve over field 2^255 - 19 engineered for constant-time side-channel immunity" },
        { "left": "Montgomery Ladder", "right": "Algorithm computing scalar point multiplication using only x-coordinates with fixed sequence of operations" },
        { "left": "Ephemeral ECDHE", "right": "Session-specific ECDH keypair generation guaranteeing Perfect Forward Secrecy in TLS 1.3" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Alice and Bob execute an Elliptic Curve Diffie-Hellman (ECDH) key exchange over an elliptic curve with public generator point G. Alice chooses private key d_A = 7 and transmits public point Q_A = 7G. Bob chooses private key d_B = 11 and transmits public point Q_B = 11G. What shared secret point K is independently computed by both Alice and Bob, and why can an eavesdropper Eve not compute K?",
      "options": [
        { "text": "Alice computes K = d_A * Q_B = 7 * (11G) = 77G; Bob computes K = d_B * Q_A = 11 * (7G) = 77G; both derive the identical shared secret point 77G; Eve intercepts only public points Q_A = 7G and Q_B = 11G and cannot compute 77G without solving the Elliptic Curve Computational Diffie-Hellman (CDH) / ECDLP problem", "isCorrect": true, "explanation": "Correct! This is the standard algebraic formulation of the Elliptic Curve Diffie-Hellman protocol (RFC 7748; Katz & Lindell Section 10.5). 1. **Alice's Computation:** - Alice receives Bob's public point $Q_B = 11G$. - Alice multiplies $Q_B$ by her own secret scalar $d_A = 7$: $K = d_A \\cdot Q_B = 7 \\cdot (11G) = \\mathbf{77G}$. 2. **Bob's Computation:** - Bob receives Alice's public point $Q_A = 7G$. - Bob multiplies $Q_A$ by his own secret scalar $d_B = 11$: $K = d_B \\cdot Q_A = 11 \\cdot (7G) = \\mathbf{77G}$. 3. **The Shared Secret:** - Because scalar point multiplication is associative and commutative over the abelian group: $7 \\cdot (11G) = 11 \\cdot (7G) = (7 \\times 11) \\cdot G = \\mathbf{77G}$. - Both parties feed the x-coordinate of $77G$ into a Key Derivation Function (HKDF) to establish identical AES-256 session keys! 4. **Eve's Barrier (The CDH Assumption):** - Eve observes $G$, $7G$, and $11G$ on the wire. - To calculate $77G$, Eve must either find $7$ from $7G$ (solving the ECDLP) or compute the Diffie-Hellman group product directly, both of which are mathematically intractable." },
        { "text": "Alice computes K = 7 + 11 = 18; Bob computes K = 7 * 11 = 77", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Alice computes K = 7G; Bob computes K = 11G", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Eve can compute K immediately by multiplying (7G * 11G) = 77G^2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The high-performance Montgomery elliptic curve designed by Daniel J. Bernstein over prime 2^255 - 19 is Curve___.",
      "blankAnswer": "25519",
      "blankDistractors": ["256", "384", "521"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive ECDH Key Agreement & Secret Derivation Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>ECDH Key Agreement Engine</h3><p>Public Base Generator: <b style=\"color:#38bdf8;\">Point G</b> on Curve25519</p><div style=\"display:flex; gap:6px;\"><button id=\"btnGenA\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Alice: d_A = 7 &rarr; Q_A = 7G</button><button id=\"btnGenB\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Bob: d_B = 11 &rarr; Q_B = 11G</button><button id=\"btnDer\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Derive Shared Secret</button></div><div id=\"ecdhLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to start ECDH exchange...</div><script>document.getElementById('btnGenA').onclick=()=>{document.getElementById('ecdhLog').innerHTML='<b>ALICE KEYPAIR GENERATED:</b><br>• Secret Scalar: <b>d_A = 7</b><br>• Public Point Sent: <b>Q_A = 7G</b>';}; document.getElementById('btnGenB').onclick=()=>{document.getElementById('ecdhLog').innerHTML='<b>BOB KEYPAIR GENERATED:</b><br>• Secret Scalar: <b>d_B = 11</b><br>• Public Point Sent: <b>Q_B = 11G</b>';}; document.getElementById('btnDer').onclick=()=>{document.getElementById('ecdhLog').innerHTML='<b>SHARED SECRET COMPUTED:</b><br>• Alice: K = 7 &times; (11G) = <b style=\"color:#10b981;\">77G</b><br>• Bob: K = 11 &times; (7G) = <b style=\"color:#10b981;\">77G</b><br>🔒 Symmetric AES-256 Key derived via HKDF(77G.x)!<br>• Eve sees only 7G and 11G (ECDLP Intractable).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
