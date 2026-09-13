#!/usr/bin/env python3
"""Build PYTHON_12.html (online) and PYTHON_12_OFFLINE.html (self-contained) from src/ + vendor/.
"""
import io, os, re, json, base64, datetime

HERE = os.path.dirname(os.path.abspath(__file__))
SRC, VEN = os.path.join(HERE, 'src'), os.path.join(HERE, 'vendor')
OUT = os.path.abspath(os.path.join(HERE, '..', '..'))
ONLINE_URL = 'https://ssc-data-science-qm.web.app/PYTHON_12.html'
GF = ('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600'
      '&family=Newsreader:ital,opsz,wght@0,6..72,400..600;1,6..72,400..600'
      '&family=Source+Sans+3:ital,wght@0,400..700;1,400..700&display=swap')

rd = lambda p: io.open(p, encoding='utf-8').read()
js = lambda s: s.replace('</script', '<\\/script')

def ui_fonts_inline():
    cache = os.path.join(VEN, 'uifonts.css')
    if os.path.exists(cache):
        return rd(cache)
    return ''

def content():
    order = [
        'data.head.js',
        'data.start.js',
        'data.m1.js',
        'data.m2.js',
        'data.omr.js',
        'data.tests.js',
        'data.tail.js'
    ]
    return '\n'.join(rd(os.path.join(SRC, f)) for f in order if os.path.exists(os.path.join(SRC, f)))

def build(online):
    shell = rd(os.path.join(SRC, 'shell.html'))
    head_fonts = (f'<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
                  f'<link rel="stylesheet" href="{GF}">') if online else f'<style>{ui_fonts_inline()}</style>'
    
    scripts = []
    scripts.append(f'<script>window.PY_OFFLINE = {json.dumps(not online)};</script>')
    if online:
        scripts.append('<script src="https://cdn.jsdelivr.net/pyodide/v0.26.4/full/pyodide.js"></script>')
    
    scripts.append('<script>' + js(rd(os.path.join(SRC, 'pyhl.js'))) + '</script>')
    scripts.append('<script>' + js(content()) + '</script>')
    scripts.append('<script>' + js(rd(os.path.join(SRC, 'ui.js'))) + '</script>')
    
    html = shell.replace('<!--PY:FONTS-->', head_fonts).replace('<!--PY:SCRIPTS-->', '\n'.join(scripts))
    name = 'PYTHON_12.html' if online else 'PYTHON_12_OFFLINE.html'
    dest = os.path.join(OUT, name)
    io.open(dest, 'w', encoding='utf-8').write(html)
    print(f'built {name}: {len(html.encode()):,} bytes')

if __name__ == '__main__':
    build(True)
    build(False)
