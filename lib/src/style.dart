import 'package:flutter/material.dart';

class FlexiChipStyle {
  const FlexiChipStyle({
    this.useCheckmark = false,
    this.clipBehavior = Clip.antiAlias,
    this.margin,
    this.padding = FlexiChipStyle.defaultPadding,
    this.foregroundStyle,
    this.foregroundColor,
    this.foregroundSpacing = 8,
    this.backgroundColor,
    this.backgroundOpacity = .12,
    this.borderColor,
    this.borderOpacity = 1,
    this.borderWidth = 1,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.borderStyle = BorderStyle.none,
    this.disabledColor,
    this.shadowColor,
    this.elevation = 0,
    this.pressElevation = 8,
  });

  /// Chip style with an outlined border and no fill color.
  const FlexiChipStyle.outlined({
    this.useCheckmark = false,
    this.margin,
    this.padding = FlexiChipStyle.defaultPadding,
    double spacing = 8,
    Color? color,
    this.clipBehavior = Clip.antiAlias,
    this.borderOpacity = 1,
    this.borderWidth = 1,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.disabledColor,
    this.shadowColor,
    this.elevation = 0,
    this.pressElevation = 0,
    this.foregroundStyle,
  })  : foregroundColor = color,
        foregroundSpacing = spacing,
        borderColor = color,
        borderStyle = BorderStyle.solid,
        backgroundColor = null,
        backgroundOpacity = 0;

  /// Chip style with fill color whose material elevates when pressed.
  const FlexiChipStyle.elevated({
    this.useCheckmark = false,
    this.margin,
    this.padding = FlexiChipStyle.defaultPadding,
    Color? color,
    this.foregroundStyle,
    this.foregroundColor = const Color(0xFFFFFFFF),
    this.foregroundSpacing = 8,
    this.clipBehavior = Clip.antiAlias,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.disabledColor,
    this.shadowColor,
    this.elevation = 0,
    this.pressElevation = 8,
  })  : backgroundColor = color,
        backgroundOpacity = 1,
        borderColor = color,
        borderStyle = BorderStyle.none,
        borderOpacity = 0,
        borderWidth = 0;

  /// A [MaterialStateFlexiChipStyle] created
  /// from a [MaterialPropertyResolver<FlexiChipStyle>]
  /// callback alone.
  ///
  /// If used as a regular FlexiChipStyle,
  /// the FlexiChipStyle resolved in the default state will be used.
  ///
  /// Used by [MaterialStateFlexiChipStyle.resolveWith].
  static MaterialStateFlexiChipStyle stated(
    MaterialPropertyResolver<FlexiChipStyle> callback,
  ) =>
      _MaterialStateFlexiChipStyle(callback);

  static const defaultColor = Color(0xDD000000);
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(8));
  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);
  static const defaultHeight = 32.0;
  static const defaultIconSize = 18.0;
  static const disabledBackgroundAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledBorderAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledForegroundAlpha = 0x61; // 38%

  final bool useCheckmark;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;

  final double elevation;
  final double pressElevation;

  final TextStyle? foregroundStyle;
  final Color? foregroundColor;
  final double foregroundSpacing;

  final Color? disabledColor;
  final Color? shadowColor;
  final Clip clipBehavior;

  final Color? backgroundColor;

  /// Chip background opacity
  final double backgroundOpacity;

  final Color? borderColor;

  /// Chip border opacity
  final double borderOpacity;

  /// The width of this side of the border, in logical pixels.
  final double borderWidth;

  /// The radii for each corner.
  final BorderRadiusGeometry borderRadius;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none].
  /// This skips painting the border, but the border still has a [width].
  final BorderStyle borderStyle;

  /// Creates a copy of this [FlexiChipStyle] but with
  /// the given fields replaced with the new values.
  FlexiChipStyle copyWith({
    bool? useCheckmark,
    TextStyle? foregroundStyle,
    Color? foregroundColor,
    double? foregroundSpacing,
    Color? backgroundColor,
    double? backgroundOpacity,
    Color? disabledColor,
    Color? shadowColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    double? pressElevation,
    Color? borderColor,
    double? borderOpacity,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle,
    Color? avatarBorderColor,
    double? avatarBorderWidth,
    BorderRadiusGeometry? avatarBorderRadius,
    BorderStyle? avatarBorderStyle,
    ShapeBorder? avatarBorderShape,
    Clip? clipBehavior,
  }) {
    return FlexiChipStyle(
      useCheckmark: useCheckmark ?? this.useCheckmark,
      foregroundStyle: foregroundStyle ?? this.foregroundStyle,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      foregroundSpacing: foregroundSpacing ?? this.foregroundSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      disabledColor: disabledColor ?? this.disabledColor,
      shadowColor: shadowColor ?? this.shadowColor,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      pressElevation: pressElevation ?? this.pressElevation,
      borderColor: borderColor ?? this.borderColor,
      borderOpacity: borderOpacity ?? this.borderOpacity,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      borderStyle: borderStyle ?? this.borderStyle,
      // avatarBorderColor: avatarBorderColor ?? this.avatarBorderColor,
      // avatarBorderWidth: avatarBorderWidth ?? this.avatarBorderWidth,
      // avatarBorderRadius: avatarBorderRadius ?? this.avatarBorderRadius,
      // avatarBorderStyle: avatarBorderStyle ?? this.avatarBorderStyle,
      // avatarBorderShape: avatarBorderShape ?? this.avatarBorderShape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      // materialTapTargetSize:
      //     materialTapTargetSize ?? this.materialTapTargetSize,
    );
  }

  /// Creates a copy of this [FlexiChipStyle] but with
  /// the given fields replaced with the new values.
  FlexiChipStyle merge(FlexiChipStyle? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      useCheckmark: other.useCheckmark,
      foregroundStyle: other.foregroundStyle,
      foregroundColor: other.foregroundColor,
      foregroundSpacing: other.foregroundSpacing,
      backgroundColor: other.backgroundColor,
      backgroundOpacity: other.backgroundOpacity,
      disabledColor: other.disabledColor,
      margin: other.margin,
      padding: other.padding,
      elevation: other.elevation,
      pressElevation: other.pressElevation,
      borderColor: other.borderColor,
      borderOpacity: other.borderOpacity,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      borderStyle: other.borderStyle,
      // avatarBorderColor: other.avatarBorderColor,
      // avatarBorderWidth: other.avatarBorderWidth,
      // avatarBorderRadius: other.avatarBorderRadius,
      // avatarBorderStyle: other.avatarBorderStyle,
      // avatarBorderShape: other.avatarBorderShape,
      clipBehavior: other.clipBehavior,
      // materialTapTargetSize: other.materialTapTargetSize,
    );
  }
}

abstract class MaterialStateFlexiChipStyle extends FlexiChipStyle
    implements MaterialStateProperty<FlexiChipStyle?> {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const MaterialStateFlexiChipStyle(FlexiChipStyle defaultValue);

  /// Creates a [MaterialStateFlexiChipStyle]
  /// from a [MaterialPropertyResolver<FlexiChipStyle>]
  /// callback function.
  ///
  /// If used as a regular color, the color resolved in the default state (the
  /// empty set of states) will be used.
  ///
  /// The given callback parameter must return a non-null color in the default
  /// state.
  static MaterialStateFlexiChipStyle resolveWith(
    MaterialPropertyResolver<FlexiChipStyle> callback,
  ) =>
      _MaterialStateFlexiChipStyle(callback);

  /// Returns a [FlexiChipStyle] that's to be used when a Material component is
  /// in the specified state. Return null to defer to the default value of the
  /// widget or theme.
  @override
  FlexiChipStyle? resolve(Set<MaterialState> states);
}

/// A [MaterialStateFlexiChipStyle] created
/// from a [MaterialPropertyResolver<FlexiChipStyle>]
/// callback alone.
///
/// If used as a regular FlexiChipStyle,
/// the FlexiChipStyle resolved in the default state will be used.
///
/// Used by [MaterialStateFlexiChipStyle.resolveWith].
class _MaterialStateFlexiChipStyle extends MaterialStateFlexiChipStyle {
  _MaterialStateFlexiChipStyle(this._resolve) : super(_resolve(_defaultStates));

  final MaterialPropertyResolver<FlexiChipStyle> _resolve;

  /// The default state for a Material component, the empty set of interaction states.
  static const Set<MaterialState> _defaultStates = <MaterialState>{};

  @override
  FlexiChipStyle resolve(Set<MaterialState> states) => _resolve(states);
}
