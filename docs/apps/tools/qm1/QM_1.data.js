/* ══════════════════════════════════════════════════════════════════
   QM I · Modules I–II — EXAM EDITION
   Trimmed to the official syllabus:
     Module I  — Griffiths ch.1, sections 1.1–1.6                (10 marks)
     Module II — Griffiths 2.1, 2.2, 2.4 + Zettili 3.6.4, 4.4,
                 4.5.1, 4.5.2                                    (20 marks)
   Written for someone meeting this topic for the first time.
   Target: 4 hours end to end.
   ══════════════════════════════════════════════════════════════════ */

/* ---- builders ---- */
function gist(text){
  return `<div class="gist"><span class="gl">in one line</span>${text}</div>`;
}
function lad(title,rungs){
  const body=rungs.map((r,i)=>`<div class="rung${i? ' hidden':''}">
    <span class="peek">tap to reveal ▸</span>
    ${r.why?`<div class="why">${r.why}</div>`:''}
    <div class="math">${r.m}</div></div>`).join('');
  return `<div class="ladder"><div class="lh">${title}<span class="li">derivation</span></div>
    ${body}
    <div class="lfoot"><button class="btn primary reveal-next">Reveal next step</button>
      <button class="btn reveal-all">Show all</button>
      <span class="mini dim">Guess the next line before you tap — that guess is what makes it stick.</span></div></div>`;
}
function fig(name,cap,leg){
  return `<figure class="fig"><div class="cvwrap"><canvas data-fig="${name}"></canvas></div>
    ${leg?`<div class="leg">${leg}</div>`:''}
    <figcaption>${cap}</figcaption></figure>`;
}
let _ck=0;
function chk(q,a){_ck++;const id='ck'+_ck;
  return `<div class="check" id="${id}"><div class="ch">◈ can you answer this?</div>
    <div class="qz">${q}</div>
    <div class="conf"><button data-c="0">No idea</button><button data-c="1">Shaky</button>
      <button data-c="2">Fairly sure</button><button data-c="3">Solid</button></div>
    <button class="reveal">Answer honestly, then check ▸</button>
    <div class="ans">${a}</div></div>`;
}
function prob(n,title,parts){
  return `<details class="prob"><summary><span class="pn">${n}</span><span class="pt">${title}</span><span class="chev">›</span></summary>
    <div class="pbody">${parts}</div></details>`;
}
function pq(html){return `<h4 class="qn">the question</h4>${html}`;}
function pth(html){return `<h4 class="theory">what you need first</h4>${html}`;}
function psol(html){return `<h4 class="sol">how to do it</h4>${html}`;}
function prac(html){return `<div class="practice"><div class="pl">now you try — same method</div>${html}</div>`;}
function tp(title){return `<div class="topic" data-tp><h3>${title}</h3></div>`;}
function must(html){return `<div class="note key"><div class="nh">learn this by heart</div>${html}</div>`;}
function trap(html){return `<div class="note pitfall"><div class="nh">where marks get lost</div>${html}</div>`;}

const STATIONS=[

/* ═══════════════════ ORIENTATION ═══════════════════ */
{id:'start',hero:true,title:'Quantum Mechanics I',short:'Read this first',est:'~5 min',
 body:`
 <p class="lead">Modules I and II only — the wave function, and the time-independent Schrödinger
 equation with wells, steps and barriers. That is <strong>30 of the 70 marks</strong>.
 Written from zero, about <strong>four hours</strong> end to end.</p>

 ${tp('What is actually on the syllabus')}
 <p>This app has been trimmed to exactly the prescribed sections — nothing extra to distract you.</p>
 <div class="plan">
   <div class="slot"><span class="when">Module I<br>10 marks</span><div class="what"><b>The Wave Function</b>
     <span>Schrödinger equation · statistical interpretation · probability (discrete &amp; continuous) · normalization · momentum · uncertainty principle. <em>(Griffiths ch.1, §1.1–1.6)</em></span></div></div>
   <div class="slot"><span class="when">Module II<br>20 marks</span><div class="what"><b>Time-Independent Schrödinger Equation</b>
     <span>Stationary states · infinite square well · free particle &amp; wave packets · conservation of probability and current · potential step · potential barrier and tunnelling. <em>(Griffiths §2.1, 2.2, 2.4; Zettili §3.6.4, 4.4, 4.5.1–2)</em></span></div></div>
 </div>
 <p class="dim">Module II carries twice the marks of Module I — budget your time accordingly.</p>

 ${tp('How to read this')}
 <p>Each section opens with an <strong>in one line</strong> box giving the whole idea in a sentence. Then two or three short topics. A <strong>learn this by heart</strong> box is something you should be able to write cold; a <strong>where marks get lost</strong> box is a mistake examiners see every year.</p>
 <p>Answer each checkpoint <em>before</em> revealing it — trying and failing to recall teaches far more than re-reading. Derivation ladders stay blurred until you tap, for the same reason.</p>

 <p class="dim">Top bar: <b>⇕</b> opens/closes everything · <b>◐</b> light or dark · <b>☁</b> sync ticks to another device · <b>⤓</b> download this page.</p>
`},

/* ═══════════════════ MODULE I ═══════════════════ */
{id:'m1-schrodinger',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'The Schrödinger equation',short:'Schrödinger equation',est:'~12 min',
 body:`
 ${gist('Classically a particle <em>is</em> a position $x(t)$. Quantum mechanically the whole state is a complex function $\\Psi(x,t)$, and the Schrödinger equation marches it forward in time.')}

 ${tp('What replaces Newton\'s law')}
 <p>In classical mechanics a particle has a definite position at every instant, and $F=ma$ tells you what that position does next. Give it $x(0)$ and $\\dot x(0)$ and the future is fixed.</p>
 <p>Quantum mechanics keeps the idea of a deterministic law, but changes <strong>what</strong> the law acts on. The complete description of a particle moving in one dimension is a <em>complex-valued function</em> $\\Psi(x,t)$ — the <strong>wave function</strong>. Its equation of motion is:</p>
 ${must(`$$\\boxed{\\;i\\hbar\\,\\frac{\\partial\\Psi}{\\partial t}=-\\frac{\\hbar^2}{2m}\\frac{\\partial^2\\Psi}{\\partial x^2}+V(x,t)\\,\\Psi\\;}$$
 <p>with $\\hbar=h/2\\pi\\approx1.055\\times10^{-34}$ J·s. The right side is (kinetic term) + (potential term) acting on $\\Psi$.</p>`)}
 <p>Read it exactly as you read $F=ma$: hand it $\\Psi(x,0)$ everywhere along the line, and it returns $\\Psi(x,t)$ at every later time — uniquely and deterministically.</p>

 ${tp('Two features worth a mark each')}
 <ul>
   <li><strong>Why complex?</strong> The $i$ is not decoration. Without it the equation would look like heat diffusion and every ripple would simply die away. The factor $i$ turns decay into <em>rotation</em> in the complex plane, so $\\Psi$ oscillates and can interfere — which is the whole of quantum behaviour.</li>
   <li><strong>Why only one initial condition?</strong> The equation is <em>first order in time</em>, so a single snapshot $\\Psi(x,0)$ determines everything after. Newton's law is second order in time and needs two ($x$ and $\\dot x$). It is <em>second order in space</em>, which is what will later force $\\psi$ and $d\\psi/dx$ to be continuous at every boundary.</li>
 </ul>

 ${chk(
   'The Schrödinger equation is first order in time. What does that tell you about how much initial information you must supply, compared with Newton\'s second law?',
   '<p>Newton\'s law is <strong>second</strong> order in time, so it needs <strong>two</strong> initial numbers: $x(0)$ and $\\dot x(0)$.</p><p>The Schrödinger equation is <strong>first</strong> order in time, so it needs only <strong>one</strong> piece of initial data — the entire function $\\Psi(x,0)$. From that single slice the whole future is determined. (Being second order in <em>space</em> is a separate matter — that is what gives the boundary conditions later.)</p>')}
`},

{id:'m1-born',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'What the wave function means',short:'Statistical interpretation',est:'~14 min',
 body:`
 ${gist('$|\\Psi|^2$ is not the particle — it is the <b>probability per unit length</b> of finding the particle there.')}

 ${tp('Born\'s rule')}
 <p>Max Born supplied the interpretation that makes the theory physics rather than mathematics. The quantity</p>
 $$|\\Psi(x,t)|^2=\\Psi^{*}(x,t)\\,\\Psi(x,t)$$
 <p>is the <strong>probability density</strong> for finding the particle at $x$. Because $\\Psi$ is complex you square it against its complex conjugate $\\Psi^*$ — that guarantees a real, non-negative answer.</p>
 <p>To get an actual probability you integrate over a stretch of the line:</p>
 ${must(`$$P_{ab}(t)=\\int_a^b|\\Psi(x,t)|^2\\,dx\\;=\\;\\text{probability of finding it between }a\\text{ and }b$$`)}
 <p>So $\\Psi$ does <em>not</em> tell you where the particle is. It tells you the odds. Even with perfect knowledge of $\\Psi$, individual results stay genuinely random — this is indeterminacy built into nature, not into our instruments.</p>

 ${fig('slit',
   'Electrons fired one at a time through a double slit. Each one lands as a single localised dot (bottom band), its position drawn at random from $|\\Psi|^2$. No single dot shows a fringe — yet thousands of independent arrivals rebuild the continuous interference curve (top). The curve is $|\\Psi|^2$; the dots are what measurement actually gives you.',
   '<span><i class="fill" style="background:var(--prob)"></i>|Ψ|² intensity</span><span><i class="fill" style="background:var(--prob)"></i>detected electrons</span>')}

 ${tp('Where was it before you looked?')}
 <p>Three classic positions — be able to name and separate them:</p>
 <ul>
   <li><strong>Realist:</strong> the particle had a definite position all along, and $\\Psi$ merely reflects our ignorance. Quantum mechanics would then be <em>incomplete</em>, needing extra "hidden variables".</li>
   <li><strong>Orthodox (Copenhagen):</strong> it had no definite position; the act of measuring <em>forced</em> one into existence.</li>
   <li><strong>Agnostic:</strong> the question is unanswerable and therefore not physics.</li>
 </ul>
 <p><strong>Bell (1964)</strong> turned this from philosophy into experiment: any <em>local</em> hidden-variable theory must obey an inequality that quantum mechanics violates. Experiments see the violation, so the local realist position is ruled out and the orthodox view stands.</p>

 ${must(`<p><strong>Collapse — the second law of motion.</strong> Measure the position and get $x=C$; measure again immediately and you must get $C$ again. So measurement <em>collapses</em> $\\Psi$ into a sharp spike at $C$.</p>
 <p>Quantum evolution therefore has <strong>two</strong> distinct rules:</p>
 <ol><li>smooth, deterministic Schrödinger evolution between measurements;</li>
 <li>abrupt, random collapse at a measurement.</li></ol>`)}

 ${chk(
   'In the double-slit experiment with one electron at a time, an interference pattern still builds up. What is interfering with what — and why does a single electron not show a fringe?',
   '<p>Each electron\'s <em>own</em> wave function passes through <strong>both</strong> slits and interferes <strong>with itself</strong>; that self-interference is what makes $|\\Psi|^2$ fringed.</p><p>But a single electron is <em>detected</em> just once, as one localised dot whose position is a single random draw from $|\\Psi|^2$. One draw cannot reveal a distribution. Only the accumulated statistics of many independent electrons reconstruct the pattern. Interference lives in the amplitude; the pattern lives in the ensemble.</p>')}
`},

{id:'m1-probability',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'Probability: averages and spread',short:'Probability theory',est:'~14 min',
 body:`
 ${gist('Two things to compute from any distribution: the average $\\langle x\\rangle$, and the spread $\\sigma$. Everything statistical in this course reduces to these.')}

 ${tp('Discrete variables')}
 <p>If a quantity $j$ takes values with frequencies $N(j)$ out of $N$ total, the probability is $P(j)=N(j)/N$ and $\\sum_jP(j)=1$. Then:</p>
 <ul>
   <li><strong>Most probable value</strong> — the $j$ with the biggest $P(j)$.</li>
   <li><strong>Median</strong> — the value that splits the list in half.</li>
   <li><strong>Average (expectation value)</strong> — $\\langle j\\rangle=\\sum_j jP(j)$, and generally $\\langle f(j)\\rangle=\\sum_j f(j)P(j)$.</li>
 </ul>
 ${trap(`<p>Careful: $\\langle j^2\\rangle$ means "square each value, <em>then</em> average". $\\langle j\\rangle^2$ means "average, <em>then</em> square". They are different, and the difference is exactly the spread.</p>`)}

 ${lad('The variance formula — derive it once, use it all course',[
   {why:'Start from the definition: variance is the average of the squared deviation from the mean.',
    m:'$$\\sigma^2\\equiv\\big\\langle(\\Delta j)^2\\big\\rangle=\\sum_j\\,(j-\\langle j\\rangle)^2\\,P(j)$$'},
   {why:'Expand the bracket inside the sum.',
    m:'$$=\\sum_j\\big(j^2-2j\\langle j\\rangle+\\langle j\\rangle^2\\big)P(j)$$'},
   {why:'$\\langle j\\rangle$ is just a number — pull it outside each sum, and remember $\\sum P=1$.',
    m:'$$=\\langle j^2\\rangle-2\\langle j\\rangle\\langle j\\rangle+\\langle j\\rangle^2$$'},
   {why:'Collect terms. This is the form you actually compute with.',
    m:'$$\\boxed{\\;\\sigma^2=\\langle j^2\\rangle-\\langle j\\rangle^2\\;}\\qquad\\Rightarrow\\qquad \\langle j^2\\rangle\\ge\\langle j\\rangle^2$$'}
 ])}

 ${tp('Continuous variables')}
 <p>For a continuous quantity the sums become integrals and $P(j)$ becomes a <strong>probability density</strong> $\\rho(x)$, defined so that $dP=\\rho(x)\\,dx$ is the probability of landing in a tiny interval $dx$:</p>
 $$\\int_{-\\infty}^{\\infty}\\rho\\,dx=1,\\qquad
   \\langle x\\rangle=\\int x\\,\\rho\\,dx,\\qquad
   \\langle f(x)\\rangle=\\int f(x)\\,\\rho\\,dx$$
 <p>and $\\sigma^2=\\langle x^2\\rangle-\\langle x\\rangle^2$ exactly as before. Note $\\rho$ itself is <em>not</em> a probability — it only becomes one after multiplying by a width.</p>

 ${fig('rock',
   'A classical density you can check by hand. A rock dropped from height $h$ and photographed at random times is found at depth $x$ with density $\\rho(x)=1/(2\\sqrt{hx})$ — it piles up near the top because it moves slowest there. The mean depth is $h/3$, well above the midpoint. Exactly this machinery gives $\\langle x\\rangle$ from $|\\Psi|^2$.',
   '<span><i class="fill" style="background:var(--prob)"></i>ρ(x)</span><span><i style="border-color:var(--pos)"></i>⟨x⟩ = h/3</span>')}

 ${chk(
   'A distribution has $\\sigma=0$. What does that force about $\\langle x^2\\rangle$ and $\\langle x\\rangle$, and what does it mean physically?',
   '<p>$\\sigma^2=\\langle x^2\\rangle-\\langle x\\rangle^2=0$, so $\\langle x^2\\rangle=\\langle x\\rangle^2$.</p><p>Zero variance means <strong>no spread at all</strong>: every measurement returns the same value — a perfectly sharp, deterministic distribution (a spike). The general inequality $\\langle x^2\\rangle\\ge\\langle x\\rangle^2$ becomes an equality only in this degenerate case.</p><p>This is the exact template for a result you meet in Module II: a stationary state has $\\sigma_H=0$, meaning its energy is perfectly definite.</p>')}
`},

{id:'m1-normalization',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'Normalization, and why it lasts',short:'Normalization',est:'~14 min',
 body:`
 ${gist('The particle is somewhere, so the total area under $|\\Psi|^2$ must be 1 — and the Schrödinger equation keeps it that way forever.')}

 ${tp('Fixing the constant')}
 <p>Since the particle must be found <em>somewhere</em> on the line:</p>
 ${must(`$$\\int_{-\\infty}^{\\infty}|\\Psi(x,t)|^2\\,dx=1$$`)}
 <p>You are allowed to impose this because the Schrödinger equation is <strong>linear and homogeneous</strong>: if $\\Psi$ is a solution then so is $A\\Psi$ for any constant $A$. Choosing $|A|$ to make the area 1 is called <em>normalizing</em>.</p>
 <p>Two consequences worth stating in an exam:</p>
 <ul>
   <li>Only functions with <em>finite</em> total area (<strong>square-integrable</strong>, $\\Psi\\in L^2$) can be normalized. A function that does not die away at infinity cannot represent a single localised particle.</li>
   <li>Normalizing fixes the size $|A|$ but <strong>not the phase</strong>. A constant factor $e^{i\\theta}$ survives — and it is physically invisible, since $|\\Psi e^{i\\theta}|^2=|\\Psi|^2$.</li>
 </ul>

 ${trap(`<p>Here is the worry Born's rule creates. You set the area to 1 at $t=0$ — but $\\Psi$ then evolves. What stops the area drifting to $0.9$ later and wrecking the probability interpretation? Nothing, <em>unless the equation itself protects it</em>. It does, and proving that is a standard exam question.</p>`)}

 ${lad('Proving normalization is conserved',[
   {why:'Differentiate the total probability with respect to time. The derivative moves inside the integral.',
    m:'$$\\frac{d}{dt}\\int_{-\\infty}^{\\infty}|\\Psi|^2dx=\\int_{-\\infty}^{\\infty}\\frac{\\partial}{\\partial t}\\big(\\Psi^{*}\\Psi\\big)\\,dx$$'},
   {why:'Product rule on $\\Psi^*\\Psi$.',
    m:'$$\\frac{\\partial}{\\partial t}|\\Psi|^2=\\Psi^{*}\\frac{\\partial\\Psi}{\\partial t}+\\frac{\\partial\\Psi^{*}}{\\partial t}\\Psi$$'},
   {why:'Substitute $\\partial_t\\Psi$ from the Schrödinger equation and its complex conjugate. For a <em>real</em> potential the two $V$ terms cancel exactly.',
    m:'$$\\frac{\\partial}{\\partial t}|\\Psi|^2=\\frac{i\\hbar}{2m}\\left(\\Psi^{*}\\frac{\\partial^2\\Psi}{\\partial x^2}-\\frac{\\partial^2\\Psi^{*}}{\\partial x^2}\\Psi\\right)$$'},
   {why:'The key trick: that bracket is a perfect derivative with respect to $x$.',
    m:'$$=\\frac{\\partial}{\\partial x}\\left[\\frac{i\\hbar}{2m}\\left(\\Psi^{*}\\frac{\\partial\\Psi}{\\partial x}-\\frac{\\partial\\Psi^{*}}{\\partial x}\\Psi\\right)\\right]$$'},
   {why:'Integrating a perfect derivative over all space leaves only the values at the two ends.',
    m:'$$\\frac{d}{dt}\\!\\int|\\Psi|^2dx=\\frac{i\\hbar}{2m}\\left[\\Psi^{*}\\Psi_x-\\Psi^{*}_x\\Psi\\right]_{-\\infty}^{\\infty}$$'},
   {why:'A normalizable $\\Psi$ (and its slope) must vanish at $\\pm\\infty$, so both ends give zero.',
    m:'$$\\frac{d}{dt}\\int_{-\\infty}^{\\infty}|\\Psi|^2dx=0\\qquad\\checkmark$$'}
 ])}

 ${chk(
   'Are $\\Psi$ and $\\Psi e^{i\\theta}$ (with $\\theta$ a real constant) physically different states? Where did that freedom come from?',
   '<p><strong>No.</strong> $|\\Psi e^{i\\theta}|^2=\\Psi^*e^{-i\\theta}\\Psi e^{i\\theta}=|\\Psi|^2$, so every probability and every expectation value is identical. A constant <em>overall</em> phase is unobservable.</p><p>It came from normalization: fixing the area pins down $|A|$ but says nothing about the phase of $A$.</p><p><strong>Careful:</strong> a <em>relative</em> phase <em>between two superposed pieces</em>, as in $\\psi_1+e^{i\\theta}\\psi_2$, is very much physical — that is interference. Only the single global phase is free.</p>')}
`},

{id:'m1-momentum',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'Momentum and operators',short:'Momentum &amp; operators',est:'~16 min',
 body:`
 ${gist('Observables become <b>operators</b> sandwiched between $\\Psi^*$ and $\\Psi$. Momentum turns out to be a derivative: $\\hat p=-i\\hbar\\,\\partial/\\partial x$.')}

 ${tp('Average position, and what it really means')}
 $$\\langle x\\rangle=\\int_{-\\infty}^{\\infty}x\\,|\\Psi|^2\\,dx$$
 ${trap(`<p>$\\langle x\\rangle$ is <strong>not</strong> "the average of repeated measurements on one particle" — the first measurement collapses the state, so every later one gives the same answer. It is the average over an <strong>ensemble of identically prepared systems</strong>: prepare many particles in the same $\\Psi$, measure each once, average those.</p>`)}

 ${tp('Where the momentum operator comes from')}
 <p>Ask how the average position moves, and the momentum operator drops out.</p>

 ${lad('From d⟨x⟩/dt to p̂ = −iℏ ∂/∂x',[
   {why:'Differentiate $\\langle x\\rangle$ and use the identity for $\\partial_t|\\Psi|^2$ from the last section.',
    m:'$$\\frac{d\\langle x\\rangle}{dt}=\\int x\\,\\frac{\\partial|\\Psi|^2}{\\partial t}\\,dx=\\frac{i\\hbar}{2m}\\int x\\,\\frac{\\partial}{\\partial x}\\Big(\\Psi^{*}\\Psi_x-\\Psi^{*}_x\\Psi\\Big)dx$$'},
   {why:'Integrate by parts; the boundary term dies at infinity.',
    m:'$$=-\\frac{i\\hbar}{2m}\\int\\Big(\\Psi^{*}\\Psi_x-\\Psi^{*}_x\\Psi\\Big)dx$$'},
   {why:'Integrate by parts a second time on the second piece — it folds onto the first.',
    m:'$$\\frac{d\\langle x\\rangle}{dt}=-\\frac{i\\hbar}{m}\\int\\Psi^{*}\\,\\frac{\\partial\\Psi}{\\partial x}\\,dx$$'},
   {why:'Define $\\langle p\\rangle=m\\,d\\langle x\\rangle/dt$ and read off whatever sits between $\\Psi^*$ and $\\Psi$.',
    m:'$$\\langle p\\rangle=\\int\\Psi^{*}\\Big(-i\\hbar\\frac{\\partial}{\\partial x}\\Big)\\Psi\\,dx\\;\\Rightarrow\\;\\boxed{\\hat p=-i\\hbar\\frac{\\partial}{\\partial x}}$$'}
 ])}

 ${tp('The general recipe, and Ehrenfest\'s theorem')}
 <p>The pattern generalises. Position is the operator "multiply by $x$"; momentum is "$-i\\hbar\\,\\partial_x$". For any classical quantity $Q(x,p)$ you build $\\hat Q=Q\\big(x,-i\\hbar\\partial_x\\big)$ and compute</p>
 ${must(`$$\\langle Q\\rangle=\\int\\Psi^{*}\\,\\hat Q\\,\\Psi\\,dx,
 \\qquad \\hat T=\\frac{\\hat p^{2}}{2m}=-\\frac{\\hbar^{2}}{2m}\\frac{\\partial^{2}}{\\partial x^{2}}$$`)}
 <p>Push the same calculation one step further — differentiate $\\langle p\\rangle$ in time — and you get <strong>Ehrenfest's theorem</strong>:</p>
 $$\\frac{d\\langle x\\rangle}{dt}=\\frac{\\langle p\\rangle}{m},
   \\qquad
   \\frac{d\\langle p\\rangle}{dt}=\\left\\langle-\\frac{\\partial V}{\\partial x}\\right\\rangle$$
 <p>In words: <strong>the averages obey Newton's laws.</strong> That is why the everyday world looks classical even though the underlying rules are not.</p>

 ${chk(
   'Why can you not compute $\\langle p\\rangle$ from $m\\,d\\langle x\\rangle/dt$ if you are only given $\\Psi$ at the single instant $t=0$?',
   '<p>Because a time derivative needs to know $\\Psi$ over an <em>interval</em> of time around $t=0$, not just at that one instant. A single snapshot cannot tell you a rate of change.</p><p>The fix is to use the operator instead, which only needs the snapshot: $$\\langle p\\rangle=\\int\\Psi^{*}(x,0)\\left(-i\\hbar\\frac{\\partial}{\\partial x}\\right)\\Psi(x,0)\\,dx$$ This is a favourite exam trap — it appears explicitly in the problem set.</p>')}
`},

{id:'m1-uncertainty',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'The uncertainty principle',short:'Uncertainty principle',est:'~10 min',
 body:`
 ${gist('A wave cannot be both sharply located and single-wavelength. Since wavelength means momentum, position spread × momentum spread has a hard floor of $\\hbar/2$.')}

 ${tp('Why it happens')}
 <p>This is a fact about waves, not about clumsy apparatus. Think about it in two extremes:</p>
 <ul>
   <li>A <strong>pure sine wave</strong> has one exact wavelength — but it stretches over all space, so its position is completely undefined.</li>
   <li>A <strong>sharp pulse</strong> has a definite location — but building a narrow spike out of sine waves requires a wide range of wavelengths, so its wavelength is undefined.</li>
 </ul>
 <p>Now bring in de Broglie: $p=h/\\lambda=\\hbar k$. A spread in wavelength <em>is</em> a spread in momentum. So the position–wavelength trade-off becomes a position–momentum trade-off:</p>
 ${must(`$$\\boxed{\\;\\sigma_x\\,\\sigma_p\\ \\ge\\ \\frac{\\hbar}{2}\\;}
 \\qquad \\sigma_x=\\sqrt{\\langle x^2\\rangle-\\langle x\\rangle^2},\\quad
 \\sigma_p=\\sqrt{\\langle p^2\\rangle-\\langle p\\rangle^2}$$`)}
 <p>It is a floor on the <em>product</em>: squeeze the position and the momentum spread must grow to compensate.</p>

 ${fig('unc',
   'A Fourier pair, live. Left is the position distribution, right is the momentum distribution. Watch them trade: as the position packet narrows, the momentum packet fattens, and the product never drops below $\\hbar/2$.',
   '<span><i class="fill" style="background:var(--pos)"></i>|Ψ(x)|²</span><span><i class="fill" style="background:var(--neg)"></i>|Φ(p)|²</span>')}

 ${must(`<p>The floor is <strong>reached</strong> ($=\\hbar/2$) only by a <strong>Gaussian</strong> wave packet. Any other shape gives a strictly larger product. You verify both cases in the problems: the Gaussian gives exactly $\\hbar/2$, while a parabolic bump $A(a^2-x^2)$ gives $\\sqrt{5/14}\\,\\hbar\\approx0.598\\hbar$.</p>`)}

 ${chk(
   'A student says “$\\sigma_x\\sigma_p\\ge\\hbar/2$ just means my detector disturbs the particle.” Correct them.',
   '<p>It is <strong>not</strong> about measurement disturbance. $\\sigma_x$ and $\\sigma_p$ are properties of the state $\\Psi$ <em>itself</em> — you compute them from $\\Psi$ before anyone measures anything.</p><p>Even a perfect, infinitely gentle apparatus faces the same floor, because a $\\Psi$ that is narrow in $x$ is <em>mathematically forced</em> (by Fourier analysis) to be broad in $p$. The "disturbance" story (Heisenberg\'s microscope) is a rough heuristic; the real content is the wave width theorem.</p>')}
`},

/* ═══════════════════ MODULE I · PROBLEMS ═══════════════════ */
{id:'m1-problems',mod:'Module I',modName:'The Wave Function',modClass:'m1',
 title:'Problems — Module I',short:'Problems I',est:'~20 min',
 body:`
 <p class="lead">The six problem types that come up from §1.1–1.6. Read the method, then do the twin on paper.</p>

 ${tp('Probability &amp; distributions')}
 ${prob('1','Discrete distribution — mean, ⟨j²⟩ and σ',
   pq('A sample contains fourteen people whose ages are: one aged 14, one aged 15, three aged 16, two aged 22, two aged 24 and five aged 25. Find the most probable age, the median age, the average age $\\langle j\\rangle$, the average of the squares $\\langle j^2\\rangle$, and the standard deviation $\\sigma$.')+
   pth('<p>$\\langle j\\rangle=\\sum jP(j)$, $\\langle j^2\\rangle=\\sum j^2P(j)$, and $\\sigma=\\sqrt{\\langle j^2\\rangle-\\langle j\\rangle^2}$. Mode = most frequent, median = middle of the ordered list.</p>')+
   psol('<p>Ages: one 14, one 15, three 16, two 22, two 24, five 25; $N=14$.</p><p>$\\langle j\\rangle=\\dfrac{14+15+48+44+48+125}{14}=\\dfrac{294}{14}=21$.</p><p>$\\langle j^2\\rangle=\\dfrac{196+225+768+968+1152+3125}{14}=\\dfrac{6434}{14}\\approx459.6$, and $\\langle j\\rangle^2=441$.</p><p>$\\sigma=\\sqrt{459.6-441}=\\sqrt{130/7}\\approx4.31$. Mode $=25$, median $=\\tfrac{22+24}{2}=23$.</p>')+
   prac('<p>20 particles have energies: 2 at $E{=}1$, 5 at $2$, 7 at $4$, 4 at $5$, 2 at $8$. Find the mode, median, $\\langle E\\rangle$, $\\langle E^2\\rangle$ and $\\sigma_E$.</p>'))}

 ${prob('2','Continuous density from a trajectory (the falling rock)',
   pq('A rock is dropped from rest off a cliff of height $h$ and falls freely, so that $x=\\tfrac12gt^2$. A million photographs are taken at random times during the fall. <b>(1)</b> Determine the probability density $\\rho(x)$ of finding the rock at distance $x$. <b>(2)</b> Verify that $\\rho(x)$ is properly normalized. <b>(3)</b> Compute the average distance fallen, $\\langle x\\rangle$.')+
   pth('<p>Sampling uniformly in time means $dP=dt/T$. Convert to $x$ using $x=\\tfrac12gt^2$, so $dt=dx/\\sqrt{2gx}$, with $T=\\sqrt{2h/g}$.</p>')+
   psol('<p>$\\rho(x)\\,dx=\\dfrac{dt}{T}=\\dfrac{dx/\\sqrt{2gx}}{\\sqrt{2h/g}}=\\dfrac{dx}{2\\sqrt{hx}}$, so $\\rho(x)=\\dfrac{1}{2\\sqrt{hx}}$ on $[0,h]$.</p><p>Check: $\\int_0^h\\frac{dx}{2\\sqrt{hx}}=\\frac{1}{2\\sqrt h}[2\\sqrt x]_0^h=1$ ✓</p><p>$\\langle x\\rangle=\\frac{1}{2\\sqrt h}\\int_0^h\\sqrt x\\,dx=\\dfrac h3$ — biased to the top, where it moves slowest.</p>')+
   prac('<p>A particle launched at $v_0$ decelerates uniformly at $a$, stopping at $L=v_0^2/2a$, sampled at random times. Find $\\rho(x)$, check normalization, and find $\\langle x\\rangle$.</p>'))}

 ${prob('3','Gaussian distribution — normalize and find σ',
   pq('Consider the Gaussian distribution $$\\rho(x)=Ae^{-\\lambda(x-a)^2}$$ where $A$, $a$ and $\\lambda$ are positive real constants. <b>(1)</b> Determine the normalization constant $A$. <b>(2)</b> Find $\\langle x\\rangle$, $\\langle x^2\\rangle$ and $\\sigma$.')+
   pth('<p>Gaussian integrals: $\\int e^{-\\lambda u^2}du=\\sqrt{\\pi/\\lambda}$, $\\int u^2e^{-\\lambda u^2}du=\\tfrac{1}{2\\lambda}\\sqrt{\\pi/\\lambda}$, and any odd integrand gives zero. Shift with $u=x-a$.</p>')+
   psol('<p>$\\rho=Ae^{-\\lambda(x-a)^2}$. Normalizing: $A\\sqrt{\\pi/\\lambda}=1\\Rightarrow A=\\sqrt{\\lambda/\\pi}$.</p><p>$\\langle x\\rangle=a$ (the odd part vanishes). $\\langle x^2\\rangle=a^2+\\tfrac{1}{2\\lambda}$.</p><p>$\\sigma=\\sqrt{\\langle x^2\\rangle-\\langle x\\rangle^2}=\\dfrac{1}{\\sqrt{2\\lambda}}$ — a bell centred at $a$ with inflection points at $a\\pm\\sigma$.</p>')+
   prac('<p>For $\\rho(x)=Cxe^{-\\beta x^2}$ on $x\\ge0$, find $C$, then $\\langle x\\rangle$, $\\langle x^2\\rangle$ and $\\sigma$.</p>'))}

 ${tp('Normalization &amp; momentum')}
 ${prob('4','Triangular wave function — normalize, most likely x, ⟨x⟩',
   pq('At $t=0$ a particle is represented by the wave function $$\\Psi(x,0)=\\begin{cases}A\\,x/a,&0\\le x\\le a\\\\ A\\,(b-x)/(b-a),&a\\le x\\le b\\\\ 0,&\\text{otherwise}\\end{cases}$$ where $A$, $a$ and $b$ are positive constants with $b>a$. <b>(1)</b> Normalize $\\Psi$, i.e. find $A$ in terms of $a$ and $b$. <b>(2)</b> At $t=0$, where is the particle most likely to be found? <b>(3)</b> What is the probability of finding the particle to the left of $x=a$? <b>(4)</b> Determine $\\langle x\\rangle$.')+
   pth('<p>Integrate $|\\Psi|^2$ leg by leg. Most likely $x$ = where $|\\Psi|^2$ peaks. Use $u=b-x$ on the second leg.</p>')+
   psol('<p>$\\Psi=A\\tfrac xa$ on $[0,a]$ and $A\\tfrac{b-x}{b-a}$ on $[a,b]$.</p><p>$\\int|\\Psi|^2=A^2\\big(\\tfrac a3+\\tfrac{b-a}{3}\\big)=A^2\\tfrac b3=1\\Rightarrow A=\\sqrt{3/b}$.</p><p>$|\\Psi|^2$ peaks at $x=a$, so that is the most likely place. $P(x&lt;a)=A^2\\tfrac a3=\\dfrac ab$ (check: $b=2a$ gives $\\tfrac12$ ✓).</p><p>$\\langle x\\rangle=\\dfrac{2a+b}{4}$.</p>')+
   prac('<p>$\\Psi=C(a-|x|)$ on $[-a,a]$. Find $C$, then $P(|x|&lt;a/2)$, then $\\langle x\\rangle$ and $\\langle x^2\\rangle$.</p>'))}

 ${prob('5','Exponential state — moments and outside-range probability',
   pq('Consider the wave function $$\\Psi(x,t)=Ae^{-\\lambda|x|}e^{-i\\omega t}$$ where $A$, $\\lambda$ and $\\omega$ are positive real constants. <b>(1)</b> Normalize $\\Psi$. <b>(2)</b> Determine $\\langle x\\rangle$ and $\\langle x^2\\rangle$. <b>(3)</b> Find $\\sigma_x$, and calculate the probability of finding the particle outside the range $\\langle x\\rangle\\pm\\sigma_x$.')+
   pth('<p>$\\int_0^\\infty x^ne^{-2\\lambda x}dx=\\dfrac{n!}{(2\\lambda)^{n+1}}$. Symmetry kills $\\langle x\\rangle$.</p>')+
   psol('<p>For $\\Psi=Ae^{-\\lambda|x|}e^{-i\\omega t}$: $\\int|\\Psi|^2=A^2/\\lambda=1\\Rightarrow A=\\sqrt\\lambda$.</p><p>$\\langle x\\rangle=0$ (odd integrand); $\\langle x^2\\rangle=2\\lambda\\cdot\\dfrac{2}{(2\\lambda)^3}=\\dfrac{1}{2\\lambda^2}$, so $\\sigma_x=\\dfrac{1}{\\sqrt2\\lambda}$.</p><p>$P_{\\text{outside}}=2\\displaystyle\\int_{\\sigma_x}^\\infty\\lambda e^{-2\\lambda x}dx=e^{-2\\lambda\\sigma_x}=e^{-\\sqrt2}\\approx0.243$.</p>')+
   prac('<p>$\\Psi(x,0)=Bxe^{-\\alpha x}$ for $x\\ge0$. Find $B$, then $\\langle x\\rangle,\\langle x^2\\rangle,\\sigma_x$.</p>'))}

 ${tp('Uncertainty')}
 ${prob('6','Gaussian state — does it reach the ℏ/2 floor?',
   pq('A particle of mass $m$ has the wave function $$\\Psi(x,t)=Ae^{-a\\left(mx^2/\\hbar+it\\right)}$$ where $A$ and $a$ are positive real constants. <b>(1)</b> Find the normalization constant $A$. <b>(2)</b> For what potential energy function $V(x)$ does $\\Psi$ satisfy the Schrödinger equation? <b>(3)</b> Calculate $\\langle x\\rangle$, $\\langle x^2\\rangle$, $\\langle p\\rangle$ and $\\langle p^2\\rangle$. <b>(4)</b> Determine $\\sigma_x$ and $\\sigma_p$, and check whether their product is consistent with the uncertainty principle.')+
   pth('<p>Find $V(x)$ by substituting into the Schrödinger equation. Get moments from Gaussian integrals; use $\\langle p^2\\rangle=-\\hbar^2\\int\\Psi^*\\Psi_{xx}\\,dx$.</p>')+
   psol('<p>For $\\Psi=Ae^{-a(mx^2/\\hbar+it)}$: $A=(2am/\\pi\\hbar)^{1/4}$, and substituting gives $V(x)=2ma^2x^2$ — a harmonic oscillator with $\\omega=2a$.</p><p>$\\langle x\\rangle=\\langle p\\rangle=0$; $\\langle x^2\\rangle=\\dfrac{\\hbar}{4am}$; $\\langle p^2\\rangle=am\\hbar$.</p><p>$$\\sigma_x\\sigma_p=\\sqrt{\\frac{\\hbar}{4am}}\\sqrt{am\\hbar}=\\frac{\\hbar}{2}$$ — the Gaussian sits exactly on the floor.</p>')+
   prac('<p>For $\\Psi(x,0)=A(a^2-x^2)$ on $[-a,a]$, show $\\sigma_x=a/\\sqrt7$, $\\sigma_p=\\tfrac{\\hbar}{a}\\sqrt{5/2}$ and hence $\\sigma_x\\sigma_p=\\hbar\\sqrt{5/14}\\approx0.598\\hbar>\\hbar/2$.</p>'))}
`},

/* ═══════════════════ MODULE II ═══════════════════ */
{id:'m2-tise',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'Stationary states',short:'Stationary states &amp; TISE',est:'~16 min',
 body:`
 ${gist('If the potential does not depend on time, $\\Psi$ splits into (a shape in $x$) × (a spinning phase in $t$). The shape obeys the time-independent Schrödinger equation.')}

 ${tp('Separating the variables')}
 <p>When $V$ depends only on position, try a product $\\Psi(x,t)=\\psi(x)\\,\\phi(t)$ and see what the equation demands.</p>

 ${lad('Separation of variables',[
   {why:'Put the product in. Each derivative only touches its own factor.',
    m:'$$i\\hbar\\,\\psi\\,\\frac{d\\phi}{dt}=-\\frac{\\hbar^2}{2m}\\,\\phi\\,\\frac{d^2\\psi}{dx^2}+V(x)\\,\\psi\\phi$$'},
   {why:'Divide everything by $\\psi\\phi$. Now the left side contains only $t$ and the right side only $x$.',
    m:'$$i\\hbar\\,\\frac{1}{\\phi}\\frac{d\\phi}{dt}=-\\frac{\\hbar^2}{2m}\\frac{1}{\\psi}\\frac{d^2\\psi}{dx^2}+V(x)$$'},
   {why:'A function of $t$ can only equal a function of $x$ if both are the same constant. Call it $E$ — it will turn out to be the energy.',
    m:'$$i\\hbar\\frac{1}{\\phi}\\frac{d\\phi}{dt}=E\\;\\Longrightarrow\\;\\phi(t)=e^{-iEt/\\hbar}$$'},
   {why:'The other half is the equation you will solve for the rest of the course.',
    m:'$$\\boxed{\\;-\\frac{\\hbar^2}{2m}\\frac{d^2\\psi}{dx^2}+V(x)\\psi=E\\psi\\;}\\quad\\text{i.e. }\\hat H\\psi=E\\psi$$'}
 ])}
 <p>The time part is <em>universal</em>: whatever the potential, it is always $e^{-iEt/\\hbar}$. All the physics of a particular problem lives in $\\psi(x)$.</p>

 ${tp('Why they are called “stationary”')}
 <p>For $\\Psi=\\psi(x)e^{-iEt/\\hbar}$, the time factor cancels out of everything measurable — three consequences, each worth marks:</p>
 <ol>
   <li><strong>The probability density is frozen.</strong>
     $$|\\Psi|^2=\\psi^{*}e^{+iEt/\\hbar}\\,\\psi e^{-iEt/\\hbar}=|\\psi(x)|^2$$ — no time in it at all.</li>
   <li><strong>Every expectation value is constant.</strong> In particular $\\langle x\\rangle$ never changes, so
     $\\langle p\\rangle=m\\,d\\langle x\\rangle/dt=0$. Nothing moves, on average.</li>
   <li><strong>The energy is perfectly sharp.</strong> Since $\\hat H\\psi=E\\psi$: $\\langle H\\rangle=E$ and $\\langle H^2\\rangle=E^2$, so
     $$\\sigma_H^2=\\langle H^2\\rangle-\\langle H\\rangle^2=E^2-E^2=0$$ Every energy measurement returns exactly $E$.</li>
 </ol>

 ${tp('The general solution, and probability amplitudes')}
 <p>Because the equation is linear, a sum of solutions is a solution. Since each stationary state carries its own phase clock, the general solution is:</p>
 ${must(`$$\\Psi(x,t)=\\sum_n c_n\\,\\psi_n(x)\\,e^{-iE_nt/\\hbar},
 \\qquad c_n=\\int\\psi_n^{*}(x)\\,\\Psi(x,0)\\,dx$$
 <p>The $c_n$ are the <strong>probability amplitudes</strong>, and:</p>
 <ul>
   <li>$|c_n|^2$ = probability that an energy measurement gives $E_n$</li>
   <li>$\\sum_n|c_n|^2=1$</li>
   <li>$\\langle H\\rangle=\\sum_n|c_n|^2E_n$</li>
 </ul>`)}
 <p>This is the master recipe: solve one potential once to get $\\{\\psi_n,E_n\\}$, and you can then evolve <em>any</em> initial state in it.</p>

 ${chk(
   'Show in one line why a stationary state has $\\sigma_H=0$, and say what an energy measurement on it would give.',
   '<p>$\\sigma_H^2=\\langle H^2\\rangle-\\langle H\\rangle^2$. For $\\hat H\\psi=E\\psi$: $$\\langle H\\rangle=\\int\\psi^{*}\\hat H\\psi\\,dx=E\\int|\\psi|^2dx=E,\\qquad \\langle H^2\\rangle=E^2$$ so $\\sigma_H^2=E^2-E^2=0$.</p><p>Every measurement returns the <strong>same</strong> value $E$, with certainty. (Superpose two stationary states and this fails: you would then get $E_1$ or $E_2$ with probabilities $|c_1|^2$ and $|c_2|^2$.)</p>')}
`},

{id:'m2-isw',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'The infinite square well',short:'Infinite square well',est:'~16 min',
 body:`
 ${gist('A particle trapped between two hard walls behaves like a guitar string: only certain standing waves fit, so only certain energies are allowed, and $E_n\\propto n^2$.')}

 ${tp('Setting it up and solving it')}
 <p>The potential is $V=0$ inside $[0,a]$ and $\\infty$ outside. Infinite walls mean the particle can never be outside, so $\\psi=0$ there. Inside, $V=0$ and the equation is</p>
 $$-\\frac{\\hbar^2}{2m}\\frac{d^2\\psi}{dx^2}=E\\psi
   \\quad\\Longrightarrow\\quad
   \\frac{d^2\\psi}{dx^2}=-k^2\\psi,\\qquad k=\\frac{\\sqrt{2mE}}{\\hbar}$$

 ${lad('Quantisation from two boundary conditions',[
   {why:'General solution of that equation — a sine plus a cosine.',
    m:'$$\\psi(x)=A\\sin kx+B\\cos kx$$'},
   {why:'$\\psi$ must be continuous, and it is zero outside. So at the left wall $\\psi(0)=0$ — which kills the cosine.',
    m:'$$\\psi(0)=B=0\\;\\Longrightarrow\\;\\psi=A\\sin kx$$'},
   {why:'At the right wall $\\psi(a)=0$ too. This is where quantisation enters: only special $k$ satisfy it.',
    m:'$$\\sin ka=0\\;\\Longrightarrow\\;k_n=\\frac{n\\pi}{a},\\qquad n=1,2,3,\\dots$$'},
   {why:'Put $k_n$ back into $E=\\hbar^2k^2/2m$.',
    m:'$$\\boxed{\\;E_n=\\frac{n^2\\pi^2\\hbar^2}{2ma^2}\\;}\\qquad(E_n\\propto n^2)$$'},
   {why:'Finally normalize: $\\int_0^a|A|^2\\sin^2(n\\pi x/a)\\,dx=|A|^2a/2=1$.',
    m:'$$\\boxed{\\;\\psi_n(x)=\\sqrt{\\frac2a}\\,\\sin\\!\\Big(\\frac{n\\pi x}{a}\\Big)\\;}$$'}
 ])}

 ${fig('isw',
   'The energy ladder is not evenly spaced. Walls in red; each level $E_n=n^2E_1$ is drawn to scale with its wave function riding on it. The gaps widen as $n^2$: $E_1,4E_1,9E_1,16E_1$. Note $E_1\\ne0$.',
   '<span><i style="border-color:var(--pos)"></i>odd n</span><span><i style="border-color:var(--neg)"></i>even n</span><span><i class="fill" style="background:var(--wall)"></i>infinite wall</span>')}

 ${fig('iswD',
   'Where the particle actually is: $|\\psi_n|^2$ for the first three states. The ground state bulges in the middle; higher states carve the box into $n$ equal humps. All of them give $\\langle x\\rangle=a/2$ by symmetry, but the <em>shape</em> of "likely to be found" changes completely.',
   '<span><i style="border-color:var(--pos)"></i>|ψ₁|²</span><span><i style="border-color:var(--neg)"></i>|ψ₂|²</span><span><i style="border-color:var(--prob)"></i>|ψ₃|²</span>')}

 ${trap(`<p><strong>Why $E=0$ and $E&lt;0$ are impossible</strong> — a standard question.</p>
 <ul>
   <li>$E=0$ gives $\\psi''=0$, so $\\psi=Ax+B$. Both walls then force $A=B=0$: only the trivial zero function, which cannot be normalized.</li>
   <li>$E&lt;0$ gives $\\psi=C\\sinh\\kappa x$ after the left wall, and $\\sinh\\kappa a\\ne0$ forces $C=0$. Again nothing.</li>
 </ul>
 <p>So the well has a hard floor at $E_1$ — the <strong>zero-point energy</strong>. Confinement alone forbids a particle from sitting still, which is uncertainty at work.</p>`)}

 ${chk(
   'You are handed an arbitrary $\\Psi(x,0)$ in the well. How do you find the probability of measuring $E_3$, and how does the state evolve afterwards?',
   '<p>Project onto the third eigenstate: $$c_3=\\sqrt{\\tfrac2a}\\int_0^a\\sin\\!\\Big(\\tfrac{3\\pi x}{a}\\Big)\\Psi(x,0)\\,dx,\\qquad P(E_3)=|c_3|^2$$</p><p>In general expand $\\Psi(x,0)=\\sum_nc_n\\psi_n$ and then $$\\Psi(x,t)=\\sum_n c_n\\psi_n(x)e^{-iE_nt/\\hbar}$$ Each mode just spins its own phase at rate $E_n/\\hbar$. The $|c_n|^2$ never change, so $P(E_n)$ and $\\langle H\\rangle$ are conserved — only the <em>relative</em> phases evolve, and that is what makes $\\langle x\\rangle$ oscillate.</p>')}
`},

{id:'m2-superposition',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'Superposition: putting motion back in',short:'Superposition',est:'~12 min',
 body:`
 ${gist('One stationary state never moves. Mix two and the probability density sloshes back and forth at the beat frequency $(E_2-E_1)/\\hbar$.')}

 ${tp('The two-state mix')}
 <p>Take the simplest non-stationary state — an equal mix of the two lowest levels, $\\Psi(x,0)=\\tfrac{1}{\\sqrt2}(\\psi_1+\\psi_2)$. Attach each phase clock and square:</p>
 $$|\\Psi(x,t)|^2=\\tfrac12\\psi_1^2+\\tfrac12\\psi_2^2
   +\\psi_1\\psi_2\\cos\\!\\Big(\\frac{E_2-E_1}{\\hbar}t\\Big)$$
 <p>The first two terms are static. The <strong>cross term</strong> is the physics: it oscillates, so the probability hump swings from side to side.</p>
 <p>Working out the integrals for the infinite well (with $\\omega=\\pi^2\\hbar/2ma^2$):</p>
 $$\\langle x\\rangle(t)=\\frac a2\\left[1-\\frac{32}{9\\pi^2}\\cos(3\\omega t)\\right],
   \\qquad \\langle p\\rangle=m\\frac{d\\langle x\\rangle}{dt}=\\frac{8\\hbar}{3a}\\sin(3\\omega t)$$

 ${fig('super',
   'A quantum sloshing bob. $|\\Psi(x,t)|^2$ for the equal mix of $\\psi_1$ and $\\psi_2$. The hump swings side to side and the centroid $\\langle x\\rangle$ (gold line) oscillates at $(E_2-E_1)/\\hbar$. Superposing states is what puts <em>motion</em> back into quantum mechanics.',
   '<span><i class="fill" style="background:var(--prob)"></i>|Ψ(x,t)|²</span><span><i style="border-color:var(--pos)"></i>⟨x⟩(t)</span>')}

 ${tp('What an energy measurement gives')}
 <p>For this state the amplitudes are $c_1=c_2=\\tfrac{1}{\\sqrt2}$, so:</p>
 <ul>
   <li>$P(E_1)=P(E_2)=\\tfrac12$ — you get one or the other, never anything between.</li>
   <li>$\\langle H\\rangle=\\tfrac12E_1+\\tfrac12E_2=\\tfrac52E_1$.</li>
 </ul>
 <p>For a general starting shape you expand in the sine basis. For example the parabola $\\Psi(x,0)=Ax(a-x)$ gives $c_n=\\tfrac{8\\sqrt{15}}{(n\\pi)^3}$ for odd $n$ (and zero for even $n$), so $P(E_1)=960/\\pi^6\\approx0.9986$ — almost pure ground state, because a smooth hump looks very like $\\psi_1$.</p>

 ${chk(
   'For $\\Psi=\\tfrac{1}{\\sqrt2}(\\psi_1+\\psi_2)$, at what frequency does the density oscillate — and why is $\\langle H\\rangle$ constant when $\\langle x\\rangle$ is not?',
   '<p>The density oscillates at $\\omega_{21}=\\dfrac{E_2-E_1}{\\hbar}$: only the <em>relative</em> phase between the two modes matters, and it advances at that beat rate.</p><p>$\\langle x\\rangle$ moves because the cross term $\\psi_1\\psi_2\\cos\\omega_{21}t$ shifts probability from side to side. But $\\langle H\\rangle=\\tfrac12E_1+\\tfrac12E_2$ depends only on the $|c_n|^2$, which never change — energy is conserved.</p><p><strong>Motion lives in the phases; energy lives in the amplitudes.</strong></p>')}
`},

{id:'m2-free',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'The free particle and wave packets',short:'Free particle',est:'~16 min',
 body:`
 ${gist('A single plane wave is not normalizable, so a real free particle is a <b>packet</b> of many wavelengths — and the packet travels at the <b>group</b> velocity, twice the phase velocity.')}

 ${tp('The problem with a single plane wave')}
 <p>With $V=0$ everywhere the equation gives $\\psi=Ae^{ikx}+Be^{-ikx}$, and with the time factor,</p>
 $$\\Psi_k(x,t)=Ae^{i(kx-\\omega t)},\\qquad \\omega=\\frac{\\hbar k^2}{2m}$$
 <p>But $|\\Psi_k|^2=|A|^2$ is the <em>same everywhere</em>, so the total probability is infinite. A single plane wave is <strong>not normalizable</strong> and cannot represent a real particle.</p>
 <p>The fix: superpose a continuous range of $k$ into a localised <strong>wave packet</strong>:</p>
 $$\\Psi(x,t)=\\frac{1}{\\sqrt{2\\pi}}\\int_{-\\infty}^{\\infty}\\phi(k)\\,e^{i(kx-\\omega(k)t)}\\,dk$$
 <p>where $\\phi(k)$ (the Fourier transform of $\\Psi(x,0)$) says how much of each wavelength you mixed in. Unlike the well, $k$ here is <em>continuous</em> — the free particle has no quantised energies.</p>

 ${tp('Phase velocity vs group velocity')}
 <p>Now a puzzle that is a guaranteed exam question. The speed of a point of constant phase is</p>
 $$v_{\\text{phase}}=\\frac{\\omega}{k}=\\frac{\\hbar k}{2m}=\\sqrt{\\frac{E}{2m}}$$
 <p>but a classical particle of that energy moves at $v=\\sqrt{2E/m}$ — <strong>twice as fast</strong>. Has something gone wrong?</p>
 <p>No. A single phase point carries no particle and no information. What carries the particle is the <em>envelope</em> of the packet, and that moves at the <strong>group velocity</strong>:</p>
 ${must(`$$v_{\\text{group}}=\\frac{d\\omega}{dk}\\bigg|_{k_0}=\\frac{\\hbar k_0}{m}=v_{\\text{classical}}=2\\,v_{\\text{phase}}$$`)}

 ${fig('phasegroup',
   'Two speeds in one wave. The fast ripples (the carrier) travel at $v_{\\text{phase}}$; the slow dashed envelope — the beat between nearby $k$ values — travels at $v_g=2v_{\\text{phase}}$. The particle rides the envelope.',
   '<span><i style="border-color:var(--pos)"></i>carrier · vₚ</span><span><i class="dash" style="border-color:var(--neg)"></i>envelope · v_g</span>')}

 ${fig('packet',
   'Dispersion. A Gaussian packet starting from the dashed profile flattens and widens as time runs, because faster (higher-$k$) components outrun slower ones. Its area stays exactly 1 throughout — the particle is not disappearing, just becoming less localised.',
   '<span><i class="fill" style="background:var(--prob)"></i>|Ψ(x,t)|²</span><span><i class="dash" style="border-color:var(--ink)"></i>t = 0</span>')}

 ${chk(
   'A student computes the phase velocity of a free-particle plane wave, finds it is half the classical speed, and panics. Resolve it.',
   '<p>There is no contradiction. $v_{\\text{phase}}=\\omega/k=\\hbar k/2m$ is the speed of a point of constant phase on an <em>infinite, unlocalised</em> wave. That wave carries no particle and no information, so nothing requires it to match a particle speed.</p><p>A real particle is a <strong>packet</strong>, and its envelope moves at $$v_g=\\frac{d\\omega}{dk}=\\frac{\\hbar k}{m}=\\sqrt{\\frac{2E}{m}}$$ which <em>is</em> the classical speed, and equals $2v_{\\text{phase}}$. The factor of two is expected, not a mistake.</p>')}
`},

{id:'m2-current',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'Conservation of probability',short:'Probability current',est:'~10 min',
 body:`
 ${gist('Probability is not created or destroyed — it <b>flows</b>, obeying a continuity equation just like electric charge.')}

 ${tp('The current, and the continuity equation')}
 <p>In the normalization proof you met a bracket that turned out to be a perfect $x$-derivative. That bracket has a name: the <strong>probability current density</strong>.</p>
 ${must(`$$J(x,t)=\\frac{i\\hbar}{2m}\\left(\\Psi\\frac{\\partial\\Psi^{*}}{\\partial x}-\\Psi^{*}\\frac{\\partial\\Psi}{\\partial x}\\right)
 =\\frac{\\hbar}{m}\\,\\mathrm{Im}\\!\\left(\\Psi^{*}\\frac{\\partial\\Psi}{\\partial x}\\right)$$
 <p>With $\\rho=|\\Psi|^2$ as the probability density, these obey the <strong>equation of continuity</strong>:</p>
 $$\\frac{\\partial\\rho}{\\partial t}+\\frac{\\partial J}{\\partial x}=0$$`)}
 <p><strong>How to interpret it.</strong> This is exactly the equation that describes a conserved fluid or electric charge. It says: the only way the probability inside a region can change is by <em>flowing across its edges</em>. Integrating between $a$ and $b$:</p>
 $$\\frac{dP_{ab}}{dt}=J(a,t)-J(b,t)
   \\quad=\\quad(\\text{what flows in at }a)-(\\text{what flows out at }b)$$
 <p>Units: $J$ has units of probability per unit time (s⁻¹). Stretch the region to the whole line and both ends vanish, giving back $dP/dt=0$ — normalization conserved, as before.</p>

 ${trap(`<p>A quick way to spot $J=0$: if $\\Psi$ can be written as a <strong>real</strong> function of $x$ times a phase, $\\Psi=\\psi(x)e^{-i\\omega t}$ with $\\psi$ real, then $\\Psi^*\\partial_x\\Psi=\\psi\\psi'$ is real, so its imaginary part is zero and $J=0$ everywhere.</p>
 <p>That is why bound states carry no current — they are standing waves, going nowhere on average. Travelling states like $e^{ikx}$ have a complex $\\psi$ and give $J=\\dfrac{\\hbar k}{m}|A|^2=v\\rho$, which is exactly "density × velocity", as you would want.</p>`)}

 ${chk(
   'Compute $J$ for $\\Psi(x,t)=\\psi(x)e^{-i\\omega t}$ with $\\psi$ real, and interpret the answer.',
   '<p>$\\Psi^{*}\\partial_x\\Psi=\\psi e^{i\\omega t}\\,\\psi\'e^{-i\\omega t}=\\psi\\psi\'$, which is <strong>real</strong>. So $\\mathrm{Im}(\\Psi^*\\partial_x\\Psi)=0$ and therefore $$J=0\\ \\text{everywhere}$$</p><p>A real spatial wave function carries <strong>no probability flow</strong> — it is a standing state, not a travelling one. This is the same reason bound states have $\\langle p\\rangle=0$: nothing is going anywhere on average.</p>')}
`},

{id:'m2-step',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'The potential step',short:'Potential step',est:'~13 min',
 body:`
 ${gist('At a sudden jump in potential, match $\\psi$ and $\\psi\'$ across the boundary. Even with enough energy to pass, part of the wave reflects — which is purely quantum.')}

 ${tp('The matching rules')}
 <p>Scattering states are unbound, so they cannot be normalized to 1. Instead we compare <em>currents</em> and quote ratios. At any step where $V$ is finite:</p>
 ${must(`<ol><li>$\\psi$ is continuous across the boundary;</li>
 <li>$d\\psi/dx$ is continuous across the boundary.</li></ol>
 <p>(The second fails only where $V$ is infinite or a delta spike.) Two conditions, two unknowns — that is the whole method.</p>`)}
 <p>Define $$R=\\frac{\\text{reflected current}}{\\text{incident current}},\\qquad T=\\frac{\\text{transmitted current}}{\\text{incident current}},\\qquad R+T=1$$</p>

 ${tp('Case 1: E > V₀')}
 <p>With $k_1=\\dfrac{\\sqrt{2mE}}{\\hbar}$ on the left and $k_2=\\dfrac{\\sqrt{2m(E-V_0)}}{\\hbar}$ on the right, write $\\psi_1=Ae^{ik_1x}+Be^{-ik_1x}$ and $\\psi_2=Ce^{ik_2x}$ (nothing comes back from the far right). Matching at $x=0$:</p>
 $$A+B=C,\\qquad k_1(A-B)=k_2C
   \\;\\Longrightarrow\\;
   \\frac BA=\\frac{k_1-k_2}{k_1+k_2},\\qquad \\frac CA=\\frac{2k_1}{k_1+k_2}$$
 ${must(`$$R=\\left(\\frac{k_1-k_2}{k_1+k_2}\\right)^{2},\\qquad
 T=\\frac{4k_1k_2}{(k_1+k_2)^2},\\qquad R+T=1$$`)}
 ${trap(`<p>$T$ is <strong>not</strong> just $|C/A|^2$. The transmitted wave moves at a different speed, so you must include the flux factor: $T=\\dfrac{k_2}{k_1}\\left|\\dfrac CA\\right|^2$. Forgetting that $k_2/k_1$ is the single most common error in this topic.</p>`)}
 <p>The striking result: $R\\ne0$ even though the particle has more than enough energy. Classically it would always continue; quantum mechanically any sudden change in the medium reflects part of the wave — exactly like light hitting glass.</p>

 ${fig('stepHigh',
   'E > V₀. The wave continues past the step but with a longer wavelength (lower kinetic energy), and part of it reflects — a wave effect with no classical counterpart.',
   '<span><i style="border-color:var(--pos)"></i>incident + reflected</span><span><i style="border-color:var(--neg)"></i>transmitted (longer λ)</span>')}

 ${tp('Case 2: E < V₀')}
 <p>Now the far side is classically forbidden. Put $k_2\\to i\\kappa$ with $\\kappa=\\dfrac{\\sqrt{2m(V_0-E)}}{\\hbar}$, so the right-hand solution becomes a decaying exponential $Ce^{-\\kappa x}$ instead of a travelling wave. Matching gives</p>
 $$\\frac BA=\\frac{k_1-i\\kappa}{k_1+i\\kappa}
   \\;\\Longrightarrow\\;
   R=\\left|\\frac BA\\right|^2=1,\\qquad T=0$$
 <p>So the particle is <strong>certainly</strong> reflected. But — and this is the important part — $\\psi$ is <em>not zero</em> inside the forbidden region. It leaks in as an <strong>evanescent</strong> tail with penetration depth $\\delta=1/\\kappa$ before dying away.</p>

 ${fig('stepLow',
   'E < V₀. Total reflection ($R=1$), yet the wave function penetrates the forbidden region as a decaying exponential with depth $\\delta=1/\\kappa$. That leakage is what makes tunnelling possible when the barrier is finite in width.',
   '<span><i style="border-color:var(--pos)"></i>incident + reflected</span><span><i style="border-color:var(--neg)"></i>evanescent tail</span>')}

 ${chk(
   'For $E&lt;V_0$ at a step, $R=1$ — the particle always bounces back. So why does the wave function bother penetrating the barrier at all?',
   '<p>Because $\\psi$ must be <strong>continuous</strong> at the boundary. It cannot drop to zero instantly, so it must continue into the forbidden region — and the only solution there that stays finite is the decaying exponential $e^{-\\kappa x}$.</p><p>Nothing is <em>transmitted</em> ($T=0$) because a real decaying exponential carries no current: it is a real function times a phase, so $J=0$. The particle is certainly reflected, yet it has a non-zero probability of being <em>found</em> a short distance inside the wall.</p><p>This matters enormously: make the barrier <em>finite in width</em> and the tail is still non-zero when it reaches the far side — which is exactly <strong>tunnelling</strong>, the next section.</p>')}
`},

{id:'m2-barrier',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'The barrier and tunnelling',short:'Barrier &amp; tunnelling',est:'~13 min',
 body:`
 ${gist('Give the barrier a finite width and the leaking tail reaches the far side — so a particle with too little energy can still come out. That is tunnelling.')}

 ${tp('Case E < V₀ — tunnelling')}
 <p>A barrier of height $V_0$ and width $a$: free on both sides, forbidden in the middle. Three regions, so you write a wave on the left (incident + reflected), decaying exponentials inside, and a transmitted wave on the right — then match $\\psi$ and $\\psi'$ at both boundaries. Solving gives</p>
 ${must(`$$T=\\left[1+\\frac{V_0^{2}}{4E(V_0-E)}\\sinh^{2}(\\kappa a)\\right]^{-1},
 \\qquad \\kappa=\\frac{\\sqrt{2m(V_0-E)}}{\\hbar}$$
 <p>and for a thick or high barrier ($\\kappa a\\gg1$), using $\\sinh\\kappa a\\approx\\tfrac12e^{\\kappa a}$:</p>
 $$T\\approx16\\,\\frac{E}{V_0}\\left(1-\\frac{E}{V_0}\\right)e^{-2\\kappa a}$$`)}
 <p>$T\\ne0$ even though $E&lt;V_0$ — classically impossible. The particle appears on the far side without ever having had enough energy to be on top of the barrier.</p>
 <p>Note how <strong>fiercely</strong> $T$ depends on the barrier through $e^{-2\\kappa a}$: double the width and you <em>square</em> the (already tiny) probability. This exponential sensitivity is why $\\alpha$-decay half-lives span twenty orders of magnitude, and why a scanning tunnelling microscope can resolve single atoms.</p>

 ${fig('barrier',
   'Tunnelling, drawn from the matched solution. The incident wave meets the barrier, decays exponentially inside it, and emerges on the far side with a smaller amplitude but the same wavelength (same energy). Nothing accumulates inside — what leaks through is the transmitted wave.',
   '<span><i style="border-color:var(--pos)"></i>incident</span><span><i style="border-color:var(--neg)"></i>decaying inside</span><span><i style="border-color:var(--prob)"></i>transmitted</span>')}

 ${tp('Case E > V₀ — resonances')}
 <p>With enough energy to pass over the barrier, the inside solution becomes oscillatory again ($\\kappa\\to ik_2$), so $\\sinh^2\\to\\sin^2$:</p>
 $$T=\\left[1+\\frac{V_0^{2}}{4E(E-V_0)}\\sin^{2}(k_2a)\\right]^{-1},
   \\qquad k_2=\\frac{\\sqrt{2m(E-V_0)}}{\\hbar}$$
 <p>Classically $T$ would simply jump to 1. Quantum mechanically it <em>ripples</em>, and reaches exactly $T=1$ whenever $\\sin(k_2a)=0$:</p>
 ${must(`$$k_2a=n\\pi\\qquad\\Longrightarrow\\qquad \\text{perfect transmission (resonance)}$$
 <p>Physically: a whole number of half-wavelengths fits inside the barrier, so the reflections from the two walls cancel out and the barrier becomes invisible.</p>`)}

 ${fig('transE',
   'Transmission against energy. For $E&lt;V_0$ (shaded) $T$ climbs up out of tunnelling. For $E>V_0$ it oscillates and touches $T=1$ at the resonances where $k_2a=n\\pi$. Classically $T$ would jump straight from 0 to 1 at $E=V_0$; quantum mechanics smooths it and then makes it ripple.',
   '<span><i style="border-color:var(--prob)"></i>T(E)</span><span><i class="dash" style="border-color:var(--wall)"></i>E = V₀</span>')}

 ${chk(
   'Two barriers have the same height, but barrier B is twice as wide as A. In the thick-barrier limit, how do their tunnelling probabilities compare?',
   '<p>In the thick limit $T\\approx(\\text{prefactor})\\,e^{-2\\kappa a}$. Doubling the width, $a\\to2a$, turns the exponential into $$e^{-4\\kappa a}=\\left(e^{-2\\kappa a}\\right)^{2}$$ so $T_B\\approx T_A^{\\,2}$.</p><p>If A transmits $10^{-3}$, B transmits about $10^{-6}$ — the probability is <strong>squared</strong>, not halved. This exponential-in-width behaviour is exactly why tunnelling rates are so extraordinarily sensitive to small changes in the barrier.</p>')}
`},

/* ═══════════════════ MODULE II · PROBLEMS ═══════════════════ */
{id:'m2-problems',mod:'Module II',modName:'Time-Independent Schrödinger Eq.',modClass:'m2',
 title:'Problems — Module II',short:'Problems II',est:'~20 min',
 body:`
 <p class="lead">Module II carries 20 marks — twice Module I. These six are the highest-yield types from the prescribed sections.</p>

 ${tp('The infinite square well')}
 ${prob('1','All four moments in the n-th state',
   pq('For the $n$-th stationary state of the infinite square well, $$\\psi_n(x)=\\sqrt{\\frac2a}\\,\\sin\\!\\Big(\\frac{n\\pi x}{a}\\Big)$$ calculate $\\langle x\\rangle$, $\\langle x^2\\rangle$, $\\langle p\\rangle$, $\\langle p^2\\rangle$, $\\sigma_x$ and $\\sigma_p$. Verify the uncertainty principle, and determine which state comes closest to the uncertainty limit.')+
   pth('<p>$\\langle x\\rangle=a/2$ by symmetry; $\\langle p\\rangle=0$ because $\\psi_n$ is real; $\\langle p^2\\rangle=2mE_n$.</p>')+
   psol('<p>$\\langle x\\rangle=\\dfrac a2$, and $\\langle x^2\\rangle=a^2\\left(\\dfrac13-\\dfrac{1}{2n^2\\pi^2}\\right)$, so $$\\sigma_x=a\\sqrt{\\tfrac1{12}-\\tfrac1{2n^2\\pi^2}}$$</p><p>$\\langle p\\rangle=0$; $\\langle p^2\\rangle=2mE_n=\\dfrac{n^2\\pi^2\\hbar^2}{a^2}$, so $\\sigma_p=\\dfrac{n\\pi\\hbar}{a}$.</p><p>$$\\sigma_x\\sigma_p=\\hbar\\sqrt{\\tfrac{n^2\\pi^2}{12}-\\tfrac12}$$ For $n=1$ this is $\\approx0.568\\hbar>\\hbar/2$ ✓, and it grows with $n$ — so the <strong>ground state comes closest</strong> to the uncertainty limit.</p>')+
   prac('<p>For the centred well ($-a/2\\le x\\le a/2$), compute all four moments and show $\\sigma_x\\sigma_p$ is unchanged.</p>'))}

 ${prob('2','Superposition Ψ = A(ψ₁ + ψ₂) — full evolution',
   pq('A particle in the infinite square well starts out in the state $$\\Psi(x,0)=A\\left[\\psi_1(x)+\\psi_2(x)\\right]$$ <b>(1)</b> Normalize $\\Psi(x,0)$ to find $A$. <b>(2)</b> Find $\\Psi(x,t)$ and $|\\Psi(x,t)|^2$. <b>(3)</b> Compute $\\langle x\\rangle(t)$, and state the frequency and amplitude of its oscillation. <b>(4)</b> Compute $\\langle p\\rangle(t)$. <b>(5)</b> Find the possible outcomes of an energy measurement, their probabilities, and $\\langle H\\rangle$.')+
   pth('<p>Normalize using orthonormality ($\\int\\psi_m\\psi_n=\\delta_{mn}$). Attach $e^{-iE_nt/\\hbar}$. The cross term gives the oscillation; $\\langle p\\rangle=m\\,d\\langle x\\rangle/dt$.</p>')+
   psol('<p>$A=1/\\sqrt2$ (since $1+1=2$).</p><p>$|\\Psi|^2=\\tfrac12\\psi_1^2+\\tfrac12\\psi_2^2+\\psi_1\\psi_2\\cos3\\omega t$, with $\\omega=\\pi^2\\hbar/2ma^2$.</p><p>Using $\\int_0^a x\\psi_1\\psi_2\\,dx=-\\dfrac{16a}{9\\pi^2}$: $$\\langle x\\rangle=\\frac a2\\left[1-\\frac{32}{9\\pi^2}\\cos3\\omega t\\right]$$ oscillating at $3\\omega$ with amplitude $\\approx0.18a$, and $\\langle p\\rangle=\\dfrac{8\\hbar}{3a}\\sin3\\omega t$.</p><p>Energies $E_1,E_2$ each with probability $\\tfrac12$; $\\langle H\\rangle=\\tfrac52E_1$.</p>')+
   prac('<p>Take $\\Psi=A(\\psi_1+2\\psi_3)$. Normalize, find the allowed energies with their probabilities, and find $\\langle H\\rangle$.</p>'))}

 ${prob('3','Expanding a given shape in the sine basis',
   pq('A particle in the infinite square well of width $a$ has the initial wave function $$\\Psi(x,0)=Ax(a-x),\\qquad 0\\le x\\le a$$ <b>(1)</b> Normalize to find $A$. <b>(2)</b> Expand $\\Psi(x,0)$ in the eigenfunctions $\\psi_n(x)$ and construct $\\Psi(x,t)$. <b>(3)</b> Compute the probability $P(E_1)$ of measuring the ground-state energy. <b>(4)</b> Calculate $\\langle H\\rangle$.')+
   pth('<p>$c_n=\\sqrt{2/a}\\displaystyle\\int_0^a\\Psi(x,0)\\sin(n\\pi x/a)\\,dx$. Useful sums: $\\sum_{\\text{odd}}n^{-6}=\\pi^6/960$, $\\sum_{\\text{odd}}n^{-4}=\\pi^4/96$.</p>')+
   psol('<p>For $\\Psi(x,0)=Ax(a-x)$: normalizing gives $A=\\sqrt{30/a^5}$.</p><p>Integrating by parts twice, $c_n=0$ for even $n$ and $c_n=\\dfrac{8\\sqrt{15}}{(n\\pi)^3}$ for odd $n$.</p><p>$P(E_1)=|c_1|^2=\\dfrac{960}{\\pi^6}\\approx0.9986$ — the parabola is almost pure ground state.</p><p>$\\langle H\\rangle=\\sum|c_n|^2E_n=\\dfrac{5\\hbar^2}{ma^2}$.</p>')+
   prac('<p>Do the same for the triangular start ($Ax$ up to $a/2$, then $A(a-x)$): find $A$, the $c_n$, and $P(E_1)$.</p>'))}

 ${tp('Free particle &amp; scattering')}
 ${prob('4','Gaussian free packet — spreading',
   pq('A free particle has the initial Gaussian wave function $$\\Psi(x,0)=Ae^{-ax^2},\\qquad a>0$$ <b>(1)</b> Normalize the state. <b>(2)</b> Find $\\Psi(x,t)$ and $|\\Psi(x,t)|^2$. <b>(3)</b> Calculate $\\langle x\\rangle$, $\\langle p\\rangle$, $\\langle x^2\\rangle$, $\\langle p^2\\rangle$, $\\sigma_x$ and $\\sigma_p$. <b>(4)</b> Show that the uncertainty principle is satisfied, and identify the time at which the packet has minimum uncertainty.')+
   pth('<p>Fourier-transform $Ae^{-ax^2}$ to get $\\phi(k)$, evolve each $k$ with $e^{-i\\hbar k^2t/2m}$, recombine. Momentum spread stays fixed; position spread grows.</p>')+
   psol('<p>$A=(2a/\\pi)^{1/4}$, and $|\\Psi(x,t)|^2$ stays Gaussian with width parameter $w(t)=\\sqrt{\\dfrac{a}{1+(2\\hbar at/m)^2}}$.</p><p>$\\langle x\\rangle=\\langle p\\rangle=0$; $$\\sigma_x(t)=\\frac{1}{2\\sqrt a}\\sqrt{1+\\left(\\frac{2\\hbar at}{m}\\right)^{2}},\\qquad \\sigma_p=\\hbar\\sqrt a$$</p><p>$\\sigma_x\\sigma_p=\\dfrac\\hbar2\\sqrt{1+(2\\hbar at/m)^2}\\ge\\dfrac\\hbar2$, with equality <strong>only at $t=0$</strong>. The packet is minimum-uncertainty at the start and spreads thereafter.</p>')+
   prac('<p>For a boosted packet $Ae^{-ax^2}e^{ik_0x}$, find $\\langle x\\rangle(t)$ and $\\langle p\\rangle(t)$, and show the spreading rate does not depend on $k_0$.</p>'))}

 ${prob('5','Potential step with E > V₀ — derive R and T',
   pq('A beam of particles of mass $m$ and energy $E>V_0$ is incident from the left on the potential step $$V(x)=\\begin{cases}0,&x&lt;0\\\\ V_0,&x\\ge0\\end{cases}$$ Derive the reflection coefficient $R$ and the transmission coefficient $T$, and show that $R+T=1$.')+
   pth('<p>Two regions; match $\\psi$ and $\\psi\'$ at $x=0$. Currents are $J=\\hbar k|{\\rm amp}|^2/m$, so $T$ carries a factor $k_2/k_1$.</p>')+
   psol('<p>From $A+B=C$ and $k_1(A-B)=k_2C$: $$\\frac BA=\\frac{k_1-k_2}{k_1+k_2},\\qquad \\frac CA=\\frac{2k_1}{k_1+k_2}$$</p><p>$R=\\left|\\dfrac BA\\right|^2=\\left(\\dfrac{k_1-k_2}{k_1+k_2}\\right)^2$ and $T=\\dfrac{k_2}{k_1}\\left|\\dfrac CA\\right|^2=\\dfrac{4k_1k_2}{(k_1+k_2)^2}$.</p><p>Sum: $\\dfrac{(k_1-k_2)^2+4k_1k_2}{(k_1+k_2)^2}=\\dfrac{(k_1+k_2)^2}{(k_1+k_2)^2}=1$ ✓</p>')+
   prac('<p>Repeat for a downward step ($V=-V_0$ for $x\\ge0$): find $R$ and $T$ in terms of $E/V_0$. Does a drop in potential also reflect?</p>'))}

 ${prob('6','Barrier with E < V₀ — tunnelling and the thick limit',
   pq('For a rectangular potential barrier of width $a$ and height $V_0$, $$V(x)=\\begin{cases}0,&x&lt;0\\\\ V_0,&0\\le x\\le a\\\\ 0,&x>a\\end{cases}$$ derive the transmission coefficient for the tunnelling case $E&lt;V_0$, and establish the wide-barrier (thick-barrier) approximation.')+
   pth('<p>Three regions; inside uses real exponentials $e^{\\pm\\kappa x}$. Solve for $F/A$, take $|F/A|^2$, then use $\\sinh\\kappa a\\approx\\tfrac12e^{\\kappa a}$.</p>')+
   psol('<p>Matching at both walls gives $$T=\\left[1+\\frac{V_0^2}{4E(V_0-E)}\\sinh^2(\\kappa a)\\right]^{-1}$$</p><p>For $\\kappa a\\gg1$, $\\sinh^2\\kappa a\\approx\\tfrac14e^{2\\kappa a}$, so $$T\\approx16\\frac{E}{V_0}\\left(1-\\frac{E}{V_0}\\right)e^{-2\\kappa a}$$ dominated by the exponential in the width $a$ and in $\\sqrt{V_0-E}$.</p>')+
   prac('<p>For $E>V_0$ show $T=\\left[1+\\dfrac{V_0^2}{4E(E-V_0)}\\sin^2(k_2a)\\right]^{-1}$, and find the energies at which $T=1$.</p>'))}
`},

/* ═══════════════════ CLOSE ═══════════════════ */
{id:'close',title:'Last pass before the exam',short:'Final checklist',est:'~8 min',
 body:`
 ${gist('Close the app and try to write all of this from memory. Whatever you cannot recall is your revision list.')}

 ${tp('Formulas you must write cold')}
 <ul>
   <li>$i\\hbar\\partial_t\\Psi=-\\tfrac{\\hbar^2}{2m}\\partial_x^2\\Psi+V\\Psi$ &nbsp;·&nbsp; $P_{ab}=\\int_a^b|\\Psi|^2dx$ &nbsp;·&nbsp; $\\int|\\Psi|^2dx=1$</li>
   <li>$\\sigma^2=\\langle x^2\\rangle-\\langle x\\rangle^2$ &nbsp;·&nbsp; $\\hat x=x$, $\\hat p=-i\\hbar\\partial_x$, $\\hat T=-\\tfrac{\\hbar^2}{2m}\\partial_x^2$</li>
   <li>$\\langle Q\\rangle=\\int\\Psi^{*}\\hat Q\\Psi\\,dx$ &nbsp;·&nbsp; Ehrenfest: $\\tfrac{d\\langle x\\rangle}{dt}=\\tfrac{\\langle p\\rangle}{m}$, $\\tfrac{d\\langle p\\rangle}{dt}=\\langle-\\partial_xV\\rangle$</li>
   <li>$\\sigma_x\\sigma_p\\ge\\hbar/2$ (equality only for a Gaussian)</li>
   <li>TISE $-\\tfrac{\\hbar^2}{2m}\\psi''+V\\psi=E\\psi$ &nbsp;·&nbsp; $\\phi(t)=e^{-iEt/\\hbar}$ &nbsp;·&nbsp; $\\Psi=\\sum c_n\\psi_ne^{-iE_nt/\\hbar}$, $c_n=\\int\\psi_n^{*}\\Psi(x,0)dx$, $P(E_n)=|c_n|^2$</li>
   <li>Well: $E_n=\\tfrac{n^2\\pi^2\\hbar^2}{2ma^2}$, $\\psi_n=\\sqrt{2/a}\\sin(n\\pi x/a)$</li>
   <li>Free: $v_{\\rm ph}=\\tfrac{\\hbar k}{2m}$, $v_g=\\tfrac{\\hbar k}{m}=2v_{\\rm ph}$</li>
   <li>$J=\\tfrac{\\hbar}{m}{\\rm Im}(\\Psi^{*}\\partial_x\\Psi)$ &nbsp;·&nbsp; $\\partial_t\\rho+\\partial_xJ=0$</li>
   <li>Step: $R=\\left(\\tfrac{k_1-k_2}{k_1+k_2}\\right)^2$, $T=\\tfrac{4k_1k_2}{(k_1+k_2)^2}$, $R+T=1$</li>
   <li>Barrier: $T=\\left[1+\\tfrac{V_0^2}{4E(V_0-E)}\\sinh^2\\kappa a\\right]^{-1}\\to16\\tfrac{E}{V_0}(1-\\tfrac{E}{V_0})e^{-2\\kappa a}$; resonance at $k_2a=n\\pi$</li>
 </ul>

 ${tp('Derivations worth rehearsing')}
 <ol>
   <li>Conservation of normalization (the perfect-derivative trick).</li>
   <li>$\\hat p=-i\\hbar\\partial_x$ from $d\\langle x\\rangle/dt$.</li>
   <li>Separation of variables → TISE, plus the three properties of stationary states.</li>
   <li>Infinite well: $E_n$ and $\\psi_n$ from the two boundary conditions.</li>
   <li>Step: $R$ and $T$ with $R+T=1$ (remember the $k_2/k_1$ flux factor).</li>
   <li>Barrier: $T$ for $E&lt;V_0$ and the thick-barrier limit.</li>
 </ol>

 ${tp('Short answers that recur')}
 <ul>
   <li>Statistical interpretation; the three positions on “where was it before?”; Bell.</li>
   <li>Why $\\Psi$ must be square-integrable; why the global phase is unobservable.</li>
   <li>Why you cannot get $\\langle p\\rangle$ from $m\\,d\\langle x\\rangle/dt$ given only $\\Psi(x,0)$.</li>
   <li>Why a stationary state has $\\sigma_H=0$ and $\\langle p\\rangle=0$.</li>
   <li>Why $E\\le0$ is impossible in the infinite well.</li>
   <li>Phase vs group velocity — and why the factor 2 is not a paradox.</li>
   <li>Interpretation of the continuity equation; why $J=0$ for a real $\\psi$.</li>
   <li>Reflection even when $E>V_0$; penetration even when $T=0$; tunnelling; resonances.</li>
 </ul>

 ${trap(`<p>Three habits that save marks: <strong>state your conventions first</strong> ($k_1=\\sqrt{2mE}/\\hbar$, label the regions) before matching; <strong>carry the flux factor</strong> $k_2/k_1$ in $T$; and <strong>sanity-check</strong> — probabilities in $[0,1]$, $R+T=1$, $\\sigma_x\\sigma_p\\ge\\hbar/2$.</p>`)}

 <p class="dim" style="margin-top:1.4rem;text-align:center"><span class="spark">ψ</span>&nbsp; Then sleep. It helps more than another hour of reading.</p>
`},

];
window.STATIONS=STATIONS;

/* ── module grouping: Module ▸ Section ▸ Topic ── */
const MODULES=[
 {id:'mod-0',name:'Start',sub:'Read this first',
  stations:['start']},
 {id:'mod-1',name:'Module I',sub:'The Wave Function &nbsp;·&nbsp; 10 marks',
  stations:['m1-schrodinger','m1-born','m1-probability','m1-normalization',
            'm1-momentum','m1-uncertainty','m1-problems']},
 {id:'mod-2',name:'Module II',sub:'Time-Independent Schrödinger Equation &nbsp;·&nbsp; 20 marks',
  stations:['m2-tise','m2-isw','m2-superposition','m2-free','m2-current',
            'm2-step','m2-barrier','m2-problems']},
 {id:'mod-3',name:'Final checklist',sub:'Last pass before the exam',
  stations:['close']}
];
window.MODULES=MODULES;
