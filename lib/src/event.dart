import 'package:widget_event/widget_event.dart';

/// Interactive events that [FlexiChip] can take on
/// when receiving input from the user.
abstract class FlexiChipEvent extends WidgetEvent {
  const FlexiChipEvent(String value) : super(value);

  /// The state when this item has been selected.
  ///
  /// This applies to things that can be toggled (such as chips and checkboxes)
  /// and things that are selected from a set of options (such as tabs and radio buttons).
  static const selected = WidgetEvent.selected;

  /// The state when this widget is disabled and cannot be interacted with.
  ///
  /// Disabled widgets should not respond to hover, focus, press, or drag
  /// interactions.
  static const disabled = WidgetEvent.disabled;

  /// The state when the user drags their mouse cursor over the given widget.
  static const hovered = WidgetEvent.hovered;

  /// The state when the user navigates with the keyboard to a given widget.
  ///
  /// This can also sometimes be triggered when a widget is tapped. For example,
  /// when a [TextField] is tapped, it becomes [focused].
  static const focused = WidgetEvent.focused;

  /// The state when the user is actively pressing down on the given widget.
  static const pressed = WidgetEvent.pressed;

  /// Checker for whether events considers [FlexiChipEvent.selected] to be active.
  static bool isSelected(Set<WidgetEvent> events) {
    return events.contains(FlexiChipEvent.selected);
  }

  /// Checker for whether events considers [FlexiChipEvent.disabled] to be active.
  static bool isDisabled(Set<WidgetEvent> events) {
    return events.contains(FlexiChipEvent.disabled);
  }

  /// Checker for whether events considers [FlexiChipEvent.hovered] to be active.
  static bool isHovered(Set<WidgetEvent> events) {
    return events.contains(FlexiChipEvent.hovered);
  }

  /// Checker for whether events considers [FlexiChipEvent.focused] to be active.
  static bool isFocused(Set<WidgetEvent> events) {
    return events.contains(FlexiChipEvent.focused);
  }

  /// Checker for whether events considers [FlexiChipEvent.pressed] to be active.
  static bool isPressed(Set<WidgetEvent> events) {
    return events.contains(FlexiChipEvent.pressed);
  }
}

/// Manages a set of [FlexiChipEvent]s and notifies listeners of changes.
///
/// Used by widgets that expose their internal event
/// for the sake of extensions that add support for additional events.
///
/// The controller's value is its current set of events.
/// Listeners are notified whenever the value changes.
/// The value should only be changed with update;
/// it should not be modified directly.
class FlexiChipEventController extends WidgetEventController {}

/// Set of WidgetEvent
typedef FlexiChipEvents = Set<WidgetEvent>;
