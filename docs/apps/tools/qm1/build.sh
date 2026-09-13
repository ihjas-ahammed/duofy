#!/usr/bin/env bash
# Rebuild the single-file QM_1.html from shell + data + engine.
cd "$(dirname "$0")"
python3 - <<'PY'
shell=open('QM_1.shell.html').read()
data=open('QM_1.data.js').read()
eng=open('QM_1.engine.js').read()
out=shell.replace('<script src="QM_1.data.js"></script>','<script>\n'+data+'\n</script>')
out=out.replace('<script src="QM_1.engine.js"></script>','<script>\n'+eng+'\n</script>')
assert 'QM_1.data.js"' not in out and 'QM_1.engine.js"' not in out
open('../../QM_1.html','w').write(out)
print("built QM_1.html:",len(out),"bytes")
PY
