# Duofy Reusable Lesson Format: Signature Rules (Snort/Suricata) and Anomaly Detection

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Network_Firewalls_and_IDS_IPS`  
**Lesson Format Type:** `signature_rules_snort_suricata_and_anomaly_detection`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the rule syntax grammar, pattern matching engines, and statistical behavioral heuristics of network intrusion detection engines (Martin Roesch 1998 Snort; Open Information Security Foundation OISF Suricata; NIST SP 800-94; William Stallings *Computer Security* Chapter 9.2): master the **Anatomy of a Snort/Suricata Rule** (**Rule Header: Action [`alert`, `drop`, `reject`], Protocol [`tcp`, `udp`, `icmp`, `http`], Source IP/Port $\to$ Destination IP/Port; Rule Options: `msg`, `flow`, `content`, `nocase`, `pcre`, `classtype`, `sid` [Snort ID > 1000000 for custom rules], and `rev`**), contrast **Signature-Based Detection** (deterministic byte-string matching, near-zero false positives for known CVEs, blind to novel zero-day attacks) with **Anomaly/Heuristic-Based Detection** (statistical/ML baselines of normal network traffic distributions, detects novel zero-days, prone to false positive alerts on benign network bursts), and evaluate rule optimization techniques (fast pattern matching via Aho-Corasick / Hyperscan).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Snort Rule Syntax Anatomy Diagram, Signature vs Anomaly Trade-Off Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction and Compilation of a Custom Snort Detection Rule Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Snort Rule Option / Detection Strategy & Technical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Snort Rule Option Used to Match a Case-Insensitive String Inside a Packet Payload (nocase) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Attackers Use Payload Encoding (Hex, Base64) to Evade Naive Signature Matching Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Snort Rule Grammar & Anomaly Detection (NIST SP 800-94; Roesch 1998):
   - **The Snort/Suricata Rule Structure:**
     $$\mathbf{\underbrace{\text{alert tcp \$EXTERNAL\_NET any -> \$HOME\_NET 80}}_{\textbf{Rule Header}} \ \ \underbrace{\text{(msg:"SQLi Attempt"; content:"UNION SELECT"; nocase; sid:1000001; rev:1;)}}_{\textbf{Rule Options}}}$$
   - **Core Rule Fields:**
     - **Action:** `alert` (notify), `drop` (IPS inline drop), `reject` (drop + TCP RST).
     - `content`: Exact byte sequence or ASCII text to find in payload.
     - `nocase`: Case-insensitive payload matching (`Union Select` matches `UNION SELECT`).
     - `flow: established, to_server`: Enforces TCP handshake reassembly.
     - `sid`: Unique Snort Identifier (Custom rules use $sid \ge 1,000,000$).
   - **Signature vs Anomaly Comparison:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Detection Paradigm} & \textbf{Zero-Day Detection} & \textbf{False Positive Rate} \\
     \hline
     \mathbf{\text{Signature-Based (Snort/Suricata)}} & \mathbf{\text{Zero (Requires published rule)}} & \mathbf{\text{Extremely Low (Deterministic)}} \\
     \mathbf{\text{Anomaly-Based (ML/Heuristics)}} & \mathbf{\text{High (Detects baseline deviations)}} & \mathbf{\text{Higher (Benign bursts flag alerts)}} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of writing and triggering a Snort rule for Log4Shell (`${jndi:ldap://`): (1) define rule header: alert tcp $EXTERNAL_NET any -> $HOME_NET any, (2) add msg and flow options: msg:"Exploit Attempt - Log4j RCE Detected"; flow:to_server,established;, (3) add pattern match options: content:"${jndi:"; nocase; fast_pattern;, (4) add classification and unique identifier metadata: classtype:attempted-admin; sid:1000042; rev:1;, (5) reload Snort engine with new rule; attacker sends exploit string; Snort triggers alert and logs packet to SIEM!
3. **Slide 3 (`matching`):** Pair 4 Snort options (content:"...", nocase, sid:1000001, Anomaly Detection) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the nocase option. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on signature evasion via encoding: An attacker attempts a SQL injection attack against a web server protected by a Snort NIDS configured with the rule `content:"UNION SELECT";`. Why does the attacker's payload `%55NION%20%53ELECT` (URL-encoded) bypass naive signature matching unless an HTTP preprocessor is enabled? (Because a raw pattern matcher evaluates the literal ASCII byte stream traversing the network wire; `%55` has ASCII bytes `0x25 0x35 0x35`, which does not match the byte pattern `UNION`; **an intelligent NIDS requires an HTTP Preprocessor / Normalization Engine to decode URL encoding, Base64, and Unicode before applying signature rules**, preventing trivial evasion).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "signature_rules_snort_suricata_and_anomaly_detection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: NIDS Signature Rules & Anomaly Detection (NIST SP 800-94)**\n• **Anatomy of a Snort/Suricata Detection Rule (Martin Roesch 1998):**\n$$\n\\mathbf{\\underbrace{\\text{alert tcp \\$EXTERNAL\\_NET any -> \\$HTTP\\_SERVERS 80}}_{\\textbf{Rule Header (Action, Proto, Addresses, Ports)}} \\quad \\underbrace{\\text{(msg:\"SQLi\"; content:\"UNION SELECT\"; nocase; sid:1000001; rev:1;)}}_{\\textbf{Rule Options (Payload Criteria \\& Metadata)}}}\n$$\n• **Signature vs Anomaly Detection Trade-Offs:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Detection Method} & \\textbf{Zero-Day Resilience} & \\textbf{Operational False Positives} \\\\\n\\hline\n\\mathbf{\\text{Signature-Based}} & \\mathbf{\\text{Blind to novel attacks (Requires CVE rule)}} & \\mathbf{\\text{Near-Zero (Deterministic byte match)}} \\\\\n\\mathbf{\\text{Anomaly-Based}} & \\mathbf{\\text{High (Detects baseline deviations)}} & \\mathbf{\\text{Moderate/High (Benign spikes flag alerts)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Fast-Pattern Rule:** Uses Aho-Corasick tree searching to scan thousands of rules at line rate!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to construct, deploy, and trigger a custom Snort NIDS detection rule for a remote exploit.",
      "orderItems": [
        "Define Rule Header specifying alert action, protocol (tcp), external source variable, and target internal subnet variable ($HOME_NET)",
        "Specify connection flow constraint (flow:to_server,established) to ensure TCP 3-way handshake is verified before parsing",
        "Add payload content pattern (content:\"${jndi:\"; nocase; fast_pattern;) to locate target exploit signature in packet payload",
        "Assign rule metadata including descriptive message (msg:\"Log4j RCE Attempt\"), attack class, unique SID (sid:1000042), and revision (rev:1)",
        "Reload Snort rule engine; test with mock exploit traffic and verify generated alerts in central SIEM monitoring logs"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Snort Rule Option / Detection Concept to its exact Technical Mechanism.",
      "matchPairs": [
        { "left": "content:\"string\"; Option", "right": "Specifies the precise byte sequence or ASCII text pattern that must be found in the packet payload" },
        { "left": "nocase Modifier", "right": "Instructs the pattern matching engine to perform case-insensitive evaluation on the preceding content string" },
        { "left": "sid Option (Snort ID)", "right": "Unique numerical identifier assigned to each rule, where custom local enterprise rules use SID >= 1,000,000" },
        { "left": "Anomaly Detection", "right": "Statistical heuristic engine that flags unusual deviations from established normal network traffic baselines" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Snort rule modifier that enables case-insensitive string matching inside packet payloads is ___.",
      "blankAnswer": "nocase",
      "blankDistractors": ["rawbytes", "pcre", "offset"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An attacker transmits a SQL Injection attack where the payload 'UNION SELECT' is encoded as '%55NION%20%53ELECT'. Why does this encoded payload bypass a naive Snort rule matching content:\"UNION SELECT\";, and how do modern IDS engines prevent this evasion?",
      "options": [
        { "text": "Raw pattern matchers inspect literal ASCII wire bytes; '%55' is represented on the wire as bytes 0x25 0x35 0x35, which does not match the byte pattern for 'U' (0x55), causing the naive signature match to fail; modern IDS/IPS engines incorporate HTTP Preprocessors / Normalization Engines that decode URL hexadecimal percent-encoding, Unicode, and Base64 before evaluating signature rules, defeating evasion", "isCorrect": true, "explanation": "Correct! This is one of the most classic IDS evasion and normalization challenges in network security (NIST SP 800-94 Section 3.3; Serious Cryptography). 1. **How Naive Byte Matching Works:** - The string `UNION SELECT` in hex bytes is: `55 4E 49 4F 4E 20 53 45 4C 45 43 54`. - When an attacker sends `%55NION%20%53ELECT`, the raw bytes sent on the wire are: `25 35 35 4E 49 4F 4E 25 32 30 25 35 33 45 4C 45 43 54`. - A naive regex or string matcher checking the raw wire packet sees `25 35 35` instead of `55`. - The rule fails to match, and the packet slips past the IDS! 2. **What Happens at the Web Server:** - The Apache/Nginx web server receives the packet and **automatically decodes the URL-encoded percent hex** (`%55 -> U`, `%20 -> space`, `%53 -> S`). - The backend MySQL database executes the malicious `UNION SELECT` query and dumps passwords! 3. **The Solution (HTTP Preprocessors & Normalization):** - Modern NIDS engines (Snort 3, Suricata, Zeek) run dedicated **Preprocessor Normalization Modules** (`http_inspect`). - The preprocessor unescapes all percent-encoding, decodes chunked transfer encoding, and unzips gzip compression BEFORE passing the clean ASCII string to the signature evaluation engine." },
        { "text": "Because SQL injection attacks only work on Saturdays", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Snort rules cannot read packets containing numbers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because URL encoding automatically encrypts traffic with AES-256", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
