/// Chemins et dimensions des assets images (maquettes TopBar / BottomBar).
class AppAssets {
  const AppAssets._();

  static const String topBar = 'assets/images/TopBar.png';
  static const String bottomBar = 'assets/images/BottomBar.png';

  /// Dimensions natives des PNG.
  static const double topBarPixelWidth = 949.0;
  static const double topBarPixelHeight = 264.0;
  static const double bottomBarPixelWidth = 936.0;
  static const double bottomBarPixelHeight = 163.0;

  /// Largeur max type téléphone (maquette ~428–430).
  static const double phoneMaxWidth = 430.0;

  static double topBarHeightFor(double width) =>
      width * topBarPixelHeight / topBarPixelWidth;

  static double bottomBarHeightFor(double width) =>
      width * bottomBarPixelHeight / bottomBarPixelWidth;
}
