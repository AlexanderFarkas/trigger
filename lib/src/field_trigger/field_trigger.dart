import '../../trigger.dart';
import '../common/field_trigger_disabled.dart';

class FieldTrigger<T> extends InvalidatingFieldTrigger<T> {
  FieldTrigger([T? value]) : super(value);
  const factory FieldTrigger.disabled() = _FieldDisabled;
}

class _FieldDisabled<T> with FieldTriggerDisabled<T> implements FieldTrigger<T> {
  const _FieldDisabled();
}
