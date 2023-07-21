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
        return 'Business Cardify';
      case Flavor.qa:
        return 'Business Cardify';
      case Flavor.staging:
        return 'Business Cardify';
      default:
        return 'title';
    }
  }

}
