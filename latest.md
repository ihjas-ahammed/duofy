# What's New in v26.8.31 (Build 2127083102)

- **Instant App Update Checking**:
  - Implemented HTTP cache-busting and no-cache headers for GitHub update manifests and release endpoints, completely bypassing CDN stale caching so newly published builds appear immediately upon checking.
  - Added multi-source fallback to `latest.txt` to guarantee update availability even during CDN propagation.
- **Interactive Review Difficult Steps Mode**:
  - Transformed the completion review affordance into a fully functional, interactive **Difficult Steps Analysis & Targeted Practice** sheet.
  - Users can review missed questions, expected solutions, and explanations with full LaTeX math, then jump directly into a targeted practice session with `"Practice Missed Questions (N)"`.
  - Added zero-mistake celebration state and lesson replay options.
- **Universal LaTeX Math Rendering Across All Slides**:
  - Replaced plain text headers and labels across all slide components (`ConceptPiecesView`, `TheoryView`, `DescriptiveView`, `CodeRunnerView`, `MatchingView`, `FillInBlankView`, `InteractiveProofView`, `PyqOneWordView`) with `MathMarkdown` for consistent KaTeX formula support.
- **Mobile-Contained Canvas Art & Interactive Diagrams**:
  - Refined AI diagram generator prompts with strict mobile bounding box containment (`pad = Math.max(16, Math.min(W, H) * 0.08)`), top corner safe areas for floating overlay controls, touch hitboxes ($\ge 24\text{px}$), and anti-clipping edge alignments.
  - Optimized HTML WebView host container styling with `box-sizing: border-box`, `width: 100%`, `height: 100%`, and resilient viewport fallback calculations.
- **Live Assistant Chat Stability**:
  - Fixed a null-check error when closing Gemini Live chat by managing WebSocket stream subscriptions and guarding against post-disposal `setState` invocations.
- **Complete Slide Architecture Redesign**:
  - Floating Glassmorphism Capsule Toolbar (`SlideCapsuleToolbar`) with liquid gradient progress and streak multipliers.
  - Tactile 3D Action Buttons (`SlideActionButton`) and diagnostic misconception feedback sheets (`SlideFeedbackSheet`).
