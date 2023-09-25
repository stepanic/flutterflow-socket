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

if git rev-parse --git-dir > /dev/null 2>&1
then
  echo 'This directory is `git` repo ✅'
else
  echo 'This directory is NOT `git` repo ❌'
  exit 1
fi

curl -L -k https://github.com/stepanic/flutterflow-socket/archive/refs/heads/main.zip | tar -xz --strip-components=1 flutterflow-socket-main/run flutterflow-socket-main/watch flutterflow-socket-main/tools

chmod +x ./run ./watch ./tools/sync ./tools/hotreloader.sh ./tools/github/listen
cd ./tools/github && npm install && cd ../..

NEW_GITHUB_WEBHOOK_URL=$(curl -Ls -o /dev/null -w %{url_effective} https://smee.io/new)

SEARCH='https://smee.io/<CHANNEL_ID>'
ESCAPED_SEARCH=$(printf '%s\n' "$SEARCH" | sed -e 's/[]\/$*.^[]/\\&/g');
REPLACE="$NEW_GITHUB_WEBHOOK_URL"
ESCAPED_REPLACE=$(printf '%s\n' "$REPLACE" | sed -e 's/[]\/$*.^[]/\\&/g');
WATCH_FILENAME='./watch'
sed -i '' "s/$ESCAPED_SEARCH/$ESCAPED_REPLACE/" $WATCH_FILENAME

git add ./run ./watch ./tools
git commit -m "Installed flutterflow-socket"

echo ""
echo "GITHUB_WEBHOOK_URL=$NEW_GITHUB_WEBHOOK_URL"
