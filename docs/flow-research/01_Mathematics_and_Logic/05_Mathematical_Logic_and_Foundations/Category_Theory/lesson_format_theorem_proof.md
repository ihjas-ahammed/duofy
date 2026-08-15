# Duofy Reusable Lesson Format: Category Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Category_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational category theory proofs: The Yoneda Lemma Proof, Adjoint Functor Preservation of Limits/Colimits ($L$ preserves colimits, $R$ preserves limits), and Monad Multiplication Axioms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Yoneda Lemma Proof Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Yoneda Naturality Square Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Adjoint Limit Preservation Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Yoneda Embedding Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Fully Faithful Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Proof of the Yoneda Lemma**\nWe construct explicit inverse bijections $\\Phi: \\text{Nat}(h_A, F) \\to F(A)$ and $\\Psi: F(A) \\to \\text{Nat}(h_A, F)$ where $h_A = \\text{Hom}(A, -)$.\n$$\n\\Phi(\\alpha) = \\alpha_A(1_A) \\in F(A)\n$$\n$$\n[\\Psi(x)]_B(f) = F(f)(x) \\in F(B) \\quad (\\text{for } f: A \\to B)\n$$\nCommutativity of naturality squares forces $\\Psi(\\Phi(\\alpha)) = \\alpha$ and $\\Phi(\\Psi(x)) = x$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Yoneda Lemma bijection.",
      "orderItems": [
        "Define evaluation map Φ(α) = α_A(1_A) sending natural transformation α to element in F(A).",
        "Define reconstruction map Ψ(x)_B(f) = F(f)(x) for any x ∈ F(A) and morphism f: A -> B.",
        "Check naturality square of α for morphism f: A -> B: α_B o h_A(f) = F(f) o α_A.",
        "Apply both sides of naturality square to 1_A: α_B(f o 1_A) = F(f)(α_A(1_A)), so α_B(f) = F(f)(Φ(α)).",
        "Conclude α is COMPLETELY determined by value α_A(1_A), proving Nat(h_A, F) ≅ F(A)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What limit/colimit preservation property holds for any **Right Adjoint Functor** $R: \\mathcal{D} \\to \\mathcal{C}$ ($L \\dashv R$)?",
      "options": [
        { "text": "Right Adjoints PRESERVE LIMITS (R(lim X_i) ≅ lim R(X_i))", "isCorrect": true, "explanation": "Correct! Dual rule: Left Adjoints PRESERVE COLIMITS." },
        { "text": "Right Adjoints preserve colimits", "isCorrect": false, "explanation": "Incorrect: That describes left adjoints." },
        { "text": "Right Adjoints destroy all limits", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Right Adjoints map objects to zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: The Yoneda Embedding $\\mathcal{C} \\hookrightarrow [\\mathcal{C}^{\\text{op}}, \\text{Set}]$",
      "interactiveSteps": [
        { "stepText": "The Yoneda embedding $y: \\mathcal{C} \\to [\\mathcal{C}^{\\text{op}}, \\text{Set}]$ maps object $A \\mapsto h^A = \\text{Hom}(-, A)$." },
        {
          "prompt": "Applying the Yoneda Lemma to $F = h^B = \\text{Hom}(-, B)$ shows $\\text{Nat}(h^A, h^B) \\cong$?",
          "options": [
            { "text": "Hom(A, B)", "isCorrect": true },
            { "text": "Hom(B, A)", "isCorrect": false },
            { "text": "Set", "isCorrect": false },
            { "text": "1_A", "isCorrect": false }
          ]
        },
        { "stepText": "Since $\\text{Nat}(y(A), y(B)) \\cong \\text{Hom}(A, B)$, the Yoneda embedding is **fully faithful**!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What term describes a functor mapping Hom(A, B) bijectively onto Nat(y(A), y(B)) (injectively and surjectively on arrows)?",
      "blankAnswer": "fully faithful"
    }
  ]
}
```
