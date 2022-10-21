# flutterflow-socket
Automatic Hot Reload of Flutter app after Push to repository at FlutterFlow without any manual source pull and app reload.

## 1. Installation

1. position to your FlutterFlow project in terminal `cd /path/to/your/ff/project`
2. copy directory `./tools` and scripts `./run` and `./watch` from this repository to your existing FlutterFlow app with this command

`curl -L -k https://github.com/stepanic/flutterflow-socket/archive/refs/heads/main.zip | tar -xz --strip-components=1 flutterflow-socket-main/run flutterflow-socket-main/watch flutterflow-socket-main/tools; chmod +x ./run ./watch ./tools/sync ./tools/hotreloader.sh ./tools/github/listen; git add ./run ./watch ./tools && git commit -m "Installed flutterflow-socket" && git push`

![Installation](https://raw.githubusercontent.com/stepanic/flutterflow-socket/692874364f8fa85fa2c198d6d31a2b7ef48d533e/screenshots/001-installation.png)

3. follow the `Setup` instructions

## 2. Setup

1. install dependencies `npm install -- prefix ./tools/github`
![npm install](https://raw.githubusercontent.com/stepanic/flutterflow-socket/main/screenshots/002-setup-npm-install.png)
2. install `entr` (for MacOS `brew install entr`)
![brew install entr](https://raw.githubusercontent.com/stepanic/flutterflow-socket/main/screenshots/003-setup-brew-install-entr.png)
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

If you want to try how it works before installation at your project then clone this repository https://github.com/stepanic/flutterflow-socket-example and in one terminal execute `./run <DEVICE_ID>` and `./watch` in another.

## How it works

1. Flutter app should be run with `--pid-file` 
- look at https://github.com/stepanic/flutterflow-socket/blob/main/run#L13

2. `./watch` script internally is calling `./tools/hotreloader.sh` which is sending a signal to Flutter process(es)
- look at https://github.com/stepanic/flutterflow-socket/blob/main/watch#L25-L30
- and https://github.com/stepanic/flutterflow-socket/blob/main/tools/hotreloader.sh
- inspired by https://medium.com/@kikap/how-to-automatically-hot-reload-flutter-when-dart-source-files-change-6e8fdb523004

3. `./watch` script internally starts background Node.js process `./tools/github/listen` which is listening for new GitHub commits from Webhook via smee.io channel
- look at https://github.com/stepanic/flutterflow-socket/blob/main/tools/github/listen#L28-L35

4. `./tools/github/listen` Node.js script internally is calling `./tools/sync` for automatic pulling the newest commits from `flutterflow` branch and merge them to the currently active branch
- look at https://github.com/stepanic/flutterflow-socket/blob/main/tools/github/listen#L44-L57

## Advanced

When adding widgets in FlutterFlow which is changing dependencies in the `pubspac.yaml` or there are modification at Firestore schema or app icon is changed then add `DEEP` to the commit message before pushing to the repository. For more details please check this https://github.com/stepanic/flutterflow-socket/blob/main/tools/sync#L14-L20

- look at https://github.com/stepanic/flutterflow-socket/blob/main/tools/github/listen#L44-L57


