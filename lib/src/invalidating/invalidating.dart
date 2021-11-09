import '../common/form_trigger_disabled.dart';
import '../common/form_trigger_wrapper.dart';
import '../common/field_trigger_disabled.dart';
import '../common/field_trigger_wrapper.dart';

import 'invalidating_impl.dart';

class _FormDisabled<T> with FormTriggerDisabled<T> implements InvalidatingFormTrigger<T> {
  const _FormDisabled();
}

class _FieldDisabled<T> with FieldTriggerDisabled<T> implements InvalidatingFieldTrigger<T> {
  const _FieldDisabled();
}

class InvalidatingFormTrigger<T> extends FormTriggerWrapper<T> {
  InvalidatingFormTrigger([T? value]) : super(InvalidatingFormTriggerImpl(value));
  const factory InvalidatingFormTrigger.disabled() = _FormDisabled;
}

class InvalidatingFieldTrigger<T> extends FieldTriggerWrapper<T> {
  InvalidatingFieldTrigger([T? value]) : super(InvalidatingFormTriggerImpl(value));
  const factory InvalidatingFieldTrigger.disabled() = _FieldDisabled;
}
