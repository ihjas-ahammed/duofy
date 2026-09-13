#!/usr/bin/env bash
# Publish the study apps. Requires a valid login: firebase login --reauth
set -e
APPS="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"; mkdir -p "$TMP/public"
cp "$APPS/QM_1.html" "$TMP/public/QM_1.html"
cp "$APPS/SOLID_STATE_1.html" "$TMP/public/SOLID_STATE_1.html"
cp "$APPS/LATEX_1.html" "$TMP/public/LATEX_1.html"
cp "$APPS/LATEX_12_OFFLINE.html" "$TMP/public/LATEX_12_OFFLINE.html"
cp "$APPS/PYTHON_12.html" "$TMP/public/PYTHON_12.html"
cp "$APPS/PYTHON_12_OFFLINE.html" "$TMP/public/PYTHON_12_OFFLINE.html"
cp "$APPS/MATERIAL_SCIENCE_12.html" "$TMP/public/MATERIAL_SCIENCE_12.html"
cp "$APPS/MATERIAL_SCIENCE_12_OFFLINE.html" "$TMP/public/MATERIAL_SCIENCE_12_OFFLINE.html"
cp "$APPS/QM_1.html" "$TMP/public/index.html"
cat > "$TMP/firebase.json" <<'JSON'
{ "hosting": { "site": "ssc-data-science-qm", "public": "public",
  "ignore": ["firebase.json", "**/.*"],
  "headers": [{ "source": "**/*.html", "headers": [{ "key": "Cache-Control", "value": "no-cache" }] }] } }
JSON
echo '{ "projects": { "default": "data-science-ef878" } }' > "$TMP/.firebaserc"
cd "$TMP"
firebase deploy --only hosting:ssc-data-science-qm --project data-science-ef878
echo "→ https://ssc-data-science-qm.web.app/QM_1.html"
echo "→ https://ssc-data-science-qm.web.app/SOLID_STATE_1.html"
echo "→ https://ssc-data-science-qm.web.app/LATEX_1.html"
echo "→ https://ssc-data-science-qm.web.app/LATEX_12_OFFLINE.html"
echo "→ https://ssc-data-science-qm.web.app/PYTHON_12.html"
echo "→ https://ssc-data-science-qm.web.app/PYTHON_12_OFFLINE.html"
echo "→ https://ssc-data-science-qm.web.app/MATERIAL_SCIENCE_12.html"
echo "→ https://ssc-data-science-qm.web.app/MATERIAL_SCIENCE_12_OFFLINE.html"
