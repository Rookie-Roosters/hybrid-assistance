import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'config/app_pages.dart';
import 'config/app_themes.dart';
import 'services/database_service.dart';
import 'services/session_sevice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initServices();
  setPathUrlStrategy();
  runApp(const HybridAssistance());
}

Future<void> initServices() async {
  await GetStorage.init();
  await Get.putAsync(() => DatabaseService().init());
  await Get.putAsync(() => SessionService().init());
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
        initialRoute: SessionService.to.loggedIn ? Routes.HOME : Routes.LOGIN,
      ),
    );
  }
}
