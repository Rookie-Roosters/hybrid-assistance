import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/general/logo_rookie_roosters.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/components/worthy/worthy_container.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text_field.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/format_utils.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'login_controller.dart';
export 'login_controller.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DirectSelectContainer(
      dragSpeedMultiplier: 1,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          alignment: Alignment.center,
          padding: kPadding3,
          child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
            statusBarSpacer,
            Image.asset('assets/uaa_logo.png', width: Get.width / 2).py2,
            WorthyText.heading1(
              'SISTEMA DE ASISTENCIA HÍBRIDA',
              textAlign: TextAlign.center,
              color: kDarkColor,
            ),
            WorthyText.bodyLarge('v1.0.0', color: kPrimaryColor.withOpacity(0.5)),
            kSpacer,
            WorthyContainer(
              color: kPrimaryColor,
              margin: kPadding2,
              header: DirectSelectList<UserTypes>(
                values: UserTypes.values,
                focusedItemDecoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 1, color: Colors.black12))),
                onItemSelectedListener: (value, index, context) => controller.selectedUserType = value,
                itemBuilder: (value) => DirectSelectItem(
                  value: value,
                  itemBuilder: (context, value) => Row(children: [Icon(value.icon).pr2, Text(value.name)]),
                ),
              ).expanded().right([const Icon(LineIcons.alternateArrowsVertical, color: Colors.white30, size: 25)]).pxy(2, 1),
              child: Form(
                key: controller.formKey,
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  WorthyTextField(
                    label: 'Id. Personal',
                    prefix: const Icon(LineIcons.identificationCard),
                    validator: Validator.requiredField,
                    style: WorthyTextFieldStyle.regular.copyWith(groupedBottom: true),
                    keyboardType: TextInputType.number,
                  ),
                  ValueBuilder<bool?>(
                    initialValue: true,
                    builder: (value, update) => WorthyTextField(
                      label: 'Contraseña',
                      prefix: const Icon(LineIcons.lock),
                      controller: controller.passwordField,
                      validator: Validator.requiredField,
                      style: WorthyTextFieldStyle.regular.copyWith(groupedTop: true),
                      obscureText: value!,
                      suffix: IconButton(
                        icon: Icon(value ? LineIcons.eyeSlash : LineIcons.eye),
                        onPressed: () => update(!value),
                      ),
                    ),
                  ),
                  kDivider.py2,
                  WorthyButton.elevated(
                    key: controller.logInButtonKey,
                    child: const Text('INGRESAR'),
                    prefix: const Icon(LineIcons.alternateSignIn),
                    color: kSecondaryColor,
                    onPressed: () => controller.logIn(),
                  ),
                ]),
              ).p3,
            ),
            kSpacer,
            const LogoRookieRoosters(),
            kSpacer,
          ]),
        ).scrollable(),
      ),
    ).overlayStyle(statusBar: kBackgroundColor, navigationBar: kBackgroundColor);
  }
}
