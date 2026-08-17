# Duofy Reusable Lesson Format: Advanced Prompt Engineering (CoT, Tree-of-Thoughts, and ReAct)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Natural_Language_Processing / Large_Language_Models_LLMs_and_Prompt_Eng`  
**Lesson Format Type:** `advanced_prompt_engineering_cot_tree_of_thoughts_and_react`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the cognitive architectures, in-context computational scratchpads, and agentic reasoning loops of modern prompt engineering (Jason Wei et al. 2022, *Chain-of-Thought Prompting Elicits Reasoning in Large Language Models*, NeurIPS; Takeshi Kojima et al. 2022 Zero-Shot CoT; Shunyu Yao et al. 2022, *ReAct: Synergizing Reasoning and Acting in Language Models*, ICLR 2023; Shunyu Yao et al. 2023 Tree of Thoughts ToT): analyze why single-token answer generation fails on multi-step arithmetic and symbolic logic (as Transformer forward computation per token is constant $\mathcal{O}(1)$ layers), master **Chain-of-Thought (CoT)** prompting (generating sequential rationale tokens that act as dynamic computational working memory), master **Tree of Thoughts (ToT)** (framing problem-solving as tree search with BFS/DFS exploration, thought generation, evaluation, and backtracking), and master the **ReAct Agent Architecture** (`Thought` $\to$ `Action[Tool(query)]` $\to$ `Observation` $\to$ `Update`), analyzing how interleaving internal reasoning with external tool observation eliminates hallucinations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CoT Working Memory Proof, ToT Search Graph, & ReAct Triplet Architecture Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of an Autonomous ReAct Agent Loop with External Tools Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Prompting Paradigm / Agentic Reasoning Construct & Cognitive Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Universal Trigger Phrase Eliciting Zero-Shot Chain-of-Thought Reasoning is 'Let's think step by ___' (Step) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Generating Intermediate CoT Tokens Fundamentally Increases the Computational Capacity of Transformers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Prompt Reasoning (Wei 2022; Yao 2022; Yao 2023):
   - **The Computation per Token Bottleneck:**
     - A Transformer with $L$ layers has a fixed, finite computation depth per emitted token.
     - Direct Question $\to$ Direct Answer forces complex 10-step math into a single feed-forward pass!
   - **Chain-of-Thought (CoT) as Scratchpad:**
     - Generating $K$ reasoning tokens before the final answer provides **$K \times L$ layers of sequential computation**!
   - **The ReAct Agent Formulation (Yao et al. 2022):**
     $$\mathbf{\text{Prompt} \xrightarrow{\text{Iterate}} \mathbf{\Big[ \text{Thought } t_i \longrightarrow \text{Action } a_i \longrightarrow \text{Observation } o_i \Big]} \xrightarrow{\text{Conclude}} \text{Final Answer}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of ReAct agent loop solving "What is the age difference between the current presidents of France and the USA?": (1) emit internal Thought analyzing what facts are required, (2) output Action: Search[President of France birth year] to call external API, (3) receive environmental Observation: "Emmanuel Macron was born in 1977", (4) emit subsequent Thought: Search[President of USA birth year] and observe result, (5) synthesize final arithmetic reasoning Thought and output Final Answer!
3. **Slide 3 (`matching`):** Pair 4 concepts (Zero-Shot CoT, Few-Shot In-Context Learning, Tree of Thoughts ToT, ReAct Framework) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of trigger phrase "Let's think step by step". Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why CoT increases computational power: Why does forcing an autoregressive Transformer model to generate intermediate Chain-of-Thought (CoT) tokens (e.g. step-by-step reasoning steps) drastically improve its accuracy on complex mathematical and logical tasks compared to asking for a direct final answer? (A standard Transformer has a **fixed, constant computational depth per token determined by its depth of $L$ layers**; forcing the model to emit the final answer in the very next token restricts the calculation to a single forward pass through $L$ layers; **generating $K$ intermediate reasoning tokens allows the autoregressive model to execute $K$ sequential forward passes (effectively providing $K \times L$ layers of recurrent computational capacity)**, utilizing the generated tokens as a dynamic working memory scratchpad via causal self-attention).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "advanced_prompt_engineering_cot_tree_of_thoughts_and_react",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: In-Context Reasoning — CoT, ToT, \\& ReAct**\n• **The Computational Scratchpad Paradigm (Wei et al. NeurIPS 2022):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Prompting Technique} & \\textbf{Working Memory Mechanism} & \\textbf{Computation Depth} & \\textbf{Typical Task} \\\\\n\\hline\n\\mathbf{\\text{Direct Answer}} & \\text{Zero intermediate tokens} & L \\text{ Layers (Fixed)} & \\text{Factual retrieval} \\\\\n\\mathbf{\\text{Chain-of-Thought (CoT)}} & \\mathbf{\\text{Sequential rationale tokens}} & \\mathbf{K \\times L \\text{ Layers}} & \\mathbf{\\text{Math \\& Symbolic logic}} \\\\\n\\mathbf{\\text{Tree-of-Thoughts (ToT)}} & \\text{Tree Search + Lookahead + Backtrack} & \\text{Branching Graph} & \\text{Game of 24; Creative writing} \\\\\n\\mathbf{\\text{ReAct Architecture}} & \\mathbf{\\text{[Thought } \\to \\text{ Action } \\to \\text{ Obs] Loop}} & \\text{Dynamic Tool API} & \\mathbf{\\text{Autonomous Agent Search}} \\\\\n\\hline\n\\end{array}\n$$\n• **The ReAct Triple Formulation (Yao et al. ICLR 2023):**\n$$\n\\mathbf{\\text{History } H_t = \\big(x, t_1, a_1, o_1, \\dots, t_t\\) \\implies \\mathbf{\\text{Action } a_t = \\text{ToolName}[\\text{Query}]}}\n$$\n• **Zero-Shot CoT Invariant:** Appending *\"Let's think step by step\"* triggers **dormant reasoning paths**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed in a ReAct agent loop resolving a real-world multi-hop search query.",
      "orderItems": [
        "Receive user query and formulate an initial internal reasoning rationale: Thought 1",
        "Generate a structured external environment call: Action 1 = Search['Query string']",
        "Execute external tool/API call and inject returned real-world payload into context: Observation 1",
        "Formulate subsequent reasoning step synthesizing observation with prior context: Thought 2",
        "Determine task goal has been satisfied and output final verified response: Final Answer"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Advanced Prompting Paradigm to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Chain-of-Thought (CoT)", "right": "Generates explicit intermediate reasoning steps allowing multi-hop self-attention before reaching answer" },
        { "left": "ReAct Framework", "right": "Interleaves verbal reasoning thoughts with external tool actions and real-world environment observations" },
        { "left": "Tree of Thoughts (ToT)", "right": "Explores multiple coherent reasoning paths using breadth-first/depth-first search and self-evaluation" },
        { "left": "Few-Shot In-Context Learning", "right": "Provides input-output demonstration pairs in prompt prefix without modifying model parameter weights" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The famous trigger prompt eliciting zero-shot reasoning in Large Language Models is 'Let's think step by ___'.",
      "blankAnswer": "step",
      "blankDistractors": ["token", "word", "prompt"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does forcing an autoregressive Transformer model to generate intermediate Chain-of-Thought (CoT) tokens (step-by-step reasoning) dramatically boost accuracy on complex math problems compared to prompting for an immediate direct answer?",
      "options": [
        { "text": "A standard Transformer has a fixed, constant computational budget per generated token determined strictly by its depth of L layers; demanding a direct answer forces the model to solve the entire multi-step problem within a single forward pass of L layers; generating K intermediate reasoning tokens allows the autoregressive model to execute K sequential forward passes (effectively providing K * L layers of recurrent computational capacity), using each emitted token as an external working memory scratchpad via causal self-attention", "isCorrect": true, "explanation": "Correct! This is the computational foundation of Chain-of-Thought prompting (Jason Wei et al. NeurIPS 2022 *Chain-of-Thought Prompting Elicits Reasoning in Large Language Models*; Takeshi Kojima et al. 2022). 1. **The Single-Token Computational Barrier:** - Suppose you ask: *\"If a store sells 15 apples for $3, and buys 20 oranges at $2 each... how much profit was made?\"* - If you force the model to answer `Answer: [Token]`: - The entire 5-step algebra problem MUST be solved in **one single forward pass through $L$ Transformer layers** (e.g. 32 layers). - There is literally not enough non-linear expressive capacity in 32 layers to execute 5 sequential arithmetic operations simultaneously! 2. **The CoT Computational Expansion:** - When the model generates: *\"First, cost per apple is 3/15 = 0.20. Second, 20 oranges cost...\"* - Emitting 50 intermediate tokens means the Transformer executes **50 forward passes** ($50 \\times 32 = \\mathbf{1,600\\text{ non-linear layers of computation}}$)! 3. **The Attention Scratchpad:** - Each newly emitted token is appended to the KV cache. - Future tokens attend back to prior intermediate calculations via self-attention, functioning identically to a mathematician's scratch paper. Accuracy jumps from $17\\%$ to $>80\\%$ on benchmark reasoning datasets!" },
        { "text": "Because generating more words slows down internet latency", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Transformers can only perform math if words are written in all capital letters", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CoT prompting downloads calculator software into the GPU", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
