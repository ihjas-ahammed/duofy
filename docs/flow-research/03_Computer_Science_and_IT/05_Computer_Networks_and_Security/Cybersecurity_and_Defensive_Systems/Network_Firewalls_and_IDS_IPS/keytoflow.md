# Key to Flow: Network Firewalls and IDS/IPS (Stateful SPI, Snort Signatures, IPS, & Zero Trust)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Network_Firewalls_and_IDS_IPS`

---

## 📌 Core Concept & Mental Model
**Packet Filtering Access Control Lists (ACLs), Connection Tracking (`conntrack`) Stateful Packet Inspection (SPI), Layer 7 Next-Generation Firewalls (NGFW / DPI), Signature vs Anomaly-Based Detection (Snort/Suricata), Inline Prevention (IPS Drop/RST) vs Passive Taps (IDS), and Zero Trust Perimeter Demilitarization (DMZ)** govern network perimeter defense and intrusion monitoring (Marcus Ranum 1990 Stateful Filtering; Martin Roesch 1998 Snort; NIST SP 800-41 Firewalls; NIST SP 800-94 IDPS; NIST SP 800-207 Zero Trust; Kurose & Ross Chapter 8.9; William Stallings *Computer Security* Chapter 9):
* **1. Firewall Generations & Evolution:**
  - **1st Gen: Stateless Packet Filter (ACLs):**
    - Inspects each packet in isolation based on **Layer 3/4 5-tuple**: $(\text{Src IP}, \text{Dst IP}, \text{Src Port}, \text{Dst Port}, \text{Protocol})$.
    - *Flaw:* Cannot track dynamic connections; return traffic requires opening broad high-numbered ports ($1024-65535$).
  - **2nd Gen: Stateful Packet Inspection (SPI / `conntrack`):**
    - Tracks TCP/UDP connection state machines in a kernel **State Table (`conntrack`)**:
      - States: `NEW` (valid handshake initiator), `ESTABLISHED` (two-way traffic matched), `RELATED` (FTP data/ICMP error), `INVALID`.
    - Automatically allows legitimate return response packets with zero open hole vulnerabilities!
  - **3rd Gen: Next-Generation Firewall (NGFW / Deep Packet Inspection DPI):**
    - Inspects **Layer 7 Application Payloads** (App-ID, user identity, TLS decryption, malware scanning) regardless of port numbers (e.g. catches Tor tunneling over port 443).
* **2. Intrusion Detection (IDS) vs Intrusion Prevention (IPS):**
  - **IDS (Passive Tap / SPAN Mirror Port):**
    - Sits out-of-band on a mirrored network tap.
    - Inspects copies of traffic and generates **alerts/logs**. *Zero latency impact, but cannot block attacks in flight!*
  - **IPS (Active / Inline Deployment):**
    - Placed directly in the physical traffic path (inline).
    - Can **drop malicious packets**, inject **TCP `RST` resets**, or dynamically update firewall blocklists in real time!
* **3. Detection Methodologies:**
  - **Signature-Based (Snort / Suricata):**
    - Matches explicit byte patterns / regular expressions against known vulnerability signatures:
      `alert tcp $EXTERNAL_NET any -> $HOME_NET 80 (msg:"SQL Injection Attempt"; content:"UNION SELECT"; nocase; sid:1000001; rev:1;)`
    - High accuracy, near-zero false positives for known attacks; *blind to Zero-Day exploits*.
  - **Anomaly-Based (Heuristic / ML Baselines):**
    - Establishes statistical baselines of normal network behavior; flags deviations (traffic volume spikes, weird TCP flags).
    - Catches novel Zero-Days; *higher false-positive rate*.
* **4. Network Zoning: DMZ & Zero Trust Architecture (NIST SP 800-207):**
  - **DMZ (Demilitarized Zone):** Semi-trusted subnet hosting public-facing servers (Web, Mail, DNS) isolated between dual firewalls to protect the internal LAN if the web server is breached.
  - **Zero Trust Architecture (ZTA):** *"Never trust, always verify"*. Eliminates the concept of a trusted internal network perimeter; mandates microsegmentation, mutual TLS (mTLS), and continuous identity authorization for every single request.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Defensive Security Continuum
* Boundary Gatekeeper $\to$ Stateless ACL $\to$ Stateful SPI $\to$ NGFW DPI.
* Traffic Watchdog $\to$ Passive IDS (Alert) vs Inline IPS (Drop/RST).
* Detection Engine $\to$ Signature (Snort Byte Match) + Anomaly (Baseline Deviation).
* Topology Design $\to$ Perimeter DMZ $\to$ Microsegmented Zero Trust.

### 2. Top Recommended Resources
* **The NIST Standard:** *NIST SP 800-94: Guide to Intrusion Detection and Prevention Systems (IDPS)* (Karen Scarfone & Peter Mell).
* **Network Security Classic:** *Network Security: Private Communication in a Public World* (Charlie Kaufman, Radia Perlman, Mike Speciner).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you contrast Stateless ACLs, Stateful SPI state tables, and NGFW Deep Packet Inspection?
- [ ] Can you write and interpret a standard Snort/Suricata NIDS detection rule?
- [ ] Can you differentiate passive IDS tap deployment from inline IPS packet dropping?
- [ ] Can you diagram a DMZ perimeter architecture and explain the Zero Trust paradigm?
