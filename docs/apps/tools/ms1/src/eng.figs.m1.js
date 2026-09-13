/* ══════════════ Module I figures — materials, forces, bonding ══════════════ */
const LOG10=Math.log10, sup=n=>String(n).split('').map(c=>SUP[c]||c).join('');
const tenTo=e=>'10'+sup(e);

/* ── structure / feature / instrument length scales on one log axis (Figs 1.x & 4.16) ── */
const SCALE_SETS={
  levels:{t:'structure, by the size of what you look at',rows:[
    ['subatomic',-15,-10,'wall','electrons & nuclei'],['atomic',-10,-9,'neg','atoms → molecules, crystals'],
    ['nanostructure',-9,-7,'prob','particles < 100 nm'],['microstructure',-7,-3,'amber','grains, phases — needs a microscope'],
    ['macrostructure',-3,0,'pos','seen by the naked eye']]},
  features:{t:'sizes of structural features (Fig 4.16a)',rows:[
    ['subatomic particles',-16,-14,'wall',''],['atom / ion diameters',-10.3,-9.7,'neg','≈ 0.1 nm'],['unit-cell edges',-10,-9,'neg',''],
    ['dislocation widths',-9,-8,'prob',''],['second-phase particles',-8,-5,'amber',''],['grains',-6,-3,'amber',''],
    ['pores, voids, cracks',-4,-1,'pos','macrostructural']]},
  tools:{t:'useful resolution of each instrument (Fig 4.16b)',rows:[
    ['scanning probe (SPM)',-10,-6,'prob',''],['TEM',-10,-6,'neg',''],['SEM',-9,-3,'blue',''],
    ['optical microscope',-7,-3,'amber',''],['naked eye',-4,0,'pos','']]}
};
FIGS.scales={opt:{set:'levels'},
  chips:[{sep:'show'},{label:'structure levels',set:{set:'levels'}},{label:'features',set:{set:'features'}},{label:'instruments',set:{set:'tools'}}],
  ar:(w,st)=>Math.min(.9,(SCALE_SETS[st.opt.set].rows.length*34+86)/w),
  draw(ctx,W,H,st){const S=SCALE_SETS[st.opt.set];const narrow=W<520;
    const P=Plot(ctx,W,H,{l:narrow?10:150,r:14,t:30,b:30});P.clear().dom(-16,0.3).ran(0,S.rows.length);
    for(let e=-16;e<=0;e++){P.seg(e,0,e,S.rows.length,C.grid,1);}
    P.xticks([-15,-12,-9,-6,-3,0],v=>tenTo(v)+' m');
    P.text(10,8,S.t,C.ink,{d:1,b:1,sz:12});
    S.rows.forEach((r,i)=>{const y=S.rows.length-i-.5,col=C[r[3]],colA=C[r[3]+'A'];
      const x0=P.X(r[1]),x1=P.X(r[2]);ctx.save();ctx.fillStyle=colA(.22);ctx.strokeStyle=col;ctx.lineWidth=1.4;
      ctx.beginPath();ctx.roundRect?ctx.roundRect(x0,P.Y(y)-10,Math.max(3,x1-x0),20,5):ctx.rect(x0,P.Y(y)-10,Math.max(3,x1-x0),20);ctx.fill();ctx.stroke();ctx.restore();
      if(narrow)P.text(Math.min(x0,W-150),P.Y(y)-24,r[0],col,{sz:10.5,b:1});
      else P.text(P.box.x0-8,P.Y(y),r[0],col,{align:'right',base:'middle',sz:11,b:1});
      if(r[4]&&!narrow)P.text(Math.min(x1+6,W-10),P.Y(y),r[4],C.inkA(.6),{base:'middle',sz:10,align:x1>W-160?'right':'left'});});
    if(st.opt.set==='levels'){P.vline(-7,C.probA(.7),1,[4,3]);P.label(-7,S.rows.length-.05,' 100 nm',C.prob,{sz:10,base:'top'});}
  }};

/* ── Al2O3 disks: same substance, three processing routes (Fig 1.1) ── */
FIGS.alumina={ar:.56,arN:.9,opt:{kind:'poly'},
  chips:[{sep:'specimen'},{label:'single crystal',set:{kind:'single'}},{label:'polycrystal, dense',set:{kind:'poly'}},{label:'polycrystal + pores',set:{kind:'porous'}}],
  draw(ctx,W,H,st){
    const k=st.opt.kind,narrow=W<520,R=rng(7);
    const key='al'+k;if(!st.memo[key]){
      const box=[0,0,10,2.4];let seeds=k==='single'?[[5,1.2]]:scatter(60,[-.5,-.5,10.5,2.9],.55,R);
      const cells=voronoi(seeds,box).map((p,i)=>({p,ang:R()*Math.PI}));
      const pores=k==='porous'?scatter(26,[.2,.2,9.8,2.2],.35,R).map(q=>[q[0],q[1],.07+R()*.08]):[];
      /* trace 70 rays from the printed page (bottom) upward through the slab */
      const rays=[],R2=rng(11);let straight=0;
      for(let i=0;i<70;i++){let x=.15+9.7*i/69,y=0,a=Math.PI/2;const path=[[x,y]];let hits=0;
        for(let s=0;s<160&&y>=0&&y<=2.4&&x>=-1&&x<=11;s++){const nx=x+Math.cos(a)*.03,ny=y+Math.sin(a)*.03;
          if(k!=='single'){const own=p=>{let b=0,bd=1e9;seeds.forEach((q,j)=>{const d=(q[0]-p[0])**2+(q[1]-p[1])**2;if(d<bd){bd=d;b=j;}});return b;};
            if(own([x,y])!==own([nx,ny])){a+=(R2()-.5)*.28;hits++;path.push([nx,ny]);}}
          for(const pr of pores){const d0=Math.hypot(x-pr[0],y-pr[1]),d1=Math.hypot(nx-pr[0],ny-pr[1]);
            if(d0>pr[2]&&d1<=pr[2]){a+=(R2()-.5)*2.6;hits+=3;path.push([nx,ny]);}}
          x=nx;y=ny;}
        path.push([x,y]);const out=y>2.4&&Math.abs(a-Math.PI/2)<.12;if(out)straight++;rays.push({path,out});}
      st.memo[key]={cells,pores,rays,frac:straight/70};}
    const M=st.memo[key];
    const pw=narrow?W:W*.62;const P=Plot(ctx,pw,narrow?H*.62:H,{l:14,r:10,t:30,b:26});P.clear();P.dom(-.2,10.2).ran(-.6,3.1);
    ctx.clearRect(0,0,W,H);
    P.text(10,8,'side view: light from the page travels up through the disk',C.ink,{d:1,b:1,sz:11.5});
    /* grains with their lattice hatch at a random angle */
    M.cells.forEach(c=>{P.poly(c.p,C.negA(.06),null);ctx.save();ctx.beginPath();c.p.forEach((q,i)=>i?ctx.lineTo(P.X(q[0]),P.Y(q[1])):ctx.moveTo(P.X(q[0]),P.Y(q[1])));ctx.closePath();ctx.clip();
      ctx.strokeStyle=C.negA(.22);ctx.lineWidth=1;const cx=P.X(5),cy=P.Y(1.2),L=900,s=7,ca=Math.cos(c.ang),sa=Math.sin(c.ang);
      ctx.beginPath();for(let o=-L;o<=L;o+=s){ctx.moveTo(cx+o*ca-L*sa,cy+o*sa+L*ca);ctx.lineTo(cx+o*ca+L*sa,cy+o*sa-L*ca);}ctx.stroke();ctx.restore();
      if(k!=='single')P.poly(c.p,null,C.inkA(.55),1.2);});
    M.pores.forEach(p=>{ctx.save();ctx.fillStyle=C.bg;ctx.strokeStyle=C.wall;ctx.lineWidth=1.2;ctx.beginPath();
      ctx.arc(P.X(p[0]),P.Y(p[1]),Math.abs(P.X(p[2])-P.X(0)),0,7);ctx.fill();ctx.stroke();ctx.restore();});
    P.poly([[0,0],[10,0],[10,2.4],[0,2.4]],null,C.ink,1.6);
    ctx.save();ctx.beginPath();ctx.rect(0,P.Y(3.1),pw,P.Y(-.6)-P.Y(3.1));ctx.clip();
    M.rays.forEach(r=>{ctx.strokeStyle=r.out?C.amberA(.85):C.amberA(.28);ctx.lineWidth=r.out?1.4:1;ctx.beginPath();
      r.path.forEach((q,i)=>i?ctx.lineTo(P.X(q[0]),P.Y(q[1])):ctx.moveTo(P.X(q[0]),P.Y(q[1])));ctx.stroke();});ctx.restore();
    P.label(0,-.45,'printed page ↑ light',C.inkA(.6),{sz:10});
    /* what the eye sees: the disk over the word */
    const tx=narrow?W/2:pw+(W-pw)/2,ty=narrow?H*.8:H/2,rr=narrow?H*.15:Math.min((W-pw)*.4,H*.32);
    ctx.save();ctx.textAlign='center';ctx.textBaseline='middle';ctx.fillStyle=C.ink;
    /* the word is read *through* the disk, so size it to the disk — at full width it ran off the canvas */
    let fs=Math.round(rr*.42);ctx.font=`700 ${fs}px ${FD}`;
    const tw=ctx.measureText('MATERIALS').width;
    if(tw>rr*2){fs=Math.max(11,Math.floor(fs*rr*2/tw));ctx.font=`700 ${fs}px ${FD}`;}
    ctx.fillText('MATERIALS',tx,ty);
    const f=M.frac,fog=k==='single'?0:k==='poly'?.62:.97;
    ctx.beginPath();ctx.arc(tx,ty,rr,0,7);ctx.fillStyle=C.dark?`rgba(235,235,230,${fog*.92})`:`rgba(250,250,247,${fog})`;ctx.fill();
    ctx.lineWidth=1.5;ctx.strokeStyle=C.inkA(.35);ctx.stroke();ctx.restore();
    const word={single:'transparent',poly:'translucent',porous:'opaque'}[k];
    P.text(tx,ty+rr+8,word+' · '+Math.round(f*100)+'% of rays pass straight',C.amber,{align:'center',sz:10.5,b:1});
  }};

/* ── property bar charts by class (Figs 1.4–1.8), log axis ── */
const CLS={M:['metals','pos'],C:['ceramics','blue'],P:['polymers','green'],X:['composites','prob'],S:['semiconductors','amber']};
const BARS={
  density:{t:'density',u:'g/cm³',lo:.1,hi:40,rows:[['M','Platinum',21.5],['M','Silver',10.5],['M','Copper',8.9],['M','Iron / steel',7.8],['M','Titanium',4.5],['M','Aluminium',2.7],['M','Magnesium',1.7],
    ['C','ZrO₂',6.0],['C','Al₂O₃',4.0],['C','SiC, Si₃N₄',3.1,3.2],['C','Glass',2.5],['C','Concrete',2.4],
    ['P','PTFE',2.15],['P','PVC',1.3,1.4],['P','PS',1.05],['P','PE',.95],['P','Rubber',.9,1.0],
    ['X','GFRC',1.5,2.0],['X','CFRC',1.5],['X','Woods',.5,.8]]},
  stiffness:{t:'stiffness — elastic modulus',u:'GPa',lo:.001,hi:1000,rows:[['M','Tungsten',400],['M','Iron / steel',200],['M','Titanium',110],['M','Aluminium',70],['M','Magnesium',45],
    ['C','SiC',400],['C','Al₂O₃',380],['C','Si₃N₄',300],['C','ZrO₂',200],['C','Glass',70],['C','Concrete',30],
    ['P','PVC',3],['P','PS, Nylon',2,3],['P','PTFE',.5],['P','PE',.2,1],['P','Rubbers',.001,.01],
    ['X','CFRC',100,200],['X','GFRC',30,50],['X','Woods',10]]},
  strength:{t:'strength — tensile strength',u:'MPa',lo:10,hi:3000,rows:[['M','Steel alloys',400,1500],['M','Cu, Ti alloys',300,1000],['M','Aluminium alloys',100,500],['M','Gold',100,200],
    ['C','Si₃N₄',400,800],['C','SiC',300,600],['C','Al₂O₃',300,500],['C','Glass',100],
    ['P','Nylon',70,100],['P','PS',40,60],['P','PVC',40,60],['P','PTFE',20,40],['P','PE',15,40],
    ['X','CFRC',600,1100],['X','GFRC',300,800],['X','Woods',30,100]]},
  toughness:{t:'resistance to fracture — fracture toughness',u:'MPa√m',lo:.1,hi:300,rows:[['M','Steel alloys',50,150],['M','Titanium alloys',50,100],['M','Aluminium alloys',20,40],
    ['C','Si₃N₄',4,6],['C','Al₂O₃',3,5],['C','SiC',3,4],['C','Glass',.7,1],['C','Concrete',.2,.5],
    ['P','Nylon',2,3],['P','Polystyrene',1,1.5],['P','Polyethylene',1,2],['P','Polyester',.5,1],
    ['X','CFRC',20,50],['X','GFRC',20,40],['X','Wood',1,10]]},
  conductivity:{t:'electrical conductivity',u:'(Ω·m)⁻¹',lo:1e-20,hi:1e9,rows:[['M','Metals',1e6,1e8],['S','Semiconductors',1e-6,1e4],['C','Ceramics',1e-20,1e-8],['P','Polymers',1e-18,1e-14]]}
};
FIGS.classbars={opt:{p:'density'},
  chips:[{sep:'property'},{label:'density',set:{p:'density'}},{label:'stiffness',set:{p:'stiffness'}},{label:'strength',set:{p:'strength'}},{label:'toughness',set:{p:'toughness'}},{label:'conductivity',set:{p:'conductivity'}}],
  ar:(w,st)=>Math.min(1.5,(BARS[st.opt.p].rows.length*17+84)/w),
  draw(ctx,W,H,st){const B=BARS[st.opt.p];const lo=LOG10(B.lo),hi=LOG10(B.hi);
    const P=Plot(ctx,W,H,{l:112,r:14,t:40,b:30});P.clear().dom(lo,hi).ran(0,B.rows.length);
    P.text(10,8,B.t+'  ('+B.u+', log scale)',C.ink,{d:1,b:1,sz:12});
    let lx=10;Object.keys(CLS).forEach(k=>{if(!B.rows.some(r=>r[0]===k))return;const c=CLS[k];ctx.fillStyle=C[c[1]];ctx.fillRect(lx,26,9,9);
      P.text(lx+13,24,c[0],C.inkA(.7),{sz:10});lx+=c[0].length*6.4+30;});
    const ex=[];for(let e=Math.ceil(lo);e<=hi;e++)ex.push(e);
    const step=ex.length>12?4:ex.length>7?2:1;
    ex.forEach(e=>P.seg(e,0,e,B.rows.length,C.grid,1));
    P.xticks(ex.filter(e=>e%step===0),e=>e>=-2&&e<=3?String(+Math.pow(10,e).toPrecision(1)):tenTo(e));
    B.rows.forEach((r,i)=>{const y=B.rows.length-i-.5,c=CLS[r[0]][1],a=LOG10(r[2]),b=LOG10(r[3]||r[2]);
      const x0=P.X(Math.min(a,b)),x1=P.X(Math.max(a,b));const single=!r[3];
      ctx.save();ctx.fillStyle=C[c+'A'](.3);ctx.strokeStyle=C[c];ctx.lineWidth=1.3;
      if(single){ctx.fillStyle=C[c+'A'](.3);ctx.fillRect(P.X(lo),P.Y(y)-5,x1-P.X(lo),10);ctx.fillStyle=C[c];ctx.beginPath();ctx.arc(x1,P.Y(y),4,0,7);ctx.fill();}
      else{ctx.fillRect(x0,P.Y(y)-6,Math.max(3,x1-x0),12);ctx.strokeRect(x0,P.Y(y)-6,Math.max(3,x1-x0),12);}
      ctx.restore();P.text(P.box.x0-6,P.Y(y),r[1],C[c],{align:'right',base:'middle',sz:10.5});});
  }};

/* ── a schematic Ashby chart: E against ρ, family envelopes from the bar-chart ranges ── */
const ASHBY=[['foams',.01,.5,1e-4,1,'wall'],['elastomers',.9,1.6,.001,.06,'green'],['natural materials',.1,1.6,.01,30,'amber'],
  ['polymers',.9,2.2,.2,4,'green'],['composites',1.4,2.1,10,200,'prob'],['technical ceramics',2.2,6.2,70,450,'blue'],['metals & alloys',1.7,21.5,40,420,'pos']];
FIGS.ashby={ar:.72,arN:1,opt:{guide:true},chips:[{label:'show E/ρ guide lines',set:{guide:true},toggle:true}],
  draw(ctx,W,H,st){const P=Plot(ctx,W,H,{l:52,r:14,t:30,b:44});P.clear().dom(-2,1.5).ran(-4,3);
    for(let e=-2;e<=1;e++)P.seg(e,-4,e,3,C.grid,1);for(let e=-4;e<=3;e++)P.seg(-2,e,1.5,e,C.grid,1);
    P.axes({y0:-4,xl:'density ρ (g/cm³)',yl:'Young’s modulus E (GPa)'});
    P.xticks([-2,-1,0,1],e=>String(+Math.pow(10,e).toPrecision(1)));P.yticks([-4,-2,0,2],e=>e>=0?String(Math.pow(10,e)):tenTo(e));
    if(st.opt.guide){for(let c=-4;c<=4;c+=2){P.seg(-2,-2+c,1.5,1.5+c,C.inkA(.18),1,[5,4]);}
      P.label(1.1,2.9,'E/ρ = const',C.inkA(.5),{sz:9.5});}
    ASHBY.forEach(f=>{const x0=LOG10(f[1]),x1=LOG10(f[2]),y0=LOG10(f[3]),y1=LOG10(f[4]);
      const cx=P.X((x0+x1)/2),cy=P.Y((y0+y1)/2),rx=Math.abs(P.X(x1)-P.X(x0))/2+8,ry=Math.abs(P.Y(y1)-P.Y(y0))/2+8;
      ctx.save();ctx.fillStyle=C[f[5]+'A'](.16);ctx.strokeStyle=C[f[5]];ctx.lineWidth=1.5;ctx.beginPath();ctx.ellipse(cx,cy,rx,ry,0,0,7);ctx.fill();ctx.stroke();ctx.restore();
      P.text(cx,cy,f[0],C[f[5]],{align:'center',base:'middle',sz:10.5,b:1});});
    P.text(10,8,'stiffness vs density — families cluster (schematic, from the book’s ranges)',C.ink,{d:1,b:1,sz:11.5});
  }};

/* ── nanomaterials: fraction of atoms sitting on the surface of a sphere of diameter D ── */
FIGS.nanosurf={ar:.56,arN:.85,opt:{D:10},
  chips:[{sep:'particle'},{label:'2 nm',set:{D:2}},{label:'5 nm',set:{D:5}},{label:'10 nm',set:{D:10}},{label:'50 nm',set:{D:50}},{label:'100 nm',set:{D:100}}],
  draw(ctx,W,H,st){const a=.2,f=D=>D<=2*a?1:1-Math.pow((D-2*a)/D,3);
    const narrow=W<520,pw=narrow?W:W*.64;const P=Plot(ctx,pw,H,{l:46,r:12,t:30,b:34});P.clear();P.dom(0,3).ran(0,1);
    ctx.clearRect(0,0,W,H);P.grid(6,4).axes({xl:'particle diameter D (nm)',yl:'fraction of atoms on the surface'});
    P.xticks([0,1,2,3],e=>String(Math.pow(10,e)));P.yticks([0,.25,.5,.75,1],v=>Math.round(v*100)+'%');
    P.fill(x=>f(Math.pow(10,x)),C.probA(.12));P.curve(x=>f(Math.pow(10,x)),C.prob,2.4);
    P.vline(2,C.inkA(.35),1,[4,3]);P.label(2,.93,' 100 nm = nano limit (≈ 500 atoms across)',C.inkA(.6),{sz:9.5});
    const D=st.opt.D,x=LOG10(D),v=f(D);P.dot(x,v,C.prob,5.5,C.bg);P.label(x,v,'  '+(v*100).toFixed(1)+'%',C.prob,{b:1,sz:11});
    P.text(10,8,'shrink the particle and the surface takes over',C.ink,{d:1,b:1,sz:11.5});
    if(narrow)return;
    /* the particle itself, atom by atom (2-D slice): surface atoms coloured */
    const cx=pw+(W-pw)/2,cy=H/2,R=Math.min((W-pw)*.42,H*.36),n=Math.min(D/a,60),s=2*R/n;
    ctx.save();for(let i=0;i<=n;i++)for(let j=0;j<=n;j++){const px=cx-R+i*s+s/2,py=cy-R+j*s+s/2,rr=Math.hypot(px-cx,py-cy);if(rr>R)continue;
      ctx.fillStyle=rr>R-s*1.05?C.prob:C.inkA(.25);ctx.beginPath();ctx.arc(px,py,Math.max(.8,s*.42),0,7);ctx.fill();}
    ctx.restore();P.text(cx,cy+R+10,D>=D/a*a&&n<D/a?'slice (not all atoms drawn)':'slice through the particle',C.inkA(.55),{align:'center',sz:9.5});
  }};

/* ── E_N(r) = −A/r + B/rⁿ and F = dE/dr (Callister's convention: attraction +) ── */
const bondE=(r,n,A)=>-A/r+(A/n)/Math.pow(r,n);            // B chosen so that r0 = 1
const bondF=(r,n,A)=>A/(r*r)-A/Math.pow(r,n+1);           // dE/dr
FIGS.bondcurve={ar:.92,arN:1.3,opt:{n:8},
  chips:[{sep:'repulsion exponent n'},{label:'n = 6',set:{n:6}},{label:'n = 8',set:{n:8}},{label:'n = 10',set:{n:10}},{label:'n = 12',set:{n:12}}],
  steps:['Bring two atoms together from far away. First, only the <b>attraction</b>: $E_A=-A/r$ keeps falling as they approach, and its force $F_A=dE_A/dr=+A/r^2$ grows.',
    'Now the <b>repulsion</b> of the overlapping electron clouds: $E_R=B/r^n$ is negligible at large $r$ and explodes when the atoms touch.',
    'Add them: $E_N=E_A+E_R$ and $F_N=F_A+F_R$. The net energy has a <b>well</b>.',
    'At $r_0$ the forces cancel: $F_N=0$, which is exactly where $dE_N/dr=0$ — the <b>bottom of the well</b>. That is the equilibrium spacing (≈ 0.3 nm for many atoms).',
    'The depth of the well is the <b>bonding energy $E_0$</b> — the energy needed to pull the pair apart to infinity. Deep well → high melting point.',
    'The slope of $F_N$ at $r_0$ (= curvature of the well) sets the <b>stiffness</b>: steeper → higher elastic modulus. Change $n$ and watch it.'],
  draw(ctx,W,H,st){const n=st.opt.n,A=1,s=st.step,E0=bondE(1,n,A);
    const h2=H/2;const top=Plot(ctx,W,h2,{l:46,r:16,t:30,b:18});top.clear();
    ctx.clearRect(0,0,W,H);
    top.dom(.55,3).ran(-1.3,1.3).grid(8,4).axes({yl:'force F'});top.clip();
    top.text(W-16,34,'+ attraction',C.inkA(.5),{align:'right',sz:9.5});top.text(W-16,h2-34,'− repulsion',C.inkA(.5),{align:'right',sz:9.5});
    top.curve(r=>A/(r*r),s>=2?C.negA(.45):C.neg,s>=2?1.4:2.2,s>=2?[5,4]:null);top.label(2.3,A/5.29+.12,'F_A',C.neg,{sz:10.5,b:1});
    if(s>=1){top.curve(r=>-A/Math.pow(r,n+1),s>=2?C.wallA(.45):C.wall,s>=2?1.4:2.2,s>=2?[5,4]:null);top.label(.62,-1.15,'F_R',C.wall,{sz:10.5,b:1});}
    if(s>=2){top.curve(r=>bondF(r,n,A),C.ink,2.6);top.label(1.55,bondF(1.55,n,A)+.14,'F_N',C.ink,{sz:10.5,b:1});}
    if(s>=3){top.vline(1,C.probA(.6),1.2,[4,3]);top.dot(1,0,C.prob,4.5);top.label(1,.12,' r₀',C.prob,{b:1,sz:11});}
    if(s>=5){const k=(n-1)*A;top.seg(.82,-k*.18,1.18,k*.18,C.amber,2.2);top.label(1.2,k*.18,' slope dF/dr = '+k.toFixed(0)+' (stiffness)',C.amber,{sz:10,b:1});}
    top.unclip();const bot=Plot(ctx,W,H,{l:46,r:16,t:h2+14,b:44});bot.dom(.55,3).ran(-1.3,1.3).grid(8,4).axes({xl:'interatomic separation r',yl:'energy E'});
    bot.xticks([1,2,3],v=>v===1?'r₀':v+'r₀');bot.clip();
    bot.curve(r=>-A/r,s>=2?C.negA(.45):C.neg,s>=2?1.4:2.2,s>=2?[5,4]:null);bot.label(2.4,-A/2.4-.14,'E_A = −A/r',C.neg,{sz:10.5,b:1});
    if(s>=1){bot.curve(r=>(A/n)/Math.pow(r,n),s>=2?C.wallA(.45):C.wall,s>=2?1.4:2.2,s>=2?[5,4]:null);bot.label(.63,1.12,'E_R = B/rⁿ',C.wall,{sz:10.5,b:1});}
    if(s>=2){bot.curve(r=>bondE(r,n,A),C.ink,2.6);bot.label(2.1,bondE(2.1,n,A)+.16,'E_N',C.ink,{sz:10.5,b:1});}
    if(s>=3){bot.vline(1,C.probA(.6),1.2,[4,3]);bot.dot(1,E0,C.prob,4.5);}
    if(s>=4){bot.arrow(1.35,0,1.35,E0,C.pos,1.8);bot.hline(E0,C.posA(.5),1,[3,3]);bot.label(1.4,E0/2,' E₀ = '+(-E0).toFixed(3)+' A/r₀',C.pos,{b:1,sz:10.5});}
    bot.unclip();
    capBlock(ctx,[['two atoms, one bond  ·  n = '+n,C.ink],s>=3?['r₀: F_N = 0  ⇔  dE_N/dr = 0',C.prob]:null]);
  }};

/* ── two wells compared: melting point, stiffness, thermal expansion from the curve's shape ── */
function wellRoots(E,n,A,lvl){const f=r=>bondE(r,n,A)-lvl;const bis=(a,b)=>{for(let i=0;i<60;i++){const m=(a+b)/2;(f(a)*f(m)<=0)?b=m:a=m;}return (a+b)/2;};
  return [bis(.5,1),bis(1,20)];}
FIGS.wells={ar:.7,arN:1.05,opt:{show:'both'},
  chips:[{sep:'material'},{label:'deep & narrow',set:{show:'deep'}},{label:'shallow & wide',set:{show:'shallow'}},{label:'both',set:{show:'both'}}],
  steps:['Two materials, same equilibrium spacing $r_0$, different wells: a <b>deep, narrow</b> one (strong bond) and a <b>shallow, wide</b> one (weak bond).',
    'Depth = bonding energy $E_0$. Heat must supply about this much per bond to melt the solid: the deep well melts at a far higher temperature.',
    'Curvature at the bottom = stiffness. The narrow well is sharply curved (steep $dF/dr$), so a small stretch costs a lot of energy: high elastic modulus.',
    'Heat the solid: atoms vibrate between the two walls at higher energy levels. Because the well is <b>lop-sided</b> (steep inside, gentle outside), the midpoint of each level moves outward — the solid expands. The shallow, wide well lurches outward far more: larger thermal expansion coefficient.'],
  draw(ctx,W,H,st){const s=st.step,show=st.opt.show;
    const P=Plot(ctx,W,H,{l:46,r:16,t:40,b:44});P.clear().dom(.6,2.6).ran(-2,.9).grid(8,6).axes({xl:'separation r',yl:'energy E_N'});P.clip();
    const M=[{k:'deep',A:2,n:12,col:C.neg,colA:C.negA,lab:'deep & narrow'},{k:'shallow',A:.8,n:6,col:C.pos,colA:C.posA,lab:'shallow & wide'}];
    M.forEach((m,i)=>{if(show!=='both'&&show!==m.k)return;const E0=bondE(1,m.n,m.A);
      P.curve(r=>bondE(r,m.n,m.A),m.col,2.5);P.label(2.25,bondE(2.25,m.n,m.A)-.13,m.lab,m.col,{b:1,sz:10.5});
      if(s>=1){P.arrow(i?1.12:.92,0,i?1.12:.92,E0,m.col,1.7);P.label(i?1.14:.7,E0*.55,'E₀ = '+(-E0).toFixed(2),m.col,{sz:10,b:1});}
      if(s>=2){const k=m.A*(m.n-1);P.curve(r=>E0+.5*k*(r-1)*(r-1),m.colA(.55),1.3,[4,3],.8,1.2);}
      if(s>=3){const lv=[.08,.18,.3,.45].map(f=>E0+f*(-E0)*(m.k==='deep'?.5:1));const mids=[];
        lv.forEach(L=>{const [a,b]=wellRoots(E0,m.n,m.A,L);P.seg(a,L,b,L,m.colA(.6),1.2);const c=(a+b)/2;mids.push([c,L]);P.dot(c,L,m.col,3);});
        mids.unshift([1,E0]);ctx.save();ctx.strokeStyle=m.col;ctx.lineWidth=1.8;ctx.setLineDash([2,3]);ctx.beginPath();
        mids.forEach((q,j)=>j?ctx.lineTo(P.X(q[0]),P.Y(q[1])):ctx.moveTo(P.X(q[0]),P.Y(q[1])));ctx.stroke();ctx.restore();}
    });
    P.unclip();P.vline(1,C.inkA(.3),1,[3,3]);P.label(1,.75,' r₀',C.inkA(.6),{sz:10.5,b:1});
    capBlock(ctx,[['what the well’s shape predicts',C.ink],['depth → melting point · curvature → stiffness · lop-sidedness → expansion',C.inkA(.65)]]);
  }};

/* ── ionic bonding in NaCl: shells, transfer, ions, the Coulomb lattice (Fig 2.11) ── */
FIGS.naclform={ar:.6,arN:.95,
  steps:['Neutral atoms. Sodium: 11 electrons in shells of 2, 8, 1 — a lone 3s electron far from the nucleus. Chlorine: 17 electrons, 2, 8, 7 — one short of a full shell.',
    'Na has low electronegativity and Cl high: the 3s electron <b>transfers</b> from Na to Cl.',
    'Now both have noble-gas shells: Na⁺ looks like neon (2, 8) and <b>shrinks</b>; Cl⁻ looks like argon (2, 8, 8) and <b>swells</b>. Opposite charges attract — a Coulombic force.',
    'In the solid every Na⁺ is surrounded by Cl⁻ and vice versa. The force acts equally in all directions — the bond is <b>non-directional</b>.'],
  draw(ctx,W,H,st){const s=st.step;ctx.clearRect(0,0,W,H);readPalette();
    const shell=(cx,cy,rs,ns,col,lab,sym,charge)=>{rs.forEach((r,i)=>{ctx.save();ctx.strokeStyle=C.inkA(.25);ctx.setLineDash([3,3]);ctx.beginPath();ctx.arc(cx,cy,r,0,7);ctx.stroke();ctx.restore();
        for(let k=0;k<ns[i];k++){const a=-Math.PI/2+k*2*Math.PI/ns[i]+(i*.3);ctx.fillStyle=i===rs.length-1&&lab?C[lab]:C.inkA(.65);ctx.beginPath();ctx.arc(cx+r*Math.cos(a),cy+r*Math.sin(a),3.2,0,7);ctx.fill();}});
      ball(ctx,cx,cy,Math.max(8,rs[0]*.55),C[col],C[col+'A'],{txt:sym,tsz:11});
      if(charge){ctx.save();ctx.fillStyle=C[col];ctx.font=`700 16px ${FD}`;ctx.textAlign='center';ctx.fillText(charge,cx+rs[rs.length-1]*.8,cy-rs[rs.length-1]*.8);ctx.restore();}};
    if(s<=2){const u=Math.min(W,H*1.6)/13,y=H*.52;
      const nax=W*.27,clx=W*.73;
      if(s<2){shell(nax,y,[u*.9,u*1.8,u*2.9],[2,8,1],'pos','amber','Na');shell(clx,y,[u*.8,u*1.6,u*2.3],[2,8,7],'neg',null,'Cl');}
      else{shell(nax,y,[u*.9,u*1.8],[2,8],'pos',null,'Na','+');shell(clx,y,[u*.8,u*1.6,u*2.55],[2,8,8],'neg','amber','Cl','−');}
      if(s===1){const a=[nax+u*2.9*Math.cos(-Math.PI/2+.6),y+u*2.9*Math.sin(-Math.PI/2+.6)];arrowPx(ctx,a[0],a[1]-4,clx-u*2.4,y-u*1.2,C.amber,2,10);
        ctx.save();ctx.fillStyle=C.amber;ctx.font=`600 11px ${FM}`;ctx.textAlign='center';ctx.fillText('3s electron',W/2,y-u*2.9);ctx.restore();}
      if(s===2){arrowPx(ctx,nax+u*2.1,y,W/2-6,y,C.prob,2);arrowPx(ctx,clx-u*2.9,y,W/2+6,y,C.prob,2);
        ctx.save();ctx.fillStyle=C.prob;ctx.font=`600 11px ${FM}`;ctx.textAlign='center';ctx.fillText('Coulombic attraction',W/2,y+u*1.2);ctx.restore();}
      capBlock(ctx,[[['Na 2,8,1  +  Cl 2,8,7','Na  →  Cl : one electron','Na⁺ (Ne core)  +  Cl⁻ (Ar core)'][s],C.ink]]);
    }else{const n=7,m=4,g=Math.min(W/(n+1),H/(m+1.4));const ox=(W-g*(n-1))/2,oy=(H-g*(m-1))/2+8;
      for(let i=0;i<n;i++)for(let j=0;j<m;j++){const x=ox+i*g,y=oy+j*g;if(i<n-1){ctx.strokeStyle=C.probA(.35);ctx.lineWidth=1.2;ctx.beginPath();ctx.moveTo(x+g*.3,y);ctx.lineTo(x+g*.7,y);ctx.stroke();}
        if(j<m-1){ctx.beginPath();ctx.moveTo(x,y+g*.3);ctx.lineTo(x,y+g*.7);ctx.stroke();}}
      for(let i=0;i<n;i++)for(let j=0;j<m;j++){const x=ox+i*g,y=oy+j*g,na=(i+j)%2===0;
        ball(ctx,x,y,na?g*.2:g*.33,na?C.pos:C.neg,na?C.posA:C.negA,{txt:na?'Na⁺':'Cl⁻',tsz:Math.max(8,g*.17)});}
      capBlock(ctx,[['each ion surrounded by the opposite kind',C.ink],['Coulombic force in every direction — non-directional',C.prob]]);}
  }};

/* ── carbon hybridisation, energy-level boxes (Figs 2.13, 2.16) ── */
FIGS.hybrid={ar:.62,arN:.95,opt:{h:'sp3'},
  chips:[{sep:'hybrid'},{label:'sp³ (CH₄, diamond)',set:{h:'sp3'}},{label:'sp² (graphite)',set:{h:'sp2'}}],
  steps:['Ground-state carbon: $1s^2\,2s^2\,2p^2$ — only two unpaired electrons, so it "should" form two bonds. It forms four.',
    '<b>Promotion</b>: one 2s electron moves up to the empty 2p box → $1s^2\,2s^1\,2p^3$, four unpaired electrons.',
    st=>st.opt.h==='sp3'?'<b>Hybridisation</b>: the 2s and all three 2p orbitals mix into four identical $sp^3$ orbitals, each with one electron. They point to the corners of a tetrahedron, 109.5° apart.'
      :'<b>Hybridisation</b>: the 2s and two 2p orbitals mix into three $sp^2$ orbitals (in a plane, 120° apart); $2p_z$ stays unmixed and sticks out of the plane.'],
  draw(ctx,W,H,st){const s=st.step,h=st.opt.h;ctx.clearRect(0,0,W,H);
    const bw=Math.min(40,W/14),bh=bw*.9,cx=W*.55;
    const lvl={s1:H*.84,s2:H*.58,p2:H*.38,h:H*.47,pz:H*.3};
    const box=(x,y,e,lab)=>{ctx.save();ctx.strokeStyle=C.ink;ctx.lineWidth=1.4;ctx.strokeRect(x,y-bh/2,bw,bh);
      ctx.fillStyle=C.neg;ctx.font=`700 ${bw*.55}px ${FM}`;ctx.textAlign='center';ctx.textBaseline='middle';
      if(e===2){ctx.fillText('↑',x+bw*.32,y);ctx.fillText('↓',x+bw*.68,y);}else if(e===1)ctx.fillText('↑',x+bw/2,y);ctx.restore();};
    const row=(y,lab,es,x0)=>{es.forEach((e,i)=>box(x0+i*(bw+4),y,e));ctx.save();ctx.fillStyle=C.inkA(.7);ctx.font=`600 12px ${FM}`;ctx.textAlign='right';ctx.textBaseline='middle';ctx.fillText(lab,x0-10,y);ctx.restore();};
    ctx.save();ctx.strokeStyle=C.axis;ctx.lineWidth=1.3;arrowPx(ctx,W*.1,H*.9,W*.1,H*.12,C.axis,1.3);ctx.restore();
    ctx.save();ctx.translate(W*.1-10,H*.5);ctx.rotate(-Math.PI/2);ctx.fillStyle=C.inkA(.6);ctx.font=`10.5px ${FM}`;ctx.textAlign='center';ctx.fillText('energy',0,0);ctx.restore();
    row(lvl.s1,'1s',[2],cx-bw/2);
    if(s<2){row(lvl.s2,'2s',[s===0?2:1],cx-bw/2-(bw+4)*1.5);row(lvl.p2,'2p',s===0?[1,1,0]:[1,1,1],cx-bw/2);
      if(s===0){arrowPx(ctx,cx-bw/2-(bw+4)*1.5+bw/2,lvl.s2-bh/2-2,cx-bw/2+2*(bw+4)+bw/2,lvl.p2+bh/2+2,C.amber,1.8);
        ctx.save();ctx.fillStyle=C.amber;ctx.font=`600 11px ${FM}`;ctx.fillText('promotion',cx+bw*2.2,lvl.s2);ctx.restore();}}
    else if(h==='sp3'){row(lvl.h,'2sp³',[1,1,1,1],cx-bw/2-(bw+4));}
    else{row(lvl.h,'2sp²',[1,1,1],cx-bw/2-(bw+4)*.5);row(lvl.pz,'2p(z)',[1],cx+bw*2.6);}
    capBlock(ctx,[[['ground state  1s² 2s² 2p²','promoted  1s² 2s¹ 2p³',h==='sp3'?'four sp³ hybrids — 109.5°':'three sp² hybrids — 120°, plus 2p_z'][s],C.ink]]);
  }};

/* ── metallic bonding: ion cores in a sea of valence electrons (Fig 2.19) ── */
FIGS.esea={ar:.55,arN:.85,anim:true,opt:{field:false},
  chips:[{label:'apply an electric field →',set:{field:true},toggle:true}],
  draw(ctx,W,H,st){ctx.clearRect(0,0,W,H);const nx=8,ny=4,g=Math.min(W/(nx+.5),H/(ny+1.2)),ox=(W-g*(nx-1))/2,oy=(H-g*(ny-1))/2+6;
    if(!st.memo.e){const R=rng(5);st.memo.e=Array.from({length:90},()=>({x:R()*W,y:R()*H,a:R()*7,s:.6+R()*.8}));}
    const t=st.t,E=st.memo.e;
    ctx.save();ctx.fillStyle=C.negA(.07);ctx.fillRect(0,0,W,H);ctx.restore();
    for(let i=0;i<nx;i++)for(let j=0;j<ny;j++)ball(ctx,ox+i*g,oy+j*g,g*.3,C.pos,C.posA,{txt:'+',tsz:g*.3});
    E.forEach(e=>{e.a+=(Math.sin(t*3+e.x*.05)*.35);const v=40*e.s;e.x+=Math.cos(e.a)*v/60+(st.opt.field?.9:0);e.y+=Math.sin(e.a)*v/60;
      if(e.x>W)e.x-=W;if(e.x<0)e.x+=W;if(e.y>H)e.y-=H;if(e.y<0)e.y+=H;
      ctx.fillStyle=C.neg;ctx.beginPath();ctx.arc(e.x,e.y,2.6,0,7);ctx.fill();});
    capBlock(ctx,[['ion cores (+) in a sea of valence electrons (−)',C.ink],[st.opt.field?'field on: the whole sea drifts → a current (good conductor)':'electrons belong to no one atom — the bond is non-directional',st.opt.field?C.neg:C.inkA(.65)]]);
  }};

/* ── van der Waals: dipoles, induced dipoles, hydrogen bonds (Figs 2.20–2.23) ── */
FIGS.dipoles={ar:.46,arN:.8,anim:true,opt:{k:'fluct'},
  chips:[{sep:'bond'},{label:'fluctuating induced',set:{k:'fluct'}},{label:'polar → induced',set:{k:'polar'}},{label:'permanent dipoles',set:{k:'perm'}},{label:'hydrogen bond',set:{k:'hb'}}],
  draw(ctx,W,H,st){ctx.clearRect(0,0,W,H);const k=st.opt.k,t=st.t,y=H*.56,u=Math.min(W/11,H/4.2);
    const atom=(x,r,off,lab,col,colA)=>{const g=ctx.createRadialGradient(x+off,y,1,x+off,y,r);g.addColorStop(0,colA(.55));g.addColorStop(1,colA(0));
      ctx.fillStyle=g;ctx.beginPath();ctx.ellipse(x+off*.6,y,r*1.08,r,0,0,7);ctx.fill();
      ctx.fillStyle=C.ink;ctx.beginPath();ctx.arc(x,y,3.4,0,7);ctx.fill();
      if(lab){ctx.fillStyle=C.inkA(.75);ctx.font=`600 11px ${FM}`;ctx.textAlign='center';ctx.fillText(lab,x,y+r+14);}};
    const sign=(x,txt,col)=>{ctx.fillStyle=col;ctx.font=`700 13px ${FM}`;ctx.textAlign='center';ctx.fillText(txt,x,y-u*1.15);};
    const bond=(x1,x2,lab)=>{ctx.save();ctx.strokeStyle=C.prob;ctx.setLineDash([4,4]);ctx.lineWidth=1.8;ctx.beginPath();ctx.moveTo(x1,y);ctx.lineTo(x2,y);ctx.stroke();ctx.restore();
      ctx.fillStyle=C.prob;ctx.font=`600 10.5px ${FM}`;ctx.textAlign='center';ctx.fillText(lab,(x1+x2)/2,y+u*.95);};
    if(k==='fluct'){const o=Math.sin(t*2.2)*u*.35+Math.sin(t*5.1)*u*.12;
      atom(W*.32,u,o,'Ar',C.neg,C.negA);atom(W*.68,u,o*.8,'Ar',C.neg,C.negA);
      if(Math.abs(o)>u*.18){const s1=o>0;sign(W*.32-u*.7,s1?'δ+':'δ−',C.inkA(.6));sign(W*.32+u*.7,s1?'δ−':'δ+',C.inkA(.6));
        sign(W*.68-u*.7,s1?'δ+':'δ−',C.inkA(.6));sign(W*.68+u*.7,s1?'δ−':'δ+',C.inkA(.6));bond(W*.32+u*1.1,W*.68-u*1.1,'weak, flickering attraction');}
      capBlock(ctx,[['fluctuating induced dipoles',C.ink],['a random lurch of one cloud induces the same in its neighbour (Ar, H₂, Cl₂, CH₄)',C.inkA(.65)]]);}
    else if(k==='polar'){const w=Math.sin(t*1.5)*.08;
      atom(W*.25-u*.55,u*.55,0,'H',C.pos,C.posA);atom(W*.25+u*.35,u*.95,u*.25,'Cl',C.neg,C.negA);
      sign(W*.25-u*.55,'δ+',C.pos);sign(W*.25+u*.5,'δ−',C.neg);
      atom(W*.7,u,-u*(.3+w),'Ar',C.neg,C.negA);sign(W*.7-u*.7,'δ−',C.inkA(.6));sign(W*.7+u*.7,'δ+',C.inkA(.6));
      bond(W*.25+u*1.35,W*.7-u*1.05,'van der Waals bond');
      capBlock(ctx,[['polar molecule → induced dipole',C.ink],['HCl’s permanent dipole distorts a symmetric neighbour',C.inkA(.65)]]);}
    else if(k==='perm'){[W*.27,W*.68].forEach(x=>{atom(x-u*.55,u*.55,0,'H',C.pos,C.posA);atom(x+u*.35,u*.95,u*.25,'Cl',C.neg,C.negA);sign(x-u*.55,'δ+',C.pos);sign(x+u*.5,'δ−',C.neg);});
      bond(W*.27+u*1.35,W*.68-u*1.1,'dipole–dipole bond');
      capBlock(ctx,[['permanent dipole bonds',C.ink],['two polar molecules line up + to −: stronger than induced ones',C.inkA(.65)]]);}
    else{const xs=[W*.22,W*.62];xs.forEach(x=>{atom(x,u*.3,0,'H',C.pos,C.posA);atom(x+u*1.05,u*.95,-u*.2,'F',C.neg,C.negA);
        ctx.strokeStyle=C.ink;ctx.lineWidth=2.2;ctx.beginPath();ctx.moveTo(x+4,y);ctx.lineTo(x+u*1.05-4,y);ctx.stroke();sign(x,'bare proton',C.pos);});
      bond(xs[0]+u*1.95,xs[1]-u*.35,'hydrogen bond');
      capBlock(ctx,[['hydrogen bond: H–F ··· H–F',C.ink],['H bonded to F, O or N is a nearly bare proton → strongest secondary bond',C.inkA(.65)]]);}
  }};

/* ── density of water: Kell's equation for the liquid, ice Ih below 0 °C ── */
const rhoW=T=>(999.83952+16.945176*T-7.9870401e-3*T*T-46.170461e-6*T**3+105.56302e-9*T**4-280.54253e-12*T**5)/(1+16.879850e-3*T)/1000;
const rhoIce=T=>.9167-9.6e-5*T;
FIGS.waterdens={ar:.62,arN:.95,
  steps:['An ordinary liquid: it contracts steadily as it cools and contracts again when it freezes — its solid sinks.',
    'Liquid water (measured): the density rises as it cools, reaches a maximum of 0.99997 g/cm³ at about 4 °C, then falls.',
    'At 0 °C water freezes into ice with density 0.917 g/cm³ — a sudden drop. The same mass takes ≈ 9 % more volume: ice floats, pipes burst.',
    'Why: in ice every molecule makes four hydrogen bonds in an open tetrahedral network. Melting collapses part of it and neighbours crowd into the gaps (about 4.5 instead of 4).'],
  draw(ctx,W,H,st){const s=st.step;const P=Plot(ctx,W,H,{l:52,r:16,t:40,b:44});P.clear().dom(-30,40).ran(.905,1.006).grid(7,5)
    .axes({y0:.905,xl:'temperature (°C)',yl:'density (g/cm³)'});
    P.xticks([-30,-20,-10,0,10,20,30,40]);P.yticks([.92,.94,.96,.98,1]);
    if(s===0){P.curve(T=>T>=0?.99-.0005*T:.9985-.00012*T,C.inkA(.55),2,[6,4]);P.label(15,.992,'ordinary liquid',C.inkA(.6),{sz:10.5});P.label(-28,1.0,'its solid is denser →',C.inkA(.6),{sz:10});}
    if(s>=1){P.curve(rhoW,C.neg,2.6,null,0,40);P.label(22,rhoW(22)+.004,'liquid water',C.neg,{b:1,sz:10.5});
      P.dot(3.98,rhoW(3.98),C.neg,4);P.label(3.98,rhoW(3.98)+.003,'max at 4 °C',C.neg,{sz:10,align:'center'});}
    if(s>=2){P.curve(rhoIce,C.prob,2.6,null,-30,0);P.label(-26,rhoIce(-26)+.004,'ice',C.prob,{b:1,sz:10.5});
      P.arrow(0,rhoW(0)-.002,0,rhoIce(0)+.002,C.wall,2);P.label(1,.955,' freezing: ρ drops 8.3 %, V grows 9.1 %',C.wall,{b:1,sz:10.5});}
    capBlock(ctx,[['water expands when it freezes',C.ink],s>=2?['ρ(ice) = 0.917  ·  ρ(water, 0 °C) = 0.99984 g/cm³  →  V ratio 1.091',C.inkA(.7)]:null]);
  }};

/* ── percent ionic character: %IC = {1 − exp[−0.25(X_A − X_B)²]} × 100 (Eq. 2.16) ── */
const EN={H:2.1,Li:1.0,C:2.5,N:3.0,O:3.5,F:4.0,Na:.9,Mg:1.2,Al:1.5,Si:1.8,S:2.5,Cl:3.0,K:.8,Ca:1.0,Ti:1.5,Fe:1.8,Ni:1.8,Cu:1.9,Zn:1.6,Ga:1.6,As:2.0,Br:2.8,In:1.7,Sb:1.9,Cs:.7,Au:2.4};
const IC=(a,b)=>(1-Math.exp(-.25*Math.pow(EN[a]-EN[b],2)))*100;
FIGS.ionicchar={ar:.6,arN:.95,opt:{p:['C','H']},
  chips:[{sep:'bond'},{label:'C–H',set:{p:['C','H']}},{label:'Si–C',set:{p:['C','Si']}},{label:'GaAs',set:{p:['As','Ga']}},{label:'AuCu₃',set:{p:['Au','Cu']}},{label:'TiAl₃',set:{p:['Al','Ti']}},
    {label:'KBr',set:{p:['Br','K']}},{label:'NaCl',set:{p:['Cl','Na']}},{label:'MgO',set:{p:['O','Mg']}},{label:'CaF₂',set:{p:['F','Ca']}},{label:'CsF',set:{p:['F','Cs']}}],
  draw(ctx,W,H,st){const [a,b]=st.opt.p,dx=EN[a]-EN[b],v=IC(a,b);
    const P=Plot(ctx,W,H,{l:46,r:16,t:48,b:44});P.clear().dom(0,3.5).ran(0,100).grid(7,4).axes({xl:'electronegativity difference X_A − X_B',yl:'% ionic character'});
    P.xticks([0,.5,1,1.5,2,2.5,3,3.5]);P.yticks([0,25,50,75,100]);
    P.fill(x=>(1-Math.exp(-.25*x*x))*100,C.probA(.1));P.curve(x=>(1-Math.exp(-.25*x*x))*100,C.prob,2.5);
    P.label(2.6,(1-Math.exp(-.25*2.6*2.6))*100-9,'more ionic →',C.prob,{sz:10});P.label(.15,8,'covalent',C.neg,{sz:10});
    P.seg(dx,0,dx,v,C.inkA(.4),1,[3,3]);P.seg(0,v,dx,v,C.inkA(.4),1,[3,3]);P.dot(dx,v,C.wall,5.5,C.bg);
    capBlock(ctx,[['%IC = {1 − exp[−0.25 (X_A − X_B)²]} × 100',C.ink],
      [`X(${a}) = ${EN[a].toFixed(1)}, X(${b}) = ${EN[b].toFixed(1)}  →  ΔX = ${dx.toFixed(1)}  →  %IC = ${v.toFixed(1)} %`,C.wall]]);
  }};

/* ════════════ Module I — 3-D models ════════════ */
MODELS.ch4=()=>{const d=1,H=[[1,1,1],[1,-1,-1],[-1,1,-1],[-1,-1,1]].map(p=>V.mul(V.norm(p),d));
  const balls=[{c:[0,0,0],r:.3,col:'ink'}],bonds=[],labels=[{p:[0,-.02,0],t:'C',col:'bg'}],faces=[];
  H.forEach((h,i)=>{balls.push({c:h,r:.2,col:'neg'});bonds.push({a:[0,0,0],b:h,col:'rule',w:5});labels.push({p:V.mul(h,1.3),t:'H',col:'neg'});});
  for(let i=0;i<4;i++)for(let j=i+1;j<4;j++)bonds.push({a:H[i],b:H[j],col:'accent',w:1,dash:[3,4],alpha:.5});
  const mid=V.mul(V.norm(V.add(H[0],H[1])),.42);labels.push({p:mid,t:'109.5°',col:'accent',sz:11,mono:true});
  return {balls,bonds,faces,labels:labels.filter(l=>l.col!=='bg')};};
V3D.ch4={model:'ch4',ar:.62,pitch:.25};
MODELS.diamond=()=>{const sites=[],balls=[],bonds=[];const T=p=>T3(p);
  for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)sites.push([i,j,k]);
  [[.5,.5,0],[.5,.5,1],[.5,0,.5],[.5,1,.5],[0,.5,.5],[1,.5,.5]].forEach(p=>sites.push(p));
  const inner=[[.25,.25,.25],[.75,.75,.25],[.75,.25,.75],[.25,.75,.75]];
  sites.forEach(p=>balls.push({c:T(p),r:.09,col:'pos'}));inner.forEach(p=>balls.push({c:T(p),r:.09,col:'neg'}));
  inner.forEach(q=>sites.forEach(p=>{if(Math.abs(Math.hypot(p[0]-q[0],p[1]-q[1],p[2]-q[2])-Math.sqrt(3)/4)<1e-6)bonds.push({a:T(q),b:T(p),col:'accent',w:2.4});}));
  boxEdges3([0,0,0],[1,1,1]).forEach(e=>bonds.push({a:T(e[0]),b:T(e[1]),col:'rule',w:1}));
  return {balls,bonds,faces:[]};};
V3D.diamond={model:'diamond',ar:.66};
MODELS.graphite=()=>{const balls=[],bonds=[],a=.55,c=.9;const pts=[];
  for(let L=0;L<3;L++){const off=L%2?[a/Math.sqrt(3)*Math.cos(Math.PI/6)*0+a/2,a/(2*Math.sqrt(3))]:[0,0];
    for(let i=-3;i<=3;i++)for(let j=-3;j<=3;j++){[[0,0],[a/2,a/(2*Math.sqrt(3))]].forEach(b=>{
      const x=i*a+j*a/2+b[0]+off[0],z=j*a*Math.sqrt(3)/2+b[1]+off[1];if(Math.hypot(x,z)>1.25)return;pts.push({p:[x,(L-1)*c,z],L});});}}
  pts.forEach(q=>balls.push({c:q.p,r:.07,col:q.L===1?'neg':'pos'}));
  for(let i=0;i<pts.length;i++)for(let j=i+1;j<pts.length;j++){const A=pts[i].p,B=pts[j].p;const d=V.len(V.sub(A,B));
    if(pts[i].L===pts[j].L&&Math.abs(d-a/Math.sqrt(3))<.02)bonds.push({a:A,b:B,col:'accent',w:2});}
  [[0,-c,0],[0,0,0],[0,c,0]].forEach((o,i)=>{if(i<2)bonds.push({a:[1.35,o[1],0],b:[1.35,o[1]+c,0],col:'rule',w:1,dash:[3,3]});});
  return {balls,bonds,faces:[],labels:[{p:[1.55,-c/2,0],t:'van der Waals',col:'ink',sz:10.5,mono:true},{p:[0,c+.35,0],t:'sp² sheets (hexagons)',col:'accent',sz:11}]};};
V3D.graphite={model:'graphite',ar:.66,pitch:.3};
MODELS.nacl=()=>{const balls=[],bonds=[],pts=[];
  for(let i=0;i<3;i++)for(let j=0;j<3;j++)for(let k=0;k<3;k++)pts.push([i/2,j/2,k/2]);
  pts.forEach(p=>{const cl=(p[0]*2+p[1]*2+p[2]*2)%2;balls.push({c:T3(p),r:cl?.19:.11,col:cl?'neg':'pos'});});
  pts.forEach(p=>pts.forEach(q=>{if(Math.abs(Math.hypot(p[0]-q[0],p[1]-q[1],p[2]-q[2])-.5)<1e-6&&p[0]*4+p[1]*2+p[2]<q[0]*4+q[1]*2+q[2])bonds.push({a:T3(p),b:T3(q),col:'rule',w:1});}));
  return {balls,bonds,faces:[],labels:[{p:[.72,.72,-.6],t:'Na⁺',col:'pos',sz:11},{p:[.72,.72,.6],t:'Cl⁻',col:'neg',sz:11}]};};
V3D.nacl={model:'nacl',ar:.66};
/* ice Ih: oxygens on a wurtzite-type net (c/a = √(8/3), u = 3/8), each O–O link one hydrogen bond */
MODELS.ice=opt=>{const a=1,c=a*Math.sqrt(8/3),u=3/8;const A=[a,0,0],B=[-a/2,a*Math.sqrt(3)/2,0],Cc=[0,0,c];
  const basis=[[0,0,0],[1/3,2/3,.5],[0,0,u],[1/3,2/3,.5+u]];const O=[];
  for(let i=-2;i<=2;i++)for(let j=-2;j<=2;j++)for(let k=-1;k<=1;k++)basis.forEach(b=>{const f=[b[0]+i,b[1]+j,b[2]+k];
    const p=V.add(V.add(V.mul(A,f[0]),V.mul(B,f[1])),V.mul(Cc,f[2]));const q=[p[0],p[2]-c*.55,p[1]];if(Math.hypot(q[0],q[2])<1.55&&Math.abs(q[1])<1.25)O.push(q);});
  const dOO=u*c,edges=[];for(let i=0;i<O.length;i++)for(let j=i+1;j<O.length;j++)if(Math.abs(V.len(V.sub(O[i],O[j]))-dOO)<.03)edges.push([i,j]);
  const out=O.map(()=>0),balls=[],bonds=[];O.forEach(p=>balls.push({c:p,r:.13,col:'wall'}));
  edges.forEach(([i,j])=>{let d=out[i]<2&&(out[j]>=out[i]||out[j]>=2)?i:out[j]<2?j:i;out[d]++;const o=d===i?j:i;
    const hpos=V.add(O[d],V.mul(V.sub(O[o],O[d]),.36));
    if(opt.h!==false)balls.push({c:hpos,r:.06,col:'neg'});
    bonds.push({a:O[d],b:hpos,col:'neg',w:2.6});bonds.push({a:hpos,b:O[o],col:'rule',w:1.2,dash:[3,3]});});
  return {balls,bonds,faces:[],labels:[{p:[0,1.5,0],t:'open hexagonal channels',col:'ink',sz:11}]};};
V3D.ice={model:'ice',ar:.72,pitch:.95,yaw:.1,opt:{h:true},chips:[{label:'show hydrogens',set:{h:true},toggle:true}]};
/* the bonding tetrahedron / material-type tetrahedron (Fig 2.25) */
MODELS.tetra=opt=>{const v={cov:[0,1.05,0],met:[-.95,-.45,-.45],ion:[.95,-.45,-.45],vdw:[0,-.45,.95]};
  const bonds=[],balls=[],labels=[];const E=[['cov','met'],['cov','ion'],['met','ion'],['cov','vdw'],['met','vdw'],['ion','vdw']];
  E.forEach(([p,q])=>bonds.push({a:v[p],b:v[q],col:'rule',w:1.6}));
  const col={cov:'neg',met:'pos',ion:'blue',vdw:'green'};Object.keys(v).forEach(k=>balls.push({c:v[k],r:.07,col:col[k]}));
  const lerp=(p,q,t)=>V.add(v[p],V.mul(V.sub(v[q],v[p]),t));
  if(opt.m!=='mat'){[['cov','covalent'],['met','metallic'],['ion','ionic'],['vdw','van der Waals']].forEach(([k,t])=>labels.push({p:V.mul(v[k],1.25),t,col:col[k],sz:12.5}));
    [['cov','ion','covalent–ionic'],['cov','met','covalent–metallic'],['met','ion','metallic–ionic']].forEach(([p,q,t])=>{labels.push({p:V.mul(lerp(p,q,.5),1.12),t,col:'ink',sz:10.5,mono:true});
      bonds.push({a:lerp(p,q,.25),b:lerp(p,q,.75),col:'accent',w:3.2});});}
  else{[['met',0,'metals','pos'],['cov',0,'polymers','neg'],['vdw',0,'molecular solids','green']].forEach(([k,_,t,c])=>labels.push({p:V.mul(v[k],1.25),t,col:c,sz:12}));
    [['ion','cov',.28,'ceramics','blue'],['cov','ion',.2,'semiconductors','amber'],['cov','met',.5,'semi-metals','accent'],['met','ion',.5,'intermetallics','pos']].forEach(([p,q,t,lab,c])=>{
      const P2=lerp(p,q,t);balls.push({c:P2,r:.09,col:c});labels.push({p:V.add(P2,[0,.17,0]),t:lab,col:c,sz:11});});}
  return {balls,bonds,faces:[{pts:[v.cov,v.met,v.ion],col:'ink',alpha:.04},{pts:[v.cov,v.ion,v.vdw],col:'ink',alpha:.04}],labels};};
V3D.tetra={model:'tetra',ar:.72,pitch:.18,opt:{m:'bond'},chips:[{sep:'corners'},{label:'bonding types',set:{m:'bond'}},{label:'material types',set:{m:'mat'}}]};
