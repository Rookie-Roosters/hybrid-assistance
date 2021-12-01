import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class WorthyText extends StatelessWidget {
  WorthyText(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = TextStyle(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null).merge(style),
        super(key: key);

  WorthyText.heading1(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.heading1.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  WorthyText.heading2(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.heading2.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  WorthyText.heading3(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.heading3.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  WorthyText.bodyLarge(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.bodyLarge.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  WorthyText.body(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.body.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  WorthyText.bodySmall(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.bodySmall.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  WorthyText.action(
    this.text, {
    Key? key,
    TextStyle? style,
    this.overflow = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    bool? isLink,
    this.onPressed,
    Color? color,
  })  : isLink = isLink ?? onPressed != null,
        style = Get.textTheme.action.merge(style).copyWith(color: color, decorationColor: color, decoration: (isLink ?? onPressed != null) ? TextDecoration.underline : null),
        super(key: key);

  final String text;
  final TextStyle? style;
  final bool overflow;
  final TextAlign textAlign;
  final int? maxLines;
  final bool isLink;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: onPressed != null,
      conditionalBuilder: (child) => child.mouse(onPressed),
      child: Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow ? TextOverflow.ellipsis : null,
        textAlign: textAlign,
      ),
    );
  }
}
