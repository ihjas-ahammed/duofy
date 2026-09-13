/* ══════════════════════════════════════════════════════════════════
   QM · Modules I–II — study-journey engine
   Framework · accurate canvas diagrams · retrieval · Firebase sync
   ══════════════════════════════════════════════════════════════════ */
(function(){
'use strict';
const $=(s,r=document)=>r.querySelector(s), $$=(s,r=document)=>[...r.querySelectorAll(s)];
const clamp=(v,a,b)=>v<a?a:v>b?b:v;
/* typeset that waits for MathJax to be ready */
function mj(el,then){
  const run=()=>{try{window.MathJax.typesetPromise(el?[el]:null).then(()=>then&&then());}
    catch(e){then&&then();}};
  if(window.__mjReady&&window.MathJax&&window.MathJax.typesetPromise)run();
  else (window.__mjQueue=window.__mjQueue||[]).push(run);
}

/* ─────────── palette read from CSS (theme-aware) ─────────── */
let C={};
function readPalette(){
  const cs=getComputedStyle(document.documentElement);
  const g=n=>cs.getPropertyValue(n).trim();
  const rgb=n=>`rgb(${g(n)})`, rgba=(n,a)=>`rgba(${g(n)},${a})`;
  C={
    pos:rgb('--pos-rgb'), neg:rgb('--neg-rgb'), prob:rgb('--prob-rgb'), wall:rgb('--wall-rgb'),
    posA:a=>rgba('--pos-rgb',a), negA:a=>rgba('--neg-rgb',a),
    probA:a=>rgba('--prob-rgb',a), wallA:a=>rgba('--wall-rgb',a),
    ink:rgb('--ink-rgb'), inkA:a=>rgba('--ink-rgb',a),
    bg:g('--plot-bg'), grid:g('--plot-grid'), axis:g('--plot-axis'),
    dark:g('--is-dark')==='1'
  };
}

/* ─────────── plotting helper ─────────── */
function Plot(ctx,W,H,pad){
  pad=Object.assign({l:34,r:16,t:16,b:26},pad||{});
  const x0=pad.l,x1=W-pad.r,y0=H-pad.b,y1=pad.t;
  let dom=[-1,1],ran=[-1,1];
  const P={
    ctx,W,H,pad,
    dom(a,b){dom=[a,b];return P},
    ran(a,b){ran=[a,b];return P},
    X(x){return x0+(x-dom[0])/(dom[1]-dom[0])*(x1-x0)},
    Y(y){return y0+(y-ran[0])/(ran[1]-ran[0])*(y1-y0)},
    clear(){ctx.clearRect(0,0,W,H)},
    grid(nx,ny){ctx.save();ctx.strokeStyle=C.grid;ctx.lineWidth=1;ctx.beginPath();
      for(let i=0;i<=nx;i++){const x=x0+(x1-x0)*i/nx;ctx.moveTo(x,y1);ctx.lineTo(x,y0);}
      for(let j=0;j<=ny;j++){const y=y1+(y0-y1)*j/ny;ctx.moveTo(x0,y);ctx.lineTo(x1,y);}
      ctx.stroke();ctx.restore();return P},
    axes(opts){opts=opts||{};ctx.save();ctx.strokeStyle=C.axis;ctx.lineWidth=1.4;
      const yz=(ran[0]<0&&ran[1]>0)?P.Y(0):y0;
      ctx.beginPath();ctx.moveTo(x0,y1);ctx.lineTo(x0,y0);ctx.stroke();      // y axis
      ctx.beginPath();ctx.moveTo(x0,yz);ctx.lineTo(x1,yz);ctx.stroke();      // x axis (at y=0)
      ctx.restore();return P},
    curve(fn,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||2;
      if(dash)ctx.setLineDash(dash);ctx.lineJoin='round';ctx.beginPath();
      const N=280;let started=false;
      for(let i=0;i<=N;i++){const x=dom[0]+(dom[1]-dom[0])*i/N;let y=fn(x);
        if(y==null||!isFinite(y)){started=false;continue;}
        y=clamp(y,ran[0]-99,ran[1]+99);const px=P.X(x),py=P.Y(y);
        if(!started){ctx.moveTo(px,py);started=true;}else ctx.lineTo(px,py);}
      ctx.stroke();ctx.restore();return P},
    fill(fn,color,x_a,x_b){ctx.save();ctx.fillStyle=color;ctx.beginPath();
      const a=x_a==null?dom[0]:x_a,b=x_b==null?dom[1]:x_b,N=160;
      ctx.moveTo(P.X(a),P.Y(0));
      for(let i=0;i<=N;i++){const x=a+(b-a)*i/N;let y=fn(x);if(!isFinite(y))y=0;
        ctx.lineTo(P.X(x),P.Y(clamp(y,ran[0],ran[1])));}
      ctx.lineTo(P.X(b),P.Y(0));ctx.closePath();ctx.fill();ctx.restore();return P},
    vline(x,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;
      if(dash)ctx.setLineDash(dash);ctx.beginPath();ctx.moveTo(P.X(x),y1);ctx.lineTo(P.X(x),y0);
      ctx.stroke();ctx.restore();return P},
    hline(y,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;
      if(dash)ctx.setLineDash(dash);ctx.beginPath();ctx.moveTo(x0,P.Y(y));ctx.lineTo(x1,P.Y(y));
      ctx.stroke();ctx.restore();return P},
    seg(ax,ay,bx,by,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;
      if(dash)ctx.setLineDash(dash);ctx.beginPath();ctx.moveTo(P.X(ax),P.Y(ay));ctx.lineTo(P.X(bx),P.Y(by));
      ctx.stroke();ctx.restore();return P},
    dot(x,y,color,r){ctx.save();ctx.fillStyle=color;ctx.beginPath();
      ctx.arc(P.X(x),P.Y(y),r||3,0,7);ctx.fill();ctx.restore();return P},
    label(x,y,txt,color,opts){opts=opts||{};ctx.save();ctx.fillStyle=color||C.inkA(.75);
      ctx.font=(opts.b?'600 ':'')+(opts.sz||11)+"px 'JetBrains Mono',monospace";
      ctx.textAlign=opts.align||'left';ctx.textBaseline=opts.base||'alphabetic';
      ctx.fillText(txt,opts.px?x:P.X(x),opts.py?y:P.Y(y));ctx.restore();return P},
    text(px,py,txt,color,opts){opts=opts||{};ctx.save();ctx.fillStyle=color||C.inkA(.75);
      ctx.font=(opts.b?'600 ':'')+(opts.sz||11)+"px 'JetBrains Mono',monospace";
      ctx.textAlign=opts.align||'left';ctx.textBaseline=opts.base||'top';
      ctx.fillText(txt,px,py);ctx.restore();return P}
  };
  return P;
}

/* ══════════════ DIAGRAM REGISTRY — all drawn from real formulas ══════════════ */
const erf=x=>{const s=x<0?-1:1;x=Math.abs(x);const t=1/(1+.3275911*x);
  const y=1-(((((1.061405429*t-1.453152027)*t)+1.421413741)*t-.284496736)*t+.254829592)*t*Math.exp(-x*x);
  return s*y;};

const FIGS={
  /* Module I — double slit single-particle buildup */
  slit:{anim:true,ar:.52,restart:true,
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:16,r:16,t:14,b:22});P.clear();
      // fringe intensity  I(x) ∝ cos²(kx) · sinc²  (two-slit + single-slit envelope)
      const I=x=>{const c=Math.cos(3.1*x);const s=x===0?1:Math.sin(1.05*x)/(1.05*x);return c*c*s*s;};
      const dom=6;P.dom(-dom,dom).ran(0,1.05);
      // accumulate points into st.pts
      st.pts=st.pts||[];st.k=st.k||0;
      const target=Math.min(1400,Math.floor(st.t*260));
      while(st.k<target){
        // rejection sample from I(x)
        let x,y;do{x=(Math.random()*2-1)*dom;y=Math.random();}while(y>I(x));
        st.pts.push([x,Math.random()]);st.k++;
      }
      // detector band
      const by0=H*.60,by1=H*.93;
      ctx.fillStyle=C.dark?'#05060a':'#0a0a10';ctx.fillRect(0,by0,W,by1-by0);
      for(const p of st.pts){const px=P.X(p[0]);const py=by0+(by1-by0)*p[1];
        ctx.fillStyle=C.probA(.85);ctx.fillRect(px,py,1.5,1.5);}
      // draw envelope curve in upper region
      const uy0=H*.10,uy1=H*.5;
      ctx.save();ctx.strokeStyle=C.prob;ctx.lineWidth=2;ctx.beginPath();
      for(let i=0;i<=240;i++){const x=-dom+2*dom*i/240;const px=16+(W-32)*i/240;
        const py=uy1-(uy1-uy0)*I(x);i?ctx.lineTo(px,py):ctx.moveTo(px,py);}
      ctx.stroke();ctx.restore();
      P.text(20,10,'|Ψ|²  intensity',C.probA(.8),{sz:10.5,b:1});
      P.text(20,by0-16,st.k+' electrons detected',C.inkA(.7),{sz:10.5});
      if(st.t>6){st.t=0;st.pts=[];st.k=0;} // loop
    }},

  /* complex wavefunction: Re, Im, |Ψ| */
  psiC:{anim:true,ar:.5,
    draw(ctx,W,H,st){const P=Plot(ctx,W,H,{});P.clear();P.dom(-5,5).ran(-1.15,1.15).grid(10,4).axes();
      const w=st.t*1.3,a=.32,k=2.4;
      const env=x=>Math.exp(-a*x*x);
      P.fill(x=>env(x),C.probA(.10));P.fill(x=>-env(x),C.probA(.10));
      P.curve(x=>env(x),C.probA(.5),1.4,[4,3]);P.curve(x=>-env(x),C.probA(.5),1.4,[4,3]);
      P.curve(x=>env(x)*Math.cos(k*x-w),C.pos,2.2);
      P.curve(x=>env(x)*Math.sin(k*x-w),C.neg,2.2);
      P.label(4.7,1.0,'|Ψ|',C.probA(.8),{align:'right',sz:10.5});
      P.text(8,10,'Re Ψ',C.pos,{sz:10.5,b:1});P.text(48,10,'Im Ψ',C.neg,{sz:10.5,b:1});
    }},

  /* Born rule: |Ψ|² with shaded P[a,b] */
  born:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{});P.clear();P.dom(-5,5).ran(0,.62).grid(10,3).axes();
      const rho=x=>Math.exp(-((x-.6)*(x-.6))/1.4)*.55/1.06;
      P.fill(rho,C.probA(.14));
      P.fill(rho,C.probA(.4),-.2,2.2);
      P.curve(rho,C.prob,2.4);
      P.vline(-.2,C.probA(.6),1.3,[3,3]);P.vline(2.2,C.probA(.6),1.3,[3,3]);
      P.label(-.2,.6,'a',C.probA(.85),{align:'center',sz:11,b:1});
      P.label(2.2,.6,'b',C.probA(.85),{align:'center',sz:11,b:1});
      P.text(W/2-30,H*.42,'P = ∫|Ψ|²dx',C.probA(.9),{sz:11,b:1});
    }},

  /* falling-rock classical density ρ(x)=1/(2√(hx)) */
  rock:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{});P.clear();P.dom(0,1).ran(0,3.2).grid(5,4).axes();
      const rho=x=>x<=0.003?null:1/(2*Math.sqrt(x));
      P.fill(x=>x<=0.003?0:Math.min(1/(2*Math.sqrt(x)),3.2),C.probA(.12));
      P.curve(rho,C.prob,2.4);
      P.vline(1/3,C.pos,1.4,[4,3]);P.label(1/3,3.15,'⟨x⟩=h/3',C.pos,{align:'center',sz:10,b:1});
      P.text(8,10,'ρ(x)=1/(2√(hx))',C.probA(.85),{sz:10.5,b:1});
      P.label(1,-.02,'x=h',C.inkA(.6),{align:'right',base:'top',sz:10});
    }},

  /* uncertainty: Fourier pair, narrow x ↔ wide k */
  unc:{anim:true,ar:.46,
    draw(ctx,W,H,st){readPalette();
      const half=W/2;
      // left: position gaussian of width s ; right: momentum width 1/(2s)
      const s=.55+.42*Math.sin(st.t*.9); // oscillate squeeze
      const gx=(ctx,x0,title,fn,col)=>{const P=Plot(ctx,x0.w?0:0,0);};
      ctx.clearRect(0,0,W,H);
      const panel=(ox,dom,fn,col,lab)=>{const P=Plot(ctx,half,H,{l:14,r:14,t:14,b:22});
        ctx.save();ctx.translate(ox,0);
        P.dom(-dom,dom).ran(0,1.1).grid(6,3).axes();
        P.fill(x=>fn(x),col.replace('rgb','rgba').replace(')',',.14)'));
        P.curve(fn,col,2.3);P.text(10,10,lab,col,{sz:10.5,b:1});
        ctx.restore();};
      panel(0,4,x=>Math.exp(-x*x/(2*s*s)),C.pos,'|Ψ(x)|²  σₓ');
      // divider
      ctx.save();ctx.strokeStyle=C.grid;ctx.lineWidth=1;ctx.beginPath();ctx.moveTo(half,8);ctx.lineTo(half,H-8);ctx.stroke();ctx.restore();
      const sp=1/(2*s);
      ctx.save();ctx.translate(half,0);
      const P2=Plot(ctx,half,H,{l:14,r:14,t:14,b:22});
      P2.dom(-4,4).ran(0,1.1).grid(6,3).axes();
      P2.fill(k=>Math.exp(-k*k/(2*sp*sp)),C.negA(.14));P2.curve(k=>Math.exp(-k*k/(2*sp*sp)),C.neg,2.3);
      P2.text(10,10,'|Φ(p)|²  σₚ',C.neg,{sz:10.5,b:1});
      ctx.restore();
      P2.text(half-52,H-16,'σₓσₚ = ℏ/2',C.probA(.9),{sz:10.5,b:1});
    }},

  /* infinite square well: ψ_n stacked on energy ladder E∝n² */
  isw:{ar:.62,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:40,r:16,t:14,b:24});P.clear();
      const Emax=17;P.dom(-.18,1.18).ran(0,Emax);
      // walls
      ctx.save();ctx.fillStyle=C.wallA(.13);ctx.fillRect(P.X(-.18),P.Y(Emax),P.X(0)-P.X(-.18),P.Y(0)-P.Y(Emax));
      ctx.fillRect(P.X(1),P.Y(Emax),P.X(1.18)-P.X(1),P.Y(0)-P.Y(Emax));ctx.restore();
      P.vline(0,C.wall,2.5);P.vline(1,C.wall,2.5);
      for(let n=1;n<=4;n++){const E=n*n;const amp=1.35;
        P.hline(E,C.inkA(.25),1,[3,4]);
        P.label(-.15,E,'E'+n,C.inkA(.6),{sz:10,base:'middle'});
        const col=n%2? C.pos:C.neg;
        ctx.save();ctx.strokeStyle=col;ctx.lineWidth=2;ctx.beginPath();
        for(let i=0;i<=160;i++){const x=i/160;const y=E+amp*Math.sin(n*Math.PI*x);
          const px=P.X(x),py=P.Y(y);i?ctx.lineTo(px,py):ctx.moveTo(px,py);}
        ctx.stroke();ctx.restore();}
      P.label(1.13,15.5,'E∝n²',C.pos,{align:'right',sz:10,b:1});
    }},

  /* |ψ_n|² densities */
  iswD:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:20,r:16,t:14,b:22});P.clear();P.dom(0,1).ran(0,2.4);
      P.vline(0,C.wall,2.2);P.vline(1,C.wall,2.2);P.axes();
      const cols=[C.pos,C.neg,C.prob];
      [1,2,3].forEach((n,i)=>{const f=x=>2*Math.pow(Math.sin(n*Math.PI*x),2);
        P.curve(f,cols[i],2.1);});
      P.text(8,10,'|ψ₁|²',cols[0],{sz:10,b:1});P.text(52,10,'|ψ₂|²',cols[1],{sz:10,b:1});
      P.text(96,10,'|ψ₃|²',cols[2],{sz:10,b:1});
    }},

  /* superposition breathing |ψ1+ψ2|²(t) */
  super:{anim:true,ar:.5,
    draw(ctx,W,H,st){const P=Plot(ctx,W,H,{l:20,r:16,t:14,b:22});P.clear();P.dom(0,1).ran(0,2.6);
      P.vline(0,C.wall,2.2);P.vline(1,C.wall,2.2);P.axes();
      const w=st.t*1.6; // 3ω t compressed
      const p1=x=>Math.sqrt(2)*Math.sin(Math.PI*x),p2=x=>Math.sqrt(2)*Math.sin(2*Math.PI*x);
      const rho=x=>.5*(p1(x)**2)+.5*(p2(x)**2)+p1(x)*p2(x)*Math.cos(w);
      P.fill(rho,C.probA(.14));P.curve(rho,C.prob,2.4);
      // centroid marker
      let num=0,den=0;for(let i=1;i<160;i++){const x=i/160,r=rho(x);num+=x*r;den+=r;}
      const xc=num/den;P.vline(xc,C.pos,1.6);P.dot(xc,0,C.pos,4);
      P.text(8,10,'|Ψ(x,t)|² breathes at ω=(E₂−E₁)/ℏ',C.probA(.85),{sz:10,b:1});
      P.label(xc,2.5,'⟨x⟩',C.pos,{align:'center',sz:10,b:1});
    }},

  /* node theorem */
  nodes:{ar:.6,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:20,r:16,t:12,b:20});P.clear();P.dom(0,1).ran(0,9);
      P.vline(0,C.wall,2);P.vline(1,C.wall,2);
      for(let n=1;n<=4;n++){const base=2*n-1;const col=n%2?C.pos:C.neg;
        P.hline(base,C.inkA(.18),1,[2,4]);
        ctx.save();ctx.strokeStyle=col;ctx.lineWidth=2;ctx.beginPath();
        for(let i=0;i<=160;i++){const x=i/160;const y=base+.85*Math.sin(n*Math.PI*x);
          const px=P.X(x),py=P.Y(y);i?ctx.lineTo(px,py):ctx.moveTo(px,py);}
        ctx.stroke();ctx.restore();
        // mark nodes
        for(let m=1;m<n;m++){P.dot(m/n,base,C.wall,3.2);}
        P.label(.02,base+1.1,'n='+n+' · '+(n-1)+' nodes',C.inkA(.6),{sz:9.5});}
    }},

  /* phase vs group velocity */
  phasegroup:{anim:true,ar:.42,
    draw(ctx,W,H,st){const P=Plot(ctx,W,H,{});P.clear();P.dom(-6,6).ran(-1.2,1.2).axes();
      const t=st.t,vg=1.4,vp=.7,k0=5,dk=1.1;
      const env=x=>Math.exp(-Math.pow((x-vg*t%12-6+((vg*t%12>6)?12:0)),2)*0); // simpler below
      // beat of two waves
      const f=x=>Math.cos((k0+dk)*x-(k0+dk)*vp*3*t)+Math.cos((k0-dk)*x-(k0-dk)*vp*3*t);
      P.curve(x=>f(x)/2,C.pos,1.7);
      // envelope
      P.curve(x=>Math.cos(dk*x-dk*vg*3*t),C.negA(.55),1.4,[5,3]);
      P.curve(x=>-Math.cos(dk*x-dk*vg*3*t),C.negA(.55),1.4,[5,3]);
      P.text(8,10,'carrier → vₚ',C.pos,{sz:10,b:1});P.text(8,24,'envelope → v_g = 2vₚ',C.neg,{sz:10,b:1});
    }},

  /* free-particle Gaussian packet spreading */
  packet:{anim:true,ar:.5,restart:true,
    draw(ctx,W,H,st){const P=Plot(ctx,W,H,{});P.clear();P.dom(-7,7).ran(0,1.05).grid(7,3).axes();
      const tau=st.t*0.9; const w=1/Math.sqrt(1+tau*tau); // width factor
      const rho=x=>w*Math.exp(-w*w*x*x*1.0);
      P.fill(rho,C.probA(.14));P.curve(rho,C.prob,2.4);
      // ghost of t=0
      P.curve(x=>Math.exp(-x*x),C.inkA(.22),1.3,[4,3]);
      P.text(8,10,'σₓ(t)=σ₀√(1+(ℏt/2mσ₀²)²) — packet spreads, area stays 1',C.probA(.8),{sz:9.5,b:1});
      if(st.t>7)st.t=0;
    }},

  /* potential step E>V0 */
  stepHigh:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{});P.clear();P.dom(-6,6).ran(-1.6,1.6);
      // potential
      ctx.save();ctx.fillStyle=C.wallA(.12);ctx.fillRect(P.X(0),P.Y(1.6),P.X(6)-P.X(0),P.Y(-1.6)-P.Y(1.6));ctx.restore();
      P.seg(-6,-1.35,0,-1.35,C.wall,2);P.seg(0,-.6,6,-.6,C.wall,2);P.seg(0,-1.35,0,-.6,C.wall,2);
      P.label(-5.5,-1.1,'V=0',C.wallA(.8),{sz:10});P.label(3,-.35,'V₀',C.wallA(.8),{sz:10});
      P.axes();
      const k1=2.4,k2=1.5;
      P.curve(x=>x<0?Math.cos(k1*x):null,C.pos,2.2);          // incident+refl (schematic)
      P.curve(x=>x>=0?.72*Math.cos(k2*x):null,C.neg,2.2);      // transmitted longer λ
      P.text(8,10,'E>V₀ · partial reflection, longer λ beyond step',C.inkA(.7),{sz:9.5,b:1});
      P.label(-4,1.3,'k₁',C.pos,{sz:10,b:1});P.label(3.5,1.3,'k₂<k₁',C.neg,{sz:10,b:1});
    }},

  /* potential step E<V0 evanescent */
  stepLow:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{});P.clear();P.dom(-6,6).ran(-1.5,1.5);
      ctx.save();ctx.fillStyle=C.wallA(.12);ctx.fillRect(P.X(0),P.Y(1.5),P.X(6)-P.X(0),P.Y(-1.5)-P.Y(1.5));ctx.restore();
      P.seg(-6,-1.25,0,-1.25,C.wall,2);P.seg(0,-.2,6,-.2,C.wall,2);P.seg(0,-1.25,0,-.2,C.wall,2);
      P.axes();
      const k1=2.6,kap=.9;
      P.curve(x=>x<0?Math.cos(k1*x):null,C.pos,2.2);
      P.curve(x=>x>=0?Math.cos(0)*Math.exp(-kap*x):null,C.neg,2.4);
      P.curve(x=>x>=0?Math.exp(-kap*x):null,C.negA(.4),1.3,[4,3]);
      P.text(8,10,'E<V₀ · total reflection, exponential tail  δ=1/κ',C.inkA(.7),{sz:9.5,b:1});
    }},

  /* barrier tunneling wavefunction */
  barrier:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{});P.clear();P.dom(-6,6).ran(-1.5,1.5);
      const a=1.6;
      ctx.save();ctx.fillStyle=C.wallA(.13);ctx.fillRect(P.X(-a),P.Y(1.5),P.X(a)-P.X(-a),P.Y(-1.5)-P.Y(1.5));ctx.restore();
      P.seg(-6,-1.25,-a,-1.25,C.wall,2);P.seg(-a,-.15,a,-.15,C.wall,2);P.seg(a,-1.25,6,-1.25,C.wall,2);
      P.seg(-a,-1.25,-a,-.15,C.wall,2);P.seg(a,-.15,a,-1.25,C.wall,2);
      P.axes();
      const k=2.6,kap=1.0;
      P.curve(x=>x<-a?Math.cos(k*x):null,C.pos,2.1);
      const A0=Math.cos(-k*a);
      P.curve(x=>(x>=-a&&x<=a)?A0*Math.exp(-kap*(x+a)):null,C.neg,2.3);
      const Ftail=A0*Math.exp(-kap*2*a);
      P.curve(x=>x>a?Ftail*Math.cos(k*(x-a))/Math.abs(A0)*Math.abs(A0):null,C.prob,2.1);
      P.text(8,10,'incident (gold) → decays in barrier (cyan) → transmitted (violet, smaller)',C.inkA(.7),{sz:9,b:1});
    }},

  /* T(E) transmission curve: barrier resonances + tunneling */
  transE:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:34,r:16,t:16,b:26});P.clear();P.dom(0,4).ran(0,1.08).grid(8,4).axes();
      const lam=6; // a√(2mV0)/ħ
      const T=eps=>{ if(eps<1){const s=Math.sinh(lam*Math.sqrt(1-eps));return 1/(1+ s*s/(4*eps*(1-eps)));}
        if(Math.abs(eps-1)<1e-4)return 1/(1+lam*lam/4);
        const s=Math.sin(lam*Math.sqrt(eps-1));return 1/(1+ s*s/(4*eps*(eps-1)));};
      P.vline(1,C.wallA(.6),1.4,[4,3]);P.label(1,1.06,'E=V₀',C.wall,{align:'center',sz:10,b:1});
      P.fill(x=>x<1?T(x):0,C.negA(.10),0,1);
      P.curve(T,C.prob,2.4);
      P.label(.5,.2,'tunnelling',C.neg,{align:'center',sz:10});
      P.label(2.6,1.0,'resonances T=1',C.pos,{align:'center',sz:10,b:1});
      P.text(4,-14,'E/V₀',C.inkA(.6),{align:'right',sz:10});
    }},

  /* delta well bound state */
  delta:{ar:.44,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{});P.clear();P.dom(-5,5).ran(-.15,1.15).axes();
      const kap=1.1;const psi=x=>Math.exp(-kap*Math.abs(x));
      P.fill(x=>psi(x)*psi(x),C.probA(.12));
      P.curve(psi,C.pos,2.4);
      P.curve(x=>psi(x)*psi(x),C.prob,1.8,[4,3]);
      P.vline(0,C.wallA(.7),1.6);P.label(0,1.1,'−αδ(x)',C.wall,{align:'center',sz:10,b:1});
      P.text(8,10,'ψ=√κ e^{−κ|x|}, cusp at 0 · E=−mα²/2ℏ²',C.inkA(.7),{sz:9.5,b:1});
    }},

  /* Ehrenfest — ⟨x⟩(t) sinusoid like classical */
  ehr:{anim:true,ar:.4,
    draw(ctx,W,H,st){const P=Plot(ctx,W,H,{});P.clear();P.dom(0,12).ran(-1.2,1.2).grid(6,4).axes();
      P.curve(x=>Math.cos(x-0),C.inkA(.25),1.3,[4,3]);
      const tp=(st.t*1.2)%12;
      P.curve(x=>x<=tp?Math.cos(x):null,C.pos,2.3);
      P.dot(tp,Math.cos(tp),C.pos,4.5);
      P.text(8,10,"⟨x⟩(t) obeys m d²⟨x⟩/dt² = −⟨V'⟩  (Ehrenfest)",C.inkA(.7),{sz:9.5,b:1});
    }}
};

/* ══════════════ canvas lifecycle ══════════════ */
const liveFigs=[];
function setupFig(cv){
  const name=cv.dataset.fig;const F=FIGS[name];if(!F)return;
  const wrap=cv.parentElement;
  const st={t:0,playing:F.anim?true:false,pts:null,k:0,lastReset:0};
  const rec={cv,name,F,st,visible:false};
  function size(){const cssW=cv.clientWidth||wrap.clientWidth||0;
    if(!cssW)return;                       // collapsed card: size it when revealed
    const dpr=Math.min(2,window.devicePixelRatio||1);
    const cssH=Math.round(cssW*F.ar);
    cv.width=cssW*dpr;cv.height=cssH*dpr;cv.style.height=cssH+'px';
    const ctx=cv.getContext('2d');ctx.setTransform(dpr,0,0,dpr,0,0);
    rec.W=cssW;rec.H=cssH;render();}
  function render(){readPalette();const ctx=cv.getContext('2d');
    try{F.draw(ctx,rec.W,rec.H,st);}catch(e){/*noop*/}}
  rec.size=size;rec.render=render;
  // controls for animated figs
  if(F.anim){
    const bar=document.createElement('div');bar.className='figbar';
    const play=document.createElement('button');play.textContent='❚❚';play.title='Pause';
    play.onclick=()=>{st.playing=!st.playing;play.textContent=st.playing?'❚❚':'▶';};
    const rep=document.createElement('button');rep.textContent='↺';rep.title='Restart';
    rep.onclick=()=>{st.t=0;st.pts=null;st.k=0;render();};
    bar.appendChild(play);bar.appendChild(rep);wrap.appendChild(bar);
  }
  liveFigs.push(rec);
  const io=new IntersectionObserver(es=>{es.forEach(e=>{rec.visible=e.isIntersecting;});},{threshold:.12});
  io.observe(cv);
  size();
  window.addEventListener('resize',debounce(size,180));
}
let lastT=performance.now();
function loop(now){const dt=Math.min(.05,(now-lastT)/1000);lastT=now;
  for(const r of liveFigs){if(r.F.anim&&r.st.playing&&r.visible){r.st.t+=dt;r.render();}}
  requestAnimationFrame(loop);}
requestAnimationFrame(loop);
function debounce(f,ms){let h;return(...a)=>{clearTimeout(h);h=setTimeout(()=>f(...a),ms);};}

/* ══════════════ progress state + Firebase sync ══════════════ */
const DB='https://task-dominion-default-rtdb.asia-southeast1.firebasedatabase.app';
const APP='ssc_qm_mod12';
const LS='qm12_progress_v1', LSID='qm12_syncid_v1';
let state={done:{},plan:{},conf:{},open:{},updated:0};
let syncId=localStorage.getItem(LSID)||'';
function loadLocal(){try{const j=JSON.parse(localStorage.getItem(LS));if(j)state=Object.assign(state,j);}catch(e){}}
function saveLocal(){state.updated=Date.now();localStorage.setItem(LS,JSON.stringify(state));}
let pushT;
function persist(){saveLocal();paintProgress();if(syncId){clearTimeout(pushT);pushT=setTimeout(push,700);}}
function push(){fetch(`${DB}/${APP}/${encodeURIComponent(syncId)}.json`,{method:'PUT',
  body:JSON.stringify(state)}).then(()=>toast('Synced ✓')).catch(()=>toast('Offline — saved locally'));}
function pull(cb){fetch(`${DB}/${APP}/${encodeURIComponent(syncId)}.json`).then(r=>r.json())
  .then(d=>{if(d&&(!state.updated||d.updated>state.updated)){state=Object.assign(state,d);saveLocal();}cb&&cb();})
  .catch(()=>cb&&cb());}
function toast(m){const s=$('#sync');$('#synctxt').textContent=m;s.classList.add('show');
  clearTimeout(toast._h);toast._h=setTimeout(()=>s.classList.remove('show'),2200);}

/* ══════════════ render: nested collapsible Module ▸ Section ▸ Topic ══════════════ */
let TREE=[];                       // [{id,secs:[{id,title,topics:[{id,title}]}]}]
const SEC=Object.create(null);

const el=h=>{const d=document.createElement('div');d.innerHTML=h.trim();return d.firstElementChild;};

function render(){
  const host=$('#stations');host.innerHTML='';TREE=[];
  MODULES.forEach((m,mi)=>{
    const modEl=el(`<section class="mod ${m.cls||('m'+mi)}" id="${m.id}">
      <div class="mh"><span class="caret">▶</span>
        <button class="tick" data-tick="${m.id}" title="Mark whole module done">✓</button>
        <div class="mt"><b>${m.name}</b><small>${m.sub||''}</small></div>
        <span class="cnt" data-cnt="${m.id}"></span></div>
      <div class="mbody"></div></section>`);
    const mbody=$('.mbody',modEl);
    const node={id:m.id,secs:[]};

    m.stations.forEach(sid=>{
      const st=STATIONS.find(x=>x.id===sid);if(!st)return;
      const title=(st.short||st.title).replace(/<[^>]+>/g,'');
      const secEl=el(`<div class="unit" id="${sid}">
        <div class="uh"><span class="caret">▶</span>
          <button class="tick" data-tick="${sid}" title="Mark section done">✓</button>
          <h3>${title}</h3>
          <span class="cnt" data-cnt="${sid}"></span>
          <span class="est">${st.est||''}</span></div>
        <div class="ubody"></div></div>`);
      const ubody=$('.ubody',secEl);
      const sec={id:sid,title,topics:[]};

      /* split the authored body at each topic marker into its own collapsible card */
      const tmp=document.createElement('div');tmp.innerHTML=st.body;
      let sink=ubody;
      [...tmp.childNodes].forEach(n=>{
        if(n.nodeType===1&&n.classList&&n.classList.contains('topic')&&n.hasAttribute('data-tp')){
          const i=sec.topics.length,tid=sid+'__t'+i;
          const h=n.querySelector('h3');
          const tHTML=h?h.innerHTML:'Topic', tTxt=(h?h.textContent:'Topic').trim();
          const tEl=el(`<div class="tunit" id="${tid}">
            <div class="th"><span class="caret">▶</span>
              <button class="tick" data-tick="${tid}" title="Mark topic done">✓</button>
              <h4>${tHTML}</h4></div>
            <div class="tbody"></div></div>`);
          ubody.appendChild(tEl);
          sink=$('.tbody',tEl);
          sec.topics.push({id:tid,title:tTxt});
        }else{
          sink.appendChild(n);            // moves the node out of tmp
        }
      });
      mbody.appendChild(secEl);node.secs.push(sec);SEC[sid]=sec;
    });
    host.appendChild(modEl);TREE.push(node);
  });

  migrateOldProgress();
  wireLadders();wireChecks();wirePlan();wireTicks();wireFolds();
  $$('canvas[data-fig]').forEach(setupFig);
  restoreFolds();
  mj(host,()=>{resizeVisibleFigs();});
  paintAll();
}

/* ---- leaves: a section's topics, or the section itself when it has none ---- */
function leavesOfSec(sec){return sec.topics.length?sec.topics.map(t=>t.id):[sec.id];}
function leavesOfMod(mod){return mod.secs.flatMap(leavesOfSec);}
function allLeaves(){return TREE.flatMap(leavesOfMod);}
function stateOf(ids){const n=ids.filter(i=>state.done[i]).length;
  return {n,total:ids.length,all:ids.length>0&&n===ids.length,some:n>0};}

function migrateOldProgress(){
  let changed=false;
  TREE.forEach(m=>m.secs.forEach(sec=>{
    if(sec.topics.length&&state.done[sec.id]&&!sec.topics.some(t=>state.done[t.id])){
      sec.topics.forEach(t=>state.done[t.id]=true);changed=true;}
  }));
  if(changed)saveLocal();
}

/* ---- ticking: parent cascades down, parent state derives from children ---- */
function setLeaves(ids,on){ids.forEach(i=>{if(on)state.done[i]=true;else delete state.done[i];});}
function toggleNode(id){
  const mod=TREE.find(m=>m.id===id);
  if(mod){const L=leavesOfMod(mod);setLeaves(L,!stateOf(L).all);}
  else{const sec=SEC[id];
    if(sec){const L=leavesOfSec(sec);setLeaves(L,!stateOf(L).all);}
    else setLeaves([id],!state.done[id]);}
  persist();paintAll();
}
let _ticksWired=false;
function wireTicks(){
  if(_ticksWired)return;_ticksWired=true;
  document.addEventListener('click',e=>{
    const t=e.target.closest('[data-tick]');
    if(t){e.preventDefault();e.stopPropagation();toggleNode(t.dataset.tick);}
  },true);
}

/* ══════════════ folding ══════════════ */
function cardOf(head){return head.parentElement;}
function setOpen(card,open){
  card.classList.toggle('open',open);
  state.open=state.open||{};
  if(open)state.open[card.id]=1;else delete state.open[card.id];
  if(open)setTimeout(()=>resizeFigsIn(card),30);
}
function wireFolds(){
  $$('.mh,.uh,.th').forEach(h=>h.addEventListener('click',e=>{
    if(e.target.closest('[data-tick]'))return;
    const c=cardOf(h);setOpen(c,!c.classList.contains('open'));saveLocal();
  }));
}
function restoreFolds(){
  const o=state.open;
  if(o&&Object.keys(o).length){
    Object.keys(o).forEach(id=>{const c=document.getElementById(id);if(c)c.classList.add('open');});
  }else{
    $$('.mod').forEach(m=>m.classList.add('open'));   // first visit: modules open, rest closed
  }
}
/* canvases inside a collapsed card have zero width — size them when revealed */
function resizeFigsIn(root){
  liveFigs.forEach(r=>{if(root.contains(r.cv)&&r.cv.clientWidth>0)r.size();});
}
function resizeVisibleFigs(){liveFigs.forEach(r=>{if(r.cv.clientWidth>0)r.size();});}

function expandAll(on){
  $$('.mod,.unit,.tunit').forEach(c=>c.classList.toggle('open',on));
  state.open={};
  if(on)$$('.mod,.unit,.tunit').forEach(c=>state.open[c.id]=1);
  saveLocal();
  setTimeout(resizeVisibleFigs,40);
}

/* ══════════════ painting ══════════════ */
function paintTick(el2,st){el2.classList.toggle('on',st.all);
  el2.classList.toggle('part',!st.all&&st.some);}
function paintAll(){
  TREE.forEach(m=>{
    m.secs.forEach(sec=>{
      sec.topics.forEach(t=>{
        const on=!!state.done[t.id];
        $$(`.tick[data-tick="${t.id}"]`).forEach(b=>{b.classList.toggle('on',on);b.classList.remove('part');});
        const card=document.getElementById(t.id);if(card)card.classList.toggle('done',on);
      });
      const ss=stateOf(leavesOfSec(sec));
      $$(`.tick[data-tick="${sec.id}"]`).forEach(b=>paintTick(b,ss));
      const c=$(`[data-cnt="${sec.id}"]`);
      if(c)c.textContent=sec.topics.length?`${ss.n}/${ss.total}`:'';
      const card=document.getElementById(sec.id);if(card)card.classList.toggle('done',ss.all);
    });
    const ms=stateOf(leavesOfMod(m));
    $$(`.tick[data-tick="${m.id}"]`).forEach(b=>paintTick(b,ms));
    const c=$(`[data-cnt="${m.id}"]`);if(c)c.textContent=`${ms.n}/${ms.total}`;
  });
  const ov=stateOf(allLeaves());
  const pct=ov.total?Math.round(ov.n/ov.total*100):0;
  $('#ringpct').textContent=pct+'%';
  $('#ringp').style.strokeDashoffset=88*(1-pct/100);
  $('#pbar').style.width=pct+'%';
}
const paintProgress=paintAll;

function wireLadders(){
  $$('.ladder').forEach(l=>{
    const rungs=$$('.rung',l);
    $$('.peek',l).forEach(p=>p.onclick=e=>{e.target.closest('.rung').classList.remove('hidden');
      mj(e.target.closest('.rung'));});
    const rev=$('.reveal-next',l),all=$('.reveal-all',l);
    if(rev)rev.onclick=()=>{const h=rungs.find(r=>r.classList.contains('hidden'));
      if(h){h.classList.remove('hidden');mj(h);}
      if(!rungs.some(r=>r.classList.contains('hidden')))rev.style.display='none';};
    if(all)all.onclick=()=>{rungs.forEach(r=>r.classList.remove('hidden'));
      if(rev)rev.style.display='none';mj(l);};
  });
}
function wireChecks(){
  $$('.check').forEach(c=>{
    $$('.conf button',c).forEach(b=>b.onclick=()=>{$$('.conf button',c).forEach(x=>x.classList.remove('sel'));
      b.classList.add('sel');state.conf[c.id]=b.dataset.c;persist();
      const r=$('.reveal',c);if(r)r.style.display='inline-block';});
    const rev=$('.reveal',c);if(rev)rev.onclick=()=>{c.classList.add('open');rev.style.display='none';mj(c);};
    if(state.conf[c.id]){const b=$(`.conf button[data-c="${state.conf[c.id]}"]`,c);if(b)b.classList.add('sel');}
  });
}
function wirePlan(){
  $$('.chip[data-plan]').forEach(ch=>{ch.onclick=()=>{const k=ch.dataset.plan;
    state.plan[k]=!state.plan[k];ch.classList.toggle('done',state.plan[k]);persist();};
    if(state.plan[ch.dataset.plan])ch.classList.add('done');});
}

/* ══════════════ chrome: expand-all, sticky header, download ══════════════ */
function initNav(){
  let allOpen=false;
  const btn=$('#expandall');
  btn.onclick=()=>{allOpen=!allOpen;expandAll(allOpen);
    btn.textContent=allOpen?'⇡':'⇕';btn.title=allOpen?'Collapse everything':'Expand everything';};
  addEventListener('scroll',()=>{$('#top').classList.toggle('scrolled',scrollY>10);},{passive:true});
  initDownload();
}

/* Download a pristine copy. Hidden when already opened as a local file. */
function initDownload(){
  const btn=$('#dl');
  if(location.protocol==='file:'){btn.hidden=true;return;}
  btn.hidden=false;
  btn.onclick=async()=>{
    btn.textContent='…';
    try{
      const res=await fetch(location.href,{cache:'no-store'});
      const txt=await res.text();
      const url=URL.createObjectURL(new Blob([txt],{type:'text/html'}));
      const a=document.createElement('a');
      a.href=url;a.download='QM_1.html';document.body.appendChild(a);a.click();
      a.remove();setTimeout(()=>URL.revokeObjectURL(url),4000);
      toast('Downloaded QM_1.html');
    }catch(err){toast('Download blocked — use your browser’s Save Page');}
    btn.textContent='⤓';
  };
}

/* ══════════════ theme ══════════════ */
function initTheme(){
  const KEY='qm12_theme';const btn=$('#theme');
  const apply=m=>{if(m==='auto')document.documentElement.removeAttribute('data-theme');
    else document.documentElement.setAttribute('data-theme',m);
    btn.textContent=m==='dark'?'☾':m==='light'?'☀':'◐';
    setTimeout(()=>liveFigs.forEach(r=>r.render&&r.render()),40);};
  let m=localStorage.getItem(KEY)||'auto';apply(m);
  btn.onclick=()=>{m=m==='auto'?'light':m==='light'?'dark':'auto';localStorage.setItem(KEY,m);apply(m);};
  matchMedia('(prefers-color-scheme:dark)').addEventListener('change',()=>{if(m==='auto')apply('auto');});
}

/* ══════════════ sync modal ══════════════ */
function initSync(){
  const modal=$('#idmodal'),inp=$('#idinput'),status=$('#idstatus');
  const open=()=>{inp.value=syncId||'';status.textContent=syncId?('Connected as “'+syncId+'”'):'';modal.classList.add('show');inp.focus();};
  $('#cloud').onclick=open;
  $('#idclose').onclick=()=>modal.classList.remove('show');
  modal.onclick=e=>{if(e.target===modal)modal.classList.remove('show');};
  $('#idsave').onclick=()=>{const v=inp.value.trim().toLowerCase().replace(/[^a-z0-9_\-]/g,'-').slice(0,40);
    if(!v){status.textContent='Enter a code first.';return;}
    syncId=v;localStorage.setItem(LSID,v);status.textContent='Connecting…';
    pull(()=>{migrateOldProgress();paintAll();status.textContent='Synced as “'+v+'” ✓';toast('Synced ✓');
      setTimeout(()=>modal.classList.remove('show'),800);push();});};
  if(syncId)$('#cloud').style.color='var(--pos)';
}

/* ══════════════ boot ══════════════ */
function boot(){
  loadLocal();readPalette();render();initNav();initTheme();initSync();
  if(syncId)pull(()=>{migrateOldProgress();paintAll();});
  // deep link
  if(location.hash){const el=$(location.hash);if(el)setTimeout(()=>el.scrollIntoView(),300);}
}
if(document.readyState!=='loading')boot();else document.addEventListener('DOMContentLoaded',boot);
})();
