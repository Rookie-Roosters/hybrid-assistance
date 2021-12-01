import 'package:flutter/material.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

const _kDefaultLogoSize = 40.0;

class LogoRookieRoosters extends StatelessWidget {
  final double size;
  final bool onlyIso;
  const LogoRookieRoosters({Key? key, this.size = _kDefaultLogoSize, this.onlyIso = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/rookie_roosters_logo.png', width: size, filterQuality: FilterQuality.medium).right([
      if (!onlyIso)
        Text(
          'Rookie\nRoosters',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: (size / _kDefaultLogoSize) * 25,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ).pLTRB(2, 1, 0, 0),
    ]);
  }
}
