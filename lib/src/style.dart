import 'package:flutter/cupertino.dart';

class FlexiChipStyle {
  const FlexiChipStyle({
    this.useCheckmark = false,
    this.clipBehavior = Clip.antiAlias,
    this.margin,
    this.padding = FlexiChipStyle.defaultPadding,
    this.foregroundColor = FlexiChipStyle.defaultColor,
    this.foregroundSpacing = 8,
    this.backgroundColor = FlexiChipStyle.defaultColor,
    this.backgroundOpacity = .12,
    this.borderColor = FlexiChipStyle.defaultColor,
    this.borderOpacity = 1,
    this.borderWidth = 1,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.borderStyle = BorderStyle.none,
    this.disabledColor,
    this.shadowColor,
    this.elevation = 0,
    this.pressElevation = 0,
    this.labelStyle,
  });

  const FlexiChipStyle.outlined({
    this.useCheckmark = false,
    this.margin,
    this.padding = FlexiChipStyle.defaultPadding,
    double spacing = 8,
    Color color = FlexiChipStyle.defaultColor,
    this.clipBehavior = Clip.antiAlias,
    this.borderOpacity = 1,
    this.borderWidth = 1,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.disabledColor,
    this.shadowColor,
    this.elevation = 0,
    this.pressElevation = 0,
    this.labelStyle,
  })  : foregroundColor = color,
        foregroundSpacing = spacing,
        borderColor = color,
        borderStyle = BorderStyle.solid,
        backgroundColor = null,
        backgroundOpacity = 0;

  const FlexiChipStyle.elevated({
    this.useCheckmark = false,
    this.margin,
    this.padding = FlexiChipStyle.defaultPadding,
    Color color = FlexiChipStyle.defaultColor,
    this.foregroundSpacing = 8,
    this.foregroundColor = const Color(0xFFFFFFFF),
    this.clipBehavior = Clip.antiAlias,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.disabledColor,
    this.shadowColor,
    this.elevation = 1,
    this.pressElevation = 2,
    this.labelStyle,
  })  : backgroundColor = color,
        backgroundOpacity = 1,
        borderColor = color,
        borderStyle = BorderStyle.none,
        borderOpacity = 0,
        borderWidth = 0;

  static const defaultColor = Color(0xDD000000);
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(8));
  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);
  static const defaultHeight = 32.0;
  static const defaultIconSize = 18.0;

  final bool useCheckmark;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;

  final double elevation;
  final double pressElevation;

  final Color foregroundColor;
  final double foregroundSpacing;

  final Color? disabledColor;
  final Color? shadowColor;
  final Clip clipBehavior;

  final TextStyle? labelStyle;

  final Color? backgroundColor;

  /// Chip background opacity
  final double backgroundOpacity;

  final Color borderColor;

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
    TextStyle? labelStyle,
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
      labelStyle: labelStyle ?? this.labelStyle,
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
      foregroundColor: other.foregroundColor,
      foregroundSpacing: other.foregroundSpacing,
      backgroundColor: other.backgroundColor,
      backgroundOpacity: other.backgroundOpacity,
      disabledColor: other.disabledColor,
      margin: other.margin,
      padding: other.padding,
      elevation: other.elevation,
      pressElevation: other.pressElevation,
      labelStyle: other.labelStyle,
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
