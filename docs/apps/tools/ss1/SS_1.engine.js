/* ══════════════════════════════════════════════════════════════════
   Solid State · Modules I–II — study-journey engine
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
function capBlock(ctx,lines){
  ctx.save();ctx.textBaseline='top';ctx.textAlign='left';let y=7;
  lines.forEach((L,i)=>{if(!L)return;
    if(i===0){ctx.font="600 11.5px 'Sora',Georgia,serif";}
    else ctx.font="10.5px 'Fira Mono',monospace";
    ctx.fillStyle=L[1]||C.ink;ctx.fillText(L[0],10,y);y+=i===0?17:14;});
  ctx.restore();
}
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


/* ─────── helpers for the step-by-step construction figures ───────
   clipHalf : cut a convex polygon with the half-plane  n·x <= d
   ws2d     : 2-D Wigner–Seitz cell as the intersection of bisector half-planes
   ISO/ipr  : one fixed axonometric view — c up, b right, a toward the reader
   planeBox : the polygon where  hx+ky+lz = 1  crosses an axis-aligned box
   fitFrame : isotropic world window that fits a set of points in the plot box   */
function clipHalf(poly,nx,ny,d){
  const out=[];
  for(let i=0;i<poly.length;i++){
    const A=poly[i],B=poly[(i+1)%poly.length];
    const da=nx*A[0]+ny*A[1]-d, db=nx*B[0]+ny*B[1]-d;
    if(da<=1e-12)out.push(A);
    if((da<-1e-12&&db>1e-12)||(da>1e-12&&db<-1e-12)){
      const t=da/(da-db);out.push([A[0]+t*(B[0]-A[0]),A[1]+t*(B[1]-A[1])]);}
  }
  return out;
}
function ws2d(neigh,R){
  let poly=[[-R,-R],[R,-R],[R,R],[-R,R]];
  neigh.forEach(g=>{poly=clipHalf(poly,g[0],g[1],(g[0]*g[0]+g[1]*g[1])/2);});
  return poly;
}
const ISO={a:[-.60,-.40],b:[1,0],c:[0,1]};
const ipr=(i,j,k)=>[i*ISO.a[0]+j*ISO.b[0]+k*ISO.c[0], i*ISO.a[1]+j*ISO.b[1]+k*ISO.c[1]];
function boxCorners(lo,hi){const o=[];
  for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)
    o.push([i?hi[0]:lo[0], j?hi[1]:lo[1], k?hi[2]:lo[2]]);
  return o;}
function boxEdges(lo,hi){const c=boxCorners(lo,hi),e=[];
  for(let x=0;x<8;x++)for(let y=x+1;y<8;y++){
    let n=0;for(let d=0;d<3;d++)if(Math.abs(c[x][d]-c[y][d])>1e-9)n++;
    if(n===1)e.push([c[x],c[y]]);}
  return e;}
function planeBox(h,k,l,lo,hi,rhs){
  const R=rhs==null?1:rhs;
  const f=q=>h*q[0]+k*q[1]+l*q[2]-R, pts=[];
  boxEdges(lo,hi).forEach(([A,B])=>{
    const fa=f(A),fb=f(B);
    if(Math.abs(fa)<1e-9){pts.push(A);return;}
    if(Math.abs(fb)<1e-9){pts.push(B);return;}
    if(fa*fb<0){const t=fa/(fa-fb);
      pts.push([A[0]+t*(B[0]-A[0]),A[1]+t*(B[1]-A[1]),A[2]+t*(B[2]-A[2])]);}});
  const u=[];pts.forEach(q=>{if(!u.some(v=>Math.hypot(v[0]-q[0],v[1]-q[1],v[2]-q[2])<1e-7))u.push(q);});
  if(u.length<3)return [];
  const P2=u.map(q=>ipr(q[0],q[1],q[2]));            // order the ring in the picture
  const cx=P2.reduce((a,q)=>a+q[0],0)/P2.length, cy=P2.reduce((a,q)=>a+q[1],0)/P2.length;
  return u.map((q,i)=>({q,th:Math.atan2(P2[i][1]-cy,P2[i][0]-cx)}))
          .sort((a,b)=>a.th-b.th).map(o=>o.q);
}
function fitFrame(P,pw,ph,pts,pad){
  let x0=1e9,x1=-1e9,y0=1e9,y1=-1e9;
  pts.forEach(q=>{x0=Math.min(x0,q[0]);x1=Math.max(x1,q[0]);
                  y0=Math.min(y0,q[1]);y1=Math.max(y1,q[1]);});
  const m=pad==null?.22:pad;x0-=m;x1+=m;y0-=m;y1+=m;
  let w=x1-x0,h=y1-y0;const ap=pw/ph;
  if(w/h<ap){const nw=h*ap,c=(x0+x1)/2;x0=c-nw/2;x1=c+nw/2;}
  else{const nh=w/ap,c=(y0+y1)/2;y0=c-nh/2;y1=c+nh/2;}
  return P.dom(x0,x1).ran(y0,y1);
}
/* the index as it is spoken: 2 → "a/2", 1 → "a", −1 → "−a", 0 → "∞ (parallel)" */
function interceptTxt(ax,n){
  if(!n)return '∞';
  const sgn=n<0?'−':'', m=Math.abs(n);
  return sgn+ax+(m===1?'':'/'+m);
}
function barTxt(n){return (n<0?Math.abs(n)+'̅':''+n);}

/* ══════════════ DIAGRAM REGISTRY — all drawn from real formulas ══════════════ */
const FIGS={

  /* ── M1: 2-D lattice, primitive vectors, primitive vs conventional cell ── */
  lattice:{ar:.56,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:20,r:20,t:18,b:20});P.clear();
      P.dom(-.6,4.4).ran(-.5,2.9);
      const ax=1,ay=0,bx=.42,by=1;                       // oblique primitive vectors
      for(let i=-1;i<=5;i++)for(let j=-1;j<=4;j++){
        const x=i*ax+j*bx,y=i*ay+j*by;
        if(x<-.6||x>4.4||y<-.5||y>2.9)continue;
        P.dot(x,y,C.inkA(.55),3.4);}
      // primitive cell (parallelogram)
      ctx.save();ctx.fillStyle=C.posA(.16);ctx.beginPath();
      ctx.moveTo(P.X(0),P.Y(0));ctx.lineTo(P.X(ax),P.Y(ay));
      ctx.lineTo(P.X(ax+bx),P.Y(ay+by));ctx.lineTo(P.X(bx),P.Y(by));
      ctx.closePath();ctx.fill();ctx.restore();
      P.seg(0,0,ax,ay,C.pos,2.6);P.seg(0,0,bx,by,C.pos,2.6);
      P.seg(ax,ay,ax+bx,ay+by,C.posA(.5),1.4,[4,3]);
      P.seg(bx,by,ax+bx,ay+by,C.posA(.5),1.4,[4,3]);
      P.label(ax*.55,ay*.5-.16,'a',C.pos,{b:1,sz:12});
      P.label(bx*.4-.22,by*.55,'b',C.pos,{b:1,sz:12});
      // a lattice translation T = 2a + b
      P.seg(0,0,2*ax+bx,2*ay+by,C.prob,2.2);
      P.dot(2*ax+bx,2*ay+by,C.prob,4.5);
      P.label(2*ax+bx+.1,2*ay+by,'T = 2a + b',C.prob,{b:1,sz:10.5});
      P.text(10,8,'every point sees an identical environment',C.inkA(.6),{sz:10});
    }},

  /* ── M1: HOW TO DRAW a 2-D Wigner–Seitz cell, one step at a time ── */
  wsdraw:{ar:.66,
    opt:{lat:'oblique'},
    chips:[{sep:'lattice'},
      {label:'Oblique',set:{lat:'oblique'},on:true},{label:'Square',set:{lat:'square'}},
      {label:'Hexagonal',set:{lat:'hex'}},{label:'Centred rect.',set:{lat:'rectc'}}],
    steps:[
      'Plot the lattice and stand on any point — call it O. Every point has the same view, so which one you pick never matters.',
      'Draw a straight line from O to each near neighbour.',
      'Halve every one of those lines — mark the midpoints.',
      'Through each midpoint draw a line at right angles to it: the perpendicular bisector. Anything past that line is nearer to that neighbour than to O.',
      'Keep the patch around O that no bisector cuts off, and shade it. The faint bisectors belong to further-out neighbours — they never reach in, which is how you know when to stop.',
      'That patch is the Wigner–Seitz cell: one lattice point inside, the same area as the primitive cell (faint), and the full symmetry of the lattice — which a skewed primitive cell hides.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:12,r:12,t:26,b:12});P.clear();
      const s=st.step|0;
      const L={oblique:[[1,0],[.44,.86]],square:[[1,0],[0,1]],
               hex:[[1,0],[.5,.8660]],rectc:[[1.3,0],[.65,.52]]}[st.opt.lat||'oblique'];
      const A=L[0],B=L[1],all=[];
      for(let i=-7;i<=7;i++)for(let j=-7;j<=7;j++)all.push([i*A[0]+j*B[0],i*A[1]+j*B[1]]);
      const neigh=all.filter(q=>q[0]||q[1])
        .sort((q,r)=>(q[0]*q[0]+q[1]*q[1])-(r[0]*r[0]+r[1]*r[1])).slice(0,14);
      const cell=ws2d(neigh,20), dmin=Math.hypot(neigh[0][0],neigh[0][1]);
      const shown=neigh.filter(g=>Math.hypot(g[0],g[1])<=dmin*1.55);
      const touches=g=>{const d=(g[0]*g[0]+g[1]*g[1])/2;
        return cell.some(v=>Math.abs(g[0]*v[0]+g[1]*v[1]-d)<1e-6);};
      fitFrame(P,W-24,H-38,shown.concat(cell),.30);
      const poly=(pts,fill,line,w)=>{ctx.save();ctx.beginPath();
        pts.forEach((q,i)=>{const x=P.X(q[0]),y=P.Y(q[1]);i?ctx.lineTo(x,y):ctx.moveTo(x,y);});
        ctx.closePath();if(fill){ctx.fillStyle=fill;ctx.fill();}
        if(line){ctx.strokeStyle=line;ctx.lineWidth=w||2.2;ctx.stroke();}ctx.restore();};
      /* the lattice */
      all.forEach(q=>{if(Math.hypot(q[0],q[1])<dmin*3.6)P.dot(q[0],q[1],C.inkA(.40),3.2);});
      /* the primitive cell, for the equal-area point at the end */
      if(s>=5){
        poly([[0,0],A,[A[0]+B[0],A[1]+B[1]],B],C.negA(.14),C.negA(.55),1.4);
        P.seg(0,0,A[0],A[1],C.neg,2);P.seg(0,0,B[0],B[1],C.neg,2);
        P.label(A[0]*.5,A[1]*.5-dmin*.12,'a',C.neg,{b:1,sz:11.5});
        P.label(B[0]*.5-dmin*.12,B[1]*.5,'b',C.neg,{b:1,sz:11.5});}
      /* the cell itself */
      if(s>=4)poly(cell,C.posA(.20),C.pos,2.4);
      /* lines to the neighbours */
      if(s>=1)shown.forEach(g=>{const on=touches(g);
        P.seg(0,0,g[0],g[1],on?C.inkA(.55):C.inkA(.22),on?1.5:1);});
      /* the bisectors */
      if(s>=3)shown.forEach(g=>{
        const on=touches(g),len=Math.hypot(g[0],g[1]);
        const ux=-g[1]/len,uy=g[0]/len,mx=g[0]/2,my=g[1]/2,R=dmin*2.6;
        P.seg(mx-R*ux,my-R*uy,mx+R*ux,my+R*uy,
              on?C.probA(.85):C.probA(.22),on?1.6:1,[5,4]);});
      /* the midpoints */
      if(s>=2)shown.forEach(g=>P.dot(g[0]/2,g[1]/2,touches(g)?C.prob:C.probA(.35),3));
      P.dot(0,0,C.pos,5.4);
      P.label(0,0,' O',C.pos,{b:1,sz:12});
      const tip=s<=2?'every point beyond a bisector is nearer that neighbour than O'
        :s===3?'the bisector is the border between “mine” and “his”'
        :s===4?cell.length+' sides — the faint bisectors never reach the cell'
        :'area = |a × b| — exactly one lattice point, exactly one primitive cell';
      P.text(10,8,tip,C.inkA(.68),{sz:10,b:s>=4?1:0});
    }},

  /* ── M1: THE GEOMETRY behind “no 5-fold axis”, step by step ── */
  fivefold:{ar:.70,
    opt:{deg:72},
    chips:[{sep:'turn by'},
      {label:'60° · 6-fold',set:{deg:60}},{label:'72° · 5-fold',set:{deg:72},on:true},
      {label:'90° · 4-fold',set:{deg:90}},{label:'120° · 3-fold',set:{deg:120}},
      {label:'180° · 2-fold',set:{deg:180}}],
    steps:[
      'Draw one row of the lattice — points every T. Take two neighbours and call them B and C.',
      'Suppose an n-fold axis stands on every lattice point. Then turning the whole lattice about B by θ = 360°/n has to carry lattice points onto lattice points. Turn B’s outer neighbour: it lands at B′.',
      'Do the same about C, turning the other way. Its outer neighbour lands at C′.',
      'B′ and C′ come out at the same height, so they lie on a row parallel to the original — and every row of a lattice has its points spaced T apart. So B′C′ has to be a whole number of steps: B′C′ = mT (the ticks).',
      'Read the length straight off the picture: B′C′ = T + 2T cos θ, so m = 1 + 2cos θ and cos θ = (m−1)/2. Whole-number m happens only at θ = 60°, 90°, 120°, 180° (and 360°). At 72° it gives 1.618 — a five-fold axis cannot exist.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:14,r:14,t:34,b:14});P.clear();
      const s=st.step|0,deg=st.opt.deg||72,th=deg*Math.PI/180;
      const ct=Math.cos(th),sn=Math.sin(th),m=1+2*ct,ok=Math.abs(m-Math.round(m))<1e-9;
      const Bp=[-ct,sn],Cp=[1+ct,sn];              // images of the two outer neighbours
      fitFrame(P,W-28,H-48,[[-2.2,0],[3.2,0],Bp,Cp,[0,Math.max(sn,.1)+.5],[0,-.45]],.12);
      const row=[];for(let i=-2;i<=3;i++)row.push(i);
      /* the parallel row through B′ and C′, with its own ticks */
      if(s>=3){P.seg(-2.4,sn,3.4,sn,C.inkA(.22),1.2,[6,4]);
        for(let i=-3;i<=4;i++)P.dot(Bp[0]+i,sn,C.inkA(.30),2.6);}
      /* the original row */
      P.seg(-2.4,0,3.4,0,C.inkA(.30),1.4);
      row.forEach(i=>P.dot(i,0,(i===0||i===1)?C.pos:C.inkA(.45),(i===0||i===1)?5:3.4));
      P.label(0,-.2,'B',C.pos,{align:'center',base:'top',b:1,sz:11.5});
      P.label(1,-.2,'C',C.pos,{align:'center',base:'top',b:1,sz:11.5});
      P.label(.5,.07,'T',C.inkA(.6),{align:'center',sz:10});
      /* turning about B */
      if(s>=1){
        P.seg(0,0,-1,0,C.negA(.5),1.4);
        P.seg(0,0,Bp[0],Bp[1],C.neg,2);
        P.dot(Bp[0],Bp[1],C.neg,5);
        P.label(Bp[0],Bp[1]+.08,'B′',C.neg,{align:'center',b:1,sz:11.5});
        ctx.save();ctx.strokeStyle=C.negA(.6);ctx.lineWidth=1.2;ctx.beginPath();
        ctx.arc(P.X(0),P.Y(0),Math.abs(P.X(.42)-P.X(0)),Math.PI,Math.PI+th,false);
        ctx.stroke();ctx.restore();
        P.label(-.42*Math.cos(th/2)-.06,.42*Math.sin(th/2)+.02,'θ',C.neg,{b:1,sz:10.5});}
      /* turning about C */
      if(s>=2){
        P.seg(1,0,2,0,C.probA(.5),1.4);
        P.seg(1,0,Cp[0],Cp[1],C.prob,2);
        P.dot(Cp[0],Cp[1],C.prob,5);
        P.label(Cp[0],Cp[1]+.08,'C′',C.prob,{align:'center',b:1,sz:11.5});
        ctx.save();ctx.strokeStyle=C.probA(.6);ctx.lineWidth=1.2;ctx.beginPath();
        ctx.arc(P.X(1),P.Y(0),Math.abs(P.X(.42)-P.X(0)),-th,0,false);
        ctx.stroke();ctx.restore();
        P.label(1+.42*Math.cos(th/2)+.04,.42*Math.sin(th/2)+.02,'θ',C.prob,{b:1,sz:10.5});}
      /* the measured gap */
      if(s>=4){
        const y=Math.max(sn,.46)+.30, col=ok?C.pos:C.wall;
        const x0=Math.min(Bp[0],Cp[0]),x1=Math.max(Bp[0],Cp[0]);
        P.seg(x0,y,x1,y,col,2);
        P.seg(x0,y-.06,x0,y+.06,col,2);P.seg(x1,y-.06,x1,y+.06,col,2);
        P.label((x0+x1)/2,y+.09,'B′C′ = '+(Math.round(Math.abs(m)*1000)/1000)+' T'+
          (m<0?'  (they swap sides)':''),col,{align:'center',b:1,sz:11});}
      P.text(10,7,'θ = '+deg+'°   ·   n = '+(Math.round(3600/deg)/10)+'-fold',C.ink,{sz:11.5,b:1});
      if(s>=4)P.text(10,24,'m = 1 + 2cos θ = '+(Math.round(m*1000)/1000)+
        (ok?'   ✓ a whole number — this axis is allowed'
           :'   ✗ not a whole number — impossible'),ok?C.pos:C.wall,{sz:10.5,b:1});
      else P.text(10,24,'B′C′ must be a whole number of steps mT',C.inkA(.6),{sz:10.5});
    }},

  /* ── M1: why only n = 1,2,3,4,6 ── */
  rotsym:{ar:.46,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:34,r:16,t:20,b:30});P.clear();
      P.dom(0,7.6).ran(-1.35,1.35).grid(0,4);
      P.hline(1,C.wallA(.5),1.3,[4,3]);P.hline(-1,C.wallA(.5),1.3,[4,3]);
      P.axes();
      // cosθ = (m-1)/2 for integer m
      for(let m=-3;m<=5;m++){
        const c=(m-1)/2, ok=Math.abs(c)<=1;
        const x=m+3.5-0.5;
        P.seg(x,0,x,c,ok?C.pos:C.inkA(.2),ok?2.6:1.4,ok?null:[3,3]);
        P.dot(x,c,ok?C.pos:C.inkA(.25),ok?5:3.4);
        P.label(x,-1.3,'m='+m,ok?C.inkA(.7):C.inkA(.3),{align:'center',sz:9.5});
        if(ok){const n=Math.round(2*Math.PI/Math.acos(Math.min(1,Math.max(-1,c))))||1;
          P.label(x,c+(c>=0?.16:-.26),'n='+(c===1?1:n),C.pos,{align:'center',b:1,sz:10});}}
      P.label(0,1.05,'cos θ = +1',C.wallA(.85),{sz:9.5});
      P.label(0,-1.22,'cos θ = −1',C.wallA(.85),{sz:9.5});
      P.text(10,8,'cos θ = (m−1)/2 must lie in [−1,1] → only n = 1,2,3,4,6',C.inkA(.7),{sz:10,b:1});
    }},

  /* ── M1: packing fractions, computed ── */
  packing:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:38,r:16,t:18,b:34});P.clear();
      P.dom(0,4).ran(0,.85).grid(0,4);P.axes();
      const bars=[['SC',Math.PI/6,'a=2r · CN 6'],['BCC',Math.PI*Math.sqrt(3)/8,'√3a=4r · CN 8'],
                  ['FCC',Math.PI/(3*Math.SQRT2),'√2a=4r · CN 12'],['HCP',Math.PI/(3*Math.SQRT2),'c/a=1.633 · CN 12']];
      const cols=[C.inkA(.4),C.neg,C.pos,C.prob];
      bars.forEach((b,i)=>{const x=i+.5,w=.34;
        ctx.save();ctx.fillStyle=cols[i];
        ctx.fillRect(P.X(x-w),P.Y(b[1]),P.X(x+w)-P.X(x-w),P.Y(0)-P.Y(b[1]));ctx.restore();
        P.label(x,b[1]+.03,b[1].toFixed(3),cols[i],{align:'center',b:1,sz:10.5});
        P.label(x,-.045,b[0],C.inkA(.8),{align:'center',base:'top',b:1,sz:11});
        P.label(x,-.115,b[2],C.inkA(.5),{align:'center',base:'top',sz:8.5});});
      P.label(0,.8,'f',C.inkA(.6),{sz:10,align:'right'});
    }},

  /* ── M1: Bragg reflection geometry with the 2d sinθ path difference ── */
  bragg:{ar:.72,
    opt:{deg:32},
    chips:[{sep:'glancing angle θ'},
      {label:'20°',set:{deg:20}},{label:'32°',set:{deg:32},on:true},
      {label:'50°',set:{deg:50}},{label:'70°',set:{deg:70}}],
    steps:[
      'Two neighbouring planes of the family, a distance d apart, with the X-rays arriving at the glancing angle θ — measured from the plane, not from the normal. That is the classic slip.',
      'The upper ray reflects at A. The ray below it carries on to the next plane and reflects at B, directly underneath A. Both leave at the same angle, so downstream they can interfere.',
      'Drop perpendiculars from A onto the lower ray — they meet it at P before B and at Q after it. Outside P…Q the two rays run side by side over equal distances, so the lower ray’s whole extra journey is PB + BQ.',
      'Each little triangle has hypotenuse AB = d and the angle θ at A, so PB = BQ = d sin θ. The extra path is 2d sin θ.',
      'The rays come away in step only when that extra path is a whole number of wavelengths: 2d sin θ = nλ. And because sin θ ≤ 1, a wavelength longer than 2d can never diffract at all.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:14,r:14,t:50,b:14});P.clear();
      const s=st.step|0,deg=st.opt.deg||32,th=deg*Math.PI/180,d=1;
      const ct=Math.cos(th),sn=Math.sin(th);
      const A=[0,0],B=[0,-d],L=2.5;
      const u=[ct,-sn],v=[ct,sn];
      const add=(p,q,t)=>[p[0]+q[0]*t,p[1]+q[1]*t];
      const Pp=add(B,u,-d*sn), Qp=add(B,v,d*sn);
      fitFrame(P,W-28,H-64,[[-L*ct,L*sn],[L*ct,L*sn],[0,-2.2],[0,.35]],.12);
      /* the planes */
      for(let r=0;r<3;r++){const y=-r*d;
        P.seg(-3.2,y,3.2,y,C.inkA(.28),1.3);
        for(let x=-3;x<=3;x+=.75)P.dot(x,y,C.posA(.55),2.5);}
      P.seg(0,0,0,-d,C.inkA(.45),1.2,[4,3]);
      P.label(.06,-d/2,'d',C.ink,{b:1,sz:11.5});
      /* ray 1 */
      P.seg(add(A,u,-L)[0],add(A,u,-L)[1],A[0],A[1],C.prob,2.2);
      if(s>=1)P.seg(A[0],A[1],add(A,v,L)[0],add(A,v,L)[1],C.prob,2.2);
      /* ray 2 */
      P.seg(add(B,u,-L)[0],add(B,u,-L)[1],B[0],B[1],C.negA(.9),2.2);
      if(s>=1)P.seg(B[0],B[1],add(B,v,L)[0],add(B,v,L)[1],C.negA(.9),2.2);
      /* the angle at A */
      ctx.save();ctx.strokeStyle=C.probA(.7);ctx.lineWidth=1.2;ctx.beginPath();
      ctx.arc(P.X(0),P.Y(0),Math.abs(P.X(.55)-P.X(0)),-Math.PI,-(Math.PI-th),false);
      ctx.stroke();ctx.restore();
      P.label(-.72*Math.cos(th/2),.72*Math.sin(th/2)+.02,'θ',C.prob,{b:1,sz:11});
      /* the two perpendiculars and the extra path */
      if(s>=2){
        P.seg(A[0],A[1],Pp[0],Pp[1],C.inkA(.45),1.2,[3,3]);
        P.seg(A[0],A[1],Qp[0],Qp[1],C.inkA(.45),1.2,[3,3]);
        P.seg(Pp[0],Pp[1],B[0],B[1],C.wall,3.2);
        P.seg(B[0],B[1],Qp[0],Qp[1],C.wall,3.2);
        P.dot(Pp[0],Pp[1],C.wall,4);P.dot(Qp[0],Qp[1],C.wall,4);
        P.label(Pp[0]-.10,Pp[1]-.02,'P',C.wall,{align:'right',b:1,sz:11});
        P.label(Qp[0]+.10,Qp[1]-.02,'Q',C.wall,{b:1,sz:11});}
      P.dot(0,0,C.prob,5);P.dot(0,-d,C.neg,5);
      P.label(-.12,.06,'A',C.prob,{align:'right',b:1,sz:11.5});
      P.label(-.12,-d+.06,'B',C.neg,{align:'right',b:1,sz:11.5});
      if(s>=3){
        P.label((Pp[0]+B[0])/2-.06,(Pp[1]+B[1])/2-.16,'d sin θ',C.wall,
          {align:'right',b:1,sz:10.5});
        P.label((Qp[0]+B[0])/2+.06,(Qp[1]+B[1])/2-.16,'d sin θ',C.wall,{b:1,sz:10.5});}
      P.text(10,7,'θ = '+deg+'°',C.ink,{sz:11.5,b:1});
      if(s>=3)P.text(10,24,'extra path = PB + BQ = 2d sin θ = '+
        (Math.round(2*sn*1000)/1000)+' d',C.wall,{sz:10.5,b:1});
      else P.text(10,24,'the lower ray travels further — by how much?',C.inkA(.6),{sz:10.5});
      if(s>=4)P.text(10,38,'2d sin θ = nλ   ·   λ ≤ 2d or nothing diffracts',
        C.pos,{sz:11,b:1});
    }},

  /* ── M1: d_hkl for a cubic crystal, exact ── */
  dspacing:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:40,r:16,t:16,b:34});P.clear();
      const set=[[1,0,0],[1,1,0],[1,1,1],[2,0,0],[2,1,0],[2,1,1],[2,2,0],[3,1,1],[2,2,2]];
      P.dom(0,set.length).ran(0,1.12).grid(0,4);P.axes();
      set.forEach((v,i)=>{const N=Math.sqrt(v[0]**2+v[1]**2+v[2]**2),dd=1/N,x=i+.5;
        ctx.save();ctx.fillStyle=(i%2?C.negA(.75):C.posA(.85));
        ctx.fillRect(P.X(x-.3),P.Y(dd),P.X(x+.3)-P.X(x-.3),P.Y(0)-P.Y(dd));ctx.restore();
        P.label(x,dd+.03,dd.toFixed(3),C.inkA(.7),{align:'center',sz:9});
        P.label(x,-.05,'('+v.join('')+')',C.inkA(.75),{align:'center',base:'top',sz:9.5});});
      P.text(10,8,'d(hkl) = a / √(h²+k²+l²)   — plotted in units of a',C.inkA(.75),{sz:10.5,b:1});
    }},

  /* ── M1: Brillouin zones of a 2-D square lattice, constructed exactly ── */
  bz:{ar:.72,
    steps:[
      'Start in reciprocal space with the reciprocal lattice of a 2-D square crystal — points every 2π/a.',
      'Join the origin to its neighbours. Each of those vectors G is a family of planes in the real crystal.',
      'Bisect every one of them with a perpendicular line. A wave whose k tip lands on such a line satisfies 2k·G = G² and gets Bragg-reflected.',
      'The patch around the origin that no bisector cuts off is the <b>first Brillouin zone</b> — the Wigner–Seitz cell of the reciprocal lattice.',
      'Carry on outwards: the pieces you reach by crossing exactly one bisector make up the <b>second zone</b>. Every zone has the <em>same total area</em>, so every zone holds the same number of electron states — one band per zone.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:12,r:12,t:28,b:12});P.clear();
      const s=st.step|0;
      const R=2.9,ry=R,rx=ry*(W-24)/(H-40);
      P.dom(-rx,rx).ran(-ry,ry);
      const G=[];
      for(let i=-3;i<=3;i++)for(let j=-3;j<=3;j++)G.push([i,j]);
      const near=G.filter(g=>Math.abs(Math.hypot(g[0],g[1])-1)<1e-9);
      const second=G.filter(g=>Math.abs(Math.hypot(g[0],g[1])-Math.SQRT2)<1e-9);
      const cellOf=list=>{let poly=[[-9,-9],[9,-9],[9,9],[-9,9]];
        list.forEach(g=>{poly=clipHalf(poly,g[0],g[1],(g[0]*g[0]+g[1]*g[1])/2);});return poly;};
      const poly=(pts,fill,line,w)=>{if(pts.length<3)return;ctx.save();ctx.beginPath();
        pts.forEach((q,i)=>{const x=P.X(q[0]),y=P.Y(q[1]);i?ctx.lineTo(x,y):ctx.moveTo(x,y);});
        ctx.closePath();if(fill){ctx.fillStyle=fill;ctx.fill();}
        if(line){ctx.strokeStyle=line;ctx.lineWidth=w||2;ctx.stroke();}ctx.restore();};
      if(s>=4){        /* zone 1 + zone 2 is bounded by the diagonal bisectors alone */
        poly(cellOf(second),C.negA(.30),C.negA(.75),1.6);}
      if(s>=3)poly(cellOf(near),C.posA(.34),C.pos,2.2);
      if(s>=2){
        const bis=(g,col,w)=>{const len=Math.hypot(g[0],g[1]);
          const ux=-g[1]/len,uy=g[0]/len,mx=g[0]/2,my=g[1]/2,L=3.4;
          P.seg(mx-L*ux,my-L*uy,mx+L*ux,my+L*uy,col,w,[5,4]);};
        near.forEach(g=>bis(g,C.probA(.8),1.5));
        if(s>=4)second.forEach(g=>bis(g,C.probA(.35),1.1));}
      if(s>=1)near.forEach(g=>P.seg(0,0,g[0],g[1],C.inkA(.35),1.2));
      G.forEach(g=>P.dot(g[0],g[1],C.inkA(.5),3.2));
      P.dot(0,0,C.ink,4.4);
      P.text(10,7,s>=3?'first zone: area (2π/a)² — one band per zone'
        :'reciprocal lattice of a square crystal · spacing 2π/a',C.inkA(.7),{sz:10.5,b:1});
      if(s>=4)P.text(10,22,'second zone: the four pieces beyond the first — same total area',
        C.negA(.9),{sz:10});
    }},

  /* ── M1: why high-angle reflections come out weaker ── */
  scatfac:{ar:.58,
    steps:[
      'A point scatterer: every wavelet leaves from the same place, so they are all in step whatever the angle. The atom would scatter with its full strength f = Z at every angle.',
      'A real atom is a cloud of Z electrons about 0.1 nm across. Wavelets leaving from opposite sides of the cloud have travelled different distances.',
      'At small angles that difference is a tiny fraction of λ, so they still add up: f ≈ Z. As the angle grows the difference approaches λ and the wavelets start to cancel.',
      'So the atomic scattering factor f falls away with sin θ/λ — which is exactly why high-angle reflections in a diffraction pattern come out systematically weaker.'],
    draw(ctx,W,H,st){
      ctx.clearRect(0,0,W,H);
      const s=st.step|0,half=W*.46;
      const P=Plot(ctx,half,H,{l:12,r:8,t:26,b:14});
      P.dom(-1.25,1.25).ran(-1.05,1.05);
      const th=s>=3?1.15:0.55;
      if(s>=1){const rp=Math.abs(P.X(.42)-P.X(0));
        const g=ctx.createRadialGradient(P.X(0),P.Y(0),rp*.15,P.X(0),P.Y(0),rp);
        g.addColorStop(0,C.negA(.55));g.addColorStop(1,C.negA(.04));
        ctx.save();ctx.beginPath();ctx.arc(P.X(0),P.Y(0),rp,0,7);ctx.fillStyle=g;ctx.fill();
        ctx.restore();}
      P.dot(0,0,C.pos,s>=1?4:6.5);
      const off=s>=1?.42:0;
      [off,-off].forEach((o,i)=>{
        const A=[-1.2,o],B=[0,o],Cc=[1.2*Math.cos(th)+0, o+1.2*Math.sin(th)];
        P.seg(A[0],A[1],B[0],B[1],C.prob,i?1.6:2.2);
        P.seg(B[0],B[1],Cc[0],Cc[1],C.neg,i?1.6:2.2);});
      if(s>=2){P.seg(0,off,0,-off,C.wallA(.55),1.2,[3,3]);
        P.label(.05,0,'≈0.1 nm',C.wallA(.9),{sz:9.5});
        const ex=1.2*Math.cos(th),ey=1.2*Math.sin(th);
        const ux=ex/Math.hypot(ex,ey),uy=ey/Math.hypot(ex,ey);
        [[-.62,'in'],[.62,'out']].forEach(w=>{
          const t=w[0]<0?-1:1;
          if(t<0)P.seg(-.62,off+.34,-.62,-off-.34,C.probA(.5),1.2,[4,3]);
          else P.seg(.62*ux-uy*.5,off*0+.62*uy+ux*.5,.62*ux+uy*.5,.62*uy-ux*.5,
                     C.negA(.5),1.2,[4,3]);});
        P.label(-.60,off+.44,'wavefront',C.probA(.85),{sz:9});}
      P.text(10,7,s===0?'point scatterer — always in step':'extended cloud — paths differ',
        C.inkA(.7),{sz:10.5,b:1});
      /* the falling curve */
      ctx.save();ctx.translate(W*.5,0);
      const Q=Plot(ctx,W*.5,H,{l:34,r:14,t:26,b:26});
      Q.dom(0,1).ran(0,1.08).grid(4,3);Q.axes();
      Q.hline(1,C.inkA(.3),1.2,[4,3]);
      Q.label(.5,1.02,'point atom: f = Z',C.inkA(.55),{align:'center',sz:9.5});
      if(s>=3)Q.curve(x=>Math.exp(-3.1*x*x),C.pos,2.6);
      if(s>=3)Q.label(.62,.32,'f(sin θ/λ)',C.pos,{b:1,sz:10.5});
      Q.label(1,-.06,'sin θ / λ',C.inkA(.6),{align:'right',base:'top',sz:10});
      Q.text(10,7,'atomic scattering factor',C.inkA(.7),{sz:10.5,b:1});
      ctx.restore();
    }},

  /* ── M2: Fermi–Dirac distribution at several temperatures (exact) ── */
  fermi:{ar:.5,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:34,r:16,t:18,b:28});P.clear();
      P.dom(0,2).ran(-.05,1.12).grid(8,4);P.axes();
      const f=(E,t)=>t<=0?(E<1?1:(E>1?0:.5)):1/(Math.exp((E-1)/t)+1);
      [[0,C.ink,'T = 0'],[0.02,C.pos,'low T'],[0.06,C.neg,'higher T'],[0.14,C.prob,'high T']]
        .forEach(([t,col,lab],i)=>{P.curve(E=>f(E,t),col,i?2.1:2.6,i?null:null);});
      P.vline(1,C.wallA(.6),1.4,[4,3]);
      P.label(1,1.09,'E_F',C.wall,{align:'center',b:1,sz:10.5});
      P.dot(1,.5,C.wallA(.8),4);
      P.label(1.06,.5,'f = ½ always',C.wallA(.9),{sz:9.5});
      P.text(10,8,'f(E) = 1/(e^((E−E_F)/k_BT) + 1)',C.inkA(.8),{sz:10.5,b:1});
      P.text(10,22,'only a ~k_BT slice around E_F is free to move',C.inkA(.55),{sz:9.5});
      P.label(2,-.03,'E',C.inkA(.6),{align:'right',base:'top',sz:10});
    }},

  /* ── M2: 3-D density of states √E with the filled Fermi sea ── */
  dos:{ar:.62,
    opt:{d:3},
    chips:[{sep:'dimensions'},{label:'1-D',set:{d:1}},{label:'2-D',set:{d:2}},
           {label:'3-D',set:{d:3},on:true}],
    steps:[
      'Counting states is a volume sum in k-space. Each allowed k occupies a box of side 2π/L, and the Pauli principle lets two electrons (spin ↑↓) into each. So the number of electrons out to a radius k is 2 × (the k-space volume inside k) ÷ (2π/L)ᵈ.',
      'In 3-D that gives N = V k³/3π². Now change the variable to energy with E = ℏ²k²/2m, i.e. k = √(2mE)/ℏ, and the count becomes N(E) = (V/3π²)(2mE/ℏ²)^{3/2} ∝ E^{3/2}.',
      'D(E) is just the slope of that count: D(E) = dN/dE ∝ √E in 3-D. States get <b>denser</b> as you climb, because a shell of the k-sphere at bigger radius has more surface to hold them. Switch dimensions with the chips — the shape of D(E) is completely different in 1-D and 2-D.',
      'Fill it to the brim at T = 0. The shaded area <em>is</em> N, and in 3-D it is top-heavy: most electrons sit near E_F, not near the bottom.',
      'Two payoffs. Because N ∝ E_F^{3/2}, differentiating gives D(E_F) = (3/2)N/E_F — the shortcut used in every heat-capacity question. And the weighted mean energy is ⟨E⟩ = ⅗E_F in 3-D. In 1-D, where D ∝ E^{−1/2} is bottom-heavy instead, the same integral gives ⅓E_F — that is a standard 4-mark proof.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:38,r:16,t:32,b:30});P.clear();
      const s=st.step|0,d=(st.opt&&st.opt.d)||3,EF=1;
      const D={1:E=>E<=0?0:0.55/Math.sqrt(E),2:()=>0.85,3:E=>1.05*Math.sqrt(E)}[d];
      const mean={1:1/3,2:1/2,3:3/5}[d];
      P.dom(0,1.55).ran(0,2.0).grid(0,4);
      if(s>=3){ctx.save();ctx.fillStyle=C.negA(.28);ctx.beginPath();
        ctx.moveTo(P.X(0),P.Y(0));
        for(let i=1;i<=200;i++){const E=EF*i/200;ctx.lineTo(P.X(E),P.Y(Math.min(2,D(E))));}
        ctx.lineTo(P.X(EF),P.Y(0));ctx.closePath();ctx.fill();ctx.restore();}
      if(s>=2)P.curve(E=>Math.min(2,D(E)),C.neg,2.6);
      if(s>=1&&s<2)P.curve(E=>{const n={1:Math.sqrt(E),2:E,3:Math.pow(E,1.5)}[d];
        return 1.15*n;},C.probA(.85),2.2);
      P.vline(EF,C.wallA(.7),1.5,[4,3]);
      P.label(EF+.03,1.9,'E_F',C.wall,{b:1,sz:11});
      if(s>=4){P.vline(mean,C.pos,2,[2,3]);
        P.label(mean+.03,.30,'⟨E⟩ = '+({1:'⅓',2:'½',3:'⅗'}[d])+' E_F',C.pos,{b:1,sz:10.5});}
      P.axes();
      P.label(1.55,-.06,'E →',C.inkA(.6),{align:'right',base:'top',sz:10});
      const lab={1:'D(E) ∝ E^(−1/2)',2:'D(E) = constant',3:'D(E) ∝ √E'}[d];
      P.text(10,7,d+'-D free electron gas   ·   '+lab,C.ink,{sz:11,b:1});
      P.text(10,21,s<1?'each state occupies (2π/L)^'+d+' in k-space, 2 electrons per state'
        :s<2?'the running count N(E) — the indigo curve'
        :s<3?'D(E) = dN/dE'
        :s<4?'shaded area = N, every state below E_F occupied at T = 0'
        :'D(E_F) = ('+d+'/2)·N/E_F   ·   ⟨E⟩ = '+({1:'E_F/3',2:'E_F/2',3:'3E_F/5'}[d]),
        C.inkA(.62),{sz:9.5});
    }},

  /* ── M2: the Fermi sphere as a filled disc of allowed k-states ── */
  /* ── M2: Kronig–Penney — the exact allowed/forbidden condition ── */
  kp:{ar:.62,
    opt:{P:6.3},
    chips:[{sep:'barrier strength P'},
      {label:'P → 0  (free)',set:{P:0.001}},{label:'P = 2',set:{P:2}},
      {label:'P = 6',set:{P:6.3},on:true},{label:'P = 20',set:{P:20}}],
    steps:[
      'Plot the left-hand side of the Kronig–Penney condition, f(αa) = P·sin(αa)/(αa) + cos(αa). Energy enters through α = √(2mE)/ℏ, so moving right along the axis means going up in energy.',
      'The right-hand side is cos(ka). Whatever k is, a cosine cannot leave the range −1 to +1 — so draw that corridor.',
      'Wherever the curve lies inside the corridor there is a real k that solves the equation: those energies are <b>allowed</b>. The copper bars along the bottom mark them.',
      'Wherever the curve escapes the corridor no real k exists: a <b>forbidden gap</b>. The gaps are exactly where the curve pokes out.',
      'Two things to notice. Going right (higher energy) the bumps shrink, so bands widen and gaps narrow. And change P with the chips: P → 0 removes the barriers and the gaps vanish (free electron), while large P squeezes each band towards a single sharp atomic level.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:34,r:16,t:34,b:30});P.clear();
      const s=st.step|0,Pv=(st.opt&&st.opt.P!=null)?st.opt.P:6.3;
      const f=x=>x===0?1+Pv:Pv*Math.sin(x)/x+Math.cos(x);
      const top=Math.max(4.2,Math.min(1+Pv,9));
      P.dom(0,14).ran(-top*.82,top).grid(7,0);
      if(s>=1){ctx.save();ctx.fillStyle=C.posA(.13);
        ctx.fillRect(P.X(0),P.Y(1),P.X(14)-P.X(0),P.Y(-1)-P.Y(1));ctx.restore();
        P.hline(1,C.wallA(.75),1.5,[5,3]);P.hline(-1,C.wallA(.75),1.5,[5,3]);
        P.label(0,1.15,'+1',C.wall,{sz:9.5});P.label(0,-1.45,'−1',C.wall,{sz:9.5});}
      if(s>=2){
        const yb=-top*.72;
        for(let i=0;i<=1400;i++){const x=i*14/1400;
          if(Math.abs(f(x))<=1){const px=P.X(x);ctx.save();ctx.strokeStyle=C.pos;ctx.lineWidth=7;
            ctx.beginPath();ctx.moveTo(px,P.Y(yb));ctx.lineTo(px+1.2,P.Y(yb));
            ctx.stroke();ctx.restore();}}
        P.label(.15,yb+.30,'allowed bands',C.pos,{b:1,sz:9.5});}
      if(s>=3){                       // hatch the excursions that make the gaps
        for(let i=0;i<=700;i++){const x=i*14/700,v=f(x);
          if(Math.abs(v)>1){const px=P.X(x);ctx.save();ctx.strokeStyle=C.wallA(.16);
            ctx.lineWidth=2;ctx.beginPath();ctx.moveTo(px,P.Y(v>0?1:-1));
            ctx.lineTo(px,P.Y(Math.max(-top*.8,Math.min(top,v))));ctx.stroke();ctx.restore();}}}
      P.curve(f,C.prob,2.2);
      P.axes();
      P.text(10,7,'P = '+(Pv<.01?'0':Pv)+'   ·   f(αa) = P·sin(αa)/(αa) + cos(αa) = cos(ka)',
        C.ink,{sz:10.5,b:1});
      P.text(10,21,s<1?'energy increases to the right'
        :s<2?'cos(ka) can only live between −1 and +1'
        :s<4?'inside the corridor → real k → allowed'
        :(Pv<.01?'no barriers: the curve never leaves the corridor — no gaps at all'
                :'bands widen and gaps narrow as the energy grows'),C.inkA(.62),{sz:9.5});
      P.label(14,-top*.79,'αa →',C.inkA(.6),{align:'right',base:'top',sz:10});
    }},

  /* ── M2: E–k in extended + reduced zone, gaps at nπ/a ── */
  bands:{ar:.62,
    steps:[
      'The <b>extended-zone</b> scheme: band 1 drawn in the first zone, band 2 in the second, and so on, straight along the free-electron parabola (dashed) with a gap torn open at every zone boundary.',
      'The <b>reduced-zone</b> scheme: because E(k) repeats every 2π/a, every branch can be slid back by a whole reciprocal-lattice vector into the first zone. Nothing is lost — it is the same states relabelled.',
      'The <b>periodic</b> scheme: draw the reduced picture again in every zone. Useful when you want to follow a band smoothly through a boundary.',
      'Same information, three pictures — and the question “which scheme is this?” is worth a mark on its own. In all three, the gaps sit at k = ±nπ/a, where Bragg reflection turns the travelling wave into a standing one.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:30,r:16,t:30,b:30});P.clear();
      const s=st.step|0,gap=1.15;
      P.dom(-3.2,3.2).ran(0,12.4);
      const seg=(n,shift)=>k=>{const ak=Math.abs(k);
        return (ak>=n-1&&ak<=n)?k*k+(n-1)*gap+(shift||0):null;};
      const col=n=>n===1?C.pos:n===2?C.neg:C.prob;
      if(s===0){
        P.curve(k=>k*k,C.inkA(.22),1.4,[4,3]);
        for(let n=1;n<=3;n++)P.curve(seg(n),col(n),2.4);}
      if(s>=1){                      // slide every branch back into the first zone
        const red=n=>k=>{const ak=Math.abs(k);if(ak>1.0001)return null;
          const kk=(n%2)?(n-1+ak):(n-ak);            // the k it came from
          return kk*kk+(n-1)*gap;};
        const reps=s>=2?[-2,0,2]:[0];
        for(let n=1;n<=3;n++)reps.forEach(off=>{
          if(s>=2&&off!==0&&n===3)return;            // keep the repeats readable
          P.curve(k=>red(n)(k-off),col(n),2.4);});}
      for(let n=1;n<=3;n++){P.vline(n,C.wallA(.45),1.2,[3,3]);P.vline(-n,C.wallA(.45),1.2,[3,3]);}
      if(s===0)for(let n=1;n<=2;n++){
        const eLo=n*n+(n-1)*gap,eHi=n*n+n*gap;
        ctx.save();ctx.strokeStyle=C.wall;ctx.lineWidth=3;ctx.beginPath();
        ctx.moveTo(P.X(n),P.Y(eLo));ctx.lineTo(P.X(n),P.Y(eHi));ctx.stroke();ctx.restore();
        P.label(n+.12,(eLo+eHi)/2,'E_g',C.wall,{b:1,sz:10});}
      P.axes();
      P.label(1,-.35,'π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
      P.label(2,-.35,'2π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
      P.label(-1,-.35,'−π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
      P.text(10,7,s===0?'extended-zone scheme':s===1?'reduced-zone scheme'
        :s===2?'periodic scheme':'three pictures, one band structure',C.ink,{sz:11,b:1});
      P.text(10,21,s===0?'band n lives in zone n · gaps at k = ±nπ/a'
        :s===1?'every branch slid back by a reciprocal vector into |k| ≤ π/a'
        :'the reduced picture repeated in every zone',C.inkA(.62),{sz:9.5});
    }},

  /* ── M2: v = (1/ħ)dE/dk and m* = ħ²/(d²E/dk²) from one cosine band ── */
  effmass:{ar:.86,
    steps:[
      'Start from the band itself, E(k). Near the bottom it looks just like the free-electron parabola; near the top it bends the other way. Everything else on this page is a derivative of this one curve.',
      'The electron’s speed is the <b>slope</b>: v = (1/ℏ)dE/dk. Note where it peaks — at the inflection point, halfway up the band — and that it falls back to <b>zero at the zone boundary</b>. An electron at k = π/a is a standing wave and goes nowhere, however hard you push.',
      'The effective mass is the <b>curvature</b>: 1/m* = (1/ℏ²)d²E/dk². Where the band is sharply curved (bottom of the band) m* is small and the electron responds eagerly; where it is flat, m* is huge.',
      'Now the strange part. Past the inflection the curvature flips sign, so <b>m* is negative</b> in the upper half of the band. Push such an electron with a field and it accelerates <em>backwards</em>.',
      'That is not nonsense, it is bookkeeping. The electron feels the applied force <em>and</em> the lattice force; m* hides the second one. Near the band top the lattice is handing momentum back faster than the field supplies it — Bragg reflection winning — so the net acceleration opposes the field. Total momentum, electron plus lattice, is conserved throughout. And a vacancy in that region is what we call a hole.'],
    draw(ctx,W,H,st){
      readPalette();ctx.clearRect(0,0,W,H);
      const s=st.step|0,h=H/3;
      const E =k=>1-Math.cos(Math.PI*k);
      const v =k=>Math.PI*Math.sin(Math.PI*k);
      const im=k=>Math.PI*Math.PI*Math.cos(Math.PI*k);
      const panel=(oy,fn,col,lab,ran,on)=>{
        ctx.save();ctx.translate(0,oy);
        const P=Plot(ctx,W,h,{l:34,r:14,t:14,b:18});
        P.dom(-1,1).ran(ran[0],ran[1]).grid(4,2);P.axes();
        P.vline(-.5,C.wallA(.3),1,[3,3]);P.vline(.5,C.wallA(.3),1,[3,3]);
        if(on){
          if(fn===im&&st.step>=3){ctx.save();ctx.fillStyle=C.wallA(.13);
            ctx.fillRect(P.X(-1),P.Y(ran[1]),P.X(-.5)-P.X(-1),P.Y(0)-P.Y(ran[1]));
            ctx.fillRect(P.X(.5),P.Y(ran[1]),P.X(1)-P.X(.5),P.Y(0)-P.Y(ran[1]));
            ctx.restore();}
          P.curve(fn,col,2.4);}
        P.text(10,6,lab,on?col:C.inkA(.25),{sz:10,b:1});
        ctx.restore();return P;};
      panel(0,E,C.pos,'E(k)  — the band',[-.15,2.2],s>=0);
      panel(h,v,C.neg,'v = (1/ℏ) dE/dk  — zero at the zone edge',[-3.6,3.6],s>=1);
      const P3=panel(2*h,im,C.prob,'d²E/dk² ∝ 1/m*  — negative in the upper half',[-11,11],s>=2);
      ctx.save();ctx.translate(0,2*h);
      const Q=Plot(ctx,W,h,{l:34,r:14,t:14,b:18});Q.dom(-1,1).ran(-11,11);
      Q.label(1,-10.4,'k = π/a',C.inkA(.55),{align:'right',sz:9});
      Q.label(-1,-10.4,'−π/a',C.inkA(.55),{sz:9});
      if(s>=3){Q.label(.75,-6.2,'m* < 0',C.wall,{align:'center',b:1,sz:11});
        Q.label(-.75,-6.2,'m* < 0',C.wall,{align:'center',b:1,sz:11});}
      ctx.restore();
      ctx.save();ctx.translate(0,h);
      const Q2=Plot(ctx,W,h,{l:34,r:14,t:14,b:18});Q2.dom(-1,1).ran(-3.6,3.6);
      if(s>=1)Q2.label(.5,3.0,'peak speed',C.negA(.85),{align:'center',sz:9.5});
      ctx.restore();
    }},

  /* ── M2: the Drude picture — random walk, then a field ── */
  drude:{ar:.60,
    steps:[
      'A metal is a rigid grid of positive ion cores with the valence electrons let loose between them. With no field an electron just bounces about at random — fast (10⁵–10⁶ m/s) but going nowhere. Over many collisions the average displacement is zero, so there is no current.',
      'Switch on a field E. Between collisions the electron accelerates gently along −E, and every collision wipes the memory. The random walk is unchanged; a small extra step is simply added to each free flight.',
      'The result is a slow <b>drift</b> superposed on the fast random motion: v_d = −eEτ/m, where τ is the mean time between collisions. Typical drift speeds are millimetres per second — thousands of times slower than the thermal speed.',
      'Current density J = −n e v_d = (ne²τ/m)E = σE. That is <b>Ohm’s law</b>, and the model gets it right: σ = ne²τ/m.',
      'The mean free path is λ = v_th τ, which classically comes out as a few atomic spacings. But cool a pure metal and the measured λ stretches past 10⁸ spacings — the fourth failure, and only Bloch’s theorem explains it.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:14,r:14,t:32,b:16});P.clear();
      const s=st.step|0;
      const ry=1.25,rx=ry*(W-28)/(H-48);
      P.dom(-rx,rx).ran(-ry,ry);
      for(let i=-6;i<=6;i++)for(let j=-3;j<=3;j++){
        const x=i*.42,y=j*.42;
        if(Math.abs(x)>rx-.1)continue;
        P.dot(x,y,C.posA(.5),3.2);}
      /* one deterministic “random” walk, with and without the field */
      let seed=7;const rnd=()=>{seed=(seed*1103515245+12345)&0x7fffffff;return seed/0x7fffffff;};
      const steps=[];for(let i=0;i<26;i++){const th=rnd()*2*Math.PI;
        steps.push([Math.cos(th)*.30,Math.sin(th)*.30]);}
      const walk=(drift,col,w)=>{let x=-rx*.8,y=0;const pts=[[x,y]];
        steps.forEach(d=>{x+=d[0]+drift;y+=d[1];pts.push([x,y]);});
        for(let i=0;i<pts.length-1;i++)
          P.seg(pts[i][0],pts[i][1],pts[i+1][0],pts[i+1][1],col,w);
        return pts[pts.length-1];};
      const endA=walk(0,s>=1?C.inkA(.22):C.neg,s>=1?1.2:2);
      if(s===0){P.dot(endA[0],endA[1],C.neg,5);
        P.seg(-rx*.8,0,endA[0],endA[1],C.negA(.5),1.6,[4,3]);
        P.label((endA[0]-rx*.8)/2,-.16,'net displacement ≈ 0 over many collisions',
          C.negA(.9),{align:'center',base:'top',sz:9.5});}
      if(s>=1){
        const endB=walk(.085,C.pos,2.2);
        P.dot(endB[0],endB[1],C.pos,5);
        if(s>=2){P.seg(-rx*.8,0,endB[0],endB[1],C.probA(.85),2.4);
          P.label((endB[0]-rx*.8)/2,.16,'drift  v_d = −eEτ/m',C.prob,{align:'center',b:1,sz:10.5});}
        /* the field arrow */
        ctx.save();ctx.strokeStyle=C.wall;ctx.lineWidth=2;
        ctx.beginPath();ctx.moveTo(P.X(rx*.55),P.Y(-ry*.80));ctx.lineTo(P.X(rx*.90),P.Y(-ry*.80));
        ctx.stroke();ctx.restore();
        P.label(rx*.72,-ry*.70,'E',C.wall,{align:'center',b:1,sz:12});}
      P.text(10,7,s===0?'no field — random walk between collisions'
        :'field on — the same walk, plus a nudge each flight',C.ink,{sz:11,b:1});
      P.text(10,21,s>=3?'J = −n e v_d = (ne²τ/m) E = σE   →   Ohm’s law'
        :s>=2?'thermal speed ~10⁶ m/s · drift speed ~10⁻³ m/s'
        :'copper = ion cores · the line is one electron’s path',C.inkA(.62),{sz:9.5});
    }},

  /* ── M2: standing waves at the zone boundary, and the gap ── */
  standing:{ar:.78,
    steps:[
      'A row of positive ion cores, spacing a, and an electron wave with k well inside the zone. Its wavelength does not match the spacing, so the wavelets reflected from successive cores do not add up — the electron sails straight through, exactly as the free-electron model assumes.',
      'Now push k to π/a, i.e. λ = 2a. Reflections off successive cores are in step and add up: the wave is Bragg-reflected. Forward and backward waves of equal strength combine into a <b>standing wave</b>, which carries no current at all.',
      'There are two ways to build that standing wave. ψ₊ ∝ cos(πx/a) piles its charge <b>on top of</b> the positive cores — closer to the attraction, so lower energy.',
      'ψ₋ ∝ sin(πx/a) piles the same charge <b>between</b> the cores — further from the attraction, so higher energy.',
      'Two allowed energies at exactly the same k, and nothing in between. That missing range is the <b>band gap</b>, and it sits at k = ±nπ/a — the Brillouin zone boundary. Everything in Module II follows from this picture.'],
    draw(ctx,W,H,st){
      ctx.clearRect(0,0,W,H);
      const s=st.step|0,hTop=H*.52;
      const P=Plot(ctx,W,hTop,{l:16,r:16,t:28,b:22});
      P.dom(0,4).ran(-1.35,1.35);
      for(let i=0;i<=4;i++){P.dot(i,-1.15,C.pos,6);
        P.label(i,-1.32,'+',C.posA(.9),{align:'center',base:'top',sz:11});}
      P.seg(0,-1.15,4,-1.15,C.inkA(.20),1.2);
      P.label(.5,-1.05,'a',C.inkA(.55),{align:'center',sz:9.5});
      if(s===0){P.curve(x=>Math.sin(2*Math.PI*x/1.35),C.prob,2.2);
        P.text(10,7,'k well inside the zone — the wave passes through',C.ink,{sz:10.5,b:1});}
      if(s===1){P.curve(x=>Math.sin(Math.PI*x),C.probA(.55),1.8);
        P.curve(x=>-Math.sin(Math.PI*x),C.negA(.55),1.8);
        P.curve(x=>2*Math.cos(Math.PI*x)*0+0,C.inkA(0),0);
        P.text(10,7,'k = π/a — forward and reflected waves are equal',C.ink,{sz:10.5,b:1});
        P.text(10,21,'their sum is a standing wave: no net current',C.inkA(.62),{sz:9.5});}
      if(s>=2){
        if(s===2||s>=4)P.curve(x=>Math.cos(Math.PI*x),C.pos,2.2);
        if(s>=3)P.curve(x=>Math.sin(Math.PI*x),C.neg,2.2);
        P.text(10,7,s===2?'ψ₊ ∝ cos(πx/a)':s===3?'ψ₋ ∝ sin(πx/a)':'two standing waves, two energies',
          C.ink,{sz:10.5,b:1});}
      /* lower panel: |ψ|² against the cores, then the gap */
      ctx.save();ctx.translate(0,hTop);
      const Q=Plot(ctx,W,H-hTop,{l:16,r:16,t:22,b:22});
      if(s<4){
        Q.dom(0,4).ran(0,1.35);
        for(let i=0;i<=4;i++)Q.dot(i,.04,C.pos,5);
        if(s>=2)Q.fill(x=>Math.cos(Math.PI*x)*Math.cos(Math.PI*x),C.posA(.30));
        if(s>=3)Q.fill(x=>Math.sin(Math.PI*x)*Math.sin(Math.PI*x),C.negA(.30));
        if(s>=2)Q.curve(x=>Math.cos(Math.PI*x)*Math.cos(Math.PI*x),C.pos,2);
        if(s>=3)Q.curve(x=>Math.sin(Math.PI*x)*Math.sin(Math.PI*x),C.neg,2);
        Q.text(10,5,s<2?'charge density |ψ|² appears here'
          :s===2?'|ψ₊|² sits ON the cores → lower energy'
          :'|ψ₋|² sits BETWEEN them → higher energy',C.inkA(.7),{sz:9.5,b:s>=2?1:0});
      }else{
        Q.dom(-1.6,1.6).ran(0,3.4);
        const gap=.85;
        Q.curve(k=>Math.abs(k)<=1?k*k:null,C.pos,2.4);
        Q.curve(k=>Math.abs(k)>=1?k*k+gap:null,C.neg,2.4);
        Q.curve(k=>k*k,C.inkA(.20),1.3,[4,3]);
        Q.vline(1,C.wallA(.5),1.2,[3,3]);Q.vline(-1,C.wallA(.5),1.2,[3,3]);
        [1,-1].forEach(sg=>{ctx.save();ctx.strokeStyle=C.wall;ctx.lineWidth=3.4;
          ctx.beginPath();ctx.moveTo(Q.X(sg),Q.Y(1));ctx.lineTo(Q.X(sg),Q.Y(1+gap));
          ctx.stroke();ctx.restore();});
        Q.label(1.08,1+gap/2,'E_g',C.wall,{b:1,sz:11});
        Q.label(1,-.06,'π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
        Q.label(-1,-.06,'−π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
        Q.axes();
        Q.text(10,5,'the two energies at k = π/a are the edges of the gap',C.wall,{sz:9.5,b:1});
      }
      ctx.restore();
    }},

  /* ── M2: Bloch's theorem, factor by factor ── */
  bloch:{ar:.74,
    steps:[
      'The lattice: a potential that repeats, V(x) = V(x+a), with a well at every ion core. This is the only change from the free-electron model — and it changes everything.',
      'Start with the free-electron part: a plane wave e^{ikx}. On its own it has no idea the lattice is there; its amplitude is the same everywhere.',
      'Now the lattice-periodic part u_k(x), with exactly the period of the lattice — it bunches the electron near the cores. Note it repeats every a, whatever k is.',
      'Bloch’s theorem says the true stationary state is the <b>product</b>: ψ = e^{ikx} u_k(x). A travelling wave, modulated as it passes each atom — the dashed envelope is ±u_k(x).',
      'Two consequences worth the marks. Shifting by one lattice step only multiplies ψ by the phase e^{ika}, so |ψ|² repeats — the electron is spread over the whole crystal, not tied to one atom. And it never decays: <b>a perfect lattice scatters nothing</b>. Resistance comes only from what breaks the periodicity — phonons, impurities, defects.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:16,r:16,t:30,b:18});P.clear();
      const s=st.step|0;
      P.dom(0,6).ran(-3.9,3.5);
      const pw=x=>Math.cos(Math.PI*x/2);            // plane wave, λ = 4a
      const u =x=>.62+.38*Math.cos(2*Math.PI*x);    // ripple, period a
      const V =x=>-.55*Math.pow(Math.cos(Math.PI*x),6);
      for(let i=0;i<=6;i++)P.dot(i,-3.35,C.pos,5.5);
      P.curve(x=>-3.35+1.5*V(x),C.posA(.85),1.8);
      P.label(.12,-2.72,'V(x) = V(x+a)',C.pos,{b:1,sz:10});
      if(s>=1){P.curve(x=>2.35+.85*pw(x),C.prob,2.2);
        P.label(.12,3.35,'e^{ikx}   — the plane wave',C.prob,{b:1,sz:10});}
      if(s>=2){P.curve(x=>.75+.75*(u(x)-.62)/.38*.5,C.neg,2.2);
        P.label(.12,1.35,'u_k(x)   — repeats every a',C.neg,{b:1,sz:10});}
      if(s>=3){P.curve(x=>-1.35+1.15*pw(x)*u(x),C.pos,2.5);
        P.label(.12,-.45,'ψ = e^{ikx} u_k(x)',C.pos,{b:1,sz:10.5});}
      if(s>=4){P.curve(x=>-1.35+1.15*u(x),C.posA(.40),1.3,[5,4]);
        P.curve(x=>-1.35-1.15*u(x),C.posA(.40),1.3,[5,4]);
        P.label(4.15,-.45,'envelope ±u_k(x)',C.posA(.8),{sz:9.5});}
      P.text(10,7,s===0?'a repeating potential — that is the whole change'
        :s===1?'free-electron part: same amplitude everywhere'
        :s===2?'lattice-periodic part: bunches charge near the cores'
        :s===3?'their product is the Bloch state'
        :'ψ(x+a) = e^{ika} ψ(x)  →  extended, undamped, never scattered',C.ink,{sz:10.5,b:1});
    }},

  /* ── M2: why a vacancy behaves like a positive particle ── */
  hole:{ar:.62,
    steps:[
      'A completely full band. For every electron drifting one way at +k there is one at −k going the other way, so the currents cancel exactly: <b>a full band carries no current</b>, however hard you pull on it.',
      'Take one electron out of a state near the top of the band. Now the cancellation fails by exactly that one term, so the current of the whole band equals <em>minus</em> the current of the missing electron.',
      'Switch on a field. Every occupied state slides through k-space together, dk/dt = −eE/ℏ — and the empty slot slides along with them, keeping its place in the queue.',
      'So instead of bookkeeping 10²³ electrons, track the one vacancy. The missing electron sat near the band top where the curvature is negative and m* < 0 — and minus a negative charge with a negative mass behaves exactly like a <b>positive charge with a positive mass</b>.',
      'That fictitious particle is a <b>hole</b>: charge +e, positive effective mass, drifting <em>with</em> the field. It is why the Hall coefficient of some metals comes out positive, and it is how conduction in a p-type semiconductor is described.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:26,r:16,t:32,b:26});P.clear();
      const s=st.step|0;
      P.dom(-1.15,1.15).ran(-.35,2.5);
      const E=k=>1-Math.cos(Math.PI*k);
      P.curve(E,C.inkA(.45),2);
      P.vline(1,C.wallA(.45),1.2,[3,3]);P.vline(-1,C.wallA(.45),1.2,[3,3]);
      P.axes();
      P.label(1,-.30,'π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
      P.label(-1,-.30,'−π/a',C.inkA(.6),{align:'center',base:'top',sz:9.5});
      const N=13,shift=(s>=2)?.055:0;
      const missing=(s>=1)?9:-1;
      for(let i=0;i<=N;i++){
        const k=-1+2*i/N+shift;
        if(k>1.02)continue;
        if(i===missing){ctx.save();ctx.strokeStyle=C.wall;ctx.lineWidth=2;
          ctx.beginPath();ctx.arc(P.X(k),P.Y(E(k)),5.2,0,7);ctx.stroke();ctx.restore();
          if(s>=3)P.label(k+.06,E(k)+.16,'hole  +e',C.wall,{b:1,sz:10.5});
          continue;}
        P.dot(k,E(k),C.neg,4.4);}
      if(s>=2){
        ctx.save();ctx.strokeStyle=C.prob;ctx.lineWidth=2;
        ctx.beginPath();ctx.moveTo(P.X(-.35),P.Y(2.25));ctx.lineTo(P.X(.05),P.Y(2.25));
        ctx.stroke();ctx.restore();
        P.label(-.15,2.32,'dk/dt = −eE/ℏ',C.prob,{align:'center',b:1,sz:10});}
      if(s===0){
        [[-.62,'←'],[.62,'→']].forEach(o=>P.label(o[0],E(o[0])+.22,o[1],C.negA(.9),
          {align:'center',b:1,sz:13}));
        P.text(10,21,'every +k is matched by a −k → currents cancel',C.inkA(.62),{sz:9.5});}
      P.text(10,7,s===0?'a full band carries no current'
        :s===1?'one electron missing near the band top'
        :s===2?'the field slides every state — the gap in the queue too'
        :s===3?'m* < 0 near the top, and −(−e)(−m) = a positive particle'
        :'the hole: charge +e, positive mass, drifts with the field',C.ink,{sz:10.5,b:1});
      if(s>=4)P.text(10,21,'this is why R_H can come out positive',C.wallA(.9),{sz:9.5,b:1});
    }},

  /* ── M2: only a k_BT window of electrons can take up heat ── */
  fdwindow:{ar:.60,
    steps:[
      'At T = 0 the Fermi function is a cliff: every state below E_F is full, every state above it empty. Nothing can absorb a small amount of energy, because there is nowhere to put the electron.',
      'Warm it up. The cliff softens, but only over a width of about k_BT — and at room temperature k_BT ≈ 0.026 eV against E_F ≈ 5 eV, so the softening is a sliver.',
      'Only the electrons inside that sliver have empty states just above them to move into. Everyone deeper down is blocked by the Pauli principle. The fraction that can take part is about k_BT/E_F = T/T_F ≈ 0.01.',
      'Each of those picks up roughly k_BT, so the extra energy is U ≈ N(T/T_F)k_BT and the heat capacity is C_v = dU/dT ≈ (3/2)R(T/T_F). Two consequences at once: it is ~1% of the classical value, <em>and</em> it grows linearly with T instead of being constant. Both are what experiment shows.'],
    draw(ctx,W,H,st){
      const P=Plot(ctx,W,H,{l:34,r:16,t:32,b:30});P.clear();
      const s=st.step|0,EF=1,kT=.085;
      P.dom(0,2).ran(-.08,1.18).grid(4,2);
      const f=(E,t)=>t<=0?(E<EF?1:0):1/(1+Math.exp((E-EF)/t));
      if(s>=2){ctx.save();ctx.fillStyle=C.probA(.16);
        ctx.fillRect(P.X(EF-2.2*kT),P.Y(1.12),P.X(EF+2.2*kT)-P.X(EF-2.2*kT),
                     P.Y(0)-P.Y(1.12));ctx.restore();
        P.label(EF+2.4*kT,.92,'≈ k_BT wide',C.prob,{b:1,sz:10});}
      P.curve(E=>f(E,0),C.inkA(.35),1.6,[5,3]);
      if(s>=1)P.curve(E=>f(E,kT),C.neg,2.6);
      P.vline(EF,C.wallA(.6),1.4,[4,3]);
      P.label(EF+.03,1.10,'E_F',C.wall,{b:1,sz:11});
      P.axes();
      P.label(2,-.05,'E →',C.inkA(.6),{align:'right',base:'top',sz:10});
      P.label(0,1.06,'f = 1',C.inkA(.55),{sz:9.5});
      P.text(10,7,s===0?'T = 0 — a cliff at E_F'
        :s===1?'T > 0 — the cliff softens over ~k_BT'
        :s===2?'only that sliver has empty states to move into'
        :'C_v ≈ (3/2)R (T/T_F) — 1% of classical, and linear in T',C.ink,{sz:10.5,b:1});
      if(s>=2)P.text(10,21,'fraction able to take part ≈ k_BT/E_F = T/T_F ≈ 0.01',
        C.inkA(.62),{sz:9.5});
    }},

  /* ── M2: metal / semiconductor / insulator band diagrams ── */
  classify:{ar:.62,
    steps:[
      'First, what a band diagram means. Energy runs up the page. A shaded block is a band of allowed levels that is <b>full</b>; an outlined block is a band that is <b>empty</b>. Conduction needs an electron to change its k, and that means finding an empty level immediately above an occupied one.',
      '<b>Metal.</b> The top band is only partly filled — one valence electron per atom fills half of the 2N places — so empty levels sit directly above occupied ones. An arbitrarily small field can shift the whole distribution and a current flows. E_F lies <em>inside</em> a band.',
      '<b>Semiconductor.</b> The valence band is exactly full and the next one empty, but the gap is small (Si 1.1 eV, Ge 0.7 eV). At T = 0 that is an insulator. Warm it and a few electrons make the jump, each leaving a hole behind — two carriers per event.',
      '<b>Insulator.</b> Same picture, but the gap is 5 eV or more. Against k_BT ≈ 0.026 eV at room temperature the Boltzmann factor e^{−E_g/2k_BT} is fantastically small, so essentially nothing crosses.',
      'Two extras worth marks. Some metals (the alkaline earths, Mg, Ca, Zn) have exactly full bands yet still conduct, because two bands <b>overlap</b> in energy — the dashed pair on the left. And the temperature behaviour is the giveaway: in a metal the carrier count is fixed and warming only adds scattering, so σ ∝ 1/T; in a semiconductor the carrier <em>number</em> grows exponentially, so σ climbs steeply with T.'],
    draw(ctx,W,H,st){
      readPalette();ctx.clearRect(0,0,W,H);
      const s=st.step|0;
      const cases=[['Metal','partly filled',0,C.pos],['Semiconductor','E_g ≈ 1 eV',1.0,C.neg],
                   ['Insulator','E_g ≳ 5 eV',2.6,C.wall]];
      const wCol=W/3;
      cases.forEach((c,i)=>{
        const on=s>=i+1;
        ctx.save();ctx.translate(i*wCol,0);
        const P=Plot(ctx,wCol,H,{l:16,r:16,t:42,b:34});
        P.dom(0,1).ran(-.6,5.9);
        const vbTop=1.2,cbBot=vbTop+c[2];
        ctx.save();ctx.fillStyle=on?C.negA(.55):C.inkA(.10);
        ctx.fillRect(P.X(.15),P.Y(vbTop),P.X(.85)-P.X(.15),P.Y(0)-P.Y(vbTop));ctx.restore();
        ctx.save();ctx.fillStyle=C.inkA(.07);ctx.strokeStyle=C.inkA(on?.35:.16);ctx.lineWidth=1.2;
        ctx.fillRect(P.X(.15),P.Y(cbBot+1.5),P.X(.85)-P.X(.15),P.Y(cbBot)-P.Y(cbBot+1.5));
        ctx.strokeRect(P.X(.15),P.Y(cbBot+1.5),P.X(.85)-P.X(.15),P.Y(cbBot)-P.Y(cbBot+1.5));
        ctx.restore();
        if(c[2]>0&&on){
          ctx.save();ctx.strokeStyle=c[3];ctx.lineWidth=2;ctx.setLineDash([4,3]);
          ctx.beginPath();ctx.moveTo(P.X(.5),P.Y(vbTop));ctx.lineTo(P.X(.5),P.Y(cbBot));
          ctx.stroke();ctx.restore();
          P.label(.55,(vbTop+cbBot)/2,'E_g',c[3],{b:1,sz:10});
        }
        if(i===0&&on){
          P.label(.5,vbTop+.55,'E_F inside',c[3],{align:'center',b:1,sz:9.5});
          if(s>=4){                      /* the overlap case */
            ctx.save();ctx.strokeStyle=C.probA(.85);ctx.lineWidth=1.6;ctx.setLineDash([4,3]);
            ctx.strokeRect(P.X(.20),P.Y(2.9),P.X(.80)-P.X(.20),P.Y(.9)-P.Y(2.9));
            ctx.restore();
            P.label(.5,3.05,'…or two bands overlapping',C.prob,{align:'center',sz:9});}
        }
        if(i===1&&on&&s>=2){             /* thermal promotion, e and h */
          ctx.save();ctx.strokeStyle=C.wall;ctx.lineWidth=1.8;
          ctx.beginPath();ctx.moveTo(P.X(.32),P.Y(vbTop-.1));ctx.lineTo(P.X(.32),P.Y(cbBot+.25));
          ctx.stroke();
          ctx.beginPath();ctx.moveTo(P.X(.32),P.Y(cbBot+.25));
          ctx.lineTo(P.X(.32)-4,P.Y(cbBot+.25)+7);ctx.lineTo(P.X(.32)+4,P.Y(cbBot+.25)+7);
          ctx.closePath();ctx.fillStyle=C.wall;ctx.fill();ctx.restore();
          ctx.save();ctx.fillStyle=C.neg;ctx.beginPath();
          ctx.arc(P.X(.32),P.Y(cbBot+.25),3.6,0,7);ctx.fill();ctx.restore();
          ctx.save();ctx.strokeStyle=C.wall;ctx.lineWidth=1.6;ctx.beginPath();
          ctx.arc(P.X(.32),P.Y(vbTop-.1),3.6,0,7);ctx.stroke();ctx.restore();
          P.label(.40,cbBot+.45,'e⁻',C.neg,{b:1,sz:9.5});
          P.label(.40,vbTop-.45,'hole',C.wall,{b:1,sz:9.5});}
        P.text(wCol/2,22,c[0],on?c[3]:C.inkA(.25),{align:'center',b:1,sz:11});
        P.text(wCol/2,H-30,c[1],on?C.inkA(.6):C.inkA(.22),{align:'center',sz:9.5});
        if(s>=4)P.text(wCol/2,H-16,i===0?'σ ∝ 1/T':i===1?'σ ∝ e^(−E_g/2k_BT)':'σ ≈ 0',
          on?c[3]:C.inkA(.25),{align:'center',b:1,sz:9.5});
        ctx.restore();});
      ctx.save();ctx.fillStyle=C.inkA(.62);ctx.font="10px 'Fira Mono',monospace";
      ctx.textBaseline='top';
      ctx.fillText(s===0?'shaded = full band · outlined = empty band · conduction needs an empty level just above a full one'
        :s===4?'the carrier count is fixed in a metal, but thermally created in a semiconductor'
        :'teal = filled valence band · outline = empty conduction band',10,7);
      ctx.restore();
    }},

  /* ── M2: electronic heat capacity, quantum vs classical ── */
  cv:{ar:.46,
    draw(ctx,W,H){const P=Plot(ctx,W,H,{l:36,r:16,t:18,b:28});P.clear();
      P.dom(0,600).ran(0,1.3).grid(6,4);P.axes();
      const TF=6e4;
      P.hline(1,C.inkA(.35),1.6,[5,3]);
      P.label(300,1.05,'classical  (3/2)R',C.inkA(.6),{align:'center',sz:9.5});
      P.curve(T=>1.5*(T/TF)*50,C.neg,2.6);        // ×50 so it is visible on the same axis
      P.label(560,1.5*(560/TF)*50+.06,'quantum',C.neg,{align:'right',b:1,sz:10});
      P.text(10,8,'C_v ≈ (3/2)R (T/T_F) — linear in T, ~1% of classical at 300 K',C.inkA(.75),{sz:10,b:1});
      P.text(10,22,'(quantum curve magnified ×50 to be visible at all)',C.inkA(.5),{sz:9});
      P.label(600,-.04,'T (K)',C.inkA(.6),{align:'right',base:'top',sz:10});
    }}
};

/* ══════════════════════════════════════════════════════════════════
   MINI 3-D ENGINE — no library. Spheres, bonds and polyhedra, depth
   sorted and drawn with a painter's algorithm. Touch + mouse.
   ══════════════════════════════════════════════════════════════════ */
const V={
  sub:(a,b)=>[a[0]-b[0],a[1]-b[1],a[2]-b[2]],
  add:(a,b)=>[a[0]+b[0],a[1]+b[1],a[2]+b[2]],
  mul:(a,s)=>[a[0]*s,a[1]*s,a[2]*s],
  dot:(a,b)=>a[0]*b[0]+a[1]*b[1]+a[2]*b[2],
  cross:(a,b)=>[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]],
  len:a=>Math.hypot(a[0],a[1],a[2]),
  norm:a=>{const l=Math.hypot(a[0],a[1],a[2])||1;return [a[0]/l,a[1]/l,a[2]/l];}
};

/* Wigner–Seitz / Brillouin cell as the intersection of the perpendicular
   bisector half-spaces of a set of neighbour vectors — genuinely computed. */
function wsCell(Gs){
  const P=Gs.map(g=>({n:V.norm(g),d:V.len(g)/2}));
  const eps=1e-7, verts=[], onPlane=P.map(()=>[]);
  for(let i=0;i<P.length;i++)for(let j=i+1;j<P.length;j++)for(let k=j+1;k<P.length;k++){
    const a=P[i].n,b=P[j].n,c=P[k].n;
    const det=V.dot(a,V.cross(b,c));
    if(Math.abs(det)<1e-9)continue;
    // Cramer: solve [a;b;c]·x = [da;db;dc]
    const x=V.mul(V.add(V.add(V.mul(V.cross(b,c),P[i].d),V.mul(V.cross(c,a),P[j].d)),
                        V.mul(V.cross(a,b),P[k].d)),1/det);
    let ok=true;
    for(const p of P){if(V.dot(p.n,x)>p.d+1e-6){ok=false;break;}}
    if(!ok)continue;
    if(verts.some(v=>V.len(V.sub(v,x))<1e-6))continue;
    verts.push(x);
  }
  verts.forEach(v=>P.forEach((p,pi)=>{if(Math.abs(V.dot(p.n,v)-p.d)<1e-6)onPlane[pi].push(v);}));
  const faces=[];
  P.forEach((p,pi)=>{
    const pts=onPlane[pi];if(pts.length<3)return;
    // order the ring by angle in the plane
    const cen=V.mul(pts.reduce((a,b)=>V.add(a,b),[0,0,0]),1/pts.length);
    let u=V.sub(pts[0],cen);u=V.norm(u);
    const w=V.norm(V.cross(p.n,u));
    const sorted=pts.slice().sort((A,B)=>{
      const a=V.sub(A,cen),b=V.sub(B,cen);
      return Math.atan2(V.dot(a,w),V.dot(a,u))-Math.atan2(V.dot(b,w),V.dot(b,u));});
    faces.push(sorted);
  });
  return {verts,faces};
}

/* ── scene builders. Each returns {balls,bonds,faces,scale} ── */
function cubeEdges(s){
  const c=[[0,0,0],[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[1,1,1],[0,1,1]]
    .map(p=>[(p[0]-.5)*s,(p[1]-.5)*s,(p[2]-.5)*s]);
  const e=[[0,1],[1,2],[2,3],[3,0],[4,5],[5,6],[6,7],[7,4],[0,4],[1,5],[2,6],[3,7]];
  return e.map(([i,j])=>({a:c[i],b:c[j]}));
}
/* ── the 7 systems: a representative cell shape for each, and the
      centrings that actually give a NEW lattice (3+2+4+1+1+2+1 = 14) ── */
const BRAVAIS_GEOM={
  cubic       :{a:1.15,b:1.15,c:1.15,al:90,be:90 ,ga:90 },
  tetragonal  :{a:1.0 ,b:1.0 ,c:1.62,al:90,be:90 ,ga:90 },
  orthorhombic:{a:.86 ,b:1.18,c:1.62,al:90,be:90 ,ga:90 },
  rhombohedral:{a:1.3 ,b:1.3 ,c:1.3 ,al:72,be:72 ,ga:72 },
  hexagonal   :{a:1.0 ,b:1.0 ,c:1.6 ,al:90,be:90 ,ga:120},
  monoclinic  :{a:.9  ,b:1.15,c:1.62,al:90,be:104,ga:90 },
  triclinic   :{a:.95 ,b:1.2 ,c:1.55,al:80,be:106,ga:74 }
};
const BRAVAIS_OK={cubic:['P','I','F'],tetragonal:['P','I'],
  orthorhombic:['P','C','I','F'],rhombohedral:['P'],hexagonal:['P'],
  monoclinic:['P','C'],triclinic:['P']};
const BRAVAIS_TXT={
  cubic       :{n:'Cubic'                 ,len:'a = b = c'  ,ang:'\u03b1 = \u03b2 = \u03b3 = 90\u00b0'},
  tetragonal  :{n:'Tetragonal'            ,len:'a = b \u2260 c'  ,ang:'\u03b1 = \u03b2 = \u03b3 = 90\u00b0'},
  orthorhombic:{n:'Orthorhombic'          ,len:'a \u2260 b \u2260 c'  ,ang:'\u03b1 = \u03b2 = \u03b3 = 90\u00b0'},
  rhombohedral:{n:'Rhombohedral / trigonal',len:'a = b = c' ,ang:'\u03b1 = \u03b2 = \u03b3 \u2260 90\u00b0'},
  hexagonal   :{n:'Hexagonal'             ,len:'a = b \u2260 c'  ,ang:'\u03b1 = \u03b2 = 90\u00b0, \u03b3 = 120\u00b0'},
  monoclinic  :{n:'Monoclinic'            ,len:'a \u2260 b \u2260 c'  ,ang:'\u03b1 = \u03b3 = 90\u00b0 \u2260 \u03b2'},
  triclinic   :{n:'Triclinic'             ,len:'a \u2260 b \u2260 c'  ,ang:'\u03b1 \u2260 \u03b2 \u2260 \u03b3 \u2260 90\u00b0'}
};
const BRAVAIS_TAG={P:'primitive \u2014 corners only',C:'base-centred \u2014 one pair of faces',
  I:'body-centred \u2014 one point at the middle',F:'face-centred \u2014 all six faces'};
const BRAVAIS_N={P:1,C:2,I:2,F:4};
const bravaisCtr=o=>{const ok=BRAVAIS_OK[o.sys]||['P'];
  return ok.indexOf(o.ctr)<0?ok[0]:o.ctr;};

/* cell + axes + origin, shared by every cube-based construction model */
function cellScaffold(lo,hi){
  /* crystal (a,b,c) → engine axes, so c stands upright on screen */
  const T=p=>[p[0]-.5,p[2]-.5,p[1]-.5];
  const balls=[],bonds=[],faces=[],labels=[];
  if(lo[0]<0||lo[1]<0||lo[2]<0)
    boxEdges(lo,hi).forEach(e=>bonds.push({a:T(e[0]),b:T(e[1]),col:'rule2',w:1}));
  boxEdges([0,0,0],[1,1,1]).forEach(e=>bonds.push({a:T(e[0]),b:T(e[1]),col:'rule',w:1.3}));
  [[1.46,0,0,'a'],[0,1.42,0,'b'],[0,0,1.40,'c']].forEach(A=>{
    bonds.push({a:T([0,0,0]),b:T([A[0],A[1],A[2]]),col:'rule',w:1.4});
    labels.push({p:T([A[0]*1.13,A[1]*1.13,A[2]*1.13]),t:A[3],col:'ink'});});
  balls.push({c:T([0,0,0]),r:.038,col:'rule'});
  labels.push({p:T([-.13,-.13,-.06]),t:'O',col:'rule'});
  return {T,balls,bonds,faces,labels};
}

const MODELS={
  /* every one of the 14 Bravais lattices: cell shape \u00d7 legal centring */
  bravais(opt){
    const sys=BRAVAIS_GEOM[opt.sys]?opt.sys:'cubic', ctr=bravaisCtr({sys,ctr:opt.ctr});
    const g=BRAVAIS_GEOM[sys], rd=d=>d*Math.PI/180;
    const ca=Math.cos(rd(g.al)),cb=Math.cos(rd(g.be)),cg=Math.cos(rd(g.ga)),sg=Math.sin(rd(g.ga));
    const A=[g.a,0,0], B=[g.b*cg,g.b*sg,0];
    const qx=cb, qy=(ca-cb*cg)/sg;
    const Cv=[g.c*qx,g.c*qy,g.c*Math.sqrt(Math.max(1e-9,1-qx*qx-qy*qy))];
    /* centre of the picture: the cell's own middle, except for hexagonal, where the
       cell is one third of a prism and the prism axis is the honest centre */
    const mid=sys==='hexagonal'?[Cv[0]/2,Cv[1]/2,Cv[2]/2]
      :[(A[0]+B[0]+Cv[0])/2,(A[1]+B[1]+Cv[1])/2,(A[2]+B[2]+Cv[2])/2];
    /* crystal axes (x,y,z) \u2192 engine axes, so c stands upright on screen */
    const at=(i,j,k)=>{const x=A[0]*i+B[0]*j+Cv[0]*k-mid[0],
                             y=A[1]*i+B[1]*j+Cv[1]*k-mid[1],
                             z=A[2]*i+B[2]*j+Cv[2]*k-mid[2];
      return [x,z,y];};
    const balls=[],bonds=[],faces=[],labels=[];
    const corners=[];
    for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)corners.push([i,j,k]);
    corners.forEach(p=>balls.push({c:at(p[0],p[1],p[2]),r:.105,col:'pos'}));
    for(let x=0;x<8;x++)for(let y=x+1;y<8;y++){
      const p=corners[x],q=corners[y];
      if(Math.abs(p[0]-q[0])+Math.abs(p[1]-q[1])+Math.abs(p[2]-q[2])===1)
        bonds.push({a:at(p[0],p[1],p[2]),b:at(q[0],q[1],q[2]),col:'rule',w:1.4});}
    /* the extra points that centring adds */
    const extra={P:[],I:[[.5,.5,.5]],C:[[.5,.5,0],[.5,.5,1]],
      F:[[.5,.5,0],[.5,.5,1],[.5,0,.5],[.5,1,.5],[0,.5,.5],[1,.5,.5]]}[ctr]||[];
    extra.forEach(p=>balls.push({c:at(p[0],p[1],p[2]),r:.125,col:'neg'}));
    if(ctr==='I')corners.forEach(p=>bonds.push({a:at(.5,.5,.5),b:at(p[0],p[1],p[2]),
      col:'neg',w:1.1}));
    /* shade the faces that actually carry a centring point */
    const FACE={z0:[[0,0,0],[1,0,0],[1,1,0],[0,1,0]],z1:[[0,0,1],[1,0,1],[1,1,1],[0,1,1]],
                y0:[[0,0,0],[1,0,0],[1,0,1],[0,0,1]],y1:[[0,1,0],[1,1,0],[1,1,1],[0,1,1]],
                x0:[[0,0,0],[0,1,0],[0,1,1],[0,0,1]],x1:[[1,0,0],[1,1,0],[1,1,1],[1,0,1]]};
    const shade=(k,al)=>faces.push({pts:FACE[k].map(p=>at(p[0],p[1],p[2])),col:'neg',alpha:al});
    if(ctr==='C')['z0','z1'].forEach(k=>shade(k,.16));
    if(ctr==='F')Object.keys(FACE).forEach(k=>shade(k,.085));
    /* the hexagonal cell only makes sense next to the prism three of them build */
    if(sys==='hexagonal'){
      const ring=[[1,0],[1,1],[0,1],[-1,0],[-1,-1],[0,-1]];
      [0,1].forEach(k=>{const pts=ring.map(r=>at(r[0],r[1],k));
        for(let i=0;i<6;i++)bonds.push({a:pts[i],b:pts[(i+1)%6],col:'rule2',w:1.1});});
      ring.forEach(r=>{bonds.push({a:at(r[0],r[1],0),b:at(r[0],r[1],1),col:'rule2',w:1.1});
        if(r[0]<0||r[1]<0)[0,1].forEach(k=>balls.push({c:at(r[0],r[1],k),r:.08,col:'rule2'}));});
    }
    /* name the three cell edges */
    const lab=(i,j,k,t)=>{const q=at(i,j,k);
      labels.push({p:[q[0]*1.17,q[1]*1.17,q[2]*1.17],t,col:'pos'});};
    lab(.5,0,0,'a');lab(0,.5,0,'b');lab(0,0,.5,'c');
    return {balls,bonds,faces,labels};
  },

  /* ── shared scaffolding for the cube-based constructions ── */
  /* (kept as a plain function so every model below can reuse it) */

  /* draw (hkl) from its indices — the same five steps, now in the round */
  miller3d(opt){
    const s=opt.step==null?4:opt.step,hkl=opt.hkl||[1,1,0];
    const h=hkl[0],k=hkl[1],l=hkl[2];
    const lo=[h<0?-1:0,k<0?-1:0,l<0?-1:0],hi=[1,1,1];
    const sc=cellScaffold(lo,hi),T=sc.T;
    const {balls,bonds,faces,labels}=sc;
    if(s>=2){[[h,[1/h,0,0],'a',[0,-.24,-.16]],[k,[0,1/k,0],'b',[-.24,0,-.16]],
             [l,[0,0,1/l],'c',[-.20,-.20,0]]].forEach(c=>{
      if(!c[0])return;
      balls.push({c:T(c[1]),r:.055,col:'pos'});
      labels.push({p:T([c[1][0]+c[3][0],c[1][1]+c[3][1],c[1][2]+c[3][2]]),
                   t:interceptTxt(c[2],c[0]),col:'pos'});});}
    const face=planeBox(h,k,l,lo,hi).map(T);
    if(s>=3&&face.length)for(let i=0;i<face.length;i++)
      bonds.push({a:face[i],b:face[(i+1)%face.length],col:'accent',w:2.6});
    if(s>=4&&face.length)faces.push({pts:face,col:'accent',alpha:.32});
    return {balls,bonds,faces,labels};
  },

  /* walk out the direction [uvw] */
  dir3d(opt){
    const s=opt.step==null?4:opt.step,uvw=opt.uvw||[1,1,1];
    const mx=Math.max.apply(null,uvw.map(Math.abs))||1, v=uvw.map(n=>n/mx);
    const lo=[v[0]<0?-1:0,v[1]<0?-1:0,v[2]<0?-1:0];
    const sc=cellScaffold(lo,[1,1,1]),T=sc.T;
    const {balls,bonds,faces,labels}=sc;
    const leg=[[0,0,0],[v[0],0,0],[v[0],v[1],0],[v[0],v[1],v[2]]];
    if(s>=3)for(let i=0;i<3;i++){
      if(Math.abs(leg[i+1][i]-leg[i][i])<1e-9)continue;
      bonds.push({a:T(leg[i]),b:T(leg[i+1]),col:'neg',w:2.4});
      balls.push({c:T(leg[i+1]),r:.04,col:'neg'});}
    if(s>=4){
      bonds.push({a:T([0,0,0]),b:T(v),col:'pos',w:3.4});
      balls.push({c:T(v),r:.06,col:'pos'});
      labels.push({p:T([v[0]+.10,v[1]+.16,v[2]+.10]),
        t:'['+uvw.map(n=>n<0?Math.abs(n)+'̅':''+n).join('')+']',col:'pos'});}
    return {balls,bonds,faces,labels};
  },

  /* the perpendicular ON that gives d = a/√(h²+k²+l²) */
  dgeom3d(opt){
    const s=opt.step==null?4:opt.step,hkl=opt.hkl||[1,1,1];
    const h=hkl[0],k=hkl[1],l=hkl[2],S=h*h+k*k+l*l,N=[h/S,k/S,l/S];
    const sc=cellScaffold([0,0,0],[1,1,1]),T=sc.T;
    const {balls,bonds,faces,labels}=sc;
    const face=planeBox(h,k,l,[0,0,0],[1,1,1]).map(T);
    if(face.length){faces.push({pts:face,col:'accent',alpha:.22});
      for(let i=0;i<face.length;i++)
        bonds.push({a:face[i],b:face[(i+1)%face.length],col:'accent',w:2.2});}
    const cuts=[[h,[1/h,0,0],'a',[0,-.24,-.16]],[k,[0,1/k,0],'b',[-.24,0,-.16]],
                [l,[0,0,1/l],'c',[-.20,-.20,0]]];
    cuts.forEach(c=>{if(!c[0])return;
      balls.push({c:T(c[1]),r:.05,col:'pos'});
      labels.push({p:T([c[1][0]+c[3][0],c[1][1]+c[3][1],c[1][2]+c[3][2]]),
                   t:interceptTxt(c[2],c[0]),col:'pos'});});
    if(s>=1){
      bonds.push({a:T([0,0,0]),b:T(N),col:'wall',w:3.4});
      balls.push({c:T(N),r:.055,col:'wall'});
      labels.push({p:T([N[0]/2+.10,N[1]/2+.10,N[2]/2+.13]),t:'d',col:'wall'});
      labels.push({p:T([N[0]+.13,N[1]+.13,N[2]+.13]),t:'N',col:'wall'});}
    if(s>=2){
      const u=Math.hypot(N[0],N[1],N[2]);
      cuts.forEach((c,i)=>{if(!c[0])return;
        bonds.push({a:T(N),b:T(c[1]),col:'rule2',w:1});
        const t=.42,e=[0,0,0];e[i]=1;
        labels.push({p:T([N[0]/u*t+e[0]*t,N[1]/u*t+e[1]*t,N[2]/u*t+e[2]*t]),
                     t:['α','β','γ'][i],col:'neg'});});}
    return {balls,bonds,faces,labels};
  },

  /* along which line do the spheres touch, and what does that make a? */
  pack3d(opt){
    const s=opt.step==null?4:opt.step,kind=opt.kind||'bcc';
    const D={sc :{pts:[[0,0,0],[1,0,0]],           r:.5},
             bcc:{pts:[[0,0,0],[.5,.5,.5],[1,1,1]],r:Math.sqrt(3)/4},
             fcc:{pts:[[0,0,0],[.5,.5,0],[1,1,0]], r:Math.SQRT2/4}}[kind];
    const sc=cellScaffold([0,0,0],[1,1,1]),T=sc.T;
    const balls=sc.balls,bonds=sc.bonds,faces=sc.faces,labels=sc.labels;
    const first=D.pts[0],last=D.pts[D.pts.length-1];
    if(s>=1){
      bonds.push({a:T(first),b:T(last),col:'accent',w:2.8});
      if(s<2)D.pts.forEach(q=>balls.push({c:T(q),r:.055,col:'pos'}));}
    if(s>=2)D.pts.forEach(q=>balls.push({c:T(q),r:D.r,col:'pos'}));
    if(s>=3){
      const dv=[last[0]-first[0],last[1]-first[1],last[2]-first[2]];
      let pv=V.cross(dv,[0,1,0]);
      if(V.len(pv)<1e-6)pv=V.cross(dv,[1,0,0]);
      pv=V.mul(V.norm(pv),.62);
      const t=.62;
      labels.push({p:T([first[0]+dv[0]*t+pv[0],first[1]+dv[1]*t+pv[1],first[2]+dv[2]*t+pv[2]]),
        t:(kind==='sc'?'a = 2r':kind==='bcc'?'√3a = 4r':'√2a = 4r'),col:'accent'});}
    return {balls,bonds,faces,labels};
  },

  /* the tetrahedron behind ideal c/a = √(8/3) */
  hcp3d(opt){
    const s=opt.step==null?3:opt.step;
    const R=1/Math.sqrt(3),c2=Math.sqrt(2/3);
    const cor=[0,1,2].map(i=>{const t=Math.PI/2+i*2*Math.PI/3;
      return [R*Math.cos(t),0,R*Math.sin(t)];});
    const top=[0,c2,0],cen=[0,0,0];
    const balls=[],bonds=[],faces=[],labels=[];
    const rr=s===0?.5:.14;
    cor.forEach(q=>balls.push({c:q,r:rr,col:'pos'}));
    for(let i=0;i<3;i++)bonds.push({a:cor[i],b:cor[(i+1)%3],col:'pos',w:2});
    labels.push({p:[(cor[1][0]+cor[2][0])/2*1.55,-.10,(cor[1][2]+cor[2][2])/2*1.55],
                 t:'a',col:'pos'});
    if(s>=1){
      const midOpp=[(cor[1][0]+cor[2][0])/2,0,(cor[1][2]+cor[2][2])/2];
      bonds.push({a:cor[0],b:midOpp,col:'rule',w:1.2});
      balls.push({c:cen,r:.055,col:'neg'});
      bonds.push({a:cen,b:cor[1],col:'neg',w:2.4});
      labels.push({p:[cor[1][0]/2,.13,cor[1][2]/2],t:'a/√3',col:'neg'});}
    if(s>=2){
      balls.push({c:top,r:rr,col:'neg'});
      bonds.push({a:cen,b:top,col:'accent',w:2.6});
      bonds.push({a:cor[1],b:top,col:'pos',w:2.6});
      labels.push({p:[.16,c2/2,.16],t:'c/2',col:'accent'});
      labels.push({p:[(cor[1][0]+top[0])/2-.18,(cor[1][1]+top[1])/2+.10,
                      (cor[1][2]+top[2])/2-.18],t:'a',col:'pos'});
      cor.forEach(q=>bonds.push({a:q,b:top,col:'rule2',w:1}));}
    return {balls,bonds,faces,labels};
  },

  /* who owns the atom: 1/8 at a corner, 1/2 on a face, all of it inside */
  count3d(opt){
    const s=opt.step==null?4:opt.step,kind=opt.kind||'fcc';
    const T=p=>[p[0]-.5,p[2]-.5,p[1]-.5];
    const balls=[],bonds=[],faces=[],labels=[];
    const cor=[];for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)cor.push([i,j,k]);
    const fac=[[.5,.5,0],[.5,.5,1],[.5,0,.5],[.5,1,.5],[0,.5,.5],[1,.5,.5]];
    /* the neighbouring cells that do the sharing */
    if(s===1)for(let i=-1;i<1;i++)for(let j=-1;j<1;j++)for(let k=-1;k<1;k++){
      if(!i&&!j&&!k)continue;
      boxEdges([i,j,k],[i+1,j+1,k+1]).forEach(e=>
        bonds.push({a:T(e[0]),b:T(e[1]),col:'rule2',w:.9}));}
    if(s===2&&kind==='fcc')boxEdges([0,0,-1],[1,1,0]).forEach(e=>
      bonds.push({a:T(e[0]),b:T(e[1]),col:'rule2',w:.9}));
    boxEdges([0,0,0],[1,1,1]).forEach(e=>bonds.push({a:T(e[0]),b:T(e[1]),col:'rule',w:1.4}));
    cor.forEach(q=>balls.push({c:T(q),r:.10,col:(s===1?'wall':'pos')}));
    if(kind==='fcc')fac.forEach(q=>balls.push({c:T(q),r:.10,col:(s===2?'wall':'neg')}));
    if(kind==='bcc')balls.push({c:T([.5,.5,.5]),r:.10,col:(s===3?'wall':'neg')});
    if(s===1)labels.push({p:T([-.16,-.16,-.16]),t:'⅛',col:'wall'});
    if(s===2&&kind==='fcc')labels.push({p:T([.5,.5,-.20]),t:'½',col:'wall'});
    if(s===3&&kind==='bcc')labels.push({p:T([.5,.68,.5]),t:'1',col:'wall'});
    return {balls,bonds,faces,labels};
  },

  /* the symmetry elements a cube actually has */
  sym3d(opt){
    const s=opt.step==null?4:opt.step;
    const T=p=>[p[0],p[1],p[2]];
    const balls=[],bonds=[],faces=[],labels=[];
    cubeEdges(1).forEach(e=>bonds.push(Object.assign(e,{col:'rule',w:1.3})));
    const axis=(v,col,w)=>bonds.push({a:V.mul(v,-.86),b:V.mul(v,.86),col,w:w||2.6});
    if(s>=1)[[1,0,0],[0,1,0],[0,0,1]].forEach(v=>axis(v,'pos',3));
    if(s>=2)[[1,1,1],[1,1,-1],[1,-1,1],[-1,1,1]]
      .forEach(v=>axis(V.mul(V.norm(v),1.05),'neg',2.4));
    if(s>=3)[[1,1,0],[1,-1,0],[1,0,1],[1,0,-1],[0,1,1],[0,1,-1]]
      .forEach(v=>axis(V.mul(V.norm(v),.95),'accent',1.8));
    if(s>=4){
      const q=.5;
      [[[q,q,0],[-q,q,0],[-q,-q,0],[q,-q,0]],
       [[q,0,q],[-q,0,q],[-q,0,-q],[q,0,-q]],
       [[0,q,q],[0,-q,q],[0,-q,-q],[0,q,-q]]]
        .forEach(f=>faces.push({pts:f,col:'accent',alpha:.16}));
      const d=.5*Math.SQRT2;
      faces.push({pts:[[-q,-q,-q],[q,q,-q],[q,q,q],[-q,-q,q]],col:'wall',alpha:.14});
      faces.push({pts:[[q,-q,-q],[-q,q,-q],[-q,q,q],[q,-q,q]],col:'wall',alpha:.14});}
    return {balls,bonds,faces,labels};
  },

  /* lattice + basis = structure, built one atom at a time */
  basis3d(opt){
    const s=opt.step==null?4:opt.step,kind=opt.kind||'diamond';
    const B={diamond:{off:[.25,.25,.25],c2:'neg',d:Math.sqrt(3)/4,r1:.11,r2:.11},
             zns    :{off:[.25,.25,.25],c2:'accent',d:Math.sqrt(3)/4,r1:.13,r2:.09},
             nacl   :{off:[.5,0,0],     c2:'neg',d:.5,r1:.11,r2:.17}}[kind];
    const T=p=>[p[0]-.5,p[2]-.5,p[1]-.5];
    const balls=[],bonds=[],faces=[],labels=[];
    const fcc=[];
    for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)fcc.push([i,j,k]);
    [[.5,.5,0],[.5,.5,1],[.5,0,.5],[.5,1,.5],[0,.5,.5],[1,.5,.5]].forEach(q=>fcc.push(q));
    boxEdges([0,0,0],[1,1,1]).forEach(e=>bonds.push({a:T(e[0]),b:T(e[1]),col:'rule',w:1.3}));
    fcc.forEach(q=>balls.push({c:T(q),r:s===0?.055:B.r1,col:s===0?'rule2':'pos'}));
    const two=[];
    if(s>=2)fcc.forEach(q=>{const w=[q[0]+B.off[0],q[1]+B.off[1],q[2]+B.off[2]];
      if(w[0]<=1.001&&w[1]<=1.001&&w[2]<=1.001)two.push(w);});
    two.forEach(q=>balls.push({c:T(q),r:B.r2,col:B.c2}));
    if(s>=3)two.forEach(q=>fcc.forEach(w=>{
      const dd=Math.hypot(q[0]-w[0],q[1]-w[1],q[2]-w[2]);
      if(Math.abs(dd-B.d)<1e-6)bonds.push({a:T(q),b:T(w),col:'accent',w:kind==='nacl'?1.2:2.2});}));
    return {balls,bonds,faces,labels};
  },

  /* the Fermi sphere: allowed k states filled from the middle out */
  fermi3d(opt){
    const s=opt.step==null?4:opt.step,kF=2.6;
    const balls=[],bonds=[],faces=[],labels=[];
    for(let i=-3;i<=3;i++)for(let j=-3;j<=3;j++)for(let k=-3;k<=3;k++){
      const d=Math.hypot(i,j,k);if(d>3.35)continue;
      const inside=d<=kF+1e-9;
      balls.push({c:[i,j,k],r:.11,col:(s>=1&&inside)?'neg':'rule2'});}
    if(s>=2){                                   // a wireframe sphere of radius kF
      const ring=(f)=>{const pts=[];for(let t=0;t<=48;t++)pts.push(f(t/48*2*Math.PI));
        for(let t=0;t<48;t++)bonds.push({a:pts[t],b:pts[t+1],col:'accent',w:1.1});};
      ring(t=>[kF*Math.cos(t),kF*Math.sin(t),0]);
      ring(t=>[kF*Math.cos(t),0,kF*Math.sin(t)]);
      ring(t=>[0,kF*Math.cos(t),kF*Math.sin(t)]);
      for(const y of [-1.6,1.6]){const rr=Math.sqrt(kF*kF-y*y);
        ring(t=>[rr*Math.cos(t),y,rr*Math.sin(t)]);}
      bonds.push({a:[0,0,0],b:[kF*.71,0,kF*.71],col:'wall',w:2.6});
      labels.push({p:[kF*.40,.22,kF*.40],t:'k_F',col:'wall'});}
    if(s>=3)['k_x','k_y','k_z'].forEach((t,i)=>{
      const e=[0,0,0];e[i]=3.35;
      bonds.push({a:[0,0,0],b:e,col:'rule',w:1.2});
      labels.push({p:V.mul(e,1.08),t:t,col:'ink'});});
    return {balls,bonds,faces,labels};
  },

  /* Laue: two scatterers, one path difference, three equations */
  laue3d(opt){
    const s=opt.step==null?5:opt.step,ax=opt.ax||'a';
    const r={a:[1,0,0],b:[0,1,0],c:[0,0,1]}[ax];
    const E=q=>[q[0],q[2],q[1]];                 // c upright, as everywhere else
    const n1=V.norm([1,-.30,.52]), n2=V.norm([1,.52,-.16]);
    const N=V.sub(n1,n2);
    const balls=[],bonds=[],faces=[],labels=[];
    const A=[0,0,0],B=r;
    /* the crystal axes, so “along a, along b, along c” means something */
    [[1,0,0,'a'],[0,1,0,'b'],[0,0,1,'c']].forEach(u=>{
      const v=[u[0],u[1],u[2]];
      bonds.push({a:E(A),b:E(V.mul(v,1.25)),col:'rule',w:1.1});
      labels.push({p:E(V.mul(v,1.42)),t:u[3],col:'ink'});
      balls.push({c:E(v),r:.05,col:'rule2'});});
    balls.push({c:E(A),r:.085,col:'pos'});
    balls.push({c:E(B),r:.085,col:'pos'});
    labels.push({p:E([A[0]-.16,A[1]-.16,A[2]+.16]),t:'A',col:'pos'});
    labels.push({p:E([B[0]+.14,B[1]+.14,B[2]+.16]),t:'B',col:'pos'});
    if(s>=1){                                   // the incoming beam, parallel through both
      [A,B].forEach(q=>bonds.push({a:E(V.sub(q,V.mul(n1,1.55))),b:E(q),col:'accent',w:2.2}));
      labels.push({p:E(V.sub(A,V.mul(n1,1.25))),t:'n̂₁',col:'accent'});}
    if(s>=2){                                   // and the scattered beam
      [A,B].forEach(q=>bonds.push({a:E(q),b:E(V.add(q,V.mul(n2,1.55))),col:'neg',w:2.2}));
      labels.push({p:E(V.add(A,V.mul(n2,1.25))),t:'n̂₂',col:'neg'});}
    if(s>=3){                                   // the two bits of extra path
      const P=V.sub(B,V.mul(n1,V.dot(r,n1)));   // foot of ⊥ from A onto B's incoming ray
      const Q=V.add(B,V.mul(n2,-V.dot(r,n2)));  // foot of ⊥ from A onto B's outgoing ray
      bonds.push({a:E(A),b:E(P),col:'rule2',w:1});
      bonds.push({a:E(A),b:E(Q),col:'rule2',w:1});
      bonds.push({a:E(P),b:E(B),col:'wall',w:3.4});
      bonds.push({a:E(B),b:E(Q),col:'wall',w:3.4});
      const up=q=>[q[0],q[1],q[2]+.20];
      labels.push({p:E(up(V.mul(V.add(P,B),.5))),t:'r·n̂₁',col:'wall'});
      labels.push({p:E(up(V.mul(V.add(Q,B),.5))),t:'r·n̂₂',col:'wall'});}
    if(s>=4){                                   // r itself, and N = n̂₁ − n̂₂
      bonds.push({a:E(A),b:E(B),col:'accent',w:3});
      labels.push({p:E(V.mul(V.add(A,B),.5)),t:'r',col:'accent'});
      bonds.push({a:E(A),b:E(V.mul(N,1.5)),col:'wall',w:2.2});
      labels.push({p:E(V.mul(N,1.72)),t:'N',col:'wall'});}
    return {balls,bonds,faces,labels};
  },

  /* a family of planes → one arrow → one reciprocal lattice point */
  recip3d(opt){
    const s=opt.step==null?4:opt.step,hkl=opt.hkl||[1,0,0];
    const h=hkl[0],k=hkl[1],l=hkl[2],S=h*h+k*k+l*l;
    const T=p=>[p[0]-.5,p[2]-.5,p[1]-.5];
    const lo=[-.75,-.75,-.75],hi=[1,1,1];
    const balls=[],bonds=[],faces=[],labels=[];
    boxEdges([0,0,0],[1,1,1]).forEach(e=>bonds.push({a:T(e[0]),b:T(e[1]),col:'rule',w:1.2}));
    [[1.30,0,0,'a'],[0,1.26,0,'b'],[0,0,1.24,'c']].forEach(A=>{
      bonds.push({a:T([0,0,0]),b:T([A[0],A[1],A[2]]),col:'rule',w:1.2});
      labels.push({p:T([A[0]*1.14,A[1]*1.14,A[2]*1.14]),t:A[3],col:'ink'});});
    [0,1].forEach(m=>{                          // two planes of the family
      const f=planeBox(h,k,l,lo,hi,m).map(T);
      if(f.length<3)return;
      faces.push({pts:f,col:'accent',alpha:m?.24:.12});
      for(let i=0;i<f.length;i++)
        bonds.push({a:f[i],b:f[(i+1)%f.length],col:'accent',w:m?2.2:1.2});});
    const nrm=V.norm([h,k,l]),d=1/Math.sqrt(S);
    if(s>=1){                                   // which way it faces
      bonds.push({a:T([0,0,0]),b:T(V.mul(nrm,d)),col:'wall',w:2.6});
      labels.push({p:T(V.mul(nrm,d*.55+.10)),t:'d',col:'wall'});}
    if(s>=2){                                   // …and how far apart: |G| ∝ 1/d
      const G=V.mul([h,k,l],.55);
      bonds.push({a:T([0,0,0]),b:T(G),col:'neg',w:3.2});
      balls.push({c:T(G),r:.075,col:'neg'});
      labels.push({p:T(V.mul(G,1.20)),t:'G',col:'neg'});}
    if(s>=3){                                   // every family at once → a lattice
      for(let i=-1;i<=1;i++)for(let j=-1;j<=1;j++)for(let m=-1;m<=1;m++){
        if(!i&&!j&&!m)continue;
        balls.push({c:T(V.mul([i,j,m],.55)),r:.05,col:'rule2'});}}
    balls.push({c:T([0,0,0]),r:.05,col:'rule'});
    return {balls,bonds,faces,labels};
  },

  /* SC / BCC / FCC, ball-and-stick or space-filling */
  cubic(opt){
    const kind=opt.kind||'fcc', fill=!!opt.fill, s=1;
    const P=[];const corner=[];
    for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)corner.push([i,j,k]);
    corner.forEach(p=>P.push({p,type:0}));
    if(kind==='bcc')P.push({p:[.5,.5,.5],type:1});
    if(kind==='fcc'){[[.5,.5,0],[.5,.5,1],[.5,0,.5],[.5,1,.5],[0,.5,.5],[1,.5,.5]]
      .forEach(p=>P.push({p,type:1}));}
    const rc={sc:.5,bcc:Math.sqrt(3)/4,fcc:Math.SQRT2/4}[kind];
    const r=fill?rc:.13;
    const balls=P.map(o=>({c:[(o.p[0]-.5)*s,(o.p[1]-.5)*s,(o.p[2]-.5)*s],r:r*s,
      col:o.type?'pos':'neg'}));
    let bonds=cubeEdges(s).map(e=>Object.assign(e,{col:'rule'}));
    if(!fill&&kind!=='sc'){ // contact directions
      const centre=kind==='bcc'?[[.5,.5,.5]]:[[.5,.5,0],[.5,0,.5],[0,.5,.5],[.5,.5,1],[.5,1,.5],[1,.5,.5]];
      centre.forEach(cp=>{corner.forEach(q=>{
        const d=Math.hypot(cp[0]-q[0],cp[1]-q[1],cp[2]-q[2]);
        const want=kind==='bcc'?Math.sqrt(3)/2:Math.SQRT2/2;
        if(Math.abs(d-want)<1e-6)bonds.push({a:[(cp[0]-.5)*s,(cp[1]-.5)*s,(cp[2]-.5)*s],
          b:[(q[0]-.5)*s,(q[1]-.5)*s,(q[2]-.5)*s],col:'accent',w:1.6});});});
    }
    return {balls,bonds,faces:[]};
  },

  /* hexagonal close packed, ABAB */
  hcp(){
    const a=1,c=a*Math.sqrt(8/3),balls=[],bonds=[];
    const hex=y=>{const o=[];for(let i=0;i<6;i++){const t=i*Math.PI/3;
      o.push([a*Math.cos(t),y,a*Math.sin(t)]);}return o;};
    [-c/2,c/2].forEach(y=>{hex(y).forEach(p=>balls.push({c:p,r:.16,col:'pos'}));
      balls.push({c:[0,y,0],r:.16,col:'pos'});});
    // B layer: three atoms over alternate hollows, at radius a/√3
    for(let i=0;i<3;i++){const t=Math.PI/6+i*2*Math.PI/3;
      balls.push({c:[a/Math.sqrt(3)*Math.cos(t),0,a/Math.sqrt(3)*Math.sin(t)],r:.16,col:'neg'});}
    [-c/2,c/2].forEach(y=>{const h=hex(y);
      for(let i=0;i<6;i++)bonds.push({a:h[i],b:h[(i+1)%6],col:'rule'});});
    const hb=hex(-c/2),ht=hex(c/2);
    for(let i=0;i<6;i++)bonds.push({a:hb[i],b:ht[i],col:'rule'});
    return {balls,bonds,faces:[]};
  },

  /* diamond cubic: FCC sites + 4 tetrahedral basis atoms, with bonds */
  diamond(){
    const s=1,sites=[],balls=[],bonds=[];
    for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)sites.push([i,j,k]);
    [[.5,.5,0],[.5,.5,1],[.5,0,.5],[.5,1,.5],[0,.5,.5],[1,.5,.5]].forEach(p=>sites.push(p));
    const inner=[[.25,.25,.25],[.75,.75,.25],[.75,.25,.75],[.25,.75,.75]];
    const T=p=>[(p[0]-.5)*s,(p[1]-.5)*s,(p[2]-.5)*s];
    sites.forEach(p=>balls.push({c:T(p),r:.11,col:'pos'}));
    inner.forEach(p=>balls.push({c:T(p),r:.11,col:'neg'}));
    inner.forEach(q=>sites.forEach(p=>{
      const d=Math.hypot(p[0]-q[0],p[1]-q[1],p[2]-q[2]);
      if(Math.abs(d-Math.sqrt(3)/4)<1e-6)bonds.push({a:T(q),b:T(p),col:'accent',w:2.2});}));
    cubeEdges(s).forEach(e=>bonds.push(Object.assign(e,{col:'rule'})));
    return {balls,bonds,faces:[]};
  },

  /* rock salt: alternating ions on a half-spaced grid */
  nacl(){
    const s=1,balls=[],bonds=[],pts=[];
    for(let i=0;i<3;i++)for(let j=0;j<3;j++)for(let k=0;k<3;k++)pts.push([i/2,j/2,k/2]);
    const T=p=>[(p[0]-.5)*s,(p[1]-.5)*s,(p[2]-.5)*s];
    pts.forEach(p=>{const par=(p[0]*2+p[1]*2+p[2]*2)%2;
      balls.push({c:T(p),r:par?.20:.13,col:par?'neg':'pos'});});
    pts.forEach(p=>pts.forEach(q=>{
      const d=Math.hypot(p[0]-q[0],p[1]-q[1],p[2]-q[2]);
      if(Math.abs(d-.5)<1e-6&&p[0]*4+p[1]*2+p[2]<q[0]*4+q[1]*2+q[2])
        bonds.push({a:T(p),b:T(q),col:'rule',w:1});}));
    return {balls,bonds,faces:[]};
  },

  /* first Brillouin zone, built from the true bisector half-spaces */
  bz(opt){
    const which=opt.which||'fcc',st=opt.step==null?9:opt.step;
    let Gs;
    if(which==='bcc'){ // BCC crystal → FCC reciprocal → the 12 shortest G
      Gs=[[1,1,0],[1,-1,0],[-1,1,0],[-1,-1,0],[1,0,1],[1,0,-1],[-1,0,1],[-1,0,-1],
          [0,1,1],[0,1,-1],[0,-1,1],[0,-1,-1]];
    }else{ // FCC crystal → BCC reciprocal → 8 ⟨111⟩ + 6 ⟨200⟩
      Gs=[];for(let a=-1;a<=1;a+=2)for(let b=-1;b<=1;b+=2)for(let c=-1;c<=1;c+=2)Gs.push([a,b,c]);
      [[2,0,0],[-2,0,0],[0,2,0],[0,-2,0],[0,0,2],[0,0,-2]].forEach(g=>Gs.push(g));
    }
    const cell=wsCell(Gs);
    const balls=[],bonds=[],faces=[];
    if(st<9){                                   // the construction, one move at a time
      balls.push({c:[0,0,0],r:.09,col:'neg'});
      Gs.forEach(g=>balls.push({c:g,r:.07,col:'rule2'}));
      if(st>=1)Gs.forEach(g=>bonds.push({a:[0,0,0],b:g,col:'rule',w:1}));
      if(st>=2&&st<=3)Gs.forEach(g=>{           // the bisecting plane of each G
        const n=V.norm(g),h=V.len(g)/2;
        let u=V.cross(n,[0,0,1]);if(V.len(u)<1e-6)u=V.cross(n,[1,0,0]);
        u=V.mul(V.norm(u),.62);const w=V.mul(V.norm(V.cross(n,u)),.62);
        const c=V.mul(n,h);
        faces.push({pts:[V.add(V.add(c,u),w),V.add(V.sub(c,u),w),
                         V.sub(V.sub(c,u),w),V.sub(V.add(c,u),w)],col:'accent',alpha:.13});});
    }
    if(st>=3||st===9){
      cell.faces.forEach(p=>faces.push({pts:p,col:'accent',alpha:st>=4||st===9?.30:.16}));
      cell.faces.forEach(p=>{for(let i=0;i<p.length;i++)
        bonds.push({a:p[i],b:p[(i+1)%p.length],col:'accent',w:1.9});});
    }
    return {balls,bonds,faces,axes:true};
  },

  /* 3-D Wigner–Seitz cell of a BCC lattice, same construction in real space */
  ws(){
    const Gs=[];
    for(let a=-1;a<=1;a+=2)for(let b=-1;b<=1;b+=2)for(let c=-1;c<=1;c+=2)Gs.push([a,b,c]);
    [[2,0,0],[-2,0,0],[0,2,0],[0,-2,0],[0,0,2],[0,0,-2]].forEach(g=>Gs.push(g));
    const cell=wsCell(Gs);
    const faces=cell.faces.map(p=>({pts:p,col:'pos',alpha:.26}));
    const bonds=[];
    cell.faces.forEach(p=>{for(let i=0;i<p.length;i++)
      bonds.push({a:p[i],b:p[(i+1)%p.length],col:'pos',w:1.8});});
    const balls=[{c:[0,0,0],r:.13,col:'neg'}];
    Gs.forEach(g=>balls.push({c:g,r:.10,col:'rule2'}));
    return {balls,bonds,faces};
  }
};

/* ── which 3-D view each canvas shows ── */
const V3D={
  /* ── drawing (hkl) from its indices, rotatable ── */
  miller3d:{model:'miller3d',ar:.86,barBelow:true,shiftY:24,pitch:.36,opt:{hkl:[1,1,0]},
    chips:[{sep:'plane'},
      {label:'(100)',set:{hkl:[1,0,0]}},{label:'(110)',set:{hkl:[1,1,0]},on:true},
      {label:'(111)',set:{hkl:[1,1,1]}},{label:'(210)',set:{hkl:[2,1,0]}},
      {label:'(112)',set:{hkl:[1,1,2]}},{label:'(1̅10)',set:{hkl:[-1,1,0]}}],
    steps:[
      'Draw the cell. Put the origin O at one corner and label the three axes a, b, c. Drag the picture around — the plane only makes sense once you have seen it from a few angles.',
      'Invert each index — that is where the plane has to cut: a/h, b/k, c/l. A 0 inverts to ∞, meaning the plane runs parallel to that axis and never touches it. A bar means the cut is on the negative side, in the cell behind.',
      'Mark those intercepts on the axes.',
      'Join the marks. Where the intercept is ∞ there is nothing to join to — run the plane parallel to that axis, straight through the cell.',
      'Shade it in. That is (hkl) — and every plane parallel to it, spaced d apart, carries the same name.'],
    overlay(ctx,W,H,st){
      const o=st.opt,hkl=o.hkl||[1,1,0],s=st.step|0;
      const nm='('+hkl.map(n=>n<0?Math.abs(n)+'̅':''+n).join('')+')';
      const par=['a','b','c'].filter((_,i)=>!hkl[i]);
      capBlock(ctx,[['plane  '+nm,C.ink],
        s>=1?['invert:   '+hkl.map(n=>n?'1/'+n:'1/0 = ∞').join('   ·   '),C.inkA(.66)]:null,
        s>=2?['cuts at:  '+[interceptTxt('a',hkl[0]),interceptTxt('b',hkl[1]),
              interceptTxt('c',hkl[2])].join('   ·   '),C.pos]:null,
        s>=4?[par.length?'parallel to '+par.join(' and '):'cuts all three axes',C.prob]:null]);
    }},

  /* ── drawing [uvw], rotatable ── */
  dir3d:{model:'dir3d',ar:.84,barBelow:true,shiftY:20,pitch:.36,opt:{uvw:[1,1,1]},
    chips:[{sep:'direction'},
      {label:'[100]',set:{uvw:[1,0,0]}},{label:'[110]',set:{uvw:[1,1,0]}},
      {label:'[111]',set:{uvw:[1,1,1]},on:true},{label:'[211]',set:{uvw:[2,1,1]}},
      {label:'[1̅10]',set:{uvw:[-1,1,0]}}],
    steps:[
      'Draw the cell, put the origin O at a corner and label the axes a, b, c.',
      'Read the three numbers as three steps: u along a, then v along b, then w along c. A bar means that step goes backwards.',
      'If any number is bigger than 1, divide all three by the largest. The arrow points exactly the same way and the whole walk now fits inside one cell.',
      'Walk it — along a, then along b, then along c.',
      'Join O to where you landed. That arrow is [uvw]. Spin the cell: any parallel arrow anywhere in the crystal is the same direction, and in a cubic crystal [hkl] is perpendicular to the plane (hkl).'],
    overlay(ctx,W,H,st){
      const uvw=st.opt.uvw||[1,1,1],s=st.step|0;
      const mx=Math.max.apply(null,uvw.map(Math.abs))||1,v=uvw.map(n=>n/mx);
      capBlock(ctx,[['direction  ['+uvw.map(n=>n<0?Math.abs(n)+'̅':''+n).join('')+']',C.ink],
        s>=1?['steps:    '+uvw.map((n,i)=>(n<0?'−':'')+Math.abs(n)+' '+'abc'[i])
              .join('   ·   '),C.inkA(.66)]:null,
        s>=2?[mx>1?'÷'+mx+' →   '+v.map(n=>Math.round(n*100)/100).join('   ·   ')+
              '   (same direction)':'already inside the cell — nothing to divide',C.neg]:null]);
    }},

  /* ── the perpendicular that gives d(hkl), rotatable ── */
  dgeom3d:{model:'dgeom3d',ar:.88,barBelow:true,shiftY:26,pitch:.34,opt:{hkl:[1,1,1]},
    chips:[{sep:'plane'},
      {label:'(100)',set:{hkl:[1,0,0]}},{label:'(110)',set:{hkl:[1,1,0]}},
      {label:'(111)',set:{hkl:[1,1,1]},on:true},{label:'(210)',set:{hkl:[2,1,0]}},
      {label:'(211)',set:{hkl:[2,1,1]}}],
    steps:[
      'Take the plane of the family nearest the origin. It cuts the axes at a/h, b/k and c/l — a zero index means it never cuts that axis at all.',
      'Drop a perpendicular from the origin O onto the plane, landing at N. Its length ON is the spacing d itself, because the next plane of the family passes through O. Rotate until you are looking down ON — the plane goes edge-on and d is the whole story.',
      'Let α, β, γ be the angles ON makes with the a, b, c axes. Each intercept gives a right-angled triangle, so cos α = d ÷ (a/h) = dh/a, and the same for β and γ.',
      'For three perpendicular axes the direction cosines of any line obey cos²α + cos²β + cos²γ = 1 — Pythagoras in 3-D.',
      'Substitute the three cosines and pull d² out: d²(h²+k²+l²)/a² = 1, so d = a/√(h²+k²+l²). Bigger indices ⇒ smaller d ⇒ planes packed closer together.'],
    overlay(ctx,W,H,st){
      const hkl=st.opt.hkl||[1,1,1],s=st.step|0;
      const S=hkl[0]*hkl[0]+hkl[1]*hkl[1]+hkl[2]*hkl[2];
      capBlock(ctx,[['plane  ('+hkl.join('')+')    ·    h²+k²+l² = '+S,C.ink],
        s>=1?['d = ON = the perpendicular from the origin',C.wall]:null,
        s>=2?['cos α = dh/a   ·   cos β = dk/b   ·   cos γ = dl/c',C.neg]:null,
        s>=4?['d = a/√'+S+' = '+(Math.round(1000/Math.sqrt(S))/1000)+' a',C.pos]
            :s>=3?['cos²α + cos²β + cos²γ = 1',C.inkA(.7)]:null]);
    }},

  /* ── the touching direction and a ↔ r, rotatable ── */
  pack3d:{model:'pack3d',ar:.86,barBelow:true,shiftY:24,pitch:.34,opt:{kind:'bcc'},
    chips:[{sep:'cell'},{label:'SC',set:{kind:'sc'}},{label:'BCC',set:{kind:'bcc'},on:true},
           {label:'FCC',set:{kind:'fcc'}}],
    steps:[
      'First question every time: along which line do the spheres actually touch? SC — along a cube edge. BCC — along the body diagonal, through the centre atom. FCC — along a face diagonal, through the face-centre atom.',
      'Draw that line and mark the atom centres sitting on it.',
      'Blow the atoms up until they touch, then count the radii laid end to end along the line. Rotate until you are looking straight down the line — the spheres line up and the count is obvious.',
      'Now write the same length in terms of a — edge = a, face diagonal = √2 a, body diagonal = √3 a — and equate the two readings. That single line is what every packing-fraction and density numerical starts from.',
      'Packing fraction = (atoms per cell × 4πr³/3) ÷ a³. Substitute r in terms of a and the numbers come out: 0.52, 0.68, 0.74.'],
    overlay(ctx,W,H,st){
      const kind=st.opt.kind||'bcc',s=st.step|0;
      const D={sc:{d:'cube edge',len:'a',cnt:'r + r = 2r',r:.5,n:1},
               bcc:{d:'body diagonal',len:'√3 a',cnt:'r + 2r + r = 4r',r:Math.sqrt(3)/4,n:2},
               fcc:{d:'face diagonal',len:'√2 a',cnt:'r + 2r + r = 4r',r:Math.SQRT2/4,n:4}}[kind];
      const f=D.n*4/3*Math.PI*Math.pow(D.r,3);
      capBlock(ctx,[[kind.toUpperCase()+'  ·  they touch along the '+D.d,C.ink],
        s>=2?['along that line: '+D.cnt,C.pos]:null,
        s>=3?[D.len+' = '+(D.n===1?'2r':'4r')+'   →   r = '+(Math.round(D.r*1000)/1000)+' a',
              C.prob]:null,
        s>=4?['f = '+D.n+'·(4/3)πr³ / a³ = '+(Math.round(f*100)/100),C.neg]:null]);
    }},

  /* ── the HCP tetrahedron, rotatable ── */
  hcp3d:{model:'hcp3d',ar:.80,barBelow:true,shiftY:22,pitch:.55,yaw:.55,
    steps:[
      'Three touching spheres of the bottom layer. Their centres make an equilateral triangle of side a = 2r.',
      'The next-layer sphere drops into the hollow, straight above the centre of that triangle. How far is that centre from a corner? The median is a sin 60° = (√3/2)a and the centre sits two-thirds along it — so the distance is a/√3.',
      'Put the upper sphere in place. It touches the lower ones, so centre-to-centre is a; the climb from the A layer to the B layer is c/2. Those two and a/√3 close a right-angled triangle — rotate until you see it edge-on.',
      'Pythagoras: a² = (a/√3)² + (c/2)². So c²/4 = a²(1 − 1/3) = (2/3)a², giving c/a = √(8/3) ≈ 1.633.'],
    overlay(ctx,W,H,st){
      const s=st.step|0;
      capBlock(ctx,[['ideal HCP — where c/a comes from',C.ink],
        s>=1?['centre of the triangle → corner = a/√3',C.neg]:null,
        s>=2?['a² = (a/√3)² + (c/2)²',C.pos]:null,
        s>=3?['c/a = √(8/3) = 1.633',C.pos]:null]);
    }},

  /* ── who owns which atom, rotatable ── */
  count3d:{model:'count3d',ar:.84,barBelow:true,shiftY:22,opt:{kind:'fcc'},
    chips:[{sep:'cell'},{label:'SC',set:{kind:'sc'}},{label:'BCC',set:{kind:'bcc'}},
           {label:'FCC',set:{kind:'fcc'},on:true}],
    steps:[
      'Here is the conventional cell with its atoms drawn in. Counting them straight off gives the wrong answer, because most of them are not entirely yours.',
      'A corner atom sits where eight cells meet — the neighbours are drawn in faintly. Your share of it is ⅛.',
      'An atom in the middle of a face is shared with exactly one neighbour across that face, so your share is ½.',
      'An atom entirely inside the cell belongs to you alone — count it as 1.',
      'Add the shares: N = N(inside) + N(face)/2 + N(corner)/8. SC gives 8×⅛ = 1, BCC gives 1 + 8×⅛ = 2, FCC gives 6×½ + 8×⅛ = 4.'],
    overlay(ctx,W,H,st){
      const k=st.opt.kind||'fcc',s=st.step|0;
      const T={sc:['8 corners','8×⅛ = 1 atom per cell'],
               bcc:['8 corners + 1 body centre','1 + 8×⅛ = 2 atoms per cell'],
               fcc:['8 corners + 6 face centres','6×½ + 8×⅛ = 4 atoms per cell']}[k];
      capBlock(ctx,[[k.toUpperCase()+'  ·  '+T[0],C.ink],
        s>=1?['corner → shared by 8 → ⅛ each',s===1?C.wall:C.inkA(.6)]:null,
        s>=2?['face → shared by 2 → ½ each',s===2?C.wall:C.inkA(.6)]:null,
        s>=4?[T[1],C.pos]:null]);
    }},

  /* ── the symmetry elements of a cube, rotatable ── */
  sym3d:{model:'sym3d',ar:.82,barBelow:true,shiftY:20,pitch:.40,
    steps:[
      'One cube. Every symmetry operation has to leave it looking exactly as it started — turn it, and if you cannot tell, that turn is a symmetry.',
      'Three <b>four-fold</b> axes, each through the centres of a pair of opposite faces. A quarter turn about any of them puts the cube back on itself.',
      'Four <b>three-fold</b> axes, along the body diagonals. A third of a turn about a body diagonal cycles the three faces meeting at that corner.',
      'Six <b>two-fold</b> axes, through the midpoints of opposite edges. Half a turn about one of those works too.',
      'Add the mirrors — 3 through pairs of faces and 6 through pairs of opposite edges — plus the centre of inversion. Rotation axes 3+4+6 = 13, mirror planes 9, centre 1: a cube has <b>23</b> symmetry elements. Note what is missing: no five-fold axis anywhere.'],
    overlay(ctx,W,H,st){
      const s=st.step|0;
      capBlock(ctx,[['symmetry elements of a cube',C.ink],
        s>=1?['3 four-fold axes  (through face centres)',s===1?C.pos:C.inkA(.55)]:null,
        s>=2?['4 three-fold axes  (body diagonals)',s===2?C.neg:C.inkA(.55)]:null,
        s>=3?['6 two-fold axes  (edge midpoints)',s===3?C.prob:C.inkA(.55)]:null,
        s>=4?['13 axes + 9 mirror planes + 1 centre = 23',C.pos]:null]);
    }},

  /* ── lattice + basis = structure, rotatable ── */
  basis3d:{model:'basis3d',ar:.84,barBelow:true,shiftY:22,opt:{kind:'diamond'},
    chips:[{sep:'structure'},{label:'Diamond',set:{kind:'diamond'},on:true},
           {label:'Zinc blende',set:{kind:'zns'}},{label:'Rock salt',set:{kind:'nacl'}}],
    steps:[
      'Start with the <b>lattice</b> — an FCC set of points: 8 corners and 6 face centres, 4 points per cell. These are positions, not atoms.',
      'Put the first atom of the <b>basis</b> on every one of those points.',
      'Now add the second atom of the basis, displaced by the same vector from every point: (¼,¼,¼) along the body diagonal for diamond and zinc blende, (½,0,0) along a cube edge for rock salt.',
      'Join each atom to its nearest neighbours. The displacement direction is what decides the coordination: along the body diagonal it comes out tetrahedral, along an edge it comes out octahedral.',
      'Count: 4 lattice points × 2 atoms in the basis = 8 atoms per cell. Same lattice all three times — only the basis changed.'],
    overlay(ctx,W,H,st){
      const k=st.opt.kind||'diamond',s=st.step|0;
      const T={diamond:['Diamond','basis = two identical C at (0,0,0) and (¼,¼,¼)','CN 4 · tetrahedral · f = 0.34'],
               zns:['Zinc blende','basis = Zn at (0,0,0), S at (¼,¼,¼)','CN 4 · tetrahedral · no centre of symmetry'],
               nacl:['Rock salt','basis = Na⁺ at (0,0,0), Cl⁻ at (½,0,0)','CN 6 · octahedral · 4 formula units per cell']}[k];
      capBlock(ctx,[[T[0]+'  ·  FCC lattice',C.ink],
        s>=2?[T[1],C.inkA(.66)]:null,
        s>=1?['lattice + basis = structure',C.pos]:null,
        s>=4?[T[2],C.neg]:null]);
    }},

  /* ── the Fermi sphere in k-space, rotatable ── */
  fermi3d:{model:'fermi3d',ar:.82,barBelow:true,shiftY:34,pitch:.36,
    steps:[
      'k-space. Fitting waves into a box of side L quantises k, so the allowed states sit on a grid with spacing 2π/L — one state per little cube of volume (2π/L)³, and two electrons per state once spin is counted.',
      'At absolute zero the electrons fill the lowest states first, so they fill from the middle outwards.',
      'The surface where the filling stops is a <b>sphere</b> — the Fermi surface — of radius k_F. That is the whole reason the free-electron model is so easy: the occupied region is a ball.',
      'Count what is inside: N = 2 × (4/3)πk_F³ ÷ (2π/L)³ = V k_F³/3π². Turn it round: k_F = (3π²n)^⅓, which depends only on the electron density.',
      'Then E_F = ℏ²k_F²/2m — every Fermi-energy numerical in the paper is those two lines. Note the Fermi surface is a sphere only while the electrons are free; a real lattice distorts it near the zone boundary.'],
    overlay(ctx,W,H,st){
      const s=st.step|0;
      capBlock(ctx,[['the Fermi sphere at T = 0',C.ink],
        s>=1?['filled states (2 per k, spin ↑↓)',C.neg]:null,
        s>=3?['N = V k_F³/3π²   →   k_F = (3π²n)^⅓',C.pos]:null,
        s>=4?['E_F = ℏ²k_F²/2m',C.wall]:null]);
    }},

  /* ── Laue's three equations, rotatable ── */
  laue3d:{model:'laue3d',ar:.86,barBelow:true,shiftY:24,pitch:.30,zoom0:1.30,opt:{ax:'a'},
    chips:[{sep:'along'},{label:'the a axis',set:{ax:'a'},on:true},
           {label:'the b axis',set:{ax:'b'}},{label:'the c axis',set:{ax:'c'}}],
    steps:[
      'Forget planes. Laue looked at two scattering atoms: A at the origin and B one lattice step r away. Use the chips to move B onto whichever axis you are writing the condition for.',
      'A plane wave arrives along the direction n̂₁ — the same beam reaches both atoms, so the two wavelets start out in step.',
      'Both atoms scatter in every direction; look at the wavelets leaving along one particular direction n̂₂.',
      'Compare the two journeys. Before scattering, the wave that hits B travels an extra r·n̂₁; after scattering, the one from B travels r·n̂₂ less. Everything else is common to the two. Net extra path = r·n̂₁ − r·n̂₂ = r·(n̂₁ − n̂₂) = r·N.',
      'Constructive interference needs that to be a whole number of wavelengths — and it has to work for a lattice step along <b>every</b> axis at once. Hence the three Laue equations: a·N = hλ, b·N = kλ, c·N = lλ.',
      'Write N with direction cosines and note |N| = 2 sin θ, and those three collapse to d = nλ/2 sin θ — i.e. 2d sin θ = nλ. <b>Bragg and Laue are the same physics in different clothes</b>; that is the short-answer question.'],
    overlay(ctx,W,H,st){
      const s=st.step|0,ax=st.opt.ax||'a';
      capBlock(ctx,[['Laue — atom by atom, not plane by plane',C.ink],
        s>=3?['extra path = r·n̂₁ − r·n̂₂ = r·N',C.wall]:null,
        s>=4?['a·N = hλ   ·   b·N = kλ   ·   c·N = lλ',C.pos]:null,
        s>=5?['|N| = 2 sin θ   ⇒   2d sin θ = nλ',C.neg]:null]);
    }},

  /* ── one family of planes → one reciprocal point, rotatable ── */
  recip3d:{model:'recip3d',ar:.88,barBelow:true,shiftY:24,pitch:.34,zoom0:1.18,opt:{hkl:[1,0,0]},
    chips:[{sep:'family'},{label:'(100)',set:{hkl:[1,0,0]},on:true},
      {label:'(110)',set:{hkl:[1,1,0]}},{label:'(111)',set:{hkl:[1,1,1]}},
      {label:'(200)',set:{hkl:[2,0,0]}},{label:'(210)',set:{hkl:[2,1,0]}}],
    steps:[
      'Here is one family of parallel planes (hkl) — two of them are drawn, the one through the origin and its neighbour a distance d away.',
      'A family of planes carries only two pieces of information: which way it faces, and how far apart the planes are. The facing is the normal direction — the crimson line, of length d.',
      'So represent the whole family by a single arrow along that normal, with length 2π/d. Closely spaced planes get a <b>long</b> arrow: (200) has half the spacing of (100), so its arrow is twice as long.',
      'The tip of that arrow is one point of the <b>reciprocal lattice</b>. Switch families with the chips and watch the tip move; do it for every possible (hkl) and the tips themselves form a lattice — shown faintly.',
      'That lattice lives in k-space, where lengths are 1/length. For a cubic crystal it comes out cubic with spacing 2π/a — and the ones worth memorising: SC → SC, BCC → FCC, FCC → BCC.'],
    overlay(ctx,W,H,st){
      const hkl=st.opt.hkl||[1,0,0],s=st.step|0;
      const S=hkl[0]*hkl[0]+hkl[1]*hkl[1]+hkl[2]*hkl[2];
      capBlock(ctx,[['family  ('+hkl.join('')+')',C.ink],
        s>=1?['d = a/√'+S+' = '+(Math.round(1000/Math.sqrt(S))/1000)+' a',C.wall]:null,
        s>=2?['|G| = 2π/d = (2π/a)·√'+S+'   →   G = (2π/a)('+hkl.join(',')+')',C.neg]:null,
        s>=3?['tips of all such arrows = the reciprocal lattice',C.pos]:null]);
    }},

  bravais:{model:'bravais',ar:.80,pitch:.30,barBelow:true,opt:{sys:'cubic',ctr:'P'},
    chips:[{sep:'system'},
           {label:'Cubic',set:{sys:'cubic'},on:true},{label:'Tetragonal',set:{sys:'tetragonal'}},
           {label:'Orthorhombic',set:{sys:'orthorhombic'}},
           {label:'Rhombohedral',set:{sys:'rhombohedral'}},
           {label:'Hexagonal',set:{sys:'hexagonal'}},{label:'Monoclinic',set:{sys:'monoclinic'}},
           {label:'Triclinic',set:{sys:'triclinic'}},
           {sep:'centring'},
           {label:'P',set:{ctr:'P'},on:true},{label:'C',set:{ctr:'C'}},
           {label:'I',set:{ctr:'I'}},{label:'F',set:{ctr:'F'}}],
    coerce(o){o.ctr=bravaisCtr(o);},
    disabled(ch,o){return Object.keys(ch.set)[0]==='ctr'&&
      (BRAVAIS_OK[o.sys]||[]).indexOf(ch.set.ctr)<0;},
    overlay(ctx,W,H,st){
      const o=st.opt,t=BRAVAIS_TXT[o.sys]||BRAVAIS_TXT.cubic,ctr=bravaisCtr(o);
      const rh=o.sys==='rhombohedral', sym=rh?'R':ctr, n=BRAVAIS_N[ctr];
      const alias={cubicP:'  (simple cubic)',cubicI:'  (BCC)',cubicF:'  (FCC)'}[o.sys+ctr]||'';
      const tag=rh?'R \u2014 the primitive rhombohedron':BRAVAIS_TAG[ctr];
      const cnt=n+' lattice point'+(n>1?'s':'')+' per cell';
      const nar=W<470;                       // phone: let the caption breathe over 4 lines
      ctx.save();ctx.textBaseline='top';ctx.textAlign='left';
      ctx.font="600 "+(nar?12.5:13.5)+"px 'Sora',Georgia,serif";ctx.fillStyle=C.ink;
      ctx.fillText(t.n+'  '+sym+alias,10,9);
      ctx.font=(nar?9.5:10.5)+"px 'Fira Mono',monospace";ctx.fillStyle=C.inkA(.66);
      ctx.fillText(t.len+'   \u00b7   '+t.ang,10,nar?27:29);
      ctx.fillStyle=C.inkA(.5);
      const one=tag+'   \u00b7   '+cnt;      // measure, never guess: split only if it would clip
      if(ctx.measureText(one).width>W-20){ctx.fillText(tag,10,nar?41:43);
        ctx.fillText(cnt,10,nar?53:56);}
      else ctx.fillText(one,10,nar?41:44);
      ctx.restore();
    }},
  cubic:{model:'cubic',ar:.68,opt:{kind:'fcc',fill:false},
    chips:[{label:'SC',set:{kind:'sc'}},{label:'BCC',set:{kind:'bcc'}},
           {label:'FCC',set:{kind:'fcc'},on:true},
           {label:'⬤ fill',set:{fill:true},toggle:true}]},
  hcp:{model:'hcp',ar:.72,pitch:.30},
  diamond:{model:'diamond',ar:.70},
  nacl:{model:'nacl',ar:.70},
  ws3d:{model:'ws',ar:.72},
  bz3d:{model:'bz',ar:.82,barBelow:true,shiftY:20,opt:{which:'fcc'},
    chips:[{sep:'crystal'},{label:'FCC crystal',set:{which:'fcc'},on:true},
           {label:'BCC crystal',set:{which:'bcc'}}],
    steps:[
      'Work in reciprocal space. Mark the origin and its nearest reciprocal-lattice points G — for an FCC crystal the reciprocal lattice is BCC, and for a BCC crystal it is FCC.',
      'Join the origin to each of those neighbours. This is the Wigner–Seitz recipe again, only now in k-space.',
      'Bisect every one of those vectors with a plane at right angles to it. A wave whose k reaches one of those planes satisfies 2k·G = G² — the Bragg condition — and gets reflected.',
      'Keep the region around the origin that no plane cuts off. That is the <b>first Brillouin zone</b>: every k inside it travels; every k on the boundary is Bragg-reflected and a gap opens there.',
      'Spin it and count the faces. FCC crystal → a truncated octahedron, 8 hexagons + 6 squares. BCC crystal → a rhombic dodecahedron, 12 identical rhombi. Those two names are exam answers.'],
    overlay(ctx,W,H,st){
      const w=st.opt.which||'fcc',s=st.step|0;
      capBlock(ctx,[[(w==='fcc'?'FCC crystal → BCC reciprocal lattice'
                                :'BCC crystal → FCC reciprocal lattice'),C.ink],
        s>=2?['bisector plane ⇔ Bragg condition 2k·G = G²',C.prob]:null,
        s>=4?[(w==='fcc'?'first zone = truncated octahedron (8 hex + 6 sq)'
                        :'first zone = rhombic dodecahedron (12 rhombi)'),C.pos]:null]);
    }}
};

/* ── the renderer ── */
function setup3D(cv){
  const name=cv.dataset.v3d;const spec=(V3D[name]||{});
  const wrap=cv.parentElement;
  const st={yaw:spec.yaw!=null?spec.yaw:0.62,pitch:spec.pitch!=null?spec.pitch:0.42,
            zoom:spec.zoom0||1,auto:true,step:0,opt:Object.assign({},spec.opt||{})};
  const rec={cv,st,visible:false,is3d:true};
  let scene=null;
  const withStep=i=>Object.assign({},st.opt,{step:i});
  /* the largest distance any drawn point reaches from the origin */
  const reach=sc=>{let m=0;const hit=p=>{const d=Math.hypot(p[0],p[1],p[2]);if(d>m)m=d;};
    (sc.balls||[]).forEach(b=>{m=Math.max(m,Math.hypot(b.c[0],b.c[1],b.c[2])+b.r);});
    (sc.bonds||[]).forEach(l=>{hit(l.a);hit(l.b);});
    (sc.faces||[]).forEach(f=>f.pts.forEach(hit));
    (sc.labels||[]).forEach(t=>hit(t.p));
    return m;};
  const build=()=>{
    scene=MODELS[spec.model](withStep(st.step));
    /* frame on the finished construction, so stepping never rescales the view */
    let m=reach(scene);
    if(spec.steps)for(let i=0;i<spec.steps.length;i++)
      m=Math.max(m,reach(MODELS[spec.model](withStep(i))));
    scene.fit=m||1;
  };
  build();

  function size(){
    const cssW=cv.clientWidth||wrap.clientWidth||0;if(!cssW)return;
    const dpr=Math.min(2,window.devicePixelRatio||1);
    const ar=cssW<430?0.92:(spec.ar||0.66);
    const cssH=Math.round(cssW*ar);
    cv.width=cssW*dpr;cv.height=cssH*dpr;cv.style.height=cssH+'px';
    cv.getContext('2d').setTransform(dpr,0,0,dpr,0,0);
    rec.W=cssW;rec.H=cssH;draw();
  }
  const COL=n=>({pos:C.pos,neg:C.neg,accent:C.prob,wall:C.wall,
                 rule:C.inkA(.30),rule2:C.inkA(.18)}[n]||C.ink);
  const COLA=(n,a)=>({pos:C.posA(a),neg:C.negA(a),accent:C.probA(a),wall:C.wallA(a),
                      rule:C.inkA(a*.5),rule2:C.inkA(a*.35)}[n]||C.inkA(a));

  function draw(){
    if(!rec.W)return;readPalette();
    const ctx=cv.getContext('2d'),W=rec.W,H=rec.H;
    ctx.clearRect(0,0,W,H);
    const cy=Math.cos(st.yaw),sy=Math.sin(st.yaw),cp=Math.cos(st.pitch),sp=Math.sin(st.pitch);
    const rot=p=>{const x=p[0]*cy+p[2]*sy, z=-p[0]*sy+p[2]*cy;
      const y=p[1]*cp-z*sp, z2=p[1]*sp+z*cp;return [x,y,z2];};
    const base=Math.min(W,H)*0.42/scene.fit*st.zoom;
    const d=6;
    const cy0=H/2+(spec.shiftY||0);
    const proj=q=>{const k=d/(d-q[2]*0.55);return [W/2+q[0]*base*k, cy0-q[1]*base*k, q[2], k];};
    const items=[];
    (scene.balls||[]).forEach(b=>{const q=rot(b.c);items.push({z:q[2],kind:'b',q,o:b});});
    (scene.bonds||[]).forEach(l=>{const a=rot(l.a),b=rot(l.b);
      items.push({z:(a[2]+b[2])/2,kind:'l',a,b,o:l});});
    (scene.faces||[]).forEach(f=>{const pts=f.pts.map(rot);
      const z=pts.reduce((s,p)=>s+p[2],0)/pts.length;items.push({z,kind:'f',pts,o:f});});
    (scene.labels||[]).forEach(t=>{const q=rot(t.p);items.push({z:q[2]+9,kind:'t',q,o:t});});
    items.sort((a,b)=>a.z-b.z);
    for(const it of items){
      if(it.kind==='l'){
        const A=proj(it.a),B=proj(it.b);
        ctx.save();ctx.strokeStyle=COL(it.o.col);ctx.lineWidth=(it.o.w||1.2);
        ctx.globalAlpha=.55+.45*((it.z+1.6)/3.2);
        ctx.beginPath();ctx.moveTo(A[0],A[1]);ctx.lineTo(B[0],B[1]);ctx.stroke();ctx.restore();
      }else if(it.kind==='f'){
        const P2=it.pts.map(proj);
        ctx.save();ctx.beginPath();P2.forEach((p,i)=>i?ctx.lineTo(p[0],p[1]):ctx.moveTo(p[0],p[1]));
        ctx.closePath();ctx.fillStyle=COLA(it.o.col,it.o.alpha||.3);ctx.fill();ctx.restore();
      }else if(it.kind==='t'){
        const P2=proj(it.q);
        ctx.save();ctx.textAlign='center';ctx.textBaseline='middle';
        ctx.font="italic 600 13px 'Sora',Georgia,serif";
        ctx.lineWidth=3.4;ctx.lineJoin='round';ctx.strokeStyle=C.bg;
        ctx.strokeText(it.o.t,P2[0],P2[1]);
        ctx.fillStyle=COL(it.o.col);ctx.fillText(it.o.t,P2[0],P2[1]);ctx.restore();
      }else{
        const P2=proj(it.q),r=Math.max(1.5,it.o.r*base*P2[3]);
        const g=ctx.createRadialGradient(P2[0]-r*.35,P2[1]-r*.4,r*.1,P2[0],P2[1],r);
        g.addColorStop(0,COLA(it.o.col,.98));g.addColorStop(.65,COL(it.o.col));
        g.addColorStop(1,COLA(it.o.col,.42));
        ctx.save();ctx.beginPath();ctx.arc(P2[0],P2[1],r,0,7);ctx.fillStyle=g;ctx.fill();
        ctx.globalAlpha=.55;ctx.strokeStyle=COLA(it.o.col,.9);ctx.lineWidth=.8;ctx.stroke();
        ctx.restore();
      }
    }
    if(spec.overlay)spec.overlay(ctx,W,H,st);
    if(spec.hint!==false){
      ctx.save();ctx.fillStyle=C.inkA(.42);
      ctx.font="10px 'Fira Mono',monospace";ctx.textBaseline='bottom';
      ctx.fillText(st.auto?'drag sideways to rotate · pinch or +/− to zoom':'⟳ resets the view',10,H-8);
      ctx.restore();
    }
  }
  rec.size=size;rec.render=draw;rec.rebuild=()=>{build();draw();};

  /* ── controls: model chips (optional) + zoom/reset (always) ── */
  if(spec.chips||spec.steps||true){
    const bar=document.createElement('div');
    bar.className='figbar'+((spec.barBelow||spec.steps)?' below':'');
    const same=(x,y)=>JSON.stringify(x)===JSON.stringify(y);
    const syncBar=()=>{
      bar.querySelectorAll('.chipbtn').forEach(x=>{
        const c=x._ch,k=Object.keys(c.set)[0];
        x.classList.toggle('on',c.toggle?!!st.opt[k]:same(st.opt[k],c.set[k]));
        const off=spec.disabled?!!spec.disabled(c,st.opt):false;
        x.classList.toggle('off',off);x.disabled=off;});};
    (spec.chips||[]).forEach(ch=>{
      if(ch.sep!==undefined){                           // a caption between chip groups
        const t=document.createElement('span');t.className='figsep';t.textContent=ch.sep;
        bar.appendChild(t);return;}
      const key=Object.keys(ch.set)[0];
      const b=document.createElement('button');
      b.textContent=ch.label;b.dataset.key=key;b.className='chipbtn';b._ch=ch;
      b.onclick=e=>{e.stopPropagation();
        if(ch.toggle){                                  // independent on/off
          st.opt[key]=!st.opt[key];
        }else{                                          // radio within its own key
          Object.assign(st.opt,ch.set);
        }
        if(spec.coerce)spec.coerce(st.opt);
        rec.rebuild();syncBar();};
      if(ch.on)b.classList.add('on');
      bar.appendChild(b);});
    if(spec.chips&&spec.chips.length)syncBar();
    const mk=(t,title,fn)=>{const b=document.createElement('button');
      b.textContent=t;b.title=title;b.style.minWidth='1.7rem';
      b.onclick=e=>{e.stopPropagation();fn();};bar.appendChild(b);return b;};
    let cap=null,goStep=null;
    if(spec.steps){
      if(spec.chips&&spec.chips.length){
        const br=document.createElement('span');br.className='brk';bar.appendChild(br);}
      cap=document.createElement('span');cap.className='stepcap';
      const nums=[];
      goStep=i=>{st.step=Math.max(0,Math.min(spec.steps.length-1,i));
        nums.forEach((b,k)=>b.classList.toggle('on',k===st.step));
        cap.innerHTML='<b>step '+(st.step+1)+'/'+spec.steps.length+'</b>'+spec.steps[st.step];
        rec.rebuild();};
      mk('◀','Previous step',()=>goStep(st.step-1));
      spec.steps.forEach((_,i)=>{const b=document.createElement('button');
        b.className='step';b.textContent=i+1;b.title='Step '+(i+1);
        b.onclick=e=>{e.stopPropagation();goStep(i);};nums.push(b);bar.appendChild(b);});
      mk('▶','Next step',()=>goStep(st.step+1));
      const br2=document.createElement('span');br2.className='brk';bar.appendChild(br2);
    }
    if(spec.barBelow&&!spec.steps){
      const g=document.createElement('span');g.className='grow';bar.appendChild(g);}
    mk('−','Zoom out',()=>{st.auto=false;st.zoom=Math.max(.55,st.zoom/1.18);draw();});
    mk('+','Zoom in', ()=>{st.auto=false;st.zoom=Math.min(2.6,st.zoom*1.18);draw();});
    mk('⟳','Reset view',()=>{st.yaw=spec.yaw!=null?spec.yaw:0.62;
      st.pitch=spec.pitch!=null?spec.pitch:0.42;st.zoom=spec.zoom0||1;st.auto=true;draw();});
    if(cap){bar.appendChild(cap);setTimeout(()=>goStep(0),0);}
    wrap.appendChild(bar);
  }

  /* ── pointer / touch interaction (works on desktop and mobile) ── */
  let drag=false,claimed=false,lx=0,ly=0,sx=0,sy=0,pinch=0,pid=null;
  const stop=()=>{st.auto=false;};
  cv.addEventListener('pointerdown',e=>{
    if(e.pointerType==='touch'&&e.isPrimary===false)return;
    drag=true;pid=e.pointerId;lx=sx=e.clientX;ly=sy=e.clientY;
    // a mouse claims the gesture at once; touch waits to see if it is a scroll
    claimed=(e.pointerType!=='touch');
    if(claimed)stop();
  });
  cv.addEventListener('pointermove',e=>{
    if(!drag||e.pointerId!==pid)return;
    if(!claimed){
      const dx=Math.abs(e.clientX-sx),dy=Math.abs(e.clientY-sy);
      if(dx<6&&dy<6)return;              // not yet a gesture
      if(dy>dx){drag=false;return;}      // vertical → let the page scroll
      claimed=true;stop();
      try{cv.setPointerCapture(pid);}catch(_){}
    }
    e.preventDefault();
    st.yaw+=(e.clientX-lx)*0.011;st.pitch+=(e.clientY-ly)*0.011;
    st.pitch=Math.max(-1.45,Math.min(1.45,st.pitch));
    lx=e.clientX;ly=e.clientY;draw();
  });
  const end=()=>{drag=false;claimed=false;pid=null;};
  cv.addEventListener('pointerup',end);cv.addEventListener('pointercancel',end);
  cv.addEventListener('wheel',e=>{e.preventDefault();stop();
    st.zoom=Math.max(.55,Math.min(2.6,st.zoom*(e.deltaY>0?0.92:1.08)));draw();},{passive:false});
  cv.addEventListener('touchstart',e=>{
    if(e.touches.length===2){drag=false;stop();
      pinch=Math.hypot(e.touches[0].clientX-e.touches[1].clientX,
                       e.touches[0].clientY-e.touches[1].clientY);}},{passive:true});
  cv.addEventListener('touchmove',e=>{
    if(e.touches.length===2&&pinch){e.preventDefault();
      const d2=Math.hypot(e.touches[0].clientX-e.touches[1].clientX,
                          e.touches[0].clientY-e.touches[1].clientY);
      st.zoom=Math.max(.55,Math.min(2.6,st.zoom*(d2/pinch)));pinch=d2;draw();}},{passive:false});
  cv.addEventListener('touchend',()=>{pinch=0;});
  let lastTap=0;
  cv.addEventListener('click',()=>{const t=Date.now();
    if(t-lastTap<330){st.yaw=spec.yaw!=null?spec.yaw:0.62;st.pitch=spec.pitch!=null?spec.pitch:0.42;
      st.zoom=spec.zoom0||1;st.auto=true;draw();}
    lastTap=t;});

  live3D.push(rec);
  new IntersectionObserver(es=>{es.forEach(e=>{rec.visible=e.isIntersecting;});},{threshold:.1})
    .observe(cv);
  size();
  window.addEventListener('resize',debounce(size,180));
}
const live3D=[];

/* ══════════════ canvas lifecycle ══════════════ */
const liveFigs=[];
function setupFig(cv){
  const name=cv.dataset.fig;const F=FIGS[name];if(!F)return;
  const wrap=cv.parentElement;
  const st={t:0,playing:F.anim?true:false,pts:null,k:0,lastReset:0,
            step:0,opt:Object.assign({},F.opt||{})};
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
  /* variant chips and, for a guided construction, the step bar */
  if(F.chips||F.steps){
    const bar=document.createElement('div');bar.className='figbar below';
    const same=(x,y)=>JSON.stringify(x)===JSON.stringify(y);
    const chipEls=[];
    (F.chips||[]).forEach(ch=>{
      if(ch.sep!==undefined){const t=document.createElement('span');
        t.className='figsep';t.textContent=ch.sep;bar.appendChild(t);return;}
      const key=Object.keys(ch.set)[0];
      const b=document.createElement('button');b.className='chipbtn';b.textContent=ch.label;
      b.onclick=e=>{e.stopPropagation();Object.assign(st.opt,ch.set);
        chipEls.forEach(x=>x.classList.toggle('on',same(st.opt[Object.keys(x._s)[0]],
          x._s[Object.keys(x._s)[0]])));
        render();};
      b._s=ch.set;if(ch.on)b.classList.add('on');
      chipEls.push(b);bar.appendChild(b);});
    if(F.steps){
      if(F.chips){const br=document.createElement('span');br.className='brk';bar.appendChild(br);}
      const cap=document.createElement('span');cap.className='stepcap';
      const nums=[];
      const go=i=>{st.step=Math.max(0,Math.min(F.steps.length-1,i));
        nums.forEach((b,k)=>b.classList.toggle('on',k===st.step));
        cap.innerHTML='<b>step '+(st.step+1)+'/'+F.steps.length+'</b>'+F.steps[st.step];
        render();};
      const mk=(t,title,fn)=>{const b=document.createElement('button');
        b.textContent=t;b.title=title;b.onclick=e=>{e.stopPropagation();fn();};
        bar.appendChild(b);return b;};
      mk('\u25c0','Previous step',()=>go(st.step-1));
      F.steps.forEach((_,i)=>{const b=document.createElement('button');
        b.className='step';b.textContent=i+1;b.title='Step '+(i+1);
        b.onclick=e=>{e.stopPropagation();go(i);};nums.push(b);bar.appendChild(b);});
      mk('\u25b6','Next step',()=>go(st.step+1));
      mk('\u21ba','Back to step 1',()=>go(0));
      bar.appendChild(cap);
      rec.goStep=go;
      setTimeout(()=>go(0),0);
    }
    wrap.appendChild(bar);
  }
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
  for(const r of live3D){if(r.st.auto&&r.visible){r.st.yaw+=dt*0.30;r.render();}}
  requestAnimationFrame(loop);}
requestAnimationFrame(loop);
function debounce(f,ms){let h;return(...a)=>{clearTimeout(h);h=setTimeout(()=>f(...a),ms);};}

/* ══════════════ progress state + Firebase sync ══════════════ */
const DB='https://task-dominion-default-rtdb.asia-southeast1.firebasedatabase.app';
const APP='ssc_ss_mod12';
const LS='ss12_progress_v1', LSID='ss12_syncid_v1';
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
  $$('canvas[data-v3d]').forEach(setup3D);
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
  liveFigs.concat(live3D).forEach(r=>{if(root.contains(r.cv)&&r.cv.clientWidth>0)r.size();});
}
function resizeVisibleFigs(){liveFigs.concat(live3D).forEach(r=>{if(r.cv.clientWidth>0)r.size();});}

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
      a.href=url;a.download='SOLID_STATE_1.html';document.body.appendChild(a);a.click();
      a.remove();setTimeout(()=>URL.revokeObjectURL(url),4000);
      toast('Downloaded SOLID_STATE_1.html');
    }catch(err){toast('Download blocked — use your browser’s Save Page');}
    btn.textContent='⤓';
  };
}

/* ══════════════ theme ══════════════ */
function initTheme(){
  const KEY='ss12_theme';const btn=$('#theme');
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
