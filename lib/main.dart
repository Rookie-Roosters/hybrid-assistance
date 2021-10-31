import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'config/app_pages.dart';
import 'config/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const HybridAssistance());
}

class HybridAssistance extends StatelessWidget {
  const HybridAssistance({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.main,
        getPages: AppPages.routes,
        initialRoute: Routes.HOME,
      ),
    );
  }
}
