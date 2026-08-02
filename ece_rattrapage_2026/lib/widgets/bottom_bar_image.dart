import 'package:flutter/material.dart';
import 'package:rattrapage/res/app_assets.dart';
import 'package:rattrapage/res/app_colors.dart';

/// Bandeau bas : navigation optionnelle + screenshot [BottomBar.png]
/// (bordure noire type téléphone).
class BottomBarImage extends StatelessWidget {
  const BottomBarImage({
    super.key,
    this.child,
  });

  /// Contenu au-dessus du PNG (ex. BottomNavigationBar).
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width.clamp(
          0.0,
          AppAssets.phoneMaxWidth,
        );
    final barHeight = AppAssets.bottomBarHeightFor(width);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (child != null) ...[
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              color: AppColors.tertiary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.5),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
          ColoredBox(
            color: AppColors.black,
            child: child!,
          ),
        ],
        // Bordure bas téléphone — PNG redimensionné en largeur
        SizedBox(
          width: double.infinity,
          height: barHeight,
          child: Image.asset(
            AppAssets.bottomBar,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            filterQuality: FilterQuality.high,
            excludeFromSemantics: true,
          ),
        ),
      ],
    );
  }
}
