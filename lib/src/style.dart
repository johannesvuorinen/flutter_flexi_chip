import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';

class FlexiChipStyle {
  const FlexiChipStyle({
    this.margin,
    this.padding,
    this.clipBehavior = Clip.antiAlias,
    this.shadowColor,
    this.elevation = 0,
    this.foregroundStyle,
    this.foregroundColor,
    this.foregroundSpacing = FlexiChipStyle.defaultForegroundSpacing,
    this.backgroundColor,
    this.backgroundOpacity = .12,
    this.borderColor,
    this.borderOpacity = 1,
    this.borderWidth = 1,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.borderStyle = BorderStyle.none,
    this.avatarSize = FlexiChipStyle.defaultAvatarSize,
    this.avatarForegroundStyle,
    this.avatarForegroundColor,
    this.avatarBackgroundColor,
    this.avatarBorderRadius,
    this.checkmarkColor,
    this.checkmarkSize = FlexiChipStyle.defaultCheckmarkSize,
    this.checkmarkWidth = FlexiChipStyle.defaultCheckmarkWidth,
    this.checkmarkStyle,
    this.iconColor,
    this.iconSize = FlexiChipStyle.defaultIconSize,
    this.iconOpacity = 1,
  });

  /// Chip style with an outlined border and no fill color.
  const FlexiChipStyle.outlined({
    this.margin,
    this.padding,
    this.clipBehavior = Clip.antiAlias,
    this.shadowColor,
    this.elevation = 0,
    double spacing = FlexiChipStyle.defaultForegroundSpacing,
    Color? color,
    this.borderOpacity = 1,
    this.borderWidth = 1,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.foregroundStyle,
    this.avatarSize = FlexiChipStyle.defaultAvatarSize,
    this.avatarForegroundStyle,
    this.avatarForegroundColor,
    this.avatarBorderRadius,
    this.checkmarkColor,
    this.checkmarkSize = FlexiChipStyle.defaultCheckmarkSize,
    this.checkmarkWidth = FlexiChipStyle.defaultCheckmarkWidth,
    this.checkmarkStyle,
    this.iconColor,
    this.iconSize = FlexiChipStyle.defaultIconSize,
    this.iconOpacity = 1,
  })  : foregroundColor = color,
        foregroundSpacing = spacing,
        avatarBackgroundColor = color,
        borderColor = color,
        borderStyle = BorderStyle.solid,
        backgroundColor = null,
        backgroundOpacity = 0;

  /// Chip style with fill color whose material elevates when pressed.
  const FlexiChipStyle.elevated({
    this.margin,
    this.padding,
    this.clipBehavior = Clip.antiAlias,
    this.shadowColor,
    this.elevation = 0,
    Color? color,
    this.foregroundStyle,
    this.foregroundColor = const Color(0xFFFFFFFF),
    this.foregroundSpacing = FlexiChipStyle.defaultForegroundSpacing,
    this.borderRadius = FlexiChipStyle.defaultBorderRadius,
    this.avatarSize = FlexiChipStyle.defaultAvatarSize,
    this.avatarForegroundStyle,
    this.avatarForegroundColor,
    this.avatarBackgroundColor,
    this.avatarBorderRadius,
    this.checkmarkColor,
    this.checkmarkSize = FlexiChipStyle.defaultCheckmarkSize,
    this.checkmarkWidth = FlexiChipStyle.defaultCheckmarkWidth,
    this.checkmarkStyle,
    this.iconColor,
    this.iconSize = FlexiChipStyle.defaultIconSize,
    this.iconOpacity = 1,
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
  static const defaultShadowColor = Color(0xFF000000);
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(8));
  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);
  static const defaultPaddingWithAvatar = EdgeInsets.symmetric(horizontal: 4);
  static const defaultAvatarSize = Size.square(24);
  static const defaultHeight = 32.0;
  static const defaultIconSize = 18.0;
  static const defaultCheckmarkWidth = 2.0;
  static const defaultCheckmarkSize = 18.0;
  static const defaultForegroundSpacing = 8.0;
  static const disabledBackgroundAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledBorderAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledForegroundAlpha = 0x61; // 38%

  final Color? checkmarkColor;
  final double checkmarkWidth;
  final double checkmarkSize;
  final CheckmarkStyle? checkmarkStyle;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final Clip clipBehavior;
  final Color? shadowColor;
  final double elevation;

  final TextStyle? foregroundStyle;
  final Color? foregroundColor;
  final double foregroundSpacing;

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
  /// This skips painting the border, but the border still has a [weight].
  final BorderStyle borderStyle;

  final Color? avatarBackgroundColor;
  final Color? avatarForegroundColor;
  final TextStyle? avatarForegroundStyle;
  final BorderRadiusGeometry? avatarBorderRadius;
  final Size avatarSize;

  final Color? iconColor;
  final double iconSize;
  final double iconOpacity;

  /// Creates a copy of this [FlexiChipStyle] but with
  /// the given fields replaced with the new values.
  FlexiChipStyle copyWith({
    TextStyle? foregroundStyle,
    Color? foregroundColor,
    double? foregroundSpacing,
    Color? backgroundColor,
    double? backgroundOpacity,
    Color? shadowColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Color? borderColor,
    double? borderOpacity,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle,
    Clip? clipBehavior,
    Size? avatarSize,
    TextStyle? avatarForegroundStyle,
    Color? avatarForegroundColor,
    Color? avatarBackgroundColor,
    BorderRadiusGeometry? avatarBorderRadius,
    Color? checkmarkColor,
    double? checkmarkWidth,
    double? checkmarkSize,
    CheckmarkStyle? checkmarkStyle,
    Color? iconColor,
    double? iconSize,
    double? iconOpacity,
  }) {
    return FlexiChipStyle(
      foregroundStyle: foregroundStyle ?? this.foregroundStyle,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      foregroundSpacing: foregroundSpacing ?? this.foregroundSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      shadowColor: shadowColor ?? this.shadowColor,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      borderColor: borderColor ?? this.borderColor,
      borderOpacity: borderOpacity ?? this.borderOpacity,
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
      clipBehavior: clipBehavior ?? this.clipBehavior,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
      checkmarkWidth: checkmarkWidth ?? this.checkmarkWidth,
      checkmarkSize: checkmarkSize ?? this.checkmarkSize,
      checkmarkStyle: checkmarkStyle ?? this.checkmarkStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      iconOpacity: iconOpacity ?? this.iconOpacity,
    );
  }

  /// Creates a copy of this [FlexiChipStyle] but with
  /// the given fields replaced with the new values.
  FlexiChipStyle merge(FlexiChipStyle? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      foregroundStyle: other.foregroundStyle,
      foregroundColor: other.foregroundColor,
      foregroundSpacing: other.foregroundSpacing,
      backgroundColor: other.backgroundColor,
      backgroundOpacity: other.backgroundOpacity,
      margin: other.margin,
      padding: other.padding,
      elevation: other.elevation,
      borderColor: other.borderColor,
      borderOpacity: other.borderOpacity,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      borderStyle: other.borderStyle,
      avatarSize: other.avatarSize,
      avatarForegroundStyle: other.avatarForegroundStyle,
      avatarForegroundColor: other.avatarForegroundColor,
      avatarBackgroundColor: other.avatarBackgroundColor,
      avatarBorderRadius: other.avatarBorderRadius,
      clipBehavior: other.clipBehavior,
      checkmarkColor: other.checkmarkColor,
      checkmarkWidth: other.checkmarkWidth,
      checkmarkSize: other.checkmarkSize,
      checkmarkStyle: other.checkmarkStyle,
      shadowColor: other.shadowColor,
      iconColor: other.iconColor,
      iconSize: other.iconSize,
      iconOpacity: other.iconOpacity,
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
