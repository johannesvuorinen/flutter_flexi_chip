import 'package:flutter/widgets.dart';
import 'package:widget_event/widget_event.dart';
import 'package:animated_checkmark/animated_checkmark.dart';
import 'event.dart';

/// Default chip's style.
class FlexiChipStyle {
  const FlexiChipStyle({
    this.height,
    this.margin,
    this.padding,
    this.clipBehavior,
    this.overlayColor,
    this.shadowColor,
    this.elevation,
    this.foregroundStyle,
    this.foregroundColor,
    this.foregroundOpacity,
    this.foregroundAlpha,
    this.foregroundSpacing,
    this.backgroundColor,
    this.backgroundOpacity,
    this.backgroundAlpha,
    this.borderColor,
    this.borderOpacity,
    this.borderAlpha,
    this.borderWidth,
    this.borderRadius,
    this.borderStyle,
    this.avatarSize,
    this.avatarForegroundStyle,
    this.avatarForegroundColor,
    this.avatarBackgroundColor,
    this.avatarBorderRadius,
    this.checkmarkColor,
    this.checkmarkSize,
    this.checkmarkWeight,
    this.checkmarkStyle,
    this.iconColor,
    this.iconOpacity,
    this.iconSize,
  });

  /// Create a chip's style from another style
  FlexiChipStyle.from(FlexiChipStyle? other)
      : height = other?.height,
        margin = other?.margin,
        padding = other?.padding,
        clipBehavior = other?.clipBehavior,
        overlayColor = other?.overlayColor,
        shadowColor = other?.shadowColor,
        elevation = other?.elevation,
        foregroundStyle = other?.foregroundStyle,
        foregroundColor = other?.foregroundColor,
        foregroundOpacity = other?.foregroundOpacity,
        foregroundAlpha = other?.foregroundAlpha,
        foregroundSpacing = other?.foregroundSpacing,
        backgroundColor = other?.backgroundColor,
        backgroundOpacity = other?.backgroundOpacity,
        backgroundAlpha = other?.backgroundAlpha,
        borderColor = other?.borderColor,
        borderOpacity = other?.borderOpacity,
        borderAlpha = other?.borderAlpha,
        borderWidth = other?.borderWidth,
        borderRadius = other?.borderRadius,
        borderStyle = other?.borderStyle,
        avatarSize = other?.avatarSize,
        avatarForegroundStyle = other?.avatarForegroundStyle,
        avatarForegroundColor = other?.avatarForegroundColor,
        avatarBackgroundColor = other?.avatarBackgroundColor,
        avatarBorderRadius = other?.avatarBorderRadius,
        checkmarkColor = other?.checkmarkColor,
        checkmarkSize = other?.checkmarkSize,
        checkmarkWeight = other?.checkmarkWeight,
        checkmarkStyle = other?.checkmarkStyle,
        iconColor = other?.iconColor,
        iconOpacity = other?.iconOpacity,
        iconSize = other?.iconSize;

  /// Create an event driven chip's style using [callback].
  factory FlexiChipStyle.driven(
    DrivenPropertyResolver<FlexiChipStyle?> callback,
  ) {
    return _DrivenFlexiChipStyle.by(callback);
  }

  /// Create a chip's style for each event.
  ///
  /// The [enabled] is base style to be applied to the chip.
  /// if [null] will fallback with empty FlexiChipStyle
  ///
  /// The [selected] is style to be merged with [enabled],
  /// when events includes [FlexiChipEvent.selected].
  ///
  /// The [disabled] style to be merged with [enabled],
  /// when events includes [FlexiChipEvent.disabled].
  ///
  /// The [hovered] style to be merged with [enabled],
  /// when events includes [FlexiChipEvent.hovered].
  ///
  /// The [focused] style to be merged with [enabled],
  /// when events includes [FlexiChipEvent.focused].
  ///
  /// The [pressed] style to be merged with [enabled],
  /// when events includes [FlexiChipEvent.pressed].
  factory FlexiChipStyle.onEvent({
    FlexiChipStyle? enabled,
    FlexiChipStyle? selected,
    FlexiChipStyle? disabled,
    FlexiChipStyle? hovered,
    FlexiChipStyle? focused,
    FlexiChipStyle? pressed,
  }) {
    return FlexiChipStyle.driven((events) {
      return (enabled ?? const FlexiChipStyle())
          .merge(FlexiChipEvent.isSelected(events)
              ? evaluate(selected, events)
              : null)
          .merge(FlexiChipEvent.isDisabled(events)
              ? evaluate(disabled, events)
              : null)
          .merge(FlexiChipEvent.isHovered(events)
              ? evaluate(hovered, events)
              : null)
          .merge(FlexiChipEvent.isFocused(events)
              ? evaluate(focused, events)
              : null)
          .merge(FlexiChipEvent.isPressed(events)
              ? evaluate(pressed, events)
              : null);
    });
  }

  /// Create chip's style with default value for toned style.
  ///
  /// The [selectedStyle] is style to be merged,
  /// when events includes [FlexiChipEvent.selected].
  ///
  /// The [disabledStyle] style to be merged,
  /// when events includes [FlexiChipEvent.disabled].
  ///
  /// The [hoveredStyle] style to be merged,
  /// when events includes [FlexiChipEvent.hovered].
  ///
  /// The [focusedStyle] style to be merged,
  /// when events includes [FlexiChipEvent.focused].
  ///
  /// The [pressedStyle] style to be merged,
  /// when events includes [FlexiChipEvent.pressed].
  factory FlexiChipStyle.toned({
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Clip? clipBehavior,
    Color? overlayColor,
    Color? shadowColor,
    double? elevation,
    TextStyle? foregroundStyle,
    Color? foregroundColor,
    double? foregroundOpacity,
    int? foregroundAlpha,
    double? foregroundSpacing,
    Color? backgroundColor,
    double? backgroundOpacity = .12,
    int? backgroundAlpha,
    Color? borderColor,
    double? borderOpacity = 1,
    int? borderAlpha,
    double? borderWidth = 1,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle = BorderStyle.none,
    Size? avatarSize,
    TextStyle? avatarForegroundStyle,
    Color? avatarForegroundColor,
    Color? avatarBackgroundColor,
    BorderRadiusGeometry? avatarBorderRadius,
    Color? checkmarkColor,
    double? checkmarkSize,
    double? checkmarkWeight,
    CheckmarkStyle? checkmarkStyle,
    Color? iconColor,
    double? iconOpacity,
    double? iconSize,
    FlexiChipStyle? selectedStyle,
    FlexiChipStyle? disabledStyle = const FlexiChipStyle(
      foregroundAlpha: FlexiChipStyle.disabledForegroundAlpha,
      backgroundAlpha: FlexiChipStyle.disabledBackgroundAlpha,
      borderAlpha: FlexiChipStyle.disabledBorderAlpha,
    ),
    FlexiChipStyle? hoveredStyle,
    FlexiChipStyle? focusedStyle,
    FlexiChipStyle? pressedStyle,
  }) {
    return FlexiChipStyle.onEvent(
      enabled: FlexiChipStyle(
        height: height,
        margin: margin,
        padding: padding,
        clipBehavior: clipBehavior,
        overlayColor: overlayColor,
        shadowColor: shadowColor,
        elevation: elevation,
        foregroundStyle: foregroundStyle,
        foregroundColor: foregroundColor,
        foregroundOpacity: foregroundOpacity,
        foregroundAlpha: foregroundAlpha,
        foregroundSpacing: foregroundSpacing,
        backgroundColor: backgroundColor,
        backgroundOpacity: backgroundOpacity,
        backgroundAlpha: backgroundAlpha,
        borderColor: borderColor,
        borderOpacity: borderOpacity,
        borderAlpha: borderAlpha,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderStyle: borderStyle,
        avatarSize: avatarSize,
        avatarForegroundStyle: avatarForegroundStyle,
        avatarForegroundColor: avatarForegroundColor,
        avatarBackgroundColor: avatarBackgroundColor,
        avatarBorderRadius: avatarBorderRadius,
        checkmarkColor: checkmarkColor,
        checkmarkSize: checkmarkSize,
        checkmarkWeight: checkmarkWeight,
        checkmarkStyle: checkmarkStyle,
        iconColor: iconColor,
        iconOpacity: iconOpacity,
        iconSize: iconSize,
      ),
      selected: selectedStyle,
      disabled: disabledStyle,
      hovered: hoveredStyle,
      focused: focusedStyle,
      pressed: pressedStyle,
    );
  }

  /// Create chip's style with default value for filled style.
  ///
  /// The [selectedStyle] is style to be merged,
  /// when events includes [FlexiChipEvent.selected].
  ///
  /// The [disabledStyle] style to be merged,
  /// when events includes [FlexiChipEvent.disabled].
  ///
  /// The [hoveredStyle] style to be merged,
  /// when events includes [FlexiChipEvent.hovered].
  ///
  /// The [focusedStyle] style to be merged,
  /// when events includes [FlexiChipEvent.focused].
  ///
  /// The [pressedStyle] style to be merged,
  /// when events includes [FlexiChipEvent.pressed].
  factory FlexiChipStyle.filled({
    Color? color,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Clip? clipBehavior,
    Color? overlayColor,
    Color? shadowColor,
    double? elevation,
    TextStyle? foregroundStyle,
    Color? foregroundColor,
    double? foregroundOpacity,
    int? foregroundAlpha,
    double? foregroundSpacing,
    double? backgroundOpacity = 1,
    int? backgroundAlpha,
    double? borderOpacity = 0,
    int? borderAlpha,
    double? borderWidth = 0,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle = BorderStyle.none,
    Size? avatarSize,
    TextStyle? avatarForegroundStyle,
    Color? avatarForegroundColor,
    Color? avatarBackgroundColor,
    BorderRadiusGeometry? avatarBorderRadius,
    Color? checkmarkColor,
    double? checkmarkSize,
    double? checkmarkWeight,
    CheckmarkStyle? checkmarkStyle,
    Color? iconColor,
    double? iconOpacity,
    double? iconSize,
    FlexiChipStyle? selectedStyle,
    FlexiChipStyle? disabledStyle = const FlexiChipStyle(
      foregroundAlpha: FlexiChipStyle.disabledForegroundAlpha,
      backgroundAlpha: FlexiChipStyle.disabledBackgroundAlpha,
      borderAlpha: FlexiChipStyle.disabledBorderAlpha,
    ),
    FlexiChipStyle? hoveredStyle,
    FlexiChipStyle? focusedStyle,
    FlexiChipStyle? pressedStyle = const FlexiChipStyle(
      elevation: 5,
    ),
  }) {
    return FlexiChipStyle.onEvent(
      enabled: FlexiChipStyle(
        backgroundColor: color,
        borderColor: color,
        height: height,
        margin: margin,
        padding: padding,
        clipBehavior: clipBehavior,
        overlayColor: overlayColor,
        shadowColor: shadowColor,
        elevation: elevation,
        foregroundStyle: foregroundStyle,
        foregroundColor: foregroundColor,
        foregroundOpacity: foregroundOpacity,
        foregroundAlpha: foregroundAlpha,
        foregroundSpacing: foregroundSpacing,
        backgroundOpacity: backgroundOpacity,
        backgroundAlpha: backgroundAlpha,
        borderOpacity: borderOpacity,
        borderAlpha: borderAlpha,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderStyle: borderStyle,
        avatarSize: avatarSize,
        avatarForegroundStyle: avatarForegroundStyle,
        avatarForegroundColor: avatarForegroundColor,
        avatarBackgroundColor: avatarBackgroundColor,
        avatarBorderRadius: avatarBorderRadius,
        checkmarkColor: checkmarkColor,
        checkmarkSize: checkmarkSize,
        checkmarkWeight: checkmarkWeight,
        checkmarkStyle: checkmarkStyle,
        iconColor: iconColor,
        iconOpacity: iconOpacity,
        iconSize: iconSize,
      ),
      selected: selectedStyle,
      disabled: disabledStyle,
      hovered: hoveredStyle,
      focused: focusedStyle,
      pressed: pressedStyle,
    );
  }

  /// Create chip's style with default value for outlined style.
  ///
  /// The [selected] is style to be merged,
  /// when events includes [FlexiChipEvent.selected].
  ///
  /// The [disabled] style to be merged,
  /// when events includes [FlexiChipEvent.disabled].
  ///
  /// The [hovered] style to be merged,
  /// when events includes [FlexiChipEvent.hovered].
  ///
  /// The [focused] style to be merged,
  /// when events includes [FlexiChipEvent.focused].
  ///
  /// The [pressed] style to be merged,
  /// when events includes [FlexiChipEvent.pressed].
  factory FlexiChipStyle.outlined({
    Color? color,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Clip? clipBehavior,
    Color? overlayColor,
    Color? shadowColor,
    double? elevation,
    TextStyle? foregroundStyle,
    double? foregroundOpacity,
    int? foregroundAlpha,
    double? foregroundSpacing,
    Color? backgroundColor,
    double? backgroundOpacity = 0,
    int? backgroundAlpha,
    double? borderOpacity,
    int? borderAlpha,
    double? borderWidth = 1,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle = BorderStyle.solid,
    Size? avatarSize,
    TextStyle? avatarForegroundStyle,
    Color? avatarForegroundColor,
    BorderRadiusGeometry? avatarBorderRadius,
    Color? checkmarkColor,
    double? checkmarkSize,
    double? checkmarkWeight,
    CheckmarkStyle? checkmarkStyle,
    Color? iconColor,
    double? iconOpacity,
    double? iconSize,
    FlexiChipStyle? selectedStyle,
    FlexiChipStyle? disabledStyle = const FlexiChipStyle(
      foregroundAlpha: FlexiChipStyle.disabledForegroundAlpha,
      borderAlpha: FlexiChipStyle.disabledBorderAlpha,
    ),
    FlexiChipStyle? hoveredStyle,
    FlexiChipStyle? focusedStyle,
    FlexiChipStyle? pressedStyle,
  }) {
    return FlexiChipStyle.onEvent(
      enabled: FlexiChipStyle(
        borderColor: color,
        foregroundColor: color,
        avatarBackgroundColor: color,
        height: height,
        margin: margin,
        padding: padding,
        clipBehavior: clipBehavior,
        overlayColor: overlayColor,
        shadowColor: shadowColor,
        elevation: elevation,
        foregroundStyle: foregroundStyle,
        foregroundOpacity: foregroundOpacity,
        foregroundAlpha: foregroundAlpha,
        foregroundSpacing: foregroundSpacing,
        backgroundColor: backgroundColor,
        backgroundOpacity: backgroundOpacity,
        backgroundAlpha: backgroundAlpha,
        borderOpacity: borderOpacity,
        borderAlpha: borderAlpha,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderStyle: borderStyle,
        avatarSize: avatarSize,
        avatarForegroundStyle: avatarForegroundStyle,
        avatarForegroundColor: avatarForegroundColor,
        avatarBorderRadius: avatarBorderRadius,
        checkmarkColor: checkmarkColor,
        checkmarkSize: checkmarkSize,
        checkmarkWeight: checkmarkWeight,
        checkmarkStyle: checkmarkStyle,
        iconColor: iconColor,
        iconOpacity: iconOpacity,
        iconSize: iconSize,
      ),
      selected: selectedStyle,
      disabled: disabledStyle,
      hovered: hoveredStyle,
      focused: focusedStyle,
      pressed: pressedStyle,
    );
  }

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [FlexiChipStyle],
  /// otherwise returns the value itself.
  static FlexiChipStyle? evaluate(
    FlexiChipStyle? value,
    Set<WidgetEvent> events,
  ) {
    return _DrivenFlexiChipStyle.evaluate(value, events);
  }

  static const defaultClipBehavior = Clip.antiAlias;
  static const defaultBorderWidth = 1.0;
  static const defaultBorderStyle = BorderStyle.solid;
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(8));
  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);
  static const defaultPaddingWithAvatar = EdgeInsets.symmetric(horizontal: 4);
  static const defaultAvatarSize = Size.square(24);
  static const defaultHeight = 32.0;
  static const defaultIconSize = 18.0;
  static const defaultCheckmarkWeight = 2.0;
  static const defaultCheckmarkSize = 18.0;
  static const defaultForegroundSpacing = 8.0;
  static const disabledForegroundAlpha = 0x61; // 38%
  static const disabledBackgroundAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledBorderAlpha = 0x0c; // 38% * 12% = 5%

  /// Defaults to [FlexiChipStyle.defaultHeight]
  final double? height;

  /// Empty space to surround the outside chip.
  final EdgeInsetsGeometry? margin;

  /// The padding between the contents of the chip and the outside chip.
  ///
  /// If chip has avatar defaults to [FlexiChipStyle.defaultPaddingWithAvatar],
  /// else defaults to [FlexiChipStyle.defaultPadding].
  final EdgeInsetsGeometry? padding;

  /// The chip's content will be clipped (or not) according to this option.
  ///
  /// See the enum [Clip] for details of all possible options and their common use cases.
  ///
  /// Defaults to [FlexiChipStyle.defaultClipBehavior]
  final Clip? clipBehavior;

  /// Defines the ink response colors.
  final Color? overlayColor;

  /// When [elevation] is non zero the color to use for the chip's shadow color.
  final Color? shadowColor;

  /// The chip's z-coordinate relative to the parent at which to place this physical object.
  ///
  /// The value is non-negative.
  final double? elevation;

  /// The style to be applied to the chip's label.
  ///
  /// The default label style is [TextTheme.bodyText1] from the overall
  /// theme's [ThemeData.textTheme].
  //
  /// This only has an effect on widgets that respect the [DefaultTextStyle],
  /// such as [Text].
  final TextStyle? foregroundStyle;

  /// The color to be applied to the chip's label, icon, and checkmark
  final Color? foregroundColor;

  /// Opacity to be apply to [foregroundColor].
  final double? foregroundOpacity;

  /// Alpha to be apply to [foregroundColor].
  final int? foregroundAlpha;

  /// How much space to place between chip's foreground widget in a run in the main axis.
  final double? foregroundSpacing;

  /// Color to be used for the chip's background.
  final Color? backgroundColor;

  /// Opacity to be apply to [backgroundColor].
  final double? backgroundOpacity;

  /// Alpha to be apply to [backgroundColor].
  final int? backgroundAlpha;

  /// Color to be used for the chip's border.
  final Color? borderColor;

  /// Opacity to be apply to [borderColor].
  final double? borderOpacity;

  /// Alpha to be apply to [borderColor].
  final int? borderAlpha;

  /// The width of this side of the chip's border, in logical pixels.
  final double? borderWidth;

  /// The radii for each corner of the chip's border.
  final BorderRadiusGeometry? borderRadius;

  /// The style of this side of the chip's border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none].
  /// This skips painting the border, but the border still has a [weight].
  final BorderStyle? borderStyle;

  /// Color to be used for the avatar's background.
  final Color? avatarBackgroundColor;

  /// Color to be used for the avatar's foreground (checkmark, or text).
  final Color? avatarForegroundColor;

  /// The style to be applied to the avatar's label.
  ///
  /// The default label style is [TextTheme.bodyText1] from the overall
  /// theme's [ThemeData.textTheme].
  //
  /// This only has an effect on widgets that respect the [DefaultTextStyle],
  /// such as [Text].
  final TextStyle? avatarForegroundStyle;

  /// The radii for each corner of the avatar's border.
  final BorderRadiusGeometry? avatarBorderRadius;

  /// Defaults to [FlexiChipStyle.defaultAvatarSize].
  final Size? avatarSize;

  /// The Color to be apply to the checkmark.
  ///
  /// If null fallback to [avatarForegroundColor] or [foregroundColor].
  final Color? checkmarkColor;

  /// Defaults to [FlexiChipStyle.defaultCheckmarkSize].
  final double? checkmarkSize;

  /// Stroke width of the checkmark.
  ///
  /// Defaults to [FlexiChipStyle.defaultCheckmarkWeight].
  final double? checkmarkWeight;

  /// Defaults to [CheckmarkStyle.sharp].
  final CheckmarkStyle? checkmarkStyle;

  /// Color to be used for the icon's inside the chip.
  final Color? iconColor;

  /// Opacity to be apply to [iconColor].
  final double? iconOpacity;

  /// The size of the icon's inside the chip, in logical pixels.
  ///
  /// Defaults to [FlexiChipStyle.defaultIconSize].
  final double? iconSize;

  /// Creates a copy of this [FlexiChipStyle] but with
  /// the given fields replaced with the new values.
  FlexiChipStyle copyWith({
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Clip? clipBehavior,
    Color? overlayColor,
    Color? shadowColor,
    double? elevation,
    TextStyle? foregroundStyle,
    Color? foregroundColor,
    double? foregroundOpacity,
    int? foregroundAlpha,
    double? foregroundSpacing,
    Color? backgroundColor,
    double? backgroundOpacity,
    int? backgroundAlpha,
    Color? borderColor,
    double? borderOpacity,
    int? borderAlpha,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle,
    Size? avatarSize,
    TextStyle? avatarForegroundStyle,
    Color? avatarForegroundColor,
    Color? avatarBackgroundColor,
    BorderRadiusGeometry? avatarBorderRadius,
    Color? checkmarkColor,
    double? checkmarkSize,
    double? checkmarkWeight,
    CheckmarkStyle? checkmarkStyle,
    Color? iconColor,
    double? iconOpacity,
    double? iconSize,
  }) {
    return FlexiChipStyle(
      height: height ?? this.height,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      overlayColor: overlayColor ?? this.overlayColor,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      foregroundStyle: foregroundStyle ?? this.foregroundStyle,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      foregroundOpacity: foregroundOpacity ?? this.foregroundOpacity,
      foregroundAlpha: foregroundAlpha ?? this.foregroundAlpha,
      foregroundSpacing: foregroundSpacing ?? this.foregroundSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      backgroundAlpha: backgroundAlpha ?? this.backgroundAlpha,
      borderColor: borderColor ?? this.borderColor,
      borderOpacity: borderOpacity ?? this.borderOpacity,
      borderAlpha: borderAlpha ?? this.borderAlpha,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      borderStyle: borderStyle ?? this.borderStyle,
      avatarSize: avatarSize ?? this.avatarSize,
      avatarForegroundStyle:
          avatarForegroundStyle ?? this.avatarForegroundStyle,
      avatarForegroundColor:
          avatarForegroundColor ?? this.avatarForegroundColor,
      avatarBackgroundColor:
          avatarBackgroundColor ?? this.avatarBackgroundColor,
      avatarBorderRadius: avatarBorderRadius ?? this.avatarBorderRadius,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
      checkmarkSize: checkmarkSize ?? this.checkmarkSize,
      checkmarkWeight: checkmarkWeight ?? this.checkmarkWeight,
      checkmarkStyle: checkmarkStyle ?? this.checkmarkStyle,
      iconColor: iconColor ?? this.iconColor,
      iconOpacity: iconOpacity ?? this.iconOpacity,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  /// Creates a copy of this [FlexiChipStyle] but with
  /// the given fields replaced with the new values.
  FlexiChipStyle merge(FlexiChipStyle? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      height: other.height,
      margin: other.margin,
      padding: other.padding,
      clipBehavior: other.clipBehavior,
      overlayColor: other.overlayColor,
      shadowColor: other.shadowColor,
      elevation: other.elevation,
      foregroundStyle: other.foregroundStyle,
      foregroundColor: other.foregroundColor,
      foregroundOpacity: other.foregroundOpacity,
      foregroundAlpha: other.foregroundAlpha,
      foregroundSpacing: other.foregroundSpacing,
      backgroundColor: other.backgroundColor,
      backgroundOpacity: other.backgroundOpacity,
      backgroundAlpha: other.backgroundAlpha,
      borderColor: other.borderColor,
      borderOpacity: other.borderOpacity,
      borderAlpha: other.borderAlpha,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      borderStyle: other.borderStyle,
      avatarSize: other.avatarSize,
      avatarForegroundStyle: other.avatarForegroundStyle,
      avatarForegroundColor: other.avatarForegroundColor,
      avatarBackgroundColor: other.avatarBackgroundColor,
      avatarBorderRadius: other.avatarBorderRadius,
      checkmarkColor: other.checkmarkColor,
      checkmarkSize: other.checkmarkSize,
      checkmarkWeight: other.checkmarkWeight,
      checkmarkStyle: other.checkmarkStyle,
      iconColor: other.iconColor,
      iconOpacity: other.iconOpacity,
      iconSize: other.iconSize,
    );
  }
}

abstract class _DrivenFlexiChipStyle extends FlexiChipStyle
    implements DrivenProperty<FlexiChipStyle?> {
  _DrivenFlexiChipStyle(FlexiChipStyle? style) : super.from(style);

  @override
  FlexiChipStyle? resolve(Set<WidgetEvent> events);

  static FlexiChipStyle? evaluate(
    FlexiChipStyle? value,
    Set<WidgetEvent> events,
  ) {
    return DrivenProperty.evaluate<FlexiChipStyle?>(value, events);
  }

  static FlexiChipStyle by(
    DrivenPropertyResolver<FlexiChipStyle?> callback,
  ) {
    return _DrivenFlexiChipStyleBy(callback);
  }
}

class _DrivenFlexiChipStyleBy extends _DrivenFlexiChipStyle {
  _DrivenFlexiChipStyleBy(this._resolver) : super(_resolver({}));

  final DrivenPropertyResolver<FlexiChipStyle?> _resolver;

  @override
  FlexiChipStyle? resolve(Set<WidgetEvent> events) => _resolver(events);
}
