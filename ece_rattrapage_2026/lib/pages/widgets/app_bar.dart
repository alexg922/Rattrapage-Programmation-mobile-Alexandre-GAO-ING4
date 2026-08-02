import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rattrapage/res/app_assets.dart';
import 'package:rattrapage/res/app_colors.dart';

/// AppBar = screenshot [TopBar.png] entier (heure, wifi, batterie + MORSE).
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = false,
    this.actions,
  });

  final String? title;
  final bool showBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(
        AppAssets.topBarHeightFor(AppAssets.phoneMaxWidth),
      );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width.clamp(
          0.0,
          AppAssets.phoneMaxWidth,
        );
    final height = AppAssets.topBarHeightFor(width);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              AppAssets.topBar,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              alignment: Alignment.topCenter,
              filterQuality: FilterQuality.high,
              excludeFromSemantics: true,
            ),
            // Zone interactive (retour / actions) sur la bande titre, sous le status
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: kToolbarHeight,
              child: Row(
                children: <Widget>[
                  if (showBack)
                    Semantics(
                      label: 'Retour',
                      button: true,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        color: AppColors.primary,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  else
                    const SizedBox(width: 8.0),
                  const Spacer(),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
