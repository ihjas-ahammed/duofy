#!/usr/bin/env python3
"""Build MATERIAL_SCIENCE_12.html (online) and MATERIAL_SCIENCE_12_OFFLINE.html (self-contained) from src/ + vendor/.
"""
import io, os, re, json, datetime

HERE = os.path.dirname(os.path.abspath(__file__))
SRC, VEN = os.path.join(HERE, 'src'), os.path.join(HERE, 'vendor')
OUT = os.path.abspath(os.path.join(HERE, '..', '..'))  # apps/ directory
ONLINE_URL = 'https://ssc-data-science-qm.web.app/MATERIAL_SCIENCE_12.html'
GF = ('https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,400..700'
      '&family=Instrument+Sans:ital,wght@0,400..700;1,400..700'
      '&family=JetBrains+Mono:wght@400;500;600&display=swap')

rd = lambda p: io.open(p, encoding='utf-8').read()
js = lambda s: s.replace('</script', '<\\/script')

def ui_fonts_inline():
    cache = os.path.join(VEN, 'uifonts.css')
    if os.path.exists(cache):
        return rd(cache)
    return ''

def bundle_js():
    order = [
        'data.head.js',
        'data.start.js',
        'data.m1.js',
        'data.m2.js',
        'data.bank.m1.js',
        'data.bank.m2.js',
        'data.tail.js',
        'data.rev.js',
        'eng.core.js',
        'eng.fig.js',
        'eng.figs.m1.js',
        'eng.figs.m2.js',
        'eng.figs.rev.js',
        'eng.widgets.js',
        'eng.app.js'
    ]
    parts = []
    for f in order:
        p = os.path.join(SRC, f)
        if os.path.exists(p):
            parts.append(rd(p))
        else:
            print(f"Warning: file {f} not found!")
    return '\n;\n'.join(parts)

def build(online):
    shell = rd(os.path.join(SRC, 'shell.html'))
    stamp = datetime.date.today().isoformat()

    head_fonts = (
        f'<link rel="preconnect" href="https://fonts.googleapis.com">'
        f'<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
        f'<link rel="stylesheet" href="{GF}">'
    ) if online else f'<style>{ui_fonts_inline()}</style>'

    cfg = {
        'online': online,
        'onlineURL': ONLINE_URL,
        'offlineName': 'MATERIAL_SCIENCE_12_OFFLINE.html'
    }

    scripts = []
    scripts.append(f'<script>window.MS_CFG = {json.dumps(cfg)};</script>')

    if online:
        scripts.append('<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/es5/tex-svg.js"></script>')
    else:
        tex_path = os.path.join(VEN, 'tex-svg.js')
        if os.path.exists(tex_path):
            scripts.append('<script>' + js(rd(tex_path)) + '</script>')
        else:
            print("Warning: vendor/tex-svg.js not found for offline build!")

    scripts.append('<script>' + js(bundle_js()) + '</script>')

    foot = (f'Built {stamp} · Calicut University CU-FYUGP B.Sc. Physics Honours · Materials Science Modules I &amp; II'
            + (' · <a href="MATERIAL_SCIENCE_12_OFFLINE.html" download>Download 100% self-contained offline copy</a>' if online else
               f' · Offline edition — zero network dependencies · For web version visit <a href="{ONLINE_URL}">online app</a>'))

    html = (shell.replace('<!--MS:FONTS-->', head_fonts)
                 .replace('<!--MS:SCRIPTS-->', '\n'.join(scripts))
                 .replace('<!--MS:FOOT-->', foot))

    name = 'MATERIAL_SCIENCE_12.html' if online else 'MATERIAL_SCIENCE_12_OFFLINE.html'
    dest = os.path.join(OUT, name)
    io.open(dest, 'w', encoding='utf-8').write(html)
    print(f'Built {name}: {len(html.encode()):,} bytes ({len(html.encode()) / (1024*1024):.2f} MB)')

if __name__ == '__main__':
    build(True)
    build(False)
