/* ══════════════════════════════════════════════════════════════════
   Solid State · Modules I–II — EXAM-NIGHT EDITION
   Written for someone meeting this topic for the first time.
   Plain words first, symbol second. Nothing that won't earn marks.
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
function fig3d(name,cap,leg){
  return `<figure class="fig is3d"><div class="cvwrap"><canvas data-v3d="${name}"></canvas></div>
    ${leg?`<div class="leg">${leg}</div>`:''}
    <figcaption><b>Spin it.</b> ${cap}</figcaption></figure>`;
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
function paper(name,time,marks){
  return `<div class="paperhead"><b>${name}</b>
    <div class="meta"><span>Time: ${time}</span><span>Max marks: ${marks}</span></div></div>`;}
function secband(letter,rubric){
  return `<div class="secband"><b>Section ${letter}</b><span>${rubric}</span></div>`;}
function qa(marks,q,ans){
  return `<details class="prob qa"><summary><span class="pn">${marks}</span>
    <span class="pt">${q}</span><span class="chev">›</span></summary>
    <div class="pbody"><div class="qmeta">model answer</div>${ans}</div></details>`;}
function must(html){return `<div class="note key"><div class="nh">learn this by heart</div>${html}</div>`;}
function trap(html){return `<div class="note pitfall"><div class="nh">where marks get lost</div>${html}</div>`;}

const STATIONS=[

/* ═══════════════════ ORIENTATION ═══════════════════ */
{id:'start',hero:true,title:'Solid State Physics',short:'Read this first',est:'~5 min',
 body:`
 <p class="lead">Everything in Modules I and II, written from zero — no prior solid state assumed.
 About <strong>four hours</strong> end to end. Work top to bottom and tick as you go.</p>

 ${tp('Your plan for tonight')}
 <div class="plan">
   <div class="slot"><span class="when">2 h</span><div class="what"><b>Module I — crystals &amp; X-rays</b>
     <span>Read each topic once, answer the checkpoint <em>before</em> revealing it, then do the problems at the end of the module. Don't re-read — the checkpoint is the study.</span></div></div>
   <div class="slot"><span class="when">1½ h</span><div class="what"><b>Module II — electrons in solids</b>
     <span>Same pattern. This module is more formula-driven, so copy every boxed formula onto one sheet as you go. That sheet is your morning revision.</span></div></div>
   <div class="slot"><span class="when">½ h</span><div class="what"><b>Last pass, then sleep</b>
     <span>Close the app and redo every checkpoint from memory. Whatever you can't recall is exactly what to glance at in the morning. Then actually sleep — sleep is what files it.</span></div></div>
 </div>

 ${tp('How to read this')}
 <p>Each section opens with an <strong>in one line</strong> box — the whole idea in a sentence. Then two or three short topics. A <strong>learn this by heart</strong> box is a formula you should be able to write cold; a <strong>where marks get lost</strong> box is a mistake examiners see every single year.</p>
 <p>The 3-D pictures can be <strong>dragged to rotate</strong> (drag sideways on a phone) and zoomed with pinch or the <b>+ −</b> buttons. Give each one ten seconds — for crystal structures, rotating a shape teaches faster than a paragraph does.</p>

 <p class="dim">Top bar: <b>⇕</b> opens/closes everything · <b>◐</b> light or dark · <b>☁</b> sync ticks to another device · <b>⤓</b> download this page.</p>
`},

/* ═══════════════════ MODULE I ═══════════════════ */
{id:'m1-basics',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'What a crystal actually is',short:'Crystal, lattice, basis',est:'~18 min',
 body:`
 ${gist('A crystal is one group of atoms (the <b>basis</b>) stamped onto every point of an endless regular grid (the <b>lattice</b>).')}

 ${tp('Crystalline vs amorphous')}
 <p>Solids come in two kinds, and the difference is just <em>how far the tidiness reaches</em>.</p>
 <ul>
   <li><strong>Crystalline</strong> — the atomic pattern repeats predictably over enormous distances. This is <em>long-range order</em>: knowing where one atom sits lets you predict one a million atoms away. Diamond, quartz, salt, copper.
     <ul>
       <li><em>Single crystal</em> — the pattern runs unbroken through the whole piece.</li>
       <li><em>Polycrystalline</em> — many small tidy grains pointing in random directions, meeting at <em>grain boundaries</em>. Most metals you handle are like this.</li>
     </ul></li>
   <li><strong>Amorphous</strong> — tidy over only a few atoms (<em>short-range order</em>), then it loses the plot. Glass, plastics. It happens when a liquid is cooled so fast the atoms freeze before they can line up.</li>
 </ul>
 <p>Crystals form because the ordered arrangement has the <strong>lowest energy</strong>. Nature takes it whenever it is given time.</p>

 ${tp('Lattice, basis, structure — keep these three apart')}
 <p>These three words get mixed up constantly, and separating them earns marks on its own.</p>
 <ul>
   <li><strong>Lattice</strong> — an imaginary set of <em>points</em>, repeating forever. No atoms in it at all. Its defining property: <em>every point has exactly the same view of its surroundings as every other point</em>.</li>
   <li><strong>Basis</strong> — the actual atom, or group of atoms, that you put at each point.</li>
   <li><strong>Structure</strong> — what you get when you do that:</li>
 </ul>
 $$\\text{lattice}+\\text{basis}=\\text{crystal structure}$$
 <p>Think of patterned wallpaper. The lattice is the set of positions where the motif gets stamped; the basis is the motif; the wallpaper is the structure. Two very different wallpapers can use the same stamping positions.</p>

 <p>You travel between lattice points using a <strong>translation vector</strong> $\\mathbf T$ — a recipe of whole-number steps along three chosen directions $\\mathbf a,\\mathbf b,\\mathbf c$:</p>
 $$\\mathbf T=n_1\\mathbf a+n_2\\mathbf b+n_3\\mathbf c \\qquad (n_1,n_2,n_3\\text{ whole numbers})$$
 ${fig('lattice',
   'A 2-D oblique lattice with one choice of primitive vectors $\\mathbf a,\\mathbf b$. The shaded parallelogram is the primitive cell — one lattice point in total, since each corner is shared by four cells. The indigo arrow is a translation $\\mathbf T=2\\mathbf a+\\mathbf b$: land on it and the view around you is identical to the view from the origin. That last sentence <em>is</em> the definition of a lattice.',
   '<span><i style="border-color:var(--pos)"></i>primitive vectors</span>'+
   '<span><i style="border-color:var(--prob)"></i>a translation T</span>')}
 <p>If whole numbers alone can reach <em>every</em> point, those vectors are called <strong>primitive</strong>.</p>

 ${tp('Unit cells, and counting the atoms inside one')}
 <p>A <strong>unit cell</strong> is the small box you repeat to build the whole crystal.</p>
 <ul>
   <li><strong>Primitive cell</strong> — the smallest box possible. It works out to exactly <strong>one</strong> lattice point per cell, with volume $V=|\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)|$.</li>
   <li><strong>Conventional cell</strong> — usually a bigger, nicer box (a cube, say) with extra points at the body centre or face centres. It holds more than one point, but we use it because it <em>shows the symmetry</em>, which a skewed primitive cell hides.</li>
 </ul>
 <p>An atom on a corner or a face is <em>shared</em> with neighbouring boxes, so you only count your share. A corner is shared by 8 boxes, a face by 2, an atom fully inside belongs to you alone:</p>
 $$N=N_{\\text{inside}}+\\frac{N_{\\text{face}}}{2}+\\frac{N_{\\text{corner}}}{8}$$

 ${fig3d('count3d',
   'Why the fractions are there. Step 2 draws in the eight cells that meet at one corner — the atom is one of theirs as much as one of yours, so you may count only ⅛ of it. Step 3 does the same for a face atom with its single neighbour. Rotate while the neighbour cells are showing; the sharing is much easier to believe when you can see it from behind.',
   '<span><i class="fill" style="background:var(--pos)"></i>corner atoms</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>face / body-centre atoms</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>the one being shared</span>')}
 ${must(`<p><strong>Simple cubic</strong> $N=\\tfrac88=1$ &nbsp;·&nbsp; <strong>Body-centred cubic (BCC)</strong> $N=1+\\tfrac88=2$ &nbsp;·&nbsp; <strong>Face-centred cubic (FCC)</strong> $N=\\tfrac62+\\tfrac88=4$</p>`)}

 <p>One more cell is worth a sentence. The <strong>Wigner–Seitz cell</strong>: stand on a lattice point, draw a line to each neighbour, and cut every line in half with a perpendicular wall. The region you are left standing in is the cell — primitive <em>and</em> fully symmetric. Remember that recipe: the identical construction done in reciprocal space later gives the Brillouin zone.</p>

 ${tp('Drawing a Wigner–Seitz cell — do it once by hand')}
 <p>Draw it yourself in 2-D once and you own it for good, because the 3-D cell and every Brillouin zone later is the same four moves: <em>join, halve, bisect, keep the middle</em>. Step through the construction, then switch the lattice underneath and watch the same four moves give a different shape.</p>
 ${fig('wsdraw',
   'The construction one step at a time. A square lattice gives back a square and a hexagonal one a hexagon, but the oblique lattice gives an irregular hexagon — still primitive, still one point, still the full symmetry. Watch the faint bisectors: they belong to further-out neighbours and never reach the cell, which is exactly how you know you have drawn enough of them.',
   '<span><i class="fill" style="background:var(--pos)"></i>the cell</span>'+
   '<span><i class="dash" style="border-color:var(--prob)"></i>perpendicular bisectors</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>primitive cell — same area</span>')}
 ${trap(`<p>Two ways this goes wrong in an exam. <strong>Bisecting the wrong thing:</strong> the bisector is perpendicular to the <em>line joining the two points</em> and passes through its midpoint — not perpendicular to a cell edge. <strong>Stopping too early or too late:</strong> include a neighbour and its bisector may simply sit outside and do nothing (harmless), but leave out a near one and the cell comes out too big. Safe habit: bisect every neighbour out to about $1.5\\times$ the nearest distance, then keep the innermost region.</p>`)}

 ${fig3d('ws3d',
   'The Wigner–Seitz cell of a BCC lattice — the region closer to the central point than to any neighbour. The app builds it by actually cutting with all those perpendicular walls, so the shape you see (8 hexagon faces + 6 square faces) is a result, not a drawing.',
   '<span><i class="fill" style="background:var(--pos)"></i>the cell</span><span><i class="fill" style="background:var(--neg)"></i>the point you stand on</span>')}

 ${chk(
   'Diamond is said to have an “FCC lattice”, yet a diamond unit cell contains 8 carbon atoms, not 4. Is that a contradiction?',
   '<p><strong>No.</strong> The <em>lattice</em> is FCC — that means 4 lattice <strong>points</strong> per conventional cube. But the <em>basis</em> placed on each point is <strong>two</strong> carbon atoms, not one. So atoms per cell $=4\\text{ points}\\times2\\text{ atoms}=8$.</p><p>This is exactly why lattice / basis / structure must stay separate: "FCC" describes the grid of positions and never the number of atoms. The same trap appears with NaCl — FCC lattice, but the basis is one Na⁺ plus one Cl⁻, giving 4 of each per cube.</p>')}
`},

{id:'m1-symmetry',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'Symmetry, and the banned 5-fold axis',short:'Symmetry &amp; the 5-fold ban',est:'~13 min',
 body:`
 ${gist('A crystal can only have 1, 2, 3, 4 or 6-fold rotation symmetry — anything else cannot fill space without leaving gaps.')}

 ${tp('The four symmetry operations')}
 <p>A <strong>symmetry operation</strong> is any move that leaves the crystal looking exactly as it did. There are four kinds:</p>
 <ol>
   <li><strong>Translation</strong> — slide by $\\mathbf T=n_1\\mathbf a+n_2\\mathbf b+n_3\\mathbf c$.</li>
   <li><strong>Rotation</strong> — turn by $\\theta=2\\pi/n$ about an axis. We call it an <em>$n$-fold axis</em>: $n=4$ means a quarter turn restores it.</li>
   <li><strong>Reflection</strong> ($m$) — mirror it through a plane.</li>
   <li><strong>Inversion</strong> ($\\bar1$) — push every point through a centre to the opposite side, $\\mathbf r\\to-\\mathbf r$.</li>
 </ol>
 <p>Collect the operations that leave one point fixed (everything except translation) and you have a <strong>point group</strong>. Add translations too and you get a <strong>space group</strong>.</p>
 ${must(`<p>2-D: <strong>10</strong> point groups, <strong>17</strong> space groups. &nbsp; 3-D: <strong>32</strong> point groups, <strong>230</strong> space groups. Four cheap marks.</p>`)}

 ${tp('Why 5-fold symmetry is impossible')}
 <p>You can tile a floor with triangles, squares or hexagons and leave no gaps — but never with regular pentagons. Crystals face the same restriction, and there is a short proof.</p>

 ${fig3d('sym3d',
   'Before the ban, see what a cube <em>does</em> have. Step through the three families of rotation axis and rotate the cube to sight straight down each one — looking down a four-fold axis you see a square, down a body diagonal a triangle, and the reason each turn works becomes obvious. Then the mirrors appear and the count comes to 23. Nowhere in that list is a five-fold axis, and the next figure proves it never can be.',
   '<span><i style="border-color:var(--pos)"></i>4-fold axes (3)</span>'+
   '<span><i style="border-color:var(--neg)"></i>3-fold axes (4)</span>'+
   '<span><i style="border-color:var(--prob)"></i>2-fold axes (6)</span>')}

 ${fig('fivefold',
   'The proof is a picture before it is algebra. Turn the row about B one way and about C the other, and the two new points must land on a lattice row — so the gap between them has to be a whole number of steps. Try each angle: $60°,90°,120°,180°$ all give whole numbers, $72°$ gives $1.618$ and fails. That number is the golden ratio, which is exactly why quasicrystals — ordered but <em>not</em> periodic — are the loophole.',
   '<span><i class="fill" style="background:var(--pos)"></i>the original row</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>turned about B</span>'+
   '<span><i class="fill" style="background:var(--prob)"></i>turned about C</span>')}

 ${lad('Only n = 1, 2, 3, 4, 6 survive',[
   {why:'Take two neighbouring lattice points $B$ and $C$, one lattice step $T$ apart. Rotate about each by the same angle $\\theta$, in opposite senses. The two new points must themselves be lattice points.',
    m:'$$BC=T,\\qquad B\\to B\',\\quad C\\to C\'$$'},
   {why:'$B\'$ and $C\'$ sit on a row parallel to the original one, so the gap between them must be a whole number of lattice steps.',
    m:'$$B\'C\'=mT,\\qquad m=\\text{a whole number}$$'},
   {why:'Read that distance off the geometry — the original step plus the two sideways projections of the rotations.',
    m:'$$T+2T\\cos\\theta=mT$$'},
   {why:'Cancel $T$ and solve for the cosine.',
    m:'$$\\cos\\theta=\\frac{m-1}{2}$$'},
   {why:'A cosine can never leave the range $-1$ to $+1$. Only five whole numbers $m$ obey that, and each gives one allowed rotation.',
    m:'$$m=-1,0,1,2,3\\;\\Rightarrow\\;n=2,3,4,6,1$$'}
 ])}

 ${fig('rotsym',
   'The proof in one picture. Each stem is $\\cos\\theta=(m-1)/2$ for a whole number $m$. Only the five landing inside the $\\pm1$ band are possible, and they give exactly $n=1,2,3,4,6$. A 5-fold axis would need a value outside the band, so it cannot exist in a repeating crystal.',
   '<span><i class="fill" style="background:var(--pos)"></i>allowed m</span><span><i class="dash" style="border-color:var(--wall)"></i>the ±1 limit</span>')}

 ${chk(
   'Write down, in two lines, why a crystal cannot have a 5-fold rotation axis.',
   '<p>Because repeating (periodicity) forces $\\cos\\theta=\\dfrac{m-1}{2}$ with $m$ a whole number, and a cosine must lie between $-1$ and $+1$. Only $m=-1,0,1,2,3$ fit, giving $\\theta=180^\\circ,120^\\circ,90^\\circ,60^\\circ,360^\\circ$ — that is $n=2,3,4,6,1$. Five-fold would need a value of $\\cos\\theta$ that no allowed $m$ produces.</p><p><em>If they ask about quasicrystals:</em> those do show 5-fold patterns, but they are ordered <strong>without</strong> being periodic, so the proof\'s starting assumption does not apply to them.</p>')}
`},

{id:'m1-bravais',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'The 7 systems and 14 Bravais lattices',short:'Bravais lattices',est:'~12 min',
 body:`
 ${gist('Once only the legal symmetries are allowed, exactly 7 box shapes and 14 distinct lattices survive in 3-D. This is a table to memorise.')}

 ${tp('The table')}
 <p>A box is described by three edge lengths $a,b,c$ and the three angles between them $\\alpha,\\beta,\\gamma$. Sorting boxes by symmetry gives <strong>7 crystal systems</strong>. Allowing extra points at the body centre ($I$), all face centres ($F$) or one pair of faces ($C$) gives <strong>14 Bravais lattices</strong>.</p>
 <div style="overflow-x:auto"><table style="width:100%;border-collapse:collapse;font-size:.86rem">
 <tr style="text-align:left"><th>System</th><th>Lengths</th><th>Angles</th><th>Lattices</th></tr>
 <tr><td>Cubic</td><td>$a=b=c$</td><td>all $90^\\circ$</td><td>$P,I,F$ &nbsp;(3)</td></tr>
 <tr><td>Tetragonal</td><td>$a=b\\ne c$</td><td>all $90^\\circ$</td><td>$P,I$ &nbsp;(2)</td></tr>
 <tr><td>Orthorhombic</td><td>$a\\ne b\\ne c$</td><td>all $90^\\circ$</td><td>$P,I,C,F$ &nbsp;(4)</td></tr>
 <tr><td>Rhombohedral</td><td>$a=b=c$</td><td>equal, not $90^\\circ$</td><td>$R$ &nbsp;(1)</td></tr>
 <tr><td>Hexagonal</td><td>$a=b\\ne c$</td><td>$90,90,120^\\circ$</td><td>$P$ &nbsp;(1)</td></tr>
 <tr><td>Monoclinic</td><td>$a\\ne b\\ne c$</td><td>two $90^\\circ$, one not</td><td>$P,C$ &nbsp;(2)</td></tr>
 <tr><td>Triclinic</td><td>$a\\ne b\\ne c$</td><td>all different</td><td>$P$ &nbsp;(1)</td></tr>
 </table></div>
 <p style="text-align:center">$3+2+4+1+1+2+1=\\mathbf{14}$</p>
 <p>In 2-D the answer is <strong>4 systems, 5 lattices</strong> — oblique, rectangular <em>primitive</em>, rectangular <em>centred</em>, square, hexagonal. The rectangular system is the one that supports two.</p>

 ${tp('All 14, in the round')}
 <p>The table is only half the memory. What actually sticks is the <em>shape</em>: which box got squashed, which got sheared, and where the extra points sit. Walk the whole list below — pick a system, then a centring — and say the row of the table out loud as each cell appears.</p>
 ${fig3d('bravais',
   'Every one of the 14. Choose a <b>system</b> on the top row and a <b>centring</b> underneath — the greyed-out letters are the centrings that give nothing new for that system, which is exactly why the count stops at 14. Copper balls are the corner points, teal balls the points centring adds, and the teal shading marks <em>which</em> faces carry them. Watch the box itself change: cubic → tetragonal stretches $c$; → orthorhombic makes all three edges differ; → monoclinic shears one angle; → triclinic shears all three. The hexagonal cell is drawn inside the faint prism that three of them build.',
   '<span><i class="fill" style="background:var(--pos)"></i>corner points</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>centring points &amp; centred faces</span>'+
   '<span><i style="border-color:var(--faint)"></i>cell edges</span>')}
 <p>Two things to take from the spin. First, a corner point is <strong>shared by 8 cells</strong> and a face point by <strong>2</strong>, so $P$ owns $8\\times\\tfrac18=1$ point, $I$ owns $1+1=2$, $C$ owns $1+2\\times\\tfrac12=2$ and $F$ owns $1+6\\times\\tfrac12=4$ — the counts printed on each cell. Second, the seven systems are one chain of <em>lowering</em> symmetry: start from the cube and stretch, then unequalise, then shear, and you arrive at triclinic, which keeps nothing but the repetition itself.</p>

 ${trap(`<p>“Why is there no face-centred <em>tetragonal</em> lattice?” is a favourite. Answer: because it is <strong>not new</strong> — a face-centred tetragonal cell can be redrawn as a smaller <em>body-centred</em> tetragonal cell (rotate the axes $45^\\circ$ and shrink by $\\sqrt2$). A centring only counts as a separate Bravais lattice if it cannot be re-described as an existing one. That test is what trims the list to 14.</p>`)}

 ${chk(
   'Put these in order from most general to most specific, and say what each adds: “NaCl structure”, “cubic system”, “FCC lattice”.',
   '<p><strong>Cubic system → FCC lattice → NaCl structure.</strong></p><ul><li><em>Cubic system</em> fixes only the box shape: $a=b=c$, all angles $90^\\circ$.</li><li><em>FCC lattice</em> picks one of the three cubic arrangements of points — corners plus face centres, 4 per cube.</li><li><em>NaCl structure</em> adds the basis: an Na⁺ at $(0,0,0)$ and a Cl⁻ half an edge away.</li></ul><p>So: system = shape, lattice = where the points are, structure = lattice + basis. Diamond and NaCl share the FCC lattice yet are entirely different structures, purely because the basis differs.</p>')}
`},

{id:'m1-planes',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'Directions and Miller indices',short:'Directions &amp; Miller indices',est:'~18 min',
 body:`
 ${gist('Directions get square brackets $[uvw]$. Planes get round brackets $(hkl)$ and are labelled by the <b>reciprocals</b> of where they cut the axes.')}

 ${tp('Naming a direction: [uvw]')}
 <p>Draw the arrow from the origin, read its components in units of $a,b,c$, and scale to the smallest whole numbers. Square brackets.</p>
 <ul>
   <li>$[uvw]$ — one specific direction. A minus sign is written as a bar on top: $[\\bar100]$ is the $-x$ direction.</li>
   <li>$\\langle uvw\\rangle$ — the whole <em>family</em> that symmetry makes equivalent. In a cube, $\\langle100\\rangle$ means all six cube-edge directions.</li>
 </ul>

 ${fig3d('dir3d',
   'Indices are <b>steps, not coordinates</b>. Walk $u$ along $a$, then $v$ along $b$, then $w$ along $c$ (teal), and the arrow from O to where you land is $[uvw]$. Drag to spin it — a direction only becomes obvious once you have seen the arrow from two or three angles. $[211]$ shows the halving trick; $[\\bar110]$ steps backwards along $a$, into the cell behind.',
   '<span><i class="fill" style="background:var(--pos)"></i>the direction</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>the walk, one index at a time</span>')}

 <p>In a <strong>cubic</strong> crystal the angle between two directions is just the ordinary angle between two vectors:</p>
 $$\\cos\\theta=\\frac{h_1h_2+k_1k_2+l_1l_2}{\\sqrt{h_1^2+k_1^2+l_1^2}\\;\\sqrt{h_2^2+k_2^2+l_2^2}}$$

 ${tp('Naming a plane: Miller indices (hkl)')}
 <p>Four steps, every single time:</p>
 <ol>
   <li>Find where the plane cuts the three axes, measured in units of $a,b,c$. Call them $p,q,r$.</li>
   <li>Take the <strong>reciprocals</strong>: $1/p,\\;1/q,\\;1/r$.</li>
   <li>Multiply through to clear fractions, giving smallest whole numbers.</li>
   <li>Write them in round brackets, no commas: $(hkl)$.</li>
 </ol>
 <p>A plane <em>parallel</em> to an axis never cuts it, so that intercept is $\\infty$ — and $1/\\infty=0$. That is the whole reason for step 2: reciprocals turn an unusable infinity into a perfectly good zero.</p>
 <p><em>Worked example.</em> Intercepts $a,\\;2b,\\;\\infty$ → $p,q,r=1,2,\\infty$ → reciprocals $1,\\tfrac12,0$ → multiply by 2 → $(210)$.</p>
 <p>Brackets matter: $(hkl)$ is one set of parallel planes; $\\{hkl\\}$ is the symmetry-equivalent family.</p>

 ${tp('Drawing $(hkl)$ — the same recipe, run backwards')}
 <p>The question comes the other way round just as often: <em>“sketch the $(110)$ plane in a cubic cell”</em>. Naming runs intercepts → reciprocals; drawing runs reciprocals → intercepts, then you join them. Four moves: <em>invert, mark, join, shade</em>.</p>
 ${fig3d('miller3d',
   'Pick a plane and walk the five steps, then <b>spin it</b> — a plane drawn flat is easy to misread, and rotating shows immediately whether it really misses the axis it is supposed to be parallel to. $(100)$ comes out as a whole cube face because two intercepts are $\\infty$; $(111)$ slices a corner off symmetrically; $(210)$ cuts $a$ at $a/2$ and sits closer to the origin; $(\\bar110)$ shows what a bar does — the cut moves to $-a$, in the cell behind.',
   '<span><i class="fill" style="background:var(--prob)"></i>the plane</span>'+
   '<span><i class="fill" style="background:var(--pos)"></i>intercepts</span>'+
   '<span><i style="border-color:var(--faint)"></i>the reference cell</span>')}
 <p>Three habits that keep the marks:</p>
 <ul>
   <li><strong>Mark the origin first.</strong> A plane that passes <em>through</em> the origin has an intercept of $0$, and $1/0$ is not an index — shift the origin one cell along, or draw the next parallel plane of the same family instead. They have the same name.</li>
   <li><strong>A zero index means “never cuts”.</strong> Do not look for an intercept: run the plane parallel to that axis, right through the cell.</li>
   <li><strong>A bar means the negative side.</strong> Step into the cell behind the origin rather than trying to squeeze the plane into the first one.</li>
 </ul>

 ${must(`<p><strong>In a cubic crystal, the direction $[hkl]$ is perpendicular to the plane $(hkl)$.</strong> This one fact turns most plane questions into simple vector arithmetic.</p>
 <p>And a direction $[uvw]$ <strong>lies inside</strong> the plane $(hkl)$ exactly when
 $$hu+kv+lw=0$$
 (because "lies in the plane" means "perpendicular to the plane's normal"). No drawing required.</p>`)}


 ${chk(
   'A plane cuts the axes at $a$, $2b$, $\\infty$. Give its Miller indices — then decide, without drawing anything, whether the direction $[\\bar120]$ lies in it.',
   '<p><strong>Indices:</strong> $p,q,r=1,2,\\infty$ → reciprocals $1,\\tfrac12,0$ → ×2 → $\\mathbf{(210)}$.</p><p><strong>Does $[\\bar120]$ lie in it?</strong> Test $hu+kv+lw$ with $(h,k,l)=(2,1,0)$ and $(u,v,w)=(-1,2,0)$: $$2(-1)+1(2)+0(0)=-2+2=0$$ It is zero, so <strong>yes</strong> — the direction lies in the plane. Any non-zero answer would mean it pierces the plane instead.</p>')}
`},

{id:'m1-dspacing',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'Spacing between planes',short:'Interplanar spacing',est:'~11 min',
 body:`
 ${gist('Planes with bigger Miller indices sit closer together: $d=a/\\sqrt{h^2+k^2+l^2}$ for a cube.')}

 ${tp('The formula, and where it comes from')}
 <p>A set of parallel planes $(hkl)$ has a fixed perpendicular gap between neighbours, written $d_{hkl}$. Every X-ray question needs it, so learn the cubic version cold.</p>


 ${fig3d('dgeom3d',
   'The whole derivation is one perpendicular. Drop $ON$ from the origin onto the nearest plane — that length <em>is</em> $d$. Rotate until you are sighting along $ON$: the plane goes edge-on and you can see that $d$ really is the gap to the next plane. Each intercept then makes a right-angled triangle, so each direction cosine is $d$ over an intercept, and the identity finishes it.',
   '<span><i class="fill" style="background:var(--prob)"></i>the plane</span>'+
   '<span><i class="fill" style="background:var(--pos)"></i>intercepts</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>the perpendicular, length d</span>')}

 ${lad('Deriving d(hkl)',[
   {why:'The plane nearest the origin cuts the axes at $a/h$, $b/k$, $c/l$. Let $d$ be the perpendicular distance from the origin to it, and $\\alpha,\\beta,\\gamma$ the angles that perpendicular makes with the three axes.',
    m:'$$\\cos\\alpha=\\frac{d}{a/h}=\\frac{dh}{a},\\qquad \\cos\\beta=\\frac{dk}{b},\\qquad \\cos\\gamma=\\frac{dl}{c}$$'},
   {why:'For perpendicular axes the three direction cosines of any line obey this — it is just Pythagoras in 3-D.',
    m:'$$\\cos^2\\alpha+\\cos^2\\beta+\\cos^2\\gamma=1$$'},
   {why:'Substitute the three expressions and pull out $d^2$.',
    m:'$$d^2\\left[\\frac{h^2}{a^2}+\\frac{k^2}{b^2}+\\frac{l^2}{c^2}\\right]=1$$'},
   {why:'Rearrange — the general orthorhombic answer.',
    m:'$$d_{hkl}=\\frac{1}{\\sqrt{\\dfrac{h^2}{a^2}+\\dfrac{k^2}{b^2}+\\dfrac{l^2}{c^2}}}$$'},
   {why:'Put $a=b=c$ for a cube. Memorise this line.',
    m:'$$\\boxed{\\;d_{hkl}=\\frac{a}{\\sqrt{h^2+k^2+l^2}}\\;}$$'}
 ])}

 ${fig('dspacing',
   'The spacings of the first few families in a cubic crystal, in units of $a$. Two things to take away: bigger indices always mean <em>closer</em> planes, and the sequence of $\\sqrt{h^2+k^2+l^2}$ values — $1,\\sqrt2,\\sqrt3,2,\\sqrt5\\dots$ — is exactly what a powder pattern measures. Which entries go <em>missing</em> is how a diffraction pattern tells BCC from FCC.',
   '<span><i class="fill" style="background:var(--pos)"></i>d(hkl) in units of a</span>')}

 <p>Notice $d_{222}=\\tfrac12d_{111}$: multiplying every index by $n$ divides the spacing by $n$. That fact gets used the moment we reach Bragg's law.</p>

 ${chk(
   'In an FCC crystal, rank $d_{111}$, $d_{200}$ and $d_{220}$. What general rule does the answer illustrate?',
   '<p>Using $d=a/\\sqrt{h^2+k^2+l^2}$: $$d_{111}=\\frac{a}{\\sqrt3}=0.577a,\\qquad d_{200}=\\frac a2=0.500a,\\qquad d_{220}=\\frac{a}{\\sqrt8}=0.354a$$ so $d_{111}>d_{200}>d_{220}$.</p><p>The rule: <strong>the most closely packed planes are the most widely spaced.</strong> In FCC the $\\{111\\}$ planes are the close-packed ones, and they are indeed furthest apart. (FCC shows $200$ and $220$ rather than $100$ and $110$ because face-centring inserts extra planes halfway, halving those spacings.)</p>')}
`},

{id:'m1-packing',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'How atoms pack: SC, BCC, FCC, HCP',short:'Packing &amp; structures',est:'~20 min',
 body:`
 ${gist('Treat atoms as hard spheres. Where they touch fixes $a$ in terms of $r$ — and that gives you the coordination number and the fraction of space filled.')}

 ${tp('The two numbers that describe a packing')}
 <ul>
   <li><strong>Coordination number ($CN$)</strong> — how many nearest neighbours actually touch a given atom.</li>
   <li><strong>Packing fraction ($f$)</strong> — what fraction of the box is really filled with sphere:
     $$f=\\frac{(\\text{atoms per cell})\\times\\tfrac43\\pi r^3}{a^3}$$</li>
 </ul>
 <p>Everything follows from one question: <em>along which line do the spheres touch?</em> Answer that and you have $a$ in terms of $r$; the rest is arithmetic.</p>

 ${must(`<div style="overflow-x:auto"><table style="width:100%;border-collapse:collapse;font-size:.87rem">
 <tr style="text-align:left"><th>Structure</th><th>Atoms/cell</th><th>Touch along</th><th>$a$ vs $r$</th><th>$CN$</th><th>$f$</th></tr>
 <tr><td>Simple cubic</td><td>1</td><td>cube edge</td><td>$a=2r$</td><td>6</td><td>$\\pi/6=0.52$</td></tr>
 <tr><td>BCC</td><td>2</td><td>body diagonal</td><td>$\\sqrt3\\,a=4r$</td><td>8</td><td>$\\pi\\sqrt3/8=0.68$</td></tr>
 <tr><td>FCC</td><td>4</td><td>face diagonal</td><td>$\\sqrt2\\,a=4r$</td><td>12</td><td>$\\pi/3\\sqrt2=0.74$</td></tr>
 <tr><td>HCP</td><td>6</td><td>basal edge</td><td>$a=2r$</td><td>12</td><td>$\\pi/3\\sqrt2=0.74$</td></tr>
 </table></div>`)}


 ${fig3d('pack3d',
   'Where $a=2r$, $\\sqrt3a=4r$ and $\\sqrt2a=4r$ actually come from. Pick a cell, follow the touching line, blow the atoms up, then count the radii along it. <b>Rotate until you look straight down that line</b> — the spheres line up and the count stops being a memory test. Every packing-fraction and density numerical starts from this one equation.',
   '<span><i class="fill" style="background:var(--pos)"></i>atoms on the touching line</span>'+
   '<span><i style="border-color:var(--prob)"></i>the touching direction</span>')}

 ${fig3d('cubic',
   'The three cubic cells. Switch between SC, BCC and FCC, then press <b>⬤ fill</b> to blow the atoms up to their real touching size — that is the moment the packing fraction becomes obvious. The indigo bonds show the touching direction: cube edge for SC, body diagonal for BCC, face diagonal for FCC.',
   '<span><i class="fill" style="background:var(--pos)"></i>corner atoms</span><span><i class="fill" style="background:var(--neg)"></i>centre atoms</span><span><i style="border-color:var(--prob)"></i>touching direction</span>')}

 ${fig('packing',
   'The four packing fractions side by side. FCC and HCP tie at 0.74 — the tightest possible packing of equal spheres. BCC manages 0.68, and simple cubic only 0.52.',
   '<span><i class="fill" style="background:var(--pos)"></i>FCC</span><span><i class="fill" style="background:var(--prob)"></i>HCP</span><span><i class="fill" style="background:var(--neg)"></i>BCC</span>')}

 ${tp('Close packing and the c/a ratio')}
 <p>FCC and HCP are both the <em>tightest possible</em> stacking of equal spheres — both give $f=0.74$ and $CN=12$. They differ only in the <strong>stacking order</strong> of the close-packed layers: HCP repeats $ABABAB\\dots$, FCC repeats $ABCABC\\dots$.</p>

 ${fig3d('hcp',
   'Hexagonal close packing. Copper atoms are the two $A$ layers (top and bottom); the three teal atoms are the $B$ layer resting in the hollows between them. Rotate to look straight down the axis and you will see the $B$ atoms drop neatly into the gaps.',
   '<span><i class="fill" style="background:var(--pos)"></i>A layers</span><span><i class="fill" style="background:var(--neg)"></i>B layer</span>')}


 ${fig3d('hcp3d',
   'One tetrahedron, and the ratio falls out. Three touching spheres make an equilateral triangle of side $a$; the hollow at its centre is $a/\\sqrt3$ from each corner; the sphere resting there is $a$ away from each of them and $c/2$ higher. <b>Spin it until the right-angled triangle goes edge-on</b> — that is the triangle Pythagoras is applied to.',
   '<span><i class="fill" style="background:var(--pos)"></i>A layer · contact distance a</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>B layer · a/√3</span>'+
   '<span><i style="border-color:var(--prob)"></i>the rise c/2</span>')}

 ${lad('Proving c/a = √(8/3) for ideal HCP',[
   {why:'Three touching spheres in the bottom layer form an equilateral triangle of side $a$. The next-layer sphere sits in the hollow, directly above the triangle\'s centre. First, how far is that centre from a corner?',
    m:'$$\\text{median}=a\\sin60^\\circ=\\frac{\\sqrt3}{2}a,\\qquad d_{\\text{centre}}=\\frac23\\cdot\\frac{\\sqrt3}{2}a=\\frac{a}{\\sqrt3}$$'},
   {why:'That upper sphere touches the lower ones, so centre-to-centre is $a$. The vertical rise between layers is $c/2$. Pythagoras on that right triangle:',
    m:'$$a^2=\\left(\\frac{a}{\\sqrt3}\\right)^2+\\left(\\frac c2\\right)^2$$'},
   {why:'Tidy up and take the square root.',
    m:'$$\\frac23a^2=\\frac{c^2}{4}\\;\\Rightarrow\\;\\frac ca=\\sqrt{\\frac83}\\approx1.633$$'}
 ])}

 ${chk(
   'FCC and HCP have the same packing fraction and the same coordination number. What is the only difference — and does it matter?',
   '<p>The only difference is the <strong>stacking sequence</strong>: HCP is $ABAB\\dots$, FCC is $ABCABC\\dots$. Locally every atom has the same 12 neighbours at the same distance, which is why both give $f=0.74$.</p><p>It does matter. FCC has four differently-oriented close-packed $\\{111\\}$ planes for atoms to slide along; HCP has essentially only one. That is why FCC metals (copper, aluminium, gold) are ductile and can be drawn into wire, while HCP metals (zinc, magnesium) are comparatively brittle.</p>')}
`},

{id:'m1-compounds',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'Diamond, zinc blende and rock salt',short:'Diamond &amp; NaCl',est:'~7 min',
 body:`
 ${gist('All three are an FCC lattice with a two-atom basis — only the basis changes.')}

 ${fig3d('basis3d',
   'The sentence “lattice + basis = structure” as a construction. The same four FCC points every time; only the basis vector changes — $(\\tfrac14,\\tfrac14,\\tfrac14)$ along the body diagonal gives tetrahedral diamond and zinc blende, $(\\tfrac12,0,0)$ along an edge gives octahedral rock salt. Spin each one and count the neighbours around a single atom: 4 for diamond, 6 for NaCl.',
   '<span><i class="fill" style="background:var(--pos)"></i>first basis atom</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>second basis atom</span>'+
   '<span><i style="border-color:var(--prob)"></i>nearest-neighbour bonds</span>')}

 ${tp('Diamond and zinc blende')}
 <ul>
   <li><strong>Diamond</strong> — FCC lattice; basis = two <em>identical</em> atoms at $(0,0,0)$ and $(\\tfrac14,\\tfrac14,\\tfrac14)$. So $4\\times2=\\mathbf 8$ atoms per cube. Each atom has just <strong>4</strong> neighbours arranged tetrahedrally, at distance $\\tfrac{\\sqrt3}{4}a$. Packing fraction only $0.34$. Materials: C, Si, Ge, grey tin.</li>
   <li><strong>Zinc blende (ZnS)</strong> — identical geometry, but the two basis atoms are <em>different</em> elements. Coordination $4{:}4$, 4 formula units per cube.</li>
 </ul>
 ${trap(`<p>“Why does diamond fill only 34% of space when FCC fills 74%?” Because its bonding is <strong>directional</strong>. Covalent bonds insist on the tetrahedral $CN=4$ arrangement, and tetrahedra cannot pack tightly. Close packing ($CN=12$) is what you get when bonding has no preferred direction, as in metals. Structure follows bonding.</p>`)}

 ${fig3d('diamond',
   'The diamond cell. Copper spheres are the FCC positions, teal spheres the four basis atoms tucked into tetrahedral gaps, and every indigo bond is exactly $\\tfrac{\\sqrt3}{4}a$ long. Rotate until a teal atom faces you and you will see its four bonds fanning out tetrahedrally — the $CN=4$ that keeps diamond so empty.',
   '<span><i class="fill" style="background:var(--pos)"></i>FCC sites</span><span><i class="fill" style="background:var(--neg)"></i>basis atoms</span>')}

 ${tp('Rock salt (NaCl)')}
 <ul>
   <li>FCC lattice; basis = one Na⁺ at $(0,0,0)$ and one Cl⁻ at $(\\tfrac12,0,0)$ — displaced along a cube <strong>edge</strong>, not the diagonal.</li>
   <li>4 Na⁺ + 4 Cl⁻ per cube (4 formula units). Coordination $6{:}6$, octahedral.</li>
   <li>The ions touch along the edge, so $\\;a=2(r_{+}+r_{-})$ — the line you need for every NaCl numerical.</li>
 </ul>

 ${fig3d('nacl',
   'Rock salt. Large teal spheres are Cl⁻, small copper ones Na⁺, alternating along every cube edge so each ion is surrounded by six of the other kind. Rotate along an edge to see the strict alternation that gives $a=2(r_++r_-)$.',
   '<span><i class="fill" style="background:var(--pos)"></i>Na⁺</span><span><i class="fill" style="background:var(--neg)"></i>Cl⁻</span>')}

 ${chk(
   'Diamond and NaCl both sit on an FCC lattice. State precisely how they differ, and give each coordination number.',
   '<p>Same lattice, different <strong>basis</strong>.</p><ul><li><strong>Diamond</strong> — basis is two <em>identical</em> atoms offset along the <em>body diagonal</em> by $(\\tfrac14,\\tfrac14,\\tfrac14)$ → tetrahedral, $CN=4$.</li><li><strong>NaCl</strong> — basis is two <em>different</em> ions offset along a cube <em>edge</em> by $(\\tfrac12,0,0)$ → octahedral, $6{:}6$.</li></ul><p>The basis differs both in <em>what</em> the atoms are and in <em>which way</em> they are displaced — enough to give completely different coordination, packing and properties from the same grid of points.</p>')}
`},

{id:'m1-xrd',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'X-rays, reciprocal lattice &amp; Brillouin zones',short:'X-rays &amp; reciprocal space',est:'~18 min',
 body:`
 ${gist('X-rays reflect off crystal planes only at special angles ($2d\\sin\\theta=n\\lambda$). Describing that in “reciprocal space” turns the condition into a clean geometric picture.')}

 ${tp('Bragg\'s law')}
 <p>To resolve something of size $d$ you need a wave of comparable wavelength. Atomic spacings are about $1$ Å, which is the X-ray range — that is the entire reason crystallography uses X-rays and not visible light.</p>
 <p>Picture the planes $(hkl)$, spaced $d$ apart, as a stack of half-silvered mirrors. A ray reflecting off the second plane travels further than one off the first. Geometry makes that extra distance $2d\\sin\\theta$, and you get a bright reflection only when it equals a whole number of wavelengths:</p>
 ${must(`$$\\boxed{\\;2d\\sin\\theta=n\\lambda\\;}$$
 <p>$\\theta$ is measured <strong>from the plane</strong>, not from the normal — that is the classic slip. $n$ is the order of the reflection.</p>`)}
 <p>Because $d_{nh\\,nk\\,nl}=d_{hkl}/n$, an $n$-th order reflection from $(hkl)$ can always be relabelled a first-order reflection from $(nh\\,nk\\,nl)$ — which is why tables list $200$ and $220$ reflections.</p>

 ${fig('bragg',
   'Built one line at a time. The two perpendiculars from $A$ are the whole trick: everything outside them is common to both rays, so the extra journey is just $PB+BQ$, and each of those is $d\\sin\\theta$. Change $\\theta$ with the chips and watch the extra path grow — at small angles it is a fraction of $d$, which is why low-angle reflections need long wavelengths.',
   '<span><i class="fill" style="background:var(--prob)"></i>upper ray</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>lower ray</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>the extra path 2d sin θ</span>')}

 ${tp('Laue\'s version — and why it is the same law')}
 <p>Laue looked atom by atom instead of plane by plane. For two scatterers separated by $\\mathbf r$, with $\\hat{\\mathbf n}_1,\\hat{\\mathbf n}_2$ the incoming and outgoing directions, the extra path is $\\mathbf r\\cdot(\\hat{\\mathbf n}_1-\\hat{\\mathbf n}_2)=\\mathbf r\\cdot\\mathbf N$. Demanding a whole number of wavelengths along <em>each</em> crystal axis gives <strong>Laue's three equations</strong>:</p>
 $$\\mathbf a\\cdot\\mathbf N=nh\\lambda,\\qquad \\mathbf b\\cdot\\mathbf N=nk\\lambda,\\qquad \\mathbf c\\cdot\\mathbf N=nl\\lambda$$

 ${fig3d('laue3d',
   'Laue’s argument has nothing to do with planes — just two atoms and one path difference. Step through it, then use the chips to put the second atom on each axis in turn: that is where the <em>three</em> equations come from, one per axis, all of which must hold at once. Rotate the picture at step 4 and watch the two crimson segments: whichever way you look at it, the extra journey is $\\mathbf r\\cdot\\hat{\\mathbf n}_1-\\mathbf r\\cdot\\hat{\\mathbf n}_2$.',
   '<span><i class="fill" style="background:var(--prob)"></i>incoming n̂₁</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>scattered n̂₂</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>the extra path</span>')}
 <p>Rewriting these with direction cosines and $|\\mathbf N|=2\\sin\\theta$ turns them into $d_{hkl}=\\dfrac{n\\lambda}{2\\sin\\theta}$, i.e. $2d\\sin\\theta=n\\lambda$. <strong>Bragg and Laue are the same physics in different clothing</strong> — a standard short-answer question.</p>
 <p>One refinement worth a line: real atoms are fuzzy clouds of electrons, not points. Waves scattered from different parts of the same cloud partly cancel, and cancel more as the angle grows. This is the <strong>atomic scattering factor</strong>, and it is why high-angle reflections come out systematically weaker.</p>

 ${fig('scatfac',
   'Why $f$ falls off. A point would scatter everything in step at every angle; a cloud $\\sim0.1$ nm across does not, and the mismatch grows with the scattering angle. Hence the curve on the right — and hence the systematic fading of high-angle reflections, which is a favourite one-mark question.',
   '<span><i class="fill" style="background:var(--neg)"></i>the electron cloud</span>'+
   '<span><i class="fill" style="background:var(--pos)"></i>f against sin θ/λ</span>')}

 ${tp('The reciprocal lattice')}
 <p>Here is the idea in plain terms. A family of parallel planes is fully described by two things: which way it faces, and how far apart the planes are. So represent the whole family by a single <em>arrow</em> — pointing along the plane normal, with length inversely proportional to the spacing:</p>
 $$\\mathbf G_{hkl}=\\frac{2\\pi}{d_{hkl}}\\,\\hat{\\mathbf n}$$
 <p>Collect the arrows for every possible family and their tips form a new lattice — the <strong>reciprocal lattice</strong>. It lives in "$k$-space", where distances have units of 1/length, not in ordinary space. Closely-spaced planes → long arrow → point far from the origin.</p>
 <p>Its building vectors come from the real ones:</p>
 $$\\mathbf a^{*}=2\\pi\\frac{\\mathbf b\\times\\mathbf c}{\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)},\\qquad\\text{and cyclically for }\\mathbf b^{*},\\mathbf c^{*}$$
 <p>built so that $\\mathbf a^{*}\\cdot\\mathbf a=2\\pi$ while $\\mathbf a^{*}\\cdot\\mathbf b=\\mathbf a^{*}\\cdot\\mathbf c=0$. The reciprocal cell has volume $(2\\pi)^3/V$.</p>

 ${fig3d('recip3d',
   'The definition, made concrete. One family of planes goes in; one arrow — and therefore one point — comes out. Switch families with the chips: $(200)$ has half the spacing of $(100)$, so its arrow is twice as long and its point sits twice as far out. Do that for every family and the tips fill the faint lattice you can see at step 4. Rotate it: the reciprocal lattice of a cubic crystal is itself cubic.',
   '<span><i class="fill" style="background:var(--prob)"></i>the plane family</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>d, along the normal</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>G, length 2π/d</span>')}
 ${must(`<p><strong>Reciprocals of the cubic lattices — a near-guaranteed question:</strong></p>
 <ul><li>simple cubic → simple cubic (spacing $2\\pi/a$)</li>
 <li><strong>BCC → FCC</strong></li>
 <li><strong>FCC → BCC</strong></li></ul>`)}

 ${tp('Brillouin zones')}
 <p>Now combine the two ideas. Diffraction happens when the wave's change of direction matches a reciprocal lattice arrow, $\\mathbf k'=\\mathbf k+\\mathbf G$. The scattering is elastic so $|\\mathbf k'|=|\\mathbf k|$; squaring gives</p>
 $$2\\mathbf k\\cdot\\mathbf G+G^2=0\\qquad\\Longleftrightarrow\\qquad \\mathbf k\\cdot\\frac{\\mathbf G}{2}=\\left|\\frac{\\mathbf G}{2}\\right|^{2}$$
 <p>Read geometrically that says: <strong>a wave diffracts exactly when the tip of $\\mathbf k$ lands on the perpendicular bisector plane of a reciprocal lattice vector.</strong></p>
 <p>Those bisector planes act as walls. The region around the origin enclosed by the nearest walls is the <strong>first Brillouin zone</strong> — which is simply the Wigner–Seitz cell from earlier, built in reciprocal space instead of real space.</p>

 ${fig('bz',
   'The same four moves as the Wigner–Seitz cell, now in reciprocal space. Step through it: points, then the vectors G, then their perpendicular bisectors, then the region no bisector cuts off — the first zone. Step 5 adds the diagonal bisectors and the second zone appears as the teal ring. Both have area $(2\\pi/a)^2$, which is why every zone holds the same number of states — one band per zone.',
   '<span><i class="fill" style="background:var(--pos)"></i>1st zone</span><span><i class="fill" style="background:var(--neg)"></i>2nd zone</span>')}

 ${fig3d('bz3d',
   'The same construction in 3-D. An <b>FCC crystal</b> has a BCC reciprocal lattice, and its first zone is a <b>truncated octahedron</b> (8 hexagon faces + 6 squares). Switch to <b>BCC crystal</b> and you get a <b>rhombic dodecahedron</b> (12 diamond-shaped faces). Rotate and count the faces — those two names are exam answers.',
   '<span><i class="fill" style="background:var(--prob)"></i>first Brillouin zone</span>')}

 ${chk(
   'What is physically special about an electron whose wavevector lands exactly on a Brillouin zone boundary? (This is the bridge into Module II.)',
   '<p>It satisfies the Bragg condition, so the lattice <strong>reflects it</strong>. Forward and backward waves have equal size and add up to a <strong>standing wave</strong>, which carries no current.</p><p>There are two standing waves you can build — one piling electrons up <em>on</em> the positive ion cores, one piling them <em>between</em> the cores. Those two arrangements have different energies, and no state exists in between. That energy difference <em>is</em> the <strong>band gap</strong>. So gaps open exactly at zone boundaries, $k=\\pm n\\pi/a$ — which is precisely where Module II starts.</p>')}
`},

/* ═══════════════════ MODULE I · PROBLEMS ═══════════════════ */
{id:'m1-problems',mod:'Module I',modName:'Crystals &amp; X-rays',modClass:'m1',
 title:'Problems — Module I',short:'Problems I',est:'~22 min',
 body:`
 <p class="lead">The seven problem types that actually come up. Read the method, then do the “now you try” twin on paper.</p>

 ${tp('Density &amp; geometry numericals')}
 ${prob('1','Link density to the lattice parameter',
   pq('Show that for any cubic lattice the lattice parameter $a$ is related to the density $\\rho$, the number of atoms per unit cell $n$ and the atomic weight $M$ by $$a=\\left(\\frac{nM}{N_A\\rho}\\right)^{1/3}$$ where $N_A$ is the Avogadro constant.')+
   pth('<p>Cell volume $a^3$; $n$ atoms per cell; one atom weighs $M/N_A$. Density = mass ÷ volume.</p>')+
   psol('<p>Mass in the cell is $nM/N_A$, so $$\\rho=\\frac{nM}{N_Aa^3}\\quad\\Longrightarrow\\quad a=\\left(\\frac{nM}{N_A\\rho}\\right)^{1/3}$$ The only thing that changes between structures is $n$: 1 for SC, 2 for BCC, 4 for FCC.</p>')+
   prac('<p>A BCC metal ($n=2$) has density $7870$ kg/m³ and atomic weight $55.85$ g/mol. Find $a$.</p>'))}

 ${prob('2','FCC copper — find a and r from the density',
   pq('Copper has an FCC structure and a density of $8960$ kg/m³. Given that the atomic mass of copper is $63.54$ amu, calculate the unit cell edge length $a$ and the atomic radius $r$ of a copper atom.')+
   pth('<p>FCC: $n=4$, and the touching condition $\\sqrt2\\,a=4r$. Use $1$ amu $=1.6605\\times10^{-27}$ kg.</p>')+
   psol('<p>One atom: $m=63.54\\times1.6605\\times10^{-27}=1.055\\times10^{-25}$ kg, so the cell holds $4m=4.22\\times10^{-25}$ kg.</p><p>$a^3=\\dfrac{4.22\\times10^{-25}}{8960}=4.71\\times10^{-29}$ m³ → $a=3.61$ Å.</p><p>$r=\\dfrac{\\sqrt2\\,a}{4}=1.28$ Å.</p>')+
   prac('<p>Gold is FCC with atomic weight $196.97$ amu and $r=1.442$ Å. Find its density.</p>'))}

 ${prob('3','Zinc (HCP) — packing fraction and density',
   pq('Zinc has an HCP structure with lattice parameters $a=2.66$ Å and $c=4.95$ Å. Given that the atomic radius is $r=1.31$ Å and the atomic mass of Zn is $65.37$ amu, calculate the packing fraction and the theoretical density of zinc.')+
   pth('<p>Hexagonal prism volume $V=\\tfrac{3\\sqrt3}{2}a^2c$, with 6 atoms per conventional cell.</p>')+
   psol('<p>With $a=2.66$ Å, $c=4.95$ Å: $V=\\tfrac{3\\sqrt3}{2}a^2c\\approx9.10\\times10^{-29}$ m³.</p><p>Sphere volume $=6\\times\\tfrac43\\pi r^3$ with $r=1.31$ Å $\\approx5.65\\times10^{-29}$ m³, so $f\\approx0.62$ — below the ideal $0.74$ because zinc\'s $c/a$ is not ideal.</p><p>Mass $=6\\times65.37/(6.023\\times10^{23})$ g $=6.51\\times10^{-25}$ kg → $\\rho\\approx7156$ kg/m³.</p>')+
   prac('<p>Titanium is HCP with $a=2.95$ Å, $c=4.68$ Å, $r=1.445$ Å, $M=47.87$ amu. Find $f$ and $\\rho$.</p>'))}

 ${prob('4','NaCl — packing efficiency and density',
   pq('Calculate the packing efficiency and the theoretical density of sodium chloride, given $r_{\\mathrm{Na}^+}=0.98$ Å, $r_{\\mathrm{Cl}^-}=1.81$ Å, atomic mass of Na $=22.99$ amu and atomic mass of Cl $=35.45$ amu.')+
   pth('<p>Ions touch along the edge: $a=2(r_++r_-)$; 4 formula units per cube.</p>')+
   psol('<p>$a=2(0.98+1.81)=5.58$ Å → $V=a^3=1.737\\times10^{-28}$ m³.</p><p>Ion volume $=\\tfrac{16\\pi}{3}\\big[(0.98)^3+(1.81)^3\\big]\\times10^{-30}\\approx1.151\\times10^{-28}$ m³ → $f\\approx0.66$.</p><p>Mass $=4(22.99+35.45)\\times1.6605\\times10^{-27}\\approx3.88\\times10^{-25}$ kg → $\\rho\\approx2234$ kg/m³.</p>')+
   prac('<p>KCl has the same structure, with $r_{K^+}=1.33$ Å, $r_{Cl^-}=1.81$ Å, $M_K=39.10$, $M_{Cl}=35.45$ amu. Find $a$, $f$ and $\\rho$.</p>'))}

 ${tp('Planes &amp; directions')}
 ${prob('5','Miller indices from intercepts',
   pq('Determine the Miller indices $(hkl)$ of the planes having the following intercepts on the crystallographic axes: <b>(i)</b> $1$ Å, $2$ Å, $0.5$ Å in an orthorhombic crystal with $a{:}b{:}c=3{:}2{:}1$; <b>(ii)</b> $3a,\\;3b,\\;2c$; <b>(iii)</b> $a,\\;2b,\\;\\infty$; <b>(iv)</b> $a,\\;b,\\;-c$.')+
   pth('<p>Intercepts in units of $a,b,c$ → reciprocals → clear fractions. Take care when the axial ratios are not 1:1:1.</p>')+
   psol('<p><strong>(i)</strong> Intercepts $1,2,0.5$ Å with $a{:}b{:}c=3{:}2{:}1$ → fractional $\\tfrac13,1,\\tfrac12$ → reciprocals $3,1,2$ → $(312)$.</p><p><strong>(ii)</strong> $3a,3b,2c$ → reciprocals $\\tfrac13,\\tfrac13,\\tfrac12$ → ×6 → $(223)$.</p><p><strong>(iii)</strong> $a,2b,\\infty$ → $1,\\tfrac12,0$ → ×2 → $(210)$.</p><p><strong>(iv)</strong> $a,b,-c$ → $(11\\bar1)$.</p>')+
   prac('<p>A plane cuts $2$ Å, $-3$ Å, $1.5$ Å on an orthorhombic cell with $a{:}b{:}c=4{:}3{:}2$. Find $(hkl)$.</p>'))}

 ${prob('6','Angles between directions and planes',
   pq('<b>(1)</b> In a cubic unit cell, calculate the angle between the normals to the planes $(111)$ and $(121)$. <b>(2)</b> Calculate the angles that the $[111]$ direction makes with the $[100]$ and the $[110]$ directions.')+
   pth('<p>Cubic only: $\\cos\\theta=\\dfrac{h_1h_2+k_1k_2+l_1l_2}{\\sqrt{\\sum h_1^2}\\sqrt{\\sum h_2^2}}$, and the normal to $(hkl)$ is $[hkl]$.</p>')+
   psol('<p><strong>$(111)$ and $(121)$:</strong> $\\cos\\theta=\\dfrac{1+2+1}{\\sqrt3\\sqrt6}=\\dfrac{4}{3\\sqrt2}=0.943\\Rightarrow\\theta\\approx19.5^\\circ$.</p><p><strong>$[111]$ and $[100]$:</strong> $\\cos\\theta=\\dfrac1{\\sqrt3}\\Rightarrow54.7^\\circ$.</p><p><strong>$[111]$ and $[110]$:</strong> $\\cos\\theta=\\dfrac2{\\sqrt6}\\Rightarrow35.3^\\circ$.</p>')+
   prac('<p>Find the angle between $[1\\bar10]$ and $[10\\bar1]$, and between $[210]$ and the normal to $(112)$.</p>'))}

 ${prob('7','Which directions lie in a given plane',
   pq('Draw a $(1\\bar10)$ plane in a cubic unit cell. Show all the $\\langle111\\rangle$ directions that lie in this plane, and give their Miller indices.')+
   pth('<p>$[uvw]$ lies in $(hkl)$ exactly when $hu+kv+lw=0$.</p>')+
   psol('<p>For $(1\\bar10)$ the condition is $u-v=0$, i.e. $u=v$. Testing the eight members of $\\langle111\\rangle$, the ones that qualify are $$[111],\\;[\\bar1\\bar1\\bar1],\\;[11\\bar1],\\;[\\bar1\\bar11]$$ The other four have $u\\ne v$ and cut through the plane instead.</p>')+
   prac('<p>Which $\\langle110\\rangle$ directions lie in the $(111)$ plane?</p>'))}
`},

/* ═══════════════════ MODULE II ═══════════════════ */
{id:'m2-drude',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'The classical model, and why it fails',short:'Free electron theory',est:'~10 min',
 body:`
 ${gist('Treat the metal\'s loose electrons as a gas of tiny balls. It explains conduction — but gets heat capacity wrong by a factor of 100, because it ignores the Pauli principle.')}

 ${tp('The Drude–Lorentz picture')}
 <p>A metal is a rigid array of positive ion cores with the outer (valence) electrons set loose to wander. The model assumes:</p>
 <ul>
   <li>Electrons move freely; the ion cores just sit there.</li>
   <li>Electrons ignore each other (no repulsion).</li>
   <li>The potential inside is <strong>flat and constant</strong>, taken as zero — so an electron's energy is purely kinetic. <em>This is the assumption that eventually breaks everything.</em></li>
   <li>Outside is higher potential, so electrons stay trapped inside the metal.</li>
   <li>They behave like an ideal gas — but charged, and enormously denser than air ($n\\sim10^{28}$ per m³).</li>
   <li>Lorentz treated that gas with ordinary <strong>Maxwell–Boltzmann</strong> statistics.</li>
 </ul>

 ${fig('drude',
   'The whole classical model in one picture. Step 1 is the zero-field random walk — fast, and going nowhere. Step 2 adds the field: the walk is unchanged apart from a small nudge on each free flight, and those nudges accumulate into the slow <b>drift</b> that carries the current. The grey path is the same walk without the field, drawn for comparison — the difference between them is the entire current in a wire.',
   '<span><i class="fill" style="background:var(--pos)"></i>ion cores · the electron path</span>'+
   '<span><i style="border-color:var(--prob)"></i>net drift</span>')}

 ${tp('Three successes, four failures')}
 <p><strong>What it gets right:</strong></p>
 <ol>
   <li><strong>Ohm's law.</strong> With no field the motion is random and there is no current; apply a field and the electrons drift, scattering as they go, giving a steady current proportional to voltage.</li>
   <li><strong>Wiedemann–Franz law.</strong> The same electrons carry both charge and heat, so the ratio $\\sigma/K$ is the same constant for every metal at a given temperature.</li>
   <li><strong>Optical properties.</strong> Opacity and metallic shine — the electrons absorb the incoming wave, oscillate, and re-radiate it.</li>
 </ol>
 <p><strong>What it gets wrong:</strong></p>
 <ol>
   <li><strong>Resistivity vs temperature.</strong> Predicts $\\rho\\propto\\sqrt T$; experiment says $\\rho\\propto T$.</li>
   <li><strong>Electronic heat capacity.</strong> Equipartition gives every electron $\\tfrac32k_BT$, predicting $C_v=\\tfrac32R$ per mole. Measurements give <strong>about 1% of that</strong>, and it grows <em>linearly</em> with $T$.</li>
   <li><strong>Magnetic susceptibility.</strong> Predicts a strong $1/T$ (Curie) behaviour; the real thing is small and almost temperature-independent.</li>
   <li><strong>Mean free path.</strong> Cannot explain why, at low temperature, an electron travels past $10^8$–$10^9$ atoms without scattering.</li>
 </ol>
 ${trap(`<p>All four failures share one cause: <strong>wrong statistics</strong>. Maxwell–Boltzmann lets every electron soak up thermal energy; the Pauli exclusion principle does not. Sommerfeld fixes the first three by switching to Fermi–Dirac statistics. The fourth needs the <em>periodic lattice</em> — and that is band theory.</p>`)}

 ${chk(
   'The classical model over-predicts the electronic heat capacity by about 100×. Give the physical reason in one sentence.',
   '<p>Because it assumes <strong>every</strong> electron can absorb $\\sim k_BT$ of heat, whereas the Pauli principle blocks all but the tiny fraction sitting within about $k_BT$ of the topmost filled level — an electron deep down has nowhere to go, since every nearby level is already occupied.</p><p>Only a fraction $\\sim k_BT/E_F=T/T_F\\approx0.01$ can take part, which suppresses $C_v$ by exactly that factor <em>and</em> makes it grow linearly with $T$ instead of staying constant.</p>')}
`},

{id:'m2-fermi',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'Electrons in a box → the Fermi sphere',short:'Fermi energy &amp; friends',est:'~16 min',
 body:`
 ${gist('Trap electrons in a box, fill the levels two at a time from the bottom. The energy of the topmost filled level is the <b>Fermi energy</b> $E_F$, and it depends only on the electron density.')}

 ${tp('One dimension first')}
 <p>Put one electron on a line of length $L$ with walls it cannot pass. Solving the Schrödinger equation gives the standing waves you would expect on a guitar string:</p>
 $$\\psi_n(x)=\\sqrt{\\frac2L}\\sin\\!\\Big(\\frac{n\\pi x}{L}\\Big),\\qquad E_n=\\frac{n^2h^2}{8mL^2}$$
 <p>Now add $N$ electrons. The <strong>Pauli exclusion principle</strong> allows two per level (spin up and spin down), so they stack up from the bottom and fill levels up to $n_F=N/2$. The energy of that top level is the Fermi energy:</p>
 $$E_F=\\frac{h^2}{8m}\\left(\\frac{N}{2L}\\right)^2$$
 <p>Adding all the filled levels (using $\\sum n^2\\approx s^3/3$) gives the average energy per electron in 1-D as $\\bar E_0=\\tfrac13E_F$. The 1-D density of states — the number of levels per unit energy — works out to $D(E)\\propto E^{-1/2}$.</p>
 ${trap(`<p>Watch the dimension. In <strong>1-D</strong> $D(E)\\propto E^{-1/2}$ (falling); in <strong>3-D</strong> $D(E)\\propto E^{+1/2}$ (rising). Same particle — only the geometry of counting states changes. Never quote one for the other.</p>`)}

 ${tp('Three dimensions and the Fermi sphere')}
 <p>In a cube of volume $V=L^3$ we use travelling waves and <em>periodic</em> boundary conditions (the crystal wraps around on itself — mathematically neater than hard walls):</p>
 $$\\psi_{\\mathbf k}(\\mathbf r)=\\frac{1}{\\sqrt V}e^{i\\mathbf k\\cdot\\mathbf r},\\qquad k_x=\\frac{2\\pi n_x}{L}\\ \\text{(and similarly for }y,z)$$
 <p>So the allowed $\\mathbf k$ values form a fine 3-D grid, each state occupying a $k$-space volume $(2\\pi/L)^3$. The energy is $E=\\hbar^2k^2/2m$, so <em>states with the same energy lie on a sphere</em>. At $T=0$ the electrons fill that sphere from the middle outwards, up to a radius $k_F$ — the <strong>Fermi sphere</strong>.</p>

 ${lad('Everything from the electron density n',[
   {why:'Count the states inside the sphere: sphere volume ÷ volume per state, doubled for spin.',
    m:'$$N=2\\cdot\\frac{\\tfrac43\\pi k_F^3}{(2\\pi/L)^3}=\\frac{V}{3\\pi^2}k_F^3$$'},
   {why:'Solve for $k_F$ — remarkably, it depends only on the density $n=N/V$, not on the size or shape of the crystal.',
    m:'$$k_F=(3\\pi^2n)^{1/3}$$'},
   {why:'Feed that into $E=\\hbar^2k^2/2m$. This is the formula every numerical uses.',
    m:'$$\\boxed{\\;E_F=\\frac{\\hbar^2}{2m}(3\\pi^2n)^{2/3}\\;}$$'},
   {why:'Speed and temperature at the Fermi surface follow at once.',
    m:'$$v_F=\\frac{\\hbar k_F}{m},\\qquad T_F=\\frac{E_F}{k_B}$$'}
 ])}

 ${must(`<p>Typical metal values, worth knowing as sanity checks: $E_F\\approx2$–$7$ eV, $v_F\\approx10^6$ m/s, $T_F\\approx10^4$–$10^5$ K.</p>
 <p>That last one is the key to Module II: $T_F$ is <em>enormous</em> compared with room temperature, so 300 K is effectively “ice cold” for an electron gas — almost nothing is thermally excited.</p>`)}

 <p><strong>The route for every numerical:</strong> structure → $a$ → $n=(\\text{atoms per cell}\\times\\text{valency})/a^3$ → $k_F$ → $E_F$ → $v_F,T_F$. Drill that chain; it is most of the marks in this module.</p>

 ${chk(
   'Silver is FCC with atomic radius $1.44$ Å and one free electron per atom. Outline the steps to $E_F$ — no arithmetic needed.',
   '<p><strong>(1)</strong> FCC touches along the face diagonal: $4r=\\sqrt2a$, so $a=2\\sqrt2r$.<br><strong>(2)</strong> An FCC conventional cell holds 4 atoms, so 4 free electrons (monovalent).<br><strong>(3)</strong> Density $n=4/a^3$.<br><strong>(4)</strong> $E_F=\\dfrac{\\hbar^2}{2m}(3\\pi^2n)^{2/3}$.</p><p>Every Fermi-parameter problem is that same chain. (For silver: $n\\approx5.9\\times10^{28}$ m⁻³ and $E_F\\approx5.5$ eV — comfortably inside the expected 2–7 eV range.)</p>')}
`},

{id:'m2-dos',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'Density of states, and the 3/5 rule',short:'Density of states',est:'~10 min',
 body:`
 ${gist('$D(E)$ counts how many electron levels sit in each slice of energy. In 3-D it grows as $\\sqrt E$, which makes the average electron energy $\\tfrac35E_F$.')}

 ${tp('What D(E) means and what it is')}
 <p>The <strong>density of states</strong> $D(E)$ is simply: <em>how many available levels lie between energy $E$ and $E+dE$</em>. It matters because anything electrons do — absorb heat, conduct, get excited — depends on how many states are available to move into.</p>
 <p>Differentiate the state count $N=\\dfrac{V}{3\\pi^2}\\Big(\\dfrac{2mE_F}{\\hbar^2}\\Big)^{3/2}$ with respect to energy:</p>
 $$D(E)=\\frac{dN}{dE}=\\frac{V}{2\\pi^2}\\left(\\frac{2m}{\\hbar^2}\\right)^{3/2}E^{1/2}\\;\\propto\\;\\sqrt E$$
 <p>There is a neat shortcut for the value at the top. Since $N\\propto E_F^{3/2}$, taking logs and differentiating gives:</p>
 ${must(`$$D(E_F)=\\frac{3}{2}\\frac{N}{E_F}$$`)}

 ${fig3d('fermi3d',
   'The picture behind every Fermi-energy numerical. The allowed states form a grid in $k$-space; at $T=0$ they fill from the middle outwards, and the surface where the filling stops is a sphere. Rotate it — the point of the free-electron model is that this region is a <em>ball</em>, so counting states is just a volume ÷ a volume.',
   '<span><i class="fill" style="background:var(--neg)"></i>filled states</span>'+
   '<span><i style="border-color:var(--prob)"></i>the Fermi surface</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>k_F</span>')}

 ${fig('dos',
   'Built in five steps — count states in $k$-space, change the variable to energy, differentiate, fill to $E_F$, then read off the two results. The chips switch the <b>dimensionality</b>, and that changes everything: in 3-D $D\\propto\\sqrt E$ is top-heavy and gives $\\langle E\\rangle=\\tfrac35E_F$; in 2-D $D$ is flat and gives exactly $\\tfrac12E_F$; in 1-D $D\\propto E^{-1/2}$ is bottom-heavy and gives $\\tfrac13E_F$. Those three numbers are three different exam questions.',
   '<span><i style="border-color:var(--neg)"></i>D(E)</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>filled at T = 0</span>'+
   '<span><i class="dash" style="border-color:var(--pos)"></i>the mean energy</span>')}

 ${tp('Why the dimension matters — and the 1-D case they ask for')}
 <p>The shape of $D(E)$ is not a detail; it is decided by how much room a shell of $k$-space has at radius $k$, and that depends on the number of dimensions. Counting states out to $k$ gives $N\\propto k^d$ in $d$ dimensions, and with $E\\propto k^2$ that becomes $N\\propto E^{d/2}$, so</p>
 $$D(E)=\\frac{dN}{dE}\;\\propto\;E^{\\frac d2-1}$$
 ${must(`<p><strong>1-D:</strong> $D(E)=\\dfrac{L}{\\pi}\\left(\\dfrac{2m}{\\hbar^2}\\right)^{1/2}E^{-1/2}$ — <em>falls</em> with energy, diverges at the band bottom.<br>
 <strong>2-D:</strong> $D(E)=\\dfrac{Am}{\\pi\\hbar^{2}}$ — a constant, independent of $E$.<br>
 <strong>3-D:</strong> $D(E)=\\dfrac{V}{2\\pi^{2}}\\left(\\dfrac{2m}{\\hbar^{2}}\\right)^{3/2}E^{1/2}$ — <em>rises</em> as $\\sqrt E$.</p>`)}
 <p>And because the average energy is $D$-weighted, each shape drags the mean a different way: $\\tfrac13E_F$ in 1-D, $\\tfrac12E_F$ in 2-D, $\\tfrac35E_F$ in 3-D. If a question says “one-dimensional”, it is almost always asking for the $E^{-1/2}$ derivation or the $\\tfrac13E_F$ that follows from it.</p>

 ${tp('Average energy = (3/5)E_F, and degeneracy pressure')}
 <p>Averaging the energy, weighted by how many states each energy has:</p>
 $$\\bar E_0=\\frac1N\\int_0^{E_F}E\\,D(E)\\,dE
   =\\frac{\\tfrac25E_F^{5/2}}{\\tfrac23E_F^{3/2}}=\\boxed{\\;\\frac35E_F\\;}$$
 <p>So even at absolute zero the electron gas is buzzing with kinetic energy — it cannot all settle to zero because Pauli forbids stacking everyone in the ground state. That leftover energy pushes outwards as a <strong>degeneracy pressure</strong>:</p>
 $$P=\\frac25\\frac{NE_F}{V}=\\frac23\\frac EV,\\qquad B=\\frac53P=\\frac23nE_F$$
 <p>where $B$ is the bulk modulus. These two lines are all you need for the compressibility numericals.</p>

 ${chk(
   'Why is the average electron energy $\\tfrac35E_F$ rather than the naive $\\tfrac12E_F$?',
   '<p>Because the levels are <strong>not spread evenly in energy</strong>. With $D(E)\\propto\\sqrt E$ there are more states — and so more electrons — at high energy than at low, so the distribution is top-heavy and the mean sits <em>above</em> the midpoint.</p><p>Doing the weighted average with $D\\propto E^{1/2}$ gives $\\dfrac{2/5}{2/3}=\\dfrac35$. A perfectly flat $D(E)$ would indeed have given $\\tfrac12E_F$; in 1-D, where $D\\propto E^{-1/2}$ is bottom-heavy, the answer drops to $\\tfrac13E_F$.</p>')}
`},

{id:'m2-fd',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'Fermi–Dirac, and the heat capacity puzzle',short:'Fermi–Dirac &amp; heat capacity',est:'~12 min',
 body:`
 ${gist('The Fermi function says a level is occupied with probability $f(E)$. Warming a metal only disturbs a thin sliver of width $k_BT$ around $E_F$ — which is why $C_v$ is tiny and grows linearly with $T$.')}

 ${tp('The Fermi function')}
 $$f(E)=\\frac{1}{\\exp\\!\\left(\\dfrac{E-E_F}{k_BT}\\right)+1}$$
 <p>Read it as: <em>the chance that a level of energy $E$ actually has an electron in it</em>. That $+1$ in the denominator is the whole difference from classical statistics — it is what stops the probability ever exceeding 1, i.e. it is Pauli exclusion written as a formula.</p>
 <ul>
   <li><strong>At $T=0$</strong> it is a perfect step: $f=1$ below $E_F$, $f=0$ above. Everything is filled to the brim and nothing above.</li>
   <li><strong>At $T>0$</strong> the step softens over a width of about $k_BT$, and — worth memorising — <strong>$f(E_F)=\\tfrac12$ at every temperature</strong>.</li>
   <li>$E_F$ itself barely moves with temperature: $E_F(T)\\approx E_{F0}\\Big[1-\\dfrac{\\pi^2}{12}\\Big(\\dfrac{k_BT}{E_{F0}}\\Big)^2\\Big]$.</li>
 </ul>

 ${fig('fermi',
   'The step, and how little it softens. Four temperatures are plotted from the exact formula. Even at high $T$ only a sliver of width $\\sim k_BT$ around $E_F$ is disturbed, and all four curves pass through $f=\\tfrac12$ exactly at $E_F$. Everything deep down stays frozen at $f=1$ because Pauli gives it nowhere to go.',
   '<span><i style="border-color:var(--ink)"></i>T = 0</span><span><i style="border-color:var(--pos)"></i>low T</span><span><i style="border-color:var(--prob)"></i>high T</span>')}

 ${tp('Why the electronic heat capacity is so small')}
 ${fig('fdwindow',
   'The answer to “why is the electronic heat capacity so small?” in four steps. Everything hangs on the width of the softened region: it is about $k_BT$, and $k_BT$ at room temperature is a fiftieth of an electron-volt against a Fermi energy of several. Only that sliver of electrons has anywhere to go.',
   '<span><i class="dash" style="border-color:var(--ink)"></i>T = 0</span>'+
   '<span><i style="border-color:var(--neg)"></i>T > 0</span>'+
   '<span><i class="fill" style="background:var(--prob)"></i>the k_BT window</span>')}

 ${lad('The T/T_F suppression',[
   {why:'Only electrons within about $k_BT$ of the top have empty states to move into. That is a small fraction of the total.',
    m:'$$N_{\\text{eff}}\\approx N\\,\\frac{k_BT}{E_F}=N\\,\\frac{T}{T_F}$$'},
   {why:'Each of those picks up roughly $k_BT$ of thermal energy.',
    m:'$$E_{\\text{thermal}}\\approx N_{\\text{eff}}\\,k_BT\\approx Nk_B\\frac{T^2}{T_F}$$'},
   {why:'Heat capacity is the rate of change of that with temperature.',
    m:'$$C_v=\\frac{\\partial E_{\\text{thermal}}}{\\partial T}\\approx\\frac32Nk_B\\left(\\frac{T}{T_F}\\right)$$'},
   {why:'Since $T_F\\sim10^4$–$10^5$ K, at room temperature $T/T_F\\sim0.01$ — and note it is proportional to $T$, not constant.',
    m:'$$C_v\\sim1\\%\\text{ of the classical }\\tfrac32Nk_B,\\qquad C_v\\propto T\\;\\checkmark$$'}
 ])}

 ${fig('cv',
   'The same result as a picture. The dashed line is what equipartition predicts — a constant $\\tfrac32R$ at every temperature. The teal curve is the quantum answer, <b>magnified 50×</b> just to be visible on the same axis: it is a straight line through the origin, so it vanishes as $T\\to0$ and never gets anywhere near the classical value at ordinary temperatures. Measure $C_v$ at low $T$ and you get $\\gamma T+AT^3$ — the electron term linear, the lattice term cubic.',
   '<span><i class="dash" style="border-color:var(--ink)"></i>classical (3/2)R</span>'+
   '<span><i style="border-color:var(--neg)"></i>quantum, ×50</span>')}
 <p>Both failures of the classical model are cured at once: the size is right, and the linear temperature dependence is right.</p>

 ${chk(
   'With $T_F=5\\times10^4$ K, estimate the molar electronic heat capacity at $T=100$ K, and compare with the lattice value $3R$.',
   '<p>$\\dfrac{T}{T_F}=\\dfrac{100}{5\\times10^4}=2\\times10^{-3}$, so $$C_v\\approx\\tfrac32R\\left(\\tfrac{T}{T_F}\\right)=\\tfrac32(8.314)(2\\times10^{-3})\\approx0.025\\ \\text{J mol}^{-1}\\text{K}^{-1}$$</p><p>The lattice (Dulong–Petit) value is $3R\\approx24.9$ J mol⁻¹K⁻¹ — about <strong>1000× bigger</strong>. That is why the electronic part is invisible at ordinary temperatures and only shows up at very low $T$, where the lattice term dies away as $T^3$ while the electronic term dies only as $T$.</p>')}
`},

{id:'m2-bloch',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'Why gaps exist, and Bloch\'s theorem',short:'Band gaps &amp; Bloch',est:'~14 min',
 body:`
 ${gist('Put the electron in a <b>repeating</b> potential instead of a flat one. Bragg reflection at the zone boundary opens gaps, and Bloch\'s theorem says the wavefunction is a plane wave times a lattice-periodic ripple.')}

 ${tp('Where the gaps come from')}
 <p>The free-electron model cannot explain three things: why solids split into conductors, semiconductors and insulators; why the Hall coefficient is sometimes <em>positive</em>; and why semiconductor resistivity falls as it warms.</p>
 <p>The culprit is the flat-potential assumption. A real electron travels through a <em>repeating</em> row of positive ion cores, so the potential repeats too:</p>
 $$V(x)=V(x+a)$$
 <p>Once it repeats, an electron wave can Bragg-reflect off it — exactly as an X-ray does. That happens when</p>
 $$k=\\frac{n\\pi}{a}\\qquad\\text{(the Brillouin zone boundaries)}$$
 <p>At those $k$ the forward and reflected waves are equally strong and combine into <strong>standing waves</strong>. Two standing waves are possible: one piles the electron charge <em>on top of</em> the positive cores (lower energy, more attraction), the other piles it <em>between</em> them (higher energy). No state exists in between — and that missing range of energies is the <strong>band gap</strong>.</p>
 ${fig('standing',
   'The most important picture in Module II. Step 2 is the Bragg reflection; steps 3 and 4 are the only two standing waves you can build from it, and the whole gap is the difference between where those two put their charge — on the cores, or between them. Step 5 shows the consequence on the $E(k)$ curve: two energies at one $k$, and nothing allowed in between.',
   '<span><i class="fill" style="background:var(--pos)"></i>ψ₊ — charge on the cores</span>'+
   '<span><i class="fill" style="background:var(--neg)"></i>ψ₋ — charge between them</span>'+
   '<span><i class="fill" style="background:var(--wall)"></i>the gap</span>')}

 ${must(`<p>Gaps open at $k=\\pm n\\pi/a$, the Brillouin zone boundaries, because that is where Bragg reflection turns travelling waves into standing waves.</p>`)}

 ${tp('Bloch\'s theorem')}
 <p>The theorem tells you the <em>shape</em> any wavefunction must have in a repeating potential:</p>
 $$\\psi(x)=e^{ikx}u_k(x),\\qquad\\text{where } u_k(x)=u_k(x+a)$$
 <p>In words: a plane wave (the free-electron part) <strong>multiplied by</strong> a ripple that repeats with the lattice. The electron still travels through the crystal; it just gets modulated as it passes each atom.</p>

 ${fig('bloch',
   'The theorem as an assembly job: plane wave × lattice-periodic ripple = Bloch state. The dashed envelope at the last step is $\\pm u_k(x)$ — note it repeats every $a$ while the wave inside it does not, which is exactly what “$\\psi(x+a)=e^{ika}\\psi(x)$” means. Nothing about it decays with distance, and that is the sentence that answers the mean-free-path failure.',
   '<span><i style="border-color:var(--prob)"></i>e^{ikx}</span>'+
   '<span><i style="border-color:var(--neg)"></i>u_k(x)</span>'+
   '<span><i style="border-color:var(--pos)"></i>ψ and its envelope</span>')}

 <p><strong>How the proof runs</strong> (enough to reproduce the argument):</p>
 <ol>
   <li>The equation is second order, so it has two independent solutions $f$ and $g$. Because $V$ repeats, the shifted functions $f(x+a)$ and $g(x+a)$ must also be solutions, so they are combinations of $f$ and $g$.</li>
   <li>Requiring that shifting by $a$ only multiplies $\\psi$ by a constant, $\\psi(x+a)=\\lambda\\psi(x)$, gives a $2\\times2$ determinant condition — a quadratic in $\\lambda$.</li>
   <li>The <strong>Wronskian</strong> $W=fg'-gf'$ is the same at $x$ and $x+a$, which forces the constant term of that quadratic to be $1$. So $\\lambda_1\\lambda_2=1$.</li>
 </ol>
 <p>Two cases follow, and this is the punchline:</p>
 <ul>
   <li><strong>Roots complex, $|\\lambda|=1$:</strong> then $\\lambda=e^{\\pm ika}$ with real $k$, giving $\\psi(x+a)=e^{\\pm ika}\\psi(x)$ — exactly the Bloch form. The wave stays finite everywhere. These are the <strong>allowed bands</strong>.</li>
   <li><strong>Roots real, $\\lambda=e^{\\pm\\mu a}$:</strong> then $\\psi$ grows without limit at one end, so it cannot be normalised and is unphysical. These are the <strong>forbidden gaps</strong>.</li>
 </ul>

 ${chk(
   'What does Bloch\'s theorem say about an electron in a <em>perfect</em> crystal — and how does that fix the classical mean-free-path failure?',
   '<p>It says the stationary states of a perfect repeating lattice are $\\psi=e^{ikx}u_k(x)$ — <strong>extended travelling waves that never decay</strong>. An electron in such a state propagates through the crystal <em>without scattering at all</em>.</p><p>So a perfectly periodic lattice offers no resistance whatsoever. Resistance comes only from <em>departures</em> from perfect periodicity: thermal vibrations of the atoms (phonons), impurities and defects. Cool a pure metal and those vanish, letting the mean free path stretch to $10^8$–$10^9$ atomic spacings — the fourth failure of the classical model, now explained.</p>')}
`},

{id:'m2-kp',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'The Kronig–Penney model &amp; band capacity',short:'Kronig–Penney',est:'~14 min',
 body:`
 ${gist('A solvable repeating potential. One equation, whose left side must stay between $-1$ and $+1$ — inside that range you get an allowed band, outside it a gap.')}

 ${tp('The model and its one equation')}
 <p>Replace the real potential with a row of square wells and barriers of period $(a+b)$: zero inside the well of width $a$, height $V_0$ across the barrier of width $b$. Solve in each region, apply Bloch's theorem, match the wavefunction and its slope at the boundaries, and set the resulting determinant to zero.</p>
 <p>In the useful limit where the barrier becomes very tall and very thin (with $V_0b$ held fixed), the answer collapses to a single tidy condition:</p>
 ${must(`$$\\boxed{\\;P\\,\\frac{\\sin(\\alpha a)}{\\alpha a}+\\cos(\\alpha a)=\\cos(ka)\\;}\\qquad
 P=\\frac{mV_0ba}{\\hbar^2},\\quad \\alpha=\\sqrt{\\frac{2mE}{\\hbar^2}}$$
 <p>$P$ is the dimensionless <em>barrier strength</em> — how tightly the lattice grips the electron.</p>`)}

 ${tp('Reading bands and gaps off it')}
 <p>Here is the trick that makes the whole model work. The right-hand side is a cosine, so it <strong>can never leave the range $-1$ to $+1$</strong>. A real value of $k$ therefore exists only when</p>
 $$-1\\le P\\frac{\\sin(\\alpha a)}{\\alpha a}+\\cos(\\alpha a)\\le1$$
 <p>Energies satisfying that are <strong>allowed</strong>; energies where the left side escapes the range are <strong>forbidden</strong>. Plot the left side and the band structure simply appears.</p>

 ${fig('kp',
   'The whole band structure in one curve, built in four steps. Then use the chips on $P$: at $P\\to0$ the curve never leaves the corridor and there are <em>no gaps at all</em> — the free electron is back. Crank $P$ up and each allowed band is squeezed towards a single sharp level — isolated atoms. Those are the two limits the paper asks for, and here you can watch them happen.',
   '<span><i style="border-color:var(--prob)"></i>left-hand side</span><span><i class="fill" style="background:var(--pos)"></i>allowed bands</span><span><i class="dash" style="border-color:var(--wall)"></i>±1 limit</span>')}

 ${must(`<p><strong>The two limits — very commonly asked:</strong></p>
 <ul>
   <li><strong>$P\\to\\infty$</strong> (huge barriers, isolated atoms): needs $\\sin(\\alpha a)=0$, so $\\alpha a=n\\pi$ and $E_n=\\dfrac{n^2h^2}{8ma^2}$. The bands shrink to sharp atomic levels.</li>
   <li><strong>$P\\to0$</strong> (no barriers, free electrons): gives $\\cos(\\alpha a)=\\cos(ka)$, so $\\alpha=k$ and $E=\\dfrac{\\hbar^2k^2}{2m}$. The gaps vanish and the free-electron parabola is back.</li>
 </ul>
 <p>Also: as energy rises, the $1/\\alpha a$ factor shrinks the oscillation, so <strong>bands get wider and gaps get narrower</strong>.</p>`)}

 ${tp('How the bands are drawn, and how many electrons fit')}
 <p>Since $\\cos(ka)$ repeats every $2\\pi/a$, $E(k)$ is periodic in $k$-space. Three standard ways to draw it: the <strong>extended</strong> scheme (band $n$ drawn in zone $n$), the <strong>reduced</strong> scheme (everything folded back into the first zone), and the <strong>periodic</strong> scheme (repeated in every zone). Same information, three pictures.</p>

 ${fig('bands',
   'All three zone schemes, one per step — extended, reduced, periodic. They contain identical information; only the bookkeeping changes. Step through them once and the exam question “which scheme is this, and what does it show?” becomes free marks.',
   '<span><i class="dash" style="border-color:var(--ink)"></i>free electron</span><span><i style="border-color:var(--pos)"></i>band 1</span><span><i class="fill" style="background:var(--wall)"></i>gap</span>')}

 <p>Now count the states. For a crystal of $N$ cells and length $L=Na$, periodic boundary conditions give $k=2\\pi n/L$, so the number of $k$ states in one zone (width $2\\pi/a$) is $\\dfrac{L}{2\\pi}\\cdot\\dfrac{2\\pi}{a}=\\dfrac La=N$. With two spins:</p>
 ${must(`<p><strong>One band holds exactly $2N$ electrons</strong>, where $N$ = number of primitive cells. One valence electron per atom → band half full → metal. Two per atom → band exactly full → insulator, <em>unless</em> bands overlap.</p>`)}

 ${chk(
   'In the Kronig–Penney picture, why do the forbidden gaps get narrower at higher energy?',
   '<p>Because the lattice\'s influence enters through the term $P\\dfrac{\\sin(\\alpha a)}{\\alpha a}$, whose size falls off like $1/\\alpha a$. At high energy $\\alpha a$ is large, so that term shrinks and the left-hand side is dominated by $\\cos(\\alpha a)$, which already lives inside $[-1,1]$.</p><p>The curve therefore spends more time inside the corridor (wider allowed bands) and pokes out less often and less far (narrower gaps). Physically: a fast electron spends little time near each ion core, so the lattice barely perturbs it — at high enough energy it behaves almost freely.</p>')}
`},

{id:'m2-dynamics',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'Effective mass, holes, and the three classes of solid',short:'Effective mass &amp; classification',est:'~16 min',
 body:`
 ${gist('An electron in a band responds to a field as if it had a different mass $m^{*}=\\hbar^2/(d^2E/dk^2)$ — which can even be negative. A full band carries no current at all.')}

 ${tp('Speed and effective mass')}
 <p>An electron in state $k$ is really a wave packet, and it travels at the <strong>group velocity</strong>:</p>
 $$v=\\frac1\\hbar\\frac{dE}{dk}$$
 <p>So the <em>slope</em> of the band gives the speed. At the bottom of a band ($k=0$) and at the zone boundary ($k=\\pm\\pi/a$) the slope is zero, so $v=0$ — those are the standing waves again. The speed peaks in between, at the point of steepest slope.</p>

 ${lad('Deriving the effective mass',[
   {why:'A field $\\mathcal E$ does work on the electron as it moves. Write that work using $v=\\hbar^{-1}dE/dk$.',
    m:'$$dE=e\\mathcal E\\,v\\,dt=\\frac{e\\mathcal E}{\\hbar}\\frac{dE}{dk}\\,dt$$'},
   {why:'But also $dE=(dE/dk)\\,dk$. Compare the two and cancel $dE/dk$ — a Newton-like law appears.',
    m:'$$\\hbar\\frac{dk}{dt}=e\\mathcal E=F_{\\text{ext}}$$'},
   {why:'Now differentiate the velocity to get the acceleration, using the chain rule.',
    m:'$$a=\\frac{dv}{dt}=\\frac1\\hbar\\frac{d^2E}{dk^2}\\frac{dk}{dt}=\\frac{e\\mathcal E}{\\hbar^2}\\frac{d^2E}{dk^2}$$'},
   {why:'Compare with $a=F/m^{*}$ and read off the mass. The <em>curvature</em> of the band is what plays the role of mass.',
    m:'$$\\boxed{\\;m^{*}=\\frac{\\hbar^{2}}{d^{2}E/dk^{2}}\\;}$$'}
 ])}

 ${tp('Reading $m^{*}$ off a band — the practical version')}
 <p>You are never asked to compute $m^{*}$ from first principles; you are asked to <em>read</em> it. Three rules cover every question:</p>
 <ul>
   <li><strong>Curvature is everything.</strong> $m^{*}=\\hbar^{2}\\big/\\dfrac{d^{2}E}{dk^{2}}$, so a sharply curved band means a light, responsive electron and a flat band means a heavy, sluggish one. Narrow bands (weakly overlapping atomic orbitals) therefore give large effective masses — that is why $d$-band electrons in transition metals are heavy.</li>
   <li><strong>Bottom of a band: $m^{*}$ small and positive.</strong> Here $E\\approx E_0+\\hbar^{2}k^{2}/2m^{*}$ and the electron behaves exactly like a free particle that happens to have the wrong mass. This is the region that matters for a semiconductor’s conduction band.</li>
   <li><strong>Top of a band: $m^{*}$ negative.</strong> The curvature has flipped, and the electron accelerates against the applied force. This is the region that matters for holes.</li>
 </ul>
 <p>In between, at the inflection point $k=\\pm\\pi/2a$, the curvature passes through zero and $m^{*}$ formally <em>diverges</em> — the electron there refuses to accelerate at all, because the lattice takes back exactly as much momentum as the field supplies.</p>

 ${fig('effmass',
   'One band, differentiated twice — one panel per step. Top: $E(k)$. Middle: the slope, giving the velocity — zero at both ends, maximum at the inflection. Bottom: the curvature, which is proportional to $1/m^{*}$ — positive in the lower half of the band, zero at the inflection (so $m^{*}\\to\\infty$ there), and negative in the upper half.',
   '<span><i style="border-color:var(--pos)"></i>E(k)</span><span><i style="border-color:var(--neg)"></i>v(k)</span><span><i style="border-color:var(--prob)"></i>1/m*</span>')}

 <ul>
   <li><strong>Lower half of the band:</strong> curvature positive → $m^{*}>0$, the electron accelerates the way you push it.</li>
   <li><strong>At the inflection:</strong> curvature zero → $m^{*}\\to\\infty$, the field cannot change its speed at all.</li>
   <li><strong>Upper half:</strong> curvature negative → $m^{*}<0$. The electron accelerates <em>backwards</em>.</li>
 </ul>
 ${trap(`<p>Negative mass looks like nonsense but breaks nothing. $m^{*}$ is a bookkeeping trick that hides the lattice force: the electron really feels both the applied field <em>and</em> the lattice. Near the top of a band the lattice force (Bragg reflection handing momentum back to the crystal) beats the applied force, so the net acceleration opposes the field — and we record that as $m^{*}<0$. Total momentum, electron plus lattice, is conserved throughout.</p>`)}

 ${tp('Holes')}
 ${fig('hole',
   'Where the fictitious positive particle comes from. The key move is step 2: instead of adding up the currents of every remaining electron, subtract the one that is missing. Because that missing electron sat where $m^{*}<0$, the two minus signs cancel and the vacancy behaves like a genuinely positive particle. This is the whole content of “holes”, and it is why a Hall measurement can report the wrong sign of carrier.',
   '<span><i class="fill" style="background:var(--neg)"></i>occupied states</span>'+
   '<span><i style="border-color:var(--wall)"></i>the vacancy — the hole</span>')}
 <p>A nearly full band with one electron missing is far easier to describe by tracking the <em>vacancy</em> instead of the $10^{23}$ remaining electrons. Because the missing electron sat where $m^{*}$ is negative, the vacancy — a <strong>hole</strong> — behaves as a real particle with</p>
 $$m^{*}_h=-m^{*}_e>0,\\qquad \\mathbf k_h=-\\mathbf k_e,\\qquad \\mathbf v_h=\\mathbf v_e,\\qquad q_h=+e$$
 <p>A positive charge with a positive mass. This is what makes the Hall coefficient come out positive in some materials — something free-electron theory could never explain.</p>

 ${tp('Metals, semiconductors, insulators')}
 <p>First the key result: <strong>a completely full band carries no current.</strong> Summing the contributions of all its electrons gives a total proportional to $dE/dk$ evaluated at the zone boundary — and that slope is zero. So no matter how hard you push, a full band contributes nothing. <em>Conduction requires a partly filled band.</em></p>

 ${must(`<p><strong>The one-line test.</strong> A solid conducts if and only if there is an <em>empty</em> level immediately above an <em>occupied</em> one. Partly filled band, or two bands overlapping → metal. Full band with a big gap above it → insulator. Full band with a small gap above it → semiconductor, which is an insulator at $T=0$ and a conductor when warmed.</p>`)}

 ${fig('classify',
   'The three cases. Teal = filled valence band, outlined = empty conduction band. A metal has no gap at the top of the filled states, so empty levels sit immediately above occupied ones. A semiconductor has a narrow gap that thermal energy can bridge. An insulator\'s gap is far beyond $k_BT\\approx0.026$ eV at room temperature.',
   '<span><i class="fill" style="background:var(--neg)"></i>filled band</span><span><i class="dash" style="border-color:var(--wall)"></i>gap</span>')}

 <ol>
   <li><strong>Insulator</strong> — full valence band, empty conduction band, wide gap $E_g\\gtrsim5$–6 eV (diamond). Thermal energy cannot lift electrons across. Essentially no conduction.</li>
   <li><strong>Semiconductor</strong> — same picture but a narrow gap, $E_g\\sim1$ eV (Si $1.1$, Ge $0.7$ eV). At $T=0$ it <em>is</em> an insulator. Warm it and electrons hop the gap leaving holes behind, with
     $$\\sigma\\propto e^{-E_g/2k_BT}$$ — conductivity rises steeply with temperature.</li>
   <li><strong>Metal</strong> — a partly filled band (one electron per atom filling half of the $2N$ capacity), or two bands that overlap (the alkaline earths). Empty states sit right next to filled ones, so conduction is easy. Here $\\sigma\\propto1/T$: warming adds lattice vibrations that scatter electrons more.</li>
 </ol>

 ${chk(
   'Metal conductivity falls as temperature rises, but semiconductor conductivity rises. Explain both in one sentence each.',
   '<p><strong>Metal:</strong> the number of carriers is already fixed (the band is partly filled and does not change), so heating only adds lattice vibrations that scatter the electrons more — mobility drops and $\\sigma\\propto1/T$.</p><p><strong>Semiconductor:</strong> here the carrier <em>number</em> is what changes — heating promotes exponentially more electrons across the gap, $n\\propto e^{-E_g/2k_BT}$, and that exponential gain easily beats the modest mobility loss, so $\\sigma$ climbs steeply.</p><p>Mobility falls with temperature in <em>both</em>; the difference is entirely whether the carrier count is fixed or thermally created.</p>')}
`},

/* ═══════════════════ MODULE II · PROBLEMS ═══════════════════ */
{id:'m2-problems',mod:'Module II',modName:'Electrons in solids',modClass:'m2',
 title:'Problems — Module II',short:'Problems II',est:'~20 min',
 body:`
 <p class="lead">Almost every question here is the same chain — <em>structure → a → n → k<sub>F</sub> → E<sub>F</sub></em>. Drill it until it is automatic.</p>

 ${tp('Fermi parameters')}
 ${prob('1','A 1-D metallic line',
   pq('Consider a one-dimensional metallic line of length $L=1$ cm carrying a linear electron concentration $N/L=5\\times10^7$ electrons/cm. Calculate the Fermi energy $E_F$ of the topmost occupied state at absolute zero, in eV. <span class="dim">(Take $m=9.11\\times10^{-28}$ g, $h=6.626\\times10^{-27}$ erg·s, $1$ eV $=1.602\\times10^{-12}$ erg.)</span>')+
   pth('<p>$E_n=\\dfrac{h^2n^2}{8mL^2}$; two electrons per level so $n_F=N/2$, giving $E_F=\\dfrac{h^2}{32m}\\Big(\\dfrac NL\\Big)^2$.</p>')+
   psol('<p>With $N/L=5\\times10^7$ cm⁻¹, $m=9.11\\times10^{-28}$ g, $h=6.626\\times10^{-27}$ erg·s:</p><p>$$E_F=\\frac{(6.626\\times10^{-27})^2}{32(9.11\\times10^{-28})}(5\\times10^7)^2\\approx3.77\\times10^{-12}\\ \\text{erg}$$</p><p>Divide by $1.602\\times10^{-12}$ erg/eV → $E_F\\approx2.35$ eV.</p>')+
   prac('<p>A 1-D polymer chain of length $2.0\\ \\mu$m holds $8\\times10^3$ conduction electrons. Find $n_F$, $k_F$ and $E_F$ in eV.</p>'))}

 ${prob('2','Sodium (BCC) — E_F from the atomic radius',
   pq('The atomic radius of sodium is $r=1.86$ Å. Sodium crystallizes in a BCC structure with one valence electron per atom. Calculate the Fermi energy of sodium at absolute zero.')+
   pth('<p>BCC touches along the body diagonal: $\\sqrt3a=4r$. A BCC cell holds 2 atoms → 2 electrons if monovalent.</p>')+
   psol('<p>$a=4r/\\sqrt3=4(1.86\\times10^{-10})/\\sqrt3=4.295\\times10^{-10}$ m → $V=a^3=7.93\\times10^{-29}$ m³.</p><p>$n=2/V=2.52\\times10^{28}$ m⁻³.</p><p>$3\\pi^2n=7.46\\times10^{29}$, so $(3\\pi^2n)^{2/3}=8.225\\times10^{19}$ m⁻².</p><p>$E_F=\\dfrac{(1.054\\times10^{-34})^2}{2(9.11\\times10^{-31})}(8.225\\times10^{19})\\approx4.98\\times10^{-19}$ J $\\approx3.11$ eV.</p>')+
   prac('<p>Lithium is BCC with $r=1.52$ Å and one electron per atom. Find the cell volume, $n$, and $E_F$ in eV.</p>'))}

 ${prob('3','Silver (FCC) — E_F, T_F and v_F',
   pq('Silver has an FCC structure with an atomic radius of $1.44$ Å. Assuming silver to be a monovalent metal, calculate the Fermi energy, the Fermi temperature and the Fermi velocity.')+
   pth('<p>FCC: $4r=\\sqrt2a$, 4 atoms per cell. Then $k_F=(3\\pi^2n)^{1/3}$, $E_F=\\hbar^2k_F^2/2m$, $T_F=E_F/k_B$, $v_F=\\hbar k_F/m$.</p>')+
   psol('<p>$a=2\\sqrt2(1.44\\times10^{-10})=4.073\\times10^{-10}$ m → $V=6.757\\times10^{-29}$ m³, $n=4/V=5.92\\times10^{28}$ m⁻³.</p><p>$k_F=(3\\pi^2n)^{1/3}\\approx1.206\\times10^{10}$ m⁻¹.</p><p>$E_F\\approx8.87\\times10^{-19}$ J $\\approx5.50$ eV.</p><p>$T_F=E_F/k_B\\approx6.4\\times10^{4}$ K; &nbsp; $v_F=\\hbar k_F/m\\approx1.39\\times10^{6}$ m/s.</p><p><em>Sanity check:</em> all three land in the expected ranges.</p>')+
   prac('<p>Gold (FCC, monovalent) has $r=1.442$ Å. Find $n$, $E_F$ in eV, $T_F$ and $v_F$.</p>'))}

 ${prob('4','Aluminium — E_F and ground-state energy density',
   pq('Aluminium crystallizes in an FCC structure with lattice constant $a=4$ Å. Assuming each atom contributes one free electron, calculate <b>(i)</b> the Fermi wave vector $k_F$ and the Fermi energy $E_F$, and <b>(ii)</b> the total kinetic energy of the free electron gas per unit volume at $0$ K.')+
   pth('<p>FCC, 4 atoms/cell. Average energy per electron at $T=0$ is $\\tfrac35E_F$, so the energy per unit volume is $u_0=\\tfrac35nE_F$.</p>')+
   psol('<p>$a=4$ Å → $V=6.4\\times10^{-29}$ m³; $n=4/V=6.25\\times10^{28}$ m⁻³.</p><p>$k_F\\approx7.73\\times10^{9}$ m⁻¹ → $E_F\\approx3.65\\times10^{-19}$ J $\\approx2.28$ eV.</p><p>$u_0=\\tfrac35nE_F=\\tfrac35(6.25\\times10^{28})(2.28)\\approx2.14\\times10^{28}$ eV/m³.</p>')+
   prac('<p>Copper is FCC with $a=3.61$ Å and one electron per atom. Find $n$, $k_F$, $E_F$ (eV) and $u_0$.</p>'))}

 ${prob('5','Potassium — bulk modulus and compressibility',
   pq('The density of potassium is $\\rho=860$ kg·m⁻³ and its atomic mass is $39.1$ amu. Potassium has a BCC lattice with one conduction electron per atom. Calculate the Fermi energy and the compressibility of potassium at $0$ K.')+
   pth('<p>$n=\\rho/M_{\\text{atom}}$ for one electron per atom; then $E_F$; then $B=\\tfrac23nE_F$ and $K=1/B$.</p>')+
   psol('<p>$M=39.1(1.66\\times10^{-27})=6.49\\times10^{-26}$ kg → $n=860/6.49\\times10^{-26}=1.325\\times10^{28}$ m⁻³.</p><p>$(3\\pi^2n)^{2/3}=5.358\\times10^{19}$ → $E_F\\approx3.27\\times10^{-19}$ J $\\approx2.04$ eV.</p><p>$B=\\tfrac23nE_F\\approx2.89\\times10^{9}$ N/m²; $K=1/B\\approx3.5\\times10^{-10}$ m²/N.</p>')+
   prac('<p>Rubidium: $\\rho=1532$ kg/m³, $M=85.47$ amu, one electron per atom. Find $n$, $E_F$ (eV), the degeneracy pressure $P$ and $B$.</p>'))}

 ${tp('Bands, gaps &amp; effective mass')}
 ${prob('6','Band gap from the Kronig–Penney model',
   pq('The potential of an electron in a one-dimensional lattice is of the Kronig–Penney type. Assuming $V_0ab\\ll\\hbar^2/m$, prove that the energy band gap at the zone boundary $k=\\pi/a$ is $$E_g=\\frac{2V_0b}{a}$$')+
   pth('<p>At the zone boundary $k=\\pi/a$, so $\\cos ka=-1$. Put $\\alpha a=\\pi\\pm\\delta$ with small $\\delta$ and expand.</p>')+
   psol('<p>Using $\\cos(\\pi\\pm\\delta)\\approx-(1-\\delta^2/2)$ and $\\sin(\\pi\\pm\\delta)\\approx\\mp\\delta$, the condition gives $\\delta\\approx\\pm2P/\\pi$, so the two roots are $\\alpha a=\\pi\\mp\\dfrac{2P}{\\pi}$.</p><p>Squaring to first order, $\\alpha_2^2-\\alpha_1^2=8P/a^2$, hence $$E_g=\\frac{\\hbar^2}{2m}\\cdot\\frac{8P}{a^2}=\\frac{4\\hbar^2P}{ma^2}$$ and substituting $P=\\dfrac{mV_0ba}{\\hbar^2}$ gives the standard first-order result $$E_g=\\frac{2V_0b}{a}$$</p>')+
   prac('<p>A 1-D crystal has $a=3.0$ Å, barriers of width $b=0.1$ Å and height $V_0=15$ eV. Find the gap at $k=\\pi/a$ in eV.</p>'))}

 ${prob('7','A hole at the top of the valence band',
   pq('The energy near the valence band edge of a crystal is given by $E=-Ak^2$ with $A=10^{-39}$ J·m². An electron of wave vector $\\mathbf k=10^{10}\\,\\hat k_x$ m⁻¹ is removed from the otherwise filled valence band. Determine the effective mass, momentum, velocity and energy of the resulting hole.')+
   pth('<p>$m^{*}=\\hbar^2/(d^2E/dk^2)$. For a hole: $m_h^{*}=-m_e^{*}$, $\\mathbf k_h=-\\mathbf k_e$, $\\mathbf v_h=\\mathbf v_e$, $E_h=-E_e$.</p>')+
   psol('<p>For $E=-Ak^2$: $\\dfrac{dE}{dk}=-2Ak$ and $\\dfrac{d^2E}{dk^2}=-2A$, so $$m_e^{*}=\\frac{\\hbar^2}{-2A}=-\\frac{(1.054\\times10^{-34})^2}{2\\times10^{-39}}\\approx-5.5\\times10^{-30}\\ \\text{kg}$$ and therefore $m_h^{*}=+5.5\\times10^{-30}$ kg.</p><p>$\\mathbf k_h=-10^{10}\\hat k_x$ m⁻¹ → $\\mathbf p_h=\\hbar\\mathbf k_h=-1.054\\times10^{-24}\\hat k_x$ kg·m/s.</p><p>$\\mathbf v_h=\\mathbf p_h/m_h^{*}\\approx-1.9\\times10^{5}\\hat k_x$ m/s — the same as $v_e=\\hbar^{-1}dE/dk$ ✓.</p><p>$E_e=-Ak^2=-10^{-19}$ J → $E_h=+10^{-19}$ J $\\approx0.62$ eV.</p>')+
   prac('<p>With $E(\\mathbf k)=-C(k_x^2+k_y^2+k_z^2)$, $C=5.0\\times10^{-39}$ J·m², an electron at $\\mathbf k_e=(2\\hat i+3\\hat j)\\times10^{9}$ m⁻¹ is removed. Find $m_e^{*}$, $m_h^{*}$, $\\mathbf p_h$, $\\mathbf v_h$ and the hole energy.</p>'))}
`},

/* ═══════════════════ CLOSE ═══════════════════ */
{id:'test-1',mod:'Model tests',modName:'Sit the paper',modClass:'m3',
 title:'Model paper 1 — the internal paper',short:'Model paper 1',est:'~75 min',
 body:`
 ${gist('The actual internal model paper. Work it closed-book against the clock first — 75 minutes — and only then open the answers. Each answer below is written the way it should appear on your script.')}

 ${paper('PROPERTIES OF SOLIDS — Model Question Paper (Internal)','75 minutes','40')}

 ${secband('A','Answer 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

 ${qa('3 m','1. Explain the concepts of (i) basis and (ii) primitive unit cell in a crystal structure.',
 `<p><strong>(i) Basis.</strong> A <em>lattice</em> is an infinite set of mathematical points, each of which has an identical environment — it contains no matter at all. The <strong>basis</strong> is the atom, ion or group of atoms that is attached, in the same orientation and the same way, to <em>every</em> one of those points. The crystal is then</p>
  $$\\text{lattice}+\\text{basis}=\\text{crystal structure}$$
  <p>The basis may be one atom (copper: FCC lattice, one Cu per point), two identical atoms (diamond: FCC lattice, C at $(0,0,0)$ and $(\\tfrac14,\\tfrac14,\\tfrac14)$), or two different ions (NaCl: FCC lattice, Na⁺ at $(0,0,0)$ and Cl⁻ at $(\\tfrac12,0,0)$). Note that diamond and NaCl share the <em>same lattice</em> and differ only in the basis — which is the whole point of keeping the two words apart.</p>
  <p><strong>(ii) Primitive unit cell.</strong> The smallest volume which, when repeated by all the lattice translations</p>
  $$\\mathbf T=n_1\\mathbf a+n_2\\mathbf b+n_3\\mathbf c$$
  <p>fills all space with no gaps and no overlaps. It contains <strong>exactly one lattice point</strong>: the eight corners of a primitive parallelepiped are each shared by eight cells, $8\\times\\tfrac18=1$. Its volume is $V=|\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)|$.</p>
  <p>Two riders worth a mark: the <em>shape</em> of a primitive cell is not unique (infinitely many choices exist) but its <em>volume</em> always is; and the <strong>conventional</strong> cell is often chosen larger than primitive — the FCC cube holds 4 lattice points — because it displays the cubic symmetry that a skewed primitive cell hides. The <strong>Wigner–Seitz</strong> cell is the primitive cell that also keeps the full symmetry.</p>`)}

 ${qa('3 m','2. State Bloch’s theorem for an electron moving in a periodic potential.',
 `<p><strong>Statement.</strong> For an electron moving in a potential with the periodicity of the lattice, $V(\\mathbf r)=V(\\mathbf r+\\mathbf T)$ for every lattice translation $\\mathbf T$, the stationary-state solutions of the Schrödinger equation can always be written as</p>
  ${must(`$$\\psi_{\\mathbf k}(\\mathbf r)=e^{i\\mathbf k\\cdot\\mathbf r}\\,u_{\\mathbf k}(\\mathbf r),\\qquad u_{\\mathbf k}(\\mathbf r+\\mathbf T)=u_{\\mathbf k}(\\mathbf r)$$
  <p>or, equivalently, $\\psi(\\mathbf r+\\mathbf T)=e^{i\\mathbf k\\cdot\\mathbf T}\\psi(\\mathbf r)$. In one dimension: $\\psi(x)=e^{ikx}u_k(x)$ with $u_k(x+a)=u_k(x)$.</p>`)}
  <p><strong>In words:</strong> the wavefunction is a plane wave (the free-electron part) multiplied by a function that repeats with the lattice. Moving one lattice step changes $\\psi$ only by the phase factor $e^{ika}$, so $|\\psi|^2$ has the periodicity of the crystal.</p>
  <p><strong>Why it matters</strong> (say this and the 3 marks are safe): the Bloch states are <em>extended, undamped travelling waves</em>. An electron in a <em>perfectly</em> periodic lattice is never scattered, so a perfect crystal has zero resistance. Resistance comes only from departures from periodicity — lattice vibrations, impurities, defects — which is exactly why the mean free path of a pure metal can stretch to $10^8$ atomic spacings at low temperature. Also, $\\mathbf k$ is defined only modulo a reciprocal lattice vector, which is why every state can be labelled inside the first Brillouin zone.</p>`)}

 ${qa('3 m','3. Calculate the interplanar spacing $d_{111}$ for a cubic crystal with lattice parameter $a=0.405$ nm.',
 `<p><strong>Formula.</strong> For a cubic crystal</p>
  $$d_{hkl}=\\frac{a}{\\sqrt{h^2+k^2+l^2}}$$
  <p><strong>Substitute</strong> $h=k=l=1$, so $h^2+k^2+l^2=3$:</p>
  $$d_{111}=\\frac{0.405\\ \\text{nm}}{\\sqrt3}=\\frac{0.405}{1.7321}=0.2338\\ \\text{nm}$$
  ${must(`$$d_{111}=0.234\\ \\text{nm}=2.34\\ \\text{Å}$$`)}
  <p><em>Sanity checks the examiner likes to see.</em> The answer must be smaller than $a$ — the $(111)$ planes are more closely spaced than the cube faces. And $a=0.405$ nm is aluminium, for which $d_{111}$ really is about $2.34$ Å, right in the X-ray range, which is why Al is a standard diffraction calibrant. If you were asked for the first-order Bragg angle with Cu K$\\alpha$ ($\\lambda=1.54$ Å): $\\sin\\theta=\\lambda/2d=1.54/4.68=0.329$, so $\\theta\\approx19.2^\\circ$.</p>`)}

 ${qa('3 m','4. Write down the expression for the Fermi energy of a 1-D free electron gas at $T=0$ K and explain the terms involved.',
 `<p><strong>Setting it up.</strong> Confine $N$ free electrons to a line of length $L$. Periodic boundary conditions quantise the wavevector as $k=2\\pi n/L$, so each state occupies a length $2\\pi/L$ of $k$-space, and each $k$ holds <em>two</em> electrons (spin up and down). At $T=0$ the electrons fill every state out to $\\pm k_F$:</p>
  $$N=2\\cdot\\frac{2k_F}{2\\pi/L}=\\frac{2k_FL}{\\pi}\\quad\\Longrightarrow\\quad k_F=\\frac{\\pi N}{2L}=\\frac{\\pi n}{2}$$
  <p>where $n=N/L$ is the number of electrons per unit length. Then</p>
  ${must(`$$E_F=\\frac{\\hbar^2k_F^2}{2m}=\\frac{\\hbar^2}{2m}\\left(\\frac{\\pi N}{2L}\\right)^{2}=\\frac{h^2N^2}{32\\,mL^2}$$`)}
  <p><strong>The terms.</strong> $E_F$ — the Fermi energy, the energy of the highest filled level at absolute zero. $\\hbar=h/2\\pi$ — the reduced Planck constant. $m$ — the electron mass (the free-electron mass here; in a real band it would be $m^{*}$). $k_F$ — the Fermi wavevector, the radius of the occupied region of $k$-space (in 1-D just the two end points $\\pm k_F$). $N$ — the number of free electrons, $L$ — the length of the specimen, and $n=N/L$ their linear density.</p>
  <p><em>Note the contrast:</em> in 1-D $E_F\\propto n^2$, in 3-D $E_F=\\dfrac{\\hbar^2}{2m}(3\\pi^2n)^{2/3}\\propto n^{2/3}$. Both depend only on the electron <em>density</em>, never on the size or shape of the sample.</p>`)}

 ${qa('3 m','5. Distinguish between a conductor, an insulator and a semiconductor on the basis of energy band theory.',
 `<p>The whole distinction is one question: <em>is there an empty level immediately above an occupied one?</em> Conduction means changing an electron’s $k$, and that is impossible unless there is somewhere for it to go.</p>
  <div style="overflow-x:auto"><table style="width:100%;border-collapse:collapse;font-size:.86rem">
  <tr style="text-align:left"><th></th><th>Conductor</th><th>Semiconductor</th><th>Insulator</th></tr>
  <tr><td>Band filling</td><td>top band <strong>partly filled</strong>, or two bands overlap</td><td>valence band full, conduction band empty</td><td>valence band full, conduction band empty</td></tr>
  <tr><td>Gap $E_g$</td><td>none to cross</td><td>small, $\\sim1$ eV (Si $1.1$, Ge $0.7$)</td><td>large, $\\gtrsim5$ eV (diamond $5.4$)</td></tr>
  <tr><td>$E_F$ lies</td><td>inside a band</td><td>near the middle of the gap</td><td>in the middle of the gap</td></tr>
  <tr><td>At $T=0$</td><td>conducts</td><td><strong>insulator</strong></td><td>insulator</td></tr>
  <tr><td>$\\sigma$ vs $T$</td><td>falls, $\\sigma\\propto1/T$</td><td>rises steeply, $n\\propto e^{-E_g/2k_BT}$</td><td>negligible at any ordinary $T$</td></tr>
  <tr><td>Typical $\\sigma$</td><td>$10^{7}$ S m⁻¹</td><td>$10^{-4}$–$10^{3}$ S m⁻¹</td><td>$10^{-12}$ S m⁻¹</td></tr>
  </table></div>
  <p><strong>The two sentences that earn the marks.</strong> A semiconductor differs from an insulator only in the <em>size</em> of the gap — it is not a different mechanism. And the temperature behaviour separates them cleanly: in a metal the number of carriers is fixed, so warming only adds lattice vibrations that scatter electrons more and $\\sigma$ falls; in a semiconductor warming <em>creates</em> carriers in pairs (an electron in the conduction band and a hole in the valence band), and that exponential gain easily beats the extra scattering.</p>`)}

 ${qa('3 m','6. Draw the [100], [110] and [111] directions and planes of a cubic unit cell.',
 `<p><strong>Directions</strong> $[uvw]$ — read the components of the arrow in units of $a,b,c$ and clear fractions:</p>
  <ul>
    <li>$[100]$ — along a <strong>cube edge</strong>, from the origin to $(a,0,0)$.</li>
    <li>$[110]$ — along a <strong>face diagonal</strong>, origin to $(a,a,0)$; length $\\sqrt2\\,a$.</li>
    <li>$[111]$ — along the <strong>body diagonal</strong>, origin to $(a,a,a)$; length $\\sqrt3\\,a$.</li>
  </ul>
  <p><strong>Planes</strong> $(hkl)$ — take reciprocals of the intercepts:</p>
  <ul>
    <li>$(100)$: intercepts $a,\\infty,\\infty$ → a whole <strong>cube face</strong>, perpendicular to $a$.</li>
    <li>$(110)$: intercepts $a,b,\\infty$ → a <strong>rectangle</strong> containing two opposite vertical edges, cutting the base along its diagonal.</li>
    <li>$(111)$: intercepts $a,b,c$ → the <strong>triangle</strong> that slices the corner off symmetrically.</li>
  </ul>
  <p><strong>Say this in the answer:</strong> in a cubic crystal the direction $[hkl]$ is <strong>perpendicular</strong> to the plane $(hkl)$, so each plane above is the one at right angles to the direction of the same name. Their spacings are $d_{100}=a$, $d_{110}=a/\\sqrt2$, $d_{111}=a/\\sqrt3$.</p>
  <p>Use the two rotatable figures in <em>Directions &amp; Miller indices</em> to check your sketch — step 5 of each shows exactly what the examiner wants to see on paper.</p>`)}

 ${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

 ${qa('6 m','6. Prove that the average kinetic energy of an electron at absolute zero is $\\tfrac35E_{F0}$.',
 `<p><strong>Step 1 — the density of states.</strong> For a 3-D free electron gas in a volume $V$,</p>
  $$D(E)=\\frac{V}{2\\pi^2}\\left(\\frac{2m}{\\hbar^2}\\right)^{3/2}E^{1/2}\\equiv A\\,E^{1/2}$$
  <p>At $T=0$ every state up to $E_F$ is occupied and every state above it is empty, so all integrals run from $0$ to $E_F$.</p>
  <p><strong>Step 2 — total number of electrons.</strong></p>
  $$N=\\int_0^{E_F}D(E)\\,dE=A\\int_0^{E_F}E^{1/2}dE=\\frac23A\\,E_F^{3/2}$$
  <p><strong>Step 3 — total kinetic energy.</strong></p>
  $$U=\\int_0^{E_F}E\\,D(E)\\,dE=A\\int_0^{E_F}E^{3/2}dE=\\frac25A\\,E_F^{5/2}$$
  <p><strong>Step 4 — divide.</strong></p>
  ${must(`$$\\bar E=\\frac UN=\\frac{\\tfrac25A E_F^{5/2}}{\\tfrac23A E_F^{3/2}}=\\frac{3}{5}E_F
  \\qquad\\text{and}\\qquad U=\\frac35NE_F$$`)}
  <p><strong>Why it is not $\\tfrac12E_F$</strong> — worth a line, because it is the physical content. The levels are not spread evenly: $D(E)\\propto\\sqrt E$ means there are more states, and therefore more electrons, near the top of the pile than near the bottom. The distribution is top-heavy, so the mean sits above the midpoint. (In 1-D, where $D\\propto E^{-1/2}$ is bottom-heavy, the same calculation gives $\\tfrac13E_F$.)</p>
  <p><strong>Consequence worth adding.</strong> This leftover energy at absolute zero cannot be removed — Pauli forbids stacking all the electrons in the ground state — and it pushes outwards as a <em>degeneracy pressure</em> $P=\\tfrac25\\dfrac{NE_F}{V}=\\dfrac{2U}{3V}$, with bulk modulus $B=\\tfrac53P$.</p>`)}

 ${qa('6 m','7. Discuss the Drude–Lorentz classical free electron theory of metals. Derive Ohm’s law from it and state its main limitations.',
 `<p><strong>The model.</strong> A metal is a rigid array of positive ion cores; the valence electrons are detached and wander freely. The assumptions are: (i) the electrons move freely, the ions are fixed; (ii) electrons do not interact with each other; (iii) the potential inside the metal is <strong>flat and constant</strong> (taken as zero), so an electron’s energy is purely kinetic; (iv) outside the metal the potential is higher, so the electrons stay in; (v) the electron gas obeys the kinetic theory of an ideal gas, with Lorentz adding <strong>Maxwell–Boltzmann</strong> statistics. Collisions with the ion cores randomise the velocity completely, with a mean free time $\\tau$ between them.</p>
  <p><strong>Derivation of Ohm’s law.</strong> With a field $\\mathcal E$ applied, the equation of motion including the collision damping is</p>
  $$m\\frac{d\\mathbf v}{dt}=-e\\boldsymbol{\\mathcal E}-\\frac{m\\mathbf v}{\\tau}$$
  <p>In the steady state $d\\mathbf v/dt=0$, giving the <strong>drift velocity</strong></p>
  $$\\mathbf v_d=-\\frac{e\\tau}{m}\\boldsymbol{\\mathcal E}$$
  <p>With $n$ electrons per unit volume the current density is $\\mathbf J=-ne\\mathbf v_d$, so</p>
  ${must(`$$\\mathbf J=\\frac{ne^2\\tau}{m}\\boldsymbol{\\mathcal E}=\\sigma\\boldsymbol{\\mathcal E},
  \\qquad \\sigma=\\frac{ne^2\\tau}{m},\\qquad \\rho=\\frac{m}{ne^2\\tau}$$`)}
  <p>which is <strong>Ohm’s law</strong>, with the conductivity expressed in microscopic quantities. Writing $\\mu=e\\tau/m$ for the mobility gives the equally standard $\\sigma=ne\\mu$.</p>
  <p><strong>Successes.</strong> Ohm’s law itself; the Wiedemann–Franz law (the same electrons carry charge and heat, so $K/\\sigma T$ is a universal constant); and the opacity and lustre of metals.</p>
  <p><strong>Limitations.</strong></p>
  <ol>
    <li><strong>Temperature dependence of resistivity.</strong> Since $\\tau=\\lambda/v_{th}$ and $v_{th}\\propto\\sqrt T$, the model predicts $\\rho\\propto\\sqrt T$; experiment gives $\\rho\\propto T$.</li>
    <li><strong>Electronic heat capacity.</strong> Equipartition gives every electron $\\tfrac32k_BT$, predicting $C_v=\\tfrac32R$ per mole. The measured value is about <strong>1%</strong> of this and is <em>linear</em> in $T$.</li>
    <li><strong>Magnetic susceptibility.</strong> Predicts a large Curie-type $1/T$ paramagnetism; the observed susceptibility is small and nearly temperature independent.</li>
    <li><strong>Mean free path.</strong> Cannot explain why, at low temperature, an electron travels past $10^8$–$10^9$ atoms without scattering.</li>
    <li>It also cannot explain why some metals show a <em>positive</em> Hall coefficient, nor why solids divide into conductors, semiconductors and insulators at all.</li>
  </ol>
  <p><strong>Root cause.</strong> The first three failures come from using Maxwell–Boltzmann statistics where the Pauli principle applies — Sommerfeld repairs them by switching to Fermi–Dirac statistics. The last two need the <em>periodic</em> potential that the model threw away, i.e. band theory.</p>`)}

 ${qa('6 m','8. Calculate the atomic packing factor (APF) of an FCC lattice.',
 `<p><strong>Step 1 — atoms per cell.</strong> An FCC conventional cube has atoms at the 8 corners (each shared by 8 cells) and at the 6 face centres (each shared by 2):</p>
  $$n=8\\times\\frac18+6\\times\\frac12=1+3=\\mathbf 4$$
  <p><strong>Step 2 — relate $r$ to $a$.</strong> In FCC the spheres touch along the <strong>face diagonal</strong>, which passes through a corner atom, a face-centre atom and the opposite corner atom — four radii in all:</p>
  $$\\sqrt2\\,a=4r\\quad\\Longrightarrow\\quad r=\\frac{\\sqrt2}{4}a=\\frac{a}{2\\sqrt2}$$
  <p><strong>Step 3 — put it together.</strong></p>
  $$\\text{APF}=\\frac{n\\cdot\\tfrac43\\pi r^3}{a^3}
  =\\frac{4\\cdot\\tfrac43\\pi\\left(\\tfrac{\\sqrt2}{4}a\\right)^{3}}{a^3}
  =\\frac{16\\pi}{3}\\cdot\\frac{2\\sqrt2}{64}
  =\\frac{\\pi\\sqrt2}{6}$$
  ${must(`$$\\text{APF(FCC)}=\\frac{\\pi}{3\\sqrt2}=\\frac{\\pi\\sqrt2}{6}=0.7405\\approx74\\%$$`)}
  <p><strong>Worth adding.</strong> $0.74$ is the <em>highest packing fraction possible</em> for identical spheres; HCP achieves exactly the same value, and both have coordination number 12 — they differ only in the stacking sequence ($ABCABC$ for FCC, $ABAB$ for HCP). For comparison, BCC gives $\\pi\\sqrt3/8=0.68$ with $CN=8$, and simple cubic only $\\pi/6=0.52$ with $CN=6$.</p>`)}

 ${qa('6 m','9. Describe the Kronig–Penney model for an electron in a 1-D periodic potential and discuss how it leads to allowed and forbidden energy bands.',
 `<p><strong>The model.</strong> Replace the real crystal potential by a row of rectangular wells and barriers of period $(a+b)$: $V=0$ inside a well of width $a$, and $V=V_0$ across a barrier of width $b$. It is the simplest periodic potential that can be solved exactly, and that is its entire purpose.</p>
  <p><strong>Solving it.</strong> Write the Schrödinger solutions in the two regions,</p>
  $$\\psi_1=Ae^{i\\alpha x}+Be^{-i\\alpha x},\\quad \\alpha=\\frac{\\sqrt{2mE}}{\\hbar};\\qquad
    \\psi_2=Ce^{\\beta x}+De^{-\\beta x},\\quad \\beta=\\frac{\\sqrt{2m(V_0-E)}}{\\hbar}$$
  <p>impose Bloch’s theorem, $\\psi(x+a+b)=e^{ik(a+b)}\\psi(x)$, and match $\\psi$ and $d\\psi/dx$ at the two boundaries. Four homogeneous equations in $A,B,C,D$ have a non-trivial solution only if the determinant vanishes, which gives</p>
  $$\\frac{\\beta^2-\\alpha^2}{2\\alpha\\beta}\\sinh(\\beta b)\\sin(\\alpha a)+\\cosh(\\beta b)\\cos(\\alpha a)=\\cos k(a+b)$$
  <p><strong>The tidy limit.</strong> Let $b\\to0$ and $V_0\\to\\infty$ with the product $V_0b$ held finite (delta-function barriers). Defining the dimensionless barrier strength $P=mV_0ba/\\hbar^2$ the condition collapses to</p>
  ${must(`$$P\\,\\frac{\\sin(\\alpha a)}{\\alpha a}+\\cos(\\alpha a)=\\cos(ka)$$`)}
  <p><strong>How bands appear.</strong> The right-hand side is a cosine, so it <em>cannot leave the range</em> $-1$ to $+1$. A real $k$ — that is, a genuine travelling Bloch state — therefore exists only for energies where</p>
  $$-1\\le P\\frac{\\sin(\\alpha a)}{\\alpha a}+\\cos(\\alpha a)\\le 1$$
  <p>Since $\\alpha=\\sqrt{2mE}/\\hbar$, plotting the left-hand side against $\\alpha a$ is plotting it against energy. Where the curve lies inside the corridor the energies are <strong>allowed</strong>; where it escapes, no real $k$ exists and those energies are <strong>forbidden</strong> — a band gap. The band edges are exactly where the left-hand side equals $\\pm1$, i.e. $ka=n\\pi$: the gaps open at the Brillouin zone boundaries, as Bragg reflection demands.</p>
  <p><strong>The features to quote.</strong></p>
  <ul>
    <li>As the energy rises the term $P\\sin(\\alpha a)/\\alpha a$ shrinks like $1/\\alpha a$, so the curve stays inside the corridor for longer: <strong>bands widen and gaps narrow at higher energy</strong>.</li>
    <li>$P\\to\\infty$ (very strong barriers, isolated atoms): the condition needs $\\sin(\\alpha a)=0$, giving $\\alpha a=n\\pi$ and $E_n=n^2h^2/8ma^2$ — the bands shrink to discrete atomic levels.</li>
    <li>$P\\to0$ (no barriers): $\\cos(\\alpha a)=\\cos(ka)$, so $\\alpha=k$ and $E=\\hbar^2k^2/2m$ — the free-electron parabola, with no gaps at all.</li>
  </ul>
  <p>The <em>Kronig–Penney</em> figure in the app lets you move $P$ between those two limits and watch the gaps appear and vanish.</p>`)}

 ${secband('C','Answer any 1 question. Each carries 10 marks.')}

 ${qa('10 m','10. (a) What is a reciprocal lattice? Derive the expressions for the reciprocal primitive vectors $\\mathbf a^{*},\\mathbf b^{*},\\mathbf c^{*}$ in terms of $\\mathbf a,\\mathbf b,\\mathbf c$. (6) &nbsp;(b) Show that the reciprocal lattice of a simple cubic lattice is also simple cubic. (4)',
 `<p><strong>(a) What it is.</strong> A family of parallel lattice planes $(hkl)$ is completely described by two things: the direction it faces, and the spacing between the planes. The reciprocal lattice represents each family by a single <em>vector</em> — pointing along the plane normal, with length inversely proportional to the spacing:</p>
  $$\\mathbf G_{hkl}=\\frac{2\\pi}{d_{hkl}}\\,\\hat{\\mathbf n}$$
  <p>Collect these vectors for every possible family and their tips form a lattice of their own — the <strong>reciprocal lattice</strong>. Formally it is the set of all vectors $\\mathbf G$ satisfying $e^{i\\mathbf G\\cdot\\mathbf T}=1$ for every direct lattice translation $\\mathbf T$. It lives in $k$-space, where lengths have units of (length)⁻¹.</p>
  <p><strong>Derivation.</strong> We want basis vectors $\\mathbf a^{*},\\mathbf b^{*},\\mathbf c^{*}$ obeying</p>
  $$\\mathbf a^{*}\\!\\cdot\\mathbf a=2\\pi,\\qquad \\mathbf a^{*}\\!\\cdot\\mathbf b=\\mathbf a^{*}\\!\\cdot\\mathbf c=0$$
  <p>The second pair says $\\mathbf a^{*}$ is perpendicular to both $\\mathbf b$ and $\\mathbf c$, so it must lie along their cross product:</p>
  $$\\mathbf a^{*}=\\lambda\\,(\\mathbf b\\times\\mathbf c)$$
  <p>Fix $\\lambda$ with the first condition:</p>
  $$\\mathbf a^{*}\\!\\cdot\\mathbf a=\\lambda\\,\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)=\\lambda V=2\\pi
  \\quad\\Longrightarrow\\quad \\lambda=\\frac{2\\pi}{V}$$
  <p>where $V=\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)$ is the volume of the direct primitive cell. Cycling the labels:</p>
  ${must(`$$\\mathbf a^{*}=2\\pi\\frac{\\mathbf b\\times\\mathbf c}{\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)},\\qquad
  \\mathbf b^{*}=2\\pi\\frac{\\mathbf c\\times\\mathbf a}{\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)},\\qquad
  \\mathbf c^{*}=2\\pi\\frac{\\mathbf a\\times\\mathbf b}{\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)}$$`)}
  <p>compactly $\\mathbf a_i^{*}\\cdot\\mathbf a_j=2\\pi\\delta_{ij}$. A general reciprocal vector is $\\mathbf G=h\\mathbf a^{*}+k\\mathbf b^{*}+l\\mathbf c^{*}$, and then</p>
  $$\\mathbf G\\cdot\\mathbf T=2\\pi(hn_1+kn_2+ln_3)=2\\pi\\times\\text{integer}\\;\\Rightarrow\\;e^{i\\mathbf G\\cdot\\mathbf T}=1$$
  <p>as required. The reciprocal cell has volume $(2\\pi)^3/V$.</p>
  <p><strong>(b) Simple cubic.</strong> Take $\\mathbf a=a\\hat{\\mathbf x}$, $\\mathbf b=a\\hat{\\mathbf y}$, $\\mathbf c=a\\hat{\\mathbf z}$, so $V=\\mathbf a\\cdot(\\mathbf b\\times\\mathbf c)=a^3$. Then</p>
  $$\\mathbf b\\times\\mathbf c=a^2(\\hat{\\mathbf y}\\times\\hat{\\mathbf z})=a^2\\hat{\\mathbf x}
  \\quad\\Longrightarrow\\quad
  \\mathbf a^{*}=2\\pi\\frac{a^2\\hat{\\mathbf x}}{a^3}=\\frac{2\\pi}{a}\\hat{\\mathbf x}$$
  <p>and by the same working $\\mathbf b^{*}=\\dfrac{2\\pi}{a}\\hat{\\mathbf y}$, $\\mathbf c^{*}=\\dfrac{2\\pi}{a}\\hat{\\mathbf z}$.</p>
  <p>These three vectors are <strong>mutually perpendicular and of equal length</strong> $2\\pi/a$ — which is precisely a simple cubic lattice, of cube side $2\\pi/a$. Hence <strong>SC → SC</strong>, with the reciprocal edge inversely proportional to the direct one. (For the record, the other two cubic cases invert into each other: <strong>BCC → FCC</strong> and <strong>FCC → BCC</strong>, which is why the first Brillouin zone of an FCC crystal is the Wigner–Seitz cell of a BCC lattice — a truncated octahedron.)</p>`)}

 ${qa('10 m','11. (a) Prove that in a 1-D crystal the average kinetic energy in the ground state is one third of the Fermi energy. (4) &nbsp;(b) Derive an expression for the density of states $D(E)$ for a free electron gas in one dimension. (6)',
 `<p><em>Do part (b) first in your rough work — part (a) needs its result — but write them in the order asked.</em></p>
  <p><strong>(b) Density of states in 1-D.</strong> Confine the electrons to a line of length $L$ and use periodic boundary conditions, $\\psi(x+L)=\\psi(x)$, so that</p>
  $$k=\\frac{2\\pi n}{L},\\qquad n=0,\\pm1,\\pm2,\\dots$$
  <p>Each allowed state therefore occupies a length $2\\pi/L$ of $k$-space, and each holds two electrons (spin $\\uparrow\\downarrow$). The number of electrons in all states with wavevector between $-k$ and $+k$ is</p>
  $$N(k)=2\\times\\frac{2k}{2\\pi/L}=\\frac{2kL}{\\pi}$$
  <p>Convert to energy with the free-electron relation $E=\\hbar^2k^2/2m$, i.e. $k=\\sqrt{2mE}/\\hbar$:</p>
  $$N(E)=\\frac{2L}{\\pi}\\frac{\\sqrt{2mE}}{\\hbar}=\\frac{2L}{\\pi\\hbar}\\sqrt{2m}\\;E^{1/2}$$
  <p>The density of states is the derivative of that count:</p>
  ${must(`$$D(E)=\\frac{dN}{dE}=\\frac{L}{\\pi\\hbar}\\sqrt{2m}\\;E^{-1/2}
  =\\frac{L}{\\pi}\\left(\\frac{2m}{\\hbar^2}\\right)^{1/2}\\frac{1}{\\sqrt E}\\;\\propto\\;E^{-1/2}$$`)}
  <p>Note the striking difference from three dimensions: in 1-D the density of states <em>diverges</em> at the bottom of the band and falls away as $E^{-1/2}$, whereas in 3-D it grows as $\\sqrt E$ and in 2-D it is constant. Writing $A=\\dfrac{L}{\\pi}\\sqrt{2m/\\hbar^2}$ for brevity, $D(E)=A\\,E^{-1/2}$.</p>
  <p><strong>(a) The average energy.</strong> At $T=0$ all states up to $E_F$ are occupied. Then</p>
  $$N=\\int_0^{E_F}D(E)\\,dE=A\\int_0^{E_F}E^{-1/2}dE=2A\\,E_F^{1/2}$$
  $$U=\\int_0^{E_F}E\\,D(E)\\,dE=A\\int_0^{E_F}E^{1/2}dE=\\frac23A\\,E_F^{3/2}$$
  <p>Dividing,</p>
  ${must(`$$\\bar E=\\frac UN=\\frac{\\tfrac23A E_F^{3/2}}{2A E_F^{1/2}}=\\frac{1}{3}E_F$$`)}
  <p><strong>The physical reason</strong> — say it explicitly, it is the examiner’s point. In one dimension $D(E)\\propto E^{-1/2}$ is <em>bottom-heavy</em>: most of the electrons sit near the bottom of the band, so the weighted mean is dragged <em>below</em> the midpoint, to $E_F/3$. In three dimensions $D\\propto\\sqrt E$ is top-heavy and the same integral gives $\\tfrac35E_F$; in two dimensions $D$ is constant and the answer is exactly $\\tfrac12E_F$. The <em>Density of states</em> figure in the app has a 1-D / 2-D / 3-D switch that shows all three shapes and the mean each one produces.</p>`)}
`},

{id:'test-2',mod:'Model tests',modName:'Sit the paper',modClass:'m3',
 title:'Model paper 2 — same shape, new questions',short:'Model paper 2',est:'~75 min',
 body:`
 ${gist('Same pattern, same weighting, questions the internal paper could just as easily have asked. Sit it cold — if you can do paper 1 and this one, the syllabus is covered.')}

 ${paper('PROPERTIES OF SOLIDS — Model Question Paper II','75 minutes','40')}

 ${secband('A','Answer 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

 ${qa('3 m','1. Define a Bravais lattice. How many Bravais lattices exist in three dimensions, and how are they distributed among the crystal systems?',
 `<p><strong>Definition.</strong> A Bravais lattice is an infinite array of discrete points generated by the translations $\\mathbf T=n_1\\mathbf a+n_2\\mathbf b+n_3\\mathbf c$ (with $n_i$ integers) such that the arrangement and orientation of the array looks <strong>exactly the same</strong> viewed from every point. That “identical environment from every point” is the whole definition — it is what excludes, for example, the honeycomb net, whose two sublattice sites have different surroundings.</p>
  <p><strong>The count: 14 in three dimensions</strong>, spread over the 7 crystal systems:</p>
  <div style="overflow-x:auto"><table style="width:100%;border-collapse:collapse;font-size:.86rem">
  <tr style="text-align:left"><th>System</th><th>Conditions</th><th>Lattices</th></tr>
  <tr><td>Cubic</td><td>$a=b=c$, all $90^\\circ$</td><td>$P,I,F$ (3)</td></tr>
  <tr><td>Tetragonal</td><td>$a=b\\ne c$, all $90^\\circ$</td><td>$P,I$ (2)</td></tr>
  <tr><td>Orthorhombic</td><td>$a\\ne b\\ne c$, all $90^\\circ$</td><td>$P,C,I,F$ (4)</td></tr>
  <tr><td>Rhombohedral</td><td>$a=b=c$, angles equal, not $90^\\circ$</td><td>$R$ (1)</td></tr>
  <tr><td>Hexagonal</td><td>$a=b\\ne c$, $90,90,120^\\circ$</td><td>$P$ (1)</td></tr>
  <tr><td>Monoclinic</td><td>two angles $90^\\circ$, one not</td><td>$P,C$ (2)</td></tr>
  <tr><td>Triclinic</td><td>no restrictions</td><td>$P$ (1)</td></tr>
  </table></div>
  <p style="text-align:center">$3+2+4+1+1+2+1=\\mathbf{14}$</p>
  <p><strong>Why not more?</strong> A centring counts as a new Bravais lattice only if the result cannot be re-described as one already on the list. Face-centred tetragonal, for instance, is <em>not</em> new: rotate the axes by $45^\\circ$ and shrink by $\\sqrt2$ and it is a body-centred tetragonal cell. That test is what trims the possibilities to 14. (In 2-D the same reasoning gives 4 systems and 5 lattices.)</p>`)}

 ${qa('3 m','2. State Bragg’s law and explain why X-rays, rather than visible light, are used to study crystals.',
 `<p><strong>The law.</strong> Treat the $(hkl)$ planes, spaced $d$ apart, as a stack of partial mirrors. A ray reflected from the second plane travels an extra distance $2d\\sin\\theta$ compared with one reflected from the first, and the reflections reinforce only when that extra path is a whole number of wavelengths:</p>
  ${must(`$$2d\\sin\\theta=n\\lambda$$
  <p>$\\theta$ is the <strong>glancing angle measured from the plane</strong>, not from the normal — the classic slip. $n$ is the order of the reflection.</p>`)}
  <p><strong>Why X-rays.</strong> Two reasons, and you should give both:</p>
  <ol>
    <li><strong>Resolution.</strong> To resolve structure of size $d$ you need a wavelength comparable with $d$. Atomic spacings are around $1$–$5$ Å, and X-rays have exactly that wavelength; visible light at $5000$ Å is thousands of times too long.</li>
    <li><strong>The law itself forbids it.</strong> Since $\\sin\\theta\\le1$, the condition $2d\\sin\\theta=n\\lambda$ can only be satisfied if $\\lambda\\le2d$. With $d\\approx2$ Å, any wavelength longer than about $4$ Å <em>cannot diffract at all</em>, whatever angle you choose. Visible light is simply excluded.</li>
  </ol>
  <p>X-rays also interact with the electron clouds rather than being absorbed, so they penetrate far enough to sample many planes and give sharp reflections.</p>`)}

 ${qa('3 m','3. A metal crystallises in the BCC structure with $a=0.287$ nm. Find the atomic radius and the packing fraction.',
 `<p><strong>Radius.</strong> In BCC the spheres touch along the <strong>body diagonal</strong>, which runs corner → body centre → opposite corner, i.e. four radii:</p>
  $$\\sqrt3\\,a=4r\\quad\\Longrightarrow\\quad r=\\frac{\\sqrt3}{4}a=\\frac{1.7321\\times0.287}{4}=0.1243\\ \\text{nm}=1.24\\ \\text{Å}$$
  <p><strong>Packing fraction.</strong> BCC has $n=8\\times\\tfrac18+1=2$ atoms per cell, so</p>
  $$\\text{APF}=\\frac{2\\cdot\\tfrac43\\pi r^3}{a^3}
  =\\frac{8\\pi}{3}\\left(\\frac{\\sqrt3}{4}\\right)^{3}=\\frac{8\\pi}{3}\\cdot\\frac{3\\sqrt3}{64}=\\frac{\\pi\\sqrt3}{8}=0.68$$
  ${must(`$$r=\\frac{\\sqrt3\\,a}{4},\\qquad \\text{APF(BCC)}=\\frac{\\pi\\sqrt3}{8}=0.68=68\\%$$`)}
  <p><em>Check:</em> $a=0.287$ nm is $\\alpha$-iron, whose accepted atomic radius is $1.24$ Å — so the arithmetic is right. Note the packing fraction is a pure number: it never depends on $a$, only on the geometry.</p>`)}

 ${qa('3 m','4. What is the Fermi factor? Sketch it at $T=0$ and at $T\\gt0$ and describe its behaviour.',
 `<p><strong>Definition.</strong> The Fermi factor (Fermi–Dirac distribution function) gives the <em>probability that a state of energy $E$ is occupied</em> at temperature $T$:</p>
  ${must(`$$f(E)=\\frac{1}{e^{(E-E_F)/k_BT}+1}$$`)}
  <p><strong>At $T=0$:</strong> a perfect step. For $E\\lt E_F$ the exponent is $-\\infty$, so $f=1$ (every state full); for $E\\gt E_F$ it is $+\\infty$, so $f=0$ (every state empty). This is the Pauli principle in action — electrons stack up to $E_F$ because they cannot share levels.</p>
  <p><strong>At $T\\gt0$:</strong> the step softens, but only over a width of roughly $k_BT$ on either side of $E_F$; deeper states stay completely full and higher states stay essentially empty. At $E=E_F$ exactly, $f=\\tfrac12$ at every temperature — a standard one-mark question.</p>
  <p><strong>Two consequences to mention.</strong> (i) Only the sliver of electrons within $\\sim k_BT$ of $E_F$ can absorb energy, which is why the electronic heat capacity is about 1% of the classical prediction and grows linearly with $T$. (ii) When $E-E_F\\gg k_BT$ the $+1$ becomes negligible and $f\\to e^{-(E-E_F)/k_BT}$ — the Fermi–Dirac distribution reduces to the Maxwell–Boltzmann one, which is why classical statistics works for the dilute carriers in a semiconductor but not for the dense electron gas in a metal.</p>`)}

 ${qa('3 m','5. What is meant by the effective mass of an electron? Why can it be negative?',
 `<p><strong>Definition.</strong> An electron in a crystal responds to an applied force as though it had a mass different from the free-electron mass. Starting from $v=\\hbar^{-1}dE/dk$ and $\\hbar\\,dk/dt=F$, differentiating the velocity gives $a=\\hbar^{-2}(d^2E/dk^2)F$, so comparing with $a=F/m^{*}$,</p>
  ${must(`$$m^{*}=\\frac{\\hbar^{2}}{d^{2}E/dk^{2}}$$`)}
  <p>The effective mass is fixed entirely by the <strong>curvature of the band</strong>: a sharply curved band (bottom of a band) gives a small $m^{*}$ and a very responsive electron; a flat band gives a huge $m^{*}$ and a sluggish one.</p>
  <p><strong>Why it can be negative.</strong> Near the <em>top</em> of a band the $E(k)$ curve bends the other way, so $d^2E/dk^2\\lt0$ and $m^{*}\\lt0$: push the electron with a field and it accelerates backwards.</p>
  <p>That is not a paradox, it is bookkeeping. The electron actually feels <em>two</em> forces — the applied field and the periodic lattice — and $m^{*}$ is a device for hiding the second one inside a single number. Near the band top the electron is close to the Bragg condition, so the lattice is handing momentum back to the crystal faster than the field supplies it, and the net acceleration opposes the applied force. Total momentum (electron plus lattice) is conserved throughout. A vacancy in that region is exactly what we call a <strong>hole</strong>: minus a negative charge with a negative mass behaves as a positive charge with a positive mass.</p>`)}

 ${qa('3 m','6. Sketch the first Brillouin zone of a two-dimensional square lattice of side $a$ and state its area.',
 `<p><strong>Construction.</strong> Work in reciprocal space, where the square lattice of side $a$ maps to a square lattice of side $2\\pi/a$. From the origin, draw the vectors $\\mathbf G$ to the four nearest reciprocal points, $(\\pm2\\pi/a,0)$ and $(0,\\pm2\\pi/a)$, and bisect each one with a perpendicular line. The region around the origin that no bisector cuts off is the first Brillouin zone.</p>
  <p><strong>Result.</strong> A <strong>square</strong>, centred on the origin, with sides running from $-\\pi/a$ to $+\\pi/a$ in both directions — i.e. the Wigner–Seitz cell of the reciprocal lattice.</p>
  ${must(`$$\\text{Area}=\\left(\\frac{2\\pi}{a}\\right)^{2}=\\frac{4\\pi^2}{a^2}$$`)}
  <p><strong>Add these lines for full marks.</strong> The zone boundary is where $2\\mathbf k\\cdot\\mathbf G=G^2$, i.e. the Bragg condition, so an electron whose $k$ reaches the boundary is Bragg-reflected and a gap opens there. The second zone consists of the four triangular pieces between the first zone and the bisectors of the next shell (the diagonal vectors $(\\pm2\\pi/a,\\pm2\\pi/a)$); it has <em>exactly the same area</em> as the first. Every zone does — which is why every band holds the same number of states, namely $2N$.</p>`)}

 ${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

 ${qa('6 m','7. Derive the expression $d_{hkl}=a/\\sqrt{h^2+k^2+l^2}$ for the interplanar spacing of a cubic crystal.',
 `<p><strong>Set up.</strong> Consider the plane of the family $(hkl)$ that is <em>nearest the origin</em>. By the definition of Miller indices it cuts the axes at</p>
  $$\\frac ah,\\qquad \\frac bk,\\qquad \\frac cl$$
  <p>Drop a perpendicular $ON$ from the origin onto that plane. Its length is the interplanar spacing $d$ itself — because the next plane of the family passes through the origin, so $ON$ is exactly the gap between neighbours. Let $\\alpha,\\beta,\\gamma$ be the angles this perpendicular makes with the $a$, $b$ and $c$ axes.</p>
  <p><strong>Step 1 — the direction cosines.</strong> The perpendicular, the axis, and the intercept form a right-angled triangle in which $ON$ is the side adjacent to the angle and the intercept is the hypotenuse:</p>
  $$\\cos\\alpha=\\frac{d}{a/h}=\\frac{dh}{a},\\qquad
    \\cos\\beta =\\frac{d}{b/k}=\\frac{dk}{b},\\qquad
    \\cos\\gamma=\\frac{d}{c/l}=\\frac{dl}{c}$$
  <p><strong>Step 2 — the direction-cosine identity.</strong> For any line referred to three mutually perpendicular axes (Pythagoras in three dimensions),</p>
  $$\\cos^2\\alpha+\\cos^2\\beta+\\cos^2\\gamma=1$$
  <p><strong>Step 3 — substitute and solve.</strong></p>
  $$\\frac{d^2h^2}{a^2}+\\frac{d^2k^2}{b^2}+\\frac{d^2l^2}{c^2}=1
  \\quad\\Longrightarrow\\quad
  d=\\left[\\frac{h^2}{a^2}+\\frac{k^2}{b^2}+\\frac{l^2}{c^2}\\right]^{-1/2}$$
  <p>which is the general orthorhombic result. Putting $a=b=c$ for a cube:</p>
  ${must(`$$d_{hkl}=\\frac{a}{\\sqrt{h^2+k^2+l^2}}$$`)}
  <p><strong>Two consequences worth a sentence.</strong> Bigger indices always mean more closely spaced planes, so $d_{100}\\gt d_{110}\\gt d_{111}$ in that order ($a$, $0.707a$, $0.577a$). And $d_{nh\\,nk\\,nl}=d_{hkl}/n$, which is why an $n$-th order Bragg reflection from $(hkl)$ can always be relabelled a first-order reflection from $(nh\\,nk\\,nl)$ — hence the $200$ and $220$ entries in diffraction tables.</p>`)}

 ${qa('6 m','8. Derive the Fermi energy of a three-dimensional free electron gas at $T=0$ K and show that it depends only on the electron density.',
 `<p><strong>Step 1 — allowed states.</strong> Take a cube of side $L$ (volume $V=L^3$) with periodic boundary conditions. Then $k_x,k_y,k_z$ are each quantised in units of $2\\pi/L$, so <em>one</em> allowed $\\mathbf k$ occupies a volume $(2\\pi/L)^3$ of $k$-space, and each state holds two electrons.</p>
  <p><strong>Step 2 — fill the sphere.</strong> At $T=0$ the electrons occupy every state inside a sphere of radius $k_F$ (the Fermi sphere), because energy increases with $|\\mathbf k|$. Counting:</p>
  $$N=2\\times\\frac{\\tfrac43\\pi k_F^3}{(2\\pi/L)^3}
   =2\\times\\frac{\\tfrac43\\pi k_F^3\\,V}{8\\pi^3}
   =\\frac{V k_F^{3}}{3\\pi^{2}}$$
  <p><strong>Step 3 — invert for $k_F$.</strong> With $n=N/V$ the electron density,</p>
  ${must(`$$k_F=\\left(3\\pi^{2}n\\right)^{1/3}$$`)}
  <p><strong>Step 4 — the Fermi energy.</strong> Substituting into $E=\\hbar^2k^2/2m$:</p>
  ${must(`$$E_F=\\frac{\\hbar^{2}k_F^{2}}{2m}=\\frac{\\hbar^{2}}{2m}\\left(3\\pi^{2}n\\right)^{2/3}\\;\\propto\\;n^{2/3}$$`)}
  <p><strong>The point of the question.</strong> $E_F$ contains no reference to $L$, $V$ or the shape of the specimen — only to $n=N/V$. Double the size of the crystal and you double both $N$ and $V$, leaving $E_F$ untouched. A typical metal has $n\\sim10^{28}$–$10^{29}$ m⁻³, giving $E_F\\approx2$–$7$ eV, $v_F=\\hbar k_F/m\\approx10^{6}$ m s⁻¹ and $T_F=E_F/k_B\\approx10^{4}$–$10^{5}$ K. That last number is the important one: room temperature is a tiny fraction of $T_F$, so the electron gas is <strong>highly degenerate</strong> — it behaves as though it were nearly at absolute zero even in a hot wire.</p>`)}

 ${qa('6 m','9. Explain the origin of energy bands in a solid using Bragg reflection and standing waves at the zone boundary.',
 `<p><strong>Start from what is wrong with the free-electron model.</strong> It assumes a flat potential. A real electron moves through a <em>periodic</em> row of positive ion cores, $V(x)=V(x+a)$, and a wave in a periodic medium can be Bragg-reflected by it — exactly as an X-ray is.</p>
  <p><strong>Where the reflection happens.</strong> Applying $2d\\sin\\theta=n\\lambda$ to a 1-D lattice at normal incidence ($d=a$, $\\theta=90^\\circ$) gives $2a=n\\lambda$, i.e. $\\lambda=2a/n$; in terms of wavevector,</p>
  ${must(`$$k=\\pm\\frac{n\\pi}{a}\\qquad\\text{— the Brillouin zone boundaries.}$$`)}
  <p>For $k$ well inside the zone, the wavelets reflected from successive cores are out of step and cancel, so the electron travels through freely. At $k=\\pi/a$ they are exactly in step and the reflection is total.</p>
  <p><strong>The two standing waves.</strong> At the boundary the forward wave $e^{i\\pi x/a}$ and the backward wave $e^{-i\\pi x/a}$ have equal amplitude, so they combine into <em>standing</em> waves — which carry no current. There are two independent ways to combine them:</p>
  $$\\psi_+\\propto\\cos\\frac{\\pi x}{a},\\qquad \\psi_-\\propto\\sin\\frac{\\pi x}{a}$$
  <p>and they put the charge in different places. $|\\psi_+|^2$ piles the electron density <strong>on top of</strong> the positive ion cores — closer to the attraction, so <em>lower</em> potential energy. $|\\psi_-|^2$ piles it <strong>between</strong> the cores — further from the attraction, so <em>higher</em> energy.</p>
  <p><strong>The gap.</strong> Two allowed energies therefore exist at the same $k=\\pi/a$, and no state exists between them. That missing range of energies is the <strong>forbidden gap</strong>,</p>
  $$E_g=E_--E_+$$
  <p>whose size is set by how strongly the lattice potential distinguishes the two arrangements (in first-order perturbation theory $E_g=2|V_1|$, twice the relevant Fourier component of the potential). Since this happens at every zone boundary $k=\\pm n\\pi/a$, the free-electron parabola is broken into <strong>allowed bands separated by forbidden gaps</strong> — the band structure of a solid. The <em>Standing waves and the gap</em> figure in the app builds this picture step by step.</p>`)}

 ${qa('6 m','10. State Laue’s equations for X-ray diffraction, outline their derivation, and show that they are equivalent to Bragg’s law.',
 `<p><strong>The set-up.</strong> Laue treated the crystal atom by atom rather than plane by plane. Take two scattering atoms separated by a lattice vector $\\mathbf r$. Let $\\hat{\\mathbf n}_1$ be the direction of the incident beam and $\\hat{\\mathbf n}_2$ that of the scattered beam.</p>
  <p><strong>The path difference.</strong> Before scattering, the wave that reaches the second atom travels an extra $\\mathbf r\\cdot\\hat{\\mathbf n}_1$; after scattering, the wave leaving it travels $\\mathbf r\\cdot\\hat{\\mathbf n}_2$ less. Everything else is common to the two paths, so the net extra path is</p>
  $$\\Delta=\\mathbf r\\cdot\\hat{\\mathbf n}_1-\\mathbf r\\cdot\\hat{\\mathbf n}_2=\\mathbf r\\cdot(\\hat{\\mathbf n}_1-\\hat{\\mathbf n}_2)=\\mathbf r\\cdot\\mathbf N$$
  <p><strong>The conditions.</strong> Constructive interference requires $\\Delta$ to be a whole number of wavelengths, and this must hold for a lattice step along <em>each</em> of the three crystal axes at once. With $\\mathbf r=\\mathbf a,\\mathbf b,\\mathbf c$ in turn:</p>
  ${must(`$$\\mathbf a\\cdot\\mathbf N=nh\\lambda,\\qquad
  \\mathbf b\\cdot\\mathbf N=nk\\lambda,\\qquad
  \\mathbf c\\cdot\\mathbf N=nl\\lambda$$`)}
  <p>These are <strong>Laue’s three equations</strong>; $h,k,l$ are integers, and a diffracted beam appears only in the rare directions where all three are satisfied simultaneously — which is why a fixed crystal in a monochromatic beam usually shows nothing at all.</p>
  <p><strong>Equivalence with Bragg.</strong> Since $|\\hat{\\mathbf n}_1|=|\\hat{\\mathbf n}_2|=1$ and the two make an angle $2\\theta$ with each other, the vector $\\mathbf N=\\hat{\\mathbf n}_1-\\hat{\\mathbf n}_2$ bisects them perpendicularly and has magnitude</p>
  $$|\\mathbf N|=2\\sin\\theta$$
  <p>while its direction is the normal to the reflecting planes. Writing the three equations with direction cosines and combining them reproduces</p>
  $$d_{hkl}=\\frac{n\\lambda}{2\\sin\\theta}\\qquad\\Longleftrightarrow\\qquad 2d\\sin\\theta=n\\lambda$$
  <p>so <strong>Bragg and Laue are the same physics in different clothing</strong>: Laue’s three scalar conditions on the atoms are equivalent to Bragg’s single condition on the planes. In modern language both are the statement $\\mathbf k'-\\mathbf k=\\mathbf G$ — the change in wavevector must equal a reciprocal lattice vector.</p>`)}

 ${secband('C','Answer any 1 question. Each carries 10 marks.')}

 ${qa('10 m','11. (a) Derive an expression for the electronic heat capacity of a metal and explain why it is so much smaller than the classical value. (6) &nbsp;(b) For a metal with $T_F=5\\times10^{4}$ K, estimate the molar electronic heat capacity at $300$ K and compare it with $3R$. (4)',
 `<p><strong>(a) The derivation.</strong> Classically every one of the $N$ electrons would take $\\tfrac32k_BT$ of thermal energy, giving $C_v=\\tfrac32Nk_B=\\tfrac32R$ per mole — about $12.5$ J mol⁻¹K⁻¹, comparable with the lattice contribution. Experiment finds roughly 1% of that. The Pauli principle explains the discrepancy.</p>
  <p><strong>Step 1 — only a sliver can absorb heat.</strong> An electron can take up energy only if there is an <em>empty</em> state a little above it. At temperature $T$ the Fermi function is sharp except within about $k_BT$ of $E_F$, so only the electrons in that window have anywhere to go. Their number is</p>
  $$N_{\\text{eff}}\\approx N\\frac{k_BT}{E_F}=N\\frac{T}{T_F}$$
  <p><strong>Step 2 — each takes about $k_BT$.</strong> So the thermal energy stored is</p>
  $$U\\approx N_{\\text{eff}}\\,k_BT\\approx N k_B\\frac{T^{2}}{T_F}$$
  <p><strong>Step 3 — differentiate.</strong></p>
  ${must(`$$C_v=\\frac{dU}{dT}\\approx 2Nk_B\\frac{T}{T_F}\\;\\sim\\;\\frac32 R\\,\\frac{T}{T_F}
  \\qquad\\text{(exact Sommerfeld result: }C_v=\\tfrac{\\pi^2}{2}R\\tfrac{T}{T_F}\\text{)}$$`)}
  <p><strong>Why it is small — the sentence that carries the marks.</strong> The suppression factor is exactly $T/T_F$. Because $T_F\\sim10^4$–$10^5$ K, at ordinary temperatures $T/T_F\\sim10^{-2}$, so the electronic heat capacity is around 1% of the classical value. The same factor also makes $C_v$ <strong>linear in $T$</strong> rather than constant — and that is how it is measured: at low temperature the total heat capacity is $C=\\gamma T+AT^{3}$, and plotting $C/T$ against $T^{2}$ gives a straight line whose intercept $\\gamma$ is the electronic term and whose slope is the lattice (Debye) term.</p>
  <p><strong>(b) The numbers.</strong> With $T=300$ K and $T_F=5\\times10^{4}$ K,</p>
  $$\\frac{T}{T_F}=\\frac{300}{5\\times10^{4}}=6\\times10^{-3}$$
  <p>Using the estimate $C_v\\approx\\tfrac32R\\,(T/T_F)$:</p>
  $$C_v\\approx1.5\\times8.314\\times6\\times10^{-3}=0.075\\ \\text{J mol}^{-1}\\text{K}^{-1}$$
  <p>(the exact coefficient $\\pi^2/2$ instead of $3/2$ would give $0.246$ J mol⁻¹K⁻¹ — the same order). The Dulong–Petit lattice value is</p>
  $$3R=3\\times8.314=24.9\\ \\text{J mol}^{-1}\\text{K}^{-1}$$
  ${must(`$$\\frac{C_v(\\text{electronic})}{3R}\\approx\\frac{0.075}{24.9}\\approx3\\times10^{-3}$$`)}
  <p>so the electronic contribution is a few tenths of a percent of the lattice contribution at room temperature — completely invisible. It only becomes measurable below a few kelvin, where the lattice term has died away as $T^{3}$ while the electronic term has died only as $T$.</p>`)}

 ${qa('10 m','12. (a) Explain the Wigner–Seitz cell and the construction of the first Brillouin zone. (6) &nbsp;(b) Show that the reciprocal lattice of an FCC lattice is BCC, and state the shape of the first Brillouin zone in each cubic case. (4)',
 `<p><strong>(a) The Wigner–Seitz cell.</strong> Stand on any lattice point. Draw a line from it to each of its neighbours, and cut every line in half with a plane perpendicular to it. The smallest region enclosed around your point — the set of all points nearer to it than to any other lattice point — is the Wigner–Seitz cell.</p>
  <p>Its properties: it is <strong>primitive</strong> (exactly one lattice point, and copies of it tile space with no gaps), and unlike an arbitrary primitive parallelepiped it carries the <strong>full point symmetry</strong> of the lattice. That combination is why it is preferred.</p>
  <p><strong>The first Brillouin zone</strong> is the identical construction carried out in <em>reciprocal</em> space: take the origin of the reciprocal lattice, join it to each neighbouring point $\\mathbf G$, and bisect every one of those vectors with a perpendicular plane. The region enclosed is the first zone.</p>
  <p>Why those planes matter physically: diffraction requires $\\mathbf k'=\\mathbf k+\\mathbf G$ with $|\\mathbf k'|=|\\mathbf k|$; squaring gives</p>
  $$2\\mathbf k\\cdot\\mathbf G+G^{2}=0\\qquad\\Longleftrightarrow\\qquad
  \\mathbf k\\cdot\\frac{\\mathbf G}{2}=\\left|\\frac{\\mathbf G}{2}\\right|^{2}$$
  <p>which is precisely the statement that the tip of $\\mathbf k$ lies on the perpendicular bisector plane of $\\mathbf G$. So the zone boundary is the locus of Bragg reflection: electrons inside the zone propagate, electrons on the boundary are reflected into standing waves, and a gap opens there. Each zone has the same volume, $(2\\pi)^3/V_{\\text{cell}}$, and therefore holds exactly $2N$ electrons — one band per zone.</p>
  <p><strong>(b) FCC → BCC.</strong> Take the FCC primitive vectors</p>
  $$\\mathbf a_1=\\frac a2(\\hat{\\mathbf y}+\\hat{\\mathbf z}),\\quad
    \\mathbf a_2=\\frac a2(\\hat{\\mathbf z}+\\hat{\\mathbf x}),\\quad
    \\mathbf a_3=\\frac a2(\\hat{\\mathbf x}+\\hat{\\mathbf y})$$
  <p>whose cell volume is $V=\\mathbf a_1\\cdot(\\mathbf a_2\\times\\mathbf a_3)=a^{3}/4$. Then</p>
  $$\\mathbf a_2\\times\\mathbf a_3=\\frac{a^{2}}{4}(\\hat{\\mathbf z}+\\hat{\\mathbf x})\\times(\\hat{\\mathbf x}+\\hat{\\mathbf y})
  =\\frac{a^{2}}{4}\\left(\\hat{\\mathbf z}\\times\\hat{\\mathbf x}+\\hat{\\mathbf z}\\times\\hat{\\mathbf y}+\\hat{\\mathbf x}\\times\\hat{\\mathbf y}\\right)
  =\\frac{a^{2}}{4}\\left(\\hat{\\mathbf y}-\\hat{\\mathbf x}+\\hat{\\mathbf z}\\right)$$
  <p>so that</p>
  $$\\mathbf b_1=2\\pi\\frac{\\mathbf a_2\\times\\mathbf a_3}{V}
  =\\frac{2\\pi\\,(a^{2}/4)(-\\hat{\\mathbf x}+\\hat{\\mathbf y}+\\hat{\\mathbf z})}{a^{3}/4}
  =\\frac{2\\pi}{a}\\left(-\\hat{\\mathbf x}+\\hat{\\mathbf y}+\\hat{\\mathbf z}\\right)$$
  <p>and cyclically $\\mathbf b_2=\\dfrac{2\\pi}{a}(\\hat{\\mathbf x}-\\hat{\\mathbf y}+\\hat{\\mathbf z})$, $\\mathbf b_3=\\dfrac{2\\pi}{a}(\\hat{\\mathbf x}+\\hat{\\mathbf y}-\\hat{\\mathbf z})$.</p>
  <p>These are exactly the primitive vectors of a <strong>body-centred cubic</strong> lattice of conventional side $4\\pi/a$. Hence <strong>FCC → BCC</strong>, and by the same working <strong>BCC → FCC</strong>, while <strong>SC → SC</strong>.</p>
  ${must(`<p>First Brillouin zones: <strong>SC</strong> → a cube; <strong>FCC crystal</strong> (BCC reciprocal) → a <strong>truncated octahedron</strong>, 8 hexagonal + 6 square faces; <strong>BCC crystal</strong> (FCC reciprocal) → a <strong>rhombic dodecahedron</strong>, 12 identical rhombic faces.</p>`)}
  <p>The <em>Brillouin zones</em> figure in the app builds both of those solids from the bisector planes and lets you rotate and count the faces.</p>`)}
`},

{id:'test-3',mod:'Model tests',modName:'Sit the paper',modClass:'m3',
 title:'Model paper 3 — the harder variant',short:'Model paper 3',est:'~75 min',
 body:`
 ${gist('The same pattern again, but leaning on the parts students skip: symmetry, the density of states, the two Kronig–Penney limits and band capacity. If you can do this one, nothing in the paper can surprise you.')}

 ${paper('PROPERTIES OF SOLIDS — Model Question Paper III','75 minutes','40')}

 ${secband('A','Answer 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

 ${qa('3 m','1. What are Miller indices? A plane makes intercepts $2a$, $3b$ and $4c$ on the crystal axes — find its Miller indices.',
 `<p><strong>Definition.</strong> Miller indices $(hkl)$ label a family of parallel lattice planes by the <em>reciprocals</em> of the intercepts the plane makes on the crystallographic axes, cleared to the smallest whole numbers. The recipe, every time:</p>
  <ol>
    <li>Find where the plane cuts the axes, in units of $a,b,c$ — call them $p,q,r$.</li>
    <li>Take reciprocals $1/p,\\;1/q,\\;1/r$.</li>
    <li>Multiply through to clear fractions, giving the smallest integers.</li>
    <li>Write them in round brackets with no commas: $(hkl)$.</li>
  </ol>
  <p>Reciprocals are used so that a plane <em>parallel</em> to an axis — intercept $\\infty$, which is useless arithmetically — gives the perfectly good index $0$.</p>
  <p><strong>The worked example.</strong> Intercepts $2a,3b,4c$, so $p,q,r=2,3,4$:</p>
  $$\\frac12,\\ \\frac13,\\ \\frac14
  \\quad\\xrightarrow{\\ \\times\\,\\text{LCM}=12\\ }\\quad 6,\\ 4,\\ 3$$
  ${must(`$$(hkl)=(643)$$`)}
  <p><em>Checks:</em> the indices are coprime as a set (no common factor), the largest index belongs to the axis with the <em>smallest</em> intercept, and a negative intercept would be written with a bar, e.g. $(\\bar643)$.</p>`)}

 ${qa('3 m','2. Define coordination number and packing fraction. Give both for SC, BCC and FCC.',
 `<p><strong>Coordination number (CN):</strong> the number of <em>nearest</em> neighbours touching a given atom — a count, with no reference to the cell.</p>
  <p><strong>Packing fraction (APF):</strong> the fraction of the cell volume actually filled by atoms, treating them as hard touching spheres:</p>
  $$\\text{APF}=\\frac{n\\times\\tfrac43\\pi r^{3}}{a^{3}}$$
  <p>with $n$ the number of atoms per conventional cell.</p>
  <div style="overflow-x:auto"><table style="width:100%;border-collapse:collapse;font-size:.86rem">
  <tr style="text-align:left"><th>Structure</th><th>$n$</th><th>Touching along</th><th>$a$–$r$ relation</th><th>CN</th><th>APF</th></tr>
  <tr><td>Simple cubic</td><td>1</td><td>cube edge</td><td>$a=2r$</td><td>6</td><td>$\\pi/6=0.52$</td></tr>
  <tr><td>BCC</td><td>2</td><td>body diagonal</td><td>$\\sqrt3\\,a=4r$</td><td>8</td><td>$\\pi\\sqrt3/8=0.68$</td></tr>
  <tr><td>FCC</td><td>4</td><td>face diagonal</td><td>$\\sqrt2\\,a=4r$</td><td>12</td><td>$\\pi/3\\sqrt2=0.74$</td></tr>
  <tr><td>HCP</td><td>6</td><td>basal edge</td><td>$a=2r$</td><td>12</td><td>$0.74$</td></tr>
  </table></div>
  <p><strong>The pattern to state:</strong> higher coordination means tighter packing. FCC and HCP both reach $0.74$, which is the densest possible packing of identical spheres, and both have $CN=12$; they differ only in the stacking order of the close-packed layers ($ABCABC$ against $ABAB$).</p>`)}

 ${qa('3 m','3. State the Wiedemann–Franz law and give the value of the Lorenz number. What does the law tell you physically?',
 `<p><strong>The law.</strong> For a metal, the ratio of the thermal conductivity $K$ to the electrical conductivity $\\sigma$ is proportional to the absolute temperature, with a constant that is the same for <em>all</em> metals:</p>
  ${must(`$$\\frac{K}{\\sigma T}=L=\\frac{\\pi^{2}}{3}\\left(\\frac{k_B}{e}\\right)^{2}=2.45\\times10^{-8}\\ \\text{W}\\,\\Omega\\,\\text{K}^{-2}$$`)}
  <p>$L$ is the <strong>Lorenz number</strong>. (The classical Drude calculation gives $L=\\tfrac32(k_B/e)^2=1.11\\times10^{-8}$, about half the measured value; the correct factor $\\pi^2/3$ comes out only when Fermi–Dirac statistics are used — which is one of the successes of Sommerfeld’s theory.)</p>
  <p><strong>What it means physically.</strong> The <em>same</em> particles — the conduction electrons — carry both the electric current and most of the heat current in a metal. Anything that impedes one impedes the other in exactly the same proportion, so the ratio is insensitive to the details of the scattering and is universal. This is why good electrical conductors (copper, silver) are also good thermal conductors, and why the law fails for insulators, where heat is carried by lattice vibrations instead of electrons.</p>`)}

 ${qa('3 m','4. Sodium is BCC with $a=0.429$ nm and contributes one free electron per atom. Calculate the free-electron concentration.',
 `<p><strong>Step 1 — atoms per cell.</strong> BCC has $8\\times\\tfrac18$ (corners) $+\\;1$ (body centre) $=2$ atoms per conventional cell.</p>
  <p><strong>Step 2 — cell volume.</strong></p>
  $$a^{3}=(0.429\\times10^{-9}\\ \\text{m})^{3}=7.90\\times10^{-29}\\ \\text{m}^{3}$$
  <p><strong>Step 3 — number density.</strong></p>
  $$n=\\frac{\\text{atoms per cell}\\times\\text{electrons per atom}}{a^{3}}
  =\\frac{2\\times1}{7.90\\times10^{-29}}$$
  ${must(`$$n=2.53\\times10^{28}\\ \\text{electrons m}^{-3}$$`)}
  <p><strong>Carry it further if asked.</strong> With this $n$,</p>
  $$k_F=(3\\pi^{2}n)^{1/3}=(3\\pi^{2}\\times2.53\\times10^{28})^{1/3}=9.1\\times10^{9}\\ \\text{m}^{-1}$$
  $$E_F=\\frac{\\hbar^{2}k_F^{2}}{2m}\\approx5.0\\times10^{-19}\\ \\text{J}\\approx3.1\\ \\text{eV}$$
  <p>which is the accepted Fermi energy of sodium — a good check that the arithmetic is sound. The general route for any metal is $n=\\rho N_A z/M$ when you are given the density instead of the lattice parameter.</p>`)}

 ${qa('3 m','5. What is a hole? State two of its properties and say where it matters.',
 `<p><strong>What it is.</strong> A hole is the <em>vacancy</em> left in an otherwise full band when one electron is removed (thermally excited into the conduction band, for example). Rather than track the $10^{23}$ remaining electrons, one tracks the single missing one.</p>
  <p><strong>Why it behaves like a particle.</strong> A completely full band carries no current, because for every electron at $+k$ there is one at $-k$. Remove one electron and the total current of the band is exactly <em>minus</em> the current that the missing electron would have carried. Since that electron sat near the top of the band, where the curvature is negative and $m^{*}\\lt0$, minus a negative charge with a negative mass is a <strong>positive charge with a positive mass</strong>.</p>
  <p><strong>Properties.</strong></p>
  <ul>
    <li>Charge $+e$ and a <strong>positive</strong> effective mass, so it drifts <em>along</em> the applied field — the opposite way to an electron.</li>
    <li>Its energy increases <em>downwards</em> in the band diagram; holes float to the top of the valence band the way bubbles rise.</li>
    <li>Its wavevector and energy are those of the missing electron with the sign reversed.</li>
  </ul>
  <p><strong>Where it matters.</strong> Holes are the majority carriers in $p$-type semiconductors, they make thermal excitation in an intrinsic semiconductor produce <em>two</em> carriers per event, and they explain why the <strong>Hall coefficient of some metals comes out positive</strong> — a result the classical free-electron theory could not account for at all.</p>`)}

 ${qa('3 m','6. Distinguish between the extended, reduced and periodic zone schemes.',
 `<p>All three are different ways of plotting the <em>same</em> $E(k)$ information. Because $E(k)$ is periodic in $k$ with period $2\\pi/a$, a state labelled $k$ and one labelled $k+G$ are physically identical, and that freedom is what the three schemes exploit.</p>
  <ul>
    <li><strong>Extended-zone scheme.</strong> Band $n$ is drawn in the $n$-th Brillouin zone, so the curve follows the free-electron parabola outwards with a gap torn open at every zone boundary $k=\\pm n\\pi/a$. Best for seeing how the bands descend from the free-electron result.</li>
    <li><strong>Reduced-zone scheme.</strong> Every branch is translated back by a suitable reciprocal lattice vector into the first zone, $-\\pi/a\\le k\\le\\pi/a$, so all bands are stacked over the same $k$ range. Nothing is lost — it is the same states relabelled — and this is the standard way band structures are published.</li>
    <li><strong>Periodic zone scheme.</strong> The reduced picture is repeated in every zone, so each band is drawn as a continuous periodic function of $k$ across all of $k$-space. Useful when you want to follow one band smoothly through a boundary, for instance in discussing the motion of an electron under a field.</li>
  </ul>
  <p>The <em>zone schemes</em> figure in the app steps through all three so you can see them as the same curve rearranged.</p>`)}

 ${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

 ${qa('6 m','7. Show that a crystal cannot possess a five-fold axis of symmetry.',
 `<p><strong>The set-up.</strong> Take a row of lattice points with spacing $T$, and pick two neighbours $B$ and $C$. Suppose an $n$-fold rotation axis stands perpendicular to the page through <em>every</em> lattice point, so that a rotation through $\\theta=360^\\circ/n$ about any lattice point must carry lattice points onto lattice points.</p>
  <p><strong>Step 1 — rotate.</strong> Rotate about $B$ through $+\\theta$ and about $C$ through $-\\theta$ (opposite senses). The images $B'$ and $C'$ of the neighbouring points must themselves be lattice points.</p>
  <p><strong>Step 2 — they lie on a lattice row.</strong> By symmetry $B'$ and $C'$ are the same height above the original row, so they lie on a row parallel to it. Every row of a lattice has its points spaced $T$ apart, so the distance $B'C'$ must be a <strong>whole number</strong> of steps:</p>
  $$B'C'=mT,\\qquad m\\in\\mathbb{Z}$$
  <p><strong>Step 3 — read the distance off the geometry.</strong> The projection of each rotated step onto the row direction is $T\\cos\\theta$, so</p>
  $$B'C'=T+2T\\cos\\theta=mT$$
  <p><strong>Step 4 — solve.</strong></p>
  ${must(`$$\\cos\\theta=\\frac{m-1}{2}$$`)}
  <p><strong>Step 5 — apply the constraint.</strong> A cosine must lie between $-1$ and $+1$, so $m-1$ must lie between $-2$ and $+2$: only $m=-1,0,1,2,3$ are possible. These give</p>
  <div style="overflow-x:auto"><table style="width:100%;border-collapse:collapse;font-size:.86rem">
  <tr style="text-align:left"><th>$m$</th><td>$-1$</td><td>$0$</td><td>$1$</td><td>$2$</td><td>$3$</td></tr>
  <tr><th>$\\cos\\theta$</th><td>$-1$</td><td>$-\\tfrac12$</td><td>$0$</td><td>$\\tfrac12$</td><td>$1$</td></tr>
  <tr><th>$\\theta$</th><td>$180^\\circ$</td><td>$120^\\circ$</td><td>$90^\\circ$</td><td>$60^\\circ$</td><td>$360^\\circ$</td></tr>
  <tr><th>$n$</th><td>2</td><td>3</td><td>4</td><td>6</td><td>1</td></tr>
  </table></div>
  <p><strong>Conclusion.</strong> Only $n=1,2,3,4$ and $6$ are compatible with translational periodicity. A five-fold axis would need $\\theta=72^\\circ$, giving $m=1+2\\cos72^\\circ=1.618$ — not a whole number (it is the golden ratio), so no lattice can support it. Equivalently: regular pentagons cannot tile the plane without gaps.</p>
  <p><em>If quasicrystals are mentioned:</em> they do show five-fold diffraction patterns, but they are ordered <strong>without</strong> being periodic, so the assumption the proof begins with — a lattice translation $T$ — simply does not apply to them.</p>`)}

 ${qa('6 m','8. Derive the density of states $D(E)$ for a three-dimensional free electron gas and hence show that $D(E_F)=\\tfrac32N/E_F$.',
 `<p><strong>Step 1 — counting states in $k$-space.</strong> For a cube of side $L$ with periodic boundary conditions, each allowed $\\mathbf k$ occupies a volume $(2\\pi/L)^{3}$, and each holds two electrons. The number of electrons in all states out to radius $k$ is</p>
  $$N(k)=2\\times\\frac{\\tfrac43\\pi k^{3}}{(2\\pi/L)^{3}}=\\frac{V k^{3}}{3\\pi^{2}}$$
  <p><strong>Step 2 — change the variable to energy.</strong> With $E=\\hbar^{2}k^{2}/2m$, i.e. $k=\\sqrt{2mE}/\\hbar$,</p>
  $$N(E)=\\frac{V}{3\\pi^{2}}\\left(\\frac{2mE}{\\hbar^{2}}\\right)^{3/2}\\;\\propto\\;E^{3/2}$$
  <p><strong>Step 3 — differentiate.</strong> The density of states is the number of states per unit energy interval:</p>
  ${must(`$$D(E)=\\frac{dN}{dE}=\\frac{V}{2\\pi^{2}}\\left(\\frac{2m}{\\hbar^{2}}\\right)^{3/2}E^{1/2}\\;\\propto\\;\\sqrt E$$`)}
  <p>Physically, $D$ rises with energy because a shell of the Fermi sphere at a larger radius has more surface area, and so holds more states.</p>
  <p><strong>Step 4 — the value at the Fermi level.</strong> There is a neat shortcut. Since $N\\propto E_F^{3/2}$, take logarithms and differentiate:</p>
  $$\\ln N=\\text{const}+\\frac32\\ln E_F
  \\quad\\Longrightarrow\\quad
  \\frac{dN}{N}=\\frac32\\frac{dE_F}{E_F}$$
  ${must(`$$D(E_F)=\\frac{dN}{dE_F}=\\frac{3}{2}\\frac{N}{E_F}$$`)}
  <p><strong>Why this matters.</strong> $D(E_F)$ is the number of electrons per unit energy that are actually able to respond — to absorb heat, to carry current, to be Pauli-paramagnetic. It is the quantity that appears in the electronic heat capacity, $C_v=\\tfrac{\\pi^2}{3}k_B^2T\\,D(E_F)$, and in the Pauli susceptibility. Note also the dimensional contrast: $D\\propto E^{1/2}$ in 3-D, constant in 2-D, and $E^{-1/2}$ in 1-D.</p>`)}

 ${qa('6 m','9. Derive the ideal $c/a$ ratio for a hexagonal close-packed structure.',
 `<p><strong>The geometry.</strong> In HCP the layers stack $ABAB\\dots$. Three touching spheres of the $A$ layer have their centres at the corners of an equilateral triangle of side $a=2r$; the $B$-layer sphere sits in the hollow, directly above the <em>centre</em> of that triangle, and the repeat distance $c$ spans two layers, so the vertical rise from $A$ to $B$ is $c/2$.</p>
  <p><strong>Step 1 — distance from the centre of the triangle to a corner.</strong> The median of an equilateral triangle of side $a$ is</p>
  $$\\text{median}=a\\sin60^{\\circ}=\\frac{\\sqrt3}{2}a$$
  <p>and the centroid lies two-thirds of the way along it from a vertex, so</p>
  $$d_{\\text{centre}}=\\frac23\\times\\frac{\\sqrt3}{2}a=\\frac{a}{\\sqrt3}$$
  <p><strong>Step 2 — Pythagoras on the tetrahedron.</strong> The upper sphere touches each of the three lower ones, so its centre is a distance $a$ (centre-to-centre) from each corner. That distance is the hypotenuse of a right triangle whose horizontal leg is $a/\\sqrt3$ and whose vertical leg is $c/2$:</p>
  $$a^{2}=\\left(\\frac{a}{\\sqrt3}\\right)^{2}+\\left(\\frac c2\\right)^{2}$$
  <p><strong>Step 3 — solve.</strong></p>
  $$\\frac{c^{2}}{4}=a^{2}-\\frac{a^{2}}{3}=\\frac{2}{3}a^{2}
  \\quad\\Longrightarrow\\quad
  c^{2}=\\frac83a^{2}$$
  ${must(`$$\\frac ca=\\sqrt{\\frac83}=1.633$$`)}
  <p><strong>Worth adding.</strong> Real HCP metals are close but not exact — Mg $1.624$, Zn $1.856$, Cd $1.886$ — and the deviation is a measure of how non-spherical the bonding is. The ideal ratio is what makes HCP achieve the same packing fraction ($0.74$) and the same coordination number ($12$) as FCC.</p>`)}

 ${qa('6 m','10. Summarise the failures of the classical free electron theory and explain how Sommerfeld’s quantum theory removes them.',
 `<p><strong>The failures.</strong></p>
  <ol>
    <li><strong>Heat capacity.</strong> Equipartition gives every electron $\\tfrac32k_BT$, predicting an electronic $C_v=\\tfrac32R$ comparable with the lattice term. The measured value is about 1% of that, and it is <em>linear</em> in $T$.</li>
    <li><strong>Resistivity.</strong> With $\\tau=\\lambda/v_{th}$ and $v_{th}\\propto\\sqrt T$ the model gives $\\rho\\propto\\sqrt T$; experiment gives $\\rho\\propto T$.</li>
    <li><strong>Magnetic susceptibility.</strong> Predicts a large Curie $1/T$ paramagnetism; the observed susceptibility is small and nearly temperature-independent.</li>
    <li><strong>Mean free path.</strong> Offers no reason why an electron in a pure cold metal travels past $10^{8}$–$10^{9}$ atoms without scattering.</li>
    <li>It also cannot explain the positive Hall coefficient of some metals, nor the existence of insulators and semiconductors.</li>
  </ol>
  <p><strong>Sommerfeld’s correction.</strong> Keep the free-electron picture — flat potential, no electron–electron interaction — but treat the electrons as <strong>fermions obeying Fermi–Dirac statistics</strong> rather than as a classical Maxwell–Boltzmann gas. The consequences:</p>
  <ul>
    <li>Electrons fill states up to $E_F$ (a few eV, i.e. $T_F\\sim10^{4}$–$10^{5}$ K). At ordinary temperatures $T\\ll T_F$, so the gas is <strong>degenerate</strong>: only the fraction $\\sim T/T_F$ of electrons within $k_BT$ of $E_F$ has empty states to move into.</li>
    <li>That immediately fixes failure 1: $C_v\\approx\\tfrac32R\\,(T/T_F)$ — about 1% of the classical value <em>and</em> linear in $T$.</li>
    <li>It fixes failure 3 the same way: only the same small fraction can flip its spin, giving the small, temperature-independent <strong>Pauli paramagnetism</strong> instead of a Curie law.</li>
    <li>It repairs failure 2 partly: the electrons that carry current move at $v_F$, which is set by $E_F$ and is essentially independent of temperature, so $\\rho$ is controlled by the temperature dependence of $\\lambda$ rather than of $v$ — and the phonon population gives $\\rho\\propto T$.</li>
    <li>It also gets the Lorenz number right, $L=\\tfrac{\\pi^{2}}{3}(k_B/e)^{2}=2.45\\times10^{-8}$, where the classical value was about half the measured one.</li>
  </ul>
  <p><strong>What Sommerfeld does <em>not</em> fix.</strong> Failures 4 and 5 survive, because they are not statistical: they come from throwing away the <em>periodic potential</em>. Only band theory — Bloch’s theorem, and gaps opening at the zone boundaries — explains the enormous mean free path, the positive Hall coefficient, and the very existence of insulators and semiconductors.</p>`)}

 ${secband('C','Answer any 1 question. Each carries 10 marks.')}

 ${qa('10 m','11. (a) Starting from the Kronig–Penney condition, discuss the limiting cases $P\\to\\infty$ and $P\\to0$ and the way band width varies with energy. (6) &nbsp;(b) Show that one energy band holds exactly $2N$ electrons, and use this to explain why some divalent solids are still metals. (4)',
 `<p><strong>(a) The condition.</strong> In the delta-function limit the Kronig–Penney model reduces to</p>
  $$P\\,\\frac{\\sin(\\alpha a)}{\\alpha a}+\\cos(\\alpha a)=\\cos(ka),
  \\qquad P=\\frac{mV_0ba}{\\hbar^{2}},\\qquad \\alpha=\\frac{\\sqrt{2mE}}{\\hbar}$$
  <p>$P$ measures how strongly the lattice grips the electron. A real solution for $k$ exists only where the left-hand side lies between $-1$ and $+1$.</p>
  <p><strong>Limit 1: $P\\to\\infty$ (very strong barriers — isolated atoms).</strong> For the left side to stay finite the factor multiplying $P$ must vanish:</p>
  $$\\frac{\\sin(\\alpha a)}{\\alpha a}\\to0\\;\\Rightarrow\\;\\sin(\\alpha a)=0\\;\\Rightarrow\\;\\alpha a=n\\pi$$
  <p>and since $\\alpha=\\sqrt{2mE}/\\hbar$,</p>
  ${must(`$$E_n=\\frac{n^{2}\\pi^{2}\\hbar^{2}}{2ma^{2}}=\\frac{n^{2}h^{2}}{8ma^{2}}$$`)}
  <p>which are exactly the levels of a particle in a box of width $a$. The allowed bands have shrunk to <strong>discrete atomic levels</strong> — the electron is trapped in one well and the solid has become a collection of isolated atoms.</p>
  <p><strong>Limit 2: $P\\to0$ (no barriers — free electrons).</strong> The condition becomes $\\cos(\\alpha a)=\\cos(ka)$, so $\\alpha=k$ and</p>
  ${must(`$$E=\\frac{\\hbar^{2}k^{2}}{2m}$$`)}
  <p>the free-electron parabola, with <strong>no gaps at all</strong> — every energy is allowed.</p>
  <p><strong>Band width against energy.</strong> The lattice enters only through the term $P\\sin(\\alpha a)/(\\alpha a)$, whose amplitude falls off as $1/\\alpha a$. At high energy $\\alpha a$ is large, that term shrinks, and the left-hand side is dominated by $\\cos(\\alpha a)$ — which already lives inside the corridor. So the curve spends more of its time inside $[-1,1]$ and pokes out less far: <strong>allowed bands get wider and forbidden gaps get narrower as the energy rises</strong>. Physically, a fast electron spends little time near each ion core, so the lattice barely perturbs it, and at high enough energy it behaves almost freely.</p>
  <p><strong>(b) Band capacity.</strong> Take a crystal of $N$ primitive cells, so its length is $L=Na$. Periodic boundary conditions quantise $k$ in steps of $2\\pi/L$. One Brillouin zone spans $k$ from $-\\pi/a$ to $+\\pi/a$, a width of $2\\pi/a$, so the number of allowed $k$ values in a band is</p>
  $$\\frac{2\\pi/a}{2\\pi/L}=\\frac La=\\frac{Na}{a}=N$$
  <p>and each $k$ takes two electrons (spin $\\uparrow\\downarrow$):</p>
  ${must(`$$\\text{one band holds exactly }2N\\text{ electrons.}$$`)}
  <p><strong>The consequence.</strong> With one valence electron per atom the band is <em>half</em> full, $E_F$ lies inside it, empty states sit directly above occupied ones, and the solid is a <strong>metal</strong> (the alkali metals). With two valence electrons per atom the band should be exactly full and the solid should be an insulator.</p>
  <p><strong>Why divalent solids are metals anyway.</strong> Because in three dimensions bands from different zones <strong>overlap in energy</strong>. The top of the lower band is higher than the bottom of the next one, so before the first band is quite full electrons start to spill into the second. The result is two partly filled bands instead of one full one, and the solid conducts. That is exactly the case for the alkaline earths — Be, Mg, Ca — and for Zn. It is also why band <em>overlap</em>, not just band filling, must be mentioned when classifying solids.</p>`)}

 ${qa('10 m','12. (a) Derive the expression for the effective mass of an electron in a band. (6) &nbsp;(b) Sketch $E(k)$, $v(k)$ and $m^{*}(k)$ for the first band and mark where $m^{*}$ is negative. (4)',
 `<p><strong>(a) Derivation.</strong></p>
  <p><em>Step 1 — the velocity.</em> A Bloch electron is a wave packet, so it travels at the group velocity of its waves. With $\\omega=E/\\hbar$,</p>
  $$v=\\frac{d\\omega}{dk}=\\frac{1}{\\hbar}\\frac{dE}{dk}$$
  <p><em>Step 2 — the work done by the field.</em> In a time $dt$ an applied force $F=-e\\mathcal E$ does work $F v\\,dt$ on the electron, which must equal its energy change:</p>
  $$dE=F\\,v\\,dt=F\\frac{1}{\\hbar}\\frac{dE}{dk}dt$$
  <p>But also $dE=\\dfrac{dE}{dk}dk$. Comparing the two and cancelling $dE/dk$:</p>
  ${must(`$$\\hbar\\frac{dk}{dt}=F$$`)}
  <p>a Newton-like law in which $\\hbar k$ plays the role of momentum (the <em>crystal momentum</em>).</p>
  <p><em>Step 3 — the acceleration.</em> Differentiate the velocity and use the chain rule:</p>
  $$a=\\frac{dv}{dt}=\\frac{1}{\\hbar}\\frac{d}{dt}\\!\\left(\\frac{dE}{dk}\\right)
  =\\frac{1}{\\hbar}\\frac{d^{2}E}{dk^{2}}\\frac{dk}{dt}
  =\\frac{1}{\\hbar^{2}}\\frac{d^{2}E}{dk^{2}}\\,F$$
  <p><em>Step 4 — compare with Newton.</em> Writing $a=F/m^{*}$ identifies</p>
  ${must(`$$m^{*}=\\frac{\\hbar^{2}}{d^{2}E/dk^{2}}$$`)}
  <p>So the effective mass is fixed entirely by the <strong>curvature of the band</strong>: sharply curved means light and responsive, flat means heavy and sluggish. Near the bottom of a band $E\\approx\\hbar^2k^2/2m^{*}$ and the electron behaves like a free particle of mass $m^{*}$; the periodic lattice has been absorbed into a single number.</p>
  <p><strong>(b) The three sketches.</strong> Using the standard band $E(k)=E_0(1-\\cos ka)$ over the first zone $-\\pi/a\\le k\\le\\pi/a$:</p>
  <ul>
    <li><strong>$E(k)$</strong> — a minimum at $k=0$, parabolic near the bottom, flattening to a maximum at the zone boundaries $k=\\pm\\pi/a$.</li>
    <li><strong>$v(k)=\\hbar^{-1}dE/dk$</strong> — zero at $k=0$, rising to a <em>maximum at the inflection point</em> $k=\\pm\\pi/2a$, then falling back to <strong>zero at $k=\\pm\\pi/a$</strong>. The electron at the zone boundary is a standing wave and does not move, however hard it is pushed.</li>
    <li><strong>$m^{*}(k)\\propto1/(d^{2}E/dk^{2})$</strong> — small and positive at the band bottom, growing as the band flattens, <strong>diverging at the inflection point</strong> $k=\\pm\\pi/2a$ where the curvature passes through zero, and then <strong>negative</strong> throughout the upper half of the band, $\\pi/2a\\lt|k|\\le\\pi/a$.</li>
  </ul>
  <p><strong>Mark and explain the negative region.</strong> Between $k=\\pi/2a$ and $k=\\pi/a$ the curvature is negative, so $m^{*}\\lt0$: the electron accelerates <em>against</em> the applied force. The reason is that near the zone boundary the electron is close to the Bragg condition and the lattice is returning momentum to the crystal faster than the field supplies it; $m^{*}$ is simply the device that hides the lattice force inside one symbol. Total momentum — electron plus lattice — is conserved throughout. A vacancy in this region is a <strong>hole</strong>, with charge $+e$ and positive mass.</p>
  <p>The <em>effective mass</em> figure in the app draws exactly these three panels, one per step, and shades the $m^{*}\\lt0$ region.</p>`)}
`},

{id:'close',title:'Last pass before the exam',short:'Final checklist',est:'~10 min',
 body:`
 ${gist('Close the app and try to write all of this from memory. Whatever you cannot recall is your morning revision list.')}

 ${tp('Formulas you must be able to write cold')}
 <ul>
   <li>$N=N_i+\\tfrac12N_f+\\tfrac18N_c$ &nbsp;→&nbsp; SC 1, BCC 2, FCC 4 atoms per cell</li>
   <li>$d_{hkl}=a/\\sqrt{h^2+k^2+l^2}$ &nbsp;·&nbsp; $\\cos\\theta$ between $[h_1k_1l_1]$ and $[h_2k_2l_2]$ &nbsp;·&nbsp; $hu+kv+lw=0$</li>
   <li>Touching: SC $a=2r$ · BCC $\\sqrt3a=4r$ · FCC $\\sqrt2a=4r$; $f=0.52,\\,0.68,\\,0.74$; $CN=6,8,12$</li>
   <li>$c/a=\\sqrt{8/3}=1.633$ &nbsp;·&nbsp; $\\rho=nM/N_Aa^3$ &nbsp;·&nbsp; NaCl $a=2(r_++r_-)$</li>
   <li>$2d\\sin\\theta=n\\lambda$ &nbsp;·&nbsp; $\\mathbf G=\\tfrac{2\\pi}{d}\\hat{\\mathbf n}$ &nbsp;·&nbsp; $2\\mathbf k\\cdot\\mathbf G+G^2=0$</li>
   <li>$k_F=(3\\pi^2n)^{1/3}$ · $E_F=\\tfrac{\\hbar^2}{2m}(3\\pi^2n)^{2/3}$ · $v_F=\\hbar k_F/m$ · $T_F=E_F/k_B$</li>
   <li>$D(E)\\propto\\sqrt E$ · $D(E_F)=\\tfrac32N/E_F$ · $\\bar E_0=\\tfrac35E_F$ · $B=\\tfrac23nE_F$</li>
   <li>$f(E)=1/[e^{(E-E_F)/k_BT}+1]$, $f(E_F)=\\tfrac12$ · $C_v\\approx\\tfrac32Nk_B(T/T_F)$</li>
   <li>$P\\tfrac{\\sin\\alpha a}{\\alpha a}+\\cos\\alpha a=\\cos ka$ · $v=\\tfrac1\\hbar\\tfrac{dE}{dk}$ · $m^{*}=\\hbar^2/(d^2E/dk^2)$ · band holds $2N$</li>
 </ul>

 ${tp('Derivations worth rehearsing')}
 <p>These five are the ones that come up as “derive/show that” questions. If time is short, do these and skip everything else:</p>
 <ol>
   <li>$\\cos\\theta=(m-1)/2$ → only $n=1,2,3,4,6$</li>
   <li>$d_{hkl}=a/\\sqrt{h^2+k^2+l^2}$ from direction cosines</li>
   <li>$c/a=\\sqrt{8/3}$ for ideal HCP</li>
   <li>Fermi sphere → $k_F$ and $E_F$ (and $\\bar E_0=\\tfrac35E_F$)</li>
   <li>$m^{*}=\\hbar^2/(d^2E/dk^2)$</li>
 </ol>

 ${tp('Short-answer questions that recur')}
 <ul>
   <li>Lattice vs basis vs structure — with diamond or NaCl as the example.</li>
   <li>Why no 5-fold axis. Why no face-centred tetragonal.</li>
   <li>Show Bragg and Laue are equivalent.</li>
   <li>Reciprocal of BCC is FCC (and vice versa); first BZ of FCC = truncated octahedron, of BCC = rhombic dodecahedron.</li>
   <li>Successes and failures of the classical free electron theory.</li>
   <li>Why $C_v$ is ~1% of the classical value and linear in $T$.</li>
   <li>Bloch's theorem — statement, and what it implies about scattering.</li>
   <li>Kronig–Penney limits $P\\to0$ and $P\\to\\infty$.</li>
   <li>Why a full band carries no current; metal vs semiconductor vs insulator.</li>
 </ul>

 ${trap(`<p>Three habits that save marks: <strong>state the structure first</strong> (“FCC ⇒ $n=4$, $\\sqrt2a=4r$”) before substituting numbers; <strong>keep units consistent</strong> — mixing Å with metres wrecks every $2/3$ power; and <strong>sanity-check</strong> — $E_F$ should be a few eV, $f$ between 0.3 and 0.75, $v_F\\sim10^6$ m/s.</p>`)}

 <p class="dim" style="margin-top:1.4rem;text-align:center"><span class="spark">⬡</span>&nbsp; Now sleep. It genuinely helps more than another hour of reading.</p>
`},

];
window.STATIONS=STATIONS;

/* ── module grouping: Module ▸ Section ▸ Topic ── */
const MODULES=[
 {id:'mod-0',name:'Start',sub:'Read this first',
  stations:['start']},
 {id:'mod-1',name:'Module I',sub:'Crystals &amp; X-rays',
  stations:['m1-basics','m1-symmetry','m1-bravais','m1-planes','m1-dspacing',
            'm1-packing','m1-compounds','m1-xrd','m1-problems']},
 {id:'mod-2',name:'Module II',sub:'Electrons in solids',
  stations:['m2-drude','m2-fermi','m2-dos','m2-fd','m2-bloch','m2-kp',
            'm2-dynamics','m2-problems']},
 {id:'mod-3',name:'Model tests',sub:'Sit the paper, then check',
  stations:['test-1','test-2','test-3']},
 {id:'mod-4',name:'Final checklist',sub:'Last pass before the exam',
  stations:['close']}
];
window.MODULES=MODULES;
