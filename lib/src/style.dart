import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';

class FlexiChipStyle {
  const FlexiChipStyle({
    this.margin,
    this.padding,
    this.clipBehavior,
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
    this.checkmarkWeight = FlexiChipStyle.defaultCheckmarkWeight,
    this.checkmarkStyle,
    this.iconColor,
    this.iconOpacity,
    this.iconSize = FlexiChipStyle.defaultIconSize,
  });

  /// Chip style with an outlined border and no fill color.
  const FlexiChipStyle.outlined({
    this.margin,
    this.padding,
    this.clipBehavior,
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
    this.checkmarkWeight = FlexiChipStyle.defaultCheckmarkWeight,
    this.checkmarkStyle,
    this.iconColor,
    this.iconOpacity,
    this.iconSize = FlexiChipStyle.defaultIconSize,
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
    this.clipBehavior,
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
    this.checkmarkWeight = FlexiChipStyle.defaultCheckmarkWeight,
    this.checkmarkStyle,
    this.iconColor,
    this.iconOpacity,
    this.iconSize = FlexiChipStyle.defaultIconSize,
  })  : backgroundColor = color,
        backgroundOpacity = 1,
        borderColor = color,
        borderStyle = BorderStyle.none,
        borderOpacity = 0,
        borderWidth = 0;

  /// A [MaterialStateFlexiChipStyle] created
  /// from a [MaterialPropertyResolver<FlexiChipStyle>]
  /// callback alone.
  static MaterialStateFlexiChipStyle stated(
    MaterialPropertyResolver<FlexiChipStyle> callback,
  ) =>
      _MaterialStateFlexiChipStyle(callback);

  static const defaultColor = Color(0xDD000000);
  static const defaultShadowColor = Color(0xFF000000);
  static const defaultClipBehavior = Clip.antiAlias;
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(8));
  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);
  static const defaultPaddingWithAvatar = EdgeInsets.symmetric(horizontal: 4);
  static const defaultAvatarSize = Size.square(24);
  static const defaultHeight = 32.0;
  static const defaultIconSize = 18.0;
  static const defaultCheckmarkWeight = 2.0;
  static const defaultCheckmarkSize = 18.0;
  static const defaultForegroundSpacing = 8.0;
  static const disabledBackgroundAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledBorderAlpha = 0x0c; // 38% * 12% = 5%
  static const disabledForegroundAlpha = 0x61; // 38%

  /// The Color to be apply to the checkmark.
  ///
  /// If null fallback to [avatarForegroundColor] or [foregroundColor]
  final Color? checkmarkColor;

  /// Stroke width of the checkmark.
  ///
  /// Defaults to [FlexiChipStyle.defaultCheckmarkWeight].
  final double checkmarkWeight;

  /// Defaults to [FlexiChipStyle.defaultCheckmarkSize].
  final double checkmarkSize;

  /// Defaults to [CheckmarkStyle.sharp].
  final CheckmarkStyle? checkmarkStyle;

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

  /// When [elevation] is non zero the color to use for the chip's shadow color.
  final Color? shadowColor;

  /// The chip's z-coordinate relative to the parent at which to place this physical object.
  ///
  /// The value is non-negative.
  final double elevation;

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

  /// How much space to place between chip's foreground widget in a run in the main axis.
  final double foregroundSpacing;

  /// Color to be used for the chip's background.
  final Color? backgroundColor;

  /// Opacity to be apply to [backgroundColor].
  final double backgroundOpacity;

  /// Color to be used for the chip's border.
  final Color? borderColor;

  /// Opacity to be apply to [borderColor].
  final double borderOpacity;

  /// The width of this side of the chip's border, in logical pixels.
  final double borderWidth;

  /// The radii for each corner of the chip's border.
  final BorderRadiusGeometry borderRadius;

  /// The style of this side of the chip's border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none].
  /// This skips painting the border, but the border still has a [weight].
  final BorderStyle borderStyle;

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
  final Size avatarSize;

  /// Color to be used for the icon's inside the chip.
  final Color? iconColor;

  /// Opacity to be apply to [iconColor].
  final double? iconOpacity;

  /// The size of the icon's inside the chip, in logical pixels.
  ///
  /// Defaults to [FlexiChipStyle.defaultIconSize].
  final double iconSize;

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
      checkmarkWeight: checkmarkWidth ?? this.checkmarkWeight,
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
      checkmarkWidth: other.checkmarkWeight,
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
  /// If used as a regular FlexiChipStyle,
  /// the FlexiChipStyle resolved in the default state will be used.
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
