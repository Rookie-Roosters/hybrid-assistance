import 'package:flutter/material.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class LogoRookieRoosters extends StatelessWidget {
  final double size;
  final bool onlyIso;
  const LogoRookieRoosters({Key? key, this.size = 50.0, this.onlyIso = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/rookie_roosters_logo.png', width: size, filterQuality: FilterQuality.medium).right([
      if (!onlyIso)
        const Text(
          'Rookie\nRoosters',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ).p3
    ]);
  }
}
