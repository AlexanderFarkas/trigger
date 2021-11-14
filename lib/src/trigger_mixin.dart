import 'package:meta/meta.dart';
import 'trigger/trigger.dart';

mixin TriggerMixin {
  @protected
  List<Trigger> get triggers;

  bool shouldValidate() => triggers.any((element) => element.isEnabled);
}
