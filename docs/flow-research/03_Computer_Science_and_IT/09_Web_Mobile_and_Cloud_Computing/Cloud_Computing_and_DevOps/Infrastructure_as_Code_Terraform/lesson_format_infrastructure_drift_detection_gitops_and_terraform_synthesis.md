# Duofy Reusable Lesson Format: Drift Detection & GitOps (Terraform Production Architecture)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / Infrastructure_as_Code_Terraform`  
**Lesson Format Type:** `infrastructure_drift_detection_gitops_and_terraform_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify enterprise IaC governance, out-of-band drift remediation, and continuous delivery GitOps pipelines in Terraform (Yevgeniy Brikman *Terraform: Up & Running* Chapter 6 & 8; HashiCorp Terraform Cloud Architecture; Alexis Richardson GitOps Principles): master **Configuration Drift Detection** (detecting unauthorized manual changes made via cloud web consoles or emergency CLI fixes by comparing live cloud API state against the authoritative `terraform.tfstate` during `terraform plan` / `terraform plan -refresh-only`), master **Drift Remediation Strategies** (re-applying git-committed code to revert unauthorized drift vs importing/updating HCL to reconcile intentional emergency changes), master **GitOps Automation (e.g. Atlantis, Terraform Cloud, GitHub Actions)** (pull request speculative plans, peer review approvals, and post-merge automated apply with remote locking), and interact with live Declarative IaC workflow runner, Terraform DAG graph scheduler, and State Locking / Drift Detection widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GitOps Automated Delivery Pipeline Diagram (PR Plan $\to$ Review $\to$ Merge Apply) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | GitOps / Drift Governance Mechanism & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Running Terraform in Automated GitOps CI/CD Outperforms Local Terminal Applies Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Discrepancy Between Real Cloud Infrastructure and Git-Committed Terraform Code Is Configuration ___ (Drift) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Terraform Studio: Declarative Workflow, DAG Scheduler & Drift Remediation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "infrastructure_drift_detection_gitops_and_terraform_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Configuration Drift in Terraform, and how does a GitOps pipeline detect and remediate it?",
      "blankAnswer": "Configuration Drift & GitOps (Yevgeniy Brikman; Alexis Richardson): (1) CONFIGURATION DRIFT: Occurs when infrastructure is modified out-of-band (e.g. engineer manually edits an AWS Security Group or resizes an EC2 instance in the AWS Console). (2) DRIFT DETECTION: Running 'terraform plan' queries live cloud APIs, detects that real cloud state diverges from terraform.tfstate and HCL code, and highlights modifications (~). (3) REMEDIATION: Running 'terraform apply' pushes the git-committed desired state back to the cloud, overwriting the manual change and restoring compliance! (4) GITOPS WORKFLOW: Git repo is the single source of truth. (a) Pull Request triggers speculative 'terraform plan' posted as PR comment -> (b) Peer review & security approval -> (c) Merge to main triggers automated 'terraform apply' with DynamoDB state locking!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Terraform Governance Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Configuration Drift", "right": "Divergence between real-world cloud infrastructure state and declarative HCL code" },
        { "left": "terraform plan -refresh-only", "right": "Inspects and updates terraform.tfstate to match live cloud state without modifying cloud resources" },
        { "left": "GitOps CI/CD (Atlantis/TFC)", "right": "Executes terraform plans automatically on pull requests and applies upon merge" },
        { "left": "State Drift Remediation", "right": "Running terraform apply to overwrite unauthorized manual changes and restore declared state" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is running Terraform inside an automated GitOps CI/CD pipeline (such as Atlantis or Terraform Cloud) considered mandatory for enterprise infrastructure governance over developers running 'terraform apply' from local laptops?",
      "options": [
        { "text": "Running Terraform from local developer laptops introduces severe security and operational risks: developers require permanent high-privilege cloud admin credentials on personal machines, local state locks can be left dangling if laptops sleep mid-apply, and uncommitted local code changes can be applied without peer code review or audit logs; an automated GitOps CI/CD pipeline centralizes cloud credentials in secure ephemeral runners, enforces mandatory Pull Request peer reviews and policy-as-code checks (e.g. OPA/Sentinel) on speculative plans before apply, and maintains an immutable Git commit audit trail for every single infrastructure modification", "isCorrect": true, "explanation": "Correct! This is the core thesis of modern GitOps and enterprise cloud governance (HashiCorp Terraform Cloud Architecture; Alexis Richardson GitOps Principles). 1. **The Dangers of Local Laptop 'terraform apply':** - Every developer must have `AWS_SECRET_ACCESS_KEY` with administrator permissions stored on their laptop. If a laptop is lost or stolen, production infrastructure is compromised! - Developer Alice might run `terraform apply` with uncommitted experimental code sitting on her local branch, creating untracked resources that nobody else has in Git! - If Alice's laptop runs out of battery during an apply: The DynamoDB lock is left locked and state is left half-applied! 2. **The GitOps Standard (Atlantis / Terraform Cloud / GitHub Actions):** - Developers have **zero local AWS credentials**! - Developer opens a PR: `feat: add redis cluster`. - CI runner securely runs `terraform plan` and posts the exact formatted diff directly into the PR comments! - Security team reviews and approves the PR. - On merge to `main`: The CI runner acquires the DynamoDB lock, executes `terraform apply`, updates the remote S3 state, and releases the lock. - **Result:** 100% auditable, secure, peer-reviewed infrastructure automation!" },
        { "text": "Because laptops do not have enough processing power to compile HCL code", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because GitOps pipelines make Terraform code run at the speed of light", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AWS disables accounts that execute commands from local terminal shells", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The discrepancy that occurs when cloud infrastructure is modified out-of-band via web consoles is configuration ___.",
      "blankAnswer": "drift",
      "blankDistractors": ["lock", "leak", "fault"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Terraform Studio: DAG, State Locking & Drift",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Infrastructure as Code Studio</h3><p>Architecture: <b style=\"color:#38bdf8;\">Terraform Workflow, DAG & State Locking</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnDag\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Compile Dependency DAG</button><button id=\"btnLock\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Acquire DynamoDB State Lock</button><button id=\"btnDrift\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Detect & Remediate Drift</button></div><div id=\"tfLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to compile Terraform DAG...</div><script>document.getElementById('btnDag').onclick=()=>{document.getElementById('tfLog').innerHTML='<b>1. DIRECTED ACYCLIC GRAPH (DAG):</b><br>• Root Nodes: aws_vpc + aws_s3_bucket (Parallelized!)<br>• Dependent Node: aws_subnet &rarr; aws_instance (Topological sort)<br>• <b style=\"color:#10b981;\">DAG compiled with 0 cyclic dependencies!</b>';}; document.getElementById('btnLock').onclick=()=>{document.getElementById('tfLog').innerHTML='<b>2. DISTRIBUTED STATE LOCK ACQUISITION:</b><br>• PutItem(LockID: \"uuid-9871\") into DynamoDB Table<br>• Remote State downloaded from Encrypted S3 Bucket<br>• <b style=\"color:#38bdf8;\">Concurrent team collisions blocked with 100% safety!</b>';}; document.getElementById('btnDrift').onclick=()=>{document.getElementById('tfLog').innerHTML='<b>3. CONFIGURATION DRIFT REMEDIATION:</b><br>• Out-of-band drift detected: Security Group opened to 0.0.0.0/0<br>• terraform plan calculated delta (~ 1 modification)<br>• terraform apply executed &rarr; <b style=\"color:#10b981;\">Security Group restored to Git compliant state!</b><br>🏆 <b style=\"color:#10b981;\">Entire Computer Science & IT Discipline 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
