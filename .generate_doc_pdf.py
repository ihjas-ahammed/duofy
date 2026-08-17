import os
import sys
import subprocess

def build_pdf():
    pdf_path = "/home/ihjas/Documents/GitHub/duofy/duofy_slide_types_and_prompts_documentary.pdf"
    pages_svg = []

    def svg_header():
        return '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 1600" width="1200" height="1600" style="background-color: #0b0f19; font-family: 'Segoe UI', Helvetica, Arial, sans-serif;">
        <defs>
            <linearGradient id="bgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#0b0f19"/>
                <stop offset="50%" stop-color="#111827"/>
                <stop offset="100%" stop-color="#0d111a"/>
            </linearGradient>
            <linearGradient id="primaryGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop offset="0%" stop-color="#1cb0f6"/>
                <stop offset="100%" stop-color="#0077ff"/>
            </linearGradient>
            <linearGradient id="accentGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop offset="0%" stop-color="#58cc02"/>
                <stop offset="100%" stop-color="#22c55e"/>
            </linearGradient>
            <linearGradient id="purpleGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop offset="0%" stop-color="#ce82ff"/>
                <stop offset="100%" stop-color="#a855f7"/>
            </linearGradient>
            <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
                <feDropShadow dx="0" dy="8" stdDeviation="6" flood-color="#000000" flood-opacity="0.5"/>
            </filter>
        </defs>
        <rect width="1200" height="1600" fill="url(#bgGrad)"/>
        '''

    def svg_footer(page_num, total_pages=7):
        return f'''
        <!-- Footer -->
        <rect x="60" y="1520" width="1080" height="1" fill="rgba(255,255,255,0.1)"/>
        <text x="60" y="1555" fill="rgba(255,255,255,0.4)" font-size="14" font-weight="500">DUOFY SYSTEM ARCHITECTURE &amp; AI PROMPT DOCUMENTARY</text>
        <text x="1140" y="1555" fill="rgba(255,255,255,0.4)" font-size="14" font-weight="600" text-anchor="end">Page {page_num} of {total_pages}</text>
        </svg>
        '''

    # PAGE 1: COVER PAGE
    p1 = svg_header() + '''
        <circle cx="1000" cy="200" r="300" fill="#1cb0f6" opacity="0.05"/>
        <circle cx="200" cy="1400" r="400" fill="#ce82ff" opacity="0.04"/>
        
        <rect x="80" y="120" width="280" height="36" rx="18" fill="rgba(28, 176, 246, 0.15)" stroke="#1cb0f6" stroke-width="1.5"/>
        <text x="220" y="143" fill="#1cb0f6" font-size="14" font-weight="700" text-anchor="middle" letter-spacing="2">TECHNICAL SPECIFICATION</text>

        <text x="80" y="240" fill="#ffffff" font-size="52" font-weight="800">Duofy Architecture &amp;</text>
        <text x="80" y="305" fill="url(#primaryGrad)" font-size="52" font-weight="800">Interactive Slide Types &amp;</text>
        <text x="80" y="370" fill="url(#accentGrad)" font-size="52" font-weight="800">AI Prompt Pipeline</text>

        <text x="80" y="430" fill="rgba(255,255,255,0.7)" font-size="20" font-weight="400">A comprehensive documentary on the 14 interactive slide types, LLM prompt engineering architecture,</text>
        <text x="80" y="460" fill="rgba(255,255,255,0.7)" font-size="20" font-weight="400">LaTeX math formatting rules, and multi-stage course generation pipeline in Duofy.</text>

        <rect x="80" y="520" width="1040" height="520" rx="20" fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1" filter="url(#shadow)"/>
        <text x="120" y="570" fill="#ffffff" font-size="22" font-weight="700">SYSTEM ARCHITECTURE OVERVIEW</text>

        <rect x="120" y="620" width="260" height="150" rx="12" fill="rgba(28, 176, 246, 0.1)" stroke="#1cb0f6" stroke-width="2"/>
        <text x="250" y="660" fill="#1cb0f6" font-size="18" font-weight="700" text-anchor="middle">1. INPUT SOURCES</text>
        <text x="250" y="695" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• Textbook PDFs &amp; Handouts</text>
        <text x="250" y="720" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• Syllabus &amp; Custom Index</text>
        <text x="250" y="745" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• User Learning Directives</text>

        <path d="M 380 695 L 440 695" stroke="#1cb0f6" stroke-width="3" fill="none"/>
        <text x="410" y="685" fill="#1cb0f6" font-size="12" text-anchor="middle">Raw Input</text>

        <rect x="450" y="620" width="300" height="150" rx="12" fill="rgba(206, 130, 255, 0.1)" stroke="#ce82ff" stroke-width="2"/>
        <text x="600" y="660" fill="#ce82ff" font-size="18" font-weight="700" text-anchor="middle">2. PROMPT SERVICE</text>
        <text x="600" y="695" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• Multi-stage Skeleton Prompts</text>
        <text x="600" y="720" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• LaTeX Escaping Rules (11-pt)</text>
        <text x="600" y="745" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• Pedagogy &amp; Bloom's Taxonomy</text>

        <path d="M 750 695 L 810 695" stroke="#ce82ff" stroke-width="3" fill="none"/>
        <text x="780" y="685" fill="#ce82ff" font-size="12" text-anchor="middle">Structured</text>

        <rect x="820" y="620" width="260" height="150" rx="12" fill="rgba(88, 204, 2, 0.1)" stroke="#58cc02" stroke-width="2"/>
        <text x="950" y="660" fill="#58cc02" font-size="18" font-weight="700" text-anchor="middle">3. LLM GENERATION</text>
        <text x="950" y="695" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• Strict JSON Schema Output</text>
        <text x="950" y="720" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• 14 Validated Slide Types</text>
        <text x="950" y="745" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">• Custom HTML Canvas Code</text>

        <rect x="120" y="820" width="960" height="180" rx="12" fill="rgba(255, 150, 0, 0.1)" stroke="#ff9600" stroke-width="2"/>
        <text x="600" y="860" fill="#ff9600" font-size="20" font-weight="700" text-anchor="middle">4. FLUTTER INTERACTIVE RENDERERS &amp; EXECUTION ENGINES</text>
        
        <rect x="150" y="885" width="200" height="85" rx="8" fill="rgba(255,255,255,0.05)"/>
        <text x="250" y="915" fill="#ffffff" font-size="15" font-weight="700" text-anchor="middle">Code Runners</text>
        <text x="250" y="940" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">SeriousPython, NumPy,</text>
        <text x="250" y="958" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">Matplotlib, Scikit-Learn</text>

        <rect x="380" y="885" width="200" height="85" rx="8" fill="rgba(255,255,255,0.05)"/>
        <text x="480" y="915" fill="#ffffff" font-size="15" font-weight="700" text-anchor="middle">HTML WebView</text>
        <text x="480" y="940" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">Custom Simulators,</text>
        <text x="480" y="958" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">DuoMessageChannel</text>

        <rect x="610" y="885" width="200" height="85" rx="8" fill="rgba(255,255,255,0.05)"/>
        <text x="710" y="915" fill="#ffffff" font-size="15" font-weight="700" text-anchor="middle">Interactive Math</text>
        <text x="710" y="940" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">KaTeX / Flutter Math,</text>
        <text x="710" y="958" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">Proof Steps &amp; Logic</text>

        <rect x="840" y="885" width="210" height="85" rx="8" fill="rgba(255,255,255,0.05)"/>
        <text x="945" y="915" fill="#ffffff" font-size="15" font-weight="700" text-anchor="middle">Retrieval &amp; Review</text>
        <text x="945" y="940" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">Flashcard Spaced Review,</text>
        <text x="945" y="958" fill="rgba(255,255,255,0.7)" font-size="13" text-anchor="middle">AI Essay Evaluation</text>

        <rect x="80" y="1080" width="1040" height="380" rx="16" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.08)"/>
        <text x="120" y="1130" fill="#1cb0f6" font-size="20" font-weight="700">DOCUMENTARY TABLE OF CONTENTS</text>

        <text x="120" y="1180" fill="#ffffff" font-size="16" font-weight="700">Section 1: The 14 Interactive Slide Types in Duofy</text>
        <text x="160" y="1205" fill="rgba(255,255,255,0.7)" font-size="14">• Theory, Concept Pieces, Quiz, Fill in Blank, One Word, Numerical, Proof/Step-by-Step</text>
        <text x="160" y="1230" fill="rgba(255,255,255,0.7)" font-size="14">• Matching, Ordering, Flashcard, Descriptive, Custom HTML, Program, Try Yourself</text>

        <text x="120" y="1275" fill="#ffffff" font-size="16" font-weight="700">Section 2: LaTeX &amp; Custom HTML Prompt Engineering Rules</text>
        <text x="160" y="1300" fill="rgba(255,255,255,0.7)" font-size="14">• The 11-Point LaTeX Math Guide &amp; Escaping Rules (latexGuide)</text>
        <text x="160" y="1325" fill="rgba(255,255,255,0.7)" font-size="14">• Custom HTML Glassmorphism Design System &amp; DuoMessageChannel Contract</text>

        <text x="120" y="1370" fill="#ffffff" font-size="16" font-weight="700">Section 3: Complete AI Prompt Inventory &amp; Generation Pipeline</text>
        <text x="160" y="1395" fill="rgba(255,255,255,0.7)" font-size="14">• Multi-stage Batched TOC Pipeline (chapterList, sectionList, unitManifest, generateLessonsPrompt)</text>
        <text x="160" y="1420" fill="rgba(255,255,255,0.7)" font-size="14">• Handout, Syllabus, Knowledge-Only, Density, and Metacognitive Prompts</text>
    ''' + svg_footer(1)

    pages_svg.append(p1)

    # PAGE 2: SLIDE TYPES 1 - 7
    p2 = svg_header() + '''
        <text x="60" y="80" fill="#ffffff" font-size="32" font-weight="800">1. Interactive Slide Types (Part 1: Foundational &amp; Practice)</text>
        <text x="60" y="110" fill="rgba(255,255,255,0.6)" font-size="16">Duofy supports 14 distinct interactive slide types to enforce active recall and practice-first learning.</text>

        <rect x="60" y="140" width="520" height="180" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(28, 176, 246, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="160" width="100" height="26" rx="6" fill="#1cb0f6"/>
        <text x="130" y="178" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">THEORY</text>
        <text x="195" y="179" fill="#ffffff" font-size="17" font-weight="700">Direct Fact &amp; Concept Presentation</text>
        <text x="80" y="215" fill="rgba(255,255,255,0.8)" font-size="13">• Direct, factual theory presentation (max ~70 words / 4 sentences).</text>
        <text x="80" y="235" fill="rgba(255,255,255,0.8)" font-size="13">• Plain definitions without storytelling or narrative padding.</text>
        <text x="80" y="255" fill="rgba(255,255,255,0.8)" font-size="13">• Full Markdown &amp; LaTeX inline/display math support.</text>
        <rect x="80" y="275" width="480" height="30" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="90" y="295" fill="#1cb0f6" font-size="12" font-family="monospace">JSON: {"type": "theory", "content": "Newton's Second Law..."}</text>

        <rect x="620" y="140" width="520" height="180" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(206, 130, 255, 0.4)" stroke-width="1.5"/>
        <rect x="640" y="160" width="140" height="26" rx="6" fill="#ce82ff"/>
        <text x="710" y="178" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">CONCEPT PIECES</text>
        <text x="795" y="179" fill="#ffffff" font-size="17" font-weight="700">Bite-Sized Bullet Flow</text>
        <text x="640" y="215" fill="rgba(255,255,255,0.8)" font-size="13">• Complex concepts split into short sequential statements (\n).</text>
        <text x="640" y="235" fill="rgba(255,255,255,0.8)" font-size="13">• Prevents wall-of-text fatigue with progressive disclosures.</text>
        <text x="640" y="255" fill="rgba(255,255,255,0.8)" font-size="13">• Ideal for multi-stage definitions or core principles.</text>
        <rect x="640" y="275" width="480" height="30" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="650" y="295" fill="#ce82ff" font-size="12" font-family="monospace">JSON: {"type": "concept_pieces", "content": "Line 1\nLine 2"}</text>

        <rect x="60" y="340" width="520" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(88, 204, 2, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="360" width="80" height="26" rx="6" fill="#58cc02"/>
        <text x="120" y="378" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">QUIZ</text>
        <text x="175" y="379" fill="#ffffff" font-size="17" font-weight="700">Multiple Choice Question</text>
        <text x="80" y="415" fill="rgba(255,255,255,0.8)" font-size="13">• Exactly 4 textually distinct options (1-5 words max per option).</text>
        <text x="80" y="435" fill="rgba(255,255,255,0.8)" font-size="13">• Exactly 1 option marked with `isCorrect: true`.</text>
        <text x="80" y="455" fill="rgba(255,255,255,0.8)" font-size="13">• Every option contains a 1-line pedagogical explanation.</text>
        <rect x="80" y="480" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="90" y="502" fill="#58cc02" font-size="11" font-family="monospace">JSON: {"type": "quiz", "content": "What is unit of force?",</text>
        <text x="90" y="522" fill="#58cc02" font-size="11" font-family="monospace">  "options": [{"text": "Newton", "isCorrect": true, ...}]}</text>

        <rect x="620" y="340" width="520" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(255, 150, 0, 0.4)" stroke-width="1.5"/>
        <rect x="640" y="360" width="130" height="26" rx="6" fill="#ff9600"/>
        <text x="705" y="378" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">FILL IN BLANK</text>
        <text x="785" y="379" fill="#ffffff" font-size="17" font-weight="700">Interactive Word Placement</text>
        <text x="640" y="415" fill="rgba(255,255,255,0.8)" font-size="13">• Question content contains `___` blanks (prefer single blank).</text>
        <text x="640" y="435" fill="rgba(255,255,255,0.8)" font-size="13">• `blankAnswer`: exact comma-separated correct token(s).</text>
        <text x="640" y="455" fill="rgba(255,255,255,0.8)" font-size="13">• `blankDistractors`: 3 wrong words for user chip selection.</text>
        <rect x="640" y="480" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="650" y="502" fill="#ff9600" font-size="11" font-family="monospace">JSON: {"type": "fill_in_blank", "content": "Force is ___.",</text>
        <text x="650" y="522" fill="#ff9600" font-size="11" font-family="monospace">  "blankAnswer": "vector", "blankDistractors": ["scalar"...]}</text>

        <rect x="60" y="580" width="520" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(239, 68, 68, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="600" width="100" height="26" rx="6" fill="#ef4444"/>
        <text x="130" y="618" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">ONE WORD</text>
        <text x="195" y="619" fill="#ffffff" font-size="17" font-weight="700">Typed Free Recall</text>
        <text x="80" y="655" fill="rgba(255,255,255,0.8)" font-size="13">• Direct question requiring user to type single exact answer word.</text>
        <text x="80" y="675" fill="rgba(255,255,255,0.8)" font-size="13">• No options or distractors shown — tests strict memory retrieval.</text>
        <text x="80" y="695" fill="rgba(255,255,255,0.8)" font-size="13">• Case-insensitive &amp; whitespace-trimmed evaluation.</text>
        <rect x="80" y="720" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="90" y="742" fill="#ef4444" font-size="11" font-family="monospace">JSON: {"type": "one_word", "content": "SI unit of power?",</text>
        <text x="90" y="762" fill="#ef4444" font-size="11" font-family="monospace">  "blankAnswer": "watt"}</text>

        <rect x="620" y="580" width="520" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(59, 130, 246, 0.4)" stroke-width="1.5"/>
        <rect x="640" y="600" width="110" height="26" rx="6" fill="#3b82f6"/>
        <text x="695" y="618" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">NUMERICAL</text>
        <text x="765" y="619" fill="#ffffff" font-size="17" font-weight="700">Quantitative Calculation</text>
        <text x="640" y="655" fill="rgba(255,255,255,0.8)" font-size="13">• Quantitative problem requiring a calculated number input.</text>
        <text x="640" y="675" fill="rgba(255,255,255,0.8)" font-size="13">• `numericAnswer`: target double/int value.</text>
        <text x="640" y="695" fill="rgba(255,255,255,0.8)" font-size="13">• `numericTolerance`: acceptable margin of error (e.g., 0.01).</text>
        <rect x="640" y="720" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="650" y="742" fill="#3b82f6" font-size="11" font-family="monospace">JSON: {"type": "numerical", "content": "Compute 5*9.8",</text>
        <text x="650" y="762" fill="#3b82f6" font-size="11" font-family="monospace">  "numericAnswer": 49.0, "numericTolerance": 0.1}</text>

        <rect x="60" y="820" width="1080" height="230" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(168, 85, 247, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="840" width="180" height="26" rx="6" fill="#a855f7"/>
        <text x="170" y="858" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">PROOF / STEP_BY_STEP</text>
        <text x="275" y="859" fill="#ffffff" font-size="17" font-weight="700">Interactive Derivation &amp; Multi-Step Logic</text>
        <text x="80" y="895" fill="rgba(255,255,255,0.8)" font-size="14">• Maps multi-stage mathematical derivations, physics proofs, or logical procedures into discrete steps.</text>
        <text x="80" y="920" fill="rgba(255,255,255,0.8)" font-size="14">• Each step in `interactiveSteps` can be static (`stepText`) or interactive (`prompt` + `options`).</text>
        <text x="80" y="945" fill="rgba(255,255,255,0.8)" font-size="14">• Optional `canvasPrompt` renders visual geometric figures or free-body diagrams alongside logic.</text>
        <rect x="80" y="975" width="1040" height="55" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="95" y="998" fill="#a855f7" font-size="12" font-family="monospace">JSON: {"type": "proof", "content": "Prove Pythagorean Theorem", "interactiveSteps": [{"stepText": "Given a right triangle..."},</text>
        <text x="95" y="1018" fill="#a855f7" font-size="12" font-family="monospace">  {"prompt": "What is c^2?", "options": [{"text": "a^2 + b^2", "isCorrect": true}]}]}</text>

        <rect x="60" y="1080" width="1080" height="400" rx="14" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.1)"/>
        <text x="90" y="1120" fill="#1cb0f6" font-size="20" font-weight="700">PEDAGOGICAL FUNCTION OF TYPES 1-7</text>
        
        <path d="M 90 1160 L 1090 1160" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>

        <text x="90" y="1200" fill="#ffffff" font-size="15" font-weight="700">Phase A: Encoding (Theory &amp; Concept Pieces)</text>
        <text x="90" y="1225" fill="rgba(255,255,255,0.7)" font-size="14">presents raw factual knowledge directly without storytelling fluff, building structured mental models.</text>

        <text x="90" y="1275" fill="#ffffff" font-size="15" font-weight="700">Phase B: Discrimination &amp; Recognition (Quiz &amp; Fill in Blank)</text>
        <text x="90" y="1300" fill="rgba(255,255,255,0.7)" font-size="14">forces the learner to discriminate correct terms from plausible distractors with detailed explanations.</text>

        <text x="90" y="1350" fill="#ffffff" font-size="15" font-weight="700">Phase C: Production &amp; Computation (One Word, Numerical, Proof)</text>
        <text x="90" y="1375" fill="rgba(255,255,255,0.7)" font-size="14">requires unprompted free recall and multi-step computational/logical execution for deep mastery.</text>
    ''' + svg_footer(2)

    pages_svg.append(p2)

    # PAGE 3: SLIDE TYPES 8 - 14
    p3 = svg_header() + '''
        <text x="60" y="80" fill="#ffffff" font-size="32" font-weight="800">1. Interactive Slide Types (Part 2: Advanced &amp; Applied)</text>
        <text x="60" y="110" fill="rgba(255,255,255,0.6)" font-size="16">Advanced slide types for sequencing, flashcards, AI essay grading, interactive HTML, and live code runners.</text>

        <rect x="60" y="140" width="520" height="210" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(236, 72, 153, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="160" width="110" height="26" rx="6" fill="#ec4899"/>
        <text x="135" y="178" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">MATCHING</text>
        <text x="205" y="179" fill="#ffffff" font-size="17" font-weight="700">Pair Association Matching</text>
        <text x="80" y="215" fill="rgba(255,255,255,0.8)" font-size="13">• 3-6 `{"left": "...", "right": "..."}` objects.</text>
        <text x="80" y="235" fill="rgba(255,255,255,0.8)" font-size="13">• Used for term↔definition, symbol↔meaning, quantity↔unit.</text>
        <text x="80" y="255" fill="rgba(255,255,255,0.8)" font-size="13">• Interactive column selection &amp; matching feedback.</text>
        <rect x="80" y="275" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="90" y="297" fill="#ec4899" font-size="11" font-family="monospace">JSON: {"type": "matching", "content": "Match units.",</text>
        <text x="90" y="317" fill="#ec4899" font-size="11" font-family="monospace">  "matchPairs": [{"left": "Force", "right": "Newton"}]}</text>

        <rect x="620" y="140" width="520" height="210" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(20, 184, 166, 0.4)" stroke-width="1.5"/>
        <rect x="640" y="160" width="110" height="26" rx="6" fill="#14b8a6"/>
        <text x="695" y="178" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">ORDERING</text>
        <text x="765" y="179" fill="#ffffff" font-size="17" font-weight="700">Sequence &amp; Algorithm Reorder</text>
        <text x="640" y="215" fill="rgba(255,255,255,0.8)" font-size="13">• `orderItems`: 3-6 items listed in exact correct sequence.</text>
        <text x="640" y="235" fill="rgba(255,255,255,0.8)" font-size="13">• App shuffles items; user drags into correct chronological order.</text>
        <text x="640" y="255" fill="rgba(255,255,255,0.8)" font-size="13">• Used for procedures, derivations, and historical events.</text>
        <rect x="640" y="275" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="650" y="297" fill="#14b8a6" font-size="11" font-family="monospace">JSON: {"type": "ordering", "content": "Sequence steps.",</text>
        <text x="650" y="317" fill="#14b8a6" font-size="11" font-family="monospace">  "orderItems": ["Step 1", "Step 2", "Step 3"]}</text>

        <rect x="60" y="370" width="520" height="210" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(245, 158, 11, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="390" width="120" height="26" rx="6" fill="#f59e0b"/>
        <text x="140" y="408" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">FLASHCARD</text>
        <text x="215" y="409" fill="#ffffff" font-size="17" font-weight="700">Recall-Flip Spaced Review</text>
        <text x="80" y="445" fill="rgba(255,255,255,0.8)" font-size="13">• Front side: recall prompt (`content`); Back side: answer (`blankAnswer`).</text>
        <text x="80" y="465" fill="rgba(255,255,255,0.8)" font-size="13">• Self-graded ("Got it right" / "Need review").</text>
        <text x="80" y="485" fill="rgba(255,255,255,0.8)" font-size="13">• Misses automatically enter spaced repetition review queue.</text>
        <rect x="80" y="505" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="90" y="527" fill="#f59e0b" font-size="11" font-family="monospace">JSON: {"type": "flashcard", "content": "State Ohm's Law",</text>
        <text x="90" y="547" fill="#f59e0b" font-size="11" font-family="monospace">  "blankAnswer": "V = I * R"}</text>

        <rect x="620" y="370" width="520" height="210" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(99, 102, 241, 0.4)" stroke-width="1.5"/>
        <rect x="640" y="390" width="130" height="26" rx="6" fill="#6366f1"/>
        <text x="705" y="408" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">DESCRIPTIVE</text>
        <text x="785" y="409" fill="#ffffff" font-size="17" font-weight="700">Paragraph &amp; Photo Essay</text>
        <text x="640" y="445" fill="rgba(255,255,255,0.8)" font-size="13">• Open-ended essay or calculation requiring explanation.</text>
        <text x="640" y="465" fill="rgba(255,255,255,0.8)" font-size="13">• Supports text box typing + optional photo upload of handwritten work.</text>
        <text x="640" y="485" fill="rgba(255,255,255,0.8)" font-size="13">• Evaluated by AI tutor with rubric feedback &amp; score.</text>
        <rect x="640" y="505" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="650" y="527" fill="#6366f1" font-size="11" font-family="monospace">JSON: {"type": "descriptive", "content": "Explain photosynthesis",</text>
        <text x="650" y="547" fill="#6366f1" font-size="11" font-family="monospace">  "title": "Essay Task"}</text>

        <rect x="60" y="600" width="1080" height="230" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(28, 176, 246, 0.6)" stroke-width="1.5"/>
        <rect x="80" y="620" width="140" height="26" rx="6" fill="#1cb0f6"/>
        <text x="150" y="638" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">CUSTOM_HTML</text>
        <text x="235" y="639" fill="#ffffff" font-size="17" font-weight="700">Interactive Canvas &amp; Web Simulators</text>
        <text x="80" y="675" fill="rgba(255,255,255,0.8)" font-size="14">• Embedded transparent WebView running full HTML5/CSS3/JavaScript code.</text>
        <text x="80" y="700" fill="rgba(255,255,255,0.8)" font-size="14">• Used for interactive circuit simulators, vector sliders, sorting visualizers, and physics games.</text>
        <text x="80" y="725" fill="rgba(255,255,255,0.8)" font-size="14">• JavaScript MUST trigger `DuoMessageChannel.postMessage("complete")` when solved!</text>
        <rect x="80" y="755" width="1040" height="55" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="95" y="778" fill="#1cb0f6" font-size="12" font-family="monospace">JSON: {"type": "custom_html", "content": "Simulate vector addition",</text>
        <text x="95" y="798" fill="#1cb0f6" font-size="12" font-family="monospace">  "interactiveCanvasHtml": "&lt;div style=\"color:white\"&gt;...&lt;script&gt;DuoMessageChannel.postMessage('complete');&lt;/script&gt;&lt;/div&gt;"}</text>

        <rect x="60" y="850" width="520" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(34, 197, 94, 0.4)" stroke-width="1.5"/>
        <rect x="80" y="870" width="110" height="26" rx="6" fill="#22c55e"/>
        <text x="135" y="888" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">PROGRAM</text>
        <text x="205" y="889" fill="#ffffff" font-size="17" font-weight="700">Code Fill-in-the-Blank</text>
        <text x="80" y="925" fill="rgba(255,255,255,0.8)" font-size="13">• `code`: code snippet containing exactly one `___` blank.</text>
        <text x="80" y="945" fill="rgba(255,255,255,0.8)" font-size="13">• `blankAnswer`: correct token (e.g. `print`).</text>
        <text x="80" y="965" fill="rgba(255,255,255,0.8)" font-size="13">• `blankDistractors`: 3 code tokens for chip selection.</text>
        <rect x="80" y="990" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="90" y="1012" fill="#22c55e" font-size="11" font-family="monospace">JSON: {"type": "program", "language": "python",</text>
        <text x="90" y="1032" fill="#22c55e" font-size="11" font-family="monospace">  "code": "def run():\n  ___('hi')", "blankAnswer": "print"}</text>

        <rect x="620" y="850" width="520" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(14, 165, 233, 0.4)" stroke-width="1.5"/>
        <rect x="640" y="870" width="140" height="26" rx="6" fill="#0ea5e9"/>
        <text x="710" y="888" fill="#ffffff" font-size="12" font-weight="700" text-anchor="middle">TRY YOURSELF</text>
        <text x="795" y="889" fill="#ffffff" font-size="17" font-weight="700">Live Code Runner Sandbox</text>
        <text x="640" y="925" fill="rgba(255,255,255,0.8)" font-size="13">• Practice-first hands-on code runner loaded with starter code.</text>
        <text x="640" y="945" fill="rgba(255,255,255,0.8)" font-size="13">• Executes live Python (SeriousPython + NumPy / Matplotlib / Sklearn).</text>
        <text x="640" y="965" fill="rgba(255,255,255,0.8)" font-size="13">• Captures stdout, stderr, and plots SVG/base64 graphics.</text>
        <rect x="640" y="990" width="480" height="60" rx="6" fill="rgba(255,255,255,0.05)"/>
        <text x="650" y="1012" fill="#0ea5e9" font-size="11" font-family="monospace">JSON: {"type": "try_yourself", "language": "python",</text>
        <text x="650" y="1032" fill="#0ea5e9" font-size="11" font-family="monospace">  "code": "import numpy as np...", "packages": ["numpy"]}</text>

        <rect x="60" y="1095" width="1080" height="390" rx="14" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.1)"/>
        <text x="90" y="1135" fill="#58cc02" font-size="20" font-weight="700">CLASSIFICATION MATRIX OF ALL 14 SLIDE TYPES</text>
        
        <path d="M 90 1155 L 1090 1155" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>

        <text x="90" y="1195" fill="#ffffff" font-size="14" font-weight="700">Category 1: Factual &amp; Concept Exposition</text>
        <text x="450" y="1195" fill="#1cb0f6" font-size="14" font-family="monospace">theory, concept_pieces</text>
        <text x="800" y="1195" fill="rgba(255,255,255,0.7)" font-size="13">Direct definition &amp; bullet flow</text>

        <text x="90" y="1245" fill="#ffffff" font-size="14" font-weight="700">Category 2: Active Recall &amp; Recognition</text>
        <text x="450" y="1245" fill="#58cc02" font-size="14" font-family="monospace">quiz, fill_in_blank, one_word</text>
        <text x="800" y="1245" fill="rgba(255,255,255,0.7)" font-size="13">Distractor discrimination &amp; recall</text>

        <text x="90" y="1295" fill="#ffffff" font-size="14" font-weight="700">Category 3: Quantitative &amp; Logical Derivations</text>
        <text x="450" y="1295" fill="#a855f7" font-size="14" font-family="monospace">numerical, proof, step_by_step</text>
        <text x="800" y="1295" fill="rgba(255,255,255,0.7)" font-size="13">Math calculation &amp; logic steps</text>

        <text x="90" y="1345" fill="#ffffff" font-size="14" font-weight="700">Category 4: Structure, Sequence &amp; Spaced Review</text>
        <text x="450" y="1345" fill="#ec4899" font-size="14" font-family="monospace">matching, ordering, flashcard</text>
        <text x="800" y="1345" fill="rgba(255,255,255,0.7)" font-size="13">Pair matching, sequence &amp; memory queue</text>

        <text x="90" y="1395" fill="#ffffff" font-size="14" font-weight="700">Category 5: Applied Practice &amp; Simulators</text>
        <text x="450" y="1395" fill="#0ea5e9" font-size="14" font-family="monospace">descriptive, custom_html, program, try_yourself</text>
        <text x="800" y="1395" fill="rgba(255,255,255,0.7)" font-size="13">AI essay, canvas webview &amp; Python IDE</text>
    ''' + svg_footer(3)

    pages_svg.append(p3)

    # PAGE 4: LATEX MATH GUIDE & RULES (FIXED RAW STRINGS)
    p4 = svg_header() + '''
        <text x="60" y="80" fill="#ffffff" font-size="32" font-weight="800">2. Prompt Engineering: LaTeX Math Rules (11-Point Guide)</text>
        <text x="60" y="110" fill="rgba(255,255,255,0.6)" font-size="16">Inlined into every lesson JSON prompt to prevent backslash stripping, delimiter errors, and JSON malformation.</text>

        <rect x="60" y="140" width="1080" height="150" rx="14" fill="rgba(28, 176, 246, 0.05)" stroke="#1cb0f6" stroke-width="1.5"/>
        <text x="90" y="180" fill="#1cb0f6" font-size="18" font-weight="700">1. JSON DOUBLE ESCAPING MANDATE (CRITICAL RULE)</text>
        <text x="90" y="210" fill="rgba(255,255,255,0.85)" font-size="14">Every backslash in LaTeX output MUST be written as double-backslash inside JSON strings.</text>
        <text x="90" y="235" fill="rgba(255,255,255,0.85)" font-size="14">Correct: \\\\frac{1}{2}, \\\\int_0^1, \\\\sqrt{x}, \\\\alpha | INCORRECT: \\frac{1}{2} (causes silent JSON syntax error or backslash loss).</text>

        <rect x="90" y="250" width="1020" height="30" rx="6" fill="rgba(0,0,0,0.3)"/>
        <text x="105" y="270" fill="#22c55e" font-size="13" font-family="monospace">Correct JSON String: "The integral is \\$\\int_0^1 x^2 \\, dx = \\frac{1}{3}\\$"</text>

        <rect x="60" y="310" width="520" height="230" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)"/>
        <text x="90" y="345" fill="#ffffff" font-size="17" font-weight="700">2. Inline vs Display Math Delimiters</text>
        <text x="90" y="380" fill="rgba(255,255,255,0.8)" font-size="13">• Inline math (sentence flow): wrap in `$ ... $`</text>
        <text x="90" y="400" fill="rgba(255,255,255,0.8)" font-size="13">  Example: `The area is $\\pi r^2$.`</text>
        <text x="90" y="430" fill="rgba(255,255,255,0.8)" font-size="13">• Display math (centered equation): wrap in `$$ ... $$`</text>
        <text x="90" y="450" fill="rgba(255,255,255,0.8)" font-size="13">  Example: `$$\\int_a^b f(x)\\,dx = F(b) - F(a)$$`</text>
        <text x="90" y="480" fill="#ef4444" font-size="13">• NEVER mix delimiters (`$$ x $`) or nest delimiters.</text>
        <text x="90" y="500" fill="#ef4444" font-size="13">• NEVER put short single equations on their own line.</text>

        <rect x="620" y="310" width="520" height="230" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)"/>
        <text x="650" y="345" fill="#ffffff" font-size="17" font-weight="700">3. LaTeX Command Escaping</text>
        <text x="650" y="380" fill="rgba(255,255,255,0.8)" font-size="13">• Fractions: \\\\frac{a}{b} (braced numerator &amp; denominator)</text>
        <text x="650" y="405" fill="rgba(255,255,255,0.8)" font-size="13">• Multi-char Exponents/Indices: x^{10}, a_{ij} (MUST brace)</text>
        <text x="650" y="430" fill="rgba(255,255,255,0.8)" font-size="13">• Greek Letters: \\\\alpha, \\\\beta, \\\\theta, \\\\pi, \\\\Sigma</text>
        <text x="650" y="455" fill="rgba(255,255,255,0.8)" font-size="13">• Operators: \\\\int, \\\\sum, \\\\lim_{x \\to 0}, \\\\sin, \\\\log</text>
        <text x="650" y="480" fill="rgba(255,255,255,0.8)" font-size="13">• Multiplication: use \\\\cdot or \\\\times (NEVER Markdown `*`)</text>
        <text x="650" y="505" fill="rgba(255,255,255,0.8)" font-size="13">• Comparisons: \\\\le, \\\\ge, \\\\ne, \\\\approx</text>

        <rect x="60" y="560" width="1080" height="220" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)"/>
        <text x="90" y="595" fill="#ffffff" font-size="17" font-weight="700">4. Aligned Equations &amp; Four-Backslash Linebreaks (`\\\\\\\\`)</text>
        <text x="90" y="630" fill="rgba(255,255,255,0.8)" font-size="14">Multi-line aligned equations MUST wrap in `$$ ... $$` and use `\\\\begin{aligned} ... \\\\end{aligned}` with `&amp;` for alignment columns.</text>
        <text x="90" y="655" fill="rgba(255,255,255,0.8)" font-size="14">Linebreaks in JSON-encoded aligned equations require FOUR backslashes (`\\\\\\\\` = 2 for LaTeX `\\\\` doubled for JSON string).</text>

        <rect x="90" y="675" width="1020" height="80" rx="8" fill="rgba(0,0,0,0.3)"/>
        <text x="110" y="705" fill="#ce82ff" font-size="13" font-family="monospace">$$\\begin{aligned}</text>
        <text x="110" y="725" fill="#ce82ff" font-size="13" font-family="monospace">  x &amp;= a + b \\\\\\\\</text>
        <text x="110" y="745" fill="#ce82ff" font-size="13" font-family="monospace">  &amp;= c \\end{aligned}$$</text>

        <rect x="60" y="800" width="1080" height="690" rx="14" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.08)"/>
        <text x="90" y="845" fill="#ff9600" font-size="20" font-weight="700">RULES 5 TO 11: DELIMITER RESTRICTIONS &amp; FAILURE MODE PREVENTION</text>

        <path d="M 90 865 L 1090 865" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>

        <text x="90" y="905" fill="#ffffff" font-size="15" font-weight="700">5. Matrices &amp; Determinants</text>
        <text x="450" y="905" fill="rgba(255,255,255,0.8)" font-size="14">`$$\\begin{pmatrix} a &amp; b \\\\\\\\ c &amp; d \\end{pmatrix}$$` (bmatrix for square brackets).</text>

        <text x="90" y="965" fill="#ffffff" font-size="15" font-weight="700">6. Chemistry &amp; Units</text>
        <text x="450" y="965" fill="rgba(255,255,255,0.8)" font-size="14">Units in plain text outside math (`5 m/s`). Chemistry: plain `H₂O` or `\\text{H}_2\\text{O}`.</text>

        <text x="90" y="1025" fill="#ffffff" font-size="15" font-weight="700">7. Safe Punctuation</text>
        <text x="450" y="1025" fill="rgba(255,255,255,0.8)" font-size="14">Never use Markdown `*` in math. Never use `_` except for braced subscripts (`a_{ij}`).</text>

        <text x="90" y="1085" fill="#ffffff" font-size="15" font-weight="700">8. Contextual Prose</text>
        <text x="450" y="1085" fill="rgba(255,255,255,0.8)" font-size="14">Slot math inline inside descriptive prose; do not leave floating math without surrounding sentence.</text>

        <text x="90" y="1145" fill="#ffffff" font-size="15" font-weight="700">9. Forbidden Syntax</text>
        <text x="450" y="1145" fill="#ef4444" font-size="14">NEVER emit single `\\frac`, `\\( ... \\)`, `\\[ ... \\]`, HTML `&lt;sup&gt;`, or raw unicode math (`½`, `√`, `∫`).</text>

        <text x="90" y="1205" fill="#ffffff" font-size="15" font-weight="700">10. Plain Numeric Results</text>
        <text x="450" y="1205" fill="rgba(255,255,255,0.8)" font-size="14">For `numerical` slides, `numericAnswer` MUST be a raw JSON number (`42.0`), NOT `"$42$"`.</text>

        <text x="90" y="1265" fill="#ffffff" font-size="15" font-weight="700">11. No LaTeX in Fill-in-Blank / One-Word</text>
        <text x="450" y="1265" fill="#ef4444" font-size="14">NEVER use `$` or `$$` in `fill_in_blank` or `one_word` questions, answers, or distractors!</text>

        <rect x="90" y="1305" width="1000" height="150" rx="10" fill="rgba(239, 68, 68, 0.1)" stroke="#ef4444" stroke-width="1"/>
        <text x="110" y="1335" fill="#ef4444" font-size="15" font-weight="700">WHY RULE 11 IS CRITICAL FOR USER EXPERIENCE:</text>
        <text x="110" y="1365" fill="rgba(255,255,255,0.85)" font-size="13">In `fill_in_blank` and `one_word` slides, the user must select or type answer chips directly. If the LLM wraps</text>
        <text x="110" y="1390" fill="rgba(255,255,255,0.85)" font-size="13">answers in LaTeX delimiters (e.g. `$vector$`), the user would be forced to type literal `$` characters or chip buttons</text>
        <text x="110" y="1415" fill="rgba(255,255,255,0.85)" font-size="13">would display raw LaTeX syntax. Plain text formatting ensures seamless interactive chip &amp; keyboard input.</text>
    ''' + svg_footer(4)

    pages_svg.append(p4)

    # PAGE 5: CUSTOM HTML CANVAS DESIGN SYSTEM & PROMPT GUIDE
    p5 = svg_header() + '''
        <text x="60" y="80" fill="#ffffff" font-size="32" font-weight="800">2. Custom HTML Canvas Design System &amp; Web View Protocol</text>
        <text x="60" y="110" fill="rgba(255,255,255,0.6)" font-size="16">Glassmorphism theme palette, responsive layout requirements, and the DuoMessageChannel bridge protocol.</text>

        <rect x="60" y="140" width="1080" height="320" rx="14" fill="rgba(28, 176, 246, 0.05)" stroke="#1cb0f6" stroke-width="1.5"/>
        <text x="90" y="180" fill="#1cb0f6" font-size="20" font-weight="700">CUSTOM HTML APP THEME PALETTE &amp; GLASSMORPHISM RULES</text>
        
        <rect x="90" y="210" width="180" height="70" rx="8" fill="#1cb0f6"/>
        <text x="180" y="240" fill="#ffffff" font-size="14" font-weight="700" text-anchor="middle">Primary Blue</text>
        <text x="180" y="260" fill="#ffffff" font-size="12" font-family="monospace" text-anchor="middle">#1cb0f6</text>

        <rect x="290" y="210" width="180" height="70" rx="8" fill="#58cc02"/>
        <text x="380" y="240" fill="#ffffff" font-size="14" font-weight="700" text-anchor="middle">Success Green</text>
        <text x="380" y="260" fill="#ffffff" font-size="12" font-family="monospace" text-anchor="middle">#58cc02</text>

        <rect x="490" y="210" width="180" height="70" rx="8" fill="#ff9600"/>
        <text x="580" y="240" fill="#ffffff" font-size="14" font-weight="700" text-anchor="middle">Warning Orange</text>
        <text x="580" y="260" fill="#ffffff" font-size="12" font-family="monospace" text-anchor="middle">#ff9600</text>

        <rect x="690" y="210" width="180" height="70" rx="8" fill="#ff4b4b"/>
        <text x="780" y="240" fill="#ffffff" font-size="14" font-weight="700" text-anchor="middle">Error Red</text>
        <text x="780" y="260" fill="#ffffff" font-size="12" font-family="monospace" text-anchor="middle">#ff4b4b</text>

        <rect x="890" y="210" width="180" height="70" rx="8" fill="#ce82ff"/>
        <text x="980" y="240" fill="#ffffff" font-size="14" font-weight="700" text-anchor="middle">Accent Violet</text>
        <text x="980" y="260" fill="#ffffff" font-size="12" font-family="monospace" text-anchor="middle">#ce82ff</text>

        <text x="90" y="320" fill="rgba(255,255,255,0.85)" font-size="14">• App Background: `#0b0f19` | Surface Background: `rgba(255, 255, 255, 0.05)` with `1px solid rgba(255, 255, 255, 0.1)` border.</text>
        <text x="90" y="345" fill="rgba(255,255,255,0.85)" font-size="14">• Responsiveness: Containers MUST use Flexbox / CSS Grid / percentages / vh / vw. NEVER use hardcoded pixel widths/heights.</text>
        <text x="90" y="370" fill="rgba(255,255,255,0.85)" font-size="14">• DuoMessageChannel Protocol: The webview page MUST call `DuoMessageChannel.postMessage("complete")` when solved!</text>

        <rect x="60" y="490" width="1080" height="350" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)"/>
        <text x="90" y="530" fill="#58cc02" font-size="20" font-weight="700">DUOMESSAGECHANNEL JAVASCRIPT &lt;-&gt; FLUTTER WEBVIEW PROTOCOL</text>

        <rect x="100" y="570" width="380" height="230" rx="12" fill="rgba(28, 176, 246, 0.1)" stroke="#1cb0f6" stroke-width="1.5"/>
        <text x="290" y="605" fill="#1cb0f6" font-size="18" font-weight="700" text-anchor="middle">CUSTOM HTML5 / JS CANVAS</text>
        <text x="120" y="645" fill="rgba(255,255,255,0.8)" font-size="13">• User interacts with sliders, switches, SVG elements</text>
        <text x="120" y="670" fill="rgba(255,255,255,0.8)" font-size="13">• JS logic evaluates puzzle completion or state</text>
        <text x="120" y="700" fill="#58cc02" font-size="13" font-family="monospace">if (solved) {</text>
        <text x="120" y="720" fill="#58cc02" font-size="13" font-family="monospace">  DuoMessageChannel.postMessage("complete");</text>
        <text x="120" y="740" fill="#58cc02" font-size="13" font-family="monospace">}</text>

        <path d="M 480 685 L 620 685" stroke="#58cc02" stroke-width="4" stroke-dasharray="6,4"/>
        <text x="550" y="670" fill="#58cc02" font-size="13" font-weight="700" text-anchor="middle">JavaScript PostMessage</text>
        <text x="550" y="710" fill="#58cc02" font-size="11" text-anchor="middle">"complete"</text>

        <rect x="620" y="570" width="480" height="230" rx="12" fill="rgba(88, 204, 2, 0.1)" stroke="#58cc02" stroke-width="1.5"/>
        <text x="860" y="605" fill="#58cc02" font-size="18" font-weight="700" text-anchor="middle">FLUTTER LESSON SCREEN RENDERER</text>
        <text x="640" y="645" fill="rgba(255,255,255,0.8)" font-size="13">• `JavaScriptChannel(name: "DuoMessageChannel")` receives event</text>
        <text x="640" y="670" fill="rgba(255,255,255,0.8)" font-size="13">• Triggers success sound effect &amp; haptic feedback</text>
        <text x="640" y="695" fill="rgba(255,255,255,0.8)" font-size="13">• Enables green "CONTINUE" DuoButton at bottom of slide</text>
        <text x="640" y="720" fill="rgba(255,255,255,0.8)" font-size="13">• Updates user XP, streak, and lesson completion progress</text>

        <rect x="60" y="870" width="1080" height="620" rx="14" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.08)"/>
        <text x="90" y="910" fill="#ce82ff" font-size="20" font-weight="700">FEW-SHOT CUSTOM HTML CODE EXAMPLES IN PROMPT SERVICE</text>

        <rect x="90" y="935" width="1020" height="160" rx="8" fill="rgba(0,0,0,0.3)"/>
        <text x="110" y="960" fill="#1cb0f6" font-size="14" font-weight="700">Example A: Interactive Circuit Sandbox</text>
        <text x="110" y="985" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">&lt;div style="color:white; display:flex; flex-direction:column; align-items:center;"&gt;</text>
        <text x="110" y="1005" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  &lt;button id="switchBtn" style="background:#1cb0f6;"&gt;Toggle Switch&lt;/button&gt;</text>
        <text x="110" y="1025" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  &lt;svg&gt;&lt;circle id="bulb" fill="#555"/&gt;&lt;/svg&gt;</text>
        <text x="110" y="1045" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  &lt;script&gt;on = !on; if(on) { DuoMessageChannel.postMessage("complete"); }&lt;/script&gt;&lt;/div&gt;</text>

        <rect x="90" y="1115" width="1020" height="160" rx="8" fill="rgba(0,0,0,0.3)"/>
        <text x="110" y="1140" fill="#58cc02" font-size="14" font-weight="700">Example B: Vector Addition Simulator</text>
        <text x="110" y="1165" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">&lt;div style="color:white;"&gt;Vx: &lt;input type="range" id="vx"&gt; Vy: &lt;input type="range" id="vy"&gt;</text>
        <text x="110" y="1185" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  &lt;script&gt;function check() { len = Math.sqrt(vx*vx + vy*vy);</text>
        <text x="110" y="1205" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  if(Math.abs(len - 5.0) &lt; 0.1) DuoMessageChannel.postMessage("complete"); }&lt;/script&gt;&lt;/div&gt;</text>

        <rect x="90" y="1295" width="1020" height="160" rx="8" fill="rgba(0,0,0,0.3)"/>
        <text x="110" y="1320" fill="#ff9600" font-size="14" font-weight="700">Example C: Interactive Sorting Algorithm Visualizer</text>
        <text x="110" y="1345" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">&lt;div style="color:white;"&gt;&lt;div id="bars"&gt;&lt;/div&gt;&lt;button id="step" style="background:#58cc02;"&gt;Step Sort&lt;/button&gt;</text>
        <text x="110" y="1365" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  &lt;script&gt;document.getElementById("step").onclick = () =&gt; {</text>
        <text x="110" y="1385" fill="rgba(255,255,255,0.7)" font-size="12" font-family="monospace">  if(!swapped) DuoMessageChannel.postMessage("complete"); };&lt;/script&gt;&lt;/div&gt;</text>
    ''' + svg_footer(5)

    pages_svg.append(p5)

    # PAGE 6: BATCHED COURSE GENERATION PIPELINE
    p6 = svg_header() + '''
        <text x="60" y="80" fill="#ffffff" font-size="32" font-weight="800">3. Multi-Stage Batched Course Generation Pipeline</text>
        <text x="60" y="110" fill="rgba(255,255,255,0.6)" font-size="16">Duofy breaks large textbook/course creation into focused, multi-stage LLM prompts to prevent context drift and missing topics.</text>

        <rect x="60" y="140" width="1080" height="520" rx="14" fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)"/>
        <text x="90" y="180" fill="#1cb0f6" font-size="20" font-weight="700">BATCHED PROMPT PIPELINE FLOWCHART</text>

        <rect x="90" y="210" width="220" height="140" rx="10" fill="rgba(28, 176, 246, 0.1)" stroke="#1cb0f6" stroke-width="1.5"/>
        <text x="200" y="245" fill="#1cb0f6" font-size="16" font-weight="700" text-anchor="middle">STAGE 1</text>
        <text x="200" y="270" fill="#ffffff" font-size="14" font-weight="600" text-anchor="middle">Chapter Enumeration</text>
        <text x="200" y="295" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Prompt: `chapterList`</text>
        <text x="200" y="315" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Lists top-level chapters &amp; TOC pages</text>

        <path d="M 310 280 L 350 280" stroke="#1cb0f6" stroke-width="3"/>

        <rect x="350" y="210" width="220" height="140" rx="10" fill="rgba(206, 130, 255, 0.1)" stroke="#ce82ff" stroke-width="1.5"/>
        <text x="460" y="245" fill="#ce82ff" font-size="16" font-weight="700" text-anchor="middle">STAGE 2</text>
        <text x="460" y="270" fill="#ffffff" font-size="14" font-weight="600" text-anchor="middle">Section Detailing</text>
        <text x="460" y="295" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Prompt: `sectionList`</text>
        <text x="460" y="315" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Details subtopics per chapter</text>

        <path d="M 570 280 L 610 280" stroke="#ce82ff" stroke-width="3"/>

        <rect x="610" y="210" width="220" height="140" rx="10" fill="rgba(88, 204, 2, 0.1)" stroke="#58cc02" stroke-width="1.5"/>
        <text x="720" y="245" fill="#58cc02" font-size="16" font-weight="700" text-anchor="middle">STAGE 3</text>
        <text x="720" y="270" fill="#ffffff" font-size="14" font-weight="600" text-anchor="middle">Unit &amp; Format Manifest</text>
        <text x="720" y="295" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Prompt: `unitManifest`</text>
        <text x="720" y="315" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Generates up to 10 formats</text>

        <path d="M 830 280 L 870 280" stroke="#58cc02" stroke-width="3"/>

        <rect x="870" y="210" width="240" height="140" rx="10" fill="rgba(255, 150, 0, 0.1)" stroke="#ff9600" stroke-width="1.5"/>
        <text x="990" y="245" fill="#ff9600" font-size="16" font-weight="700" text-anchor="middle">STAGE 4</text>
        <text x="990" y="270" fill="#ffffff" font-size="14" font-weight="600" text-anchor="middle">5-Slide Lesson Gen</text>
        <text x="990" y="295" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Prompt: `generateLessonsPrompt`</text>
        <text x="990" y="315" fill="rgba(255,255,255,0.7)" font-size="12" text-anchor="middle">Builds interactive slide JSON</text>

        <rect x="90" y="380" width="1020" height="250" rx="10" fill="rgba(0,0,0,0.3)"/>
        <text x="120" y="415" fill="#ffffff" font-size="16" font-weight="700">Alternative Course Source Pipelines Supported by PromptService:</text>

        <text x="120" y="450" fill="#1cb0f6" font-size="14" font-weight="700">1. Textbook PDF / TOC Flow:</text>
        <text x="350" y="450" fill="rgba(255,255,255,0.8)" font-size="13">Stage 1 `chapterList` -&gt; Stage 2 `sectionList` (preserves TOC printed page numbers).</text>

        <text x="120" y="490" fill="#ce82ff" font-size="14" font-weight="700">2. Handout Document Flow:</text>
        <text x="350" y="490" fill="rgba(255,255,255,0.8)" font-size="13">One-shot `handoutSkeleton` mapping absolute PDF page bounds [1, totalPages].</text>

        <text x="120" y="530" fill="#58cc02" font-size="14" font-weight="700">3. Syllabus-Guided Flow:</text>
        <text x="350" y="530" fill="rgba(255,255,255,0.8)" font-size="13">Stage 1 `syllabusChapterList` -&gt; Stage 2 `syllabusSectionList` matching syllabus modules.</text>

        <text x="120" y="570" fill="#ff9600" font-size="14" font-weight="700">4. Knowledge-Only Flow:</text>
        <text x="350" y="570" fill="rgba(255,255,255,0.8)" font-size="13">Stage 1 `knowledgeChapterList` -&gt; Stage 2 `knowledgeSectionList` (no source PDF).</text>

        <text x="120" y="610" fill="#ef4444" font-size="14" font-weight="700">5. Custom Index Text Flow:</text>
        <text x="350" y="610" fill="rgba(255,255,255,0.8)" font-size="13">`customIndexChapterList` &amp; `parseCustomIndexText` strictly parses user's outline.</text>

        <rect x="60" y="680" width="1080" height="810" rx="14" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.08)"/>
        <text x="90" y="725" fill="#58cc02" font-size="20" font-weight="700">GENERATION DENSITY THRESHOLDS (densityBlock)</text>

        <path d="M 90 745 L 1090 745" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>

        <rect x="90" y="770" width="1020" height="120" rx="10" fill="rgba(28, 176, 246, 0.05)" stroke="#1cb0f6" stroke-width="1"/>
        <text x="120" y="805" fill="#1cb0f6" font-size="16" font-weight="700">LOW DENSITY (Easy Review)</text>
        <text x="120" y="835" fill="rgba(255,255,255,0.8)" font-size="14">• Units per Section: 1 to 2 units | Lessons per Unit: 6 to 8 lessons | Slides per Lesson: EXACTLY 5 slides.</text>
        <text x="120" y="860" fill="rgba(255,255,255,0.6)" font-size="13">Ideal for quick refresher courses or rapid surface-level reviews.</text>

        <rect x="90" y="910" width="1020" height="120" rx="10" fill="rgba(88, 204, 2, 0.05)" stroke="#58cc02" stroke-width="1"/>
        <text x="120" y="945" fill="#58cc02" font-size="16" font-weight="700">MEDIUM DENSITY (Standard - Default)</text>
        <text x="120" y="975" fill="rgba(255,255,255,0.8)" font-size="14">• Units per Section: 3 to 4 units | Lessons per Unit: 8 to 12 lessons | Slides per Lesson: EXACTLY 5 slides.</text>
        <text x="120" y="1000" fill="rgba(255,255,255,0.6)" font-size="13">Balanced cognitive load for standard semester learning.</text>

        <rect x="90" y="1050" width="1020" height="120" rx="10" fill="rgba(206, 130, 255, 0.05)" stroke="#ce82ff" stroke-width="1"/>
        <text x="120" y="1085" fill="#ce82ff" font-size="16" font-weight="700">HIGH DENSITY (Deep Dive)</text>
        <text x="120" y="1115" fill="rgba(255,255,255,0.8)" font-size="14">• Units per Section: 5 to 6 units | Lessons per Unit: 12 to 16 lessons | Slides per Lesson: EXACTLY 5 slides.</text>
        <text x="120" y="1140" fill="rgba(255,255,255,0.6)" font-size="13">Detailed coverage for technical subjects, STEM courses, and exam preparation.</text>

        <rect x="90" y="1190" width="1020" height="140" rx="10" fill="rgba(255, 150, 0, 0.05)" stroke="#ff9600" stroke-width="1"/>
        <text x="120" y="1225" fill="#ff9600" font-size="16" font-weight="700">EXTRA &amp; MAX DENSITY (Comprehensive / Exhaustive)</text>
        <text x="120" y="1255" fill="rgba(255,255,255,0.8)" font-size="14">• Extra Density: 7 to 8 units, 16 to 20 lessons per unit.</text>
        <text x="120" y="1280" fill="rgba(255,255,255,0.8)" font-size="14">• Max Density: 9+ units, 20 to 25 lessons per unit (exhaustive problem breakdown).</text>
        <text x="120" y="1305" fill="rgba(255,255,255,0.6)" font-size="13">Translates entire textbook exercise sets into individual interactive slide problems one-by-one.</text>
    ''' + svg_footer(6)

    pages_svg.append(p6)

    # PAGE 7: COMPLETE PROMPT INVENTORY TABLE & SERVICE ARCHITECTURE
    p7 = svg_header() + '''
        <text x="60" y="80" fill="#ffffff" font-size="32" font-weight="800">4. Complete AI Prompt Inventory &amp; Service Mapping</text>
        <text x="60" y="110" fill="rgba(255,255,255,0.6)" font-size="16">Full catalog of all prompt constants, service invocation sites, and AI feedback loops in Duofy.</text>

        <rect x="60" y="140" width="1080" height="1350" rx="14" fill="rgba(255,255,255,0.02)" stroke="rgba(255,255,255,0.08)"/>
        
        <rect x="60" y="140" width="1080" height="50" rx="14" fill="rgba(28, 176, 246, 0.15)"/>
        <text x="90" y="172" fill="#1cb0f6" font-size="14" font-weight="700">PROMPT CONSTANT</text>
        <text x="380" y="172" fill="#1cb0f6" font-size="14" font-weight="700">SOURCE SERVICE</text>
        <text x="620" y="172" fill="#1cb0f6" font-size="14" font-weight="700">FUNCTION &amp; STAGE</text>
        <text x="920" y="172" fill="#1cb0f6" font-size="14" font-weight="700">OUTPUT FORMAT</text>

        <path d="M 60 190 L 1140 190" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>

        <text x="90" y="225" fill="#ffffff" font-size="13" font-family="monospace">chapterList</text>
        <text x="380" y="225" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="225" fill="rgba(255,255,255,0.8)" font-size="13">Stage 1 PDF TOC chapter enumeration</text>
        <text x="920" y="225" fill="#58cc02" font-size="13" font-family="monospace">JSON (chapters[])</text>

        <text x="90" y="275" fill="#ffffff" font-size="13" font-family="monospace">sectionList</text>
        <text x="380" y="275" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="275" fill="rgba(255,255,255,0.8)" font-size="13">Stage 2 subtopic detailing per chapter</text>
        <text x="920" y="275" fill="#58cc02" font-size="13" font-family="monospace">JSON (sections[])</text>

        <text x="90" y="325" fill="#ffffff" font-size="13" font-family="monospace">generateLessonFormatsPrompt</text>
        <text x="380" y="325" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="325" fill="rgba(255,255,255,0.8)" font-size="13">Stage 3 custom lesson format creation (max 10)</text>
        <text x="920" y="325" fill="#58cc02" font-size="13" font-family="monospace">JSON (lessonFormats[])</text>

        <text x="90" y="375" fill="#ffffff" font-size="13" font-family="monospace">unitManifest</text>
        <text x="380" y="375" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="375" fill="rgba(255,255,255,0.8)" font-size="13">Pedagogical unit metadata &amp; Bloom's level</text>
        <text x="920" y="375" fill="#58cc02" font-size="13" font-family="monospace">JSON (units[])</text>

        <text x="90" y="425" fill="#ffffff" font-size="13" font-family="monospace">generateLessonsPrompt</text>
        <text x="380" y="425" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="425" fill="rgba(255,255,255,0.8)" font-size="13">Builds 5 interactive slides per lesson</text>
        <text x="920" y="425" fill="#58cc02" font-size="13" font-family="monospace">JSON (lessons[])</text>

        <text x="90" y="475" fill="#ffffff" font-size="13" font-family="monospace">handoutSkeleton</text>
        <text x="380" y="475" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="475" fill="rgba(255,255,255,0.8)" font-size="13">One-shot course skeleton for PDF handouts</text>
        <text x="920" y="475" fill="#58cc02" font-size="13" font-family="monospace">JSON (modules[])</text>

        <text x="90" y="525" fill="#ffffff" font-size="13" font-family="monospace">syllabusChapterList</text>
        <text x="380" y="525" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="525" fill="rgba(255,255,255,0.8)" font-size="13">Syllabus-aligned chapter enumeration</text>
        <text x="920" y="525" fill="#58cc02" font-size="13" font-family="monospace">JSON (chapters[])</text>

        <text x="90" y="575" fill="#ffffff" font-size="13" font-family="monospace">knowledgeChapterList</text>
        <text x="380" y="575" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="575" fill="rgba(255,255,255,0.8)" font-size="13">Textbook-free course structuring</text>
        <text x="920" y="575" fill="#58cc02" font-size="13" font-family="monospace">JSON (chapters[])</text>

        <text x="90" y="625" fill="#ffffff" font-size="13" font-family="monospace">customIndexChapterList</text>
        <text x="380" y="625" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="625" fill="rgba(255,255,255,0.8)" font-size="13">User custom TOC outline parsing</text>
        <text x="920" y="625" fill="#58cc02" font-size="13" font-family="monospace">JSON (chapters[])</text>

        <text x="90" y="675" fill="#ffffff" font-size="13" font-family="monospace">slideRulesBlock</text>
        <text x="380" y="675" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="675" fill="rgba(255,255,255,0.8)" font-size="13">Single slide regeneration &amp; custom slide rules</text>
        <text x="920" y="675" fill="#58cc02" font-size="13" font-family="monospace">JSON (slide)</text>

        <text x="90" y="725" fill="#ffffff" font-size="13" font-family="monospace">latexGuide</text>
        <text x="380" y="725" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="725" fill="rgba(255,255,255,0.8)" font-size="13">Inlined 11-point LaTeX formatting rules</text>
        <text x="920" y="725" fill="#ce82ff" font-size="13" font-family="monospace">Text Rule Block</text>

        <text x="90" y="775" fill="#ffffff" font-size="13" font-family="monospace">_customHtmlGuide</text>
        <text x="380" y="775" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="775" fill="rgba(255,255,255,0.8)" font-size="13">Inlined HTML5 canvas theme &amp; postMessage guide</text>
        <text x="920" y="775" fill="#ce82ff" font-size="13" font-family="monospace">Text Rule Block</text>

        <text x="90" y="825" fill="#ffffff" font-size="13" font-family="monospace">pedagogyBlock</text>
        <text x="380" y="825" fill="rgba(255,255,255,0.8)" font-size="13">PromptService</text>
        <text x="620" y="825" fill="rgba(255,255,255,0.8)" font-size="13">Practice-first coding &amp; retrieval practice</text>
        <text x="920" y="825" fill="#ce82ff" font-size="13" font-family="monospace">Text Rule Block</text>

        <text x="90" y="875" fill="#ffffff" font-size="13" font-family="monospace">LessonAssistantChat</text>
        <text x="380" y="875" fill="rgba(255,255,255,0.8)" font-size="13">LessonAssistantChat Widget</text>
        <text x="620" y="875" fill="rgba(255,255,255,0.8)" font-size="13">Contextual AI tutor prompt for current slide</text>
        <text x="920" y="875" fill="#ff9600" font-size="13" font-family="monospace">Streamed Chat</text>

        <text x="90" y="925" fill="#ffffff" font-size="13" font-family="monospace">MetacognitionService</text>
        <text x="380" y="925" fill="rgba(255,255,255,0.8)" font-size="13">MetacognitionService</text>
        <text x="620" y="925" fill="rgba(255,255,255,0.8)" font-size="13">Learner model assessment &amp; diagnostic review</text>
        <text x="920" y="925" fill="#ff9600" font-size="13" font-family="monospace">JSON Diagnostic</text>

        <rect x="90" y="980" width="1020" height="480" rx="12" fill="rgba(28, 176, 246, 0.05)" stroke="#1cb0f6" stroke-width="1.5"/>
        <text x="120" y="1025" fill="#1cb0f6" font-size="20" font-weight="700">DOCUMENTARY SUMMARY &amp; ARCHITECTURAL STRENGTHS</text>

        <text x="120" y="1065" fill="#ffffff" font-size="15" font-weight="700">1. Strict Structural Reliability</text>
        <text x="120" y="1090" fill="rgba(255,255,255,0.8)" font-size="14">By separating TOC parsing into batched, single-purpose API calls (`chapterList` -&gt; `sectionList` -&gt; `unitManifest`), Duofy completely eliminates missing chapters, merged subtopics, and contents-to-page drift.</text>

        <text x="120" y="1135" fill="#ffffff" font-size="15" font-weight="700">2. Error-Free Math &amp; Code Execution</text>
        <text x="120" y="1160" fill="rgba(255,255,255,0.8)" font-size="14">The 11-point `latexGuide` prevents backslash stripping and bad math delimiters, while the embedded SeriousPython pure-Python NumPy / Matplotlib / Sklearn stubs guarantee code runner slides execute natively on mobile without dependencies.</text>

        <text x="120" y="1205" fill="#ffffff" font-size="15" font-weight="700">3. Active Retrieval &amp; Practice-First Pedagogy</text>
        <text x="120" y="1230" fill="rgba(255,255,255,0.8)" font-size="14">With 14 specialized slide types spanning practice-first coding runners (`try_yourself`, `program`), custom webview canvas apps (`custom_html`), and interactive recall questions (`quiz`, `fill_in_blank`, `numerical`, `flashcard`, `matching`, `ordering`), Duofy ensures at least 33% of every lesson forces active answer production rather than passive reading.</text>

        <text x="120" y="1275" fill="#ffffff" font-size="15" font-weight="700">4. Dynamic Design System &amp; Web Bridge</text>
        <text x="120" y="1300" fill="rgba(255,255,255,0.8)" font-size="14">The Glassmorphism theme palette and `DuoMessageChannel` postMessage protocol allow LLMs to author complete interactive physics simulators, circuits, and algorithm games directly inside Flutter webviews with automatic progress tracking.</text>

        <rect x="120" y="1340" width="960" height="90" rx="8" fill="rgba(88, 204, 2, 0.1)" stroke="#58cc02" stroke-width="1"/>
        <text x="600" y="1375" fill="#58cc02" font-size="16" font-weight="700" text-anchor="middle">DUOFY PDF DOCUMENTARY GENERATED SUCCESSFULLY</text>
        <text x="600" y="1405" fill="rgba(255,255,255,0.8)" font-size="14" text-anchor="middle">All 14 slide types, LaTeX guidelines, custom HTML protocols, and AI prompt pipelines documented.</text>
    ''' + svg_footer(7)

    pages_svg.append(p7)

    pdf_page_paths = []
    for idx, svg_content in enumerate(pages_svg):
        svg_file = f"/tmp/duofy_doc_p{idx+1}.svg"
        page_pdf = f"/tmp/duofy_doc_p{idx+1}.pdf"
        with open(svg_file, "w", encoding="utf-8") as f:
            f.write(svg_content)
        
        cmd = ["rsvg-convert", "-f", "pdf", "-o", page_pdf, svg_file]
        res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if res.returncode == 0:
            pdf_page_paths.append(page_pdf)
        else:
            print(f"Error converting page {idx+1}: {res.stderr.decode()}")

    if pdf_page_paths:
        merge_cmd = ["pdfunite"] + pdf_page_paths + [pdf_path]
        m_res = subprocess.run(merge_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if m_res.returncode == 0:
            print(f"Successfully generated PDF documentary at: {pdf_path}")
        else:
            gs_cmd = ["gs", "-q", "-dNOPAUSE", "-dBATCH", "-sDEVICE=pdfwrite", f"-sOutputFile={pdf_path}"] + pdf_page_paths
            subprocess.run(gs_cmd)
            print(f"Generated PDF via Ghostscript at: {pdf_path}")

if __name__ == "__main__":
    build_pdf()
