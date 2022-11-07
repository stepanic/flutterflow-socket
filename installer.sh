#!/bin/sh

curl -L -k https://github.com/stepanic/flutterflow-socket/archive/refs/heads/main.zip | tar -xz --strip-components=1 flutterflow-socket-main/run flutterflow-socket-main/watch flutterflow-socket-main/tools

chmod +x ./run ./watch ./tools/sync ./tools/hotreloader.sh ./tools/github/listen

git add ./run ./watch ./tools && npm install --prefix tools/github/
git commit -m "Installed flutterflow-socket"
git push