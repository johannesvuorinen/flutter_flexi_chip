import 'package:flutter/material.dart';
import './style.dart';
import './checkmark.dart';

class FlexiChip extends ImplicitlyAnimatedWidget {
  const FlexiChip({
    Key? key,
    required this.label,
    this.avatar,
    this.leading,
    this.trailing,
    this.tooltip,
    this.deleteIcon,
    this.deleteTooltip,
    this.style,
    this.selectedStyle,
    this.disabledStyle,
    this.hoveredStyle,
    this.focusedStyle,
    this.pressedStyle,
    this.selected = false,
    this.disabled = false,
    this.onPressed,
    this.onDeleted,
    this.onSelected,
    Curve curve = Curves.linear,
    Duration duration = FlexiChip.defaultDuration,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );

  final Widget label;

  final ImageProvider? avatar;

  final Widget? leading;

  final Widget? trailing;

  final String? tooltip;

  final Widget? deleteIcon;

  final String? deleteTooltip;

  final bool selected;

  final bool disabled;

  final VoidCallback? onPressed;

  final VoidCallback? onDeleted;

  final ValueChanged<bool>? onSelected;

  final FlexiChipStyle? style;

  final FlexiChipStyle? selectedStyle;

  final FlexiChipStyle? disabledStyle;

  final FlexiChipStyle? hoveredStyle;

  final FlexiChipStyle? focusedStyle;

  final FlexiChipStyle? pressedStyle;

  static const defaultDuration = Duration(milliseconds: 200);

  bool get enabled => !disabled;

  bool get canTap {
    return enabled && (onPressed != null || onSelected != null);
  }

  @override
  FlexiChipState createState() => FlexiChipState();
}

class FlexiChipState extends AnimatedWidgetBaseState<FlexiChip>
    with MaterialStateMixin<FlexiChip> {
  ThemeData? appTheme;
  ChipThemeData? chipTheme;

  FlexiChipStyle style = const FlexiChipStyle();

  FlexiChipStyle? resolveStyle(FlexiChipStyle? style) {
    return MaterialStateProperty.resolveAs<FlexiChipStyle?>(
      style,
      materialStates,
    );
  }

  void setStyle() {
    final result = const FlexiChipStyle()
        .merge(resolveStyle(widget.style))
        .merge(isSelected ? resolveStyle(widget.selectedStyle) : null)
        .merge(isDisabled ? resolveStyle(widget.disabledStyle) : null)
        .merge(isHovered ? resolveStyle(widget.hoveredStyle) : null)
        .merge(isFocused ? resolveStyle(widget.focusedStyle) : null)
        .merge(isPressed ? resolveStyle(widget.pressedStyle) : null);
    setState(() => style = result);
  }

  Color get defaultColor {
    return widget.selected
        ? (appTheme?.colorScheme.primary ?? FlexiChipStyle.defaultColor)
        : (chipTheme?.backgroundColor ??
            appTheme?.chipTheme.backgroundColor ??
            appTheme?.unselectedWidgetColor ??
            FlexiChipStyle.defaultColor);
  }

  Color get defaultForegroundColor {
    return widget.selected
        ? (appTheme?.colorScheme.primary ?? FlexiChipStyle.defaultColor)
        : (chipTheme?.labelStyle?.color ??
            appTheme?.chipTheme.labelStyle?.color ??
            FlexiChipStyle.defaultColor);
  }

  Color get backgroundColor {
    final color = style.backgroundColor ?? defaultColor;
    final withOpacity = color.withOpacity(style.backgroundOpacity);
    return widget.disabled
        ? withOpacity.withAlpha(FlexiChipStyle.disabledBackgroundAlpha)
        : withOpacity;
  }

  Color get borderColor {
    final color = style.borderColor ?? defaultColor;
    final withOpacity = color.withOpacity(style.borderOpacity);
    return widget.disabled
        ? withOpacity.withAlpha(FlexiChipStyle.disabledBorderAlpha)
        : withOpacity;
  }

  Color get foregroundColor {
    final color = style.foregroundColor ?? defaultForegroundColor;
    return widget.disabled
        ? color.withAlpha(FlexiChipStyle.disabledForegroundAlpha)
        : color;
  }

  EdgeInsetsGeometry get containerPadding {
    return style.padding.clamp(
      EdgeInsets.only(
        left: hasLeading ? 8 : 10,
        right: hasTrailing ? 8 : 10,
      ),
      EdgeInsetsGeometry.infinity,
    );
  }

  BorderRadiusGeometry get containerRadius {
    return style.borderRadius;
  }

  ShapeBorder get containerBorder {
    return RoundedRectangleBorder(
      borderRadius: style.borderRadius,
      side: BorderSide(
        color: borderColor,
        width: style.borderWidth,
        style: style.borderStyle,
      ),
    );
  }

  BoxDecoration get containerDecoration {
    return BoxDecoration(
      color: backgroundColor,
      border: Border.all(
        color: borderColor,
        width: style.borderWidth,
        style: style.borderStyle,
      ),
      borderRadius: style.borderRadius,
    );
  }

  TextStyle get foregroundStyle {
    return const TextStyle()
        .copyWith(color: foregroundColor)
        .merge(style.foregroundStyle);
  }

  ColorTween? _containerColorTween;
  Color get animatedContainerColor {
    return _containerColorTween?.evaluate(animation) ?? backgroundColor;
  }

  ColorTween? _containerShadowColorTween;
  Color get animatedContainerShadowColor {
    return _containerShadowColorTween?.evaluate(animation) ??
        style.shadowColor ??
        FlexiChipStyle.defaultShadowColor;
  }

  Tween<double>? _containerElevationTween;
  double get animatedContainerElevation {
    return _containerElevationTween?.evaluate(animation) ?? 0.0;
  }

  BorderRadiusTween? _containerRadiusTween;
  BorderRadiusGeometry? get animatedContainerRadius {
    return _containerRadiusTween?.evaluate(animation);
  }

  ShapeBorderTween? _containerBorderTween;
  ShapeBorder get animatedContainerBorder {
    return _containerBorderTween?.evaluate(animation) ?? containerBorder;
  }

  DecorationTween? _containerDecorationTween;
  Decoration get animatedContainerDecoration {
    return _containerDecorationTween?.evaluate(animation) ??
        containerDecoration;
  }

  ColorTween? _foregroundColorTween;
  Color? get animatedForegroundColor {
    return _foregroundColorTween?.evaluate(animation);
  }

  TextStyleTween? _foregroundStyleTween;
  TextStyle get animatedForegroundStyle {
    return const TextStyle().merge(_foregroundStyleTween?.evaluate(animation));
  }

  Tween<double>? _checkmarkTween;
  double get animatedCheckmark {
    return _checkmarkTween?.evaluate(animation) ?? 0;
  }

  bool get hasCheckmark => style.useCheckmark && animatedCheckmark > 0;
  bool get hasAvatar => widget.avatar != null || style.avatarColor != null;
  bool get hasLeading => widget.leading != null;
  bool get hasTrailing => widget.trailing != null;

  Widget? get leading {
    final withCheckmark = hasCheckmark
        ? FlexiCheckmark(
            progress: animatedCheckmark,
            color: animatedForegroundColor,
            size: FlexiChipStyle.defaultIconSize,
          )
        : null;

    final withAvatar = hasAvatar
        ? CircleAvatar(
            radius: style.avatarRadius,
            backgroundColor: style.avatarColor,
            backgroundImage: widget.avatar,
            child: withCheckmark,
          )
        : withCheckmark;

    return widget.leading ?? withAvatar;
  }

  Widget? get trailing {
    return widget.trailing ?? deleteButton;
  }

  Widget? get deleteButton {
    final onDeleted = widget.onDeleted;
    return onDeleted != null
        ? FlexiChipButton(
            onPressed: onDeleted,
            icon: widget.deleteIcon ?? const Icon(Icons.close),
            tooltip: widget.deleteTooltip,
            disabled: !widget.canTap,
          )
        : null;
  }

  void onTap() {
    setMaterialState(MaterialState.pressed, false);
    widget.onPressed?.call();
    widget.onSelected?.call(!widget.selected);
  }

  void onTapCancel() {
    setMaterialState(MaterialState.pressed, false);
  }

  void onTapDown(TapDownDetails details) {
    setMaterialState(MaterialState.pressed, true);
  }

  void onHover(bool value) {
    setMaterialState(MaterialState.hovered, value);
  }

  void onFocus(bool value) {
    setMaterialState(MaterialState.focused, value);
  }

  @override
  void initState() {
    setMaterialState(MaterialState.disabled, widget.disabled);
    setMaterialState(MaterialState.selected, widget.selected);
    setStyle();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appTheme = Theme.of(context);
      chipTheme = ChipTheme.of(context);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(FlexiChip oldWidget) {
    if (oldWidget.disabled != widget.disabled) {
      setMaterialState(MaterialState.disabled, widget.disabled);
    }
    if (oldWidget.selected != widget.selected) {
      setMaterialState(MaterialState.selected, widget.selected);
    }
    setStyle();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void forEachTween(visitor) {
    _containerRadiusTween = visitor(
      _containerRadiusTween,
      containerRadius,
      (value) => BorderRadiusTween(begin: value),
    ) as BorderRadiusTween?;

    _containerBorderTween = visitor(
      _containerBorderTween,
      containerBorder,
      (value) => ShapeBorderTween(begin: value),
    ) as ShapeBorderTween?;

    _containerDecorationTween = visitor(
      _containerDecorationTween,
      containerDecoration,
      (value) => DecorationTween(begin: value),
    ) as DecorationTween?;

    _containerShadowColorTween = visitor(
      _containerShadowColorTween,
      style.shadowColor,
      (value) => ColorTween(begin: value),
    ) as ColorTween?;

    _containerElevationTween = visitor(
      _containerElevationTween,
      style.elevation,
      (value) => Tween<double>(begin: value),
    ) as Tween<double>;

    _foregroundColorTween = visitor(
      _foregroundColorTween,
      foregroundColor,
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

  void didChangeMaterialState() {
    didUpdateWidget(widget);
  }

  @override
  void addMaterialState(MaterialState state) {
    if (materialStates.add(state)) {
      setState(() {});
      didChangeMaterialState();
    }
  }

  @override
  void removeMaterialState(MaterialState state) {
    if (materialStates.remove(state)) {
      setState(() {});
      didChangeMaterialState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: widget.canTap,
      enabled: widget.enabled,
      selected: widget.selected,
      child: _Tooltip(
        message: widget.tooltip,
        enabled: widget.canTap,
        child: _ChipContainer(
          clipBehavior: style.clipBehavior,
          borderRadius: animatedContainerRadius,
          decoration: animatedContainerDecoration,
          shape: animatedContainerBorder,
          shadowColor: animatedContainerShadowColor,
          elevation: animatedContainerElevation,
          child: _ChipEvent(
            onTap: onTap,
            onTapCancel: onTapCancel,
            onTapDown: onTapDown,
            onHover: onHover,
            onFocus: onFocus,
            enabled: widget.canTap,
            child: _ChipForeground(
              textStyle: animatedForegroundStyle,
              iconTheme: IconThemeData(
                color: animatedForegroundColor,
                size: FlexiChipStyle.defaultIconSize,
              ),
              padding: containerPadding,
              spacing: style.foregroundSpacing,
              label: widget.label,
              leading: leading,
              trailing: trailing,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipContainer extends StatelessWidget {
  const _ChipContainer({
    Key? key,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.elevation = 0.0,
    required this.shadowColor,
    required this.shape,
    required this.decoration,
    required this.child,
  }) : super(key: key);

  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;
  final Color shadowColor;
  final double elevation;
  final ShapeBorder shape;
  final Decoration decoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: Colors.transparent,
      clipBehavior: clipBehavior,
      shadowColor: shadowColor,
      elevation: elevation,
      clipper: ShapeBorderClipper(
        textDirection: Directionality.maybeOf(context),
        shape: shape,
      ),
      child: DecoratedBox(
        decoration: decoration,
        child: SizedBox(
          height: FlexiChipStyle.defaultHeight,
          child: child,
        ),
      ),
    );
  }
}

class _ChipEvent extends StatelessWidget {
  const _ChipEvent({
    Key? key,
    required this.child,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
    required this.onHover,
    required this.onFocus,
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final bool enabled;
  final GestureTapCallback onTap;
  final GestureTapCancelCallback onTapCancel;
  final GestureTapDownCallback onTapDown;
  final ValueChanged<bool> onHover;
  final ValueChanged<bool> onFocus;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        mouseCursor: MaterialStateMouseCursor.clickable,
        canRequestFocus: enabled,
        onTap: enabled ? onTap : null,
        onTapCancel: enabled ? onTapCancel : null,
        onTapDown: enabled ? onTapDown : null,
        onHover: onHover,
        onFocusChange: onFocus,
        child: child,
      ),
    );
  }
}

class _ChipForeground extends StatelessWidget {
  const _ChipForeground({
    Key? key,
    required this.textStyle,
    required this.iconTheme,
    required this.label,
    this.leading,
    this.trailing,
    required this.padding,
    this.spacing = 0.0,
  }) : super(key: key);

  final TextStyle textStyle;
  final IconThemeData iconTheme;
  final Widget label;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle()
          .merge(Theme.of(context).chipTheme.labelStyle)
          .merge(ChipTheme.of(context).labelStyle)
          .merge(textStyle),
      child: IconTheme(
        data: iconTheme,
        child: Padding(
          padding: padding,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: spacing,
            children: [
              leading,
              label,
              trailing,
            ].whereType<Widget>().toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class _Tooltip extends StatelessWidget {
  const _Tooltip({
    Key? key,
    this.message,
    this.enabled = true,
    required this.child,
  }) : super(key: key);

  final String? message;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (enabled && message != null) {
      return Tooltip(
        message: message,
        child: child,
      );
    }
    return child;
  }
}

class FlexiChipButton extends StatelessWidget {
  const FlexiChipButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.disabled = false,
    this.chipHeight = FlexiChipStyle.defaultHeight,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final bool disabled;
  final double chipHeight;

  bool get enabled => !disabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      child: _Tooltip(
        message:
            tooltip ?? MaterialLocalizations.of(context).deleteButtonTooltip,
        enabled: enabled,
        child: InkWell(
          // Radius should be slightly less than the full size of the chip.
          radius: chipHeight * .35,
          // Keeps the splash from being constrained to the icon alone.
          splashFactory:
              _UnconstrainedInkSplashFactory(Theme.of(context).splashFactory),
          onTap: enabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: icon,
        ),
      ),
    );
  }
}

class _UnconstrainedInkSplashFactory extends InteractiveInkFeatureFactory {
  const _UnconstrainedInkSplashFactory(this.parentFactory);

  final InteractiveInkFeatureFactory parentFactory;

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return parentFactory.create(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
      radius: radius,
      onRemoved: onRemoved,
      textDirection: textDirection,
    );
  }
}
