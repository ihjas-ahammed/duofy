# Key to Flow: Application Layer Protocols (HTTP Evolution, TLS 1.3, DNS, and DHCP DORA)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / HTTP_HTTPS_DNS_DHCP`

---

## 📌 Core Concept & Mental Model
**Binary Stream Multiplexing & QUIC Transport, Ephemeral Cryptographic Key Agreement (TLS 1.3 ECDHE), Hierarchical Distributed Name Tree Resolution (DNS), and Automated Dynamic Bootstrap Addressing (DHCP DORA)** govern application-layer internet communications (Tim Berners-Lee HTTP; RFC 9112 HTTP/1.1; RFC 9113 HTTP/2; RFC 9114 HTTP/3 QUIC; Eric Rescorla RFC 8446 TLS 1.3; Paul Mockapetris RFC 1034/1035 DNS; Ralph Droms RFC 2131 DHCP; Kurose & Ross Chapter 2; Ilya Grigorik *High Performance Browser Networking*):
* **1. HTTP Protocol Evolution (1.1 $\to$ 2 $\to$ 3):**
  - **HTTP/1.1 (RFC 9112):** Plaintext ASCII. Persistent TCP connections (`Keep-Alive`), but suffers from **Application-Level Head-of-Line (HoL) Blocking** (one slow request delays all queued responses on that connection).
  - **HTTP/2 (RFC 9113):** **Binary Framing Layer**. Single TCP connection multiplexing multiple bidirectional independent streams ($Stream \to Message \to Frame$). **HPACK Header Compression** and Server Push. *Limitation:* Still suffers from **TCP-Level HoL Blocking** on packet loss!
  - **HTTP/3 (RFC 9114 - QUIC over UDP):** Replaces TCP with **QUIC**. Solves TCP HoL blocking completely (loss on one stream does not pause other streams!). Features **0-RTT connection resumption** and connection migration across IP changes (e.g. Wi-Fi to 5G).
* **2. HTTPS & The Modern TLS 1.3 Handshake (RFC 8446):**
  - Encrypts HTTP over Transport Layer Security.
  - **The 1-RTT TLS 1.3 Handshake:**
    $$\mathbf{\text{Client} \xrightarrow{\mathbf{\text{ClientHello (Supported Ciphers + Ephemeral ECDHE KeyShare)}}} \text{Server}}$$
    $$\mathbf{\text{Server} \xrightarrow{\mathbf{\text{ServerHello (ECDHE KeyShare) + Encrypted Extensions + Cert + Finished}}} \text{Client}}$$
  - **Security Invariants:**
    - **PFS (Perfect Forward Secrecy):** Enforced by mandatory ephemeral Diffie-Hellman (ECDHE); compromise of server private key cannot decrypt past recorded sessions!
    - **PKI & X.509 Certificates:** Browser validates server certificate chain signed by trusted Certificate Authorities (CAs).
* **3. Domain Name System (DNS - RFC 1034/1035):**
  - Hierarchical distributed database mapping human domain names to IP addresses:
    $$\mathbf{\text{Root Servers ('.')} \ \longrightarrow \ \text{TLD Servers ('.com', '.org')} \ \longrightarrow \ \text{Authoritative Nameservers ('example.com')}}$$
  - **Resolution Models:**
    - **Recursive Query:** Client asks Local Resolver (e.g. `8.8.8.8`); resolver does all the legwork and returns the final IP.
    - **Iterative Query:** Resolver queries Root $\to$ TLD $\to$ Authoritative step-by-step using referral pointers.
  - **Core Resource Records (RR):**
    - `A` (IPv4 address), `AAAA` (IPv6 address), `CNAME` (Canonical alias), `MX` (Mail server), `NS` (Nameserver delegation), `TXT` (SPF/DKIM verification), `PTR` (Reverse IP-to-Domain lookup).
* **4. Dynamic Host Configuration Protocol (DHCP - RFC 2131):**
  - Automated 4-Step Bootstrap Lease Allocation: **DORA**:
    1. **D - Discover:** Client broadcasts `DHCPDISCOVER` on Layer 2 (`FF:FF:FF:FF:FF:FF`) and Layer 3 (`255.255.255.255:67`).
    2. **O - Offer:** DHCP Server responds with `DHCPOFFER` (proposing client IP, subnet mask, default gateway, DNS servers, lease time).
    3. **R - Request:** Client broadcasts `DHCPREQUEST` accepting the offer.
    4. **A - Acknowledge:** Server unicasts/broadcasts `DHCPACK`, finalizing the lease.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Internet Boot & Web Fetch Pipeline
* Power on PC $\to$ DHCP DORA (Get IP, Gateway, DNS).
* Type URL $\to$ DNS Resolution (Root $\to$ TLD $\to$ Auth $\to$ IP).
* Connect $\to$ TLS 1.3 1-RTT Handshake (ECDHE + Cert).
* Fetch $\to$ HTTP/2 Multiplexed Binary Streams / HTTP/3 QUIC.

### 2. Top Recommended Resources
* **The Web Performance Bible:** *High Performance Browser Networking* (Ilya Grigorik, O'Reilly).
* **Definitive Textbook:** *Computer Networking: A Top-Down Approach* (Kurose & Ross), Chapter 2 (Application Layer).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you contrast HTTP/1.1, HTTP/2 binary framing, and HTTP/3 QUIC transport?
- [ ] Can you trace the 1-RTT TLS 1.3 handshake and explain Perfect Forward Secrecy?
- [ ] Can you differentiate Recursive vs Iterative DNS lookups and distinguish A, CNAME, and MX records?
- [ ] Can you trace the 4 DHCP DORA packets (Discover $\to$ Offer $\to$ Request $\to$ Acknowledge)?
