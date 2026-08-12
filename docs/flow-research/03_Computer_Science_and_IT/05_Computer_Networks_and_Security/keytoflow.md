# Key to Flow: Computer Networks and Security

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security`

---

## 📌 Core Concept & Mental Model
Computer Networks enable communication between distributed computing systems via protocol stacks (OSI 7-Layer / TCP/IP 4-Layer models), while Network Security protects data confidentiality, integrity, and availability.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Protocol Stack Architecture
* **Application Layer (HTTP, HTTPS, DNS, SMTP, SSH):** Request-Response cycles, TLS handshake.
* **Transport Layer (TCP vs UDP):**
  * **TCP:** Connection-oriented, 3-way handshake (`SYN`, `SYN-ACK`, `ACK`), Flow Control (Sliding Window), Congestion Control (Slow Start, Congestion Avoidance, Fast Retransmit).
  * **UDP:** Connectionless, low latency, unreliable datagrams.
* **Network Layer (IP, ICMP, BGP, OSPF):** IPv4/IPv6 Addressing, Subnetting (CIDR), Routing algorithms (Distance Vector vs Link State).
* **Data Link Layer (Ethernet, Wi-Fi):** MAC addresses, Framing, CSMA/CD, Switches, ARP.

### 2. Cryptography & Defensive Security
* **Symmetric Encryption:** AES, DES (Fast, shared secret key).
* **Asymmetric Encryption:** RSA, ECC (Public/Private key pair).
* **Cryptographic Hashes & Signatures:** SHA-256, HMAC, Digital Certificates (PKI, X.509).

### 3. Top Recommended Resources
* **Networking Top-Down Classic:** *Computer Networking: A Top-Down Approach* by Kurose & Ross.
* **Network Systems Classic:** *Computer Networks* by Andrew S. Tanenbaum.
* **Cryptography Standard:** *Cryptography and Network Security* by William Stallings.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you perform Subnetting calculations (CIDR notation `/24`, Network ID, Broadcast ID, Host range)?
- [ ] Can you trace a complete web request from DNS lookup to TCP handshake and HTTP response?
- [ ] Can you execute RSA encryption/decryption mathematically ($c = m^e \bmod n$)?
- [ ] Can you explain Diffie-Hellman Key Exchange?
