# flutter_boilerplate_pro

This flutter_boilerplate_pro will saved you ~30 minutes of doing configuration and writing boring code.

Just use it and have fun conding.

<img src="./docs/icon.png"/>

## Features:
- Easy app icon creation
    - The icon file is configured in `pubspec.yaml`
    - Command for update icon: `flutter pub run flutter_launcher_icons:main`
    - Reference: [https://pub.dev/packages/flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
    - Free icon resource: [https://iconarchive.com/](https://iconarchive.com/)
- Simple splash screen
    - Splash screen is configured in `pubspec.yaml`
    - Command for update splash screen: `flutter pub run flutter_native_splash:create`
- Use `GetX` for State Management and Routing
    - Pre-created `AppController`
- Use `styled_widget` is used for widget code style
- Use `another_flushbar` for beautiful `toast` message
- Use `logger` package for logging
    - Add `custom_printer` class for customized emojis and log message
- Easy changing app name, app bundle
    - by using package `flutter_rename_app`
    - App's name and bundle information are configured in `pubspec.yaml`
    - Ref: [https://pub.dev/packages/flutter_rename_app](https://pub.dev/packages/flutter_rename_app)
    - Command for update app name and bundle: `flutter pub run flutter_rename_app`
- App is preconfigured to run with portrait mode only
    ```dart
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    ).then(
      (value) => runApp(MyApp()),
    );
    ```
- Debugger banner is turned off
    ```dart
    debugShowCheckedModeBanner: false
    ```

## Sample screenshots

<img src="./docs/screenshot2.png" width="350"/>

<img src="./docs/log-message.png"/>

## Copyright
Copyright (c) 2021 Hoang Nam Hai (hai@mana.vn). See [LICENSE](LICENSE.txt)  for further details.
