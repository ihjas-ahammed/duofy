# Key to Flow: Recurrent Neural Networks (Vanilla RNN, BPTT Decay, LSTM Gates, GRU, & Seq2Seq)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Deep_Learning_and_Neural_Networks / Recurrent_Neural_Networks_LSTM_GRU`

---

## 📌 Core Concept & Mental Model
**Temporal Recurrence ($h_t = \tanh(W_{hh} h_{t-1} + W_{xh} x_t + b)$), Backpropagation Through Time (BPTT Exponential Jacobian Decay), Long Short-Term Memory Constant Error Carousels ($C_t = f_t \odot C_{t-1} + i_t \odot \tilde{C}_t$), Gated Recurrent Units (GRU Reset/Update Gates), and Sequence-to-Sequence (Seq2Seq) Encoder-Decoder Projections** govern sequential modeling, time-series forecasting, and natural language processing (David Rumelhart et al. 1986; Paul Werbos 1990 BPTT; Sepp Hochreiter & Jürgen Schmidhuber 1997 LSTM; Kyunghyun Cho et al. 2014 GRU; Ilya Sutskever et al. 2014 Seq2Seq; Goodfellow et al. *Deep Learning* Chapter 10):
* **1. Vanilla RNN & Backpropagation Through Time (BPTT):**
  - Forward Recurrence Equation:
    $$\mathbf{h_t = \tanh\big(W_{hh} h_{t-1} + W_{xh} x_t + b_h\big) \qquad ; \qquad \mathbf{\hat{y}_t = \text{softmax}(W_{hy} h_t + b_y)}}$$
  - **The BPTT Vanishing Gradient Derivation:**
    - By the chain rule across $T$ time steps:
      $$\mathbf{\frac{\partial \mathcal{L}_T}{\partial h_1} = \frac{\partial \mathcal{L}_T}{\partial h_T} \cdot \prod_{k=2}^T \frac{\partial h_k}{\partial h_{k-1}} = \frac{\partial \mathcal{L}_T}{\partial h_T} \cdot \prod_{k=2}^T \mathbf{\Big( W_{hh}^T \text{diag}(1 - h_k^2) \Big)}}$$
    - If the largest eigenvalue of $W_{hh} < 1$ or $\tanh' \le 1$, gradients **decay exponentially to zero ($|\lambda|^T \to 0$)**, making it impossible for standard RNNs to learn dependencies longer than 10-15 time steps!
* **2. Long Short-Term Memory (LSTM - Hochreiter & Schmidhuber 1997):**
  - Solves vanishing gradients via an uninterrupted linear **Cell State ($C_t$) Constant Error Carousel**:
  - **The 4 LSTM Equations:**
    1. **Forget Gate ($f_t$ - What to discard):** $\mathbf{f_t = \sigma\big(W_f [h_{t-1}, x_t] + b_f\big)}$
    2. **Input Gate ($i_t$ - What to add):** $\mathbf{i_t = \sigma\big(W_i [h_{t-1}, x_t] + b_i\big)}$
    3. **Candidate Memory ($\tilde{C}_t$):** $\mathbf{\tilde{C}_t = \tanh\big(W_c [h_{t-1}, x_t] + b_c\big)}$
    4. **Cell State Update (Additive linear highway!):**
       $$\mathbf{C_t = \mathbf{f_t \odot C_{t-1}} \ + \ \mathbf{i_t \odot \tilde{C}_t}}$$
    5. **Output Gate & Hidden State:** $\mathbf{o_t = \sigma\big(W_o [h_{t-1}, x_t] + b_o\big) \implies \mathbf{h_t = o_t \odot \tanh(C_t)}}$
* **3. Gated Recurrent Unit (GRU - Cho et al. 2014):**
  - Streamlined architecture merging cell state and hidden state with only **2 Gates**:
    1. **Reset Gate ($r_t$):** $\mathbf{r_t = \sigma\big(W_r [h_{t-1}, x_t] + b_r\big)}$
    2. **Update Gate ($z_t$):** $\mathbf{z_t = \sigma\big(W_z [h_{t-1}, x_t] + b_z\big)}$
    3. **Candidate State ($\tilde{h}_t$):** $\mathbf{\tilde{h}_t = \tanh\big(W_h [r_t \odot h_{t-1}, x_t] + b_h\big)}$
    4. **Final State Interpolation:**
       $$\mathbf{h_t = \mathbf{(1 - z_t) \odot h_{t-1}} \ + \ \mathbf{z_t \odot \tilde{h}_t}}$$
* **4. Bidirectional RNNs & Seq2Seq Encoder-Decoder:**
  - **Bidirectional RNN (BiRNN):** Concatenates forward hidden state $\vec{h}_t$ and backward hidden state $\overleftarrow{h}_t$ to give tokens full context of past and future words.
  - **Seq2Seq:** Encoder processes input sequence into a fixed context vector $c = h_{\text{enc}}^{(T)}$; Decoder unrolls from $c$ to generate target sequence auto-regressively.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Sequence Modeling Progression
* Recurrence $\to$ Hidden State $h_t$ + BPTT Time Unrolling.
* Failure Mode $\to$ Jacobian Product $\prod W_{hh}^T \to$ Exponential Vanishing Gradients.
* Memory Fix $\to$ LSTM Cell State $C_t$ + Gating ($f_t, i_t, o_t$).
* Efficiency $\to$ GRU ($r_t, z_t$) + Linear Convex Interpolation.
* Translation $\to$ BiRNN + Seq2Seq Encoder-Decoder.

### 2. Top Recommended Resources
* **The Visual Classic:** *Understanding LSTM Networks* (Christopher Olah / colah's blog).
* **Definite Deep Learning Text:** *Deep Learning* (Goodfellow, Bengio, Courville), Chapter 10 (Sequence Modeling: Recurrent and Recursive Nets).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive why $\frac{\partial h_T}{\partial h_1} = \prod W_{hh}^T \text{diag}(1-h_k^2)$ causes exponential gradient decay?
- [ ] Can you write out the 5 core LSTM forward pass gating equations?
- [ ] Can you explain why the additive update $C_t = f_t \odot C_{t-1} + i_t \odot \tilde{C}_t$ prevents vanishing gradients?
- [ ] Can you contrast the GRU 2-gate mechanism with the LSTM 3-gate mechanism?
