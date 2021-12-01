import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class WorthyContainer extends StatelessWidget {
  const WorthyContainer({
    Key? key,
    this.title,
    this.leading,
    this.trailing,
    this.header,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color = kDarkColor,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? header;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      width: width,
      height: height,
      decoration: BoxDecoration(color: color, borderRadius: kRoundedBorder),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (header != null || title != null || leading == null || trailing != null)
          DefaultTextStyle(
            style: Get.textTheme.heading3.copyWith(color: color.onColor, inherit: true),
            child: IconTheme(
              data: IconThemeData(color: color.onColor, size: 32),
              child: header != null
                  ? header!
                  : Container(
                      decoration: BoxDecoration(color: color, borderRadius: kRoundedBorder),
                      padding: kPadding2,
                      child: Row(children: [
                        if (leading != null) leading!.pr2,
                        (title != null ? WorthyText.heading3(title!, color: color.onColor).pr2 : const SizedBox()).expanded(),
                        if (trailing != null) trailing!,
                      ]),
                    ),
            ),
          ),
        Container(
          decoration: BoxDecoration(color: kSurfaceColor, borderRadius: kRoundedBorder, border: Border.all(color: color)),
          padding: padding ?? EdgeInsets.zero,
          child: child,
        )
      ]),
    );
  }
}
