#!/usr/bin/env python3
"""One-off: assemble src/shell.html from the LATEX_1 shell (layout, tree, widgets, tabs)
and the SOLID_STATE_1 shell (figures, ladders, checkpoints, problems), plus the
Materials Science identity. Kept for the record; edit src/shell.html directly from now on."""
import io, os
HERE = os.path.dirname(os.path.abspath(__file__))
L = io.open(os.path.join(HERE, '..', 'latex1', 'src', 'shell.html'), encoding='utf-8').read().split('\n')
S = io.open(os.path.join(HERE, '..', 'ss1', 'SS_1.shell.html'), encoding='utf-8').read().split('\n')
lx = lambda a, b: '\n'.join(L[a - 1:b])          # 1-based inclusive
ss = lambda a, b: '\n'.join(S[a - 1:b])

FAV = ("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E"
       "%3Crect width='100' height='100' rx='22' fill='%23171A1D'/%3E"
       "%3Cpath d='M18 30 44 18 58 40 40 60 16 52Z' fill='%23D9A441'/%3E"
       "%3Cpath d='M58 40 44 18 80 22 84 48Z' fill='%236E95E8'/%3E"
       "%3Cpath d='M40 60 58 40 84 48 78 80 46 84Z' fill='%23E0DDD5'/%3E"
       "%3Cpath d='M16 52 40 60 46 84 20 78Z' fill='%23C2553F'/%3E%3C/svg%3E")

HEAD = f'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Materials Science · Modules I &amp; II</title>
<link rel="icon" href="{FAV}">
<meta name="theme-color" content="#F5F3EE">
<!--MS:FONTS-->
<style>
/* ══════════════ palette — metallography: a polished, etched specimen ══════════════
   light = the specimen under bright field · dark = dark-field illumination
   module accents are real materials: cobalt-blue glaze (ceramic, bonding),
   brass (metal, crystals & defects), verdigris (tests), iron oxide (practice)
   figure roles: pos = cations / metal atoms (bronze) · neg = anions / electrons (cobalt)
   prob = vectors, highlights (magenta) · wall = defects, boundaries, repulsion (crimson) */
:root{{
  --red-rgb:178,58,40;        /* iron oxide — practice, errors                    */
  --blue-rgb:44,86,170;       /* cobalt glaze — Module I, links                   */
  --green-rgb:28,128,104;     /* verdigris — correct, tests                       */
  --amber-rgb:170,110,24;     /* brass — Module II, bookmarks                     */
  --ink-rgb:26,28,30;
  --pos-rgb:176,98,36; --neg-rgb:36,104,178; --prob-rgb:156,52,150; --wall-rgb:190,40,52;
  --void:#F2F0EB; --paper:#F9F8F4; --bench:#FFFFFF; --panel:#ECE9E2; --panel2:#E2DED5;
  --rule:#D7D2C8; --rule-soft:#E7E3DB;
  --ink:#1A1C1E; --dim:#565A5E; --faint:#8A8D90;
  --plot-bg:#FBFAF7; --plot-grid:#E6E3DC; --plot-axis:#B5B2AB; --is-dark:0;
  --shadow:0 1px 2px rgba(20,24,30,.05),0 6px 18px rgba(20,24,30,.06);
  --shadow-lift:0 2px 8px rgba(20,24,30,.10),0 18px 40px rgba(20,24,30,.12);
  --on-accent:#FFFFFF;
  color-scheme:light;
}}
@media (prefers-color-scheme:dark){{
  :root:not([data-theme="light"]){{
    --red-rgb:240,122,98; --blue-rgb:122,160,245; --green-rgb:92,204,172; --amber-rgb:226,176,88;
    --ink-rgb:232,230,226;
    --pos-rgb:232,152,90; --neg-rgb:104,172,245; --prob-rgb:220,120,214; --wall-rgb:246,98,108;
    --void:#0E1012; --paper:#14171A; --bench:#181B1F; --panel:#20242A; --panel2:#282D33;
    --rule:#30353C; --rule-soft:#23272D;
    --ink:#E8E6E2; --dim:#A4A7AA; --faint:#6C7075;
    --plot-bg:#111417; --plot-grid:#23272D; --plot-axis:#3A4048; --is-dark:1;
    --shadow:0 1px 2px rgba(0,0,0,.45); --shadow-lift:0 10px 34px rgba(0,0,0,.55);
    --on-accent:#0E1012;
    color-scheme:dark;
  }}
}}
:root[data-theme="dark"]{{
  --red-rgb:240,122,98; --blue-rgb:122,160,245; --green-rgb:92,204,172; --amber-rgb:226,176,88;
  --ink-rgb:232,230,226;
  --pos-rgb:232,152,90; --neg-rgb:104,172,245; --prob-rgb:220,120,214; --wall-rgb:246,98,108;
  --void:#0E1012; --paper:#14171A; --bench:#181B1F; --panel:#20242A; --panel2:#282D33;
  --rule:#30353C; --rule-soft:#23272D;
  --ink:#E8E6E2; --dim:#A4A7AA; --faint:#6C7075;
  --plot-bg:#111417; --plot-grid:#23272D; --plot-axis:#3A4048; --is-dark:1;
  --shadow:0 1px 2px rgba(0,0,0,.45); --shadow-lift:0 10px 34px rgba(0,0,0,.55);
  --on-accent:#0E1012;
  color-scheme:dark;
}}
:root{{
  --red:rgb(var(--red-rgb)); --blue:rgb(var(--blue-rgb)); --green:rgb(var(--green-rgb)); --amber:rgb(var(--amber-rgb));
  --pos:rgb(var(--pos-rgb)); --neg:rgb(var(--neg-rgb)); --prob:rgb(var(--prob-rgb)); --wall:rgb(var(--wall-rgb));
  --accent-rgb:var(--blue-rgb); --accent:var(--blue);
  --f-d:'Bricolage Grotesque','Avenir Next','Segoe UI',system-ui,sans-serif;
  --f-b:'Instrument Sans','Segoe UI',system-ui,-apple-system,Roboto,sans-serif;
  --f-m:'JetBrains Mono','Cascadia Code',Consolas,'SF Mono',Menlo,monospace;
  --col:50rem; --wide:62rem; --prose:44rem;
  --sp:clamp(.8rem,3vw,1.5rem);
  --ease:cubic-bezier(.2,.7,.2,1);
}}'''

MS_EXTRA = r'''
/* ══════════════ materials-science additions ══════════════ */
#app>*{min-width:0}
mjx-container[display="true"]{min-width:0!important;overflow-x:auto;overflow-y:hidden;padding:.15em 0}
mjx-container{color:inherit}
.mod.m1{--accent-rgb:var(--blue-rgb);--accent:var(--blue)}
.mod.m2{--accent-rgb:var(--amber-rgb);--accent:var(--amber)}
.mod.m3{--accent-rgb:var(--green-rgb);--accent:var(--green)}
.mod.m4{--accent-rgb:var(--red-rgb);--accent:var(--red)}
.mod.m0{--accent-rgb:var(--ink-rgb);--accent:var(--ink)}
.brand{font-family:var(--f-d);font-weight:650;letter-spacing:-.015em}
.brand .grain{display:inline-block;width:1.05rem;height:1.05rem;border-radius:.3rem;align-self:center;
  background:conic-gradient(from 20deg,var(--amber) 0 26%,var(--blue) 0 52%,var(--rule) 0 78%,var(--red) 0)}
.masthead h1{font-family:var(--f-d);font-weight:650;letter-spacing:-.025em}
.masthead h1 em{font-style:normal;color:var(--accent)}
.mh .mt b{font-family:var(--f-d);font-weight:600}
.carry{display:grid;grid-template-columns:1fr 1fr;gap:.6rem;margin:.8rem 0 1rem}
.carry>div{border:1px solid var(--rule-soft);border-radius:.7rem;padding:.6rem .8rem;background:var(--paper)}
.carry .ch{font-family:var(--f-m);font-size:.6rem;letter-spacing:.12em;text-transform:uppercase;color:var(--faint);margin-bottom:.2rem}
.carry>div:last-child .ch{color:var(--accent)}
.carry ul{margin:0;padding-left:1.05rem}
.carry li{margin:.25rem 0;font-size:.9rem;line-height:1.5}
@media(max-width:560px){.carry{grid-template-columns:1fr}}
.note.key{border-left-color:var(--green)} .note.key .nh{color:var(--green)}
.eq{margin:.8rem 0;padding:.4rem .6rem;border-radius:.6rem;background:var(--paper);border:1px solid var(--rule-soft);overflow-x:auto}
.defn{margin:.7rem 0;padding:.55rem .8rem;border-radius:.55rem;border:1px solid var(--rule-soft);background:var(--paper);font-size:.94rem}
.defn b:first-child{color:var(--accent)}
.src{font-family:var(--f-m);font-size:.66rem;color:var(--faint);letter-spacing:.04em}
.pill{display:inline-block;font-family:var(--f-m);font-size:.64rem;border:1px solid var(--rule);border-radius:1rem;padding:.05rem .45rem;color:var(--dim);white-space:nowrap}
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(15rem,1fr));gap:.6rem;margin:.8rem 0}
.grid2>div{border:1px solid var(--rule-soft);border-radius:.7rem;padding:.6rem .8rem;background:var(--paper);font-size:.92rem}
.grid2>div>b:first-child{display:block;font-family:var(--f-d);font-weight:600;margin-bottom:.15rem}
table.ref td.num,table.ref th.num{text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
'''

FIG_CSS = r'''
/* ══════════════ derivation ladders · figures · checkpoints · worked problems ══════════════ */
''' + ss(235, 249) + '\n' + ss(250, 250) + '\n' + ss(259, 298) + '\n' + ss(300, 338) + r'''
.lfoot{padding:.6rem 1rem;background:var(--panel);border-top:1px solid var(--rule);display:flex;gap:.6rem;align-items:center;flex-wrap:wrap}
.lfoot .mini{flex:1;min-width:12rem}
.rung .math{overflow-x:auto}
figure.fig .figbar button{font-family:var(--f-m)}
.check{--accent-rgb:var(--prob-rgb);--accent:var(--prob)}
'''

SOLVER_CSS = r'''
/* ══════════════ Solver tab: numerical problems, every step shown ══════════════ */
.solv{margin:0 0 1rem;border:1px solid var(--rule);border-radius:1rem;background:var(--paper);box-shadow:var(--shadow);overflow:hidden}
.solv>summary{list-style:none;cursor:pointer;display:flex;gap:.7rem;align-items:center;padding:.85rem 1rem}
.solv>summary::-webkit-details-marker{display:none}
.solv>summary .ic{flex:none;width:2.1rem;height:2.1rem;border-radius:.6rem;display:grid;place-items:center;font-family:var(--f-m);
  font-size:.8rem;font-weight:600;background:rgba(var(--accent-rgb),.12);color:var(--accent)}
.solv>summary .tt{flex:1;min-width:0}
.solv>summary .tt b{display:block;font-family:var(--f-d);font-weight:600;font-size:1.05rem;line-height:1.2}
.solv>summary .tt small{color:var(--dim);font-size:.8rem}
.solv>summary .chev{color:var(--faint);transition:transform .2s}
.solv[open]>summary .chev{transform:rotate(90deg)}
.solv[open]>summary{border-bottom:1px dashed var(--rule)}
.solv .sb{padding:.8rem 1rem 1rem}
.solv .ins{display:grid;grid-template-columns:repeat(auto-fit,minmax(9.5rem,1fr));gap:.55rem;margin:.2rem 0 .8rem}
.solv label{display:flex;flex-direction:column;gap:.2rem;font-size:.76rem;color:var(--dim);font-weight:600}
.solv label input,.solv label select{font:inherit;font-family:var(--f-m);font-size:.9rem;font-weight:500;color:var(--ink);background:var(--bench);
  border:1px solid var(--rule);border-radius:.5rem;padding:.42rem .55rem;min-width:0;width:100%}
.solv label input:focus,.solv label select:focus{outline:2px solid rgba(var(--accent-rgb),.35);border-color:var(--accent)}
.solv .presets{display:flex;gap:.35rem;flex-wrap:wrap;margin:0 0 .7rem}
.solv .presets button{font-family:var(--f-m);font-size:.68rem;border:1px solid var(--rule);background:var(--bench);border-radius:1rem;
  padding:.22rem .6rem;cursor:pointer;color:var(--dim)}
.solv .presets button:hover{color:var(--ink);border-color:var(--faint)}
.solv .steps{border-top:1px solid var(--rule-soft);padding-top:.5rem}
.solv .st{display:grid;grid-template-columns:1.6rem 1fr;gap:.1rem .5rem;padding:.35rem 0;border-bottom:1px dashed var(--rule-soft)}
.solv .st:last-child{border-bottom:0}
.solv .st .n{font-family:var(--f-m);font-size:.7rem;color:var(--faint);padding-top:.25rem}
.solv .st .w{font-size:.84rem;color:var(--dim)}
.solv .st .m{overflow-x:auto}
.solv .res{margin-top:.6rem;padding:.6rem .8rem;border-radius:.6rem;background:rgba(var(--accent-rgb),.08);border:1px solid rgba(var(--accent-rgb),.25);
  font-weight:600;overflow-x:auto}
.solv .err{color:var(--red);font-size:.85rem}
'''

BODY = r'''
</style>
</head>
<body>
<header id="top">
  <div class="topwrap">
    <span class="brand"><span class="grain" aria-hidden="true"></span>Materials Science<small>Modules I–II</small></span>
    <span class="hspace"></span>
    <div class="ring" title="Progress">
      <svg width="34" height="34" viewBox="0 0 34 34">
        <circle cx="17" cy="17" r="14" fill="none" stroke="var(--rule)" stroke-width="3"/>
        <circle id="ringp" cx="17" cy="17" r="14" fill="none" stroke="var(--blue)" stroke-width="3"
          stroke-linecap="round" stroke-dasharray="88" stroke-dashoffset="88"/>
      </svg>
      <span class="pct" id="ringpct">0%</span>
    </div>
    <button class="iconbtn" id="dl" title="Download the offline copy" hidden>⤓</button>
    <button class="iconbtn" id="cloud" title="Sync progress between devices">☁</button>
    <button class="iconbtn" id="theme" title="Theme">◐</button>
  </div>
  <div class="progbar"><i id="pbar"></i></div>
</header>
<nav id="nav" aria-label="Sections of the app">
'''+lx(721,721)+r'''
  <button data-view="solve"><i><svg viewBox="0 0 24 24" width="22" height="22" fill="currentColor" aria-hidden="true"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5.97 4.06L14.09 6l1.41 1.41L16.91 6l1.06 1.06-1.41 1.41 1.41 1.41-1.06 1.06-1.41-1.4-1.41 1.41-1.06-1.06 1.41-1.41-1.41-1.42zm-6.78.66h5v1.5h-5v-1.5zM11.5 16h-2v2H8v-2H6v-1.5h2v-2h1.5v2h2V16zm6.5 1.25h-5v-1.5h5v1.5zm0-2.5h-5v-1.5h5v1.5z"/></svg></i><span>Solver</span></button>
'''+lx(723,723)+r'''
</nav>
<main id="app">
 <section class="view on" id="view-learn">
  <header class="masthead">
    <h1>Materials <em>Science</em></h1>
    <p>Modules I &amp; II — what materials are and why they bond the way they do, then how real crystals
      are built and how they go wrong: grains, anisotropy, X-rays, vacancies, impurities, dislocations and boundaries.
      Every diagram is drawn live from the real formula; every section ends with retrieval practice.</p>
  </header>
  <div id="stations"></div>
  <p class="foot"><!--MS:FOOT--></p>
 </section>
 <section class="view" id="view-solve">
  <header class="masthead"><h1>Solver <em>bench</em></h1>
    <p>The numerical problems these two modules can ask, as calculators that show every line of working —
      the same lines you write in the exam. Change a number and watch the whole solution update.</p></header>
  <div id="solvers"></div>
 </section>
 <section class="view" id="view-bm">
  <header class="masthead"><h1>Bookmarked <em>for review</em></h1>
    <p>Everything you starred, in one place — same cards, same exercises. Unstar an item when you have it cold.</p></header>
  <div id="bmlist"></div>
 </section>
</main>
<div id="sync"><span class="dot"></span><span id="synctxt"></span></div>
<div class="modal" id="idmodal">
  <div class="card">
    <h3>Sync your progress</h3>
    <p class="mini">Progress saves in this browser automatically. To carry it between phone and laptop, pick a sync code and enter the same one on both.</p>
    <input id="idinput" placeholder="e.g. umair-matsci-2026" autocomplete="off" spellcheck="false">
    <div class="row"><button class="btn primary" id="idsave" style="flex:1">Connect &amp; sync</button><button class="btn" id="idclose">Later</button></div>
    <p class="mini" id="idstatus" style="margin-top:.6rem"></p>
  </div>
</div>
<!--MS:SCRIPTS-->
</body>
</html>
'''

css_lx = '\n'.join([
    lx(61, 196),            # base, header, page, tree, reading
    lx(310, 401),           # widgets: shell, buttons, OMR, flashcards, match, fill
    lx(426, 502),           # model papers, views/nav, bookmarks, stars, donebar
    lx(515, 518),           # modal helpers
    lx(674, 677),           # long OMR sheets
    '.omr.onlywrong .q:not(.bad){display:none}',
    lx(679, 698),           # bookmarks view, toast, modal, footer
])
css_lx = css_lx.replace('body.v-ide main#app{max-width:none;padding:0}\n', '').replace('body.v-ide .foot{display:none}\n', '')
out = HEAD + '\n' + css_lx + '\n' + MS_EXTRA + FIG_CSS + SOLVER_CSS + BODY
dest = os.path.join(HERE, 'src', 'shell.html')
io.open(dest, 'w', encoding='utf-8').write(out)
print('wrote', dest, len(out))
