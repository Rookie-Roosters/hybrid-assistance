import 'package:collapsible/collapsible.dart';
import 'package:derived_colors/derived_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';

class WorthyTextField extends StatefulWidget {
  const WorthyTextField({
    Key? key,
    this.controller,
    required this.label,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.validator,
    this.textArea = false,
    this.inputFormatters,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.style,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final bool textArea;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final WorthyTextFieldStyle? style;
  final void Function()? onTap;

  @override
  _WorthyTextFieldState createState() => _WorthyTextFieldState();
}

class _WorthyTextFieldState extends State<WorthyTextField> {
  late final WorthyTextFieldStyle _style;
  final _focus = FocusNode();
  bool _focused = false;
  String? _errorMessage;

  void _onChanged() => setState(() {});
  void _onFocusChange() => setState(() => _focused = _focus.hasFocus);
  String? _onValidate(String? value) {
    if (widget.validator != null) {
      final res = widget.validator!(value);
      setState(() => _errorMessage = res);
      return res;
    }
  }

  @override
  void initState() {
    _style = widget.style ?? WorthyTextFieldStyle.regular;
    _focus.addListener(() => _onFocusChange);
    _focus.addListener(_onChanged);
    super.initState();
  }

  Color get textColor => _errorMessage != null
      ? kErrorColor
      : _focused
          ? _style.focusColor
          : _style.color;

  Color get backgroundColor => _errorMessage != null
      ? kErrorColor.variants.light
      : _focused
          ? _style.focusBackgroundColor
          : _style.backgroundColor;

  Widget? iconTheme(Widget? widget) {
    return widget != null ? IconTheme(data: IconThemeData(color: textColor, size: 24), child: widget) : null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: _onValidate,
      builder: (FormFieldState<String> state) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: _style.groupedTop ? Radius.zero : const Radius.circular(kBorderRadius),
              bottom: _style.groupedBottom ? Radius.zero : const Radius.circular(kBorderRadius),
            ),
          ),
          child: Column(children: [
            TextField(
              focusNode: _focus,
              controller: widget.controller,
              keyboardType: widget.textArea ? TextInputType.multiline : widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              obscureText: widget.obscureText,
              expands: widget.textArea,
              enabled: widget.enabled,
              onChanged: (value) => state.didChange(value),
              style: Get.textTheme.body.copyWith(color: textColor.withOpacity(0.5)),
              maxLines: widget.textArea ? null : 1,
              decoration: InputDecoration(
                labelText: widget.label,
                prefixIcon: iconTheme(widget.prefix),
                suffixIcon: iconTheme(widget.suffix),
                fillColor: Colors.transparent,
                contentPadding: kPadding2,
                labelStyle: Get.textTheme.bodyLarge.copyWith(color: textColor, fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
            ),
            Collapsible(
              collapsed: !state.hasError,
              axis: CollapsibleAxis.vertical,
              alignment: Alignment.topCenter,
              maintainState: true,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(LineIcons.exclamationCircle, color: kErrorColor, size: 18).pr1,
                Text(_errorMessage ?? 'Error', style: Get.textTheme.bodySmall.copyWith(fontStyle: FontStyle.italic, color: kErrorColor), overflow: TextOverflow.fade),
              ]).pb1,
            ),
            if (_style.groupedBottom) Divider(color: textColor.withOpacity(0.1), height: 0),
          ]),
        );
      },
    );
  }
}

class WorthyTextFieldStyle {
  final Color color;
  final Color backgroundColor;
  final Color focusColor;
  final Color focusBackgroundColor;
  final bool groupedTop;
  final bool groupedBottom;

  WorthyTextFieldStyle({
    Color? backgroundColor,
    Color? focusColor,
    Color? focusBackgroundColor,
    required this.color,
    this.groupedTop = false,
    this.groupedBottom = false,
  })  : backgroundColor = backgroundColor ?? color.variants.light,
        focusColor = focusColor ?? color.variants.dark,
        focusBackgroundColor = focusBackgroundColor ?? focusColor?.variants.light ?? color.variants.dark.variants.light;

  static WorthyTextFieldStyle get regular => WorthyTextFieldStyle(
        color: kDarkColor,
        backgroundColor: kBackgroundColor,
        focusColor: kPrimaryColor,
      );

  static WorthyTextFieldStyle get primary => WorthyTextFieldStyle(color: kPrimaryColor);
  static WorthyTextFieldStyle get secondary => WorthyTextFieldStyle(color: kSecondaryColor);

  WorthyTextFieldStyle copyWith({
    Color? color,
    Color? backgroundColor,
    Color? focusColor,
    Color? focusBackgroundColor,
    bool? groupedTop,
    bool? groupedBottom,
  }) {
    return WorthyTextFieldStyle(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      focusColor: focusColor ?? this.focusColor,
      focusBackgroundColor: focusBackgroundColor ?? this.focusBackgroundColor,
      groupedTop: groupedTop ?? this.groupedTop,
      groupedBottom: groupedBottom ?? this.groupedBottom,
    );
  }
}
