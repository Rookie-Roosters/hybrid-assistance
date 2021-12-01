// ignore_for_file: constant_identifier_names
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';

enum WorthyButtonType { ELEVATED, FLAT, OUTLINED }
enum WorthyButtonStatus { IDLE, LOADING, SUCCESS, ERROR, WARNING, INFO }

const _kWorthyButtonAnimationDuration = Duration(milliseconds: 200);
const _kWorthyButtonIconSize = 22.0;

class WorthyButton extends StatefulWidget {
  final Widget child;
  final Widget? prefix;
  final Widget? suffix;
  final String? tooltip;
  final Color color;
  final bool isCircle;
  final WorthyButtonType type;
  final void Function()? onPressed;

  const WorthyButton({Key? key, required this.child, required this.type, this.color = kPrimaryColor, this.prefix, this.suffix, this.tooltip, this.onPressed})
      : isCircle = false,
        super(key: key);
  const WorthyButton.circle({Key? key, required this.child, required this.type, this.color = kPrimaryColor, this.tooltip, this.onPressed})
      : isCircle = true,
        prefix = null,
        suffix = null,
        super(key: key);

  const WorthyButton.elevated({Key? key, required this.child, this.color = kPrimaryColor, this.prefix, this.suffix, this.tooltip, this.onPressed})
      : type = WorthyButtonType.ELEVATED,
        isCircle = false,
        super(key: key);
  const WorthyButton.elevatedCircle({Key? key, required this.child, this.color = kPrimaryColor, this.tooltip, this.onPressed})
      : type = WorthyButtonType.ELEVATED,
        isCircle = true,
        prefix = null,
        suffix = null,
        super(key: key);

  const WorthyButton.flat({Key? key, required this.child, this.color = kPrimaryColor, this.prefix, this.suffix, this.tooltip, this.onPressed})
      : type = WorthyButtonType.FLAT,
        isCircle = false,
        super(key: key);
  const WorthyButton.flatCircle({Key? key, required this.child, this.color = kPrimaryColor, this.tooltip, this.onPressed})
      : type = WorthyButtonType.FLAT,
        isCircle = true,
        prefix = null,
        suffix = null,
        super(key: key);

  const WorthyButton.outline({Key? key, required this.child, this.color = kPrimaryColor, this.prefix, this.suffix, this.tooltip, this.onPressed})
      : type = WorthyButtonType.OUTLINED,
        isCircle = false,
        super(key: key);
  const WorthyButton.outlineCircle({Key? key, required this.child, this.color = kPrimaryColor, this.tooltip, this.onPressed})
      : type = WorthyButtonType.OUTLINED,
        isCircle = true,
        prefix = null,
        suffix = null,
        super(key: key);

  @override
  WorthyButtonState createState() => WorthyButtonState();
}

class WorthyButtonState extends State<WorthyButton> {
  WorthyButtonStatus _status = WorthyButtonStatus.IDLE;
  bool get _enabled => widget.onPressed != null;
  bool get _isCircle => widget.isCircle;
  Color get _color => _status.color ?? widget.color;

  Color get _textColor {
    if (!_enabled) return kDarkColor;
    switch (widget.type) {
      case WorthyButtonType.ELEVATED:
        return _color.onColor;
      case WorthyButtonType.FLAT:
        return _color;
      case WorthyButtonType.OUTLINED:
        return _color;
    }
  }

  Color get _backgroundColor {
    if (!_enabled) return kDarkColor.variants.light;
    switch (widget.type) {
      case WorthyButtonType.ELEVATED:
        return _color;
      case WorthyButtonType.FLAT:
        return _color.variants.light;
      case WorthyButtonType.OUTLINED:
        return Colors.white;
    }
  }

  Color? get _outlineColor => widget.type == WorthyButtonType.OUTLINED ? (_enabled ? _color.variants.light : kDarkColor.variants.light) : null;
  bool get showStatus => _status.widget != null;

  void setStatus(WorthyButtonStatus status) {
    setState(() => _status = status);
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: widget.tooltip != null,
      conditionalBuilder: (child) => child.tooltip(widget.tooltip!),
      child: AnimatedContainer(
        duration: _kWorthyButtonAnimationDuration,
        alignment: _isCircle ? Alignment.center : null,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: _outlineColor ?? Colors.transparent),
          color: _backgroundColor,
          shape: _isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: _isCircle ? null : kRoundedBorder,
          //boxShadow: [if (_enabled && widget.type == WorthyButtonType.ELEVATED) BoxShadow(color: _color.withOpacity(0.8), offset: Offset(0.0, 2.0), blurRadius: 8.0)],
        ),
        child: DefaultTextStyle.merge(
          style: Get.textTheme.action.copyWith(color: _textColor),
          child: Theme(
            data: Get.theme.copyWith(
              colorScheme: ColorScheme.light(primary: _textColor),
              iconTheme: IconThemeData(color: _textColor, size: _kWorthyButtonIconSize),
            ),
            child: AnimatedSizeAndFade(
              fadeDuration: _kWorthyButtonAnimationDuration,
              sizeDuration: _kWorthyButtonAnimationDuration,
              child: _status.widget != null
                  ? Center(
                      key: ValueKey(_status.index),
                      child: _status.widget?.pxy(3, _isCircle ? 3 : 2),
                    )
                  : Row(
                      key: const ValueKey('content'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.prefix != null) ...[widget.prefix!, kSpacerX2],
                        widget.child,
                        if (widget.suffix != null) ...[kSpacerX2, widget.suffix!],
                      ],
                    ).pxy(3, _isCircle ? 3 : 2),
            ),
          ),
        ),
      ).mouse(widget.onPressed),
    );
  }
}

extension WorthyButtonStatusExtension on WorthyButtonStatus {
  Color? get color {
    switch (this) {
      case WorthyButtonStatus.SUCCESS:
        return kSuccessColor;
      case WorthyButtonStatus.ERROR:
        return kErrorColor;
      case WorthyButtonStatus.WARNING:
        return kWarningColor;
      case WorthyButtonStatus.INFO:
        return kInfoColor;
      default:
        return null;
    }
  }

  Widget? get widget {
    switch (this) {
      case WorthyButtonStatus.LOADING:
        return const SizedBox(
          width: _kWorthyButtonIconSize,
          height: _kWorthyButtonIconSize,
          child: CircularProgressIndicator(strokeWidth: 3),
        );
      case WorthyButtonStatus.SUCCESS:
        return const Icon(LineIcons.checkCircle);
      case WorthyButtonStatus.ERROR:
        return const Icon(LineIcons.timesCircle);
      case WorthyButtonStatus.WARNING:
        return const Icon(LineIcons.exclamationCircle);
      case WorthyButtonStatus.INFO:
        return const Icon(LineIcons.infoCircle);
      default:
        return null;
    }
  }
}
