import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';
import './style.dart';

class FlexiChip extends ImplicitlyAnimatedWidget {
  const FlexiChip({
    Key? key,
    required this.label,
    this.avatarImage,
    this.avatarText,
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
    this.checkmark = false,
    this.autofocus = false,
    this.focusNode,
    this.splashColor,
    this.splashFactory,
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

  final ImageProvider? avatarImage;

  final Widget? avatarText;

  final Widget? leading;

  final Widget? trailing;

  final String? tooltip;

  final Widget? deleteIcon;

  final String? deleteTooltip;

  final bool selected;

  final bool disabled;

  final bool checkmark;

  final bool autofocus;

  final FocusNode? focusNode;

  final Color? splashColor;

  final InteractiveInkFeatureFactory? splashFactory;

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
  ThemeData appTheme = ThemeData();
  ChipThemeData chipTheme = const ChipThemeData();
  ChipThemeData defaultTheme = const ChipThemeData();
  Brightness brightness = Brightness.light;

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
        ? appTheme.brightness == Brightness.light
            ? appTheme.colorScheme.primary
            : appTheme.colorScheme.inversePrimary
        : (defaultTheme.backgroundColor ??
            chipTheme.backgroundColor ??
            appTheme.chipTheme.backgroundColor ??
            appTheme.unselectedWidgetColor);
  }

  Color get defaultForegroundColor {
    final brightness = appTheme.brightness;
    final colorByBrightness = brightness == Brightness.light
        ? FlexiChipStyle.defaultColor
        : Colors.white;
    return widget.selected
        ? appTheme.colorScheme.primary
        : (chipTheme.labelStyle?.color ??
            appTheme.chipTheme.labelStyle?.color ??
            colorByBrightness);
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
    final defaultPadding = hasAvatar
        ? FlexiChipStyle.defaultPaddingWithAvatar
        : FlexiChipStyle.defaultPadding;
    final padding = style.padding ?? defaultPadding;
    return padding.clamp(
      EdgeInsets.only(
        right: hasTrailing ? 8 : 0,
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
        .merge(appTheme.chipTheme.labelStyle)
        .merge(chipTheme.labelStyle)
        // .merge(defaultTheme.labelStyle)
        .copyWith(color: foregroundColor)
        .merge(style.foregroundStyle);
  }

  Color get avatarBackgroundColor {
    return style.avatarBackgroundColor ?? borderColor;
  }

  Color? _estimateSurfaceColor(Color? background, Color inLight, Color inDark) {
    if (background == null) return null;
    final brightness = ThemeData.estimateBrightnessForColor(background);
    return brightness == Brightness.dark ? inDark : inLight;
  }

  Color get avatarForegroundColor {
    return style.avatarForegroundColor ??
        _estimateSurfaceColor(
          avatarBackgroundColor,
          Colors.black87,
          Colors.white,
        ) ??
        foregroundColor;
  }

  TextStyle get avatarForegroundStyle {
    return const TextStyle(
      height: 1,
      fontSize: 12,
    ).copyWith(color: avatarForegroundColor).merge(style.avatarForegroundStyle);
  }

  ShapeBorder get avatarBorder {
    final radius = style.avatarBorderRadius;
    return radius != null
        ? RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide.none,
          )
        : const CircleBorder(
            side: BorderSide.none,
          );
  }

  BoxDecoration get avatarDecoration {
    return BoxDecoration(
      color: avatarBackgroundColor,
      image: widget.avatarImage != null
          ? DecorationImage(
              image: widget.avatarImage!,
              fit: BoxFit.cover,
            )
          : null,
      shape: BoxShape.rectangle,
    );
  }

  Color get checkmarkColor {
    return style.checkmarkColor ??
        (hasAvatar ? avatarForegroundColor : foregroundColor);
  }

  Color get iconColor {
    return style.iconColor ?? foregroundColor;
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

  TextStyleTween? _avatarForegroundStyleTween;
  TextStyle get animatedAvatarForegroundStyle {
    return const TextStyle()
        .merge(_avatarForegroundStyleTween?.evaluate(animation));
  }

  ColorTween? _avatarForegroundColorTween;
  Color get animatedAvatarForegroundColor {
    return _avatarForegroundColorTween?.evaluate(animation) ??
        avatarForegroundColor;
  }

  ShapeBorderTween? _avatarBorderTween;
  ShapeBorder get animatedAvatarBorder {
    return _avatarBorderTween?.evaluate(animation) ?? avatarBorder;
  }

  DecorationTween? _avatarDecorationTween;
  Decoration get animatedAvatarDecoration {
    return _avatarDecorationTween?.evaluate(animation) ?? avatarDecoration;
  }

  SizeTween? _avatarSizeTween;
  Size get animatedAvatarSize {
    return _avatarSizeTween?.evaluate(animation) ?? style.avatarSize;
  }

  ColorTween? _checkmarkColorTween;
  Color get animatedCheckmarkColor {
    return _checkmarkColorTween?.evaluate(animation) ?? checkmarkColor;
  }

  Tween<double>? _checkmarkProgressTween;
  double get animatedCheckmarkProgress {
    return _checkmarkProgressTween?.evaluate(animation) ?? 0;
  }

  Tween<double>? _checkmarkSizeTween;
  double get animatedCheckmarkSize {
    return _checkmarkSizeTween?.evaluate(animation) ?? style.checkmarkSize;
  }

  Tween<double>? _checkmarkWidthTween;
  double get animatedCheckmarkWidth {
    return _checkmarkWidthTween?.evaluate(animation) ?? style.checkmarkWidth;
  }

  ColorTween? _iconColorTween;
  Color get animatedIconColor {
    return _iconColorTween?.evaluate(animation) ?? iconColor;
  }

  Tween<double>? _iconSizeTween;
  double get animatedIconSize {
    return _iconSizeTween?.evaluate(animation) ?? style.iconSize;
  }

  Tween<double>? _iconOpacityTween;
  double get animatedIconOpacity {
    return _iconOpacityTween?.evaluate(animation) ?? style.iconOpacity;
  }

  bool get hasCheckmark => widget.checkmark && animatedCheckmarkProgress > 0;
  bool get hasAvatar => widget.avatarImage != null || widget.avatarText != null;
  bool get hasLeading => widget.leading != null;
  bool get hasTrailing => widget.trailing != null || deleteButton != null;

  Widget get label {
    return Baseline(
      baseline: foregroundStyle.fontSize ?? 14,
      baselineType: TextBaseline.alphabetic,
      child: widget.label,
    );
  }

  Widget? get leading {
    final withAvatar = hasAvatar
        ? _ChipAvatar(
            textStyle: animatedAvatarForegroundStyle,
            decoration: animatedAvatarDecoration,
            border: animatedAvatarBorder,
            size: animatedAvatarSize,
            child: checkmark ?? widget.avatarText!,
          )
        : checkmark;

    return widget.leading ?? withAvatar;
  }

  Widget? get trailing {
    return widget.trailing ?? deleteButton;
  }

  Widget? get checkmark {
    return hasCheckmark
        ? Checkmark(
            progress: animatedCheckmarkProgress,
            size: Size.square(animatedCheckmarkSize),
            weight: animatedCheckmarkWidth,
            color: animatedCheckmarkColor,
            style: style.checkmarkStyle,
          )
        : null;
  }

  Widget? get deleteButton {
    final onDeleted = widget.onDeleted;
    return onDeleted != null
        ? FlexiChipButton(
            icon: widget.deleteIcon ?? const Icon(Icons.close),
            tooltip: widget.deleteTooltip,
            disabled: !widget.canTap,
            onPressed: onDeleted,
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

  setTheme() {
    setState(() {
      appTheme = Theme.of(context);
      chipTheme = ChipTheme.of(context);
      brightness = chipTheme.brightness ?? appTheme.brightness;
      defaultTheme = ChipThemeData.fromDefaults(
        brightness: brightness,
        secondaryColor: brightness == Brightness.dark
            ? Colors.tealAccent[200]!
            : appTheme.primaryColor,
        labelStyle: const TextStyle().merge(appTheme.textTheme.bodyText1),
      );
    });
  }

  @override
  void initState() {
    setMaterialState(MaterialState.disabled, widget.disabled);
    setMaterialState(MaterialState.selected, widget.selected);
    setStyle();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setTheme();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setTheme();
    setStyle();
    super.didChangeDependencies();
    didUpdateWidget(widget);
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

    _avatarForegroundStyleTween = visitor(
      _avatarForegroundStyleTween,
      avatarForegroundStyle,
      (value) => TextStyleTween(begin: value),
    ) as TextStyleTween?;

    _avatarForegroundColorTween = visitor(
      _avatarForegroundColorTween,
      avatarForegroundColor,
      (value) => ColorTween(begin: value),
    ) as ColorTween?;

    _avatarBorderTween = visitor(
      _avatarBorderTween,
      avatarBorder,
      (value) => ShapeBorderTween(begin: value),
    ) as ShapeBorderTween?;

    _avatarDecorationTween = visitor(
      _avatarDecorationTween,
      avatarDecoration,
      (value) => DecorationTween(begin: value),
    ) as DecorationTween?;

    _avatarSizeTween = visitor(
      _avatarSizeTween,
      style.avatarSize,
      (value) => SizeTween(begin: value),
    ) as SizeTween?;

    _checkmarkColorTween = visitor(
      _checkmarkColorTween,
      checkmarkColor,
      (value) => ColorTween(begin: value),
    ) as ColorTween?;

    _checkmarkProgressTween = visitor(
      _checkmarkProgressTween,
      widget.selected ? 1.0 : 0.0,
      (value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    _checkmarkSizeTween = visitor(
      _checkmarkSizeTween,
      style.checkmarkSize,
      (value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    _checkmarkWidthTween = visitor(
      _checkmarkWidthTween,
      style.checkmarkWidth,
      (value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    _iconColorTween = visitor(
      _iconColorTween,
      iconColor,
      (value) => ColorTween(begin: value),
    ) as ColorTween?;

    _iconSizeTween = visitor(
      _iconSizeTween,
      style.iconSize,
      (value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    _iconOpacityTween = visitor(
      _iconOpacityTween,
      style.iconOpacity,
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
            enabled: widget.canTap,
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            splashColor: widget.splashColor,
            splashFactory: widget.splashFactory,
            onTap: onTap,
            onTapCancel: onTapCancel,
            onTapDown: onTapDown,
            onHover: onHover,
            onFocus: onFocus,
            child: _ChipForeground(
              textStyle: animatedForegroundStyle,
              iconTheme: IconThemeData(
                color: animatedIconColor,
                size: animatedIconSize,
                opacity: animatedIconOpacity,
              ),
              padding: containerPadding,
              spacing: style.foregroundSpacing,
              label: label,
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
    required this.child,
    required this.decoration,
    required this.shadowColor,
    required this.shape,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.elevation = 0.0,
  }) : super(key: key);

  final Widget child;
  final Decoration decoration;
  final Color shadowColor;
  final ShapeBorder shape;
  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;
  final double elevation;

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
    this.splashColor,
    this.splashFactory,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
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
        canRequestFocus: enabled,
        autofocus: autofocus,
        focusNode: focusNode,
        splashColor: splashColor,
        splashFactory: splashFactory,
        mouseCursor: MaterialStateMouseCursor.clickable,
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
    required this.padding,
    required this.textStyle,
    required this.iconTheme,
    required this.label,
    this.leading,
    this.trailing,
    this.spacing = 0.0,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final IconThemeData iconTheme;
  final Widget label;
  final Widget? leading;
  final Widget? trailing;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    // to keep the wrap spacing
    const placeholder = SizedBox.square(dimension: 0);
    return DefaultTextStyle(
      style: textStyle,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.start,
      softWrap: false,
      maxLines: 1,
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
              leading ?? placeholder,
              label,
              trailing ?? placeholder,
            ].whereType<Widget>().toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class _ChipAvatar extends StatelessWidget {
  const _ChipAvatar({
    Key? key,
    required this.decoration,
    required this.border,
    required this.size,
    required this.textStyle,
    this.child,
  }) : super(key: key);

  final TextStyle textStyle;
  final Decoration decoration;
  final ShapeBorder border;
  final Size size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: PhysicalShape(
        color: Colors.transparent,
        clipper: ShapeBorderClipper(
          textDirection: Directionality.maybeOf(context),
          shape: border,
        ),
        clipBehavior: Clip.antiAlias,
        child: DecoratedBox(
          decoration: decoration,
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            textHeightBehavior: const TextHeightBehavior(
              leadingDistribution: TextLeadingDistribution.even,
            ),
            style: textStyle,
            child: Center(
              child: child,
            ),
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
        message: tooltip,
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
