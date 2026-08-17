# Duofy Reusable Lesson Format: Normal Forms (1NF, 2NF, 3NF, and BCNF Hierarchy)

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / Normalization_1NF_to_5NF_and_BCNF`  
**Lesson Format Type:** `normal_forms_1nf_2nf_3nf_and_bcnf_hierarchy`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal mathematical definitions, dependency constraints, and anomaly elimination boundaries of the core normal forms hierarchy (Edgar F. Codd 1970–1972; Raymond F. Boyce & Edgar F. Codd 1974; Elmasri & Navathe *Fundamentals of Database Systems* Chapter 14; Silberschatz et al. Chapter 7): master **1NF** (atomic domain values, no repeating groups), **2NF** (1NF + **NO Partial Dependencies**: every non-prime attribute is fully functionally dependent on every candidate key), **3NF** (2NF + **NO Transitive Dependencies**: for every non-trivial $X \to A$, either $X$ is a Superkey **OR** $A$ is a Prime Attribute), **Boyce-Codd Normal Form (BCNF)** (strictly requiring that for EVERY non-trivial $X \to A$, **$X$ MUST be a Superkey**), evaluate the **3NF Prime Attribute Escape Clause**, and diagnose insertion, update, and deletion anomalies.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Normal Forms Hierarchy Master Table (1NF, 2NF, 3NF, BCNF) & Anomaly Invariants Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Diagnostic Evaluation of a Relation from 1NF to BCNF Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Normal Form & Exact Mathematical Constraint / Violation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of a Functional Dependency Where a Non-Key Attribute Depends on a Subset of a Composite Primary Key (Partial) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis of the Prime Attribute Escape Clause in 3NF vs BCNF Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Normal Forms 1NF to BCNF (Codd 1970–1972; Boyce-Codd 1974):
   - **The Master Normal Forms Taxonomy:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Normal Form} & \textbf{Formal Mathematical Requirement} & \textbf{Primary Anomaly Removed} \\
     \hline
     \mathbf{\text{1NF}} & \text{All column domain values must be atomic scalar values} & \text{Arrays, nested tables, multivalued sets} \\
     \mathbf{\text{2NF}} & \mathbf{\text{1NF } + \text{ No Partial Dependencies (Non-prime depends on subset of key)}} & \text{Partial key redundancy} \\
     \mathbf{\text{3NF}} & \mathbf{\text{2NF } + \text{ For every non-trivial } X \to A: \ X \text{ is Superkey OR } A \text{ is Prime}} & \text{Transitive non-key dependencies} \\
     \mathbf{\text{BCNF}} & \mathbf{\text{Strict: For EVERY non-trivial } X \to A: \ \mathbf{X \text{ MUST BE A SUPERKEY!}}} & \text{All functional dependency anomalies} \\
     \hline
     \end{array}$$
   - **Prime Attribute Definition:** An attribute that is a member of **ANY Candidate Key**.
   - **The 3NF Escape Clause:** If $A$ is prime, $X \to A$ is allowed in 3NF even if $X$ is not a superkey! (BCNF removes this escape clause).
2. **Slide 2 (`ordering`):** Provide 5 steps of diagnosing the highest normal form of relation R(Student_ID, Course_ID, Student_Name, Grade, Instructor_Name, Instructor_Office) with PK {Student_ID, Course_ID}: (1) check 1NF: all attributes contain single atomic values (satisfies 1NF), (2) check 2NF: observe Student_ID -> Student_Name where Student_Name depends on a proper subset of composite key (violates 2NF partial dependency!), (3) decompose into 2NF tables: R1(Student_ID, Student_Name) and R2(Student_ID, Course_ID, Grade, Instructor_Name, Instructor_Office), (4) check 3NF on R2: observe Instructor_Name -> Instructor_Office where non-key determines non-key (violates 3NF transitive dependency!), (5) decompose into 3NF/BCNF tables: R2a(Student_ID, Course_ID, Grade, Instructor_Name) and R2b(Instructor_Name, Instructor_Office)!
3. **Slide 3 (`matching`):** Pair 4 normal forms (1NF, 2NF, 3NF, BCNF) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of partial dependency in 2NF. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the 3NF vs BCNF prime attribute difference: Relation $R(A, B, C)$ has Candidate Keys $\{A, B\}$ and $\{B, C\}$. The functional dependency set is $F = \{AB \to C, \ C \to A\}$. In which highest normal form is relation $R$? (Evaluate $C \to A$: (1) Is $C$ a superkey? No, $\{C\}^+ = \{C, A\} \ne R$. (2) Is $A$ a prime attribute? Yes! $A$ is part of candidate key $\{A, B\}$. Because $A$ is prime, $C \to A$ **satisfies the 3NF condition**, but **violates BCNF** because $C$ is not a superkey; therefore, the relation is in **3NF but NOT in BCNF**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "normal_forms_1nf_2nf_3nf_and_bcnf_hierarchy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Relational Normal Forms Hierarchy (Codd 1970-1974)**\n• **Formal Normal Forms Invariants (Elmasri & Navathe Chapter 14):**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Normal Form} & \\textbf{Formal Mathematical Rule for Every Non-Trivial } X \\to A \\\\\n\\hline\n\\mathbf{\\text{1NF}} & \\text{All attribute values are atomic scalars (no repeating groups/arrays)} \\\\\n\\mathbf{\\text{2NF}} & \\mathbf{\\text{1NF } + \\text{ NO Partial Dependencies (No non-prime attr depends on subset of key)}} \\\\\n\\mathbf{\\text{3NF}} & \\mathbf{\\text{2NF } + (X \\text{ is a Superkey } \\lor \\mathbf{A \\text{ is a Prime Attribute}})} \\\\\n\\mathbf{\\text{BCNF}} & \\mathbf{\\text{Strict: } X \\text{ MUST BE A SUPERKEY! (Zero escape clauses)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Prime Attribute:** An attribute that belongs to **at least ONE candidate key**.\n• **The BCNF Strictness:** BCNF eliminates all redundancy, but can occasionally sacrifice **Dependency Preservation**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential diagnostic steps to normalize R(Student_ID, Course_ID, Student_Name, Grade, Dept_Head) with PK {Student_ID, Course_ID}.",
      "orderItems": [
        "Verify 1NF: check that all fields contain atomic scalar values with zero nested tables or array lists",
        "Diagnose 2NF: detect partial dependency Student_ID -> Student_Name depending on subset of composite primary key",
        "Decompose to achieve 2NF: create R1(Student_ID, Student_Name) and R2(Student_ID, Course_ID, Grade, Dept_Head)",
        "Diagnose 3NF on R2: detect transitive dependency Course_ID -> Dept_Head where non-key determines another non-key",
        "Decompose to achieve 3NF/BCNF: create R2a(Student_ID, Course_ID, Grade) and R2b(Course_ID, Dept_Head)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Normal Form to its exact mathematical requirement.",
      "matchPairs": [
        { "left": "First Normal Form (1NF)", "right": "Mandates that every attribute domain contains only atomic, indivisible scalar values" },
        { "left": "Second Normal Form (2NF)", "right": "Prohibits partial functional dependencies of non-prime attributes on a subset of a candidate key" },
        { "left": "Third Normal Form (3NF)", "right": "Requires that for every X -> A, either X is a superkey OR A is a member of some candidate key" },
        { "left": "Boyce-Codd Normal Form (BCNF)", "right": "Strictly requires that the left-hand side X of every non-trivial dependency X -> A is a superkey" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A functional dependency where a non-prime attribute depends on only a proper subset of a composite candidate key is a ___ dependency.",
      "blankAnswer": "partial",
      "blankDistractors": ["transitive", "multivalued", "join"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Relation R(A, B, C) has Candidate Keys {A, B} and {B, C}. The functional dependency set is F = {AB -> C, C -> A}. In which highest normal form is relation R?",
      "options": [
        { "text": "3NF (Third Normal Form); evaluating C -> A reveals that C is not a superkey ({C}+ = {A, C} != R), but attribute A is a Prime Attribute because A is a member of candidate key {A, B}; because A is prime, the dependency satisfies 3NF, but strictly violates BCNF because C is not a superkey", "isCorrect": true, "explanation": "Correct! This is the classic textbook counterexample demonstrating the exact difference between 3NF and BCNF (Elmasri & Navathe Section 14.5; Silberschatz Section 7.3.3). 1. Candidate Keys of $R(A, B, C)$: $\\{A, B\\}$ and $\\{B, C\\}$. 2. Prime Attributes (attributes belonging to ANY candidate key): $\\{A, B, C\\}$ (All attributes in this relation are prime!). 3. Non-Prime Attributes: $\\emptyset$ (None). 4. Evaluate dependency $AB \\to C$: - Is $\\{A, B\\}$ a superkey? YES. (Satisfies both 3NF and BCNF). 5. Evaluate dependency $C \\to A$: - Is $C$ a superkey? Let's compute $\\{C\\}^+ = \\{C, A\\} \\ne R$. No, $C$ is NOT a superkey! - Is $A$ a Prime Attribute? YES! $A$ is part of candidate key $\\{A, B\\}$. 6. **3NF Rule:** For every $X \\to A$, either $X$ is a superkey OR $A$ is prime. - Since $A$ is prime, $C \\to A$ SATISFIES 3NF! 7. **BCNF Rule:** For every $X \\to A$, $X$ MUST be a superkey. - Since $C$ is NOT a superkey, $C \\to A$ VIOLATES BCNF! 8. Therefore, the relation is in **3NF, but NOT in BCNF**." },
        { "text": "BCNF (Boyce-Codd Normal Form)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "2NF only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1NF only", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
