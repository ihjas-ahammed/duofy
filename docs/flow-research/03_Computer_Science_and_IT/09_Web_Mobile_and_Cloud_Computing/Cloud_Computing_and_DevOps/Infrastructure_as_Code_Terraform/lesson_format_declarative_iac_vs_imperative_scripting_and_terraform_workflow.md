# Duofy Reusable Lesson Format: Declarative IaC (vs Imperative Scripts and Terraform Workflow)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / Infrastructure_as_Code_Terraform`  
**Lesson Format Type:** `declarative_iac_vs_imperative_scripting_and_terraform_workflow`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through declarative infrastructure paradigms, state convergence, and the core Terraform operational lifecycle (Yevgeniy Brikman *Terraform: Up & Running* Chapter 1 & 2; HashiCorp Terraform Core Engine Architecture): master the fundamental difference between **Declarative Infrastructure as Code (Terraform HCL)** (declaring the **Desired End State** *\"There must exist 3 VMs and 1 Load Balancer\"*, allowing the engine to calculate the delta and converge idempotently: $\mathbf{f(f(x)) = f(x)}$) vs **Imperative Scripting (Bash / Python / AWS CLI)** (specifying step-by-step sequential commands *\"Create VM 1, then create VM 2\"*, which fail or duplicate resources on retries), and master the **4-Stage Terraform Core Lifecycle**: **1. `terraform init`** (downloads cloud provider plugins e.g. `hashicorp/aws` and initializes backends), **2. `terraform plan`** (reads live cloud state, diffs Desired vs Actual, builds a DAG, and prints precise resource creations `+`, modifications `~`, and deletions `-`), **3. `terraform apply`** (executes the compiled plan against cloud APIs), and **4. `terraform destroy`** (tears down all managed resources in clean reverse-dependency order).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Declarative IaC vs Imperative Automation Comparison Matrix & 4-Stage Workflow Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Execution of the Complete Terraform Engineering Lifecycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Terraform CLI Command / IaC Concept & Technical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Terraform CLI Command That Initializes the Working Directory and Downloads Provider Plugins Is terraform ___ (init) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Systems Engineering Analysis: Why Declarative IaC Guarantees True Idempotency Over Imperative Bash Scripts Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Declarative IaC (Brikman 2022; HashiCorp 2023):
   - **Declarative vs Imperative Comparison Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{IaC Paradigm} & \textbf{Imperative Scripts (Bash / Python / CLI)} & \textbf{Declarative IaC (Terraform HCL)} \\
     \hline
     \mathbf{\text{Authoring Focus}} & \text{Procedural execution steps (*\"How\"*)} & \mathbf{\text{Desired target state (*\"What\"*)}} \\
     \mathbf{\text{Idempotency}} & \mathbf{\text{Non-idempotent (Duplicate resources on re-run)}} & \mathbf{\text{100\% Idempotent: } f(f(x)) = f(x)} \\
     \mathbf{\text{Failure Recovery}} & \text{Stops midway; leaves dangling orphaned state} & \mathbf{\text{Calculates exact diff and converges on retry}} \\
     \mathbf{\text{Preview Safety}} & \text{Executes live without pre-execution dry run} & \mathbf{\text{Detailed pre-flight execution plan (}}\\texttt{plan}\\text{)}} \\
     \hline
     \end{array}$$
   - **The 4-Stage Terraform Workflow:**
     $$\mathbf{\texttt{terraform init}} \longrightarrow \mathbf{\texttt{terraform plan}} \longrightarrow \mathbf{\texttt{terraform apply}} \longrightarrow \mathbf{\texttt{terraform destroy}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the Terraform workflow: (1) write declarative HCL files defining AWS VPC and EC2 instances, (2) run `terraform init` to download the AWS provider plugin into `.terraform/` and configure state backend, (3) run `terraform plan` to compare HCL code against live cloud API state and output the execution graph diff, (4) run `terraform apply` and approve the plan; Terraform provisions cloud resources via AWS REST APIs and writes IDs to `terraform.tfstate`, (5) run `terraform destroy` when decommissioning environment to delete resources in reverse dependency order!
3. **Slide 3 (`matching`):** Pair 4 concepts (`terraform init`, `terraform plan`, `terraform apply`, `terraform destroy`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of init. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why declarative IaC guarantees idempotency over imperative bash scripts: In cloud infrastructure automation, why does running a declarative Terraform manifest 10 times consecutively guarantee true mathematical idempotency ($f(f(x)) = f(x)$), whereas running an imperative Bash script (`aws ec2 run-instances ...`) 10 times results in catastrophic resource duplication? (An imperative Bash script blindly executes the raw API command to create a VM on every invocation, so **running the script 10 times provisions 10 duplicate virtual machines, incurring 10x cloud billing costs**; **a declarative Terraform manifest defines the desired state (e.g. `count = 1`); on runs 2 through 10, Terraform queries live state, discovers that 1 VM already exists matching the configuration, determines that the delta is exactly 0 changes (`No changes. Your infrastructure matches the configuration.`), and executes zero API mutations**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "declarative_iac_vs_imperative_scripting_and_terraform_workflow",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Declarative Infrastructure as Code \\& The Terraform Lifecycle (Yevgeniy Brikman)**\n• **Declarative vs Imperative Comparison Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Dimension} & \\textbf{Imperative Scripts (Bash / AWS CLI)} & \\textbf{Declarative IaC (Terraform HCL)} \\\\\n\\hline\n\\mathbf{\\text{Mental Model}} & \\text{Step-by-step procedural actions (*\"How to build\"*)} & \\mathbf{\\text{Desired end-state blueprint (*\"What should exist\"*)}} \\\\\n\\mathbf{\\text{Idempotency}} & \\mathbf{\\text{Non-Idempotent (Creates duplicates on re-run)}} & \\mathbf{\\text{100\\% Idempotent: } f(f(x)) = f(x)} \\\\\n\\mathbf{\\text{State Tracking}} & \\text{Blind to pre-existing resources} & \\mathbf{\\text{Maintains central state map (}\\texttt{terraform.tfstate}\\text{)}} \\\\\n\\mathbf{\\text{Pre-flight Diff}} & \\text{Zero dry-run validation} & \\mathbf{\\text{Computes exact execution diff (}\\texttt{terraform plan}\\text{)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 4-Stage Core Engine Lifecycle:**\n$$\n\\mathbf{\\texttt{init (Plugins)}} \\longrightarrow \\mathbf{\\texttt{plan (Diff Engine)}} \\longrightarrow \\mathbf{\\texttt{apply (Parallel Exec)}} \\longrightarrow \\mathbf{\\texttt{destroy (Teardown)}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the standard Terraform engineering workflow when provisioning a new cloud VPC.",
      "orderItems": [
        "Author declarative HCL configuration files (main.tf, variables.tf) specifying desired cloud resources",
        "Execute 'terraform init' to download required provider binaries (e.g. hashicorp/aws) and initialize the backend",
        "Execute 'terraform plan' to inspect live cloud state, calculate the dependency DAG, and preview planned additions (+)",
        "Execute 'terraform apply', allowing the Terraform engine to provision resources via cloud APIs and update terraform.tfstate",
        "Execute 'terraform destroy' upon environment decommissioning to tear down all managed resources in reverse DAG order"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Terraform CLI Workflow Command to its exact Engine Action.",
      "matchPairs": [
        { "left": "terraform init", "right": "Initializes the working directory, downloads cloud provider plugins, and connects to remote backend" },
        { "left": "terraform plan", "right": "Refreshes live state, diffs actual vs desired state, and generates an execution plan" },
        { "left": "terraform apply", "right": "Executes planned cloud API calls in parallel to converge infrastructure to desired state" },
        { "left": "terraform destroy", "right": "Terminates all managed infrastructure resources in strict reverse-dependency order" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Terraform CLI command used to download required provider plugins and initialize state backends is terraform ___.",
      "blankAnswer": "init",
      "blankDistractors": ["plan", "apply", "refresh"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In cloud automation, why does executing a declarative Terraform configuration ten times in a row guarantee mathematical idempotency (f(f(x)) = f(x)), whereas executing an imperative Bash script (aws ec2 run-instances) ten times results in catastrophic resource duplication?",
      "options": [
        { "text": "An imperative Bash script blindly executes the create command on every single run without inspecting existing system state, resulting in 10 separate API calls that provision 10 duplicate virtual machines and inflate cloud costs tenfold; a declarative Terraform manifest declares the desired end state (e.g. 'there should be 1 web server'); on the 1st run it creates the VM, while on runs 2 through 10, Terraform inspects live state via its state file, determines that 1 VM already exists matching the configuration, computes a delta of exactly 0 changes, and performs zero cloud API mutations", "isCorrect": true, "explanation": "Correct! This is Yevgeniy Brikman's primary justification for declarative Infrastructure as Code (*Terraform: Up & Running* Chapter 1). 1. **The Imperative Failure (Bash / CLI):** - You run `aws ec2 run-instances --image-id ami-123 --instance-type t3.micro`. - If the network drops or the CI pipeline re-runs $10\\text{ times}$: - The AWS API creates 10 separate EC2 instances (`i-1`, `i-2`, ..., `i-10`). - You get billed $10\\times$ more and the system is in an inconsistent state! 2. **The Declarative Elegance (Terraform HCL):** - You write: `resource \"aws_instance\" \"web\" { ami = \"ami-123\"; instance_type = \"t3.micro\" }`. - On Run 1: Terraform sees state has 0 instances $\\implies$ Creates 1 VM $\\implies$ Records `i-1` in `terraform.tfstate`. - On Runs 2 through 10: Terraform reads state $\\to$ sees `i-1` exists $\\to$ asks AWS: *\"Does `i-1` match our HCL?\"* $\\to$ AWS confirms *\"Yes\"* $\\to$ Terraform outputs: `\"No changes. Your infrastructure matches the configuration.\"`! - **Total mutations on runs 2-10 = ZERO! $100\\%$ idempotent!**" },
        { "text": "Because Bash scripts cannot connect to the internet", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Terraform compiles code into hardware motherboard circuits", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AWS prohibits running CLI commands more than once per day", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
