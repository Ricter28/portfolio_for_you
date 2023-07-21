# flutter master template, use bloc

A new Flutter project.

## App description 

## Run build_runner generate DI, model, route

Run:

```bash
$ fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Generate localizations

Run:

```bash
$ fvm flutter pub run easy_localization:generate -S assets/locales -f keys -O lib/generated -o locale_keys.g.dart
```

## Generate app flavor

View [document](https://pub.dev/packages/flutter_flavorizr) for details

Run:
```bash
$ fvm flutter pub run flutter_flavorizr
```

## Generate Assets dart code from assets folder

### With Flutter Gen

Install Flutter Gen

```bash
$ dart pub global activate flutter_gen
```

Or add it as a part of build_runner

```bash
dev_dependencies:
  build_runner:
  flutter_gen_runner:
```

Run Flutter Gen
With command line

```bash
$ fluttergen -c pubspec.yaml
```

With build_runner

```bash
$ fvm flutter pub run build_runner build
$ fvm flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Generate template code with mason_cli

View [document](https://github.com/felangel/mason/tree/master/packages/mason_cli#readme) for details

### Install mason_cli

Active from https://pub.dev

```bash
$ dart pub global activate mason_cli
```

Or install from https://brew.sh

```bash
$ brew tap felangel/mason
$ brew install mason
```

### Initializing

Get all bricks registered in mason.yaml run:
```bash
$ mason get
```
Then you can use 'mason make' to generate bricks.
You can generate bloc template with:
```bash
$ mason make bloc_template -c ./.mason/config.json -o ./lib/modules/presentation
```

## Build Android/iOS release

```bash
$ fvm flutter build apk --release --flavor <env_name> -t lib/main_<env_name>.dart

$ fvm flutter build ipa --release --flavor <env_name> -t lib/main_<env_name>.dart
```

Example: Build QA

```bash
$ fvm flutter build apk --release --flavor qa -t lib/main_qa.dart

$ fvm flutter build ipa --release --flavor qa -t lib/main_qa.dart
```

## Rename app
Run this command inside your flutter project root.
```bash
$ flutter pub global run rename --bundleId com.tonydung.businesscardify
$ flutter pub global run rename --appname "Business Cardify"
```

Description:
Your business card will always be ready to share in any situation, helping to create more business opportunities and professional exchanges. Impress potential partners and customers with Business Cardify - the application that enhances your business expertise and efficiency.
1 Choose from a wide range of available card templates
2 Add your contact information, company logo, and social media for a professional and impressive look.
3 Friendly interface and easy to use

https://www.termsfeed.com/live/35457147-97b4-4f25-ae0c-82dc2cf9148e
https://sites.google.com/view/business-cardify/trang-ch%E1%BB%A7
