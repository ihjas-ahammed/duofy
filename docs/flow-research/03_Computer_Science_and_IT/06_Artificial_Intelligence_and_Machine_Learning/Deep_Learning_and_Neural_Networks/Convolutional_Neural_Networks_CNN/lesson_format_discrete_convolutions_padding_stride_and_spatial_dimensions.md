# Duofy Reusable Lesson Format: Discrete Convolutions (Padding, Stride, and Spatial Dimensions)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Deep_Learning_and_Neural_Networks / Convolutional_Neural_Networks_CNN`  
**Lesson Format Type:** `discrete_convolutions_padding_stride_and_spatial_dimensions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the spatial mechanics, kernel dot products, and dimension transformation algebra of 2D Discrete Convolutions (LeCun et al. 1998; Goodfellow et al. *Deep Learning* Chapter 9.1; Stanford CS231n): master the **2D Cross-Correlation Operation ($\mathbf{S(i, j) = \sum_m \sum_n I(i+m, j+n) K(m, n)}$)**, evaluate the effects of **Zero-Padding ($P$)** (contrasting **"Valid" padding ($P=0$, shrinking boundary pixels)** with **"Same" padding ($P = \frac{K-1}{2}$ for odd $K$ with stride $S=1$, preserving identical spatial input dimensions $O = W$)**), analyze the step-size downsampling role of **Stride ($S \ge 1$)**, master the **Universal Spatial Output Dimension Equation ($\mathbf{O = \lfloor \frac{W - K + 2P}{S} \rfloor + 1}$)**, compute 3D tensor volume transformations ($C_{\text{in}} \times H \times W \xrightarrow{F \text{ filters of } K \times K \times C_{\text{in}}} C_{\text{out}} \times H_{\text{out}} \times W_{\text{out}}$), and calculate total learnable parameters per layer.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 2D Cross-Correlation Formula, Universal Dimension Equation $O = \lfloor \frac{W-K+2P}{S} \rfloor + 1$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Calculation of Output Feature Map Dimensions and Parameter Counts Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hyperparameter / Tensor Dimension Term & Operational Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Padding Scheme That Adds Surrounding Zeroes to Keep Output Spatial Size Equal to Input is ___ Padding (Same) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Calculation of Output Spatial Dimensions and Tensor Parameter Counts for a Concrete Convolutional Layer Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Convolution Arithmetic (Goodfellow *Deep Learning* 9.1; CS231n):
   - **The 2D Cross-Correlation Operation:**
     $$\mathbf{S(i, j) = (I * K)(i, j) = \sum_{m} \sum_{n} I(i+m, j+n) K(m, n)}$$
   - **The Universal Spatial Output Dimension Formula:**
     $$\mathbf{O = \left\lfloor \frac{W - K + 2P}{S} \right\rfloor + 1}$$
     - $W$: Input width / height.
     - $K$: Filter / Kernel spatial size.
     - $P$: Zero-padding border pixels ("Valid" $P=0$; "Same" $P = \frac{K-1}{2}$).
     - $S$: Stride step size.
   - **3D Tensor Volume Mapping:**
     $$\mathbf{(C_{\text{in}}, H, W) \xrightarrow{C_{\text{out}} \text{ filters of } (K \times K \times C_{\text{in}})} (C_{\text{out}}, H_{\text{out}}, W_{\text{out}})}$$
     - Total Parameters: $\mathbf{\text{Params} = C_{\text{out}} \times (K \cdot K \cdot C_{\text{in}} + 1)}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of computing layer output dimensions and params: (1) extract input dimensions W=224, C_in=3, and layer settings K=7, S=2, P=3, C_out=64, (2) compute effective padded input spatial size: W + 2P = 224 + 2(3) = 230, (3) subtract kernel size and divide by stride: (230 - 7) / 2 = 223 / 2 = 111.5, (4) apply floor function and add 1 to obtain output spatial dimension: floor(111.5) + 1 = 111 + 1 = 112, (5) calculate learnable parameters: 64 filters * (7 * 7 * 3 weights + 1 bias) = 64 * 148 = 9,472 total parameters!
3. **Slide 3 (`matching`):** Pair 4 terms (Kernel Size K, Stride S, Zero-Padding P, Same Padding) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that padding preserving dimensions is Same padding. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on output dimension calculation: An input image tensor of shape $(C_{\text{in}}=3, H=32, W=32)$ is passed through a convolutional layer with $64$ filters, kernel size $K = 5 \times 5$, stride $S = 1$, and "valid" zero-padding ($P = 0$). What is the exact spatial shape of the resulting output feature map $(C_{\text{out}}, H_{\text{out}}, W_{\text{out}})$ and the total number of learnable parameters (including 1 bias per filter)? (Output spatial size is $\lfloor \frac{32 - 5 + 0}{1} \rfloor + 1 = 27 + 1 = \mathbf{28 \times 28}$; with 64 filters, output tensor shape is $\mathbf{(64, 28, 28)}$; total learnable parameters = $64 \times (5 \times 5 \times 3 + 1) = 64 \times (75 + 1) = 64 \times 76 = \mathbf{4,864\text{ parameters}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "discrete_convolutions_padding_stride_and_spatial_dimensions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 2D Convolution Arithmetic \\& Tensor Dimensions**\n• **Discrete Cross-Correlation Formulation (Goodfellow *Deep Learning* 9.1):**\n$$\n\\mathbf{S(i, j) = (I * K)(i, j) = \\sum_{m=0}^{K-1} \\sum_{n=0}^{K-1} I(i+m, j+n) K(m, n)}\n$$\n• **The Universal Spatial Output Dimension Formula:**\n$$\n\\mathbf{O = \\left\\lfloor \\frac{W - K + 2P}{S} \\right\\rfloor + 1}\n$$\n$$\n\\begin{array}{|c|l|l|}\n\\hline\n\\textbf{Variable} & \\textbf{Hyperparameter Role} & \\textbf{Dimension Impact} \\\\\n\\hline\n\\mathbf{W} & \\text{Input spatial width/height} & \\text{Initial input resolution} \\\\\n\\mathbf{K} & \\text{Kernel/Filter spatial size} & \\text{Reduces output by } (K-1) \\text{ when } P=0 \\\\\n\\mathbf{P} & \\mathbf{\\text{Zero-Padding border width}} & \\mathbf{\\text{\"Same\" padding: } P = (K-1)/2 \\implies O = W} \\\\\n\\mathbf{S} & \\text{Stride traversal step size} & \\text{Downsamples spatial resolution by factor } 1/S \\\\\n\\hline\n\\end{array}\n$$\n• **Layer Parameter Formula:** $\\mathbf{\\text{Params} = C_{\\text{out}} \\times (K^2 \\cdot C_{\\text{in}} + 1)}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential mathematical steps executed to compute the output feature map shape and parameter count for a conv layer (Input: 224x224x3, K=7, S=2, P=3, 64 Filters).",
      "orderItems": [
        "Compute the effective padded input spatial dimension: W_padded = W + 2*P = 224 + 2*(3) = 230 pixels",
        "Subtract the filter kernel size from the padded dimension: W_padded - K = 230 - 7 = 223",
        "Divide the remaining span by stride S = 2 and apply floor division: floor(223 / 2) = floor(111.5) = 111",
        "Add 1 to determine the final output spatial height and width: O = 111 + 1 = 112 pixels (Shape: 64 x 112 x 112)",
        "Compute total learnable parameter count: 64 filters * (7 * 7 * 3 weights + 1 bias) = 64 * 148 = 9,472 total parameters"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Convolution Hyperparameter to its exact Functional Role.",
      "matchPairs": [
        { "left": "Kernel Size (K x K)", "right": "Spatial window dimension of the learnable sliding filter computing local dot products" },
        { "left": "Stride (S)", "right": "Number of spatial pixels the kernel slides across the input tensor at each step" },
        { "left": "Zero-Padding (P)", "right": "Border pixels of value zero added to input edges preventing spatial boundary shrinkage" },
        { "left": "Same Padding Scheme", "right": "Specific padding setting P = (K-1)/2 that perfectly preserves input spatial dimensions when S=1" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The zero-padding configuration that maintains an output spatial size identical to the input is ___ padding.",
      "blankAnswer": "same",
      "blankDistractors": ["valid", "full", "causal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An input image tensor of shape (C_in=3, H=32, W=32) is passed through a convolutional layer with 64 filters of kernel size K = 5x5, stride S = 1, and 'valid' padding (P = 0). What is the exact spatial shape of the resulting output feature tensor and the total number of learnable parameters (including 1 bias per filter)?",
      "options": [
        { "text": "Output tensor shape is (64, 28, 28) and total learnable parameters = 4,864", "isCorrect": true, "explanation": "Correct! Let's calculate both values step-by-step using standard convolution arithmetic (CS231n; Goodfellow et al. *Deep Learning* Section 9.1). 1. **Spatial Output Dimensions ($H_{\\text{out}}, W_{\\text{out}}$):** - Formula: $O = \\lfloor \\frac{W - K + 2P}{S} \\rfloor + 1$. - $O = \\lfloor \\frac{32 - 5 + 2(0)}{1} \\rfloor + 1 = 27 + 1 = \\mathbf{28}$. - Since the layer uses 64 filters, the output feature tensor shape is $\\mathbf{(64, 28, 28)}$. 2. **Learnable Parameter Count:** - Each of the 64 filters has spatial dimension $K \\times K = 5 \\times 5 = 25$. - Each filter must process all $C_{\\text{in}} = 3$ input channels: $25 \\times 3 = 75\\text{ weights}$. - Each filter has $1$ learnable additive scalar bias: $75 + 1 = 76\\text{ parameters per filter}$. - For all 64 filters: $64 \\times 76 = \\mathbf{4,864\\text{ total learnable parameters}}$!" },
        { "text": "Output tensor shape is (64, 32, 32) and total learnable parameters = 1,600", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Output tensor shape is (3, 28, 28) and total learnable parameters = 228", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Output tensor shape is (64, 16, 16) and total learnable parameters = 9,472", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
