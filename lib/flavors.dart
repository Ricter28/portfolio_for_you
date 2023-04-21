enum Flavor {
  dev,
  qa,
  staging,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '[DEV] Card';
      case Flavor.qa:
        return '[QA] Card ';
      case Flavor.staging:
        return 'Card';
      default:
        return 'title';
    }
  }

}
