import 'dart:collection';
import 'trigger/trigger.dart';

mixin TriggerMixin {
  List<Trigger> get triggers;

  bool shouldValidate() => triggers.any((element) => element.isEnabled);
  bool allTriggersDisabled() => triggers.every((element) => element.isDisabled);
}
