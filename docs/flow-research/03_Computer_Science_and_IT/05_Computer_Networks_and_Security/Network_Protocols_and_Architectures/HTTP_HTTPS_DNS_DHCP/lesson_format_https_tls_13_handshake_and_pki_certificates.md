# Duofy Reusable Lesson Format: HTTPS, TLS 1.3 Handshake, and PKI Certificates

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / HTTP_HTTPS_DNS_DHCP`  
**Lesson Format Type:** `https_tls_13_handshake_and_pki_certificates`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the cryptographic handshakes, key exchange mechanisms, and trust validation pipelines of Transport Layer Security (TLS 1.3) and Public Key Infrastructure (PKI) (Eric Rescorla RFC 8446 TLS 1.3; ITU-T X.509; Kurose & Ross Chapter 8; Ilya Grigorik *High Performance Browser Networking* Chapter 4): master the **1-RTT TLS 1.3 Handshake Pipeline** (Client sends `ClientHello` with supported AEAD ciphers and ephemeral **ECDHE KeyShare**; Server responds with `ServerHello` [ECDHE KeyShare], `EncryptedExtensions`, `Certificate`, and `Finished` MAC; derives symmetric session key via HKDF), decode **Perfect Forward Secrecy (PFS)**, master **X.509 PKI Digital Certificate Validation** (chain of trust from Root CA $\to$ Intermediate CA $\to$ Leaf Server Certificate verified via asymmetric RSA/ECDSA digital signatures, Subject Alternative Names SAN, and OCSP stapling), and contrast TLS 1.3 with older 2-RTT TLS 1.2 handshakes.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TLS 1.3 1-RTT Handshake Architecture, ECDHE KeyShare, & X.509 PKI Trust Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of the 1-RTT TLS 1.3 Cryptographic Handshake Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | TLS 1.3 Cryptographic Component / PKI Entity & Security Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Cryptographic Property Guaranteeing That Compromise of a Server's Long-Term Private Key Cannot Decrypt Past Recorded Sessions (Perfect Forward Secrecy) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why TLS 1.3 Dropped RSA Static Key Exchange in Favor of Ephemeral Diffie-Hellman (ECDHE) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TLS 1.3 & PKI (RFC 8446; Grigorik Chapter 4):
   - **The 1-RTT TLS 1.3 Handshake:**
     $$\begin{array}{rcccl}
     \textbf{Client} & \xrightarrow{\mathbf{\text{ClientHello} \ [\text{AEAD Ciphers, Ephemeral KeyShare } g^a]}} & \textbf{Server} \\
     \textbf{Client} & \xleftarrow{\mathbf{\text{ServerHello} \ [\text{KeyShare } g^b] \ + \ \text{Encrypted [Cert, Verify, Finished]}}} & \textbf{Server} \\
     \textbf{Client} & \xrightarrow{\mathbf{\text{Finished} \ + \ \text{Encrypted Application Data (HTTP Request!)}}} & \textbf{Server} \\
     \end{array}$$
   - **X.509 PKI Certificate Hierarchy:**
     $$\mathbf{\text{Root CA (Self-Signed, in OS Trust Store)} \xrightarrow{\text{Signs}} \text{Intermediate CA} \xrightarrow{\text{Signs}} \text{Leaf Server Certificate}}$$
   - **Core Cryptographic Guarantees:**
     - **Confidentiality:** AEAD Symmetric Ciphers (AES-128-GCM, ChaCha20-Poly1305).
     - **Integrity:** HMAC / Poly1305 MAC authentication.
     - **Authenticity:** Digital signature verification of server certificate chain.
     - **Perfect Forward Secrecy (PFS):** Ephemeral ECDHE keys generated per session.
2. **Slide 2 (`ordering`):** Provide 5 steps of the TLS 1.3 handshake: (1) client sends ClientHello with supported ciphers and its ephemeral Diffie-Hellman public KeyShare (g^a), (2) server receives KeyShare, generates its own ephemeral KeyShare (g^b), selects cipher (e.g. AES-256-GCM), and derives master secret via HKDF, (3) server sends ServerHello (g^b) followed by encrypted certificate chain and signature verification, (4) client receives ServerHello, computes shared secret (g^(ab)), verifies CA certificate signature, and validates server identity, (5) client sends Finished MAC and begins transmitting encrypted HTTP application data within 1 single RTT!
3. **Slide 3 (`matching`):** Pair 4 security concepts (Ephemeral ECDHE, Certificate Authority CA, AEAD Symmetric Cipher, OCSP Stapling) with their roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Perfect Forward Secrecy. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why TLS 1.3 banned RSA key exchange: Why did the IETF in RFC 8446 (TLS 1.3) completely eliminate static RSA key exchange (which was widely used in TLS 1.0–1.2) and mandate Ephemeral Diffie-Hellman (ECDHE) for all connections? (Under static RSA key exchange, the client encrypted the premaster secret using the server's public key; if an adversary recorded encrypted internet traffic and stole the server's long-term RSA private key 5 years later, **the adversary could retroactively decrypt all historical recorded conversations**; **ECDHE generates temporary, disposable cryptographic keys for every single connection, guaranteeing Perfect Forward Secrecy (PFS) so that stealing the server's private key cannot decrypt past traffic**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "https_tls_13_handshake_and_pki_certificates",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: TLS 1.3 Handshake & PKI (RFC 8446)**\n• **1-RTT Cryptographic Handshake Pipeline (Grigorik Chapter 4):**\n$$\n\\begin{array}{rcccl}\n\\textbf{Client} & \\xrightarrow{\\mathbf{\\text{ClientHello } [\\text{AEAD Ciphers, Ephemeral KeyShare } g^a]}} & \\textbf{Server} \\\\\n\\textbf{Client} & \\xleftarrow{\\mathbf{\\text{ServerHello } [\\text{KeyShare } g^b] \\ + \\ \\text{Encrypted [Cert, Signature, Finished]}}} & \\textbf{Server} \\\\\n\\textbf{Client} & \\xrightarrow{\\mathbf{\\text{Finished} \\ + \\ \\text{Encrypted Application Data (HTTP Request!)}}} & \\textbf{Server} \\\\\n\\end{array}\n$$\n• **The X.509 PKI Trust Chain:**\n$$\n\\mathbf{\\text{Root CA (Pre-installed in OS)} \\ \\longrightarrow \\ \\text{Intermediate CA} \\ \\longrightarrow \\ \\text{Leaf Server Certificate}}\n$$\n• **Perfect Forward Secrecy (PFS):** Ephemeral ECDHE keys generated per session guarantee that compromising the server's private key in the future **cannot decrypt past recorded sessions**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the 1-RTT TLS 1.3 cryptographic handshake from initial hello to encrypted application transport.",
      "orderItems": [
        "Client sends ClientHello advertising supported AEAD ciphers and attaches an ephemeral ECDHE KeyShare (g^a)",
        "Server generates ephemeral ECDHE KeyShare (g^b), derives shared symmetric session keys via HKDF, and sends ServerHello (g^b)",
        "Server transmits EncryptedExtensions, its X.509 digital certificate chain, and a cryptographic signature over the handshake transcript",
        "Client receives ServerHello, calculates shared secret g^(ab), validates the X.509 CA certificate trust chain, and verifies the server signature",
        "Client sends encrypted Finished MAC verify message and immediately begins streaming encrypted HTTP application payload data"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each TLS 1.3 / PKI Cryptographic Component to its exact Security Function.",
      "matchPairs": [
        { "left": "Ephemeral ECDHE KeyShare", "right": "Generates temporary session keys per connection to provide mathematically unbreakable Perfect Forward Secrecy" },
        { "left": "Certificate Authority (CA)", "right": "Trusted third-party entity that cryptographically signs server certificates to verify domain ownership" },
        { "left": "AEAD Symmetric Cipher (AES-GCM)", "right": "High-speed symmetric encryption algorithm providing simultaneous data confidentiality and integrity authentication" },
        { "left": "OCSP Stapling", "right": "Server attaches a time-stamped CA revocation status to the TLS handshake to avoid client-side DNS lookup delays" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The cryptographic property ensuring that future compromise of a server private key cannot decrypt past recorded sessions is Perfect ___ Secrecy.",
      "blankAnswer": "Forward",
      "blankDistractors": ["Backward", "Session", "Zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did the Internet Engineering Task Force (IETF) in RFC 8446 (TLS 1.3) completely eliminate static RSA key exchange (which was widely used in TLS 1.0, 1.1, and 1.2) and mandate Ephemeral Diffie-Hellman (ECDHE) for all connections?",
      "options": [
        { "text": "Under static RSA key exchange, the client encrypted the session pre-master secret using the server's static public key; if an intelligence agency or attacker recorded encrypted network traffic and subsequently stole or subpoenaed the server's long-term RSA private key years later, they could retroactively decrypt all historical recorded conversations; Ephemeral Diffie-Hellman (ECDHE) generates disposable, temporary cryptographic keys for every individual connection that are immediately destroyed after session termination, guaranteeing Perfect Forward Secrecy (PFS)", "isCorrect": true, "explanation": "Correct! This was the primary security motive for the entire TLS 1.3 redesign (Eric Rescorla RFC 8446; Ilya Grigorik Chapter 4). 1. **How Static RSA Key Exchange Worked (The Flaw):** - Client generated a random session key, encrypted it with the Server's Public RSA key, and sent it over the wire. - Server decrypted it with its Private RSA key. - Both used that key for AES encryption. 2. **The 'Record Now, Decrypt Later' Threat:** - An attacker records all encrypted traffic traveling through an ISP or undersea cable for 5 years. - If the server is hacked, decommissioned improperly, or compelled by a court to surrender its private key in 2030, the attacker can use that ONE single private key to **retroactively decrypt all 5 years of recorded private conversations**! 3. **The Ephemeral Diffie-Hellman Solution (TLS 1.3):** - Every single connection generates random, ephemeral Diffie-Hellman keypairs ($g^a$ and $g^b$). - Once the session ends, $a$ and $b$ are wiped from memory. - Even if an attacker steals the server's long-term certificate private key, they CANNOT mathematically calculate $g^{ab}$ from recorded traffic! Past sessions remain cryptographically secure forever (Perfect Forward Secrecy)." },
        { "text": "Because RSA encryption is patent-protected and illegal on the internet", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because RSA keys cannot be transmitted over Wi-Fi networks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because TLS 1.3 only runs on Linux servers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
