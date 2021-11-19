import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/general/logo_rookie_roosters.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'login_controller.dart';
export 'login_controller.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
        kSpacer,
        kSpacer,
        BootstrapContainer(children: [
          Card(
            child: Form(
              key: controller.formKey,
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text('Ingresar', style: Get.textTheme.headline4),
                kSpacerY,
                TextFormField(
                  controller: controller.userIdField,
                ),
                kSpacerY,
                TextFormField(
                  controller: controller.passwordField,
                ),
                kDivider.py,
                Obx(() => ElevatedButton(
                      child: controller.loading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(kSurfaceColor),
                            ).box(20, 20)
                          : const Text('Ingresar'),
                      onPressed: () => controller.logIn(),
                    ))
              ]).p3,
            ),
          ),
        ]),
        kSpacer,
        const LogoRookieRoosters(),
        kSpacer,
      ]).safeArea(),
    );
  }
}
