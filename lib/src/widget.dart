import 'package:flutter/material.dart';
import './style.dart';
import './checkmark.dart';

class FlexiChip extends ImplicitlyAnimatedWidget {
  const FlexiChip({
    Key? key,
    required this.label,
    this.leading,
    this.trailing,
    this.style,
    this.activeStyle,
    this.selected = false,
    this.disabled = false,
    this.onPressed,
    this.onDeleted,
    this.onSelected,
    Curve curve = Curves.linear,
    Duration duration = const Duration(milliseconds: 200),
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );

  final Widget label;

  final Widget? leading;

  final Widget? trailing;

  final bool selected;

  final bool disabled;

  final VoidCallback? onPressed;

  final VoidCallback? onDeleted;

  final ValueChanged<bool>? onSelected;

  final FlexiChipStyle? style;

  final FlexiChipStyle? activeStyle;

  bool get enabled => !disabled;

  bool get canTap {
    return enabled && (onPressed != null || onSelected != null);
  }

  @override
  FlexiChipState createState() => FlexiChipState();
}

class FlexiChipState extends AnimatedWidgetBaseState<FlexiChip> {
  FlexiChipStyle get style => const FlexiChipStyle().merge(widget.style);
  FlexiChipStyle get activeStyle => style.merge(widget.activeStyle);
  FlexiChipStyle get effectiveStyle => widget.selected ? activeStyle : style;

  BorderRadiusGeometry get containerRadius => effectiveStyle.borderRadius;
  BoxDecoration get containerDecoration => BoxDecoration(
        color: effectiveStyle.backgroundColor
            ?.withOpacity(effectiveStyle.backgroundOpacity),
        border: Border.all(
          color: effectiveStyle.borderColor,
          width: effectiveStyle.borderWidth,
          style: effectiveStyle.borderStyle,
        ),
        borderRadius: effectiveStyle.borderRadius,
      );
  TextStyle get foregroundStyle => const TextStyle()
      .copyWith(color: effectiveStyle.foregroundColor)
      .merge(effectiveStyle.labelStyle);

  BorderRadiusTween? _containerRadiusTween;
  DecorationTween? _containerDecorationTween;
  ColorTween? _foregroundColorTween;
  TextStyleTween? _foregroundStyleTween;
  Tween<double>? _checkmarkTween;

  BorderRadiusGeometry? get animatedContainerRadius =>
      _containerRadiusTween?.evaluate(animation);
  Decoration? get animatedContainerDecoration =>
      _containerDecorationTween?.evaluate(animation);
  Color? get animatedForegroundColor =>
      _foregroundColorTween?.evaluate(animation);
  TextStyle? get animatedForegroundStyle =>
      _foregroundStyleTween?.evaluate(animation);
  double get animatedCheckmark => _checkmarkTween?.evaluate(animation) ?? 0;

  bool get hasCheckmark => effectiveStyle.useCheckmark && animatedCheckmark > 0;
  bool get hasLeading => widget.leading != null;
  bool get hasTrailing => widget.trailing != null;

  Widget? get leading {
    return hasCheckmark
        ? FlexiCheckmark(
            progress: animatedCheckmark,
            color: animatedForegroundColor,
            size: FlexiChipStyle.defaultIconSize,
          )
        : null;
  }

  Widget? get trailing {
    return widget.trailing;
  }

  @override
  void forEachTween(visitor) {
    _containerRadiusTween = visitor(
      _containerRadiusTween,
      containerRadius,
      (value) => BorderRadiusTween(begin: value),
    ) as BorderRadiusTween?;

    _containerDecorationTween = visitor(
      _containerDecorationTween,
      containerDecoration,
      (value) => DecorationTween(begin: value),
    ) as DecorationTween?;

    _foregroundColorTween = visitor(
      _foregroundColorTween,
      effectiveStyle.foregroundColor,
      (value) => ColorTween(begin: value),
    ) as ColorTween?;

    _foregroundStyleTween = visitor(
      _foregroundStyleTween,
      foregroundStyle,
      (value) => TextStyleTween(begin: value),
    ) as TextStyleTween?;

    _checkmarkTween = visitor(
      _checkmarkTween,
      widget.selected ? 1.0 : 0.0,
      (value) => Tween<double>(begin: value),
    ) as Tween<double>?;
  }

  bool _isPressing = false;
  bool get isPressing => widget.canTap && _isPressing;

  void onTap() {
    setState(() => _isPressing = false);
    widget.onPressed?.call();
    widget.onSelected?.call(!widget.selected);
  }

  void onTapCancel() {
    setState(() => _isPressing = false);
  }

  void onTapDown(TapDownDetails details) {
    setState(() => _isPressing = true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation:
          isPressing ? effectiveStyle.pressElevation : effectiveStyle.elevation,
      borderRadius: animatedContainerRadius,
      shadowColor: effectiveStyle.shadowColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        canRequestFocus: widget.enabled,
        onTap: widget.canTap ? onTap : null,
        onTapCancel: widget.canTap ? onTapCancel : null,
        onTapDown: widget.canTap ? onTapDown : null,
        child: Container(
          height: FlexiChipStyle.defaultHeight,
          padding: effectiveStyle.padding.clamp(
            EdgeInsets.only(
              left: hasLeading ? 8 : 10,
              right: hasTrailing ? 8 : 10,
            ),
            EdgeInsetsGeometry.infinity,
          ),
          decoration: animatedContainerDecoration,
          child: DefaultTextStyle(
            style: const TextStyle().merge(animatedForegroundStyle),
            child: IconTheme(
              data: IconThemeData(
                color: animatedForegroundColor,
                size: FlexiChipStyle.defaultIconSize,
              ),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: effectiveStyle.foregroundSpacing,
                children: [
                  leading,
                  widget.label,
                  trailing,
                ].whereType<Widget>().toList(growable: false),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
