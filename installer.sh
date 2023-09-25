#!/bin/sh

if which node > /dev/null
then
    echo "node is installed ✅"
else
    echo "node is NOT installed ❌"
    echo "check: https://github.com/nvm-sh/nvm"
    exit 1
fi

if which npm > /dev/null
then
    echo "npm is installed ✅"
else
    echo "npm is NOT installed ❌"
    echo "check: https://github.com/nvm-sh/nvm"
    exit 1
fi

curl -L -k https://github.com/stepanic/flutterflow-socket/archive/refs/heads/main.zip | tar -xz --strip-components=1 flutterflow-socket-main/run flutterflow-socket-main/watch flutterflow-socket-main/tools

chmod +x ./run ./watch ./tools/sync ./tools/hotreloader.sh ./tools/github/listen

git add ./run ./watch ./tools && cd ./tools/github && npm install && cd ../..
git commit -m "Installed flutterflow-socket"
git push
