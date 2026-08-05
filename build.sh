#!/bin/bash
set -e
cd /home/user/farm-game
cat src/00-head.html src/10-core.js src/20-data.js src/30-art.js \
    src/40-engine.js src/50-render.js src/60-ui.js > index.html
node -e '
const fs=require("fs");
const h=fs.readFileSync("index.html","utf8");
const i=h.lastIndexOf("<script>");
const j=h.lastIndexOf("</script>");
fs.writeFileSync("/tmp/fchk.js",h.slice(i+8,j));
'
node --check /tmp/fchk.js
echo "СБОРКА OK  $(du -h index.html | cut -f1)"
