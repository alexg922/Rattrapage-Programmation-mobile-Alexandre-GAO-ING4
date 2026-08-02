import 'package:flutter/material.dart';
import 'package:rattrapage/res/app_assets.dart';
import 'package:rattrapage/res/app_colors.dart';

/// Cadre téléphone : largeur max maquette + MediaQuery adapté
/// pour que TopBar/BottomBar gardent leurs proportions.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return ColoredBox(
      color: AppColors.black,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppAssets.phoneMaxWidth),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return MediaQuery(
                data: media.copyWith(
                  size: Size(width, media.size.height),
                  // Le status bar est dessiné dans TopBar.png
                  padding: media.padding.copyWith(top: 0, bottom: 0),
                  viewPadding: media.viewPadding.copyWith(top: 0, bottom: 0),
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
