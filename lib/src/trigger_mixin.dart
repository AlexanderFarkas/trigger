import 'trigger/trigger.dart';

mixin TriggerMixin {
  List<Trigger> get triggers;

  bool anyTriggerEnabled() => triggers.any((element) => element.isEnabled);
  bool allTriggersDisabled() => triggers.every((element) => element.isDisabled);
}
