# Duofy Reusable Lesson Format: Terraform DAG (Dependency Graphs, HCL, and Reusable Modules)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / Infrastructure_as_Code_Terraform`  
**Lesson Format Type:** `terraform_hcl_resource_dependency_graph_dag_and_modules`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through declarative graph compilation, parallel scheduling, dependency resolution, and reusable modular architecture in Terraform HCL (Yevgeniy Brikman *Terraform: Up & Running* Chapter 4; HashiCorp Terraform HCL Language Specification): master the **Directed Acyclic Graph (DAG) Compilation Engine** (how Terraform parses HCL resources as vertices/nodes and dependency relationships as directed edges), contrast **Implicit Dependencies** (automatically inferred by Terraform when one resource references an exported attribute of another e.g. `subnet_id = aws_subnet.main.id`) vs **Explicit Dependencies ($\mathbf{\texttt{depends\_on = [aws\_iam\_role\_policy\_attachment.example]}}$)** (manual overrides used only when hidden side-effect relationships exist), analyze **Maximum Concurrency Execution** (how Terraform provisions hundreds of independent DAG branches simultaneously in parallel up to `-parallelism=10`), and author **Reusable Terraform Modules** (`variables.tf`, `main.tf`, `outputs.tf`).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Directed Acyclic Graph (DAG) Topology Diagram & Implicit vs Explicit (`depends_on`) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step DAG Compilation, Parallel Branch Execution, and Topological Walk Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Terraform HCL Construct / Dependency Mechanism & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Directed Graph Data Structure Compiled by Terraform to Determine Resource Creation Order Is a ___ (DAG) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Software Architecture Analysis: Why Implicit Attribute References Are Strongly Preferred Over 'depends_on' Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Terraform DAG & Modules (Brikman 2022; HashiCorp 2023):
   - **DAG Dependency Formulation:**
     $$\mathbf{\text{Graph: } G = (V, E) \quad \text{where } V = \text{Resources}, \ E = \text{Dependencies}}$$
     - **Implicit Dependency:** `vpc_id = aws_vpc.main.id` $\implies$ Edge $\text{aws\_subnet.main} \to \text{aws\_vpc.main}$ created automatically!
     - **Explicit Dependency:** `depends_on = [aws_s3_bucket.logs]` $\implies$ Used only when no direct attribute reference exists.
   - **Module Composition Invariant:**
     $$\mathbf{\text{Module Architecture: } \mathbf{\texttt{variables.tf (Inputs)}} \longrightarrow \mathbf{\texttt{main.tf (Resources)}} \longrightarrow \mathbf{\texttt{outputs.tf (Exports)}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of DAG scheduling: (1) Terraform parses all `.tf` configuration files in the working directory into an AST, (2) Terraform inspects all attribute expressions, constructing a Directed Acyclic Graph (DAG) of resource dependencies, (3) Terraform performs a topological sort on the DAG to find root nodes with 0 incoming dependencies, (4) Terraform provisions independent root resources (VPC, S3 bucket, IAM roles) concurrently in parallel, (5) once dependent parent resources finish and return exported IDs, child resources (Subnet, EC2 instance) are unblocked and created!
3. **Slide 3 (`matching`):** Pair 4 concepts (Directed Acyclic Graph DAG, Implicit Dependency, Explicit `depends_on`, Terraform Module) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of DAG. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on implicit vs explicit `depends_on`: In professional Terraform module engineering, why are implicit attribute references (`subnet_id = aws_subnet.public.id`) strongly preferred over hardcoded explicit `depends_on` blocks for modeling resource relationships? (Implicit attribute references allow Terraform to dynamically determine dependencies from exact data values, **automatically populating dependent arguments with dynamic cloud-generated values (such as subnet IDs and ARN strings) while maximizing parallelism by enforcing dependencies only where data is actually needed**; **overusing explicit `depends_on` forces rigid, artificial sequencing across entire resource trees, needlessly serializing independent operations, reducing concurrent provisioning throughput, and obscuring real data flow**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "terraform_hcl_resource_dependency_graph_dag_and_modules",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Directed Acyclic Graph (DAG) Compilation \\& Modules (HashiCorp)**\n• **Dependency Graph Topology Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Dependency Type} & \\textbf{Syntax Formulation} & \\textbf{How Inferred} & \\textbf{Best Practice Status} \\\\\n\\hline\n\\mathbf{\\text{Implicit Dependency}} & \\mathbf{\\texttt{vpc\\_id = aws\\_vpc.main.id}} & \\mathbf{\\text{Engine detects attribute reference automatically}} & \\mathbf{\\text{Gold Standard (Maximum Concurrency!)}} \\\\\n\\mathbf{\\text{Explicit Dependency}} & \\mathbf{\\texttt{depends\\_on = [aws\\_iam.role]}} & \\text{Manually declared in HCL block} & \\text{Use sparingly (Hidden side-effects only)} \\\\\n\\hline\n\\end{array}\n$$\n• **The DAG Concurrency Invariant:**\n$$\n\\mathbf{\\text{All Independent Nodes in DAG (Zero Edges between them)}} \\xrightarrow{\\text{Parallelized!}} \\mathbf{\\text{Executed Concurrently up to } \\texttt{-parallelism=10}}\n$$\n• **Modular HCL Component Triad:**\n  - $\\mathbf{\\texttt{variables.tf}}$: Declares parameterized inputs with type constraints;\n  - $\\mathbf{\\texttt{main.tf}}$: Declares resource blueprints;\n  - $\\mathbf{\\texttt{outputs.tf}}$: Exports generated cloud IDs to consuming parent modules!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by the Terraform engine to compile a DAG and schedule parallel resource provisioning.",
      "orderItems": [
        "Terraform parses all HCL code files in the root module and submodules into an Abstract Syntax Tree (AST)",
        "The engine analyzes cross-resource attribute references to construct a Directed Acyclic Graph (DAG) of vertices and edges",
        "Terraform performs a topological sort on the DAG to identify all root nodes possessing zero dependencies",
        "The engine provisions independent root nodes (e.g. AWS VPC, S3 Log Bucket, IAM Roles) concurrently in parallel",
        "As parent resources finish and export their cloud IDs, dependent downstream nodes (Subnets, EC2 Instances) unblock and execute"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Terraform HCL / Architecture Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Directed Acyclic Graph (DAG)", "right": "Mathematical graph compiled by Terraform modeling resource dependencies and execution order" },
        { "left": "Implicit Dependency", "right": "Relationship automatically detected by referencing an exported attribute of another resource" },
        { "left": "Explicit depends_on", "right": "Meta-argument manually forcing a resource to wait for another to complete before starting" },
        { "left": "Terraform Module", "right": "Self-contained package of HCL files defining reusable, parameterized infrastructure templates" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The directed mathematical graph structure compiled by Terraform to determine resource provisioning order is a ___.",
      "blankAnswer": "DAG",
      "blankDistractors": ["Tree", "Queue", "Ring"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In professional Terraform module architecture, why are implicit attribute references (e.g. subnet_id = aws_subnet.public.id) strongly preferred over hardcoded explicit 'depends_on' blocks for establishing relationships?",
      "options": [
        { "text": "Implicit attribute references allow Terraform to dynamically infer dependencies from actual data flow, automatically passing generated cloud attributes (such as subnet IDs, security group IDs, and ARNs) directly into dependent resources while maximizing concurrency by enforcing ordering only where real data dependencies exist; overusing explicit 'depends_on' blocks forces rigid, coarse-grained sequencing across entire resource blocks, needlessly serializing operations that could otherwise run in parallel and obscuring the true data flow of the architecture", "isCorrect": true, "explanation": "Correct! This is Yevgeniy Brikman's central guideline for writing clean Terraform HCL (*Terraform: Up & Running* Chapter 4). 1. **Why Implicit Dependencies Are Superior:** - When you write: `resource \"aws_instance\" \"web\" { subnet_id = aws_subnet.main.id }` - Two critical things happen simultaneously: - (a) **Data Flow:** The real generated subnet ID (e.g. `subnet-012345`) is automatically injected into the EC2 instance configuration upon creation. - (b) **Precise Dependency:** Terraform knows `web` depends on `main` *only* because of `subnet_id`. - If you also declare an independent `aws_s3_bucket.logs`: Terraform creates `aws_s3_bucket.logs` and `aws_subnet.main` **concurrently in parallel** at the exact same time! 2. **The Problem with Explicit `depends_on`:** - If you write `depends_on = [module.vpc]`: - Terraform stops ALL resources in your module until the ENTIRE VPC module finishes every single one of its 20 sub-resources! - It destroys parallelism and slows down deployment times significantly. 3. **The Rule:** Only use `depends_on` when a hidden, out-of-band dependency exists that cannot be expressed as an attribute reference (e.g. waiting for an IAM role policy attachment to propagate before launching an EKS cluster)!" },
        { "text": "Because explicit depends_on was deleted from Terraform in version 1.0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because implicit dependencies do not require cloud provider authentication", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because depends_on causes Terraform to run in single-threaded mode on the CPU", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
