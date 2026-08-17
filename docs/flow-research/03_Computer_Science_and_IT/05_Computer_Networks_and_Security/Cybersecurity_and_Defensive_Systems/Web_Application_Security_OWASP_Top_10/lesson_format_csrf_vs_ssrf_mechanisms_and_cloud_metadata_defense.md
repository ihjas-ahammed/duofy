# Duofy Reusable Lesson Format: CSRF vs SSRF Mechanisms and Cloud Metadata Defense

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Web_Application_Security_OWASP_Top_10`  
**Lesson Format Type:** `csrf_vs_ssrf_mechanisms_and_cloud_metadata_defense`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify cross-origin request forging, backend internal pivot exploits, and cloud metadata defense architectures across Cross-Site Request Forgery (CSRF) and Server-Side Request Forgery (SSRF) (OWASP Top 10 2021 A10: SSRF; PortSwigger Web Security Academy; Stuttard & Pinto Chapter 10; AWS IMDSv2 RFC): contrast **Client-Side Impersonation (CSRF)** (tricking an authenticated user's browser into transmitting unauthorized state-changing HTTP commands via ambient credentials like session cookies; defended by **Anti-CSRF Synchronizer Tokens** and **`SameSite=Lax` / `SameSite=Strict` Cookie Attributes**) with **Server-Side Internal Pivoting (SSRF)** (tricking the backend server itself into fetching arbitrary internal/private URLs, bypassing network firewalls to access internal microservices or **Cloud Metadata Endpoints e.g. `http://169.254.169.254/latest/meta-data/iam/security-credentials/`** to steal AWS STS tokens; defended by strict URL whitelisting, RFC 1918/3927 private IP blocking, disabling HTTP redirects, and **AWS Instance Metadata Service v2 [IMDSv2 session-token requirement]**), and interact with live CSRF token verification and SSRF cloud metadata isolation simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CSRF vs SSRF Threat Vectors, Cloud Metadata 169.254.169.254 & IMDSv2 Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Threat Vector / Defense Protocol & Web Security Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why CSRF Synchronizer Tokens Stored in POST Bodies Prevent Cross-Origin Forgery Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Link-Local IPv4 Address Used by Cloud Providers for Instance Metadata (169.254.169.254) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive CSRF Token Verification & SSRF Cloud Metadata Defense Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "csrf_vs_ssrf_mechanisms_and_cloud_metadata_defense",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do CSRF and SSRF differ in execution context, and how are both vulnerabilities defended?",
      "blankAnswer": "CSRF vs SSRF (OWASP A10 & PortSwigger Web Security Academy): (1) CSRF (Cross-Site Request Forgery - Client-Side): The attacker tricks a victim's authenticated BROWSER into sending forged HTTP POST requests (e.g. changing email/transferring money) to a vulnerable site. The browser automatically attaches the victim's session cookies (Ambient Credentials). Defenses: (i) Anti-CSRF Synchronizer Tokens (Cryptographically random tokens in form POST bodies). (ii) SameSite=Strict / SameSite=Lax cookie attribute. (2) SSRF (Server-Side Request Forgery - Server-Side): The attacker tricks the BACKEND WEB SERVER into fetching an internal URL. The server becomes an open proxy pivoting into the internal network! (3) THE CLOUD METADATA THREAT (169.254.169.254): In AWS/GCP/Azure, attackers input 'http://169.254.169.254/latest/meta-data/iam/security-credentials/' to steal IAM temporary secret access keys! (4) SSRF DEFENSES: (i) Whitelist allowed domains/IPs. (ii) Block private RFC 1918 / link-local RFC 3927 IPs. (iii) Enforce AWS IMDSv2 (requires session token via PUT request with 'X-aws-ec2-metadata-token-ttl-seconds', which SSRF cannot forge!)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Web Security Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "CSRF Vulnerability", "right": "Client-side exploit where an attacker leverages an authenticated browser's automatic cookie transmission" },
        { "left": "SSRF Vulnerability", "right": "Server-side exploit coercing the backend server to make unauthorized HTTP requests to internal networks" },
        { "left": "Anti-CSRF Token", "right": "Cryptographically unpredictable value embedded in forms and verified by the server to defeat cross-origin forgery" },
        { "left": "AWS IMDSv2", "right": "Cloud metadata defense requiring a session token obtained via HTTP PUT to defeat basic SSRF attacks" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does an Anti-CSRF Synchronizer Token successfully prevent Cross-Site Request Forgery attacks against an authenticated banking website (bank.com)?",
      "options": [
        { "text": "The banking server generates a cryptographically random, unguessable token tied to the user's session and embeds it in the hidden HTML form; when a user submits a transfer, the server validates that the POST body token matches the session token; because the Same-Origin Policy (SOP) prevents an external attacker's website (evil.com) from reading the DOM or extracting the token from bank.com, forged cross-origin requests cannot supply the valid token and are immediately rejected", "isCorrect": true, "explanation": "Correct! This is the canonical defense against Cross-Site Request Forgery (OWASP CSRF Prevention Cheat Sheet; PortSwigger Web Security Academy). 1. **How CSRF Attacks Work:** - Alice logs into `bank.com`. - Alice visits `evil.com` in another tab. - `evil.com` runs JavaScript: `fetch('https://bank.com/transfer', {method: 'POST', body: 'to=hacker&amount=1000'})`. - The browser automatically attaches Alice's `Cookie: session=xyz` because it's a request to `bank.com`. - The bank sees a valid session cookie and executes the transfer! 2. **How Anti-CSRF Tokens Fix It:** - When `bank.com` renders the transfer page, it includes: `<input type='hidden' name='csrf_token' value='9f8a3b...'>`. - When a POST request arrives, the server checks BOTH the cookie AND the `csrf_token` form field. - When `evil.com` tries to forge the request, `evil.com` CANNOT guess the random `csrf_token`. - Due to the **Same-Origin Policy (SOP)**, `evil.com` is forbidden from reading the HTML of `bank.com` to steal the token. - The forged request arrives without a valid token, and the bank rejects it with `403 Forbidden`!" },
        { "text": "Because CSRF tokens encrypt all bank accounts with RSA 4096", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CSRF tokens turn off the user's internet connection during bank transfers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CSRF tokens force all requests to use UDP instead of HTTP", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The link-local IPv4 address used by AWS, Azure, and GCP for instance metadata is ___.",
      "blankAnswer": "169.254.169.254",
      "blankDistractors": ["127.0.0.1", "192.168.1.1", "10.0.0.1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive CSRF vs SSRF Cloud Defense Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>CSRF & SSRF Security Simulator</h3><div style=\"display:flex; gap:6px;\"><button id=\"btnCsrf\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Attacker: Forge CSRF (No Token)</button><button id=\"btnSsrf\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Attacker: SSRF to 169.254.169.254</button><button id=\"btnImds\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Enable IMDSv2 + Anti-CSRF</button></div><div id=\"webLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Select an exploit to test defense...</div><script>document.getElementById('btnCsrf').onclick=()=>{document.getElementById('webLog').innerHTML='<b>CSRF ATTEMPT (evil.com &rarr; bank.com):</b><br>• Cookie attached automatically.<br>🚫 <b style=\"color:#ef4444;\">REJECTED 403: Missing Anti-CSRF Token!</b><br>• SameSite=Lax cookie attribute blocked cross-site POST.';}; document.getElementById('btnSsrf').onclick=()=>{document.getElementById('webLog').innerHTML='<b>SSRF ATTEMPT (Server &rarr; 169.254.169.254):</b><br>• Target: AWS Metadata IAM keys.<br>⚠️ In legacy IMDSv1: Keys exfiltrated!<br>🛡️ In IMDSv2: <b style=\"color:#10b981;\">BLOCKED 401 (Missing X-aws-ec2-metadata-token PUT header)!</b>';}; document.getElementById('btnImds').onclick=()=>{document.getElementById('webLog').innerHTML='<b>ALL DEFENSES ACTIVE:</b><br>✅ Anti-CSRF Synchronizer Tokens validated.<br>✅ SameSite=Strict cookies enforced.<br>✅ AWS IMDSv2 token authentication enforced.<br>✅ RFC 1918 / Link-Local IPs blocked on egress.<br>🎉 100% Protected against CSRF and SSRF!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
