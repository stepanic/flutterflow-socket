# flutterflow-socket
Automatic Hot Reload of Flutter app after Push to repository at FlutterFlow without any manual source pull and app reload.

## 1. Installation

1. position to your FlutterFlow project in terminal `cd /path/to/your/ff/project`
2. copy directory `./tools` and scripts `./run` and `./watch` from this repository to your existing FlutterFlow app with this command

```curl -L -k https://github.com/stepanic/flutterflow-socket/archive/refs/heads/main.zip | tar -xz --strip-components=1 flutterflow-socket-main/run flutterflow-socket-main/watch flutterflow-socket-main/tools```

3. follow the `Setup` instructions

## 2. Setup

1. install dependencies `npm install -- prefix ./tools/github`
2. install `entr` (for MacOS `brew install entr`)
3. create new channel at `smee.io` by visiting https://smee.io/new
4. copy `Webhook Proxy URL` from previous step and paste it to the `GITHUB_WEBHOOK_URL` variable in `./watch` script
5. OPTIONAL: change `GITHUB_WEBHOOK_SECRET` at `./watch`
6. add a new Webhook at GitHub `https://github.com/<ORG_ID|USERNAME>/<REPO_ID>/settings/hooks/new`
  - `Payload URL` = `Webhook Proxy URL` from 3rd step
  - `Content type` = `application/json`
  - `Secret` = `GITHUB_WEBHOOK_SECRET` from `./watch`

## 3. Usage

1. get a `<DEVICE_ID>` with `flutter devices`
2. run the Flutter app on the device with `./run <DEVICE_ID>`
3. open another terminal window/tab and watch for local and remote changes with `./watch`
4. make some changes in the FlutterFlow project and click to `Push to Repository`
5. repeat 4th step multiple times :))

## Example



